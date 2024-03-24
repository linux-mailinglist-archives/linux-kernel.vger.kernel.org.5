Return-Path: <linux-kernel+bounces-112844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85365887EEF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFECD281244
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840818638;
	Sun, 24 Mar 2024 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFteGM5m"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004F79E4
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313578; cv=none; b=fpj3qvP4J9u3U0oZXepZ6cqkP9cN59aEAuLHoyaNSaY+IPH03qtNBBv3/Jpb97i9e85mV4VMZwr+ihhtG0mjPBbvtdOGGw87HsIQ2+yhsxv+i34NrDem5LtwjLdtzJ46vFT7OnDU+HXmpEo+oEeJrgRArF0P9CVgFTSfBbClp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313578; c=relaxed/simple;
	bh=22UiKubT7EHMviuwQMLIOURT7NpUUEkIVMAX95NvvkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0VXGrIGDRgFUrrMRsT69eBU8+4Y3p/DviI11BB1w1yqle0QdxSS/XlO6bpDX6Jdy2hTsQc6fzypQcrFOTAct6qU+VdXb/fu74wn1uTFM4PNaXtWxKhQQkeDsWz9CvTHjN5kWOlO2SuG7lKjcoC5R7ojf+IOfoI44nGUu6fRJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFteGM5m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso2455937b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711313577; x=1711918377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyRZutiV2/jtrRGuLfGpKmxuRIEsR8K1wS+EgVmrYBo=;
        b=TFteGM5mbL6qmcXmPr7USPJ2yn1mrI7BxhteLNxMUHYRbl4UcaZo4BRTOA16G1ut5f
         xFYc5MI4WkCAfLHs2J/jr+KbXcvTCuCi4UPbYFEtpyx0d1WDtS3N/S2jKiuSXktQYmtj
         9S9EeVgyqhih2D4hOIMeOw2JU9yUbAa6ZBonWqGKPqvrYi/6xz/ygXQsQuPWpbxQucEB
         fsseofuL9v8NJFuo5oZlhI3Nb85kRv57jv71AtrGWAQaO6bq85T4UNnvQ8ZS/FNsfnZ4
         wfCwFVRgRHfssPdtEa7KO13bFDBarsPXvGuNC5upv0EmKvfmKfPk6lFB1Enswv3Behjv
         PYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711313577; x=1711918377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyRZutiV2/jtrRGuLfGpKmxuRIEsR8K1wS+EgVmrYBo=;
        b=lVisBVzpJ3DU2iDEEmY1oX+V9+jyZOdehCRS7/9Kq7hKme3lIOZ6PNtpgBc72u1TOf
         mbN9BTvOysfxpbIND+AimloPxCPLufOm/KK1pVPM349+IrGecGqEOqhUrHZODixJ7Ach
         3RfWnU8eqk8i5je5u2yXER2kDSzGra0drwtNnV+n7KEGZQMDam5QcD5hcCJJwl2O6d/1
         aiThZDGvWVxwT236UT+Zohr3Jj12cFfJKwkI8kM10Vp+3emjumIGI6tapLh2IQrBIsa4
         8XCu5gpFeStaMr9i/iplkwJe5K/v220vh2uGyQFHJU0yJyRC2o5YNS5B6ICe84mc0dVR
         Ptdg==
X-Forwarded-Encrypted: i=1; AJvYcCWZiKa0sKa7N31MDgaxpMESSo07xp9I6z2oLc222h8mwj2sW1MSxO8Q4G3zOYJf1KosjelKNzMyRWoG/BvJln+8YpHOlMCsc94DxOzj
X-Gm-Message-State: AOJu0YxQpsVqCDJnLbWwq5rdMZwuHs06xWVfq0DEHcJkNRkSntaqHq4s
	/p+oVjL5GOZp/FGy6uliG47pR/xxISbcq5cBqrfRyiVIbXuzfscY
X-Google-Smtp-Source: AGHT+IGo9kUNIqG9rOlXl78uMvmDQrMD0EhncC1dcQKVqlcNRKCinH5OVW0+8URwoFGWqJgDf705rw==
X-Received: by 2002:a05:6a20:3d8a:b0:1a3:a775:2588 with SMTP id s10-20020a056a203d8a00b001a3a7752588mr5653194pzi.31.1711313576962;
        Sun, 24 Mar 2024 13:52:56 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id 26-20020a630a1a000000b005c6e8fa9f24sm4776049pgk.49.2024.03.24.13.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 13:52:56 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:22:49 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4 3/3] staging: rtl8712: rename backupTKIPCountermeasure to
 backup_TKIP_countermeasure
Message-ID: <3fd64e6671d3f86c49fd8c6ba9ef64c4f0e0b75e.1710965653.git.ayushtiw0110@gmail.com>
References: <cover.1710965653.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710965653.git.ayushtiw0110@gmail.com>

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


