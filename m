Return-Path: <linux-kernel+bounces-51129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099E68486E0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D221F23464
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E9B5EE9C;
	Sat,  3 Feb 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="AdAOTaOQ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080F5EE91;
	Sat,  3 Feb 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972268; cv=none; b=mCocpUGb7AsRWMy7TXN2I0MWn1dVMbOQEHlQAvPdk0+K0MayGjo322wbzHGHGf9xFBOC5Mtr6PYKG6om1JPWf/pcP38DlOVbNK3yC6mWiFIIWn05tQAL79kAu9Umu0pkJbth2CtUVFP3WXInkqlYfVhrI8UjdKNddI9ffG/UKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972268; c=relaxed/simple;
	bh=JL4nOZ57/NU8eLT7e2PNLAaEMoD5QGMoIz35/Kel4Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5BUKTpbb3dDpHYfYzgaQvSJ9Y8/qaUMZxRxsJtQKuHmPu1qbpT+hdrm5qC+Dme+YToi7v6sDQojMORMqrVZSzeW9++y2brTAEucnGFjrGBDpJvLPnkn20EtrkwvDmumW7wCwq+CkZ2Lv3/XIcESP+OF7wzE4GDMbcCRusejB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=AdAOTaOQ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dc11fdddd6so46254a12.1;
        Sat, 03 Feb 2024 06:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972265; x=1707577065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDTqKC9fCb9FawpzFfnVp+z6Vq35bRpsuqTV29F0WVU=;
        b=EjF8pghCpxs9PPh3Gt4Vkc0qxwfKNz0A4VaKBenFGJf+yjvfTeRfVYhlpWbWQNrENy
         70Z8MsNz+uG9mBSfsY035ymFxdJqnhHkVwDwOp6tnaMxiVX0f8xn56c0REVwZNQSe6jZ
         sYoUBJJeLsl3Vx1I0ywEGsdbkA3lMv7iYbjvZ9sUgoqmLSA5NSTH9+8aMikQgtjF9RL/
         Ahi7Q/+8tYHteT9sfppQWyXEvYGhYUFPjPu2cQyvRmgDYfx+uji5YCDEx25vKibvfQDJ
         C26n1sbwiILFSz5Kl1I0cKzP3LSyLggOOWYBsjZYSrLtkSErxJO3Um6LrWTLrPf8SnRH
         nDlQ==
X-Gm-Message-State: AOJu0YyTSnc+n25+RwD+eWcUKYfLXojqsV5ZXo4GY+y8eOchzHegArv1
	s9SPB1hUW8eJex67xb3AuxboAuN+pGD4pcd9JtFkMkTOMNVG6ZHGCttIqpSdJS70Eg==
X-Google-Smtp-Source: AGHT+IH9lLkfRr+nbZ5zdzPNi4R9ASln6Den8GChn8JNiK++cCzON2nBqEOzlm97wev1Fdeg44GeoA==
X-Received: by 2002:a05:6a20:6f8b:b0:19c:99f1:bd5 with SMTP id gv11-20020a056a206f8b00b0019c99f10bd5mr9852995pzb.11.1706972265591;
        Sat, 03 Feb 2024 06:57:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXPT2GpJ3aTruQUHfakASBgmXdcqkJqUkxLjJE0uV7HsW6l5Bt05pk4f48BNBpwGTcQS/8cQ9mP8SglFFBcq8xSYh6d4PE9yPzx+gkLXCYU7T9+uRxbv7GCqgN2mWNgxR/CqAutVjuPkklJA7erJKG4rgZ6Xgl8zQZgkQwL5mvPKGJW+VyNJjWvTGfX8EGTIun9xYZp7PkBl5FuZdq9w4j5LZ1ZIelBCwAHrlaciF/WC4AcQWSbnP7zQCPv3Fkd/bVwiEOeHC7c680cEHz/7HGToaP8GcbF4buLn8xgImj9eL8hg0jHW0JQe40N8u6y1i1NgQwRSepOcFrgdY4t6objRcvcUaW6tO2I4RX9UZqccGzJK/td1flHSDqQnfskOLFsDCYzFBaLUtzFpZ7E3IY35rNReGqIXQ0COXDc+O0msC1EinZpcw=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id t13-20020a63224d000000b005db76738ae2sm3682060pgm.58.2024.02.03.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:57:45 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706972264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDTqKC9fCb9FawpzFfnVp+z6Vq35bRpsuqTV29F0WVU=;
	b=AdAOTaOQ/VUTEABaEK+GbMf1oKUhALAK5R67sliLowPu335d6vRfoKZzGV0hp4IZFsTu2C
	/SE8k6Azh8vHrMjuNAaGRimIH0wPLLLfXq+6NtN73QDhpOsqOLN9u+G9SLFUjz4CgkSfPu
	5XUjNC8q0GYOQGPUrcKyd04BspeOV4m9U9LRHwD09Ox3/xik4x1Ve+0ZrstXHdbAl3BSnY
	MmG+pBKMfoGB0HPNAIedFVJwEuP4sPC2IsOeVmbbaFzP/w+t4xWR0gTzD5wJwzHnkyzaKT
	vs5uVZ4xv5T8KljBG/xVMu2KbeZiHED0je3l7jy+3irYyoJMxVwXAI0f+ekURQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 11:57:58 -0300
Subject: [PATCH 1/6] s390: ccwgroup: make ccwgroup_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-s390-v1-1-ac891afc7282@marliere.net>
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
In-Reply-To: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
To: Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=JL4nOZ57/NU8eLT7e2PNLAaEMoD5QGMoIz35/Kel4Cs=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlSALUZj1dUJ/U7DlzBSnic0Byl1/v0CeSSLt
 2TtkwrKU5+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5UgAAKCRDJC4p8Y4ZY
 pvPTD/9jAn4l+iEjJU7+E9FTRXREGxex5MvlnsPkK4VddF4VppbICbqEpIBzoz8Ui0YkDb9CkOp
 IIycLcih95t52XwtYSVVWstdO3MxY+yT79o8jB2yaH2JVB/UAm2XADYLlOJ+G6YLFvBTqjqGi05
 o/pPwd8F5Ycfc+ZfE44F/X9pqY5tJUoSjo9h49G0tJsaVYswsd6q2LCoNLroqrUR8OxICC+ULMG
 rLI774LglxTvOywaJjGQ8sjBnFqitbzXb8KXQwKe7D/qBpRvt2myiBU1MDmzIw1o6Vtg1AmoUV9
 Zv24KRFNwymrcYv4/W85bKx+7uZxYSLoROJK5NnPhMh6lFXoG2wg/Mf9wWvdv95sB8Yk7pk3ASF
 gP5J7xL6FiF54GEdE+Kz70sLwuKKK2mhZDBxL0aEkPB1qUjjpBt9gQwSF1zMf+0aj63soFN5Br0
 8I5q1T5WrzdY0QtIXH9S+CyTyMqZXxA+NrKUVB3QS9uOlNN9spHqHYoYIzbAhFqhMxqYRgyZhl+
 MKp85VfG3OkvJX2KvtB203SGwnzm1hISzgdstY2WVQLifL2Z0z5MDETMXCnlY5T31dI2fapCoGI
 +4rSHZ+f/QlgnhZZM5XsmVnYsju8f06zVe9xaYszH1QbD53d+NNfX+Mo65O05TIs87a6FCkLtfh
 IOTP+8MYsvy23Xg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ccwgroup_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/cio/ccwgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index aa3292e57e38..6eb8bcd948dc 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -31,7 +31,7 @@
  * to devices that use multiple subchannels.
  */
 
-static struct bus_type ccwgroup_bus_type;
+static const struct bus_type ccwgroup_bus_type;
 
 static void __ccwgroup_remove_symlinks(struct ccwgroup_device *gdev)
 {
@@ -465,7 +465,7 @@ static void ccwgroup_shutdown(struct device *dev)
 		gdrv->shutdown(gdev);
 }
 
-static struct bus_type ccwgroup_bus_type = {
+static const struct bus_type ccwgroup_bus_type = {
 	.name   = "ccwgroup",
 	.dev_groups = ccwgroup_dev_groups,
 	.remove = ccwgroup_remove,

-- 
2.43.0


