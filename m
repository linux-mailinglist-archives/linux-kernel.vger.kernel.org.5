Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9217CF674
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbjJSLQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345301AbjJSLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:16:53 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196B11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:16:51 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9cb74cf53fso449510276.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697714210; x=1698319010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NgYcXpsAufBvhvqvkU9EfIFdvCzKhOZm6VhiqN3orBs=;
        b=tCWnJj9WE51uYOiXi2l4HBFYag9C2FVpqUiUpSDkESiarWHDVGJjStxvZ1jA3vT6ub
         0W3ArpfEUmKmlxruEL9fW8zIzc+WWCxqL/bm4lVOqb8IFqGwGTijLOmFdz+BMaOnRJl5
         R3dtz85De5u4b0ar9R0ncdyLaFbTDNGoRPbukmlH6Z+RT1KCeurJbf5+mfS29CGz5cng
         k2ruZglNPZgR6z2sSQjC4eIC6LROMq+f6Qs1q8Ltu1vsU4JbmHOeY2YOXC+FAjhKVqDr
         HArFxhaehWV/5OUeZaRqDnNH9blD+Uq64A4QcTFWzbSZ5Oq1EzqlljHPDGCBeH2kBlPj
         noOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714210; x=1698319010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgYcXpsAufBvhvqvkU9EfIFdvCzKhOZm6VhiqN3orBs=;
        b=WbKVfOfbh3/uMFAtsutQ/S08+cCVtuvPXJgoIhuhV88FMirvnJ+IRSaaDwicOvE2i5
         Zlc7oW+2RcvcJLG/xzXd7cKf0UNJxHTaq1k+Cdj77f5XAToiTPYgZTY/EPPu6o5hSxj8
         q7A0HOeczHBByA1lGaNxTCR9RTUBKltECO+tvrCtkgN+a3osd3pNCnoDKPzrMexrZaDq
         k9ufym0jcnZAKEr+V4pvlqu+3H3cuYtbAFF2z6xO6c/uxD3A6PEIr4OcI4ksg89LG52X
         bRwWw1DsElV9iw1x7kQLNxxsB075LyYDl9J+krSoedwLcYB2sBdH2mWpVJeVkMlZ9+z2
         x1zw==
X-Gm-Message-State: AOJu0YwrqxcZhNxlWhQqx00De/jLduWD4MVjdWyf9sKvzdCThLxHoe6E
        rRG3MZS7ZkOc6h4/KZuoR73UxH+BkItrJUng3B022Q==
X-Google-Smtp-Source: AGHT+IHaHfcpYADWfbOu61f1MZkU41LPowQtu2w3zd0HGrnOQ7xVjctaIEtW0Wjzzy4Dfec3kuxT4taaXyTcmCcNrCg=
X-Received: by 2002:a5b:c12:0:b0:d9a:4362:67ac with SMTP id
 f18-20020a5b0c12000000b00d9a436267acmr1971034ybq.15.1697714210265; Thu, 19
 Oct 2023 04:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
In-Reply-To: <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 13:16:14 +0200
Message-ID: <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There are two genpd (as required-opp) cases that we need to handle,
> devices with a single genpd and ones with multiple genpds.
>
> The multiple genpds case is clear, where the OPP core calls
> dev_pm_domain_attach_by_name() for them and uses the virtual devices
> returned by this helper to call dev_pm_domain_set_performance_state()
> later to change the performance state.
>
> The single genpd case however requires special handling as we need to
> use the same `dev` structure (instead of a virtual one provided by genpd
> core) for setting the performance state via
> dev_pm_domain_set_performance_state().
>
> As we move towards more generic code to take care of the required OPPs,
> where we will recursively call dev_pm_opp_set_opp() for all the required
> OPPs, the above special case becomes a problem.
>
> Eventually we want to handle all performance state changes via
> _set_opp_level(), so lets move the single genpd case to that right away.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c |  6 ++++--
>  drivers/opp/of.c   | 25 ++++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 84f345c69ea5..aab8c8e79146 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1074,10 +1074,12 @@ static int _opp_set_required_opps_generic(struct device *dev,
>  static int _opp_set_required_opps_genpd(struct device *dev,
>         struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
>  {
> -       struct device **genpd_virt_devs =
> -               opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
> +       struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
>         int index, target, delta, ret;
>
> +       if (!genpd_virt_devs)
> +               return 0;
> +
>         /* Scaling up? Set required OPPs in normal order, else reverse */
>         if (!scaling_down) {
>                 index = 0;
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 81fa27599d58..e056f31a48b5 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -296,7 +296,7 @@ void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
>         of_node_put(opp->np);
>  }
>
> -static int _link_required_opps(struct dev_pm_opp *opp,
> +static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_table,
>                                struct opp_table *required_table, int index)
>  {
>         struct device_node *np;
> @@ -314,6 +314,25 @@ static int _link_required_opps(struct dev_pm_opp *opp,
>                 return -ENODEV;
>         }
>
> +       /*
> +        * There are two genpd (as required-opp) cases that we need to handle,
> +        * devices with a single genpd and ones with multiple genpds.
> +        *
> +        * The single genpd case requires special handling as we need to use the
> +        * same `dev` structure (instead of a virtual one provided by genpd
> +        * core) for setting the performance state. Lets treat this as a case
> +        * where the OPP's level is directly available without required genpd
> +        * link in the DT.
> +        *
> +        * Just update the `level` with the right value, which
> +        * dev_pm_opp_set_opp() will take care of in the normal path itself.
> +        */
> +       if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
> +           !opp_table->genpd_virt_devs) {
> +               if (!WARN_ON(opp->level))

Hmm. Doesn't this introduce an unnecessary limitation?

An opp node that has a required-opps phande, may have "opp-hz",
"opp-microvolt", etc. Why would we not allow the "opp-level" to be
used too?

> +                       opp->level = opp->required_opps[0]->level;
> +       }
> +
>         return 0;
>  }
>
> @@ -338,7 +357,7 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>                 if (IS_ERR_OR_NULL(required_table))
>                         continue;
>
> -               ret = _link_required_opps(opp, required_table, i);
> +               ret = _link_required_opps(opp, opp_table, required_table, i);
>                 if (ret)
>                         goto free_required_opps;
>         }
> @@ -359,7 +378,7 @@ static int lazy_link_required_opps(struct opp_table *opp_table,
>         int ret;
>
>         list_for_each_entry(opp, &opp_table->opp_list, node) {
> -               ret = _link_required_opps(opp, new_table, index);
> +               ret = _link_required_opps(opp, opp_table, new_table, index);
>                 if (ret)
>                         return ret;
>         }

Kind regards
Uffe
