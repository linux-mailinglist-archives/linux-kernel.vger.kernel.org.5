Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A37CA4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjJPKMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjJPKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:12:13 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F2DC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:12:11 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d84c24a810dso5092113276.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697451131; x=1698055931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=teBlxViKMUipO1j0WIhcACG5H8FSzPYvKzxeJQgHOtk=;
        b=iUyyFxCeD2Yn94KiBZGtDESmK/7djByRdPq/CGkj5JAN5tZDH0PjqdGNkEFo+rc2sj
         KQZo4enZOuIQIOq3wMYojBMcOt88GDRhhkqXrIDwZwsyetA3K5fZvJgGrwy7A/TyMQ9H
         ZIpp4aGNiCKEekawPxZul+7T2JKOc+nXdPVGEa2X3SQQG2ib3kU/trFKtjl2xqUp2UUu
         SEo0fQbiAmdg/NaL6HKHwy+sDthrk1ZYsXPOmpROtlZ/yiwjZ03fcVx7zaduyDxYbl/A
         y2yhQrmZVvWJDSEZb0ueyYjUOVJMBmd+oq2slwETWcqoBObYqB3B9nUkRjdLaoSpzmWo
         tQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451131; x=1698055931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teBlxViKMUipO1j0WIhcACG5H8FSzPYvKzxeJQgHOtk=;
        b=hgN83TnfKYCpNvL9zLiIKaV84G1EY++wRSOU+9063iMaevVtKicQiHaiTDuQGcOtPY
         a4tuxYj5DJMAGPFxmRL1WOvNdyInkmOHZnRID5XKkqQIxn4iXFqRLnDfq40/L+8aqjoh
         lZEqWyt5KbDj57U4bqL83aAYVzC4a22W37Yu1igmDDWsetRpwg/Hy6mOK4CSwgwnLsI8
         5BJ/Zj84uOvNYDdht0KVx34Ii5RliTCW2Vmh7Ysa53i0Q7KJB63vT0obYuFyoELuhYyA
         Og/MexhhvhKLxAava0Q6e0WcsVNC7thYc4PiIvL1/bjggbAw6SbNfHAp8ZfVq9HWhZbE
         pjkA==
X-Gm-Message-State: AOJu0YxKwrU05G/XWFvil9HYurOit3Sw2b7XGzMGmewVhsuP6FCTm9on
        obXrXD3H8yE8YalpXEg27lZsSGl2GC89yRRIgR6UzQ==
X-Google-Smtp-Source: AGHT+IFZtmtfATtcPgZHrM0i1PxChrWNenp2V+Cb6GprsyDQcnIS3TUWRbtTdrCfsvPQ+R/2xX7TjgXdSEOlC46VNt4=
X-Received: by 2002:a25:401:0:b0:d9a:634e:5ad3 with SMTP id
 1-20020a250401000000b00d9a634e5ad3mr14561897ybe.13.1697451130976; Mon, 16 Oct
 2023 03:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186772.git.viresh.kumar@linaro.org> <0890df8ddfafba0d9d214e73e4bb0e243a2db9fa.1697186772.git.viresh.kumar@linaro.org>
In-Reply-To: <0890df8ddfafba0d9d214e73e4bb0e243a2db9fa.1697186772.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 12:11:35 +0200
Message-ID: <CAPDyKFp=k23RFjSvn1QYfZYF6-e5dkN1BT69oopRceyq2mLCmQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] OPP: Add _link_required_opps() to avoid code duplication
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, 13 Oct 2023 at 10:48, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Factor out _link_required_opps() to remove duplicate code. No functional
> change.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/of.c | 62 ++++++++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 85e2af3d6a49..81fa27599d58 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -296,24 +296,41 @@ void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
>         of_node_put(opp->np);
>  }
>
> +static int _link_required_opps(struct dev_pm_opp *opp,
> +                              struct opp_table *required_table, int index)
> +{
> +       struct device_node *np;
> +
> +       np = of_parse_required_opp(opp->np, index);
> +       if (unlikely(!np))
> +               return -ENODEV;
> +
> +       opp->required_opps[index] = _find_opp_of_np(required_table, np);
> +       of_node_put(np);
> +
> +       if (!opp->required_opps[index]) {
> +               pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
> +                      __func__, opp->np, index);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
>  /* Populate all required OPPs which are part of "required-opps" list */
>  static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>                                        struct dev_pm_opp *opp)
>  {
> -       struct dev_pm_opp **required_opps;
>         struct opp_table *required_table;
> -       struct device_node *np;
>         int i, ret, count = opp_table->required_opp_count;
>
>         if (!count)
>                 return 0;
>
> -       required_opps = kcalloc(count, sizeof(*required_opps), GFP_KERNEL);
> -       if (!required_opps)
> +       opp->required_opps = kcalloc(count, sizeof(*opp->required_opps), GFP_KERNEL);
> +       if (!opp->required_opps)
>                 return -ENOMEM;
>
> -       opp->required_opps = required_opps;
> -
>         for (i = 0; i < count; i++) {
>                 required_table = opp_table->required_opp_tables[i];
>
> @@ -321,21 +338,9 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>                 if (IS_ERR_OR_NULL(required_table))
>                         continue;
>
> -               np = of_parse_required_opp(opp->np, i);
> -               if (unlikely(!np)) {
> -                       ret = -ENODEV;
> -                       goto free_required_opps;
> -               }
> -
> -               required_opps[i] = _find_opp_of_np(required_table, np);
> -               of_node_put(np);
> -
> -               if (!required_opps[i]) {
> -                       pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
> -                              __func__, opp->np, i);
> -                       ret = -ENODEV;
> +               ret = _link_required_opps(opp, required_table, i);
> +               if (ret)
>                         goto free_required_opps;
> -               }
>         }
>
>         return 0;
> @@ -350,22 +355,13 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>  static int lazy_link_required_opps(struct opp_table *opp_table,
>                                    struct opp_table *new_table, int index)
>  {
> -       struct device_node *required_np;
>         struct dev_pm_opp *opp;
> +       int ret;
>
>         list_for_each_entry(opp, &opp_table->opp_list, node) {
> -               required_np = of_parse_required_opp(opp->np, index);
> -               if (unlikely(!required_np))
> -                       return -ENODEV;
> -
> -               opp->required_opps[index] = _find_opp_of_np(new_table, required_np);
> -               of_node_put(required_np);
> -
> -               if (!opp->required_opps[index]) {
> -                       pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
> -                              __func__, opp->np, index);
> -                       return -ENODEV;
> -               }
> +               ret = _link_required_opps(opp, new_table, index);
> +               if (ret)
> +                       return ret;
>         }
>
>         return 0;
> --
> 2.31.1.272.g89b43f80a514
>
