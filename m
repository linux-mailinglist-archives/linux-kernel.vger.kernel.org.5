Return-Path: <linux-kernel+bounces-109430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A688818FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B653283677
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532398595C;
	Wed, 20 Mar 2024 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqGoS201"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36E85941
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969562; cv=none; b=MaRC6Ehmn67U6mH3esV0arA+jV9QBtxeULJB8+S/Sb7tGl00OIGBIEI36gHADf2dlNQ0fD8a/Qa2kxTqJ0KmuAAQzZMBw8dalTqj677H8mPfyRKbSRatkcW7+xiVANqSf5r0tpnWNCu3RyYxtcP8RvFKjMoiRdWSbZ1LgZRhNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969562; c=relaxed/simple;
	bh=GDUK059pKBZeHrxYHmKfn+74LCF9FZgSA5vmAJNvPi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPyuNbScRhwC/rvIuujYlE6k71y6w2tx3PDBZOdbYBmUTECdmaK2SGa+O7/OsUxt1rJ1RfAe7WpxfgXvaa3IHx/kFMD4mgQpZScR5KBXmoFY3FPB8TCPqeXjqDmsLTJqC+g6iWpSyTqx3qBKJuxZN0/kIN6AWUJbdfYXxboANbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqGoS201; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dddaa02d22so1708505ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710969560; x=1711574360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0B2zlqbREuHKOh+t9O0ebnJVeZkcILT08w8oULXcsk=;
        b=gqGoS201K+gQVj+Q8rKhY/CsLmylG8grslOVFq/TUK6uvCNDosnMqldPbVICwWXGWH
         of697rTm8O1quY4Eh1j2Sm3ABLQQEjO56m+it1GnkDrIbQOVOpI7PbMRZfDVwwMtgUXN
         LM7lRf7Ffa1jnOaVTs8yfAFLQPOHmWsTf4eLPyOtT98X3svN0ppcRs/cU5vUG26Hwi++
         ZGAhCEikV/C2ffV+aLdd+fYBF/cP7vMVc9VBqZC4M55bke8BuNCvLs9rKzOvjIQuoMQZ
         Cmc95dMhjn+F89RK35fyGc+aXXcn3VCUxoXYhNSVmSkbDBSBi9iZ5k2iZQO+fvePJkew
         lRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710969560; x=1711574360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0B2zlqbREuHKOh+t9O0ebnJVeZkcILT08w8oULXcsk=;
        b=Cg5bkpWlbk1EQQZNOwCA+eazUiy0BqvsRX2V/NfykCKhA19/snUhTa8VHMJzyKg6yk
         k2HHnlhTRooP0f8jT4aZSQPmRULNVFJAxxcQus1lWYPdnYGByjlMxH9hlGSMvcMHoYVr
         u1MCXUEERCl85DVpkVRgMgw0ctZAvB9KPnD/xafLeQuuh4ac4N1k1V7tTsqXJMuSywgl
         EHUTcvnLXYewtGR7Hjhs9mOvsL+zzko1jaoKYL+d250/smQH8H9OAtb+2/W5j69Mil1F
         sV711K6NI9Piw9yNkzuYbsg0YFEDZkrjLT4yiZUeyHkfgbK/vYW1id1Fd3fYXXdw3aeP
         V48Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK4rf3O6eUKjLbwcAu6jm9mE1tNoPxlp83QlzgLaTS3cdIXB+M4tWZDluxRlaKHVKVI+evmO6C2tDM5xO8Av+PL9DDm+Z20PBx2ms/
X-Gm-Message-State: AOJu0YyemVxDpWWwjQ/MBXXd9OkeD5RIX2nalZ1Er/Z8aubwBjzB/2XZ
	6B0lAlpy15+PXfQw9DGauj8CmKum+K9c1yeO45q+1xdz8FmAgZVl
X-Google-Smtp-Source: AGHT+IH+gkKiUOeFd5TiUgmcx2l6m+eiPE2XIe8uQh/+n91aD2xhd7pGMWQ9YU2OfQElPcvETHjaxQ==
X-Received: by 2002:a17:903:41ca:b0:1dd:b728:b8d8 with SMTP id u10-20020a17090341ca00b001ddb728b8d8mr253646ple.45.1710969560324;
        Wed, 20 Mar 2024 14:19:20 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b001e009717560sm7090751plf.232.2024.03.20.14.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:19:20 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:49:17 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v3 1/3] staging: rtl8712: rename backupPMKIDList to
 backup_PMKID_list
Message-ID: <5d3930cb847fd311afdd16c8fb947133ec49b55e.1710965653.git.ayushtiw0110@gmail.com>
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

Rename backupPMKIDList to backup_PMKID_list and remove extra spaces
between RT_PMKID_LIST and backupPMKIDList to address checkpatch
warnings and match the common kernel coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
Changes in v3: Fixed the errors in v2, built the kernel with
CONFIG_WERROR set.

Changes in v2: Checked any possible reuse of backup_PMKID_list 
manually and rebuilt, rebooted the kernel and loaded the driver 
with modprobe. 

 drivers/staging/rtl8712/mlme_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index b9f5104f3bf7..a009ec1a5c11 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -84,7 +84,7 @@ void r8712_os_indicate_connect(struct _adapter *adapter)
 	netif_carrier_on(adapter->pnetdev);
 }
 
-static struct RT_PMKID_LIST   backupPMKIDList[NUM_PMKID_CACHE];
+static struct RT_PMKID_LIST backup_PMKID_list[NUM_PMKID_CACHE];
 void r8712_os_indicate_disconnect(struct _adapter *adapter)
 {
 	u8 backupPMKIDIndex = 0;
@@ -99,7 +99,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		 * disconnect with AP for 60 seconds.
 		 */
 
-		memcpy(&backupPMKIDList[0],
+		memcpy(&backup_PMKID_list[0],
 		       &adapter->securitypriv.PMKIDList[0],
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		backupPMKIDIndex = adapter->securitypriv.PMKIDIndex;
@@ -113,7 +113,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		 * for the following connection.
 		 */
 		memcpy(&adapter->securitypriv.PMKIDList[0],
-		       &backupPMKIDList[0],
+		       &backup_PMKID_list[0],
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		adapter->securitypriv.PMKIDIndex = backupPMKIDIndex;
 		adapter->securitypriv.btkip_countermeasure =
-- 
2.40.1


