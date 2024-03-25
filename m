Return-Path: <linux-kernel+bounces-117639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F37788AD97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B6D1C3F3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F654502E;
	Mon, 25 Mar 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5FqLVav"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B918E20
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389030; cv=none; b=buMqvq/BK9OIgCAqV3K9dhzTUBlAps4i2yLk3WVYS+/J4TLBG5MEXVMQNZnAncqEq/sf8+eqfJavljv8aaZVNgMvDWl22o0jU51HVuI+fk08grAFp69/7v2ei12+mF5aakTctZgYeXbOwfFqscoVanz+KtdN5IzuJfnzCpDtt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389030; c=relaxed/simple;
	bh=mLOchj0+iWZlApmwpPHKFKADSoGovJwves4ASWPI97E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTiWx9YToweVOJ5Q2Sz/u/N6ebhDNikCkiD8IL0ZJk9K57IITkgjcxfCIN3cLJhm9+k1SPC05HH3s8xGNxBYRDwg5FnyVMnBh8nLkyMenXEbh/NW4fLp4+zjaw2QRyW30OP8e5ciJK6V4xMF+nUaBaWbrRa/LEWP5z7u0CIjWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5FqLVav; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3195156a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389028; x=1711993828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zxB1ME9DNA2QAznLegn7G7zlIdrVB+x8IZEYE8rx6AU=;
        b=X5FqLVavn+mCIcJ25ksFqXzLywUT/C7q/JM0ZjTjEcGl7Rc25W4AQqqJMBsjUsbf4K
         bs527PfXPzVqoXDPTQ/rO/2HA6LawBSkToKXxrg9iAZ/z4c7pTcFeNECfFtsCBHEalGv
         kJG0bii5eIk8MGGo5XChMWIXpOg62RsLlA29VhWpoV8CL4BfGKCmQEBUzoQFU0zxowxy
         FGH7TQBrzdslWRAjKAz7PdAm2T/VpiBfKXscaoYSwnUNtJutaorREJwikyXZUJF25ly8
         F974t5TdiYX5qffSzGLgbgqbtqLUeNPKnVEvY4VN3xZpXQq61hjDZWsLtg3Jon0nxBGF
         2Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389028; x=1711993828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxB1ME9DNA2QAznLegn7G7zlIdrVB+x8IZEYE8rx6AU=;
        b=vL6Nyjg4kWBdFIY0NRazfmxcFZA1vq85yzMyGxcOb9XWwz+QveFm4mPDZRIu3Nm7uw
         e6LX115WqCBRCcviBJAaQyJWek2CBPz7KZ9tn6qGG4tdx8LEQ7DYWQaoyF0Nr9O1dYS8
         jlKIQyMKOCiY4Evfqs5ba+qAwEPsmOhpsHAYPpVRrQbHt4Cw31AQpNlpibqqaebmozlb
         o45/LIel2y9nkO6g2hEyym0S2mD7QX1gLt4ufYuMO6da5LIv67RQSj+O/gkZUUqrf2ww
         tWG2ow9RmZwSxi4p2c/H5tO0Gx22E+T3wN+Yuw3on15AHWFrj1GnoR6QFPJioaATwG8O
         4oPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzgQuXrwo1yyK3jNqa0yi6cmYX2bl5929EX1Iafrb8ZohF040yhi7tNmQ8YUocZTP/3ksm95aR2Jd1a6lwNJ7f8lItD+kGoQ1Jgn1Y
X-Gm-Message-State: AOJu0YxIeuHQ6fFSc1zWp5hpvGMW0EtoR55S8OQKO9qVL5Li6b6XLOJq
	7NOXc173DE3cZr8A3GbE32fmE0d6jLE85MrEPexhjl8grGqk23TH
X-Google-Smtp-Source: AGHT+IEW8ixadyy7GPbDHnFI2/TLp+VcVncvNJpKaVXwmQo/2MNoRtcYPIgFJ6Ezm5p0Ijo0axf6lw==
X-Received: by 2002:a17:90b:3110:b0:2a0:5880:bf01 with SMTP id gc16-20020a17090b311000b002a05880bf01mr4871890pjb.28.1711389028062;
        Mon, 25 Mar 2024 10:50:28 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a8e8300b0029baf768de6sm5915126pjo.1.2024.03.25.10.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:50:27 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:20:22 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4 2/3] staging: rtl8712: rename backupPMKIDIndex to
 backup_PMKID_index
Message-ID: <2902ed6252d6773fecd32254383eefe8b0c465aa.1711388443.git.ayushtiw0110@gmail.com>
References: <cover.1711388443.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711388443.git.ayushtiw0110@gmail.com>

Rename variable backupPMKIDIndex to backup_PMKID_index to address
checkpatch warning 'Avoid Camelcase' and to ensure adherence to
coding style guidelines.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---

Changes in v4: No change
Changes in v3: No change
Changes in v2: No change

 drivers/staging/rtl8712/mlme_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index a009ec1a5c11..ac8196d24ce0 100644
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
@@ -102,7 +102,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		memcpy(&backup_PMKID_list[0],
 		       &adapter->securitypriv.PMKIDList[0],
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
-		backupPMKIDIndex = adapter->securitypriv.PMKIDIndex;
+		backup_PMKID_index = adapter->securitypriv.PMKIDIndex;
 		backupTKIPCountermeasure =
 			adapter->securitypriv.btkip_countermeasure;
 		memset((unsigned char *)&adapter->securitypriv, 0,
@@ -115,7 +115,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		memcpy(&adapter->securitypriv.PMKIDList[0],
 		       &backup_PMKID_list[0],
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
-		adapter->securitypriv.PMKIDIndex = backupPMKIDIndex;
+		adapter->securitypriv.PMKIDIndex = backup_PMKID_index;
 		adapter->securitypriv.btkip_countermeasure =
 					 backupTKIPCountermeasure;
 	} else { /*reset values in securitypriv*/
-- 
2.40.1


