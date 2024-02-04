Return-Path: <linux-kernel+bounces-51883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0436B849061
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C901F22209
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64733CC9;
	Sun,  4 Feb 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="BS4Mt9V4"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE03399C;
	Sun,  4 Feb 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078699; cv=none; b=bPKHX/vR0ZvJ+ZsFTp1uIaGmr9/438nZFG7TZ4t2ZK2tRWy/AX5/d10tjPxUaho5i7DAQU9T7DtxsjaEbkxR26u3QlyNPsX13cEKS/vYRkL0SlVBziFbrGWfEc751nyvBFRb7qyb0iNHT0EkmS9P+d/uGC0rOWFGVUh6zCiaVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078699; c=relaxed/simple;
	bh=VRoTYpwLZnzgBXaKD3r0QAPslmakchudfuNhoaBd8ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c/Sh/NnFsS3y8uPzuf5JCQFqvCqR135mC8Pmo5XyYgYS4uB3Era5DZHnWMQr4OOOxMw2tY1xKle0+8lHH8iViNQFQtba0Xy2vcoQamPQhscaEqFT4z7Yne70OSltCeb1/EE94N1FUVlH8yr/CMzIXDe9Z94CWFG4fL0722DgfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=BS4Mt9V4 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d934c8f8f7so30750415ad.2;
        Sun, 04 Feb 2024 12:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707078697; x=1707683497;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WCglIy8ayd+eS45f/mgaJU4SOqdCX8ta1jEh6jlM9Y=;
        b=mYPQd3uvWf9fqJQ2KST4bmmOiUm6gK8om5/Y5/x3Pqh6aFEEBpt1w+JGIex04fqFBY
         kfDe9DOLplPZ/p9OWTxPe9W5eQNORyRTDzhuNbu8Li8isy3NlG3XQ06PqcdkBvwvYxg4
         ltUYmfEkLxUAsPSN5GqUJKszDEg01HH1MTXCoEY6ar4Yn+jewOJtaHbfp9+7CHsdvXhk
         HY3OLcDYHRX/1T+fbJoWC3K3EF2W+aRkHg0DahlEAR1NGBL4NvY/SaH4mblffLT/Hi5I
         n7Y4/c7qrZeG6YERZQ2id0GNAe8X44EbLZlsdJ/WCgyjqGA44Zj9u9WQxjBqgJFQr+tR
         SvWg==
X-Gm-Message-State: AOJu0YynuyzIxYoZfSSPOSNhHbXGClYWxdG6irOZeXy5LMPkuf5V48nO
	nlwAzb5YX0s0yPxjjeebEhwaOFlEQqTxW7MPLjw/Hkr9ybCQbLe41mnIuEsMeCLFiw==
X-Google-Smtp-Source: AGHT+IGOFMWqyEF2S7mE9GgPQ7KY0tlqaOJKnouwCEmMsXR9wqiWr6mw+Q35LGczyogzhM7E/2hlCw==
X-Received: by 2002:a17:902:dac6:b0:1d9:e40:39cd with SMTP id q6-20020a170902dac600b001d90e4039cdmr13871383plx.2.1707078697585;
        Sun, 04 Feb 2024 12:31:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW0dKuM9rWCldH2/Aco3eurHVoZKC0HdeNmTY2y//6cwop/ppm/eYlLWoeQhNAR1wjd0VxX9LoL0nxidUzwHatgCLJYNZZKCzUuV943NpL4YNmX6obyFyc3Y4FCd3VnHA5gHZDyVhLQWrjqX9vn5eXmIyZxYelYmuVqKb8QJ15fIlpuT+Y=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d0c900b001d8f82c61cdsm1032035pln.231.2024.02.04.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:31:36 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707078695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7WCglIy8ayd+eS45f/mgaJU4SOqdCX8ta1jEh6jlM9Y=;
	b=BS4Mt9V4Ksjo1frOWqBlPnGuxLId5k35qCM6Fc78hGs4Svi751DEj/NJnBtqmd7yeAhKuV
	aT1sREZG4hbdkcLZ4tHAhJzaq7/CT6pwEdNfezaa3cgxZu7Ff5QhG5CfNPWH0DGNkq+FdL
	wT7aC74DryhOOFW55Rdk6/xYhLmHm1v5kV24vi+DWM4o5s3VrHsXNS+5+VHOA9irNrrq8C
	TYwnZkh+VbKFTe1iKMe4hkug77JeKDcvyd0lr5Hc6P37ABC3DedbeA4BinAASGYyPGySR8
	b2lt0lOQ3YmwhiYsI2rFcSbPIsSsh5Kwmy43lnZ/3D8JamHEU2gRvbCU9RSfRA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:32:05 -0300
Subject: [PATCH] rpmsg: core: make rpmsg_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-rpmsg-v1-1-1703508c23b7@marliere.net>
X-B4-Tracking: v=1; b=H4sIAET0v2UC/x3MQQqAIBBA0avErBNMTKirRMRUkw2UiUMRRHdPW
 r7F/w8IJSaBtngg0cXCR8ioygKmFYMnxXM2GG2sNtqq8ZRh2gjDGVWKu3hVYb04HF2DxkLuYqK
 F7//Z9e/7AQYAhfZjAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=VRoTYpwLZnzgBXaKD3r0QAPslmakchudfuNhoaBd8ag=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/RFYNEW1n3ot2vWTihcOBpkI5Fk3rVxR9ybp
 xagfA5klj6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/0RQAKCRDJC4p8Y4ZY
 plBkD/sHLuhFv5Dazsz1xPzZr48dawO4hgXKd2Gu4AfZ8OXua/802YDCEzvZViJ8AJBT1mEov5T
 YjoYGlf9Hkzy7KaAo8yMMJ68+hH8J/7itQlzhHAZQYVxSnAEu/k1kDXWbSBl9Xvxprpe/Vk3O6a
 b1NvHqMuTE1h6op7e9zdNh8bBsHtZszL6rbeje9x8TkkwgKenGdvwN6dRbr6izi4yzFU7Q/uVGd
 Y+awDg7F+mDzYkRCUwkyj8ZcSKXOZt59Y7PAoT3AXaEqg9tX+iBaDgkcumqmmoIF/5cKlpom3li
 Miku8isq24GTgkyWAcD9pt9vyS4XM1FvI3ZjYNQDXROubzkuhfkPA/3kbR0GjyqDrH6mxEsqv7q
 r4qg2Rct9xCdB+gudlBHCM9+g/vaFyptZnP7BHetAtf8Tf+WpEYTzLXjcjoMfc20jzQUfyRFsG9
 hsaor9MXE5uOqyLciDyIeVnAPdHQFgAH0lv9QC39nqIsx9RpjJoJ+QnRuX3Zt9mHPRtZbsSFqA4
 8sIe+lJGa1A+5EF77a+OwnC1KdIV/Spk7qgHof4AmaUyMQbuVnEEwOXyK1VmED+u8uJdaVWsnzI
 gUWtn+eWz1nrX8xdeU2+BvXqoH5OBPG8oNeHcVOSzrBpPKT8Y+Zb/vpXxhJlACC+ypkuF0GqDGO
 srSs/312swjlLSg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the rpmsg_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/rpmsg/rpmsg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 8abc7d022ff7..4295c01a2861 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -605,7 +605,7 @@ static void rpmsg_dev_remove(struct device *dev)
 		rpmsg_destroy_ept(rpdev->ept);
 }
 
-static struct bus_type rpmsg_bus = {
+static const struct bus_type rpmsg_bus = {
 	.name		= "rpmsg",
 	.match		= rpmsg_dev_match,
 	.dev_groups	= rpmsg_dev_groups,

---
base-commit: 80255b24efbe83a6a01600484b6959259a30ded5
change-id: 20240204-bus_cleanup-rpmsg-1a5f6ab69a24

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


