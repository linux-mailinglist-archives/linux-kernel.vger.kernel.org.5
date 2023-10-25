Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDD47D6E37
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbjJYNw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjJYNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:52:26 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D95119A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:52:21 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce31c4a653so3534801a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698241940; x=1698846740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mf/tOcZ/6jE6930UPVsDhW3+wB63K7ieLNSBZLgxFJI=;
        b=ZPjEoxuS5R59F2zrlFA6WWCM974AtzUlOe0xRXViOjAc4pJwoGRHqXXvlMnXUiQO4s
         74U4VMuansi8SsSh8Iu7pJx/VGMI5oplOX6TZS5MoN0lcLHYXhNlUuSq595IvH/FY/dP
         1FbXWo1q8Zmp4NuFU2WvOtaLpr5WEzIctfS8A+vt1e20we1GRbB2h3W3aWeapXHngJp4
         LzcAO3QsI5Z7ZPHYA8y04TivS/uQ0k+uGSKoNZ/J+BQnqQf6/v6ld7kLTLnbqJRteVmD
         ddCZZIheF1Womisa65bb4QZ5yv0LWGfsqxpx8LCXSVPrmS6UbnV4IDxG0BGqt/dZehq3
         28tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241940; x=1698846740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mf/tOcZ/6jE6930UPVsDhW3+wB63K7ieLNSBZLgxFJI=;
        b=R3YISrNLTyBdBpTrNdUi9+jvhOYPCx2MNwnvtQZdOr3cshlVpCmElqqdv9kQaG2VBE
         AkhcvAGrVhGEJwNfNSXHbCydAj+Ut84PkoPWTC3RbhaSIB9/ffQwv4M/9I7BN8yHMY5A
         9FfXddCdORZm9dZHykcQOLa5KpU5Ofje9cGf/sqZLru0tB6LRFMzRIYB0PdDG8iSEz5A
         OGQl+i6ogW28eRce09NhtfPF+qP5EMsNIIu40nBxT2pvmSJ0vuln/k/OSEPZA/FGYau+
         IYL2IEITNlxDkZcWnPK2ugvxMYDrylTzmdBeN8rmCqrcctzekTtpC4bIpw9/cH8Uhm5z
         GrUQ==
X-Gm-Message-State: AOJu0YwSNk1cMROyiyMBmaaJmct36O0Au779SVfqz4WPXs1Yhcr9rWQ/
        PYEhLNmYW2g7+nIhfwxd36gX9YGgn1GDTimDOe7Y8A==
X-Google-Smtp-Source: AGHT+IFMoW8roXMXarWSypKnJrf/6MjvgsvKah8L+3caWOq7aUiIdJho9FtYtlh2vc095UiJNLahg6+nRgN6fJgYkUg=
X-Received: by 2002:a05:6830:2693:b0:6bd:cf64:d105 with SMTP id
 l19-20020a056830269300b006bdcf64d105mr18356016otu.12.1698241940472; Wed, 25
 Oct 2023 06:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
In-Reply-To: <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Oct 2023 15:51:44 +0200
Message-ID: <CAPDyKFrxFmNZpNdwQs3CS0NzmDjtCaNSQWkT=zW1Tm+MommWkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] OPP: Call dev_pm_opp_set_opp() for required OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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

On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Configuring the required OPP was never properly implemented, we just
> took an exception for genpds and configured them directly, while leaving
> out all other required OPP types.
>
> Now that a standard call to dev_pm_opp_set_opp() takes care of
> configuring the opp->level too, the special handling for genpds can be
> avoided by simply calling dev_pm_opp_set_opp() for the required OPPs,
> which shall eventually configure the corresponding level for genpds.
>
> This also makes it possible for us to configure other type of required
> OPPs (no concrete users yet though), via the same path. This is how
> other frameworks take care of parent nodes, like clock, regulators, etc,
> where we recursively call the same helper.
>
> In order to call dev_pm_opp_set_opp() for the virtual genpd devices,
> they must share the OPP table of the genpd. Call _add_opp_dev() for them
> to get that done.
>
> This commit also extends the struct dev_pm_opp_config to pass required
> devices, for non-genpd cases, which can be used to call
> dev_pm_opp_set_opp() for the non-genpd required devices.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c     | 144 ++++++++++++++++++-----------------------
>  drivers/opp/of.c       |  12 ++--
>  drivers/opp/opp.h      |   8 +--
>  include/linux/pm_opp.h |   7 +-
>  4 files changed, 76 insertions(+), 95 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index aab8c8e79146..056b51abc501 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c

[...]

> -static int _opp_set_required_opps_genpd(struct device *dev,
> -       struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
> +/* This is only called for PM domain for now */
> +static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> +                             struct dev_pm_opp *opp, bool up)
>  {
> -       struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
> +       struct device **devs = opp_table->required_devs;
>         int index, target, delta, ret;
>
> -       if (!genpd_virt_devs)
> -               return 0;

Rather than continue the path below, wouldn't it be better to return 0
"if (!devs)" here?

If I understand correctly, the code below does manage this condition,
so it's not strictly needed though.

> +       /* required-opps not fully initialized yet */
> +       if (lazy_linking_pending(opp_table))
> +               return -EBUSY;
>
>         /* Scaling up? Set required OPPs in normal order, else reverse */
> -       if (!scaling_down) {
> +       if (up) {
>                 index = 0;
>                 target = opp_table->required_opp_count;
>                 delta = 1;
> @@ -1092,9 +1069,11 @@ static int _opp_set_required_opps_genpd(struct device *dev,
>         }
>
>         while (index != target) {
> -               ret = _set_performance_state(dev, genpd_virt_devs[index], opp, index);
> -               if (ret)
> -                       return ret;
> +               if (devs[index]) {
> +                       ret = dev_pm_opp_set_opp(devs[index], opp);
> +                       if (ret)
> +                               return ret;
> +               }
>
>                 index += delta;
>         }

[...]

>
>  /*
> @@ -2429,15 +2374,10 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>         int index = 0, ret = -EINVAL;
>         const char * const *name = names;
>
> -       if (opp_table->genpd_virt_devs)
> +       /* Checking only the first one is enough ? */
> +       if (opp_table->required_devs[0])

The allocation of opp_table->required_devs is being done from
_opp_table_alloc_required_tables(), which doesn't necessarily
allocate/assign the data for it.

Maybe check "opp_table->required_devs" instead, to make that clear?

>                 return 0;
>
> -       opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
> -                                            sizeof(*opp_table->genpd_virt_devs),
> -                                            GFP_KERNEL);
> -       if (!opp_table->genpd_virt_devs)
> -               return -ENOMEM;
> -
>         while (*name) {
>                 if (index >= opp_table->required_opp_count) {
>                         dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
> @@ -2452,13 +2392,25 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>                         goto err;
>                 }
>
> -               opp_table->genpd_virt_devs[index] = virt_dev;
> +               /*
> +                * Add the virtual genpd device as a user of the OPP table, so
> +                * we can call dev_pm_opp_set_opp() on it directly.
> +                *
> +                * This will be automatically removed when the OPP table is
> +                * removed, don't need to handle that here.
> +                */
> +               if (!_add_opp_dev(virt_dev, opp_table->required_opp_tables[index])) {
> +                       ret = -ENOMEM;
> +                       goto err;
> +               }
> +
> +               opp_table->required_devs[index] = virt_dev;
>                 index++;
>                 name++;
>         }
>
>         if (virt_devs)
> -               *virt_devs = opp_table->genpd_virt_devs;
> +               *virt_devs = opp_table->required_devs;
>
>         return 0;
>
> @@ -2468,10 +2420,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>
>  }
>
> +static void _opp_set_required_devs(struct opp_table *opp_table,
> +                                  struct device **required_devs)
> +{
> +       int i;
> +
> +       /* Another CPU that shares the OPP table has set the required devs ? */

Not sure I fully understand the above comment. Is this the only
relevant use-case or could there be others too?

> +       if (opp_table->required_devs[0])

Maybe check opp_table->required_devs instead?

> +               return;
> +
> +       for (i = 0; i < opp_table->required_opp_count; i++)
> +               opp_table->required_devs[i] = required_devs[i];

To be safe, don't we need to check the in-parameter required_devs?

Or we should simply rely on the callers of dev_pm_opp_set_config() to
do the right thing?

[...]

Besides the minor things above, this looks really great to me! Feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
