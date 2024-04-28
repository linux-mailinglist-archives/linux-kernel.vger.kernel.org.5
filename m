Return-Path: <linux-kernel+bounces-161620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145268B4EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462C91C21F09
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F952F82;
	Sun, 28 Apr 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NTcV8JtM"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1C45006
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345280; cv=none; b=i/bamg1Hd8rb4pqfQWy+f48ImLbJcKBflggn25nDS8MZVFn1IeTlBCd6F5cQ1iq6UATXIROOmJLaageljKt1HCadgEQOUeJ8Gh/ogTF4JH80MDv+2JSMuxmrW8sOkNwFa7EphWaSj74KunUhvwWWPCuIwnq1U9cukxZ5hs4JRDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345280; c=relaxed/simple;
	bh=vb94GfA1JvNoE6vUPfEwtkUDwECrX6lvUQ0dq8p/b4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XAGtmAEqimZO7qYazl+1SoOawM930E6L970Rb2ZiYIg/q/96RROvxR/VCO1oHHNP8TNjG8/fk3GyxVghhNynuB5QA0W6+r7+izeA1sOdZimJ9fC4M2vxDrUaI4yzcgpCwDG9VoyDgnz6iABXwVPPdYBPpkEBPj8Hh4U/Q7XEFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=NTcV8JtM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ad8919ba0cso3471358a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345278; x=1714950078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LiXQYKGf9PWs2c05STiuIP9UOdO9VQJ7oQke7MHzLw=;
        b=NTcV8JtMT9OkdKh+vMqN9ad3MMtPI90qBc1q1ySLearkSkq118TiZT9LPfOqk/qtUR
         50AeOhjomZhvgvqVLzFy8uz3JFPtOrOYzcVbx8LqiPBwil3cZInixYTA3NFw3dHGd2vq
         LaW2rr9a9iuRBMC2sYwpGnZ1620pPZ99nSJBONaQ9T3bxDGRyDeG/cieJW25Y3z63i7T
         FDhshH8a3BrGDmNsqY6AGm2YOdRlWE5d0uVkCxAxnTwjjbuk4V/SyakO2+FlkO78oR37
         5jgy9wlp4M0lcKk7DNznpandTLmrCltxSIHwieW0M1NuGGMZhAKBhYvZ/enIw1dgMfd5
         HmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345278; x=1714950078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LiXQYKGf9PWs2c05STiuIP9UOdO9VQJ7oQke7MHzLw=;
        b=QhObxwjGhkka0rlFYq2e1RWd+2unGB8ho00GXMGWDGyWf+hTcTrhm+Hm0UFxj+nf5r
         0B/KOOOH5lgO05Gz5WtOxTfVfi5pJDQjFh28hJJ4T2mi43PBdQOLPtEZ78ERAVEJnJ4i
         nqLOcxA9HOcC6Bz7U+6ADryG3b15LsFxD+IHi8uAdgpQNS13+MEI+1i0v5JSXgJBpUnl
         AMNg2pGr6mCeLZEAsYN/5sk06CEBCmfBkbcfafLpNVVzx0TOSTLMO8+xvzoMcZACEgek
         s4v6tGMfXAVi0dpQv8SuBgNIQxK72ljrUh8QPXoYcCDBPkQvr08NwHOqx0FcEBI3GCV0
         9ZKg==
X-Forwarded-Encrypted: i=1; AJvYcCVIcrf7Y501wGaA9do/HVn7Lifwjy26N5vhX/I33RHxf++olhCHH7xiEXtjV/SSRli3cr1/d+hY5oX+5f8jvYlwWypctxFRTxrdnwUu
X-Gm-Message-State: AOJu0YzaoC6vKkZs9rhHIyflUPz0stetNd19T1Rjt8QPkqIExD/PUdGx
	LwCorCD8/bPFdCZTKl/55CUn6CHwlN15V4MuWX9ZQbAUrQd3k/A+Sr7YK0mLO/c=
X-Google-Smtp-Source: AGHT+IFWTQICE5G3tTJSfFP5EMqzPtQVSRfF0pUynaGhoUqNZbA7gjk97Brp/TuOUfUk8FzOOV0l/Q==
X-Received: by 2002:a17:90a:bc89:b0:2a2:7a00:f101 with SMTP id x9-20020a17090abc8900b002a27a00f101mr8178859pjr.47.1714345278692;
        Sun, 28 Apr 2024 16:01:18 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:18 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/18] Staging: rtl8192e: Rename variable MaxAMSDUSize
Date: Sun, 28 Apr 2024 16:01:02 -0700
Message-Id: <20240428230106.6548-15-tdavies@darkphysics.net>
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

Rename variable MaxAMSDUSize to max_amsdu_size
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 96973c744cd0..e0906e4588c2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -33,7 +33,7 @@ struct ht_capab_ele {
 	u8	tx_stbc:1;
 	u8	rx_stbc:2;
 	u8	delay_ba:1;
-	u8	MaxAMSDUSize:1;
+	u8	max_amsdu_size:1;
 	u8	DssCCk:1;
 	u8	PSMP:1;
 	u8	Rsvd1:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 5c920a0089c9..7b08e549726b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -265,14 +265,14 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	cap_ele->tx_stbc			= 1;
 	cap_ele->rx_stbc			= 0;
 	cap_ele->delay_ba		= 0;
-	cap_ele->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
+	cap_ele->max_amsdu_size = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	cap_ele->DssCCk = 1;
 	cap_ele->PSMP = 0;
 	cap_ele->lsig_txop_protect = 0;
 
 	netdev_dbg(ieee->dev,
-		   "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n",
-		   cap_ele->chl_width, cap_ele->MaxAMSDUSize, cap_ele->DssCCk);
+		   "TX HT cap/info ele BW=%d max_amsdu_size:%d DssCCk:%d\n",
+		   cap_ele->chl_width, cap_ele->max_amsdu_size, cap_ele->DssCCk);
 
 	if (is_encrypt) {
 		cap_ele->MPDUDensity	= 7;
-- 
2.30.2


