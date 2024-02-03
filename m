Return-Path: <linux-kernel+bounces-51131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478CF8486E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9844DB26DE3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF565F84C;
	Sat,  3 Feb 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="mMXdHiiD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5985F579;
	Sat,  3 Feb 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972274; cv=none; b=arDMDQw1mtJalQFEfABYM94883wz/xqIepjsmHV4J4l8XPyA/OJv3X5ivAhzOCGwWl/fgQK9L+Xp780Tb0zYZcgkBBJ9qnFCzMLolh2LYrBuc1g77cil6hl7P/W3R+88IV4ZnTdaW4u9M3FXd4vco6pWZe53nB53SIrfjuMrW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972274; c=relaxed/simple;
	bh=LQZJcq94nKe7BZYvOY/G3jm6pit7GvkEgv2oDWVhxPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6brB1/p4HcECdm1eLFsF01gfez9pHWCSjcD/OvAV3iTUjNMSs0aDnRIXaVhdxJnPl7V5pqL0lFGmDMnqlqVjeZZjqp+BZ8Y935Fo0Ifd2mAH3xlCwLIehV4v+SrTn7qRpfpC3UGcMuu5ecz0kefR7z7gxwnF0s0OETfjfEE4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=mMXdHiiD reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso675565ad.1;
        Sat, 03 Feb 2024 06:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972272; x=1707577072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHwOQPu6JJEjp0Uca7hntqTrI+9sFUxfoRsBBVe4/68=;
        b=Ilb7EMp009s6iXeMMgYAAb9pAqMq2zBY7BjgAlF15G5VfQUc3VYekHuETt8G+emr3A
         ho6EKJg87D6ZuJgoheaCQMhubYLU464HRubW5ehfhHtMgw0zx3LV8L/fI2wBKxiR41z/
         8HjqeuqbDR44uyLzjPWlX23QcJ9ltG4e4vP6UCT5gtbHiQIE7UjC+QySCfD0l8L63O81
         N7DZttBffmRHuZdYrifjzWMnLAS+iHn2quDAnkPrsyj+3KePdITw1crJytn8b0mdUvfj
         TlvgHGWW35aVzQ8H8jKkb5HQeaOtXfsuHhDiJa1/kwlsACoJSTWjbILhND2IZrvm73cb
         YUTA==
X-Gm-Message-State: AOJu0Yz9OFmoWbdFOlObws6oUcdqsQH5loIzQoh8e9qAXlNIGH59KrQN
	icMRLr/r24XBN7kgjnJLR18K1/dUHpFAWEGHAk2wnvUrWzAzfMEX
X-Google-Smtp-Source: AGHT+IGswFO+4q4XCCgyDaf9pDv7MoC67N2i//oBPc3skOy0F6rKiZS/ZtjwObp36l+Try5cSuhG2Q==
X-Received: by 2002:a05:6a21:2d8e:b0:19e:5683:e8cf with SMTP id ty14-20020a056a212d8e00b0019e5683e8cfmr2692938pzb.0.1706972272099;
        Sat, 03 Feb 2024 06:57:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXYMntrFtBfSGoqWq0HDYQLDqodEJ3cRooAdYU5n+BR4smxkT0aRTMec59ZkJhQbwgyIxNb7uTcl1KMCTVAkZeJAC3FNZt3toPF0IOi1ALSs6FIklY4LgqO55bEmu2XzQNMbxKkg3SazH4j2GAhNrc+WBncmV2jMQo5krk8+ZMF2A6Z5/MLwKRr6RxXCLr8uDLW36YwUcjaEsSrGvAVx0VUGYK7MfvslAK36Y1cffa+ZLaZDu7TRc+tPDik3R38GHOME/ACiZZK1AlYD+WsUdkeylZqlTjlBLEHzcLsu8Qh2o+OFnGLnU43U8675oNXJAjJgb2xZkurNm1LiWV6Ye+mHBPpy8DKRfBqTc+ai/W06U0w5bGR51WgJ3FGjYXGjCF8tPZJy6EK4MW9isHx4Ssyt8NKs7TqOvdHcFmYM3IgTL2RyAVrAw=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fb36-20020a056a002da400b006de39de76adsm3473990pfb.139.2024.02.03.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:57:51 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706972270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHwOQPu6JJEjp0Uca7hntqTrI+9sFUxfoRsBBVe4/68=;
	b=mMXdHiiD5VKldXCDzE0USYiR1c9OLBLHvUfZ0FBiGbIOa4Tx/K9hEuQD6D4BLYxFCKPq+S
	azrXOkeYG9ae8gbWuAivhCWrdPS58tNFpSFG4PgUK0YEzRR/+1pDaCeMPuBu9u+CjSj8nI
	tw0APPk9vCyPzYhLI/vsUUyJvHX5oTKo/Ria2xClXI4/F78Pu28ZrYOM9AMzhvba/pBgvZ
	/neQ2yGM0AtYlVrErQmyH8OTa1Imno+JIPYty5NCFiBie8+9dusgFfRdxihN6BvgZn1ulq
	5u7S0buxXBxwo7wzW1OUBzybTnpOnG1kMYZNSyE0B7pjMNtNVOfeQEz8jS+rrg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 11:58:00 -0300
Subject: [PATCH 3/6] s390: cio: make ccw_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-s390-v1-3-ac891afc7282@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=LQZJcq94nKe7BZYvOY/G3jm6pit7GvkEgv2oDWVhxPA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlSAHO1rmsQ7DHqMlfo3AMrefF6YBApTOTqJV
 CB+MDAoAl+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5UgAAKCRDJC4p8Y4ZY
 ppJKD/0WtL0b42u4C+p1k9jAut9XcJKJIEshxtaG3qzA/3fku8+f2dZtbEmGuec8nPwKNYg/bez
 YAKRFY9LOAmQp0kkvoTwJ8W1I1a91+CSbcXUDZXF3QA3BEi/Me5le4ADZaYOG+HRm868AguoP71
 xIKTAKgx+MCp1ixrniVzMWvp78EXRvjeLSKbvlHdi53ZYRuR8BLDslX3ERnmtjUgCGBt0dDLvND
 woBJPZczQLB7fD41tK29dlfIrCwUVEIMeo2ZqxM2YJ/j8E/7i15Vq9hhLaLAT1L8kmRfZV30ocY
 +I2KKi0+2MtUYs8nt6PUrm52PeYaIrzpFLoB9lmJRP5GB3QfRYmoeMUGupg1nlWsHTtOKiLU9cr
 R6L9GBzd1eJP1eJu5vcOy75u1I7mmjweIbWpEnHZWFQ+0U4OjQxyT0cBFGidGI6AGrqXHH4MSz/
 P1bx8sWDJnoICFokcoKpBRXo5+KcHI+tEUzVkYxVF0zmxM7fbY3QVcIaB8Zo33j9EvOrT94vwyJ
 w1WsEuwhvsWTp/xYQtJ497gRWQYPmZI3ddmOJCs4ErBlgYkZlah9Ng24VTsYi/wLSj+nGi81RPm
 xXIQ+8dlHAG/p0wTv6PFbQRLA7smuLvos+MvyLVhLwsIMpjpPd1q3EiEIQrmDma7beZvHr76fhi
 /aZB0lfiRXd4WsQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ccw_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/cio/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 0cfb179e1bcb..f95d12345d98 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -49,7 +49,7 @@ static const unsigned long recovery_delay[] = { 3, 30, 300 };
 
 static atomic_t ccw_device_init_count = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(ccw_device_init_wq);
-static struct bus_type ccw_bus_type;
+static const struct bus_type ccw_bus_type;
 
 /******************* bus type handling ***********************/
 
@@ -1776,7 +1776,7 @@ static void ccw_device_shutdown(struct device *dev)
 	__disable_cmf(cdev);
 }
 
-static struct bus_type ccw_bus_type = {
+static const struct bus_type ccw_bus_type = {
 	.name   = "ccw",
 	.match  = ccw_bus_match,
 	.uevent = ccw_uevent,

-- 
2.43.0


