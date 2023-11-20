Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E57F7F1E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjKTVFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKTVFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:05:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F6A2;
        Mon, 20 Nov 2023 13:05:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso13096125e9.0;
        Mon, 20 Nov 2023 13:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700514315; x=1701119115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t7GQ+j+zo3ZXwNW9a8QcJb79mY0YBo2C3suFz9nShCM=;
        b=YwxBeObwcG9HVXqiN1TtwGXoRsQgGEfpi//MOMUvwWJN24/NYLfFSz98X8Dyq640Ce
         k+bMe+tTyehG5rVii39F1jI1Mem8xL5Ny5fXo3eH9huULPWBhZJuKh1lhkRjSMA0tZtQ
         MBm3YCWCuUjlACgRNbjVDwGHsIdk95E/BGFk5XCqckf9jBDQbEziNWA29+/ddJBIJHP7
         f+kIQGjGfQi6l7apNgHuA2y4dxLSQKsnSBdEyKCUOj1nCqX0xuw3wVgZlY6P25/Wn1uN
         ZKOClbqKlMBhYrRC6iB/vDi1wU6xPmOX78SLtP3kO0GOAZksm+CdDxNBfqzfCR4dD2Tw
         AfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700514315; x=1701119115;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7GQ+j+zo3ZXwNW9a8QcJb79mY0YBo2C3suFz9nShCM=;
        b=cPnft/ceF5bziUKtb0OO1H8eCGqNdb38Rv3x+VYeu0bVXAxnwx0WWWuu2hm5I03Nge
         2dZtM6ugrJFeiNy45PohemahaUbwGhPxMV7GvYrd+jnl1rJwhkj49QZzBP+1clv37mWt
         Mg2Q8eiwl+EA/mMWCFJz4XGszZVYecT5+Yr3u2RDLJGLcltiPly4KjBvKoDr6OMwmHiA
         P/iSkubclzWHnH1xRNieS/4MTYWME2pKk4r9AOvz8BNwV4DI9BRsohcRCWcHpHRYPPPt
         clnZOleAsnBq96b2PeAXupZoWJTg0glwP7laNJPTwoBc9vt5XwIDppNCQiMqKHBtSSPa
         if1w==
X-Gm-Message-State: AOJu0YwH353/Z7Yqn6TmQy/v4wbn1+ykign7oB45hGQKXlGG0vLj/s01
        Hddt7r5rG2YCvRGRT7yCQ2Cnhi2JkVe4vw==
X-Google-Smtp-Source: AGHT+IHGp3m7pG3+F5ye3GUY8rU6t1lcEvjBadidsIQnessDV55agtZsQ7BrqH/s5R2UBVGxlrlYzg==
X-Received: by 2002:a5d:598e:0:b0:332:c723:12aa with SMTP id n14-20020a5d598e000000b00332c72312aamr451580wri.9.1700514314562;
        Mon, 20 Nov 2023 13:05:14 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id dh18-20020a0560000a9200b00332cb1bcd01sm2470608wrb.86.2023.11.20.13.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:05:13 -0800 (PST)
Message-ID: <655bca09.050a0220.bac1.aa06@mx.google.com>
X-Google-Original-Message-ID: <ZVuiFCh74TVT245E@Ansuel-xps.>
Date:   Mon, 20 Nov 2023 19:14:44 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq
 multi ops
References: <20230916140046.7878-1-ansuelsmth@gmail.com>
 <20230916140046.7878-3-ansuelsmth@gmail.com>
 <419b0e85-5479-30b0-d6a9-b2697d057c55@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XrBa3dHTEHMQ5RTv"
Content-Disposition: inline
In-Reply-To: <419b0e85-5479-30b0-d6a9-b2697d057c55@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XrBa3dHTEHMQ5RTv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2023 at 03:51:50PM +0530, Devi Priya wrote:
> 
> 
> On 9/16/2023 7:30 PM, Christian Marangi wrote:
> > Some RCG frequency can be reached by multiple configuration.
> > 
> > Add clk_rcg2_fm_ops ops to support these special RCG configurations.
> > 
> > These alternative ops will select the frequency using a CEIL policy.
> > 
> > When the correct frequency is found, the correct config is selected by
> > calculating the final rate (by checking the defined parent and values
> > in the config that is being checked) and deciding based on the one that
> > is less different than the requested one.
> > 
> > These check are skipped if there is just on config for the requested
> > freq.
> > 
> > qcom_find_freq_multi is added to search the freq with the new struct
> > freq_multi_tbl.
> > __clk_rcg2_select_conf is used to select the correct conf by simulating
> > the final clock.
> > If a conf can't be found due to parent not reachable, a WARN is printed
> > and -EINVAL is returned.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   drivers/clk/qcom/clk-rcg.h  |   1 +
> >   drivers/clk/qcom/clk-rcg2.c | 167 ++++++++++++++++++++++++++++++++++++
> >   drivers/clk/qcom/common.c   |  18 ++++
> >   drivers/clk/qcom/common.h   |   2 +
> >   4 files changed, 188 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> > index c81458db6ce4..dc9a77965e68 100644
> > --- a/drivers/clk/qcom/clk-rcg.h
> > +++ b/drivers/clk/qcom/clk-rcg.h
> > @@ -190,6 +190,7 @@ struct clk_rcg2_gfx3d {
> >   extern const struct clk_ops clk_rcg2_ops;
> >   extern const struct clk_ops clk_rcg2_floor_ops;
> > +extern const struct clk_ops clk_rcg2_fm_ops;
> >   extern const struct clk_ops clk_rcg2_mux_closest_ops;
> >   extern const struct clk_ops clk_edp_pixel_ops;
> >   extern const struct clk_ops clk_byte_ops;
> > diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> > index e22baf3a7112..617e7ff0f6a3 100644
> > --- a/drivers/clk/qcom/clk-rcg2.c
> > +++ b/drivers/clk/qcom/clk-rcg2.c
> > @@ -266,6 +266,116 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> >   	return 0;
> >   }
> > +static const struct freq_conf *
> > +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
> > +		       unsigned long req_rate)
> > +{
> > +	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
> > +	const struct freq_conf *conf, *best_conf;
> > +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> > +	const char *name = clk_hw_get_name(hw);
> > +	unsigned long parent_rate, rate;
> > +	struct clk_hw *p;
> > +	int index, i;
> > +
> > +	/* Init best_conf to the first conf */
> > +	best_conf = f->confs;
> > +
> > +	/* Exit early if only one config is defined */
> > +	if (f->num_confs == 1)
> > +		goto exit;
> > +
> > +	/* Search in each provided config the one that is near the wanted rate */
> > +	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
> > +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> > +		if (index < 0)
> > +			continue;
> > +
> > +		p = clk_hw_get_parent_by_index(hw, index);
> > +		if (!p)
> > +			continue;
> > +
> > +		parent_rate =  clk_hw_get_rate(p);
> > +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
> > +
> > +		if (rate == req_rate) {
> > +			best_conf = conf;
> > +			goto exit;
> > +		}
> > +
> > +		rate_diff = abs(req_rate - rate);
> > +		if (rate_diff < best_rate_diff) {
> > +			best_rate_diff = rate_diff;
> > +			best_conf = conf;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Very unlikely. Warn if we couldn't find a correct config
> > +	 * due to parent not found in every config.
> > +	 */
> > +	if (unlikely(i == f->num_confs)) {
> > +		WARN(1, "%s: can't find a configuration for rate %lu.",
> > +		     name, req_rate);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> Hi Christian,
> 
> Thanks a lot for the patch!
> We have incorporated these changes along with the corresponding clock driver
> changes & tested it on IPQ9574 & IPQ5332 targets.
> 
> When setting the clk rate for the nss port clocks, for the requested
> frequency the correct config gets selected and the
> clk rate is set properly.
> We see the WARN getting printed for other frequencies (rate * i where
> i=2 to maxdiv) that is requested by the clk_hw_round_rate function.
> 
> Upon analysis, we see that the for loop in clk_divider_bestdiv iterates
> until the maxdiv value and requests (rate*i) via the clk_hw_round_rate
> API to find the bestdiv and best_parent_rate. For frequencies which are
> multiples of the requested frequency (rate*i where i=2 to maxdiv), it
> seems unlikely to see the WARN being printed.
> 
> Can you please help us understand when the WARN is likely to be printed
> & Looking forward to your suggestions on how this WARN could
> be suppressed in the afore mentioned scenario!
> 

Hi,

thanks a lot for testing this. Maybe was a small oversight by me.

I attached an alternative patch. Can you test it and tell me if the WARN
is still printed? (the WARN must be printed only when the parent is not
found, I don't think it's your case)

-- 
	Ansuel

--XrBa3dHTEHMQ5RTv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-clk-qcom-clk-rcg2-add-support-for-rcg2-freq-multi-op.patch"

From d043c00e40ff69fb4c212a16e67e37b1b35f6528 Mon Sep 17 00:00:00 2001
From: Christian Marangi <ansuelsmth@gmail.com>
Date: Sat, 22 Apr 2023 00:52:35 +0200
Subject: [PATCH 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq multi ops

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
 drivers/clk/qcom/clk-rcg2.c | 166 ++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  18 ++++
 drivers/clk/qcom/common.h   |   2 +
 4 files changed, 187 insertions(+)

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
index e22baf3a7112..2393c7df0402 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -266,6 +266,115 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
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
+	if (unlikely(!best_conf)) {
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
@@ -282,6 +391,14 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
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
@@ -377,6 +494,30 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
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
@@ -389,6 +530,12 @@ static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
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
@@ -401,6 +548,12 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
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
@@ -511,6 +664,19 @@ const struct clk_ops clk_rcg2_floor_ops = {
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


--XrBa3dHTEHMQ5RTv--
