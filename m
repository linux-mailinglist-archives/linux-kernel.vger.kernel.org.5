Return-Path: <linux-kernel+bounces-105531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2387DFCB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB900B20B45
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733441EEF8;
	Sun, 17 Mar 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IehbeBak"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC61EB35
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704810; cv=none; b=vBC4YGGvrh8Nx1lAb2MHu46vhRebuKDeaxEGJlOvVi7TZ1F82B+TCrOTRT2d+OTh4UmM2HIx6SHOVynsiKL0/o7uusmq2mP1tc2gqQZ8ECzf5k26aW4Brmc3pc43R55Q4VhGrDN7tav9fHDRFFcFH3C956n0H9bZ5OgCr6oDnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704810; c=relaxed/simple;
	bh=5VoeI8shccD62vvJl27csC1lbvCVSUXAMc14gVH40eA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V6Q6XkyUAZ5lNdjM4zPUF5qEh6b4KN8DREu++Y00A23CfkMcB2XkL+FMMFBTR6LGOoyn2nd+4UwJtPY5WAjzhpJvHb/FpDGeCxvA+TeDkMe470dslt8cwVhZL2DRCcCNmgIn4WTLK+RpSMKMd8JOVXS65w/hFB17ezT4p6IWTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IehbeBak; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-222a9eae9a7so631078fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704808; x=1711309608; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kz8BkbFXqKqMfjxMVaZWBsOHuYxmooNt9MF70X9aYrc=;
        b=IehbeBakP+S3VbI0LGSNqEIdJKnCRhaa9E4KjT98RXj6sMOue8WDzoaK1LPwhGFGUs
         1IG/eti9DVGisa8r6OEs8iPRYCNw9CCC6vz6RX7eWGY6GAxtzJ+7nr9zVjrYZr2h32sK
         uAFc7bLhoG6bUe4FYoq59i317W7LRoY/CISXdEKaKkKzEmutBDQ5h7Gx7svxHhwbnOsP
         fGuDW+yaAWOyhRD7cBD85vclB/w5hX2mQvhQakoSBcU25JyWubhDG4k/1gj6xkVIJdL6
         /3h55Xa9o0U+eYGgpV8dmlGKOXcECY3q9fi61yqG950sgt+oaQ15Ef9pmENJ7sLgLcOE
         MO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704808; x=1711309608;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz8BkbFXqKqMfjxMVaZWBsOHuYxmooNt9MF70X9aYrc=;
        b=Kt8KBZ23SalzLSq9M0kNN6hqmplVHJEkCZzwPQ0kZ5U5cPWHMNVZAFWnjzKUtXO1X/
         1RZZJcQvOofzBxqlk4JCdrrdc3P+nxU9kyaZzCzHheJMi6Rp18QTvEKpdXynMzVQoT3H
         tAW+hNGToIgEPe8EYtCAebQzJ/E/H+3NfHWksywqTAe2jAQUVobsul7Sx/ox1GXuA+3j
         ynGsF9cWD0BrWltwaJ0Vq9cMHo1AlDffTlfrfWl4dGl35KD3trMgz96LNjpC8YSvvFmO
         4NwmwXAZSfV7DmCRvZUzAu7Gw3FdV59DmLffgob6o0cYWB+vDU4+UFP2sos2BqbT9Wxv
         HF8g==
X-Forwarded-Encrypted: i=1; AJvYcCVS+hMSrXt3PMqdOk85Ees/XcAdrWzQPaUibBufSqrkdZPSQlxHZKnvt+Wg1zD91YP/odGSh1ydSoo++PCsktQ7kp1HZkeZhL1UIA/+
X-Gm-Message-State: AOJu0Yyym6uH8hxQGK9hyQCKeYUMdiczz+H2ViB40AOzZ0Jx06bD+M5j
	kWQ71gdFMxyLVR531yj9QjLSOKamIcse7Esb8Qto+yOXbYw/i/uc
X-Google-Smtp-Source: AGHT+IEXP+04l7fbZ/T1oWuQc6nrIlGvXyfydrEluqYX2fpdbi/mkaup7DOLjFJd/IkVmikqyNrtfw==
X-Received: by 2002:a05:6870:e415:b0:21e:a47f:ec31 with SMTP id n21-20020a056870e41500b0021ea47fec31mr11656682oag.43.1710704808430;
        Sun, 17 Mar 2024 12:46:48 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id o9-20020a056a00214900b006e4e616e520sm6517625pfk.72.2024.03.17.12.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:46:48 -0700 (PDT)
Date: Mon, 18 Mar 2024 01:16:45 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: Fix line length exceeding 100 columns
Message-ID: <ZfdIpVyUTIEGTp7j@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Split the argument list of the kthread_run function call across two
lines to address the checkpatch warning "line length exceeds 100
columns".

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 7554613fe7e1..e77fcfc465ba 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -221,7 +221,8 @@ struct net_device *r8712_init_netdev(void)
 
 static u32 start_drv_threads(struct _adapter *padapter)
 {
-	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s", padapter->pnetdev->name);
+	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
+			padapter->pnetdev->name);
 	if (IS_ERR(padapter->cmd_thread))
 		return _FAIL;
 	return _SUCCESS;
-- 
2.40.1


