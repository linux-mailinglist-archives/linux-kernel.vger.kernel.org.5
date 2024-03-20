Return-Path: <linux-kernel+bounces-109431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6928818FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AD2283801
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5D8595B;
	Wed, 20 Mar 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQc8JHSk"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9EA4F8B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969628; cv=none; b=G1iwk6gagJqHq2RQL4+mETnXhftEtaWjQcR1yCavKuMeX7A7K/0FGqyo7EhbqK2oaHmOtfygdHDyEWiauArdcVy5jbu5l6gAKzbuqJyltgYvOL7c5iBPJKdcFpGGbdRAu3OlmWM5UZPbZ4FURxr9r+nHCYZl8Xb/7EV1EkLLIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969628; c=relaxed/simple;
	bh=NFVEItHG5lM1U16FUnCoPHMmr2sd19WHClYJ6LrT7hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVJTLQqqQw34a6pe2X5keopkD/z2g63zp3igvWNIVQNzT9L7nPsZy1BFtvytTfr8UAXsTPu1VyFEEi0VSVJTyOeO/a8S05bmMhP+65+j8IEus468P5lTUJxzCCTQF83pDiClG42WnlgR6U1nxzUhWPVQ5XcbzlpL1VPSBarpfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQc8JHSk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1def2a1aafaso1801585ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710969627; x=1711574427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x0FLJZ2j2x4/r+XyOiwEvTZzCfcrETa+/DL0dHt9m/o=;
        b=AQc8JHSkOqW1djdb2uaUCTftRWb0JQI2ijFhySYwnsDMD0AkMFhN9urZYfudG3rGqb
         uW67f9O4NPwNYbSg0M+ukndrjQ1brJafXMagoIl1v7dBu6crO/NIcljjwWNBZIbrctTO
         W9+kdOr+/nG/tCfPFzhP8EJlC/SZ/9eDdFE2QGheBnvsKiFAjlqeI7+0BDOZosfCgKJg
         7cSbcsOf5MKd0JJLaupdjmvP02qdqMrrhXYCoCi9rCshSSWIqD4RWe3kOMM0AHH2Vqvn
         0yh/4aJBVIWUlWnuGoWIdTboasovXx7M88YCNUBhGpPKre2KTctZMTkphUZuEDhMdZdV
         YKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710969627; x=1711574427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0FLJZ2j2x4/r+XyOiwEvTZzCfcrETa+/DL0dHt9m/o=;
        b=Y5t/V6FvuCNN8ZBYb7Z1KT1kEO0DeWyiCZReHb8QQxigtxs4RD283UECqqn4Zl10Dv
         NBkQyeecY8vV5YY8d0blkRMFGNZkx9Gg6yH6vWv2fN+d8vSWwvRAR9GLjR9qg2genHFz
         MJLCG9qj0vfdgRiUQEQfB+JOqqa/TDLUxGDqYIkxanx3aHCq/OFeZAtj/gXbFt46EosV
         IdY92iqSe4TbCAyqiYEzfGjj2A1WtgTSeXJNn7XSZjPmgmXFtZs2Z45E880N6ASzJ9AD
         eBVwhbV7ESh161O0CIcTbZfEMjpqYMxbofxEfWGXestieO+TmcUSzy4Qy5sQeU9Ehqrp
         OShQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuxnkBwSnW0+zb1r2AKcNjeatzNp8b+0JCV7CDfH+uZE7/e80hee96zUzbTPdjnKP5Yk2YmHxDzxCt3HMst0HKWmJgi1T0khFE0Gz5
X-Gm-Message-State: AOJu0YywLyKcSH6aKFFKD1FD7b/PBlCiPfKOhp+pFtWs9UkngRIPOUiR
	6CGE8v10iNFnzXxgKIfcAvgxkh3WUFeDvHwKDwaEY9nGZoNfrsooLgFtiBSjjYY=
X-Google-Smtp-Source: AGHT+IFxZpDs8usQm8L7cuu08LIijmZbjTKdkWB5e/bS3IjVW7XUCB/JBzlNxkBjwENALeDWXRh/hw==
X-Received: by 2002:a17:902:9f8f:b0:1e0:3f65:f503 with SMTP id g15-20020a1709029f8f00b001e03f65f503mr287059plq.39.1710969626873;
        Wed, 20 Mar 2024 14:20:26 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001dbac604e4dsm14140586plg.146.2024.03.20.14.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:20:26 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:50:24 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v3 2/3] staging: rtl8712: rename backupPMKIDIndex to
 backup_PMKID_index
Message-ID: <2902ed6252d6773fecd32254383eefe8b0c465aa.1710965653.git.ayushtiw0110@gmail.com>
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

Rename variable backupPMKIDIndex to backup_PMKID_index to address
checkpatch warning 'Avoid Camelcase' and to ensure adherence to
coding style guidelines.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
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


