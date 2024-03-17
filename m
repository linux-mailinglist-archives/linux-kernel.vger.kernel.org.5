Return-Path: <linux-kernel+bounces-105517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966D487DFA2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C752815A5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC71F94D;
	Sun, 17 Mar 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8pFpO5B"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF91F932
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703607; cv=none; b=R6hs4aAkQW+2Jvd9kJKt6Hflz3IdnUWz3mK0ytujPUKmGQOHicJQbI6g1hXuA5PbnAAqRgcQa4rODfN8e4dAnT5+65lMKsSW/aHYr9Ty1C4n+Mg0QgEurLbmd+PB9BVEu/ng6mKKw5e6clMBX55xjkBdv82EXzJjdyTQVR7aatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703607; c=relaxed/simple;
	bh=5iUakWHZ2xIUZce/GJzvI7SGPPKCVQXi7v6lz97ehJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irUTbIKRU9ummAfQsLQJGVHc2mS8MmfdGsLjmdFMDYN2p0j86SEtNz5eBcqX4xaNc+k5DO8dh49bOSilqwifGrXPUi2S6HkNKxLmlH+eyquicqOFKq1Po4mYqT3UXVuRMX8PHGG+NSYxNl6T3e95eXnWA06FLbDGYu6Fwqu+Nq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8pFpO5B; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c37e87756dso1042452b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710703605; x=1711308405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VjzizuacV1B0CmkeG2qTNIJqlqeCPwMo2mxSMnDyLWA=;
        b=h8pFpO5BO8OEzU/9yfgDGZDH/1r7In/AS4JPVPKyh9pG8/CjPofBu0cgfzkKaZYEjs
         FSr58PPgI9foC1Kx/5w9T90/MJyqz80Bf8W8ACwWHF9CroicM/HZDxNILC49QABBRoQT
         GFNaeSUU1+158X/SM4K/ijej820674W+rhfcH+7tnVdasSssvYVvZElVuRVJLPD2bGjD
         UCvs+O79aQr26uRI171XfFTdWsQXxxdgoInvDSZVDSWr6u2d6eK8z4U0ABQQ58BQpTZF
         gRHBUIR/VDH8lYX7RCo2+JkS1xAIXge9AFQAPyU4V/LR21blgkvyXav8YqbJXkH8cBhC
         dXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710703605; x=1711308405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjzizuacV1B0CmkeG2qTNIJqlqeCPwMo2mxSMnDyLWA=;
        b=B8uybur8jUpFXma+JiibJVVKvgSBdAg/kt+afz40Dzpr7rAuxlG9T+ZaFrBc8EvQ/5
         Zb81gfIh5N5A79AWSK98XS3fNFteINQWvitBZKppiHN9yOIMqeisrIGw9stk2enKhO/M
         TsfoueLOLHHuUv/q54aiTv7CWNIBY2BitQLIrDWgIUC2S+ThGEbnNrUo0pWKRjNFq4Rw
         9C6wxO5gKhKRVPPwkjWe2pU5AYv7YaXf+n/6RMYsvVDj8fi+xuMSMf8UiiVO8NT2lXrh
         Qw5iTcmEEw+agkR+vMTcTvBIjRBOLnpst6dDl5alXkbrs2xHNbSrkUvzPsaVFT3IXvY4
         zQNA==
X-Forwarded-Encrypted: i=1; AJvYcCXaqbDzeIaF54A+g43+sUXM7GPEnQlQFv1PMwCGOqVH8FdRlRRVMRzPmT3vYOmTxGeLBpCGPQwLSosNzm20j8BUY00wkjsfwv4JGFus
X-Gm-Message-State: AOJu0YwFX+fYna/0lqucAICSOHLaCvpoiK+LMtmmSvB19nSzuGeOZD67
	E9gAGJJuDdtfzd6B//KgBQ8wGwCmZDFZNRbddYkor02cEKPHaFDG
X-Google-Smtp-Source: AGHT+IGda7+ZYL5afSY/gJ9PcukxWWU9Y7XSgHzAQLDMspffQybuCpOLss4QAqvbuIJV3GYkoxefug==
X-Received: by 2002:a05:6358:284:b0:17b:5e32:6009 with SMTP id w4-20020a056358028400b0017b5e326009mr13708650rwj.11.1710703604795;
        Sun, 17 Mar 2024 12:26:44 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id r19-20020a63fc53000000b005e83b3ce8d9sm2110917pgk.8.2024.03.17.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:26:44 -0700 (PDT)
Date: Mon, 18 Mar 2024 00:56:42 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH 2/3] staging: rtl8712: rename backupPMKIDIndex to
 backup_PMKID_index
Message-ID: <279456b8fb09414316e626663d70650f4a3c1d98.1710703217.git.ayushtiw0110@gmail.com>
References: <cover.1710703217.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710703217.git.ayushtiw0110@gmail.com>

Rename variable backupPMKIDIndex to backup_PMKID_index to address
checkpatch warning 'Avoid Camelcase' and to ensure adherence to
coding style guidelines.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/mlme_linux.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index a8cda81f4240..ac8196d24ce0 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -87,7 +87,7 @@ void r8712_os_indicate_connect(struct _adapter *adapter)
 static struct RT_PMKID_LIST backup_PMKID_list[NUM_PMKID_CACHE];
 void r8712_os_indicate_disconnect(struct _adapter *adapter)
 {
-	u8 backupPMKIDIndex = 0;
+	u8 backup_PMKID_index = 0;
 	u8 backupTKIPCountermeasure = 0x00;
 
 	r8712_indicate_wx_disassoc_event(adapter);
@@ -99,10 +99,10 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		 * disconnect with AP for 60 seconds.
 		 */
 
-		memcpy(&backupPMKIDList[0],
+		memcpy(&backup_PMKID_list[0],
 		       &adapter->securitypriv.PMKIDList[0],
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
-		backupPMKIDIndex = adapter->securitypriv.PMKIDIndex;
+		backup_PMKID_index = adapter->securitypriv.PMKIDIndex;
 		backupTKIPCountermeasure =
 			adapter->securitypriv.btkip_countermeasure;
 		memset((unsigned char *)&adapter->securitypriv, 0,
@@ -113,9 +113,9 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		 * for the following connection.
 		 */
 		memcpy(&adapter->securitypriv.PMKIDList[0],
-		       &backupPMKIDList[0],
+		       &backup_PMKID_list[0],
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
-		adapter->securitypriv.PMKIDIndex = backupPMKIDIndex;
+		adapter->securitypriv.PMKIDIndex = backup_PMKID_index;
 		adapter->securitypriv.btkip_countermeasure =
 					 backupTKIPCountermeasure;
 	} else { /*reset values in securitypriv*/
-- 
2.40.1


