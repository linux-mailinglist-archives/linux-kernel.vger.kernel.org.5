Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF20756141
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjGQLJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:09:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1807FB9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:08:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so69040821fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689592137; x=1692184137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQuNLrwbJ2AdsFbKd9SBZgt7zHVZW51vp7qPZgcDweg=;
        b=MtFO/Mvc0xspnkoMEh5fsDNS+VVWirzNRAvB3fitk0Dm1zi/YTGv2jOL7Uk8ZI/7B1
         Y6xasr3dN+h4JKJOdCQLyigRLxdVVZmSpRwZlVCIzZ4dh5hXKGqTmVkPzvKR0dJV2o6a
         EwepnhROHZ3tM6JAqt/PxVT3mwA4Ue+IjCJWFwI6spHEqNVvKTBiMdIvwTzydidas5Kc
         PNKkM8pVa+21nvblq8PkjAdVhSDpEWe6PwVA2Hsyd1jXaENlfmfekeWdHfLssfI0dNmd
         ROb5AZnYMr7mpnhw+TycOgiWldFHoWZpw8KGneC8ulwk8pm/gC2WYUJbbPnufoiIa4RC
         85Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689592137; x=1692184137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQuNLrwbJ2AdsFbKd9SBZgt7zHVZW51vp7qPZgcDweg=;
        b=AXipBPn3hNbECag0qJHpvMDZaMFFxPC0V2abOfDFxEOipDKD5EoqsfOhPi5y9SO9RR
         cggKBpVYgN08Moz8vpCCqxvdLZMdxEWP68y7+TtJOwySvtrXoJAtooVEfG33ZkYohomI
         xKYo5TGmtnjNUwipOTvtaKArDCiPXhH9aTG+lHax8ywZ+tilb3NNKxrk1GqkpmamSrs7
         Y2zkw+4BMrF9gfGGzaS1JGfOHm3taMDt2ASZ92WJkmq4c4LeLvetUNd/dyVgFh6Rd6W2
         RD3wBHcnc61g4y4JUoNIaolKNnzDVKpC1jlHRLknkAG6iweqG4VO019GW7OccgLA5SEP
         Jqtw==
X-Gm-Message-State: ABy/qLZiHAPpl4HYsuEIygna52PPa3EpHGOm1cVhJrlXym2qvL6TiogU
        vioGVm4Zb3AyRH9c+amZKxsKlqm1wyCWP/3GQPs=
X-Google-Smtp-Source: APBJJlErSTd9piiodlW+ToCtAf2Q4Jwxz8C8FI1Iin32AwNZNKHAg7wzx7U496d2ZHQO+2dysJbLUw==
X-Received: by 2002:a05:651c:20a:b0:2b6:d8d4:161 with SMTP id y10-20020a05651c020a00b002b6d8d40161mr10907844ljn.43.1689592137230;
        Mon, 17 Jul 2023 04:08:57 -0700 (PDT)
Received: from linaro.org ([82.78.74.213])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709064e0300b00992afee724bsm8989196eju.76.2023.07.17.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:08:56 -0700 (PDT)
Date:   Mon, 17 Jul 2023 14:08:54 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: gdsc: Add support for set_hwmode_dev
Message-ID: <ZLUhRlm20xlZ3OJj@linaro.org>
References: <20230628105652.1670316-1-abel.vesa@linaro.org>
 <20230628105652.1670316-3-abel.vesa@linaro.org>
 <42b1167d-da60-f6c3-67b6-3f6857327396@linaro.org>
 <e94f187e-e444-d18d-eba9-b9a699abdb95@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94f187e-e444-d18d-eba9-b9a699abdb95@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-10 09:40:14, Taniya Das wrote:
> Hi Abel,
> 
> Thanks for the patch.
> 
> On 6/28/2023 10:48 PM, Konrad Dybcio wrote:
> > On 28.06.2023 12:56, Abel Vesa wrote:
> > > Implement the GDSC specific genpd set_hwmode_dev callback in order to
> > > switch the HW control on or off. For any GDSC that supports HW control
> > > set this callback in order to allow its consumers to control it.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > This still does nothing to prevent the HW_CTRL state being changed in
> > init, enable and disable functions.
> > 
> > Konrad
> > >   drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > > index 5358e28122ab..9a04bf2e4379 100644
> > > --- a/drivers/clk/qcom/gdsc.c
> > > +++ b/drivers/clk/qcom/gdsc.c
> > > @@ -314,6 +314,26 @@ static int gdsc_enable(struct generic_pm_domain *domain)
> > >   	return 0;
> > >   }
> > > +static int gdsc_set_hwmode_dev(struct generic_pm_domain *domain,
> > > +			       struct device *dev, bool enable)
> > > +{
> > > +	int ret = gdsc_hwctrl(domain_to_gdsc(domain), enable);
> > > +
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * Wait for the GDSC to go through a power down and
> > > +	 * up cycle.  In case there is a status polling going on
> > > +	 * before the power cycle is completed it might read an
> > > +	 * wrong status value.
> > > +	 */
> > > +	udelay(1);
> > > +
> > > +out:
> > > +	return ret;
> > > +}
> > > +
> > >   static int gdsc_disable(struct generic_pm_domain *domain)
> > >   {
> > >   	struct gdsc *sc = domain_to_gdsc(domain);
> > > @@ -451,6 +471,8 @@ static int gdsc_init(struct gdsc *sc)
> > >   		sc->pd.power_off = gdsc_disable;
> > >   	if (!sc->pd.power_on)
> > >   		sc->pd.power_on = gdsc_enable;
> > > +	if (sc->flags & HW_CTRL)
> > > +		sc->pd.set_hwmode_dev = gdsc_set_hwmode_dev;
> We do not want to move to SW mode without consumers wanting to move to this
> mode.
> 
> We want a new flag for the consumers wanting to move to this mode. The mode
> in which the GDSC would be enabled would be in SW mode only.
> +	if (sc->flags & HW_CTRL_TRIGGER) {
> +		sc->pd.set_hwmode_dev = gdsc_set_mode;
> +	}
> +

OK, maybe I'm missing something here.

Do you suggest we have GDSCs that, even though they support HW ctrl,
should not be controllable by the consumer?

Why isn't dev_pm_genpd_set_hwmode good enough? If a consumer doesn't
want to control it then the consumer can just skip calling the mentioned
function.

Or maybe you want this all hidden into the genpd provider?

> 
> > >   	ret = pm_genpd_init(&sc->pd, NULL, !on);
> > >   	if (ret)
> 
> -- 
> Thanks & Regards,
> Taniya Das.
