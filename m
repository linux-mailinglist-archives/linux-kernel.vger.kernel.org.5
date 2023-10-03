Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCEC7B691C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjJCMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjJCMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:36:57 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBF83
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:36:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d894b8b9b7cso734895276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696336613; x=1696941413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBX7WALro7ZMkb002Ch3k9j1xjJ9wEjQFSfSLSNKyVA=;
        b=wowDWE69tD5ieLR6Ads/Gyej3DkIMinqPh4cf/7coSvZFkJzUDlN2cLFVx7EQ3hTNB
         6fJcMgDSlDvBfW49tVCMEksYLzhaL93dCQCXELdqo0cHyuPZwmm1n4ohS6zn5M5QjfQy
         /GxFQfrb6uTdu+j8YJ9znAVNbXndw2vrEWS07hFxk4reJyYXEq5G2DUT0yemwBRvrOF3
         VIhBDKDjQW9pJnapUZZp2ZVG/GX5JYq6yJPwwTR0uvocDQHTGybydTc0/P1Csa9tkwHZ
         246VrjNHqcNLnvN+30nged/SL2CYVWX3Y16qte3XE1Y3REak48Uvrbsern8cKwXf+vIU
         l+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696336613; x=1696941413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBX7WALro7ZMkb002Ch3k9j1xjJ9wEjQFSfSLSNKyVA=;
        b=O6jx6Z9B2oWmgfxLKMdco3PQkBDCTg3eCKqZMH7ZPz+ZEHAXbQjISJzPEMi5Y8EmYB
         pzhPT711+7qOWSf/DE8EpNu1SDchD8x6vDw3UB53AIrV6UEPqBWXTU+8BmkG9NvEtKyf
         /6QUT5IYbhxwYH/uEUH9DeiXLUWGAl/7Zj6nXn3OYfRMyZBxq0Vbt1r9sC+35aaEzKTq
         Xpq+OnPCSgnBY2O6PGTOCpf5dLMtX1Z2Hc5a7Z9DLDP86dDYaGH6gip+ffsnYOwoWRZN
         3TlKswslSNXpbWX3Ld2QDxFrx3QH6xmgfiELIPB+RsajFT4fiiG/bZGcHxCxUCB2bcs6
         n/xw==
X-Gm-Message-State: AOJu0Yw1Fzdu+CsrYq1zWul1Mx22YBPj58E13jJY3Ecm4IUpyX7ZRLYE
        5BoXCX3NZv+DRuKuv/8w82scDDZvp0VI+hNn3xhkFw==
X-Google-Smtp-Source: AGHT+IGdl+vhW0m01pb/+ML+OMGARTp9lewRZVPBj7PzhWM7waqR82ShESUiVLf8ufb7gdbuRoiu4yVr0cW53ETCZw0=
X-Received: by 2002:a25:8b09:0:b0:d81:b5e2:b1cc with SMTP id
 i9-20020a258b09000000b00d81b5e2b1ccmr1931296ybl.5.1696336613296; Tue, 03 Oct
 2023 05:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-7-ulf.hansson@linaro.org> <CAPDyKFo+XCEtTSNqtA1SeajWo4tuRroA4GrRegta5TsqSGd4eQ@mail.gmail.com>
 <20231003082322.cmok766jxzftsgrg@vireshk-i7>
In-Reply-To: <20231003082322.cmok766jxzftsgrg@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 14:36:17 +0200
Message-ID: <CAPDyKForAJfdqqpkAP0vwZFAtSAtGMyqChLVr96v7PDWRj2qzw@mail.gmail.com>
Subject: Re: [PATCH 6/9] OPP: Extend support for the opp-level beyond required-opps
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 at 10:23, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-09-23, 15:33, Ulf Hansson wrote:
> > On Mon, 25 Sept 2023 at 15:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > At this point the level (performance state) for an OPP is currently limited
> > > to be requested for a device that is attached to a PM domain.  Moreover,
> > > the device needs to have the so called required-opps assigned to it, which
> > > are based upon OPP tables being described in DT.
> > >
> > > To extend the support beyond required-opps and DT, let's enable the level
> > > to be set for all OPPs. More precisely, if the requested OPP has a valid
> > > level let's try to request it through the device's optional PM domain, via
> > > calling dev_pm_domain_set_performance_state().
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/opp/core.c | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index 60dca60ac4af..afb73978cdcb 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -1107,6 +1107,22 @@ void _update_set_required_opps(struct opp_table *opp_table)
> > >                 opp_table->set_required_opps = _opp_set_required_opps_generic;
> > >  }
> > >
> > > +static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
> > > +                         struct dev_pm_opp *opp)
> > > +{
> > > +       int ret = 0;
> > > +
> > > +       /* Request a new performance state through the device's PM domain. */
> > > +       if (opp && opp->level) {
> > > +               ret = dev_pm_domain_set_performance_state(dev, opp->level);
> > > +               if (ret)
> > > +                       dev_err(dev, "Failed to set performance state %u (%d)\n",
> > > +                               opp->level, ret);
> > > +       }
> >
> > Okay, so reviewing my own code found a problem here. We need an "else"
> > here, that should request the performance state to be set to 0.
> >
> > I am not sending a new version at this point, but awaiting more feedback first.
>
> I am looking to add below to this patch, is that okay with you ?
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7b505316bb1c..a113e9caaa5a 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1135,16 +1135,22 @@ void _update_set_required_opps(struct opp_table *opp_table)
>  static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
>                           struct dev_pm_opp *opp)
>  {
> +       unsigned int level = 0;
>         int ret = 0;
>
> -       /* Request a new performance state through the device's PM domain. */
> -       if (opp && opp->level) {
> -               ret = dev_pm_domain_set_performance_state(dev, opp->level);
> -               if (ret)
> -                       dev_err(dev, "Failed to set performance state %u (%d)\n",
> -                               opp->level, ret);
> +       if (opp) {
> +               if (!opp->level)
> +                       return 0;
> +
> +               level = opp->level;
>         }
>
> +       /* Request a new performance state through the device's PM domain. */
> +       ret = dev_pm_genpd_set_performance_state(dev, level);
> +       if (ret)
> +               dev_err(dev, "Failed to set performance state %u (%d)\n", level,
> +                       ret);
> +
>         return ret;
>  }
>
> I am switching back to dev_pm_genpd_set_performance_state() as I won't be
> applying the power domain changes.

Can you please explain further on this. Rafael has acked those
patches, so it should be perfectly fine for you to pick them via your
tree too. There is no need to defer them.

> I will then push out a branch and you can
> rebase your patches on top of it ? And then probably Sudeep or someone else can
> apply everything ?

Or are you suggesting to just take one of the patches from my series,
and then I will re-base everything on top?

Just trying to understand the way forward. :-)

Kind regards
Uffe
