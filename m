Return-Path: <linux-kernel+bounces-146749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCA08A6A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746F32825A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0A212B145;
	Tue, 16 Apr 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzhD7XkG"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D756412A152
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269296; cv=none; b=XtkGj5Jeubj8tAZXF+p9O+WApz6IjvfSct7sWYdTWbar6tV9i7U9pkt/1LXThE0mXH6JGFBahxVr9kuxcXiyOQaNCfN65UZxna53yFEiT+bHr4nUVCOGB5nHpfQQz7zrG69F1L88bahtR6POWBPNB0SwBMu8m52Xdl1so+doiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269296; c=relaxed/simple;
	bh=imj9FU964ipR270SsIgTiSstsL4zLPFQC2BSRYMML+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQHGiq4SBTK7seI/ZPUDC1JWieac6LnjU0GXxtxeAyg7yTrpd6pdprQAkzqOeJwbZvjpMu1mS3Y0rLLTaW/+GkSS4WtznWSLEE8+eapLJ1ioKfQOg75dyoV6pVg+UfZY0ktMD+Ji/gYUEkBEBysgjaVrzJ6iH/AjBCQfAOy8vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IzhD7XkG; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4562660276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713269294; x=1713874094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv6O9ENZ1HB7/Vm/R0vkAKjxXVgkFYsZ40itiMTKBZ0=;
        b=IzhD7XkGzJmc997dMPpEXq1dgcYBDaRy16Z5oXZQn1Ot7tCKHcw5+lJ3eL3KmH4RVi
         irP9tn+u/hIbU1EbGcIvHQggGx2b1wOLzrwHvNLcJFu7+xqTtl0gj5hxaH6ZVKVRJTki
         YbFNn1HzJJDVehe5f58dVAXq89DWqJKt5nEBCtvsoh83mDjDWenG6xxarsn9+OCIchVR
         UXeb/fPELHAeGxjVaUbOcbSQ8af7j1WDxcD1QIF8hwoe7JfEuptfkwxMnzhAPLLCkc5r
         C8garSYo31TSdm0VYVgW1mmG5xe/WtrglFpQ5xllPwA3aPQYDQKniZpJcvpurqOIrxsg
         SDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269294; x=1713874094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv6O9ENZ1HB7/Vm/R0vkAKjxXVgkFYsZ40itiMTKBZ0=;
        b=ZkR097GnQO1AlJZzD2GEuBP7DfjeTucrmOnwVI1v12W6DqYHyVJtV9ePVmWHSxDG95
         frAAmWGQKAMw1m+vRa1hYA/EoiONqhFcXVbCOcDcACpKLSWXkU8xPffSomV3j8LXu7E9
         hb7t+HjEWCtvs11wtAFizjum3yv5Td9Caayh+99r2Q4S9odM6oBKP8pkbYSJKafufI3s
         b0Zy5DKU0M6hDIkwauYDE5fxXBAA++xbcneK2AaevG1646s3ZnHD7BFH1hoGIri3f8sA
         YfBkEbA5vRfg818TGnHYFvJSrGMU2aTEW6gPfEPCsq1ppXj85GKG6HHWSdn9s8bIHKKq
         TPFA==
X-Forwarded-Encrypted: i=1; AJvYcCU7b0EmlHvAekIBlm/LoTp77s11vhSke3ECDCYp/gq25whAcmzbuVQgt+qf82H0AzVSpJgdLYvfFOL311mTjXwpPfntL7FzfIuBxFiv
X-Gm-Message-State: AOJu0Yw8Evs2Tpbg7QSP6O5nkfII3dWDSZyrhvAjh8VQt6oCtteXIXBK
	YAUzqcdvNvvkxNWd5yEP4zZWeJwzGpfPG/umTYQSqQeGJhJhPnev0H7BD6tI43JfPH0fCEI1Cm/
	xgJ6Ti4AGvWqKvvNkzl0PP5t9LEFH6BUK0aTuZA==
X-Google-Smtp-Source: AGHT+IEKp6p1uPXxrEyB0FdKc6HRZsP1/zTSv3J7Xs4AHz4+a41DBwpfyqxTVd6fjk4b1Brb2X5G+Ngd4xWL9iLBuJQ=
X-Received: by 2002:a25:203:0:b0:dc7:4725:56df with SMTP id
 3-20020a250203000000b00dc7472556dfmr11611038ybc.23.1713269293654; Tue, 16 Apr
 2024 05:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com> <20240307140728.190184-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307140728.190184-9-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 Apr 2024 14:07:37 +0200
Message-ID: <CAPDyKFos=FP3GxX+5qAmBpqrR-8Q7MRhhV3HvPAtu2K6x=7XEw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] clk: renesas: rzg2l-cpg: Add suspend/resume
 support for power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 15:10, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/G3S supports deep sleep states that it can reach with the help of the
> TF-A.
>
> RZ/G3S has a few power domains (e.g. GIC) that need to be always-on while
> Linux is running. These domains are initialized (and powered on) when
> clock driver is probed.
>
> As the TF-A takes control at the very last(suspend)/first(resume)
> phase of configuring the deep sleep state, it can do it's own settings on
> power domains.

For my understanding, can you please elaborate on this part a bit.
What does the "last suspend/resume phase" mean, more exactly, here?

>
> Thus, to restore the proper Linux state, add rzg2l_cpg_resume() which
> powers on the always-on domains and rzg2l_cpg_complete() which activates
> the power down mode for the IPs selected through CPG_PWRDN_IP{1, 2}.
>
> Along with it, added the suspend_check member to the RZ/G2L power domain
> data structure whose purpose is to checks if a domain can be powered off
> while the system is going to suspend. This is necessary for the serial
> console domain which needs to be powered on if no_console_suspend is
> available in bootargs.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - none; this patch is new
>
>  drivers/clk/renesas/rzg2l-cpg.c | 66 ++++++++++++++++++++++++++++++---
>  drivers/clk/renesas/rzg2l-cpg.h |  1 +
>  2 files changed, 62 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
> index b36700f4a9f5..b18af227177e 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -15,6 +15,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/clk/renesas.h>
> +#include <linux/console.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -139,6 +140,7 @@ struct rzg2l_pll5_mux_dsi_div_param {
>   * @num_resets: Number of Module Resets in info->resets[]
>   * @last_dt_core_clk: ID of the last Core Clock exported to DT
>   * @info: Pointer to platform data
> + * @domains: generic PM domains
>   * @mux_dsi_div_params: pll5 mux and dsi div parameters
>   */
>  struct rzg2l_cpg_priv {
> @@ -155,6 +157,8 @@ struct rzg2l_cpg_priv {
>
>         const struct rzg2l_cpg_info *info;
>
> +       struct generic_pm_domain **domains;
> +
>         struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
>  };
>
> @@ -1570,12 +1574,14 @@ struct rzg2l_cpg_pm_domains {
>   * struct rzg2l_cpg_pd - RZ/G2L power domain data structure
>   * @genpd: generic PM domain
>   * @priv: pointer to CPG private data structure
> + * @suspend_check: check if domain could be powered off in suspend
>   * @conf: CPG PM domain configuration info
>   * @id: RZ/G2L power domain ID
>   */
>  struct rzg2l_cpg_pd {
>         struct generic_pm_domain genpd;
>         struct rzg2l_cpg_priv *priv;
> +       int (*suspend_check)(void);
>         struct rzg2l_cpg_pm_domain_conf conf;
>         u16 id;
>  };
> @@ -1676,6 +1682,13 @@ static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
>         struct rzg2l_cpg_reg_conf pwrdn = pd->conf.pwrdn;
>         struct rzg2l_cpg_priv *priv = pd->priv;
>
> +       if (pd->suspend_check) {
> +               int ret = pd->suspend_check();
> +
> +               if (ret)
> +                       return ret;
> +       }
> +

This should not be needed at all, I think.

Instead, genpd should be able to take the correct decision during
system-wide suspend and simply avoid calling the ->power_off()
callback, when that is needed.

If I understand correctly, GENPD_FLAG_ACTIVE_WAKEUP is set for the
genpd in question. The only remaining thing would then be to let the
console driver, during system suspend, check whether
"console_suspend_enabled" is set and then call device_set_awake_path()
for its device. In this way, genpd should then keep the corresponding
PM domain powered-on.

>         /* Set MSTOP. */
>         if (mstop.mask)
>                 writel(mstop.mask | (mstop.mask << 16), priv->base + mstop.off);
> @@ -1687,8 +1700,14 @@ static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
>         return 0;
>  }
>
> -static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
> +static int rzg2l_pd_suspend_check_console(void)
>  {
> +       return console_suspend_enabled ? 0 : -EBUSY;
> +}
> +
> +static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, u32 flags)
> +{
> +       bool always_on = !!(flags & RZG2L_PD_F_ALWAYS_ON);
>         struct dev_power_governor *governor;
>
>         pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
> @@ -1700,6 +1719,8 @@ static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
>         } else {
>                 pd->genpd.power_on = rzg2l_cpg_power_on;
>                 pd->genpd.power_off = rzg2l_cpg_power_off;
> +               if (flags & RZG2L_PD_F_CONSOLE)
> +                       pd->suspend_check = rzg2l_pd_suspend_check_console;
>                 governor = &simple_qos_governor;
>         }
>
> @@ -1719,7 +1740,7 @@ static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
>
>         pd->genpd.name = np->name;
>         pd->priv = priv;
> -       ret = rzg2l_cpg_pd_setup(pd, true);
> +       ret = rzg2l_cpg_pd_setup(pd, RZG2L_PD_F_ALWAYS_ON);
>         if (ret)
>                 return ret;
>
> @@ -1778,13 +1799,13 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
>         domains->onecell_data.domains = domains->domains;
>         domains->onecell_data.num_domains = info->num_pm_domains;
>         domains->onecell_data.xlate = rzg2l_cpg_pm_domain_xlate;
> +       priv->domains = domains->domains;
>
>         ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, &domains->onecell_data);
>         if (ret)
>                 return ret;
>
>         for (unsigned int i = 0; i < info->num_pm_domains; i++) {
> -               bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
>                 struct rzg2l_cpg_pd *pd;
>
>                 pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> @@ -1796,11 +1817,11 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
>                 pd->id = info->pm_domains[i].id;
>                 pd->priv = priv;
>
> -               ret = rzg2l_cpg_pd_setup(pd, always_on);
> +               ret = rzg2l_cpg_pd_setup(pd, info->pm_domains[i].flags);
>                 if (ret)
>                         return ret;
>
> -               if (always_on) {
> +               if (info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON) {
>                         ret = rzg2l_cpg_power_on(&pd->genpd);
>                         if (ret)
>                                 return ret;
> @@ -1890,9 +1911,43 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
>         if (error)
>                 return error;
>
> +       dev_set_drvdata(dev, priv);
> +
>         return 0;
>  }
>
> +static int rzg2l_cpg_resume(struct device *dev)
> +{
> +       struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
> +       const struct rzg2l_cpg_info *info = priv->info;
> +
> +       /* Power on always ON domains. */
> +       for (unsigned int i = 0; i < info->num_pm_domains; i++) {
> +               if (info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON) {
> +                       int ret = rzg2l_cpg_power_on(priv->domains[i]);
> +
> +                       if (ret)
> +                               return ret;
> +               }
> +       }

I don't quite understand why this is needed? Is always-on PM domains
being powered-off during system wide suspend, so you need to power
them on again?

> +
> +       return 0;
> +}
> +
> +static void rzg2l_cpg_complete(struct device *dev)
> +{
> +       struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
> +
> +       /* Prepare for power down the BUSes in power down mode. */
> +       if (priv->info->pm_domain_pwrdn_mstop)
> +               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);
> +}
> +
> +static const struct dev_pm_ops rzg2l_cpg_pm_ops = {
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, rzg2l_cpg_resume)
> +       .complete = rzg2l_cpg_complete,
> +};
> +
>  static const struct of_device_id rzg2l_cpg_match[] = {
>  #ifdef CONFIG_CLK_R9A07G043
>         {
> @@ -1931,6 +1986,7 @@ static struct platform_driver rzg2l_cpg_driver = {
>         .driver         = {
>                 .name   = "rzg2l-cpg",
>                 .of_match_table = rzg2l_cpg_match,
> +               .pm     = pm_sleep_ptr(&rzg2l_cpg_pm_ops),
>         },
>  };
>
> diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
> index d9a7357c4873..abff85644270 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -301,6 +301,7 @@ struct rzg2l_cpg_pm_domain_init_data {
>
>  /* Power domain flags. */
>  #define RZG2L_PD_F_ALWAYS_ON   BIT(0)
> +#define RZG2L_PD_F_CONSOLE     BIT(1)
>  #define RZG2L_PD_F_NONE                (0)
>

Kind regards
Uffe

