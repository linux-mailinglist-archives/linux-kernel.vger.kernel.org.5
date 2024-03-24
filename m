Return-Path: <linux-kernel+bounces-112842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55789887EEB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A30F1F2114E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA29101E6;
	Sun, 24 Mar 2024 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZfviox5"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BC19BA2
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313397; cv=none; b=qNeQEDHRMTheBOn/By08BUVpXSfqWUepv9zpHa3mYX8kCm10FSsv/V/CRsag/jbJh8wRKbxDhg+hcwP1X+CapK5h8Evrd4VdfCFC1Y5VhLI0kuW6PTwI0Q/ihHSeeZTZ0V13z7pgAlizsxNDroDT4I3eq7p2Q54315eLVeojUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313397; c=relaxed/simple;
	bh=1O2i+z9ec5worg89eWFtLCmRb7aXmuCsagcLEDtkmCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4piDA52tal7GaICLTg3KCljG4IjJW4DAaKExeBQJXwFvK1KiZCUjxj/V8mak5sDWtE+Fpvpi4IuEt0cLmkf4Q1jyMtU8txt68C0cbr+WkDrmhqRbzbPcGLlA/LYDt2FB+o2Ap/uk6c/E9P7xEKwgOal0aNhMg6bX06izEeb7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZfviox5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso2588915b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711313394; x=1711918194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lnLG30Vz/3lGDQ/KrylGmjWUx6Db7eT1RcS7bbD5KE=;
        b=YZfviox5ddECp9z6PFuuHX3JXQvfcTNtEvYxPd/9qniunPaVTU6cLdJ8UjVbitzNlG
         57K0z8b1vjW9lXRt5J0g3tkmRdGeK461ur1KdCEmB/ZrsNlx8H4Ao9+cziITjRJC7/Gk
         /z2xBE4tMtbjRAlpUUMGYsKFV9Owyz5NSZ2gq4zeCB9qRpFUBBXUOwrd2rhy2/lbUh6b
         j4FtLiH0A6dnOM1hTJXHde0qnIaSc1C5f/YCXQw+0DCPiIijE9U2cN740fHzHfCIMGuW
         bg17/RBsFtIDEfNtEnEqyjuI+PumGjFkjtrmVmRjYUEvcTQIq5KEodNfWI8fWWuEQ9GO
         suBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711313394; x=1711918194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lnLG30Vz/3lGDQ/KrylGmjWUx6Db7eT1RcS7bbD5KE=;
        b=GlDMyK00aHXK/5dUpAAD5RvwyEJC2yk2xYCFyNlS7/rh1dxAmESRh2ifhdbh6wXZIy
         KWoqu6Lo3YO2pkqGArx7ATruqSXLu3ahmULnGSQlvjTl3+Mw94ajSsUM7awBHEAvlAao
         GQS9byQlmqHpI4rp3wKmfrEqv6ZNXevhwQiKx6seBmZkpYpYyfrsqHr07fI23d9HHr9u
         S9uvp6bA2mn8S07+8C5ODkxIC0Z6shJgcXTAH5MDEX6N3/fWHqtq1ukbmKL8Rj+GCwmZ
         lbI7f897O9IRvhYczgWF4gVtJw2hi5YlK5vuF1g7f/fOCA7iTNcsHo6LK7tDKlOSK5hu
         aSWw==
X-Forwarded-Encrypted: i=1; AJvYcCWreA2p8BFE6PYnNy2iElOBP+tyJUCSEe8Xo8lgXxU2fUgzZERNqiTPQkAU76dMzNzgN1sI9u2XJYRoazI36dRLQgWM+sZGI29c2Kzg
X-Gm-Message-State: AOJu0YxuT5VXXWIcNtmMwFfhU3Zq0gnucHBtp9H2RqlEclq696yJVy5F
	8llHIr14wijgSV+zDVkqYERVaE+B6VabkCzJEqvVizZkvejSywQs
X-Google-Smtp-Source: AGHT+IHLNE1psXO9z/vQGNfZSPapZDrgcXSfPVt5sguaQ7O8BUVBYq/u/3Dec0Gnxb8pCOiObp1lhQ==
X-Received: by 2002:aa7:88c6:0:b0:6ea:7f6e:f451 with SMTP id k6-20020aa788c6000000b006ea7f6ef451mr5543305pff.1.1711313394444;
        Sun, 24 Mar 2024 13:49:54 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id c6-20020aa781c6000000b006e7369736dasm3010066pfn.74.2024.03.24.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 13:49:54 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:19:47 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4 1/3] staging: rtl8712: rename backupPMKIDList to
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


