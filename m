Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBFE80DBE9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbjLKUoO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 15:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKUoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:44:12 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66F9F;
        Mon, 11 Dec 2023 12:44:18 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5909156aea9so499990eaf.0;
        Mon, 11 Dec 2023 12:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327458; x=1702932258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeREiPriPrWtwP3pdr3EegoOX+dWJ7MdihH217BBpnA=;
        b=b9iNlsraf8aigEB920qwohqWgv8wvRjwe7d9rSpBTdDwGr4Rwf/Jk5CCnshCfkpN+u
         ssCSQ/ItgyU2xjPVtC1oETavsyTRxrs4x2FEySKuJD9QuCnoK6VhMLqCWmRnPj41Qmzq
         mUgj7ETfJKJ6kmfJSlBMLIOvCyzsU4XMkJMs3vXoffubuyxNf0gfGLRStAwqBsF+6lRo
         UQuawhmMxNg/62p5gml194emBjVPetaQRofKTgE0xaRCgHDxesk6QflJzphEbXdoan/3
         8zTYBNx+P8lgcTmCZMSJcpR9/MO04utvcYPk3UQIsaFU03ET/kEKuRCX9nYnGSKHjYje
         c0Zw==
X-Gm-Message-State: AOJu0Yxg3NOHo6RAURMMPEDnugds5rvQ+iNJCsXhkss0363RE+o3dp3y
        vw10ICAv7GzuVWkD9cmAdjODjBB0hXicVPW7jGQx5SHA
X-Google-Smtp-Source: AGHT+IF5nokFz42vvJTKNIHrAyvCr/vwnBehgSnRxhxX21ubnv0QG3aPj7gGukFBEADGhEhz6+xoJSL369lTIU4AoSU=
X-Received: by 2002:a4a:a7c4:0:b0:590:6585:5c41 with SMTP id
 n4-20020a4aa7c4000000b0059065855c41mr8414919oom.0.1702327457990; Mon, 11 Dec
 2023 12:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20231127151931.47055-1-ulf.hansson@linaro.org>
In-Reply-To: <20231127151931.47055-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 21:44:07 +0100
Message-ID: <CAJZ5v0jXRNDV7AhZPkrDvMtrk6cYeMJ+HuUs0kJ=kjbQ-YiyVA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 4:19 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
> level dance"), there is no longer any users of the
> pm_genpd_opp_to_performance_state() API. Let's therefore drop it and its
> corresponding ->opp_to_performance_state() callback, which also no longer
> has any users.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I can take this in principle, but I'm wondering if you'd prefer to
apply patches modifying domain.c yourself?  They are definitely
related to the pmdomain tree.

> ---
>  drivers/base/power/domain.c | 32 --------------------------------
>  include/linux/pm_domain.h   | 12 ------------
>  2 files changed, 44 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da1777e39eaa..cf65b5a9783c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -3042,38 +3042,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> -/**
> - * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
> - *
> - * @genpd_dev: Genpd's device for which the performance-state needs to be found.
> - * @opp: struct dev_pm_opp of the OPP for which we need to find performance
> - *     state.
> - *
> - * Returns performance state encoded in the OPP of the genpd. This calls
> - * platform specific genpd->opp_to_performance_state() callback to translate
> - * power domain OPP to performance state.
> - *
> - * Returns performance state on success and 0 on failure.
> - */
> -unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> -                                              struct dev_pm_opp *opp)
> -{
> -       struct generic_pm_domain *genpd = NULL;
> -       int state;
> -
> -       genpd = container_of(genpd_dev, struct generic_pm_domain, dev);
> -
> -       if (unlikely(!genpd->opp_to_performance_state))
> -               return 0;
> -
> -       genpd_lock(genpd);
> -       state = genpd->opp_to_performance_state(genpd, opp);
> -       genpd_unlock(genpd);
> -
> -       return state;
> -}
> -EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
> -
>  static int __init genpd_bus_init(void)
>  {
>         return bus_register(&genpd_bus_type);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 34663d0d5c55..b97c5e9820f9 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -118,7 +118,6 @@ struct genpd_power_state {
>  };
>
>  struct genpd_lock_ops;
> -struct dev_pm_opp;
>  struct opp_table;
>
>  struct generic_pm_domain {
> @@ -146,8 +145,6 @@ struct generic_pm_domain {
>         int (*power_on)(struct generic_pm_domain *domain);
>         struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
>         struct opp_table *opp_table;    /* OPP table of the genpd */
> -       unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
> -                                                struct dev_pm_opp *opp);
>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>                                      unsigned int state);
>         struct gpd_dev_ops dev_ops;
> @@ -348,8 +345,6 @@ int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n);
> -unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> -                                              struct dev_pm_opp *opp);
>
>  int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> @@ -395,13 +390,6 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
>         return -ENODEV;
>  }
>
> -static inline unsigned int
> -pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> -                                 struct dev_pm_opp *opp)
> -{
> -       return 0;
> -}
> -
>  static inline int genpd_dev_pm_attach(struct device *dev)
>  {
>         return 0;
> --
> 2.34.1
>
