Return-Path: <linux-kernel+bounces-112843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4A7887EEC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB97B20BF5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3E199BC;
	Sun, 24 Mar 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpIcGpY4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670B0FC02
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313498; cv=none; b=fQvGWHuoriMEo9WFd35M1jN8jtHQBrSLBtMPMkYW/yvovsq3Pd1kAhKfr3bRMaYd7nxZQ/e2UQWzJ0+BpoDxoYEv7xfj/N77KfRXVkl7ytp1crmiZxhaUpjRUli62s4FvD+K6vZ9mjgHimMjiB5GlUQ7sNPF0EM5lbejmn8tGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313498; c=relaxed/simple;
	bh=xbED7VUAQKgIJuZaHw9k54Q7oJJJIBBD9cMqZQxcZv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL38n6PtLDPyDpej4KYKZUi6amrHOFK87iZvz1Wgr1EJCmO2kEjnOw0tLnjD7oW++ixd3x/KsXLedyjeDeLcboXs7WTHen+RtNKjU50p0U67TRkBo8JMfbT4RP80F8453S5UxFt4TwoDD1AJLCljiRPD7OjLlgrsyNFcSJq5eJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpIcGpY4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1def2a1aafaso22115765ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711313496; x=1711918296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qghiSz7D9sCAzbkITRm47/uYLynPy7bJABS0ecPLalc=;
        b=GpIcGpY4HaS8sZaZeZffJPkrIFvOFbMmZfwSmDpGV/9zcXxHidt5p4uaiUduJSiNGU
         sb8c+YTWWOkUVTsktPaJuodiR1qfRUq/9edR+Nlk/mJq06nYiLEo4hhoiIRoF7X5Ykv7
         mMSOzBDgKgQHiHOk7UUaUSJKLD+fB4xM0ViQOb3rGFPMAZHFzPBZPNEuUmiktz83+MXA
         gTSh3we81tiDxR2n6DxxbRnwV/RM9rWSKXvG513QrMZzeXEWzReBc0yqDB+T+/QYBUys
         4G7VpTyQObrVjdzbWrczRN8eMCRG/BODc5JXRzKsZ7l7E6ZOcv0DMZylUlsh3bWJi0DI
         p3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711313496; x=1711918296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qghiSz7D9sCAzbkITRm47/uYLynPy7bJABS0ecPLalc=;
        b=FSUwkK9+XNVq9saiosLa7l4CzAz6/E6HmBX0ujCJIazrhKAJDccrCnI8oR4zEdCI9c
         Df1AiAZn73DSf3DZgg7ixINiu5C0Igxu8Z0mndNeGtGAwOYCh7xPIbVlEGQIIbNtwtkm
         Qa7snvxSaLGEJ+517zJPFb2CHKQPth66LVxlslBVeGw3lUBpcj59qNMbRBt0G/9plF4i
         Yf0iRy3ixMNVmM2BAbweJcD7y0FVJdhugRJ1NmJAM8Mh0SJdHpCnqlqp+AJtvNdrjyEu
         9sgWWh5xv0DkdYWRqXOr3iXLav+zpxL+ZK68FNP9bkPF88DSvDzY20EKD42Pd/pKPnHR
         mtcg==
X-Forwarded-Encrypted: i=1; AJvYcCUroCrF3mJ+Jg714aK594iRAdPq/zdepCdwKBzb12vo1Fpa5kd9qjIiKNgYS7aPlpkgeJnJ/nZv5bT+8zWZgrv/KC6scxZexE3yjyOx
X-Gm-Message-State: AOJu0Yw/1PWlRoY0VsVo4xRuYzNRpSFAvhfVbZQbSdNN3dOrneCAjHce
	krunpvX7i6uUobqDDA14EZJ0DJ7DtIAyILMqGtRj/KP5l6+s4o7htgXxE/a31kg=
X-Google-Smtp-Source: AGHT+IFT3itD9WwTTd7aLXWbH8yVFWJ0LSVdFyz60u38dLBPgfQXpDcWGXYwmEmAHYX2ZEgXsRDTgA==
X-Received: by 2002:a17:903:26c9:b0:1e0:27c8:5c7e with SMTP id jg9-20020a17090326c900b001e027c85c7emr4804997plb.25.1711313496611;
        Sun, 24 Mar 2024 13:51:36 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001e0c568ae8fsm64157plx.192.2024.03.24.13.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 13:51:36 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:21:30 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4 2/3] staging: rtl8712: rename backupPMKIDIndex to
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


