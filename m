Return-Path: <linux-kernel+bounces-80490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AE38668E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588231F2284B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136B41CAA1;
	Mon, 26 Feb 2024 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="kM//mFbc"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C01C2AF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919797; cv=none; b=pQppIE+1YXYTJb8jLFpyw3iycmqfJt3GRrpzD1+GYE/dbn6XmQWrrX9K/U2T4ERX3MRcH9uFCIoKzB+4FrpimqGsx6YAclXhh44YqdCtcr8qUtEqEXPFNHveoyxPOdfy/xqMc9J0ttp8J1kUVOQvJdPUMJ5A85woLLY0p97dnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919797; c=relaxed/simple;
	bh=feRmvYGb2I/8Joqfn39hSQRLq9jVSX6Ip8zqh2pMZww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZTm2+bVy4D5CEea9UjK4oKpAF0WOBahO12zU/WcjOpDAjQq3KAS2bCUwxUdCjMyMVQLesppwCFLt+yHLU4DE3vsa04nCh9Tptr0aIqERCwFwDAWAb9BMPfTMEfschADpEjepRkQXByJnrub35fZ7Oj+83dBIbeB3Zibe4uyOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=kM//mFbc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e4670921a4so1317763b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919795; x=1709524595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHZ4Dy1MrJ8rtOqk9em+bLvh1hFQIoUwHqrhLCKwAIc=;
        b=kM//mFbc3ahqBzkBHt4rzGcGRI3nUr5tUawOEMEei3hsHz7xI4AzZdXh7HmTzHjLCE
         RwPsr4rZiZYaP/QrXoaxMD+IGYj7UNeKSLPKA886jTpXFb30BL1U9xSKYqS5h1tC+IoJ
         wPfbdW25s7VB1QCiqOBrhz4V+0aSk2fclNQydpHfrG1v2LgFRmTu8twR/S3J/PlB4rEq
         bz4gWcC2nm4ty+B1ZO5w9R0/zKTZCwjtz0s4bTpkmCO/0OHy4l5VSvWXdhsNUl4gKn3a
         uown7LZeDRLc8Kwnk0FZquImUQVeIX00tBK+iWFWipgw2tf6byBMuZjOdon7PJJtFkW2
         FMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919795; x=1709524595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHZ4Dy1MrJ8rtOqk9em+bLvh1hFQIoUwHqrhLCKwAIc=;
        b=bNnn1iZ1ZXWIoB/GkP4W8mJY5nr03GUuf+L+IMoIQpKQuFhn44fZ5UHy8bsOj/nuxV
         ye24NRM9knZtJK/smr4Z3LHckYDhqLo8/IAEJud2QzOAtEmfAzjPkJw8SlY9iPdXslm6
         JOYdkAwYERLCGjhhtL6F8PwfUpcHYkI5MnYkU845HVTVtzo1NNnyadDefu8QT+hvzkmT
         qoHqmZgyyRE6TLNXSt33JciwKiqKYMUzkK7rJa93oBbfglZqFKknHIprHG4hUTn1whIT
         rrSaAA4+7QuAJx3bDtODjBsfiQmr+KKg6E2DaJIvV0v3/KKHMblB2OA8EkK34pExQgp2
         PO9A==
X-Forwarded-Encrypted: i=1; AJvYcCV+axUiTeJJPnqg5rJ3ujkPLl6QUQ9sTp42sakbO53fgbrpqaIDNIJA1C1lRea1/+LWS2VuX7sRu2PPqAiSvlVHEyXvn1PRsc+8S5OF
X-Gm-Message-State: AOJu0Yxay/6d6cEFYM/WlwwQEMxYoK+oEMebDyZAZPeQCjUKpwmkP3IG
	U6Qh8KFBQlc3p5B1V/SmSWQoWK73O47rbZJ2+yle+Lt+6rVSBnZnACuSPFF/Ybs=
X-Google-Smtp-Source: AGHT+IF5OZ29RGlYUvjMLdVi1JSUJb+EpyTP+DluLyoXRqkNeISIJ4V/b3iwMPxiw8DdFtwP1vsqww==
X-Received: by 2002:a05:6a21:920a:b0:19e:378a:124c with SMTP id tl10-20020a056a21920a00b0019e378a124cmr9105913pzb.12.1708919795170;
        Sun, 25 Feb 2024 19:56:35 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:34 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/20] Staging: rtl8192e: Rename variable bCcxRmEnable
Date: Sun, 25 Feb 2024 19:56:12 -0800
Message-Id: <20240226035624.370443-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bCcxRmEnable to ccx_rm_enable to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 8 ++++----
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6cab19b03f4f..9ec4a3b8ae3c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -929,7 +929,7 @@ struct rtllib_network {
 
 	bool	bWithAironetIE;
 	bool	ckip_supported;
-	bool	bCcxRmEnable;
+	bool	ccx_rm_enable;
 	u8	CcxRmState[2];
 	bool	bMBssidValid;
 	u8	MBssidMask;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index cdb7e87c0c89..103117692a88 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1818,9 +1818,9 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 		if (info_element->len == 6) {
 			memcpy(network->CcxRmState, &info_element->data[4], 2);
 			if (network->CcxRmState[0] != 0)
-				network->bCcxRmEnable = true;
+				network->ccx_rm_enable = true;
 			else
-				network->bCcxRmEnable = false;
+				network->ccx_rm_enable = false;
 			network->MBssidMask = network->CcxRmState[1] & 0x07;
 			if (network->MBssidMask != 0) {
 				network->bMBssidValid = true;
@@ -1833,7 +1833,7 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				network->bMBssidValid = false;
 			}
 		} else {
-			network->bCcxRmEnable = false;
+			network->ccx_rm_enable = false;
 		}
 	}
 	if (info_element->len > 4  &&
@@ -2351,7 +2351,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->bWithAironetIE = src->bWithAironetIE;
 	dst->ckip_supported = src->ckip_supported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
-	dst->bCcxRmEnable = src->bCcxRmEnable;
+	dst->ccx_rm_enable = src->ccx_rm_enable;
 	dst->MBssidMask = src->MBssidMask;
 	dst->bMBssidValid = src->bMBssidValid;
 	memcpy(dst->MBssid, src->MBssid, 6);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d3837fa2c859..db1a47ce3528 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -742,7 +742,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	if (beacon->ckip_supported)
 		ckip_ie_len = 30 + 2;
-	if (beacon->bCcxRmEnable)
+	if (beacon->ccx_rm_enable)
 		ccxrm_ie_len = 6 + 2;
 	if (beacon->BssCcxVerNumber >= 2)
 		cxvernum_ie_len = 5 + 2;
@@ -837,7 +837,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		tag += osCcxAironetIE.Length;
 	}
 
-	if (beacon->bCcxRmEnable) {
+	if (beacon->ccx_rm_enable) {
 		static const u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01,
 			0x00};
 		struct octet_string os_ccx_rm_cap;
-- 
2.39.2


