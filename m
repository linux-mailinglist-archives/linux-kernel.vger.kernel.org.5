Return-Path: <linux-kernel+bounces-52894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA3849DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8641F22CE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F863A1CC;
	Mon,  5 Feb 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="IDaUUJ5P"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0EF3A8F4;
	Mon,  5 Feb 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146595; cv=none; b=H3LR4bAPhlxlMf27GSmmeVf8dmr67choPN1ptqP+Qvue2pzlPwurHtu7GaNwDcn33ZUD8Z3iclKiCNFTphSgdZ3XzqV1XbFetGo7OXZLVxSmpbHpLo8V34t7a1W3YJOVWNMLGYOmcwF2cCQnqVhfUBKnMvIQFY5gAposaJ8IwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146595; c=relaxed/simple;
	bh=/3dNKggDHZ8IDpHedZkuDBEbq+kfTgK2pJtlaJ3P5io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OE/SHb8v2XNolGpNVJYHxwHDcvxYt5jA0bzMh53ZJnPPhW87BEagE8o4Gl7wrGRcjAAlqBrcTYzuH9Y+qVvVoUqU0CEEdfTiip/ww41A5n8bp9ip0InBO3qUDrLI6FCQdPnMGtolGEt1pA6MIY1lv7iLc+v/ZHZrwrpTitqVYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=IDaUUJ5P; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TT9B00qv3z9sqg;
	Mon,  5 Feb 2024 16:23:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1707146584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU9BjDKbdWvhuTRibGk4N23TVvjyO4DZIzgSg1oCo6o=;
	b=IDaUUJ5PaOMkW+Dzmqmhvw1A2j2Lfq6AF6jkWqYyvuUV1mnPji1NK36FRhHisVpA1kq91J
	N9nQAbdp5x1uKIQ2nJMSsJBfeEHeU3Lg9wlnrwSTrGCBbbi4aekUehgkYMOuMyjdmRX9Cm
	/HR6dLUGcoGE9kf3JY6qhuiTgh3x5FGGw5WaK7OZ/NYc/XBo5xkaX5CJMwKyMDWdZBYdTc
	OXJ2OcDHedVgWThIGV1viXPs+xhuOKsRMHQoSZ2rQEguyscQBTVXgunD07NfRF2RbDin8P
	OhYcz/VzrOJo7cdUDvCVE+Y5ISgk6LdGAIg3AWTcgjra1KaYtxslApH5S7yN5g==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Mon, 05 Feb 2024 16:22:26 +0100
Subject: [PATCH v2 3/6] clk: sunxi-ng: nkm: Support minimum and maximum
 rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
In-Reply-To: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=/3dNKggDHZ8IDpHedZkuDBEbq+kfTgK2pJtlaJ3P5io=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBlwP0/R/bYRLSWDoR8LFJNAtlZjd3AuDTv0TkSy
 h6Q/t85+q+JAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZcD9PwAKCRCaaaIIlErT
 x7cUC/90hwXY99Ja4sPw6whiQKjE2ZtXg2fE1iRFw0+6vh1HBrZuuzBYjAond8O2cZhSszDwTV6
 fsKjWCndURyzjCM50NZOZidj8q2F2hNxNfwzYtd2DeYxhaT7IzHpzwWiS150YVdru/4YTgc+zmm
 6fePa2l5nnrf+nr1LL2371HweSyQbxUHiAzrCR2iaZhkhDpkEmRQBmkzIQRIKlLHf6TkaG1j0IQ
 mzbCbsCDTfewQUPHe+sRDAndVbsxwi65ZoCI5BPtDlLoW9SgJLeawQ27nR22EsgA1VR1+FqSKgt
 JUka8btp+cH79A2OeLbeZoKapTa3T3BcU8gYviht8L24G99WcywrYzEOKfxJkZGwaXzfXJWTzjs
 NjaepFV6e+z/1Xy6E7oRgHP2Ns+4brhuPhnqfwBgjK9bmo7ogE0uC9OV4JtNygG/5CDGm8IIOaO
 UE5j/+5B8D47kn6fIaozCmuA1f3Ti/UgXv2t63jjvvM0LYNdWpiBJf8IZ/SmdsXkpFNNU=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4TT9B00qv3z9sqg

According to the Allwinner User Manual, the Allwinner A64 requires
PLL-MIPI to run at 500MHz-1.4GHz. Add support for that to ccu_nkm.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 13 +++++++++++++
 drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 1168d894d636..7d135908d6e0 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -181,6 +181,12 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
+	if (nkm->min_rate && rate < nkm->min_rate)
+		rate = nkm->min_rate;
+
+	if (nkm->max_rate && rate > nkm->max_rate)
+		rate = nkm->max_rate;
+
 	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
 		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm, &nkm->common);
 	else
@@ -220,6 +226,13 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
+
+	if (nkm->min_rate && rate < nkm->min_rate)
+		rate = nkm->min_rate;
+
+	if (nkm->max_rate && rate > nkm->max_rate)
+		rate = nkm->max_rate;
+
 	ccu_nkm_find_best(parent_rate, rate, &_nkm, &nkm->common);
 
 	spin_lock_irqsave(nkm->common.lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index c409212ee40e..358a9df6b6a0 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -27,6 +27,8 @@ struct ccu_nkm {
 	struct ccu_mux_internal	mux;
 
 	unsigned int		fixed_post_div;
+	unsigned long		min_rate;
+	unsigned long		max_rate;
 	unsigned long		max_m_n_ratio;
 	unsigned long		min_parent_m_ratio;
 

-- 
2.43.0


