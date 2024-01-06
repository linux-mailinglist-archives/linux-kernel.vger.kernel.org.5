Return-Path: <linux-kernel+bounces-18509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7D825E6D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43071F23744
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2529422;
	Sat,  6 Jan 2024 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="R56tQIzH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAC1FAA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso186621b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520584; x=1705125384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1QdnX5i/KKMIr1vHd0oDppzxPgX4vgJKp2lY3tk4nA=;
        b=R56tQIzHPX4DwdZcnzIpbSHU6VWbT2iavv3nqhq3TBop1GE2kp46wHNuHKjpEDPrSj
         BXHTwPMtb9i5v6IU9BLTZslD9futyag00EUgQOLs9QM4Rm4pJUOQvR/TQgIgd5SBPFKz
         yP2oYYTruaV1qsTeTli8MVP/XKivhsPiMH/9VeRwW7GWBgmhJAyaxJNRPyfcb5yWYPN2
         +ZCNXfyf7mIs926ez9T/FioI4+CQtp926mBaAv9pmSu0hV/wrWH0MRff+xALJjdKmvej
         INrwvGwDyIoX0Gc15QMgL4oqpDzBX8+4tiox+rPbWaTbYBxPdP+2cqApI3vXbVxtTLgi
         IFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520584; x=1705125384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1QdnX5i/KKMIr1vHd0oDppzxPgX4vgJKp2lY3tk4nA=;
        b=p+mnNppAsCLtChZTCsqgTHDgpIyTn+N839WFbA8xOTMp23zFXQw1oD7WMtldJpzSyo
         hjxFt9mMJx8NeBCPN9AUBOajmZLcmWItfsVquHINucE3VxEidTELohtYEcXms4IrFBL7
         PzIisquyNu51O8XiFBLbR9GdkDFitvB3zHu3GunSiOl5VzdYTy4M1wp4opKhTSI0BZO4
         DJiArHLB7R4BfYU15LfaT/vsrr074e60IHsaG+WYQPwTUtysKjqbC1sA4NMOm6XvKFT1
         iU0vXxSxk/1lLD73ffEb5lFjv6P6/tb6quThKcL5ID2WOWnuBjP6AMY6BUMnS7ZCqePk
         5Mvw==
X-Gm-Message-State: AOJu0Yy2DHFcSNMMP1r7jsDS7v8RGFz3xLOWfYrev+1UcKETJPy8JxNP
	CYVbkDNrxsOvD17wDYpAjWW4poJ8RYFuVg==
X-Google-Smtp-Source: AGHT+IH0k1clmb4jvrGZp4/DBJjbFE52fY3Re8LQXd9KgAYP5jl32F18rb/l8goA95Tj/VarVRK1dw==
X-Received: by 2002:a05:6a00:3a23:b0:6d3:ab53:367 with SMTP id fj35-20020a056a003a2300b006d3ab530367mr842891pfb.33.1704520584716;
        Fri, 05 Jan 2024 21:56:24 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:24 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 19/21] Staging: rtl8192e: Rename variable PMKCacheIdx
Date: Fri,  5 Jan 2024 21:55:54 -0800
Message-Id: <20240106055556.430948-20-tdavies@darkphysics.net>
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

Rename variable PMKCacheIdx to pmk_cache_idx to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 5305486c9594..533af4b28aa7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -700,7 +700,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	unsigned int cxvernum_ie_len = 0;
 	struct lib80211_crypt_data *crypt;
 	int encrypt;
-	int	PMKCacheIdx;
+	int	pmk_cache_idx;
 
 	unsigned int rate_len = (beacon->rates_len ?
 				(beacon->rates_len + 2) : 0) +
@@ -748,8 +748,8 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->BssCcxVerNumber >= 2)
 		cxvernum_ie_len = 5 + 2;
 
-	PMKCacheIdx = SecIsInPMKIDList(ieee, ieee->current_network.bssid);
-	if (PMKCacheIdx >= 0) {
+	pmk_cache_idx = SecIsInPMKIDList(ieee, ieee->current_network.bssid);
+	if (pmk_cache_idx >= 0) {
 		wpa_ie_len += 18;
 		netdev_info(ieee->dev, "[PMK cache]: WPA2 IE length: %x\n",
 			    wpa_ie_len);
@@ -878,11 +878,11 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (wpa_ie_len) {
 		skb_put_data(skb, ieee->wpa_ie, ieee->wpa_ie_len);
 
-		if (PMKCacheIdx >= 0) {
+		if (pmk_cache_idx >= 0) {
 			tag = skb_put(skb, 18);
 			*tag = 1;
 			*(tag + 1) = 0;
-			memcpy((tag + 2), &ieee->PMKIDList[PMKCacheIdx].PMKID,
+			memcpy((tag + 2), &ieee->PMKIDList[pmk_cache_idx].PMKID,
 			       16);
 		}
 	}
-- 
2.39.2


