Return-Path: <linux-kernel+bounces-161612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05F88B4EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5DC281937
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514CA1118E;
	Sun, 28 Apr 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="F3oTmI3T"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88A23754
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345275; cv=none; b=dL0IVWfwDrBQmz5Ca2z9DFmOZlHn9xOPaP1xJko6O0VA2vox1ocp/uqqCT4AtKHnVtQCUCP2VgAUYhnBtodxKE6j0MI6X81QVdAJd6HvW6YwpgVH1SF6Xb+knOjolL7BNDyZLrke7hPUN4q5eexiqQqmIR/35lC8vFWam4ccP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345275; c=relaxed/simple;
	bh=VjSg2a0zESUrQlQ7UqqXoz3ZfIq6uHR65gp54GGKI+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BN+qD5BOyU19Et9k7bUNck6H6Zh6u/Z7rMzulqQY3HfdA38fVFtOMaLyOgIWawRfOqtxEAfMEJx8HtsQ7ycJeRxKTCbOFR974bXTU0C4NgfjMV2YpHGkwL4h91DjsP1wE/grNI6xps75YoWchnttrfy6YZrVMf2E5mW8etsTqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=F3oTmI3T; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6001399f22bso2622598a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345274; x=1714950074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkv6fQ+rdTI8d1Fd3FEdWOYYHkDKSt1pFsTmB15mOUI=;
        b=F3oTmI3T9HH7DSovc5xaFOnz8MSLIfXHdm6pqCIxrCDedcNMm7jAb9Oy2EkGJTYBOv
         HNMPId7nMSCPiwXvkjDEPhBv9XWN5UMSUczA0oGX8zUf3MYnAv0I3SGWZauVzG7HUwfs
         rKkLqri0npPt9hpOYL1lpUmefufPV9ZiBsOClkZZbdDVDzucaGjUpWcjtGpCbDpzmEaZ
         Nirq9MxBbmUAJjrgF9aW5VUSdim9rQ9dW7zvkixYs/4Y1oSafBdVgL5eUqPFdc9gfUFN
         wjaG1HGLnKUZh+RASxESWdueJBsTaOaMwxQBrKTGct0t4v9AMg+RYTd7dDvv4Cyvpgix
         bK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345274; x=1714950074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dkv6fQ+rdTI8d1Fd3FEdWOYYHkDKSt1pFsTmB15mOUI=;
        b=L1CC4mf6ZACxsAFuVqGRtsiA+VK7HZC6ued9abxLVIUOqJ/A7SI/VZDT0+O3jYUsJM
         GwwmuWVOZMP6RlKUhdhy2dGwB8pmuHJ4TdIIFmTUIPZ4Iemd54XP7yLFQnR0bETxeiFB
         Y3f/vtQswy5yLZCN86tdrhMOuEiO2WCv3CkXyXzJSXuaRmmJNuaB+9EVJWxXiPeDhuvr
         SccFXO4M2u+TY6eqDuk36pIe7BztNQQRR0sO95Jpngxf0KDqPwSk2foRq9Nje1tTD1DT
         CKMtfd9uZcgwYpHqcc0JhlnzoMbILx8eyXsc9CKE0OQVoFyloyx7Egqyrxxin2OcdEq4
         3vRA==
X-Forwarded-Encrypted: i=1; AJvYcCVNNPtIt8gUhmJhPaFudR1GFknSYtxAPtqZcOPwVeddlg7Pph22iy2M9wouJJJ3T5gdCBhlKv2xhFZxMWbtfco/SwrFeNKU8XvclST+
X-Gm-Message-State: AOJu0YymI/79grcQML0L+6nGpiM+HWO9M67LTcBYW3s3aMLDwgX9yI2m
	qKgu0yhb4MfE7EZxQ4w2CYqnKT3Xf5TMrGM8A9toQ5pnM9ufUtcYO66VblYIMQVZuqr0ZUgaKM6
	S
X-Google-Smtp-Source: AGHT+IGDkmjZ+2iDHDjqNo4usnK1Li7Vh3VXy93nGUJmWpm2zxMO8iK+AB5KltTaSHEXqYCCpb+W1Q==
X-Received: by 2002:a17:90a:654c:b0:2ab:b480:5018 with SMTP id f12-20020a17090a654c00b002abb4805018mr8648550pjs.34.1714345272260;
        Sun, 28 Apr 2024 16:01:12 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:11 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/18] Staging: rtl8192e: Rename variable LSigTxopProtect
Date: Sun, 28 Apr 2024 16:00:52 -0700
Message-Id: <20240428230106.6548-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable LSigTxopProtect to lsig_txop_protect
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index d8fb2bda91e4..7e0f64df01ea 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -37,7 +37,7 @@ struct ht_capab_ele {
 	u8	DssCCk:1;
 	u8	PSMP:1;
 	u8	Rsvd1:1;
-	u8	LSigTxopProtect:1;
+	u8	lsig_txop_protect:1;
 
 	u8	MaxRxAMPDUFactor:2;
 	u8	MPDUDensity:3;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 837911934462..503ea1e92a7d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -268,7 +268,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	cap_ele->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	cap_ele->DssCCk = 1;
 	cap_ele->PSMP = 0;
-	cap_ele->LSigTxopProtect = 0;
+	cap_ele->lsig_txop_protect = 0;
 
 	netdev_dbg(ieee->dev,
 		   "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n",
-- 
2.30.2


