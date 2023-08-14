Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E91277B8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjHNMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHNMeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:34:11 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4EBE4A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:34:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d66f105634eso1807610276.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692016449; x=1692621249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rs/cBEo3rqYRMTWU2EFQmctZrTV/0YAHrVzSp8vUhOQ=;
        b=HSErfQ1aapjonTuHNv6obvYcqjB9/RdfTci3m3c4EyJ9nw+uVuz4QMJLnGEr/0I/uk
         q76jsFT/eIURBhvjaIBy+MdCn+QWvn30Nesdxr7Et0URwnHqystKUvRR5Tb/IYbYDtLF
         oeyQ2VKUKtCE7tz2vSsy4lIpooP9i3ynWpbtdAcDiWPAediDatubMiKQXM8Kgu47uoV9
         AGl8LzezWlXW/DTuvvPJFHnvh4J5X4V4p0uzETppCNqKhB3VfI2DxlRhaWfQJnim4J78
         nxRDZF2Cok2UPAvDrfpZnzDOht+tcp6X1CiDLeqbgG9H7sAxA+zbi8vgr3UZepLToWiA
         t9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016449; x=1692621249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rs/cBEo3rqYRMTWU2EFQmctZrTV/0YAHrVzSp8vUhOQ=;
        b=WiXLuhKH65NZj9DVC6pFC+sOBL93BaTuAOKSonRtQoqHI8PBs1fpfEkvEHcwKQCB+Q
         8rufyQLjG3nxRuf08orsV9VMz2lfqmISeYcb3/ukubqm1uu5CGjqKn14x1wZwIlOJiWF
         q16tJP1A5LyxU0uh9/jAgeth6VTBh9idxBmOpu3f7TWQPO7GiYWbU5u8FJx7CFDclxoy
         BhTvYKUiTDjruvSo/GZXsVppevYy6c8HaggVRlBtODLxynxM5Wa61h65fsOhwssVGu68
         MrM88yAuKX92r4IezNMP5GxCsA60nYPnIMpWnCAIcXuCKpQ96WDZk0+0PYgPFlsF0LxT
         Uxkg==
X-Gm-Message-State: AOJu0YwvxmsWn3dmG21DDUrB7jSlZtZ+KSDr4ghbo4P8x4oriWC0fbqn
        lJfah3sIk1XRy1F9HRGKV10wpsHFVhr6eUcHckdaoQ==
X-Google-Smtp-Source: AGHT+IHf84ePhcxoW92ls15JLNJd2UwrevLR/ZjY8Le4cp50FZ9x6KglQIm/ABB+S4Ms6fzyn4div8MZ27oXWIxsJgw=
X-Received: by 2002:a05:6902:529:b0:d09:2cba:bcac with SMTP id
 y9-20020a056902052900b00d092cbabcacmr6521672ybs.65.1692016449625; Mon, 14 Aug
 2023 05:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230814104127.1929-1-peng.fan@oss.nxp.com> <20230814104127.1929-8-peng.fan@oss.nxp.com>
 <CAPDyKFqaA2q=jEYDwAE58vERcHC_rtNYpYf8TbvU80a29oFy3w@mail.gmail.com>
 <DU0PR04MB941702FF9AAFFFBBB7740C978817A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo+eLxea1tiovH2zpkc_rfqhSBbRtUAYygaSFGMfCRK-w@mail.gmail.com>
In-Reply-To: <CAPDyKFo+eLxea1tiovH2zpkc_rfqhSBbRtUAYygaSFGMfCRK-w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Aug 2023 14:33:33 +0200
Message-ID: <CAPDyKFrAZ0176wZT0iGZ2-sT09KRqxCN2dOm_0-+J3pdESYctw@mail.gmail.com>
Subject: Re: [PATCH V4 7/8] genpd: imx: scu-pd: add multi states support
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 14 Aug 2023 at 13:52, Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Re: [PATCH V4 7/8] genpd: imx: scu-pd: add multi states support
> > >
> > > On Mon, 14 Aug 2023 at 12:37, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > wrote:
> > > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Add multi states support, this is to support devices could run in LP
> > > > mode when runtime suspend, and OFF mode when system suspend.
> > >
> > > For my understanding, is there a functional problem to support OFF at
> > > runtime suspend too?
> >
> > In OFF mode, the HW state is lost, so the clks that exported by this(Subsystem)
> > genpd is lost. While in LF mode, no need handle clks recover.
> >
> >
> > Such as subsystem LSIO has clks output, has GPIO, has LPUART.
> >
> > The clks are in drivers/clk/imx/clk-imx8qxp*, which relies on the scu pd.
> >
> > If scu-pd is off, the clks will lose state.
>
> Thanks for clarifying, much appreciated! So it sounds like it's the
> clock provider(s) that has these requirements then. Can we let the
> clock provider set a QoS latency constraint for its device that is
> attached to the genpd then? To prevent the deeper OFF state?
>
> Another option would be to enable runtime PM support for the clock
> provider (to manage the save/restore from runtime PM callbacks), but
> whether that's feasible sounds like a separate discussion.
>
> >
> > >
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/genpd/imx/scu-pd.c | 48
> > > > ++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 46 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
> > > > index 2f693b67ddb4..30da101119eb 100644
> > > > --- a/drivers/genpd/imx/scu-pd.c
> > > > +++ b/drivers/genpd/imx/scu-pd.c
> > > > @@ -65,6 +65,12 @@
> > > >  #include <linux/pm_domain.h>
> > > >  #include <linux/slab.h>
> > > >
> > > > +enum {
> > > > +       PD_STATE_LP,
> > > > +       PD_STATE_OFF,
> > > > +       PD_STATE_MAX
> > > > +};
> > > > +
> > > >  /* SCU Power Mode Protocol definition */  struct
> > > > imx_sc_msg_req_set_resource_power_mode {
> > > >         struct imx_sc_rpc_msg hdr;
> > > > @@ -368,7 +374,8 @@ static int imx_sc_pd_power(struct
> > > generic_pm_domain *domain, bool power_on)
> > > >         hdr->size = 2;
> > > >
> > > >         msg.resource = pd->rsrc;
> > > > -       msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON :
> > > IMX_SC_PM_PW_MODE_LP;
> > > > +       msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : pd-
> > > >pd.state_idx ?
> > > > +                  IMX_SC_PM_PW_MODE_OFF : IMX_SC_PM_PW_MODE_LP;
> > > >
> > > >         /* keep uart console power on for no_console_suspend */
> > > >         if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled &&
> > > > !power_on) @@ -412,11 +419,33 @@ static struct generic_pm_domain
> > > *imx_scu_pd_xlate(struct of_phandle_args *spec,
> > > >         return domain;
> > > >  }
> > > >
> > > > +static bool imx_sc_pd_suspend_ok(struct device *dev) {
> > > > +       /* Always true */
> > > > +       return true;
> > > > +}
> > > > +
> > > > +static bool imx_sc_pd_power_down_ok(struct dev_pm_domain *pd) {
> > > > +       struct generic_pm_domain *genpd = pd_to_genpd(pd);
> > > > +
> > > > +       /* For runtime suspend, choose LP mode */
> > > > +       genpd->state_idx = 0;
> > > > +
> > > > +       return true;
> > > > +}
> > >
> > > I am wondering if we couldn't use the simple_qos_governor here instead. In
> > > principle it looks like we want a QoS latency constraint to be set during
> > > runtime, to prevent the OFF state.
> >
> > LP mode indeed could save resume time, but the major problem is to avoid
> > save/restore clks.
>
> Okay. So it still sounds like a QoS latency constraint (for the clock
> provider) sounds like the correct thing to do.
>
> If/when the clock provider gets runtime PM support, we can remove the
> QoS latency constraints. That should work, right?
>
> > >
> > > During system wide suspend, the deepest state is always selected by genpd.
> > >
> > > > +
> > > > +struct dev_power_governor imx_sc_pd_qos_governor = {
> > > > +       .suspend_ok = imx_sc_pd_suspend_ok,
> > > > +       .power_down_ok = imx_sc_pd_power_down_ok, };
> > > > +
> > > >  static struct imx_sc_pm_domain *
> > > >  imx_scu_add_pm_domain(struct device *dev, int idx,
> > > >                       const struct imx_sc_pd_range *pd_ranges)  {
> > > >         struct imx_sc_pm_domain *sc_pd;
> > > > +       struct genpd_power_state *states;
> > > >         bool is_off;
> > > >         int mode, ret;
> > > >
> > > > @@ -427,9 +456,22 @@ imx_scu_add_pm_domain(struct device *dev, int
> > > idx,
> > > >         if (!sc_pd)
> > > >                 return ERR_PTR(-ENOMEM);
> > > >
> > > > +       states = devm_kcalloc(dev, PD_STATE_MAX, sizeof(*states),
> > > GFP_KERNEL);
> > > > +       if (!states) {
> > > > +               devm_kfree(dev, sc_pd);
> > > > +               return ERR_PTR(-ENOMEM);
> > > > +       }
> > > > +
> > > >         sc_pd->rsrc = pd_ranges->rsrc + idx;
> > > >         sc_pd->pd.power_off = imx_sc_pd_power_off;
> > > >         sc_pd->pd.power_on = imx_sc_pd_power_on;
> > > > +       states[PD_STATE_LP].power_off_latency_ns = 25000;
> > > > +       states[PD_STATE_LP].power_on_latency_ns =  25000;
> > > > +       states[PD_STATE_OFF].power_off_latency_ns = 2500000;
> > > > +       states[PD_STATE_OFF].power_on_latency_ns =  2500000;
> > >
> > > We should probably describe these in DT instead? The domain-idle-states
> > > bindings allows us to do this. See
> > > Documentation/devicetree/bindings/power/domain-idle-state.yaml.
> >
> > The scu-pd is a firmware function node, there is no sub-genpd node inside it.
> >
> > Just like scmi pd, there is no sub-genpd in it.
>
> Not sure I got your point. We don't need a sub-genpd node to describe
> this. This is how it could look like:
>
> domain-idle-states {
>     domain_retention: domain-retention {
>         compatible = "domain-idle-state";
>         entry-latency-us = <25>;
>         exit-latency-us = <25>;
>     };
>     domain_off: domain-off {
>         compatible = "domain-idle-state";
>         entry-latency-us = <2500>;
>         exit-latency-us = <2500>;
>     };
> };
>
> power-controller {
>     compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
>     #power-domain-cells = <1>;
>     domain-idle-states = <&domain_retention>, <&domain_off>;
> };

Ahh, now I think I got your point. The domain-idle-states need a
corresponding power-domain specifier too, right?

Can we do something along the lines of the below:

domain-idle-states = <&domain_retention domain-id>, <&domain_off domain-id>;

Anyway, I don't have a strong opinion about moving this to the DT, if
you want to keep the values in the code, that works too.

Kind regards
Uffe
