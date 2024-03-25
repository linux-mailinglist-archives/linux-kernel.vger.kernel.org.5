Return-Path: <linux-kernel+bounces-117636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B488AD8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD201F3EC78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4029427;
	Mon, 25 Mar 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTm1X8nJ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55E1F60A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388956; cv=none; b=VgWAhbYgqButzED4C5Q+sCAypd50NwECuqg7rsEL72X2SZEhr9Mu1NVl+q3KZzUnCOQtshjKf+V+2ZltHnj3snCTW4BqB7VAx9C7F+UgMkvNIj7B5BUXlJr8skpDy6aOc7EtuisOpCiXXInghWaoANF4Tc0ERCie9mzAc+z5xlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388956; c=relaxed/simple;
	bh=1O2i+z9ec5worg89eWFtLCmRb7aXmuCsagcLEDtkmCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPT0Nz0dsqk6JQ4TlOy3mic5XBWkDkfxbO377jLdYgHJDYqsqAwhByhCs6fcfton5vhHfqHn0pepoGMgTW/6cBVZbNcdmoWdI/ZwYnpIzkxCaLraLc6TsI76LmPQdsFc+n9Rhl7acU9Jucdie7iOEPhiB/SRvPDJFjrD0ugrkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTm1X8nJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0189323b4so34605475ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711388954; x=1711993754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lnLG30Vz/3lGDQ/KrylGmjWUx6Db7eT1RcS7bbD5KE=;
        b=iTm1X8nJQ96c+kvMHo8f7dIVuufqd0GPNULRBBzDV+B0p13dms7fIHMBGHen4yRGO6
         w2+p6mb/SrUu6+L/4PUjTh6nsl8JvnPLPZJX8SgdRDOtG/RtfmDJTHp5jviOgGbU7N1U
         Ijp9klX8bnZogfd9HTWv52V6ukmqHrsAb10UByHLXPm/ZW6ysBVYsn82Dv78O1ZFBaCP
         lFFW//EwVczQxVrug63kmcRvI4Ba9pGIcGHkB9YnPnWEwpfouy5LtI70uC5c9muyE3yf
         T8T7UESfqKbba/Uzmnbxqzx5dhwnmstwIhIfZv9phGNv9bQFx1aGT6J4CpVGfRQwNiyP
         4RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388954; x=1711993754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lnLG30Vz/3lGDQ/KrylGmjWUx6Db7eT1RcS7bbD5KE=;
        b=k5Y3nqb71lcKvouJ9mKPR6B4mq2TPDEh2AT3TQdfWb3OZs62C25LwXemLKiUWgpkDB
         qsRNE3fAHJcOjPnr8q8ipFegs29XTralgqRFNnOAWsdy2EfE7+gBPyC+dexwdMwBAonC
         nrHkmSSqnkT99mCFM2TK+quy1Ywg2fkJu63XLYPVdaiPc0Vtr8mDbVs6z/xupkBSEXwz
         IzMmdoC73Wlz50ahhJ4DdeLLRIQkEZ0V+a5vAt/eL0kfZyLpMPMCssLmonZonhn5ZJnW
         6Nn55l4K4HE5ytdF7IPQzSejw+rKEbma08F6a69ODt/Z0zbhfdfqiZL1cLxnBZ91gPIb
         frfA==
X-Forwarded-Encrypted: i=1; AJvYcCXS0GX53eTgXSQ2e/+C9sB9NFQPGi7G3JzmQJ343RfopAhM0eR64HoJYEwoQSnoSzIbwT8kSb67hAT5AXUwnvAF1o3GsGyuGARenrTN
X-Gm-Message-State: AOJu0Yz2FelGQJQbFyAQofi1LUmnW6AVjo0qJpn/HkPK4oJG7L5HeHi4
	14camT14jSgjRXT5D26o/PLIsjb3ZWV0DCjLWQx/sRc2GpjZhCrLBEnLRTnz+FA=
X-Google-Smtp-Source: AGHT+IGbL0wknT1iGzMMPJyvG9LJToHnRvRU96heKUlxYnKSn6NiyZtkDnGi7d8f/HExWMsAw4aLJQ==
X-Received: by 2002:a17:903:22cb:b0:1dd:bf6c:8973 with SMTP id y11-20020a17090322cb00b001ddbf6c8973mr9548449plg.68.1711388954182;
        Mon, 25 Mar 2024 10:49:14 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001db5ca97817sm4920410plg.68.2024.03.25.10.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:49:13 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:19:08 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4 1/3] staging: rtl8712: rename backupPMKIDList to
 backup_PMKID_list
Message-ID: <5d3930cb847fd311afdd16c8fb947133ec49b55e.1711388443.git.ayushtiw0110@gmail.com>
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

Rename backupPMKIDList to backup_PMKID_list and remove extra spaces
between RT_PMKID_LIST and backupPMKIDList to address checkpatch
warnings and match the common kernel coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---

v4: Update the changelog to match revision history
v3: Update memcpy() param to match new name backup_PMKID_list
v2: No changes. Just a patch sending error.

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


