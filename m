Return-Path: <linux-kernel+bounces-109709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51734881CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE24AB21963
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E444D9E7;
	Thu, 21 Mar 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7iSZmbK"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E141E4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004268; cv=none; b=LhNRXwx4skE1JMFCTSdJBfB3xuIiYaATbGrd1CWLyRPWUUNfhTFLRu63FGmW0qVPoMAvc56u97tMQv/G+vLHjyVxWJw1HQYPPFnjZXkpeTUo+0YDiwqx+2CeHi/Z1cOTQmlvopSXsR6zC7EQ4rhAeVfZl3zvb3p+HyQ6tVUOEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004268; c=relaxed/simple;
	bh=StxNl/KI8IGwn9Tcx+LijsYzpaVocZlUNBEJwMkixMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I7EeZBsGqmRTWtZZn6xfYpC4jDPtWho+vwjzIgUOq2pV1vMmd1Cg59WuvUVBtwZJ52q/82Ljq7I7uPXdYMp+gmhS0KtE+M8kgF3qcD2bGpEIc8gd4jfuL7fJckb1Yk83BZ2QXznj1vaexLZXwZnmOOsIN6HJaz7+WRHFs8QFZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7iSZmbK; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso557133276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711004266; x=1711609066; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2Ihr1sSb1dhBBAxziapzajvXw1Qmx1MeL7IyGGNNK0=;
        b=J7iSZmbKbSzcI4NM7jXzn5S3lkUxLBsz0RYE6oP63hdUfc3diAdBrguObNW1G2+das
         GGjf7GkT5o89lAvOWDEF6vkXVhcJs27SbzBKU9rqzRoKhkBwvq6Doc4lJBYeSATeQjDq
         v5ZAvLrHPkkhMmIpEQn1vbbxQH7SbmQrfOhrxNyXF8DgU43XXbN44eZtV8EL4K793Vyj
         JF/e6JtrxRBDpBJgZQR7iSujS2debqVtv5ySjruyKy9kcVIZLKNyBmXaWGhBDts2IGoI
         O/OwxzpzL6XkMSxy/0pGrj6LVnC7B4qYB6sechmK/JBj+LhcUT3MlKN3bn8X0MHWo+UH
         iY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711004266; x=1711609066;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2Ihr1sSb1dhBBAxziapzajvXw1Qmx1MeL7IyGGNNK0=;
        b=VXpCpmi1w8KbD0wyeiIra8Ngyuq3L+Upp7YESIk0WMRrdd/msBP2ZpGw0mNEZiZNtu
         +gYRVv73ChMvOlCzJYyjKxv0UaaRUJ0yEgaztfLTMXQpNvzLf2FnrXrhEbskA4Id50zK
         7OGVSxG9v6Kp3GILOoqToT1ZgTx/WOp6Gc7CwUvdaK2YOiRkxlIeb2c8w2Ztrffs99oV
         jWUTEoEjQX4GFwvdmIEtGOCWBGNURs6aJcQnkCtvO6W/eScfk0h6ruAnV+xVFKRbWRwz
         uLEXrcap+6zOzbw2qEj8+/Wtn+b2JH7uhAW0ixPvim8U1/3/2LXJnQLeLjJF+kE4Mzs+
         kAOw==
X-Forwarded-Encrypted: i=1; AJvYcCUgG2neCAbZZ651UgugcmU8+cEWxuTJMSzrw5WP1i3eMFwveYDTh8ldL3IE6DHuSjqBxG9R6hAj5tPYqNlJlj6mEKjU9hHIdzDd/Daw
X-Gm-Message-State: AOJu0Yw/RI8n9b/o7kFo1aoM44SU7Cc2lQwCRWrwn/P3o0DSvpMY3LES
	546tWpV61WnKg9YSZx2QrUqyFCc3H7TqQmn4taFoCj+JmzJLX+0lTyRA33fDnh8=
X-Google-Smtp-Source: AGHT+IHMkKzlctySclD7YkUIPliBND2uiteo3ehaPZV+3Cjf4OSbcgCvJ32U88WkzHdk2XoHiIhr8Q==
X-Received: by 2002:a25:13c7:0:b0:dcc:943a:b99f with SMTP id 190-20020a2513c7000000b00dcc943ab99fmr919184ybt.46.1711004266279;
        Wed, 20 Mar 2024 23:57:46 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id o21-20020a63e355000000b005d6b5934deesm12194200pgj.48.2024.03.20.23.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 23:57:45 -0700 (PDT)
Date: Thu, 21 Mar 2024 12:27:41 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v3] staging: rtl8712: Fix line length exceeding 100 columns
Message-ID: <ZfvaZd92bnoZ9M1m@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
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

Changes in v3: fixed the issue in v2, created the patch against
a clean staging tree.

Changes in v2: Fixed the alignment to address checkpatch.pl
warning.

drivers/staging/rtl8712/os_intfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 7554613fe7e1..1b11f8b04e13 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -221,7 +221,8 @@ struct net_device *r8712_init_netdev(void)
 
 static u32 start_drv_threads(struct _adapter *padapter)
 {
-	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s", padapter->pnetdev->name);
+	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
+					   padapter->pnetdev->name);
 	if (IS_ERR(padapter->cmd_thread))
 		return _FAIL;
 	return _SUCCESS;
-- 
2.40.1


