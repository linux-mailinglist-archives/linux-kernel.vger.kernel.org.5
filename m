Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3244E7A31A2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjIPRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjIPRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:15:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0D18E;
        Sat, 16 Sep 2023 10:15:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31ff2ce9d4cso1648084f8f.0;
        Sat, 16 Sep 2023 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694884499; x=1695489299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8r81PokekiscTN1fYoAgUCTcPOQ9XsRk0wZLGjEubc=;
        b=YCIKg2wJ7J4qbDKVBty/y+dER1K+dlfPlTPsBBQp/4NQccKG7k+DQ2/46GkXpWudTe
         URixA2ZEG/fRCdte1VMxVXcy57qgQMlpIgnUDbTIKHCy4U7teZMfTpO391tFLicEKV6N
         U2T9lXQGkK0xSoH5JRhpqoim+zqBfg7S6vPbnr7WGyPi/jHfYQKajekTEjMy1zo/Bksx
         OpUkmmq50eJuO3cr8uXL4Pbj1LSmrnxd5S/CC/5nvIfPJgdZRtQpcSyVKJTd3eCqAcXq
         ui/EvVjTwmwAMZApB3CUYtCsMvtXoDlDihpi7pcg4wLoKcXwfGfmfTDRtSNPRQUqA4yY
         ywcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694884499; x=1695489299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8r81PokekiscTN1fYoAgUCTcPOQ9XsRk0wZLGjEubc=;
        b=JfVlolyvD7Ps9Ao6CO3yblKysJfIUvKPrrVzOOs5dTNuVn5fiEWs0wIzIy9lYdjiYZ
         5JoMjUnZNBP8088hKiQHAuVaRd76lMaEDlW8mV71pw+qHJg/S+6Xs43HPN/HtKgJ3Ekl
         eaatxdVcVuBpdtde506TwwlnUU1XZM9f+Jj0eu8khtTZEcSsPRY/C0ZXIClnq5BJLgg/
         x/YGdBCDjAW/engBHKhBo/Du9v84dpx66c5CDgWy0/W6WtovzoElkQMbVfZ05HNgEKo2
         F0mR5tpRTR6btY9t3ep6r7qP2IJ6wsnoJU2ntd71eh0Kibe/jaXN50ocORb0thIy09iM
         g1gw==
X-Gm-Message-State: AOJu0YwETqwqPfnL8UBnVwQNzK/rjN/099UNFYgyhPNZ/+wtAFowmfln
        UCd4sMMjjaAQtK0fsXU4HzjNf8rAuHs=
X-Google-Smtp-Source: AGHT+IFmv6dO3awPrP2M7bpWh7m7OHarCmeQ616muFK+UjE2PLiKe1CNLjGB5T82vUAapy82bzsu+A==
X-Received: by 2002:a5d:48c9:0:b0:314:15a8:7879 with SMTP id p9-20020a5d48c9000000b0031415a87879mr3736251wrs.34.1694884498822;
        Sat, 16 Sep 2023 10:14:58 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id w4-20020a5d6804000000b003196e992567sm7712395wru.115.2023.09.16.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 10:14:58 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v6 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
Date:   Sat, 16 Sep 2023 16:00:45 +0200
Message-Id: <20230916140046.7878-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230916140046.7878-1-ansuelsmth@gmail.com>
References: <20230916140046.7878-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RCG frequency can be reached by multiple configuration.

Add clk_rcg2_fm_ops ops to support these special RCG configurations.

These alternative ops will select the frequency using a CEIL policy.

When the correct frequency is found, the correct config is selected by
calculating the final rate (by checking the defined parent and values
in the config that is being checked) and deciding based on the one that
is less different than the requested one.

These check are skipped if there is just on config for the requested
freq.

qcom_find_freq_multi is added to search the freq with the new struct
freq_multi_tbl.
__clk_rcg2_select_conf is used to select the correct conf by simulating
the final clock.
If a conf can't be found due to parent not reachable, a WARN is printed
and -EINVAL is returned.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h  |   1 +
 drivers/clk/qcom/clk-rcg2.c | 167 ++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  18 ++++
 drivers/clk/qcom/common.h   |   2 +
 4 files changed, 188 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index c81458db6ce4..dc9a77965e68 100644
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
index e22baf3a7112..617e7ff0f6a3 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -266,6 +266,116 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 	return 0;
 }
 
+static const struct freq_conf *
+__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
+		       unsigned long req_rate)
+{
+	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
+	const struct freq_conf *conf, *best_conf;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const char *name = clk_hw_get_name(hw);
+	unsigned long parent_rate, rate;
+	struct clk_hw *p;
+	int index, i;
+
+	/* Init best_conf to the first conf */
+	best_conf = f->confs;
+
+	/* Exit early if only one config is defined */
+	if (f->num_confs == 1)
+		goto exit;
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
+		rate_diff = abs(req_rate - rate);
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
+	if (unlikely(i == f->num_confs)) {
+		WARN(1, "%s: can't find a configuration for rate %lu.",
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
@@ -282,6 +392,14 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
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
@@ -377,6 +495,30 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 	return clk_rcg2_configure(rcg, f);
 }
 
+static int __clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_multi_tbl *f;
+	const struct freq_conf *conf;
+	struct freq_tbl f_tbl;
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
@@ -389,6 +531,12 @@ static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
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
@@ -401,6 +549,12 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
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
@@ -511,6 +665,19 @@ const struct clk_ops clk_rcg2_floor_ops = {
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

