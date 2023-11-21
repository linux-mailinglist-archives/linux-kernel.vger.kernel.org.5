Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A579E7F2FED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjKUNz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjKUNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:55:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304E4D6D;
        Tue, 21 Nov 2023 05:55:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40790b0a224so23581065e9.0;
        Tue, 21 Nov 2023 05:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700574951; x=1701179751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r5CEXNKpyjfsro5F2qODV+l61Asj3Ijt7gGz48Uso34=;
        b=U3t2EdH2jSG/OvdsBHSSJhGFoAv/ApPokaObCNi5D9Nfifg2Itk9MUMLUsJV9CrwVq
         BkptBZ7aZerFq0vN7Xo6eeDzp8k7viv1fOh5ifMoHdJ9jI+g6RyN3SoCQJNuXWWWTCaz
         nqoNm9L6aSixld7LRBZ72qIkFc2N/5P8BClT0XRYxPptqtYE5YDgPgN45LTlaxkzu4xR
         R/ZdEFwfIC3YscZYeDHxJcXweypamsP1HlZCDJnjCDF1UqUQdw3L/2y7AIqEL5Sm9Sne
         gkrHLGYguHY0RsGU4wMNj8s1JzZqaRl1r2gG+fXfrbtROkGovuT1nGtO8tpyQ3vlVocq
         ViVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700574951; x=1701179751;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5CEXNKpyjfsro5F2qODV+l61Asj3Ijt7gGz48Uso34=;
        b=r+fx/IecllC6IESCn5QWAod4pRkVFB9/aNGMgKkn8Gl5EVzZG9SPc9l84KBLZeYBFc
         IOcsljCnMkTvux7ih4TvF198pLIKIfJcHw0LDazMlpwNa+A6gbPPEppW9GfmdD6vqDxS
         6NUGb7g1t6U68dUwjQ4rzrPjHNCLa+qMAzZ+EdS8NdpAd3R+pykc4cLTz9yFEXHNiVwK
         s/wh5JLxdrduKAveFLRfvfE0oCa+d6zqQsUqlUTKFuqfbrdBrgVSlNXI1kVP9gad7Ixo
         FeCdly95gs+svD1dImG5+oeHarcTVXU0Okc61pIIaTl6DO+i5u98ziAtbDOTIkKcqnHE
         Dalg==
X-Gm-Message-State: AOJu0Ywp2oljIV20pSJj/R+R6MI5oiMI2iEbeiHzLm+Oyp2Q5Vp/8+1i
        QVqEr+cIfourGbiU9SPWCxM=
X-Google-Smtp-Source: AGHT+IFTLe2B5bXxlevVAgaKNB3Xo3WSpTsAxE13jfMNSN5R9F0TwQskofmVrAX3lZ4FXLbEefS2Wg==
X-Received: by 2002:a05:600c:3154:b0:407:8e85:89ad with SMTP id h20-20020a05600c315400b004078e8589admr8572103wmo.14.1700574951118;
        Tue, 21 Nov 2023 05:55:51 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id di11-20020a0560000acb00b00332cbece829sm3701237wrb.59.2023.11.21.05.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:55:50 -0800 (PST)
Message-ID: <655cb6e6.050a0220.35346.e9a2@mx.google.com>
X-Google-Original-Message-ID: <ZVy25JLIVbXPY/6w@Ansuel-xps.>
Date:   Tue, 21 Nov 2023 14:55:48 +0100
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
 <655bca09.050a0220.bac1.aa06@mx.google.com>
 <5540adcd-4ba6-53e7-c7fe-b7116e6403ca@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5540adcd-4ba6-53e7-c7fe-b7116e6403ca@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 12:01:15PM +0530, Devi Priya wrote:
> 
> 
> On 11/20/2023 11:44 PM, Christian Marangi wrote:
> > On Mon, Nov 20, 2023 at 03:51:50PM +0530, Devi Priya wrote:
> > > 
> > > 
> > > On 9/16/2023 7:30 PM, Christian Marangi wrote:
> > > > Some RCG frequency can be reached by multiple configuration.
> > > > 
> > > > Add clk_rcg2_fm_ops ops to support these special RCG configurations.
> > > > 
> > > > These alternative ops will select the frequency using a CEIL policy.
> > > > 
> > > > When the correct frequency is found, the correct config is selected by
> > > > calculating the final rate (by checking the defined parent and values
> > > > in the config that is being checked) and deciding based on the one that
> > > > is less different than the requested one.
> > > > 
> > > > These check are skipped if there is just on config for the requested
> > > > freq.
> > > > 
> > > > qcom_find_freq_multi is added to search the freq with the new struct
> > > > freq_multi_tbl.
> > > > __clk_rcg2_select_conf is used to select the correct conf by simulating
> > > > the final clock.
> > > > If a conf can't be found due to parent not reachable, a WARN is printed
> > > > and -EINVAL is returned.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >    drivers/clk/qcom/clk-rcg.h  |   1 +
> > > >    drivers/clk/qcom/clk-rcg2.c | 167 ++++++++++++++++++++++++++++++++++++
> > > >    drivers/clk/qcom/common.c   |  18 ++++
> > > >    drivers/clk/qcom/common.h   |   2 +
> > > >    4 files changed, 188 insertions(+)
> > > > 
> > > > diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> > > > index c81458db6ce4..dc9a77965e68 100644
> > > > --- a/drivers/clk/qcom/clk-rcg.h
> > > > +++ b/drivers/clk/qcom/clk-rcg.h
> > > > @@ -190,6 +190,7 @@ struct clk_rcg2_gfx3d {
> > > >    extern const struct clk_ops clk_rcg2_ops;
> > > >    extern const struct clk_ops clk_rcg2_floor_ops;
> > > > +extern const struct clk_ops clk_rcg2_fm_ops;
> > > >    extern const struct clk_ops clk_rcg2_mux_closest_ops;
> > > >    extern const struct clk_ops clk_edp_pixel_ops;
> > > >    extern const struct clk_ops clk_byte_ops;
> > > > diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> > > > index e22baf3a7112..617e7ff0f6a3 100644
> > > > --- a/drivers/clk/qcom/clk-rcg2.c
> > > > +++ b/drivers/clk/qcom/clk-rcg2.c
> > > > @@ -266,6 +266,116 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> > > >    	return 0;
> > > >    }
> > > > +static const struct freq_conf *
> > > > +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
> > > > +		       unsigned long req_rate)
> > > > +{
> > > > +	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
> > > > +	const struct freq_conf *conf, *best_conf;
> > > > +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> > > > +	const char *name = clk_hw_get_name(hw);
> > > > +	unsigned long parent_rate, rate;
> > > > +	struct clk_hw *p;
> > > > +	int index, i;
> > > > +
> > > > +	/* Init best_conf to the first conf */
> > > > +	best_conf = f->confs;
> > > > +
> > > > +	/* Exit early if only one config is defined */
> > > > +	if (f->num_confs == 1)
> > > > +		goto exit;
> > > > +
> > > > +	/* Search in each provided config the one that is near the wanted rate */
> > > > +	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
> > > > +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> > > > +		if (index < 0)
> > > > +			continue;
> > > > +
> > > > +		p = clk_hw_get_parent_by_index(hw, index);
> > > > +		if (!p)
> > > > +			continue;
> > > > +
> > > > +		parent_rate =  clk_hw_get_rate(p);
> > > > +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
> > > > +
> > > > +		if (rate == req_rate) {
> > > > +			best_conf = conf;
> > > > +			goto exit;
> > > > +		}
> > > > +
> > > > +		rate_diff = abs(req_rate - rate);
> > > > +		if (rate_diff < best_rate_diff) {
> > > > +			best_rate_diff = rate_diff;
> > > > +			best_conf = conf;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Very unlikely. Warn if we couldn't find a correct config
> > > > +	 * due to parent not found in every config.
> > > > +	 */
> > > > +	if (unlikely(i == f->num_confs)) {
> > > > +		WARN(1, "%s: can't find a configuration for rate %lu.",
> > > > +		     name, req_rate);
> > > > +		return ERR_PTR(-EINVAL);
> > > > +	}
> > > Hi Christian,
> > > 
> > > Thanks a lot for the patch!
> > > We have incorporated these changes along with the corresponding clock driver
> > > changes & tested it on IPQ9574 & IPQ5332 targets.
> > > 
> > > When setting the clk rate for the nss port clocks, for the requested
> > > frequency the correct config gets selected and the
> > > clk rate is set properly.
> > > We see the WARN getting printed for other frequencies (rate * i where
> > > i=2 to maxdiv) that is requested by the clk_hw_round_rate function.
> > > 
> > > Upon analysis, we see that the for loop in clk_divider_bestdiv iterates
> > > until the maxdiv value and requests (rate*i) via the clk_hw_round_rate
> > > API to find the bestdiv and best_parent_rate. For frequencies which are
> > > multiples of the requested frequency (rate*i where i=2 to maxdiv), it
> > > seems unlikely to see the WARN being printed.
> > > 
> > > Can you please help us understand when the WARN is likely to be printed
> > > & Looking forward to your suggestions on how this WARN could
> > > be suppressed in the afore mentioned scenario!
> > > 
> > 
> > Hi,
> > 
> > thanks a lot for testing this. Maybe was a small oversight by me.
> > 
> > I attached an alternative patch. Can you test it and tell me if the WARN
> > is still printed? (the WARN must be printed only when the parent is not
> > found, I don't think it's your case)
> > 
> Hi Christian,
> 
> WARN does not get printed with the attached patchset.
> Thanks much!
> 

Can you also confirm that the code correctly works with your div
scenario?

Would love to have some Tested-by tag to move this further!

(since it seems newer SoC after ipq807x will use this implementation
even more)

-- 
	Ansuel
