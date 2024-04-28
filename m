Return-Path: <linux-kernel+bounces-161624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D58B4EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB038B21B23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD45474B;
	Sun, 28 Apr 2024 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="QXj1p9cJ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05452F9A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345283; cv=none; b=J+/JcnaJAS9SrrWEPRxylm59tcYU8J8zIUinv9k8yYnmcRukNHYqUbJjfNdxVOtppPUTycLNtSpfhvqhKVO0wUpBV6CH2Hi+l0hpAtbfSICg5b6RJeVSnJkkPnaiGIHf/lmq5qA4qFrCHCp6kminsARsa3s9cZZF2y6/RbLa5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345283; c=relaxed/simple;
	bh=CINZa7BZ9kwdDRvCzgXCeiUMShws1T7hlMcYDXKXccg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuCePJbOnNjqsc5qvaDWFerGRq7QbqZvG72oLHibqf+yIRntCkfxZJoQd6LQR8wzV73S5+RouaYo9ixKxAeravJ+zzKXroSxLlnvSKcFVuJ2rdpfd595XPYPZphWTXQWMKjwOe/6lAlw0JytqB+mwvcXFq0DIl5/KrHER99RbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=QXj1p9cJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso3639123b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345281; x=1714950081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szh4UKx+DCu/+Jb81IHvm3sJHBJ5ImWZ7XqJmmyg3wk=;
        b=QXj1p9cJaY8K3kod7j5jarr0dD7/jBjsyOfaxaKw5XJPG3lhRpuqxxhH0CuozHlmri
         tFqibPHer5aH0cBjrW0rpdXa27K1OSWyf2coiXTgJcVLwWLLo4WN4y31ejCbkp+L3lLf
         17kRIYdB1a0l4fc0anitPrVpu+yYR1Miri6WJODKgmRJ6SLTu1OgonYmqo0gGBeruBOA
         /O/IhKG4ZeshMEXFn0E0I8I++FFcymhj93T5QVarh06hOfE0ytp0TgJLYluYxp/kKgcs
         xZsPbxTxYK2/o8A4lMXXNgg5dI87AvRYCQFnT6DzH30KdhdJiEMVu/it/sURUd1Eg3U+
         xngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345281; x=1714950081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szh4UKx+DCu/+Jb81IHvm3sJHBJ5ImWZ7XqJmmyg3wk=;
        b=eLT7azGXAoL5dJuGhaaSwARS7KbUMpuuRM9LbFaw8LsCAb94bvREf9MTyAcMzhF8K+
         +CXZxAU/stDTODWzYkDMX5gLStDanY4TsSzvttwXcovAB2Pe16VVjWWTbnvEQAKn4sL+
         XQefXNWPHQTmQmVXMMZc3UsUWCLLrPbXzDkkCyIF4Wdo3WNAfpanfbUUbnWqcd/TIOh0
         KF/zGIwi8JimrVZT9xWwytjA36m1ID8mg55UAMvVWX6OrwXbZ47SW303OeeqyLfCJpNn
         CYGwmZDwZEHCQvfmxPkdsp1IPXvsP9a6XV4wIepNbTyWvPVa3sSlV1dE500DiCzC8jkx
         g7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXw+cPP9XsLdqUQQ512/7PpZO+4f/8Q2qKzMFaVj0XjP2tfqVmWmMJQbKRJGZl7vfwjDuRtbVTgJ0RMdFzYbaWTqRqYhczQmqviVZEE
X-Gm-Message-State: AOJu0Yx91xlxCQZ2/TEhw6zykszHQ+5iM7AW0Ajarn30Rqhl95/cvHDl
	wwaVb/PkYtuPltWIHv9HVFKeiVSMX0A1kqPSOTdVLmduW2lkxVe3SuVThgNL1YU=
X-Google-Smtp-Source: AGHT+IEayXLaLCT7Ia7HGBREBpMOGoPMsguYGlKFCBMNIDhZLcTnbCBm/Um9a55y4twAp7YTf9gqJA==
X-Received: by 2002:a17:90b:684:b0:2b1:9845:e09b with SMTP id m4-20020a17090b068400b002b19845e09bmr1107604pjz.49.1714345281097;
        Sun, 28 Apr 2024 16:01:21 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:20 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 18/18] Staging: rtl8192e: Rename variable DssCCk
Date: Sun, 28 Apr 2024 16:01:06 -0700
Message-Id: <20240428230106.6548-19-tdavies@darkphysics.net>
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

Rename variable DssCCk to dss_cck
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index c1446081956d..a6e0077630c7 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -34,7 +34,7 @@ struct ht_capab_ele {
 	u8	rx_stbc:2;
 	u8	delay_ba:1;
 	u8	max_amsdu_size:1;
-	u8	DssCCk:1;
+	u8	dss_cck:1;
 	u8	PSMP:1;
 	u8	Rsvd1:1;
 	u8	lsig_txop_protect:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 963d69680049..9b0a981f6f22 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -266,13 +266,13 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	cap_ele->rx_stbc			= 0;
 	cap_ele->delay_ba		= 0;
 	cap_ele->max_amsdu_size = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	cap_ele->DssCCk = 1;
+	cap_ele->dss_cck = 1;
 	cap_ele->PSMP = 0;
 	cap_ele->lsig_txop_protect = 0;
 
 	netdev_dbg(ieee->dev,
-		   "TX HT cap/info ele BW=%d max_amsdu_size:%d DssCCk:%d\n",
-		   cap_ele->chl_width, cap_ele->max_amsdu_size, cap_ele->DssCCk);
+		   "TX HT cap/info ele BW=%d max_amsdu_size:%d dss_cck:%d\n",
+		   cap_ele->chl_width, cap_ele->max_amsdu_size, cap_ele->dss_cck);
 
 	if (is_encrypt) {
 		cap_ele->mpdu_density	= 7;
-- 
2.30.2


