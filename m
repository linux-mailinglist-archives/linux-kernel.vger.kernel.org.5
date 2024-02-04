Return-Path: <linux-kernel+bounces-51753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E51848EEE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59A2B20B7D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259D224FB;
	Sun,  4 Feb 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="HCkR48wm"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70C225CD;
	Sun,  4 Feb 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060679; cv=none; b=UvwiXmiAACABwEML3kpWz7imxWpI5kXyeozsOCcgjusBQMYI2QVHEIaoV4RUcQ9c/uaBDLtOxElZ0C+L6jlf2FQyF3pJm/8VLPqxAdtY7QC/zAzaSqXlzybAldn8VpdMKdpM7KjRKasQbCfB3sLCK7IRzbgi8ct37XghOewc4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060679; c=relaxed/simple;
	bh=S/ZIXKaYCzBvSHAb0bgIk6ZHFhlKGdCf+UMP2fmktpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o1DQn11nzqMq02zK13i2E+sbeXCBQaTMA1UpNRIK1+wRJadW02yaQQwcsWyHeDPEYR58D8gZeVuXgpg+ycuvviPttd8mCwJ7xLN9ZPIx3CONO+oz5U+glOeddUNKIxe0WkAZCRdd3XUG+1AmDDjyLxvP5pe/nBs5NvhnwrqmXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=HCkR48wm reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-290ec261a61so2058053a91.0;
        Sun, 04 Feb 2024 07:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707060677; x=1707665477;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o22UdR34yn0ACUyhPkPi4SkDUzpZs8sy4/iVZx/uUJQ=;
        b=neBvweghmYMQa7H1mFIjg5utoYDBAVjhSwwP+WCqsadfhFgQI/L4i+jSpDGTYzXFyj
         lhmh+lsiMQ6FAKOoRD9gbMRr5DGDr/AmW0qDlmHuRcY4JawLgLZO/xTosYVMgKkRBhpi
         Ye0YMV04ugnEPt/R+RiwN20T3i7+qi2aMabDDD7lkjRuvUNa7XGY/fZYQqGWyL9BPyMb
         T0pZL2jPGzsXe4bIgsPttQd/GhHtPr7hXCRvkW+2Om0xtSFA72kzWJY1IeP9veNxNh7o
         sO1dhQ+dmQ4pevzPq/Nkx8J6wywmUS1p8u405OPBGDTVe2uKWRiSh3HdXH8ZeEdOIUlb
         +tkA==
X-Gm-Message-State: AOJu0Yymsgfvd47wcyiMOZfAuMWMOfzqJvSgA/xyhHC4ySNs/yLUKTi+
	QVpv2zBDMgr9zeEgLEQQnlNC3T5QPdL3lv4dlUPuDcIfPZO7HxRE
X-Google-Smtp-Source: AGHT+IHSpzQVUU3HI2CWfeDuARDPDX/tZOTNAL4H2cyLVAjZRoIDVJVFWM49DOD9Uwj0u+S6KbPVPQ==
X-Received: by 2002:a17:90a:9a7:b0:296:68c4:9348 with SMTP id 36-20020a17090a09a700b0029668c49348mr1979636pjo.37.1707060677318;
        Sun, 04 Feb 2024 07:31:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1xMCtChTbJvqtDxJ9w2qTs/PRj3pku8bljQRLephaQdE2CHv1uk4mWtuCU6Jo+Lo3uA0fKaIsdD92DCAUnyzbxLjrc3OeTN5Cv7OJr+VqSvHLbw4n8RNH+uIKxCoPhiSSniRdbwfZ953oVH4g0eW/mfLW2ZzMwKadu3xkLrt9+LF5596h7ywQdN6SYkBbV8A/Af1DVPOqBAq0qz6KvTu22Pk9SRsj2tJoYySwv7QEgbhoUg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090a854100b002964ce7d420sm3227908pjw.42.2024.02.04.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:31:16 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707060674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o22UdR34yn0ACUyhPkPi4SkDUzpZs8sy4/iVZx/uUJQ=;
	b=HCkR48wmXBe53W/gbe3s16Ay0NBppkbWXV6bMu9zKSgZVt390RF7GIX0NCo/xvacyjE1bu
	5kzQg57FCAxSzpfO/SZY19veHJHzhaWo7+b0tu/PHmSnShVgnc6gRvSC8Dp41r2tnEpt+O
	w7ILGR7/0VxHuuwxWO7TWKOJ/W19zbj9OufIJPQ1OUYhYntnlKghndYAlHiRtj7vlGiYK/
	hHas5pLipvEWejZcj8VQ162xYzL445+XqAQkzZvjkFn2eSkmUciGtq9nmjMg+qC1Z/9NLb
	wMaTbDdB2pUoYoy0F90LbrGz+rmX3FjDFnCjwjVG7h0YVc4tQNKEITOBRUcA4w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 12:31:42 -0300
Subject: [PATCH] block: rbd: make rbd_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-block-v1-1-fc77afd8d7cc@marliere.net>
X-B4-Tracking: v=1; b=H4sIAN2tv2UC/x3MQQqAIBBA0avErBNMKrOrRITaWENhoRhBdPek5
 Vv8/0DEQBihLx4IeFGkw2dUZQF21X5BRnM2CC5qLnjNTIqT3VH7dDKzH3ZjSnWtcailkg3k7gz
 o6P6fw/i+H/HDShxjAAAA
To: Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>
Cc: ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=S/ZIXKaYCzBvSHAb0bgIk6ZHFhlKGdCf+UMP2fmktpc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv63fKH7qtQOL6Z1EP/0HwYmkgsBtA7OM8Hx4s
 LCyC4T6mPWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+t3wAKCRDJC4p8Y4ZY
 ppSuEACZkoFB2BqC6sK4RoRgd6I4hKOQt+aQjKjrDxe7iL7MT9J6jMU9Jc6JXh5DQGpnk7Kk+Vs
 BilMZT2Sukxr2PVNwl9RUA2+eM5IXmy0Xfi14BqOfiL/1kHrXdWQCEYAPmHxPB7zulNVXa+j4Gm
 kyC/kaqk7HIKDJlNIK4ksbtfPUe4afRx71lTBYyPubdUPhfIOG9JBqT0jBAhBuml/nigF8ydgCJ
 GHPKW94FVcCz7CeXJHDBgaO2flviEpv5aEvCblBmjid7n0strgSjmY+JDqf1Xn21pZRPxqy4IxE
 oiBy7EaHx1Nx114fvvhv+zvYuewZrnjyv++cg6ue7+x2qwsMs9nOwLFaxGeDymq1YiOArENtI6W
 Yle+V/7PXFrZuTggM6UUiMFDbUkdQNyyPuTyk5DRr5jFg6Ew8Ct2Iulj6JuUBQGFSkX/tadmdPq
 2OdbOV7PVzBEVjIF4OrPS/igatJ2wqctyfG3CENuxxF03qW5hunQdotJPx4qjzDajX1NbYHJ4vN
 TI9sujGRzmAnEEie+kLmwvt+disVc6qEkMZofGh/uK2UwuhUyETbxq1F1kBFIiXsoRzrvl7EtyK
 hAyzvONVxKBX1mpfr85n3CN+lj72fi2mOBeT1eWtyIsoOKW34zizr0isgg65yJBrPLU/9GDYnnI
 yBMJZ3KqhazSrHw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the rbd_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0202a4e5d6cf..21f2b9e9b9ff 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -575,7 +575,7 @@ static const struct attribute_group rbd_bus_group = {
 };
 __ATTRIBUTE_GROUPS(rbd_bus);
 
-static struct bus_type rbd_bus_type = {
+static const struct bus_type rbd_bus_type = {
 	.name		= "rbd",
 	.bus_groups	= rbd_bus_groups,
 };

---
base-commit: aa826a9b19b93bf8aabc462381ae436a60b2a320
change-id: 20240204-bus_cleanup-block-9986bfea7975

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


