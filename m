Return-Path: <linux-kernel+bounces-18501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF91825E65
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72659B237E1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC8E573;
	Sat,  6 Jan 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="hihQnpIz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFDC15F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso103853b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520577; x=1705125377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTFfC6a6+CdPfuYQ6OOPrqm2TNcAcxQiTaVsILJFR48=;
        b=hihQnpIz5SLb9TY1W7R/6G9Ge5PDNuCY20owvm9pJkP/rxXq8kVSP+toby4cNdJKOK
         w3QozRVfcuDXee7vBYD33f2L6kC/wC/01YAXXV7b3y7WImkp95rZooS2B8lLetqXb+nk
         gwrOrLLmPWw4tkpkOne3aImtertKAFPp2hL10/cRjDyi7pPDtQz85kb3AReA2hNzhNDD
         jHV5ukCFJFwHetJf9t3bnO25MWJ0mks1r11GfGbnxXKwfCcLjzKJlPwOoRAgulxbWuet
         S83hOCiED+e/cvU4kQKnUNgUO1wC7up5bGStPxZY2QGhdu7pOn+jGIzBRsxnqiPaLg7H
         bXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520577; x=1705125377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTFfC6a6+CdPfuYQ6OOPrqm2TNcAcxQiTaVsILJFR48=;
        b=cH5flhNY6pSFAtTb+xp8ZGfd9X0nL38NhKkqe4cSuGfwawWA9KgURkwqsEIv1XGHsW
         4ZFDlp09q5sNHhgi8tDyvHtsPc4MOvt+RqtE5f968PiwSE44PgGOob/wRaeIPTHCVTdb
         ns5YMQ/YP3Ith/vWQfQwK/ita8Q1fVZvZwTR2nadlEZPmwtCifkuQxB5NkAwFSMcPYRo
         2mnyj88c4fCKMbeAsYMMiRbq+xKcgGaD/qV7PxAMESUuraklvdfPOE84rAEx8ZoL40aw
         pkYU78x5xVpV7z/q7GIq99tI/8xhTJ7tcsfeMVF2RuP7CU/esDJSSlbKhAKnHyh07I4K
         HJeQ==
X-Gm-Message-State: AOJu0Yxd96kq83IXV2SC9x7Cw+rluoMEaQdqXZq2DwQvLyzh1a5GurSB
	hcGXrY+yC2gl+KYQ0YzraCRolnBRj5x30g==
X-Google-Smtp-Source: AGHT+IGxcLHolKb3fWB6F0W3lmgR06VsfPutLh4diwag/oXBpU4yoCXymddOT/bx1gTLlEOqcwj3qw==
X-Received: by 2002:a05:6a00:1306:b0:6d9:abde:a803 with SMTP id j6-20020a056a00130600b006d9abdea803mr161631pfu.34.1704520577416;
        Fri, 05 Jan 2024 21:56:17 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:16 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/21] Staging: rtl8192e: Rename variable array Bssid
Date: Fri,  5 Jan 2024 21:55:46 -0800
Message-Id: <20240106055556.430948-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable array Bssid -> bssid to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 35c66ecd20e6..f379819287b4 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1161,7 +1161,7 @@ struct rate_adaptive {
 
 #define	NUM_PMKID_CACHE		16
 struct rt_pmkid_list {
-	u8 Bssid[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
 	u8 PMKID[16];
 	u8 SsidBuf[33];
 	u8 used;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 98c1041214fb..8fb69fa09cc2 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -671,7 +671,7 @@ static inline int SecIsInPMKIDList(struct rtllib_device *ieee, u8 *bssid)
 
 	do {
 		if ((ieee->PMKIDList[i].used) &&
-		   (memcmp(ieee->PMKIDList[i].Bssid, bssid, ETH_ALEN) == 0))
+		   (memcmp(ieee->PMKIDList[i].bssid, bssid, ETH_ALEN) == 0))
 			break;
 		i++;
 	} while (i < NUM_PMKID_CACHE);
-- 
2.39.2


