Return-Path: <linux-kernel+bounces-106584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29A87F0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A881E1F229B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274D57326;
	Mon, 18 Mar 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eec1Fr5q"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0EA219F6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791848; cv=none; b=ZXAhkoqkteQLRVrBD0Qj29iSSTshgyKCWHSfNh/VO6uRmt7dcw02RzJtuKa5PdgBYCVQVzbd+FerhxGgqGLqwasV00DAuODBLMfnA2FRYhA4yjvtR9X9C1nB03WGxaRwOSjCQpbfk6tJ8BSHOZbChfhXJvJfUBSHMmyCcc65h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791848; c=relaxed/simple;
	bh=3GFESOC+U6VEmUnYs1sG/rzktq3h3JAUICyyo3XBa7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM/burL9fD5tMQBVpaeIIkBP/tlHjpypTjbA2xdnNyvJBd1B+DgiUwBFC35cpTXutq3vTj74fl2QBr3SfEaZS1yPpOBFm5/xYFFW+nvO/drwkJJxxm6ELZc+RY++rYkPozaHJUAi2OB0Zz8NX31tyYhtB8xidScIiF3HQPlnnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eec1Fr5q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e00b1c2684so14401635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710791847; x=1711396647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbYK9mYkaokSAe4HO8g3voutIt00vEa0yBv9vB7tmuM=;
        b=Eec1Fr5qZIBrfDfZWXNoNYjox2W1x84CR7kahMaNM/XYjFxQ+VLFdIXkeRPXrksLzx
         FZvnO0x9TlPdc9Jy/qUOnNrS424qISJCHFGaE1q4OzBwoOaXqbIeC2bzpAconzz4fI4n
         j2RwVcXId1YACh1fiEOR9PLUF2FEvoGHdiZW91VpYA+LoX6zazLkluZLI2YwHcdWC7/P
         maiZDeKfVqAJndmODuFto7cKTZ3IsttvoDQ4Mg9ck6+V2xQBzEMawn5EM3/W959DwMsI
         ImLn/Rq/+P3S73cRJGIGRfHIDpMTXMHi1OrGj/SQI915us+i3qzxvF4e60yOZZPBw+/6
         3e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791847; x=1711396647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbYK9mYkaokSAe4HO8g3voutIt00vEa0yBv9vB7tmuM=;
        b=qrGOg8LbMTxtMJozV24gmU+nVv+bBxI7raRPyJS1JAfSNcguv5ksUDkDPdg/kPL4I+
         GKZ0KDD4/IiNi/XnWvIJJU7cQ2z6o1mchvuUEdjML4Oqaj8GxkoNgUvy0owHQRLW93RL
         r6fxuhQ8x4C04SzgB+b70r4IxAg5pnNSztfYduZ7N/BEYt+DKwCay7z5W/DS7arv6t2K
         /tN66EjqzTpOJGl1J1pjc9yELz4u3jN55W3HFMtt4wkvUiYqz3FHQNW0Z+QG2OCjwbn9
         YLniv0EUC0G+/GFrNSO0KHdylj2vybhjj3eDNTahYnbD0eFR7mJzeqezgyGBTls1EYCz
         c4hA==
X-Forwarded-Encrypted: i=1; AJvYcCWHDNXVvBuO5ua6AvDi1mwZTSHKJQWKg3bDWUDNZieuB6pR6NPJxXnwcJw2HrA2UjMetLmIRewECuUF35uVEgSaev//qT++Tip3VMD3
X-Gm-Message-State: AOJu0Yzzw5ooKVjeGUI8w90tQCZmiKIbM4DHSlo7dCDnfy3P+v8GSV8N
	6GYd/IkiSGBzIjnLGBlfSOTTL41FPaepf1YqZflCrKwHMv5ef4K8
X-Google-Smtp-Source: AGHT+IGQAkwsRpc7yBEDg0Wp445e5klRgnbqazGAXFpUiXVpnwcolTFnqYajqLAteciM95WV+CM2Ow==
X-Received: by 2002:a17:902:d489:b0:1e0:342b:af6f with SMTP id c9-20020a170902d48900b001e0342baf6fmr2410411plg.16.1710791846891;
        Mon, 18 Mar 2024 12:57:26 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.68])
        by smtp.gmail.com with ESMTPSA id jx18-20020a170903139200b001dcc2847655sm9689962plb.176.2024.03.18.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:57:26 -0700 (PDT)
Date: Tue, 19 Mar 2024 01:27:24 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2 2/3] staging: rtl8712: rename backupPMKIDIndex to
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
Change in v2: No change.

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


