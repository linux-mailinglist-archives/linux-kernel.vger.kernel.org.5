Return-Path: <linux-kernel+bounces-51779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 942F6848F34
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475971F22EC2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023423774;
	Sun,  4 Feb 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="O+Z2XWVv"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BE22F14
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063701; cv=none; b=SqJjzckSdMWx5FHmCfq+G5GSX906eF/47an5MLVAfOi2cwTZJ7W5oOjUYnlnYV5yjdjnNmw37MJR6GEw0PKZKRF7Aypp6f0bmZAxug8BNEU9B2+4J+Q9IH2fIO4fmfnkdOZh/GNf4KVl5da7AIQ4IZZXs3Au6O2Nta1xrfn5PxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063701; c=relaxed/simple;
	bh=o2JftdH1Lhh0GDvslzWGXgMsYHPICO40Ht1z1kVrKj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Spbq3NbdRz8NBlpLqUL67GZKeL7XDiO2Fe9aCkz5EurSpewivzkymxkTqPAuQCuWEsnL3Lrm/bjP3mxEUuE4PVSvm4WD5jiXbqiw1ch19FZ4YjmnurgLvz6sOCV4WMXetjluRPu1RUD61c/B7T+y7RxLIZrRR4nR8pseWy/q+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=O+Z2XWVv reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2330021a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 08:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063699; x=1707668499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjiJPQVvtwUyBqU7KJO38zWmQJXbmgfQDFzxeewrpks=;
        b=Q4J8Z4COKOix1vleKs8DR6BWdX65PV80O+rVKhzMuRay2kyFzrZ2WxpimUKDt3c8sB
         DjM+AiaVOofgerXH2z7lUD/CYbr+F2u1h91C+7sGJxzAi1SmjQVNLdPonhBhpzC3NQJ1
         IFMR2xeJn4LVzKlRc6LZCmxzVtxuaNM32ZHwCCHpW/v4mp/JxuYu7qB623Bi7UzCmk+c
         RiqU6I1hG4U4aHTLPR86UWN6db26qny2YiuZ16dJcFnh/vSEOboJPrBZqJwFXBY1k3ME
         4YAgTS9xUGT8P8maJ99Ok4MaZJCRcVFMxt7eTxFYGKmNgKSp72sN3Wcldz0umimCXTah
         6mSg==
X-Gm-Message-State: AOJu0Yx5C2CECRYhEqUEfU9f17/V/QyveWvNveg2WU0X/vz42UZmJvMh
	e7BoWl83kdbX9dGq87QzA0/hswy9hbFuU8xF4QIWCUy0JZyjnsCt
X-Google-Smtp-Source: AGHT+IF8je7qQu/s7vJVwCPZGn/23M5VeoaV3eOb9d1YPqK2zrOabeBIxhivh1P6Nrgc95i9dTRwTQ==
X-Received: by 2002:a05:6a00:2b58:b0:6e0:3329:1044 with SMTP id du24-20020a056a002b5800b006e033291044mr1675780pfb.29.1707063699536;
        Sun, 04 Feb 2024 08:21:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUrR1KL5euiahwckJ9aaO9NAK2Z6RDRB7p1VBjX73QYAQuzLb4OEoHaNudmXQ7qO8bV2/O16epE6JYi0bSUCd+hMUAyZ5+pROfdp1p+Qmu4vwfocCgVpQJApXbIQ3n6jjpHR4JWnFxWnf+0QHBxB5H6vbg27cFsay39S3ZX0VnoedM7B6rJXkGFxmdVQwXOYc5e
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b006ddd112c7c9sm5140654pfo.145.2024.02.04.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:21:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707063697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjiJPQVvtwUyBqU7KJO38zWmQJXbmgfQDFzxeewrpks=;
	b=O+Z2XWVvP0UMKrW1QPxP07yofSO2OaCGbAltbXl9QrHxKQiTW4R3a46MLao8mVppQFSQlY
	SoSOPJsMX/Nj7FTZcq9pdZ/VIvZvEVVS+PzwL6W+Iw4bf0BNlXNic4FQN1V7MbbgRnocp8
	M8pdz0FeK1xgwxVSLwa1ek7QZXA0PY4DFP3It8xi5i8VgXJprQz+TwT2dak8WexMN005lC
	r07kNwpgzWxY7q44Bgw+quTsxTdflVyuiJwnFtJmrGbonZwpPEQ6Xs/NWBs6iwSCco5H4o
	qHGQE+QlUnxX89+pqiXVd5klgqTHNbHzpuqfcR6u8d7eFVq2Yq5WhzLmKPSMmw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:22:00 -0300
Subject: [PATCH 1/2] ntb: ntb_transport: make ntb_transport_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-ntb-v1-1-155184f60d5f@marliere.net>
References: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
In-Reply-To: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=o2JftdH1Lhh0GDvslzWGXgMsYHPICO40Ht1z1kVrKj0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7mrsYfIx/tjByMzOoLAMVwhjhFxyD3oTBQsx
 9ozryIlcb+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+5qwAKCRDJC4p8Y4ZY
 ptUUD/41Qi5N2w1Zlibh7z3PcppcnEYkxeEtme7bJ6LuGKcenNm3iPaZSn6RTbHLtiOa+L0PZEw
 0XIQERCz0BHrUUi4Uk8D1ZN/Zxp571wZVKxO+ecTvI2VEN6fQF8+IavxwfQ0DVu2oSKnR21amY1
 jk1KhtopQFV7+uGEpTZMqSP97drkrRt7niDw+Djt4ub87qA3tn6/0pomPqO9SD3+Q0T2L1Jbqma
 C+VikRZwu2QDV//aOC9eDryjNPVtohb+jdw9Tp6SMiukWF+ZxfYjgTxhv1e23XaUBGe87qaFH9i
 bDZ31lB82p/52hBPyN3UPAMhjufcX86xY+9UriEIt4YoMcuK1yyjsTSYAgCmM/yJ79ZXZYm5ybl
 LsGvERxf7mjEaO/UgfhDh5qIzsrzbQT+Q60zD/KkoPgG2b16ZsaDrY0SjZaKtkK+tI/zomZxo4U
 m0yDhgPpf7OZQSkMQJ2Kb2BL2t9ujImoIHr5S4nEmj8l35Wp2r4J3qU6bQ6pW67ROPhglAiMdgN
 WV7rjiy9ciTHIb6MHeh4NqJ3eUJGrcL80gi6YN8qpkAYmx4bE1j4StlapxxwsSUzgLCS4fRwSrm
 QdNzwp0I+dwmpgPGMt7L7ZHTsIxR7IzRDvP08ljLE4w6Ykvl8j9BGGZVJbJZwuq+qI77UKbjUTK
 1Nh9ackxPgNawgw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ntb_transport_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9e7847a378e..0291d80611dc 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -314,7 +314,7 @@ static void ntb_transport_bus_remove(struct device *dev)
 	put_device(dev);
 }
 
-static struct bus_type ntb_transport_bus = {
+static const struct bus_type ntb_transport_bus = {
 	.name = "ntb_transport",
 	.match = ntb_transport_bus_match,
 	.probe = ntb_transport_bus_probe,

-- 
2.43.0


