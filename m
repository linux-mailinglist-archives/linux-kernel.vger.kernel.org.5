Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4092810E81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjLMKeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLMKeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:34:14 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC4AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:34:20 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so6435823276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463659; x=1703068459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MiCuJGdqU3JpN4sR605F4gpjnmDDPjE+WkJpEGI+07w=;
        b=Al5DynLsK6MMCjJWHslSzhx12RKhrjNpAUjEmg7JHVtivmWyGFFvHz+26d4Gg7ZPHq
         b8zTTDneMkAgxCaYVQAsG6zFctO1tHB3gXkDnOPC+yn/iEXIuSRtsTej9pQtwn8y3DZU
         TfwBS+XbOPskq8SkH1UhjmhHpZbCAqp6aQaHZTBUn2RhNVFi1RVPAEHal/ZHKuMyl+KD
         7TMieGoAXcirKaDllxlkDSoi11gD8S+qJ7Cj/x6RjQSUZ9lpVU5yjU8CMdBYQknzlOjc
         7l+Xy+gg1YKyGHAyWvun9eEWAFx0awHSGmWTdQfdoO8x4gS9xpjeGcbTCIAy5ML4EP1h
         7G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463659; x=1703068459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiCuJGdqU3JpN4sR605F4gpjnmDDPjE+WkJpEGI+07w=;
        b=XLDB7R2P5fNG6XHCRlao5bxhRfsUbMMlsHoj8vp/dScv4l85FicuV61KVAnuQBxgGy
         HfWaskEIF5CNW6GsOfHg9ZjpdwJkNJGggGF/OGED99NGuXL8s198NG4qWi0aw50aiDs0
         bXhzuJP/gCgTgHHP+a+NsKnuj3vEpLGSFp9LFHWtLbq4bGm0qw5kC7j5Q/vWsTajtqua
         25/JQt4vXKP5txs9Emd8Vw4v1SS8b1EWfmiZunSkLc5MDyoo+i0yFUTE2DzSm4h5Wn3A
         yHKj99jY339K8/vXVHdxraRdWU9qAHiVzjGirAOvi/ngtOKMJE0tPQVvVj6O/1jHUYHz
         6BHg==
X-Gm-Message-State: AOJu0Yz8/tRe1IVJ5LUwEmKE96HjTaYeBrjZZxkZ7KokxYyGEomowzC6
        Ro7+Xrk0ddUfvhDsziwUIt98rlCCs4BJRl0MD61xoQ==
X-Google-Smtp-Source: AGHT+IFgD1jVe3bhFgxKF39rvDQ+ntKZdf/plcoM/+rcHzXjRXeTMPPO0CRFY6Bnj0jPZjnuV1UQVLT74ShuhRh7MPg=
X-Received: by 2002:a25:bec3:0:b0:db5:49d8:bcd1 with SMTP id
 k3-20020a25bec3000000b00db549d8bcd1mr4676061ybm.55.1702463659338; Wed, 13 Dec
 2023 02:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20231127151931.47055-1-ulf.hansson@linaro.org>
In-Reply-To: <20231127151931.47055-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Dec 2023 11:33:43 +0100
Message-ID: <CAPDyKFofR7AHDctZErs3QG_mXdnhY+yjqNYungim+yeLpx1gBQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 at 16:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
> level dance"), there is no longer any users of the
> pm_genpd_opp_to_performance_state() API. Let's therefore drop it and its
> corresponding ->opp_to_performance_state() callback, which also no longer
> has any users.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

So, I have applied this for next and by adding your ack.

Kind regards
Uffe


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
