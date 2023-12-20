Return-Path: <linux-kernel+bounces-7501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62C81A8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754B228D07A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048594B14A;
	Wed, 20 Dec 2023 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOECU5so"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CA4A9AB;
	Wed, 20 Dec 2023 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d2764c0f2so2115135e9.2;
        Wed, 20 Dec 2023 14:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703110669; x=1703715469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jotW/smCHe43GFm6S3QgFxRqWUkfntNB5Eyd37F/QlU=;
        b=DOECU5soZn21H0VU+A0jGZfUCQ8Ug14rMLbCAUTrHeKbQJdv6Jgt0b6JfTAj3W7dJE
         62T0H9RYY/KL6nSlLKB+5nec+JIGddilFpKyabbBLlVtc1FZP14rBatWhiqOWo1e0H6G
         Tv9osLnz9e829JfzKX+4AmBmN4K1OXBexBFU9ezmxBZsUIKybpquBni2IvLKxG5Ue6xh
         eO/bunLaLStIsCVz9qRFr+PdDYi62gqT3a/sqtvZyvF5Z0oU/LvmyKE+q8hKSGgPcISj
         heSgdOEn/M4FJ5Cx1nAVK8YOFeUTGj0qXqindurKYLP5cCFN26F81mL8u2SLC9Y+QY1m
         cUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110669; x=1703715469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jotW/smCHe43GFm6S3QgFxRqWUkfntNB5Eyd37F/QlU=;
        b=kQtTI282cneQ6MkF8VMfYwmKi9BQEukJfoCsLD9CcAcQCbKfGW9A4JSPiiBo/+ScEq
         V7KJz7qpDEXBY2MhbWGMs8usA47PZEjAWroaRpuxUs6eTJy/xWyV3Ah42lQrcUAcJGTb
         IgJ07Vl3idvz3T6Wk9YK451KoR0Cnd175WrARq9PT1mMyqQWtz1bfJTVcSEz1f4JIEW0
         R67cCmu/wH73YuPhcBt68GIzXvYOtqMqjTqWsT/k0CneM3wNpFEm0EROmRJcc1oMVamN
         2dXZLvQ1RIwyvAMzdD53iI/4GX/QlRgUNgSm6j7+H2TcCVeRtcG7VcOTybOiXcBZ8Dyv
         KCBw==
X-Gm-Message-State: AOJu0Yw0WLmEPGQLhF5FUIF8+6jB8F0eAndOpJdocyyXr0dQrDfH5lZ7
	2y3YViMqXPCteOZKqakhhk4=
X-Google-Smtp-Source: AGHT+IGUuo04xufrasQlOb7GkDV0g2zrhFlGHPK3Te860OOFGJMFSYA7K/YVal6iboFtHIwH1R/wTw==
X-Received: by 2002:a05:600c:3ac7:b0:40d:190d:f36e with SMTP id d7-20020a05600c3ac700b0040d190df36emr177426wms.161.1703110668449;
        Wed, 20 Dec 2023 14:17:48 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm8908826wmn.14.2023.12.20.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:17:48 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Wei Lei <quic_leiwei@quicinc.com>
Subject: [PATCH v8 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
Date: Wed, 20 Dec 2023 23:17:23 +0100
Message-Id: <20231220221724.3822-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220221724.3822-1-ansuelsmth@gmail.com>
References: <20231220221724.3822-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some RCG frequency can be reached by multiple configuration.

Add clk_rcg2_fm_ops ops to support these special RCG configurations.

These alternative ops will select the frequency using a CEIL policy.

When the correct frequency is found, the correct config is selected by
calculating the final rate (by checking the defined parent and values
in the config that is being checked) and deciding based on the one that
is less different than the requested one.

These check are skipped if there is just one config for the requested
freq.

qcom_find_freq_multi is added to search the freq with the new struct
freq_multi_tbl.
__clk_rcg2_select_conf is used to select the correct conf by simulating
the final clock.
If a conf can't be found due to parent not reachable, a WARN is printed
and -EINVAL is returned.

Tested-by: Wei Lei <quic_leiwei@quicinc.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h  |   1 +
 drivers/clk/qcom/clk-rcg2.c | 166 ++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  18 ++++
 drivers/clk/qcom/common.h   |   2 +
 4 files changed, 187 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index c50e6616d02c..d7414361e432 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -190,6 +190,7 @@ struct clk_rcg2_gfx3d {
 
 extern const struct clk_ops clk_rcg2_ops;
 extern const struct clk_ops clk_rcg2_floor_ops;
+extern const struct clk_ops clk_rcg2_fm_ops;
 extern const struct clk_ops clk_rcg2_mux_closest_ops;
 extern const struct clk_ops clk_edp_pixel_ops;
 extern const struct clk_ops clk_byte_ops;
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 5183c74b074f..9b3aaa7f20ac 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -260,6 +260,115 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 	return 0;
 }
 
+static const struct freq_conf *
+__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
+		       unsigned long req_rate)
+{
+	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
+	const struct freq_conf *conf, *best_conf = NULL;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const char *name = clk_hw_get_name(hw);
+	unsigned long parent_rate, rate;
+	struct clk_hw *p;
+	int index, i;
+
+	/* Exit early if only one config is defined */
+	if (f->num_confs == 1) {
+		best_conf = f->confs;
+		goto exit;
+	}
+
+	/* Search in each provided config the one that is near the wanted rate */
+	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
+		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
+		if (index < 0)
+			continue;
+
+		p = clk_hw_get_parent_by_index(hw, index);
+		if (!p)
+			continue;
+
+		parent_rate =  clk_hw_get_rate(p);
+		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
+
+		if (rate == req_rate) {
+			best_conf = conf;
+			goto exit;
+		}
+
+		rate_diff = abs_diff(req_rate, rate);
+		if (rate_diff < best_rate_diff) {
+			best_rate_diff = rate_diff;
+			best_conf = conf;
+		}
+	}
+
+	/*
+	 * Very unlikely. Warn if we couldn't find a correct config
+	 * due to parent not found in every config.
+	 */
+	if (unlikely(!best_conf)) {
+		WARN(1, "%s: can't find a configuration for rate %lu\n",
+		     name, req_rate);
+		return ERR_PTR(-EINVAL);
+	}
+
+exit:
+	return best_conf;
+}
+
+static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_multi_tbl *f,
+				       struct clk_rate_request *req)
+{
+	unsigned long clk_flags, rate = req->rate;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_conf *conf;
+	struct clk_hw *p;
+	int index;
+
+	f = qcom_find_freq_multi(f, rate);
+	if (!f || !f->confs)
+		return -EINVAL;
+
+	conf = __clk_rcg2_select_conf(hw, f, rate);
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
+	index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
+	if (index < 0)
+		return index;
+
+	clk_flags = clk_hw_get_flags(hw);
+	p = clk_hw_get_parent_by_index(hw, index);
+	if (!p)
+		return -EINVAL;
+
+	if (clk_flags & CLK_SET_RATE_PARENT) {
+		rate = f->freq;
+		if (conf->pre_div) {
+			if (!rate)
+				rate = req->rate;
+			rate /= 2;
+			rate *= conf->pre_div + 1;
+		}
+
+		if (conf->n) {
+			u64 tmp = rate;
+
+			tmp = tmp * conf->n;
+			do_div(tmp, conf->m);
+			rate = tmp;
+		}
+	} else {
+		rate =  clk_hw_get_rate(p);
+	}
+
+	req->best_parent_hw = p;
+	req->best_parent_rate = rate;
+	req->rate = f->freq;
+
+	return 0;
+}
+
 static int clk_rcg2_determine_rate(struct clk_hw *hw,
 				   struct clk_rate_request *req)
 {
@@ -276,6 +385,14 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
 	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
 }
 
+static int clk_rcg2_fm_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	return _freq_tbl_fm_determine_rate(hw, rcg->freq_multi_tbl, req);
+}
+
 static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
 				u32 *_cfg)
 {
@@ -371,6 +488,30 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 	return clk_rcg2_configure(rcg, f);
 }
 
+static int __clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_multi_tbl *f;
+	const struct freq_conf *conf;
+	struct freq_tbl f_tbl = {};
+
+	f = qcom_find_freq_multi(rcg->freq_multi_tbl, rate);
+	if (!f || !f->confs)
+		return -EINVAL;
+
+	conf = __clk_rcg2_select_conf(hw, f, rate);
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
+
+	f_tbl.freq = f->freq;
+	f_tbl.src = conf->src;
+	f_tbl.pre_div = conf->pre_div;
+	f_tbl.m = conf->m;
+	f_tbl.n = conf->n;
+
+	return clk_rcg2_configure(rcg, &f_tbl);
+}
+
 static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 			    unsigned long parent_rate)
 {
@@ -383,6 +524,12 @@ static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
 	return __clk_rcg2_set_rate(hw, rate, FLOOR);
 }
 
+static int clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	return __clk_rcg2_fm_set_rate(hw, rate);
+}
+
 static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
 		unsigned long rate, unsigned long parent_rate, u8 index)
 {
@@ -395,6 +542,12 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
 	return __clk_rcg2_set_rate(hw, rate, FLOOR);
 }
 
+static int clk_rcg2_fm_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_fm_set_rate(hw, rate);
+}
+
 static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
@@ -505,6 +658,19 @@ const struct clk_ops clk_rcg2_floor_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
 
+const struct clk_ops clk_rcg2_fm_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_fm_determine_rate,
+	.set_rate = clk_rcg2_fm_set_rate,
+	.set_rate_and_parent = clk_rcg2_fm_set_rate_and_parent,
+	.get_duty_cycle = clk_rcg2_get_duty_cycle,
+	.set_duty_cycle = clk_rcg2_set_duty_cycle,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_fm_ops);
+
 const struct clk_ops clk_rcg2_mux_closest_ops = {
 	.determine_rate = __clk_mux_determine_rate_closest,
 	.get_parent = clk_rcg2_get_parent,
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..48f81e3a5e80 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -41,6 +41,24 @@ struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(qcom_find_freq);
 
+const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
+						  unsigned long rate)
+{
+	if (!f)
+		return NULL;
+
+	if (!f->freq)
+		return f;
+
+	for (; f->freq; f++)
+		if (rate <= f->freq)
+			return f;
+
+	/* Default to our fastest rate */
+	return f - 1;
+}
+EXPORT_SYMBOL_GPL(qcom_find_freq_multi);
+
 const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
 					    unsigned long rate)
 {
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..2d4a8a837e6c 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -45,6 +45,8 @@ extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
 					     unsigned long rate);
 extern const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
 						   unsigned long rate);
+extern const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
+							 unsigned long rate);
 extern void
 qcom_pll_set_fsm_mode(struct regmap *m, u32 reg, u8 bias_count, u8 lock_count);
 extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
-- 
2.40.1


