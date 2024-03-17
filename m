Return-Path: <linux-kernel+bounces-105518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EE87DFA3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B158A1F211D0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54C1208B4;
	Sun, 17 Mar 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaMfrvBO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34C208A0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703647; cv=none; b=Ld0jyU5Hue0x6rWKeqV83Rh+kxSv+pW5qYMD1TYBrM4gkpD50GL7P6iQZdRNPvPZGKWl+2KBaIAHeT8tlpeVNj5h91usY1BxgPW44wFPeYM4qXKnYIDUHj35FBqp8iijxhgcRNflLmAzbGRN4aXpe7oidowlvIeYHYasS7qwC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703647; c=relaxed/simple;
	bh=xPWoQOs4TfwooFLDZo4ETTOlpvvvuG+yA+6t3NeCCH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb4cNLissEQ7eCbSzWviR1crtCD7wChENWSF7IW1jTGSIwzgJRTJlirisUBpJZGpAYq4Lp//gf5BOXL4Nb+a+z3BV94GrnKO9cK0QhoDJR52WqDBmqi801QcrZLOL/FrH7OqA4zFWSmUXIBWK1CFxzn523RMhjr9ZTIp2tAPcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaMfrvBO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1def2a1aafaso11906295ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710703645; x=1711308445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zO2QsTVjpffWTan4vJBt4m5gR695Y2a63wY9pQvTlEg=;
        b=GaMfrvBOW5bVaZOzM5rya2XL92wNaXTT9Bek8UtufWERHfn7he2DbLXD5mQv4qYaNC
         Tn82iE6MdslV75AK87zA2UehBTGpViVyqG0CDmqFANnkLaQuZV7314Q7QV8wKXCqHTMy
         /CLw1qwsvNf25KvZVBYyEhHat3T5h8uPeKc88fcYcsbVq+xpn7s/aKU8Cwh6JHpC8GRK
         gPeV5Yff69QsNVTj5Jb01Kwi3uH1uWLdlk1GoHSjm2ABLyIeifJ0aTnEz/1qcp9pFeq+
         cq6VV9pUcTIiNjlCrfR3wikIZQPnyJWd3tzSiknSwKXqZukJjfTacweF+umXCtqaSxfc
         NS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710703645; x=1711308445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zO2QsTVjpffWTan4vJBt4m5gR695Y2a63wY9pQvTlEg=;
        b=DSRJy4tRjpT0qz1X+xb2Rr19Xtzbk4uyiSPCQKsNRUZ09m+nJYu4e0YSJRFtqPfr9S
         qFSSwD9BaZYM1V5BzHZHACDWIhbIoTfCuDhp83a1UpPDJPzxd7CcyR9KYF9XNdZlZ0sK
         QCYov9c4vhCNJYX/pAnWDM5hXKbwPPVb/tKOkaz8P1t4SUe09tTWgvfj6n3fN5agenpP
         OF4A9OPCg7UCNuiK1IxZn+D22UKm0e/ToVpvtDSYFBuUvlHBPreE9yDK2DE1lYvMrkH4
         XMngdd7+jnB6b/CfzcrNhGpa3rsoHlsbZavXsrWXlG7JCHiZiGuboIY70S5KGGfOuY6H
         2WVw==
X-Forwarded-Encrypted: i=1; AJvYcCW0yJppyT+FkTX7qd8M/120KW5mQopYTc0Btik5jyRirtKlaz2jONoS7YT8tca7F82LteemmfxUPXUJlRG5wa/UmoMGt+dNj77I/LHf
X-Gm-Message-State: AOJu0YxK+aJ31Nj3N4cxRbzAQGHiUKl3rqXco62EZXm6Y3TH1Cb4XYI1
	hnCh2IaAg26thB2f2pG3xCEI4qqHLrbgpkJT129eNosyBjXsqeygf7Os5r7bCIg=
X-Google-Smtp-Source: AGHT+IHHowoa/TnHLcot1PK4Nlzd5a5XlR0ctEt+JQFctj+YKf2JoqRVB7F7XsmQAmm+Ojyv7SqIGg==
X-Received: by 2002:a17:902:ea08:b0:1db:55cc:d226 with SMTP id s8-20020a170902ea0800b001db55ccd226mr8526738plg.66.1710703645010;
        Sun, 17 Mar 2024 12:27:25 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001dd59b54f9fsm1928417pla.136.2024.03.17.12.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:27:24 -0700 (PDT)
Date: Mon, 18 Mar 2024 00:57:22 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH 3/3] staging: rtl8712: rename backupTKIPCountermeasure to
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


