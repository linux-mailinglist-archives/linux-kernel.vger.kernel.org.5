Return-Path: <linux-kernel+bounces-161608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D08B4EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54D02812E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D322338;
	Sun, 28 Apr 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="WLUFGZ8P"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82D1118E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345273; cv=none; b=ndrWdnp6Wv9e8Pf0D6N1/841S0hBokdJR2QYQ7YiZZTOoio8Sybl19XJUwPzFGSeKAjDws5GkeliwARV8cAhNi10LuLeDEwzGpohvoZ9RJ64C/tusrnSQba4GzpWM4VxQR7qOG2fdL5BPp+i+/+zq4rZ2GU98ZvTob1gOdxsLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345273; c=relaxed/simple;
	bh=l1N7ppwQAFsdyrxlamyLKMlCpeI3ctv4JREfJWzeHj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2fglepnKMmLF3mWkOGnSTaKEprAeedmrhoNW3D40x8dSgWZYNLXvb7PhFVHTRezh/glDyldpzE1xj4jCEov1JZ3NPyLEaF7Uvoh0CPD0rjg3Tgmjoi/2AEozwN2d2mDVtsp6Q74jKB7Wta5xOhEg7DfEIQMR84vp2PxIhmHcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=WLUFGZ8P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3ca546d40so32207175ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345271; x=1714950071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KENCVx6uegL7ew41ijCYKGsXuud/xPQNe/tRNshJuk=;
        b=WLUFGZ8PtRNmlgjPPh6i5y1IyJ7JbHLG3WBXOJ+teFzU2d4NAr+H6wSI9ST1fEcsov
         8xMhCyRPHPz5b7W/LhzRlUNdP0xc3od3oulDUQUHe/5Tlbx3Zsn6eL/cw5avb+cGL36R
         fa55xR0DpC6ywFDA5qJ5JbBT3LWquFgdGoNd0GG/w0OIJm+4YH0dddmp/qPYDF+dEEcA
         EdDToAI64tYniUtIGtn6XP/Nclpn/CyBxwttf1eDXfr2cEJDHsiBwiF+1ebELMPc6oQi
         ECqZZ8IIWhEL7DIw3ma/eDRtUHaFFm1ODFAvr4gseGPsWofD2ivlpkg+1uJ52QGjk+yU
         xrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345271; x=1714950071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KENCVx6uegL7ew41ijCYKGsXuud/xPQNe/tRNshJuk=;
        b=eyIlkfbo3+KI3Kb4GeE5DZ3omiYwqaR8O4Op36CqSHX8fOe/7mXbcQxfKG6PQv4T2z
         6POaKL9Adc2WaTR6iediN2M8o6UQrMf7aEJ8RAypqJ+GM0gxhtS8zXz5Qn8683m1004p
         JKm1kdn6LYr1tGRDrFKhDesg4Hu5NlvoHwuZU6j2/hrjnWYdK5b3nGSkF7m92XYlZnw0
         ID+DbJm6f2wv9Tfhbrx/PLv5zoneq7dbMqfao/olaLhc157jH5m3X+A81Vc99oYDrVkL
         HM2PKwMyiWBc7Oojzs1cPXOsnNl0wJTS+UFrq5UvJAnRCEZb5affr6dT+yN/D0Cc3qp/
         5YEA==
X-Forwarded-Encrypted: i=1; AJvYcCVSsTTCnQQe3W7gHJ37UTiuTtop5xlcIaKDp0JyK3l64OvKiIkpPDzWcEiyLEfLSzBaCLht3RxAvnZo31EK4vG5u5gh5ThUlQszeLEI
X-Gm-Message-State: AOJu0YzWuDm4UY0B34nZXk29k3oxfiVGv83xEPIrlR7HXcxuhfZFX0ww
	8uTnDDgcmK96M88c6r4qNDVJxcMYg3KxI9zBi3V4IVfXfvOUU/ZBXCxjK2YtLZc=
X-Google-Smtp-Source: AGHT+IFVEu6gQBfsHHhNIwJLCMTct8XdvZOfNrf8MZU2TBod0vCG9bXbxCA+vqYoaWeprrpR86u2UQ==
X-Received: by 2002:a17:90a:1548:b0:2a4:b9db:acf5 with SMTP id y8-20020a17090a154800b002a4b9dbacf5mr7428162pja.24.1714345270986;
        Sun, 28 Apr 2024 16:01:10 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:10 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/18] Staging: rtl8192e: Rename variable CurrentAMPDUFactor
Date: Sun, 28 Apr 2024 16:00:50 -0700
Message-Id: <20240428230106.6548-3-tdavies@darkphysics.net>
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

Rename variable CurrentAMPDUFactor to current_ampdu_factor
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib_tx.c      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index eeb5a5eb94be..b789d0f17156 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -104,7 +104,7 @@ struct rt_hi_throughput {
 	u8 ampdu_enable;
 	u8 current_ampdu_enable;
 	u8 ampdu_factor;
-	u8 CurrentAMPDUFactor;
+	u8 current_ampdu_factor;
 	u8 current_mpdu_density;
 	u8 forced_ampdu_factor;
 	u8 forced_mpdu_density;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index e82e8c50c090..3982c37f208c 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -470,12 +470,12 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 
 	if (ieee->current_network.bssht.bd_rt2rt_aggregation) {
 		if (ieee->pairwise_key_type != KEY_TYPE_NA)
-			ht_info->CurrentAMPDUFactor =
+			ht_info->current_ampdu_factor =
 					 pPeerHTCap->MaxRxAMPDUFactor;
 		else
-			ht_info->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
+			ht_info->current_ampdu_factor = HT_AGG_SIZE_64K;
 	} else {
-		ht_info->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
+		ht_info->current_ampdu_factor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
 						    HT_AGG_SIZE_32K);
 	}
 
@@ -514,7 +514,7 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 	ht_info->cur_short_gi_40mhz = false;
 
 	ht_info->current_mpdu_density = 0;
-	ht_info->CurrentAMPDUFactor = ht_info->ampdu_factor;
+	ht_info->current_ampdu_factor = ht_info->ampdu_factor;
 
 	memset((void *)(&ht_info->self_ht_cap), 0,
 	       sizeof(ht_info->self_ht_cap));
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 54100dd81505..1aeb207a3fee 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -313,7 +313,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 		}
 		if (ieee->iw_mode == IW_MODE_INFRA) {
 			tcb_desc->ampdu_enable = true;
-			tcb_desc->ampdu_factor = ht_info->CurrentAMPDUFactor;
+			tcb_desc->ampdu_factor = ht_info->current_ampdu_factor;
 			tcb_desc->ampdu_density = ht_info->current_mpdu_density;
 		}
 	}
-- 
2.30.2


