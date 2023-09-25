Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9322E7AD93B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjIYNef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjIYNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:34:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35793E8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:34:26 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d86a0c97ae6so2585174276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695648865; x=1696253665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FqmWWR+G31hZDZUGZwMonL2cb5Bksu8antYerZiIOYs=;
        b=gbN24MEulHvwjYFQHPDX8C7xaIVJT92ZeJE24qjdsMU2H2mSIUkxuvweCi5/j4EiJ6
         BOFCqvUNReRxZ2nd0m9i0lYbl3x4Kog47wqlDcepVYLpi83rilHcoxphBy0MFZTWzBjd
         5PArA2KFnbYPRsVHZ9cguFZbMkxEPpkVGvk6o0oMx+nm64yPfD4BqRu2Xc0KxuybwX2c
         Cyqwa5hvzCAKJHJ0r43pMrNfjw8jXjf/8SmxNX+F5yEpsJb2GZZwDnsYuV+n3boFa4pf
         klWoD9mHggnHyjq5UF2WVIOK42ykXJmGBhZRRLMZoyysZUKPXf14Vwfl3sHBIauqpEKl
         9q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695648865; x=1696253665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqmWWR+G31hZDZUGZwMonL2cb5Bksu8antYerZiIOYs=;
        b=LDGM9AEj4LF5MZ7TV8N4amYyaYXnMQmp8EUeycnP3WKHYcZ0RPOFSytwsvYZBu5SFC
         AbDwP0CRh5BqNn69CMIRglmBp5Ex/SejwXtwHUfQpyB00tXzMKCJwjSwXSahGgODHJCF
         bVTrJBa6Cif/9mzpbYgiNRDH72Hhl7YuzBC7Dej6hjiWXG8npKcultYlPvH6aYGAZ5EL
         /JJ/U3Z3dILun8GYKiHyeGRpi/qO/QE/wX/quQw5/wk7BjKKi0dZl1TB+jB8KaunNL5f
         ynJdIDaKr+GM1H0k3G5g2EL8ilbV8KB56ILe4qzCGhzouK2LHKQcq9JAuMb4Rd2iXneI
         Aj5Q==
X-Gm-Message-State: AOJu0YwAL07oQI8vgLrg49tx4YhqAQpNAWyiI+4B8D3wOQ66ua8do3qG
        zgK59MUvAIx4+4eoDldKnCqX6Tkd5/1C4yv1HMzdHQ==
X-Google-Smtp-Source: AGHT+IE094/N30rRuL4yk94xTu3o08g/uw1o9Y6Hcdw7g+Q4lyl5BlkWJaRuOamwwrUMa8Hlgy0Db0VXX8f/+UhsMdo=
X-Received: by 2002:a25:9949:0:b0:d89:4829:6a63 with SMTP id
 n9-20020a259949000000b00d8948296a63mr534949ybo.65.1695648865345; Mon, 25 Sep
 2023 06:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230925131715.138411-1-ulf.hansson@linaro.org> <20230925131715.138411-7-ulf.hansson@linaro.org>
In-Reply-To: <20230925131715.138411-7-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Sep 2023 15:33:49 +0200
Message-ID: <CAPDyKFo+XCEtTSNqtA1SeajWo4tuRroA4GrRegta5TsqSGd4eQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] OPP: Extend support for the opp-level beyond required-opps
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, 25 Sept 2023 at 15:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> At this point the level (performance state) for an OPP is currently limited
> to be requested for a device that is attached to a PM domain.  Moreover,
> the device needs to have the so called required-opps assigned to it, which
> are based upon OPP tables being described in DT.
>
> To extend the support beyond required-opps and DT, let's enable the level
> to be set for all OPPs. More precisely, if the requested OPP has a valid
> level let's try to request it through the device's optional PM domain, via
> calling dev_pm_domain_set_performance_state().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/opp/core.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 60dca60ac4af..afb73978cdcb 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1107,6 +1107,22 @@ void _update_set_required_opps(struct opp_table *opp_table)
>                 opp_table->set_required_opps = _opp_set_required_opps_generic;
>  }
>
> +static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
> +                         struct dev_pm_opp *opp)
> +{
> +       int ret = 0;
> +
> +       /* Request a new performance state through the device's PM domain. */
> +       if (opp && opp->level) {
> +               ret = dev_pm_domain_set_performance_state(dev, opp->level);
> +               if (ret)
> +                       dev_err(dev, "Failed to set performance state %u (%d)\n",
> +                               opp->level, ret);
> +       }

Okay, so reviewing my own code found a problem here. We need an "else"
here, that should request the performance state to be set to 0.

I am not sending a new version at this point, but awaiting more feedback first.

> +
> +       return ret;
> +}
> +
>  static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
>  {
>         struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
> @@ -1154,8 +1170,13 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
>         if (opp_table->regulators)
>                 regulator_disable(opp_table->regulators[0]);
>
> +       ret = _set_opp_level(dev, opp_table, NULL);
> +       if (ret)
> +               goto out;
> +
>         ret = _set_required_opps(dev, opp_table, NULL, false);
>
> +out:
>         opp_table->enabled = false;
>         return ret;
>  }
> @@ -1198,6 +1219,10 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>                         return ret;
>                 }
>
> +               ret = _set_opp_level(dev, opp_table, opp);
> +               if (ret)
> +                       return ret;
> +
>                 ret = _set_opp_bw(opp_table, opp, dev);
>                 if (ret) {
>                         dev_err(dev, "Failed to set bw: %d\n", ret);
> @@ -1241,6 +1266,10 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>                         return ret;
>                 }
>
> +               ret = _set_opp_level(dev, opp_table, opp);
> +               if (ret)
> +                       return ret;
> +
>                 ret = _set_required_opps(dev, opp_table, opp, false);
>                 if (ret) {
>                         dev_err(dev, "Failed to set required opps: %d\n", ret);
> --
> 2.34.1
>

Kind regards
Uffe
