Return-Path: <linux-kernel+bounces-60851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF926850A25
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7071F22DAF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5855CDC9;
	Sun, 11 Feb 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="JwaG85w2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146E5C616
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666663; cv=none; b=M5mV99mhRkzACIDjkX+kTcIDacSPYCOgMA5v+cJ7m8npbLvohiEOYyNheDh/llmGhQ5RtpGcJ2GQfI2bN99TVDDdCskLQtTNkHmwFny8/7dHAkfpQLxUspDkpVa5hNxdSVjLnropRWsWM1ssiFQ045HPjygkinZw1EcnnbdQIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666663; c=relaxed/simple;
	bh=2DXxJu+KPQUi1akz0xAbwCY6WPF6YuYAvQw6ywMU71k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSqZPSj/E/BNcBy9DfkFj188tPuI+y6A23j/Rn5+yzayq2EFWEJHgbyru/10rBiCIVYm3yVTwaGempS+IbAp370e+AUAjRz9TYhxry80XpOIPAfIDhkimWVhebquWNYKTNR3Od2mEl0+Ku7L74XJcOhQpPjTnd9/Od51jB7tAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=JwaG85w2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d746856d85so18526915ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666661; x=1708271461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4Gcc4Xndyg3QpASX0JMqOkflhcAzBHLuuTQVBUmj7Q=;
        b=MxQ/QHKqxgqySKiO/ds8iOiChI2uaZPniMj6EN7mkVcAFHzgQ3f2FFS0021MdUrmgB
         TTg6n4OIyNVOOTXkB+1MNAG06mA9N0eiq0J4qyzD95qKD4eQxR4h09JXZYclmkSnxB1t
         85eCMFHKYbAOI+zDD5FARy35qxpmX2c7hc8j2FG0dXl3HzB01jk3NHeAWS1dzbVFCFvE
         xDKm8TBOMbyZ1+2dIWEihKmi13aWt23DfwOLEC2zvDj3KxqCgevaAnEE9HeL7D2Vn9Dz
         3Mh3H6PSecjMsJtgT4gNYVd4Mt0bWDA+D+ja2w/d7PPf5TTkoMXh8LOf0gAJgyZumM79
         1moA==
X-Forwarded-Encrypted: i=1; AJvYcCVfiXr3AFKtBSJRhJZfgcRli6RzeSt2vXDULqhUkLTF/NEq5lA17vrbV+7ZpGroO6rdZybMbw4os656B8gDsSi5+eKL8CnvzyrL8nXI
X-Gm-Message-State: AOJu0Yxit+2bl+Oy/rpR25VyqMa2ErsU4LpdOvGxWrZZWVA581z6Vxmv
	9x8bRN6crI9OS1I2/tiQuWa3LAhywCroEKvRz2Szq9LU72hqzI+GluPK8eHHnAmhRQ==
X-Google-Smtp-Source: AGHT+IEI9lq5dA34AHVeb+iMvot4hcH028ChbaSpEGEcOLvfUGDPB6GCO3nb5D9yA+LKpZmHPWjYvg==
X-Received: by 2002:a17:902:f68e:b0:1d9:859f:b505 with SMTP id l14-20020a170902f68e00b001d9859fb505mr4436425plg.21.1707666661324;
        Sun, 11 Feb 2024 07:51:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv1bTfqA5q8d4YOoEhJXKCFE/XCtNFUDccZIs6B+JlL8NgGMXSedkp/N36JzOI/IvTi1kYy0OpSqphpHpcHdsAgoLaz2jY7NAu1Lo7A9Ysl5Dd6uPtgjOTgyi3slv81xhtb5Ug1xtnm3J4ET2UlwOqgIu72B6Cprb3kKv3IhshdQ0j
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001d9630e3396sm4457627pld.193.2024.02.11.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:51:00 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4Gcc4Xndyg3QpASX0JMqOkflhcAzBHLuuTQVBUmj7Q=;
	b=JwaG85w2MwtkXsefAeGkqQVomcKeKVGed2aK+7hzc7QWU8PQtj/Pmp3V17wFLZxt8o9bZr
	erqils/vfcN6kbUTxjdr12CpiZHFO3HNo5Xq2mhW3tcL2wi9KeauwhPD0RKDGJQzErzboA
	Iq6UHEq5JrNAXaB0e4oqrsq2m5G0aH0NDQsbypzA0liTl5JMY4jXYExZMHj1kYPaDtTeO2
	en9znPsj4CTOZBZW2IofsyGwyxP+H+Cf4zCGJ8VM7+W+XXd5MlxstVhxDrYPUcu3AHjUqK
	ieWtdrdNwbNbHou5HMQJu2vhJ1j/wDTl95z5m3Fi743Ts/pQCzTVD+SsONsL4g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:51:30 -0300
Subject: [PATCH 2/2] firmware: arm_scmi: make scmi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-firmware2-v1-2-1851c92c7be7@marliere.net>
References: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
In-Reply-To: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=2DXxJu+KPQUi1akz0xAbwCY6WPF6YuYAvQw6ywMU71k=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyO0CNpjVnQm1f4mTaBU/yng6HbD1pirl70Kw+
 1tn3hP+mbaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjtAgAKCRDJC4p8Y4ZY
 ppioD/93LqVA4qwg6m2/98RBhSmHxrXXzvXmKkMdJHAOgvt1uTubajTkqHdxRXNBCwOuaSkvHNY
 hHsmHSAwVz0NRbUc0tabRMFntHZrd3hqD3iV6NtbivHn8NqS98Mh6FKBqSbr6XXMzU2fRu3Q1j8
 P/DL9d1xN6e7ejbei+8q8NkOfOrIV2Yq+7J47IjEEUNPPs7Z766RdWH8KO0nHe8O3zY6zUKpeqM
 4qGXOw71sCQX9AAixnu2MWirQSf0873ddN8Msq+o+WzecXanCwGBvvR/cFDQqxVqL87L2ndwwUk
 R1DtDVa6dlS6raZvquBUMt3wObX+hP+UiKLrCgIj8CxcLxCmcZ6Sd06jhfCQP21uwQhOqgL9yk4
 VezjtVrSeSX3q+qHQp89Bk0lvKkjC6lkE9qVnRELEzKvkD73raS0OL4KqvklL7i7hyZOkYdzeev
 jAdP5h54FnRcUTnfwnBJczyzomhBI8Sb+R3xzzjnAUsN8w4p1R+k7jRDopGe+AED9VMH3YljP1V
 cFpARItZ8mA5Jlt8wGNjofRoSthRSCpxdpHpn50qq1Qre1FFln8xvFZ/fAHm/3mWfrk6yn+HY+S
 wD083Syz/MbXHKFZRyo7huiKrPaQRFvxEooWvV7PYJ2f6h5j0RheVwl5tTSREV28+ChuBEgfNiS
 JHijGvapEGABAHw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the scmi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/firmware/arm_scmi/bus.c    | 2 +-
 drivers/firmware/arm_scmi/common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index c15928b8c5cc..609a6496c1d4 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -263,7 +263,7 @@ static void scmi_dev_remove(struct device *dev)
 		scmi_drv->remove(scmi_dev);
 }
 
-struct bus_type scmi_bus_type = {
+const struct bus_type scmi_bus_type = {
 	.name =	"scmi_protocol",
 	.match = scmi_dev_match,
 	.probe = scmi_dev_probe,
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 00b165d1f502..6affbfdd1dec 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -141,7 +141,7 @@ scmi_revision_area_get(const struct scmi_protocol_handle *ph);
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp);
 
-extern struct bus_type scmi_bus_type;
+extern const struct bus_type scmi_bus_type;
 
 #define SCMI_BUS_NOTIFY_DEVICE_REQUEST		0
 #define SCMI_BUS_NOTIFY_DEVICE_UNREQUEST	1

-- 
2.43.0


