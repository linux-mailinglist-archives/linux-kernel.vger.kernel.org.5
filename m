Return-Path: <linux-kernel+bounces-117641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423788ADA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3D81FA27B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFAE7175E;
	Mon, 25 Mar 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7hxQi1+"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09E1B5B1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389174; cv=none; b=QsDINjneOb/A1mcGfri+H+TkC3Bu0zo9HYrf9PAUB8ajRev2psKJ20mFKV/Y+zWeZi1A9mr4XOUJ6IJX8XuQKfWUiyTpiPnuIyMaGOoZk5VxJV0ZE0lT/SLi+3Q9E7J+oUr3EjzBZ4k0FgUE/w2QLL5CRBnfktoZa72ZLbrTSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389174; c=relaxed/simple;
	bh=+e0it607tIg+b2rZM2w/eJragbno58DdtfRWyRwQ1f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDQ9O21jncp0CQ/RofJwSHPnNAqBTv6GJA4+d74ulvLRrKYA89ZcHXLgM6WNGRqzCGft1BMW6y0jfZl3jFb6zu2YTAdLV1GkUK6hFKwVzD1xZuFrb/xaN+7ooSXYTYEHdn16Il9Xkp6Nc7y18C4p0yuSiNynldnDU6uWKkMBzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7hxQi1+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2636475a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389172; x=1711993972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdkP92/Ym8fhO2N2bPQUMgG774O7zzPSnF71mNNVTm0=;
        b=b7hxQi1+pT3OUZA3vRwEG/g2gYiJhsm218O2adxZLKK1TQr6Vyfo21yrxPwa7tAFWz
         emlran3GBdtzQyr2VJSfOP7eGyYnD0vOG0OXZuIiNHqR6BF4KnyoAHvw2kmUubFY/6OA
         i13yMMAygWgbSuwS2QdWZHbPnFTJ4Y3E6G6JeiXRoKcwICYtVYc3L67iP8DmG6xxZzBg
         WQA9ZRAigbzatRh98c5+zSoNTJ5h24GqrIY+ZVsrZR26iK+wArWNIrglCi0vWuHi9wdi
         DAEvDEuV7M95irFBmcyGsf6VW+p04Esis+IaDrRMhleeryC3fOMKN0Gb1EA1vnAfC7I7
         jzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389173; x=1711993973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdkP92/Ym8fhO2N2bPQUMgG774O7zzPSnF71mNNVTm0=;
        b=UXhAX8ABxCzKDEDZNLaThpwMQqTYopBdOUROT3tg0TxJIqg6SS4l4RLjVs84zNjlX7
         xVHXyw7HtC00AY1JvMFYyeWKhSpfVEb6Xef6wMAtHRIzhEPxZ0c2P6lgQq04RQ5P/I9x
         CbTEEbiCB0WE7aWdvEyIdKuhjMVe1G1+0FjIxpOqQqjGi514KfHZ5ZKkW1bZRXRsqYuP
         g0kFHSpD4pKndvIQmELMOQdfzqHkq32brhYNfycXVIOM/V4mT6keDox71QSQvd5sC0mn
         JDaw8Az6pXaa7++Wd9g7xrCQp8xN0sV2lLPzPnHi6rvi977szfXGAN++SmM2h03infOD
         /YiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcQuHOfeRlYb/BW2XKg1T6xSHhVs50tBDkxGf3CaEW9cUERzKqWqQtAtCZUGICIUULp/WfeSyBGyJPvpMTkZLEHhDmYRdW/MD0qZwp
X-Gm-Message-State: AOJu0YwjS82FEPeQTe+QeS6ivx7CHKEf2uFyYe7MsJfls+bv4Lh1Fd5W
	O5as4zPANFSqkvQF9PuRvoKfTwC7Mdtf0RlYVdExB6LDUZm/9h9/kWZR/ZhajlU=
X-Google-Smtp-Source: AGHT+IH7l6Nr3jgLuzR+uEEpfWCStVS9T4WpcYVGab+dpXtZY5JWh6SKJ3eaUaCdiYBw58Jmk6rK9A==
X-Received: by 2002:a17:90a:e542:b0:29f:ce37:50d8 with SMTP id ei2-20020a17090ae54200b0029fce3750d8mr5423211pjb.17.1711389172525;
        Mon, 25 Mar 2024 10:52:52 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090a9a8100b0029e077a9fe6sm10348086pjp.27.2024.03.25.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:52:52 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:22:47 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4 3/3] staging: rtl8712: rename backupTKIPCountermeasure to
 backup_TKIP_countermeasure
Message-ID: <3fd64e6671d3f86c49fd8c6ba9ef64c4f0e0b75e.1711388443.git.ayushtiw0110@gmail.com>
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

Rename variable backupTKIPCountermeasure to backup_TKIP_countermeasure
to address checkpatch warning 'Avoid Camelcase' and to ensure
adherence to coding style guidelines.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---

Changes in v4: No change
Changes in v3: No change
Changes in v2: No change

 drivers/staging/rtl8712/mlme_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index ac8196d24ce0..436816d14cdf 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -88,7 +88,7 @@ static struct RT_PMKID_LIST backup_PMKID_list[NUM_PMKID_CACHE];
 void r8712_os_indicate_disconnect(struct _adapter *adapter)
 {
 	u8 backup_PMKID_index = 0;
-	u8 backupTKIPCountermeasure = 0x00;
+	u8 backup_TKIP_countermeasure = 0x00;
 
 	r8712_indicate_wx_disassoc_event(adapter);
 	netif_carrier_off(adapter->pnetdev);
@@ -103,7 +103,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		       &adapter->securitypriv.PMKIDList[0],
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		backup_PMKID_index = adapter->securitypriv.PMKIDIndex;
-		backupTKIPCountermeasure =
+		backup_TKIP_countermeasure =
 			adapter->securitypriv.btkip_countermeasure;
 		memset((unsigned char *)&adapter->securitypriv, 0,
 		       sizeof(struct security_priv));
@@ -117,7 +117,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		adapter->securitypriv.PMKIDIndex = backup_PMKID_index;
 		adapter->securitypriv.btkip_countermeasure =
-					 backupTKIPCountermeasure;
+					 backup_TKIP_countermeasure;
 	} else { /*reset values in securitypriv*/
 		struct security_priv *sec_priv = &adapter->securitypriv;
 
-- 
2.40.1


