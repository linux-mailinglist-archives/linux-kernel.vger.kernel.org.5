Return-Path: <linux-kernel+bounces-106586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6487F0A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BFE281B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1C05733D;
	Mon, 18 Mar 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl/Ak4uv"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049D56763
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791908; cv=none; b=QfrJzt1Vtp1jiP0cQyF4fNskrsYB3R5vh1ohMeBOmpacuTCfheIGp4uZk/qjQRmP65zA6GpyCJIfdwqRW8i+oKLcn0AeYdn7wQ8BgAksHfw61m840cjL4Vnb7rEtwYB/0PlTblPCwbiWtOHDmNjysPFE5FpDTt6sofdbafDqiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791908; c=relaxed/simple;
	bh=imHre1WYkYJJvHeVYmQyseBXC1vErVr/dpt8t+8JCL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JViw4mUl1Ub78qMYsf+X4ZB7kQO5DaIalCpdVKcMr/1jMelP4Weu28sJW4GERt4MJQE0oWaDjqO4UZTA36gf3RXB6U8sHjK/mPgm5dChgLepevks6nrPejWUYZqx7WMhptd5fZ4C8gpbD/UlTRWjO+802sO4n9YEkBjud/Vl43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl/Ak4uv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1def2a1aafaso20154905ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710791907; x=1711396707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhpWyfW3cSY9QR0atHoby5w0GIIMIXfenBRbMhngid8=;
        b=Cl/Ak4uvVkXDdl3ixH+cf1A9g7O7JYAy5A+IN4AV3+2u05Uja64Y8l0ztYqkn0pNPE
         eZuYpTmM+CnoxSVOfO33s2lzeZiRIB69zJL+71Gy1pG/E519j/6PS95ROOJ09nSPnVRm
         YIFYGDOP6NEppqRUwJdmBQCX5qsNWIfDo67BKdfOuPufp0zqyoAPO+RN5PFoK54lnOuw
         2wlZR06Vbpupxx2UFItw/DYGBP78aoyI6DxjzTh/XNLDfrUgGxwGUIRZIWCX63MzYdhu
         fj52PEy9aSipRCnuJpnQ7eTTWOFDslMMvK4Zkszwi+h8S1jQs0wn4EXZ60RoJ+iwgZSg
         4ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791907; x=1711396707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhpWyfW3cSY9QR0atHoby5w0GIIMIXfenBRbMhngid8=;
        b=L/PKHdDFwz8oMlnOwxDjrbhrV0U00tFB9BoRso7cS/NWcFAdX33Hd/qQ5tj5MHjsDa
         Oe0eFbGbNd9bH+MB79MpjPkV62PVP4HetP/zP8bVFiGhrZSrO6oqd7AmsO6Ao+uOQeKK
         OKbPlKvH8b1PyjszgtD+SW5qrCcCr8BNzZlm1R7P54QDQso1a+jws+C5tILc0MU+Leun
         S8Wf1AhR08PM3cjAur0G9Nkg1F6H58lo7GV1uCQIvbvdVaMdVzsplhW5vTlrRl+nl32U
         yFVFfuCn9K9x16PcVVsBs7UqM3caKuufUM6/yyQseC1hbAhmzSFZjYWyj6Z5BbowHq9v
         9CRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSPYC4HWKsKPRi/ef/p0P2p+RkiZ2TnEfaqAX6mKp8LPLTBT17BfXFIK1COzfEy+9ggdfGh/GhS9D8aZXUYUMYFUDp2hXLA26E7iv0
X-Gm-Message-State: AOJu0Yw3Oedkt1VU/2srszhtLwfr20fq9d1UF6EVFStVNkJiiq4HyOyP
	DTNtT0WFfCSWqNZQxCfXeblNMhfbgDTrnJ3aaFp4vJH7YPJf0P7FqiwikLC5JFg=
X-Google-Smtp-Source: AGHT+IHfOD+YTWMpzUuPz05rdC/gZaOPr4VZoVs4ZtW+a3K0l1NLSpccPzZ6c8y4xiwZzGJz71OCEw==
X-Received: by 2002:a17:903:2289:b0:1e0:e16:8cd4 with SMTP id b9-20020a170903228900b001e00e168cd4mr6593115plh.63.1710791905891;
        Mon, 18 Mar 2024 12:58:25 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.68])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001dd091a4224sm7225607plg.61.2024.03.18.12.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:58:25 -0700 (PDT)
Date: Tue, 19 Mar 2024 01:28:22 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2 3/3] staging: rtl8712: rename backupTKIPCountermeasure to
 backup_TKIP_countermeasure
Message-ID: <21c20db8d4ffdf914a3d91daa7860d1edec9f9e7.1710703217.git.ayushtiw0110@gmail.com>
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

Rename variable backupTKIPCountermeasure to backup_TKIP_countermeasure
to address checkpatch warning 'Avoid Camelcase' and to ensure
adherence to coding style guidelines.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

---
Change in v2: No change.

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


