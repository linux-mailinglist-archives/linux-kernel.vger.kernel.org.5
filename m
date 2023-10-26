Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100F37D8011
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjJZJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:54:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235589D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:54:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9adca291f99so103440666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698314071; x=1698918871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I3YDr2ocn/6g63a/V8roX2GZ1TJCeG5AXnyiXnJWo6c=;
        b=C7YqiIBGPGeUcoRDPav9RWGeNFzIEQiIUd0IeKAaNN8sEXfJDE1BKDf109T/Vkd1fs
         GWIzNi2F3C7+1gH0NceqJ8MKbsFGQw3tUMnHTcUjOfaXYQykBYlUHGll0x4nDEd19e4I
         WR4Nao8G2sV/w3pEhT/JTZjNmgfBw/LirdMMXLGsYCtzyx8NIx5+umaiTQibTpMUvlyQ
         q9xg4BDZhTRQM62LjGl+qSj8V7vFe8RwKimeZp/YhamUSnwLjrCUPew4VipydzNzrUZs
         RR1l/lac1WDelsj3eHdfMaxcDYXZAraaAiZldkcVJC6ZraoSWgPIQ2GMrBzCpsQdMo8f
         uBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314071; x=1698918871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3YDr2ocn/6g63a/V8roX2GZ1TJCeG5AXnyiXnJWo6c=;
        b=ZYnj4WSn/YsRDomy2h/NwL25m1PbYYyinGYRLEja/ivL1Fmd/ryGvfWYLSRbAjKXWB
         NsGIjhOcEeyN1OrJbcu2ico2jilE6tNnySGcTJ57XEtSk6GB02on2QreW76m1NouiBpU
         Yh3NdlFMsw3XCqwXGItyIIygjzjKjF04cc40jEx1GVgeZzEs+d0R6qj7Yd/YoyHTY1JT
         9ZBk+WoooUB865b2utGDHBHe4S2/cF82E/f9evIAnHADsUDAT9fYtFYQHuIvIBKQUDKG
         sVlTHpXuThCRBiW0sEVZVOWFjauGl+4dHwARbJP6kmOwYF6B/N8GCJr4cA6p1IC1LKrN
         fx1A==
X-Gm-Message-State: AOJu0YxCLVcVhywPMYvjVyt15M7HpvJsC8R/8etDa7CpabfCbPOu6wgV
        X0IDa2YSF9R3E8/GZvZ6YbKZ0Tu4U1Ahbgw8X5j2cA==
X-Google-Smtp-Source: AGHT+IFW+iNdf/9vQKMMQNHZ3ZdkddTY789qTXZsZMeUFAwKGk/GtoPJGODBCDJoQUU5k9ZyoMTBmVkuBt31+V96HM8=
X-Received: by 2002:a17:907:2ce2:b0:9bd:d7bd:1a52 with SMTP id
 hz2-20020a1709072ce200b009bdd7bd1a52mr12923436ejc.20.1698314071109; Thu, 26
 Oct 2023 02:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7> <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net>
In-Reply-To: <ZTkciw5AwufxQYnB@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Oct 2023 11:53:53 +0200
Message-ID: <CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 15:49, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Wed, Oct 25, 2023 at 12:40:26PM +0200, Ulf Hansson wrote:
> > On Wed, 25 Oct 2023 at 08:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 19-10-23, 13:16, Ulf Hansson wrote:
> > > > On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > +static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_table,
> > > > >                                struct opp_table *required_table, int index)
> > > > >  {
> > > > >         struct device_node *np;
> > > > > @@ -314,6 +314,25 @@ static int _link_required_opps(struct dev_pm_opp *opp,
> > > > >                 return -ENODEV;
> > > > >         }
> > > > >
> > > > > +       /*
> > > > > +        * There are two genpd (as required-opp) cases that we need to handle,
> > > > > +        * devices with a single genpd and ones with multiple genpds.
> > > > > +        *
> > > > > +        * The single genpd case requires special handling as we need to use the
> > > > > +        * same `dev` structure (instead of a virtual one provided by genpd
> > > > > +        * core) for setting the performance state. Lets treat this as a case
> > > > > +        * where the OPP's level is directly available without required genpd
> > > > > +        * link in the DT.
> > > > > +        *
> > > > > +        * Just update the `level` with the right value, which
> > > > > +        * dev_pm_opp_set_opp() will take care of in the normal path itself.
> > > > > +        */
> > > > > +       if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
> > > > > +           !opp_table->genpd_virt_devs) {
> > > > > +               if (!WARN_ON(opp->level))
> > > >
> > > > Hmm. Doesn't this introduce an unnecessary limitation?
> > > >
> > > > An opp node that has a required-opps phande, may have "opp-hz",
> > > > "opp-microvolt", etc. Why would we not allow the "opp-level" to be
> > > > used too?
> > >
> > > Coming back to this, why would we ever want a device to have "opp-level" and
> > > "required-opp" (set to genpd's table) ? That would mean we will call:
> > >
> > > dev_pm_domain_set_performance_state() twice to set different level values.
> >
> > Yes - and that would be weird, especially since the PM domain (genpd)
> > is already managing the aggregation and propagation to parent domains.
> >
>
> FWIW I'm hitting this WARNing when trying to set up the parent domain
> setup for CPR->RPMPD(MX) on MSM8916 that I discussed with Uffe recently
> [1]. I know, me and all my weird OPP setups. :'D
>
> Basically, I have cpufreq voting for performance states of the CPR genpd
> (via required-opps). CPR is supposed to have <&rpmpd MSM8916_VDDMX_AO>
> as parent genpd and translates to the parent performance state using the
> "required-opps" in the *CPR* OPP table:
>
>         cpr: power-controller@b018000 {
>                 compatible = "qcom,msm8916-cpr", "qcom,cpr";
>                 reg = <0x0b018000 0x1000>;
>                 /* ... */
>                 #power-domain-cells = <0>;
>                 operating-points-v2 = <&cpr_opp_table>;
>                 /* Supposed to be parent domain, not consumer */
>                 power-domains = <&rpmpd MSM8916_VDDMX_AO>;
>
>                 cpr_opp_table: opp-table {
>                         compatible = "operating-points-v2-qcom-level";
>
>                         cpr_opp1: opp1 {
>                                 opp-level = <1>;
>                                 qcom,opp-fuse-level = <1>;
>                                 required-opps = <&rpmpd_opp_svs_soc>;
>                         };
>                         cpr_opp2: opp2 {
>                                 opp-level = <2>;
>                                 qcom,opp-fuse-level = <2>;
>                                 required-opps = <&rpmpd_opp_nom>;
>                         };
>                         cpr_opp3: opp3 {
>                                 opp-level = <3>;
>                                 qcom,opp-fuse-level = <3>;
>                                 required-opps = <&rpmpd_opp_super_turbo>;
>                         };
>                 };
>         };
>
> There are two problems with this:
>
>  1. (Unrelated to $subject patch)
>     Since there is only a single entry in "power-domains", the genpd
>     core code automatically attaches the CPR platform device as consumer
>     of the VDDMX_AO power domain. I don't want this, I want it to become
>     child of the VDDMX_AO genpd.
>
>     I added some hacky code to workaround this. One option that works is
>     to add a second dummy entry to "power-domains", which will prevent
>     the genpd core from attaching the power domain:
>
>         power-domains = <&rpmpd MSM8916_VDDMX_AO>, <0>;

Hmm, looks a bit hackish to me.

>
>     The other option is detaching the power domain again in probe(),
>     after setting it up as parent domain:

Yes, if needed.

>
>         struct of_phandle_args parent, child;
>
>         child.np = dev->of_node;
>         child.args_count = 0;
>
>         of_parse_phandle_with_args(dev->of_node, "power-domains",
>                                    "#power-domain-cells", 0, &parent));
>         of_genpd_add_subdomain(&parent, &child);
>
>         /* Detach power domain since it's managed via the subdomain */
>         dev_pm_domain_detach(dev, false);
>
>     Is there a cleaner way to handle this? Mainly a question for Uffe.

At the moment, I don't think so. In fact, we have situations when the
attachment is really useful.

For example, during ->probe(), one can do a pm_runtime_get_sync() to
power-on the "parent" domain. This may be needed to synchronize the
power-states between the child/parent-domains, before calling
of_genpd_add_subdomain().

>
>  2. The OPP WARNing triggers with both variants because it just checks
>     if "required-opps" has a single entry. I guess we need extra checks
>     to exclude the "parent genpd" case compared to the "OPP" case.
>
>         [    1.116244] WARNING: CPU: 2 PID: 36 at drivers/opp/of.c:331 _link_required_opps+0x180/0x1cc
>         [    1.125897] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>         [    1.146887] pc : _link_required_opps+0x180/0x1cc
>         [    1.146902] lr : _link_required_opps+0xdc/0x1cc
>         [    1.276408] Call trace:
>         [    1.283519]  _link_required_opps+0x180/0x1cc
>         [    1.285779]  _of_add_table_indexed+0x61c/0xd40
>         [    1.290292]  dev_pm_opp_of_add_table+0x10/0x18
>         [    1.294546]  of_genpd_add_provider_simple+0x80/0x160
>         [    1.298974]  cpr_probe+0x6a0/0x97c
>         [    1.304092]  platform_probe+0x64/0xbc
>
> It does seem to work correctly, with and without this patch. So I guess
> another option might be to simply silence this WARN_ON(). :')

Oh, thanks for pointing this out! This case haven't crossed my mind yet!

Allow me to think a bit more about it. I will get back to you again
with a suggestion soon, unless Viresh comes back first. :-)

[...]

Kind regards
Uffe
