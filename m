Return-Path: <linux-kernel+bounces-146751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682C68A6A55
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B60B20FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCED12AACC;
	Tue, 16 Apr 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwD2JaX4"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF212A166
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269370; cv=none; b=OI8j1wFYt8KPwlvmVGGaa2xZ2UTk4uftZztWgbRTsLrs6AH+Re4guI7a0VzWrpMAvqS+mwIwBx/WCV1ydG/lTQQP6LZ8YjzK6k+MT215ulTCtCsFqd6WnLiZA00Wu5W5K+MlrHC4WI3pZXlm2hSJGL0Zg986k8r+S61g+54ldFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269370; c=relaxed/simple;
	bh=qgo2VuoqjBOMiWgEy/VprcKS5hZxDHs461zACqbCJVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJpGDJDyvd2ZJSXZj6gviczBxykWitxZKAn4c9pKPxT6OWAJyUmOOChgXLg3qe8xJgRJo+9GLbSO1dxwpUm6SKYpStKM49f0orYvRdVOOuo10espmIZgjJu0etTxCC1ksvQW84iC4lmHKMK5KMylF153yfeAVxJP+6vvGWwZhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwD2JaX4; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so3892067276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713269365; x=1713874165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8RCYdqkWa3jbpv0WvdFju7UDxlXJQ/vg5ssRIlSUrEA=;
        b=mwD2JaX4lSuzAdX2devvwRzGRbgc6WaFvAsfRx9z9s4KZLV515nEL35+zxtqHhWHEQ
         LS9hRzAxWoDkLZu49XroM5IEzoAXbTRy/XKX8GSFK399bkAEY8GI5WyXpR9pAIPhvjVq
         /mcIveHRlnxQCyRsxLgOdhKdUTMkbob2paItdyNbyrF9L8WMf9gjJy7wbI4mk/KCnruA
         374MW2G/VJEKw1b1SMdqsm6+txGgQjC9ULozboJRlhb/TnUeyF7J0W2N8eHLf4+i9Hf+
         ddQE2xuZDIdRnN+Ll7d24AtsavhyOphoD6sR/bWwWe7AY8SaPP9T0rMlMATcSEMk52cy
         DY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269365; x=1713874165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RCYdqkWa3jbpv0WvdFju7UDxlXJQ/vg5ssRIlSUrEA=;
        b=gJmz+Dq9T3JgMnT30g8YhCP9oX5xlvD7Svn2P5ZqJ2eACNi6jIClZl/KvL4fCJaZeD
         B4CIH+qwwneh/utHovemgHTX2Cdne6zgdzcmBpMo2Nh423XUcZau0h4HQBg/pNYr9NAW
         bPiKcTL+WPoTWETE/kArdmsSrE+ei3TKATP3Jojs6QSU4kHXOK7TZHZ7A49NszuwXnul
         19occ7agg3WhiLqwQ4pr2+i/G49FbEOuInrrwiywR8jFTr4xHJRhzx5EOoHk9RFhPEWS
         DL3nTw2trT8o1HmsaMbIG3Mq6IOGrzVTWu5ZgOK/TXaFenaNeAPWlBiI7ySwSztZVFaJ
         NNQw==
X-Forwarded-Encrypted: i=1; AJvYcCVhOqkmzLSjBWz2kHLqqjLewG3h/ehUu1fwG4s1hLKIWqZyzk14/9MaGVxLjLj8cD0y7+yO/6iD7CZJD9x+anDT5043CYwYzgPLxw7u
X-Gm-Message-State: AOJu0YyX3llzM/wNYq9K06eN4Yg5Ze+SfBoRSGDUcZIC36OtALSPSNNx
	cMj3II77DP28QGBwUhP6d4x4TdaY0sVs6oPlcpjwDc03Yo2HGGQ+hRLlGQ859hdiUfcXEuqTYHw
	21ojhz+XXLl1RdrRyqClvECZgWv2OTNOgVpGXTLMOBWmNT7fp
X-Google-Smtp-Source: AGHT+IHfmSOafU46VNT55D4o0lpL+Y+zPaCP9ePMjEUBeVn/imDh6XLVUdZ1y2xw2Zofyfd4MqVcJjDrhaUhPQguKsg=
X-Received: by 2002:a25:ae42:0:b0:dcc:943a:b99f with SMTP id
 g2-20020a25ae42000000b00dcc943ab99fmr12839754ybe.46.1713269365553; Tue, 16
 Apr 2024 05:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com> <20240410122657.2051132-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410122657.2051132-7-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 Apr 2024 14:08:49 +0200
Message-ID: <CAPDyKFoxtEWEyR9fV-5Py4b-zhJJeAFNucuh9eWo2=-n90wyFw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] clk: renesas: rzg2l: Extend power domain support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 14:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/{G2L, V2L, G3S}-based CPG versions have support for saving extra
> power when clocks are disabled by activating module standby. This is done
> through MSTOP-specific registers that are part of CPG. Each individual
> module has one or more bits associated with one MSTOP register (see table
> "Registers for Module Standby Mode" from HW manuals). Hardware manual
> associates modules' clocks with one or more MSTOP bits. There are 3
> mappings available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW
> manuals):
>
> case 1: N clocks mapped to N MSTOP bits (with N={0, ..., X})
> case 2: N clocks mapped to 1 MSTOP bit  (with N={0, ..., X})
> case 3: N clocks mapped to M MSTOP bits (with N={0, ..., X}, M={0, ..., Y})
>
> Case 3 has been currently identified on RZ/V2L for the VCPL4 module.
>
> To cover all three cases, the individual platform drivers will provide to
> clock driver MSTOP register offset and associated bits in this register
> as a bitmask and the clock driver will apply this bitmask to proper
> MSTOP register.
>
> Apart from MSTOP support, RZ/G3S can save more power by powering down the
> individual IPs (after MSTOP has been set) if proper bits in
> CPG_PWRDN_IP{1,2} registers are set.
>
> The MSTOP and IP power down support were implemented through power
> domains. Platform-specific clock drivers will register an array of
> type struct rzg2l_cpg_pm_domain_init_data, which will be used to
> instantiate properly the power domains.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

This looks good to me!

However, as said elsewhere, I would like to encourage you to move the
genpd provider specific parts into drivers/pmdomain/*. Not saying it
should be a separate driver, but looking at the amount of genpd
specific code, I am a little worried about maintenance when moving
forward, if we keep this in drivers/clk/*. Nevertheless, feel free to
add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
> Changes in v3:
> - collected tags
>
> Changes in v2:
> - called pm_genpd_init() with proper value for is_off argument
> - fixed typos
> - used flexible array for struct rzg2l_cpg_pm_domains::domains member
> - moved genpd member of struct rzg2l_cpg_pd at the beginning of struct
> - didn't initialize the parent variable in rzg2l_cpg_add_pm_domains()
>   as it is already initialized in the for block from
>   rzg2l_cpg_add_pm_domains() and that initialization should be enough
> - dropped RZG2L_PD_F_PARENT flag
> - used datasheet naming for all MSTOP registers
> - added all MSTOP registers to rzg2l-cpg.h
> - reworked the code that initializes the register offset and bits for domains
> - dropped MSTOP*(), PWRDN*() macros and introduced struct rzg2l_cpg_reg_conf
>   and DEF_REG_CONF() for domain description
> - constified the 1st argument of rzg2l_cpg_pm_domain_xlate()
> - used dev instead of priv->dev where possible
> - dropped RZG2L_PD_F_PARENT
> - added RZG2L_PD_F_NONE for better description of domains in platform
>   specific clock drivers
>
>  drivers/clk/renesas/rzg2l-cpg.c | 213 +++++++++++++++++++++++++++++---
>  drivers/clk/renesas/rzg2l-cpg.h |  77 ++++++++++++
>  2 files changed, 276 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
> index 3d2daa4ba2a4..b36700f4a9f5 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -139,7 +139,6 @@ struct rzg2l_pll5_mux_dsi_div_param {
>   * @num_resets: Number of Module Resets in info->resets[]
>   * @last_dt_core_clk: ID of the last Core Clock exported to DT
>   * @info: Pointer to platform data
> - * @genpd: PM domain
>   * @mux_dsi_div_params: pll5 mux and dsi div parameters
>   */
>  struct rzg2l_cpg_priv {
> @@ -156,8 +155,6 @@ struct rzg2l_cpg_priv {
>
>         const struct rzg2l_cpg_info *info;
>
> -       struct generic_pm_domain genpd;
> -
>         struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
>  };
>
> @@ -1559,9 +1556,34 @@ static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_priv *priv,
>         return true;
>  }
>
> +/**
> + * struct rzg2l_cpg_pm_domains - RZ/G2L PM domains data structure
> + * @onecell_data: cell data
> + * @domains: generic PM domains
> + */
> +struct rzg2l_cpg_pm_domains {
> +       struct genpd_onecell_data onecell_data;
> +       struct generic_pm_domain *domains[];
> +};
> +
> +/**
> + * struct rzg2l_cpg_pd - RZ/G2L power domain data structure
> + * @genpd: generic PM domain
> + * @priv: pointer to CPG private data structure
> + * @conf: CPG PM domain configuration info
> + * @id: RZ/G2L power domain ID
> + */
> +struct rzg2l_cpg_pd {
> +       struct generic_pm_domain genpd;
> +       struct rzg2l_cpg_priv *priv;
> +       struct rzg2l_cpg_pm_domain_conf conf;
> +       u16 id;
> +};
> +
>  static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device *dev)
>  {
> -       struct rzg2l_cpg_priv *priv = container_of(domain, struct rzg2l_cpg_priv, genpd);
> +       struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
> +       struct rzg2l_cpg_priv *priv = pd->priv;
>         struct device_node *np = dev->of_node;
>         struct of_phandle_args clkspec;
>         bool once = true;
> @@ -1617,31 +1639,194 @@ static void rzg2l_cpg_detach_dev(struct generic_pm_domain *unused, struct device
>  }
>
>  static void rzg2l_cpg_genpd_remove(void *data)
> +{
> +       struct genpd_onecell_data *celldata = data;
> +
> +       for (unsigned int i = 0; i < celldata->num_domains; i++)
> +               pm_genpd_remove(celldata->domains[i]);
> +}
> +
> +static void rzg2l_cpg_genpd_remove_simple(void *data)
>  {
>         pm_genpd_remove(data);
>  }
>
> +static int rzg2l_cpg_power_on(struct generic_pm_domain *domain)
> +{
> +       struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
> +       struct rzg2l_cpg_reg_conf mstop = pd->conf.mstop;
> +       struct rzg2l_cpg_reg_conf pwrdn = pd->conf.pwrdn;
> +       struct rzg2l_cpg_priv *priv = pd->priv;
> +
> +       /* Set PWRDN. */
> +       if (pwrdn.mask)
> +               writel(pwrdn.mask << 16, priv->base + pwrdn.off);
> +
> +       /* Set MSTOP. */
> +       if (mstop.mask)
> +               writel(mstop.mask << 16, priv->base + mstop.off);
> +
> +       return 0;
> +}
> +
> +static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
> +{
> +       struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
> +       struct rzg2l_cpg_reg_conf mstop = pd->conf.mstop;
> +       struct rzg2l_cpg_reg_conf pwrdn = pd->conf.pwrdn;
> +       struct rzg2l_cpg_priv *priv = pd->priv;
> +
> +       /* Set MSTOP. */
> +       if (mstop.mask)
> +               writel(mstop.mask | (mstop.mask << 16), priv->base + mstop.off);
> +
> +       /* Set PWRDN. */
> +       if (pwrdn.mask)
> +               writel(pwrdn.mask | (pwrdn.mask << 16), priv->base + pwrdn.off);
> +
> +       return 0;
> +}
> +
> +static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
> +{
> +       struct dev_power_governor *governor;
> +
> +       pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
> +       pd->genpd.attach_dev = rzg2l_cpg_attach_dev;
> +       pd->genpd.detach_dev = rzg2l_cpg_detach_dev;
> +       if (always_on) {
> +               pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
> +               governor = &pm_domain_always_on_gov;
> +       } else {
> +               pd->genpd.power_on = rzg2l_cpg_power_on;
> +               pd->genpd.power_off = rzg2l_cpg_power_off;
> +               governor = &simple_qos_governor;
> +       }
> +
> +       return pm_genpd_init(&pd->genpd, governor, !always_on);
> +}
> +
>  static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
>  {
>         struct device *dev = priv->dev;
>         struct device_node *np = dev->of_node;
> -       struct generic_pm_domain *genpd = &priv->genpd;
> +       struct rzg2l_cpg_pd *pd;
>         int ret;
>
> -       genpd->name = np->name;
> -       genpd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ALWAYS_ON |
> -                      GENPD_FLAG_ACTIVE_WAKEUP;
> -       genpd->attach_dev = rzg2l_cpg_attach_dev;
> -       genpd->detach_dev = rzg2l_cpg_detach_dev;
> -       ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
> +       pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return -ENOMEM;
> +
> +       pd->genpd.name = np->name;
> +       pd->priv = priv;
> +       ret = rzg2l_cpg_pd_setup(pd, true);
>         if (ret)
>                 return ret;
>
> -       ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, genpd);
> +       ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove_simple, &pd->genpd);
>         if (ret)
>                 return ret;
>
> -       return of_genpd_add_provider_simple(np, genpd);
> +       return of_genpd_add_provider_simple(np, &pd->genpd);
> +}
> +
> +static struct generic_pm_domain *
> +rzg2l_cpg_pm_domain_xlate(const struct of_phandle_args *spec, void *data)
> +{
> +       struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
> +       struct genpd_onecell_data *genpd = data;
> +
> +       if (spec->args_count != 1)
> +               return ERR_PTR(-EINVAL);
> +
> +       for (unsigned int i = 0; i < genpd->num_domains; i++) {
> +               struct rzg2l_cpg_pd *pd = container_of(genpd->domains[i], struct rzg2l_cpg_pd,
> +                                                      genpd);
> +
> +               if (pd->id == spec->args[0]) {
> +                       domain = &pd->genpd;
> +                       break;
> +               }
> +       }
> +
> +       return domain;
> +}
> +
> +static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
> +{
> +       const struct rzg2l_cpg_info *info = priv->info;
> +       struct device *dev = priv->dev;
> +       struct device_node *np = dev->of_node;
> +       struct rzg2l_cpg_pm_domains *domains;
> +       struct generic_pm_domain *parent;
> +       u32 ncells;
> +       int ret;
> +
> +       ret = of_property_read_u32(np, "#power-domain-cells", &ncells);
> +       if (ret)
> +               return ret;
> +
> +       /* For backward compatibility. */
> +       if (!ncells)
> +               return rzg2l_cpg_add_clk_domain(priv);
> +
> +       domains = devm_kzalloc(dev, struct_size(domains, domains, info->num_pm_domains),
> +                              GFP_KERNEL);
> +       if (!domains)
> +               return -ENOMEM;
> +
> +       domains->onecell_data.domains = domains->domains;
> +       domains->onecell_data.num_domains = info->num_pm_domains;
> +       domains->onecell_data.xlate = rzg2l_cpg_pm_domain_xlate;
> +
> +       ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, &domains->onecell_data);
> +       if (ret)
> +               return ret;
> +
> +       for (unsigned int i = 0; i < info->num_pm_domains; i++) {
> +               bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
> +               struct rzg2l_cpg_pd *pd;
> +
> +               pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +               if (!pd)
> +                       return -ENOMEM;
> +
> +               pd->genpd.name = info->pm_domains[i].name;
> +               pd->conf = info->pm_domains[i].conf;
> +               pd->id = info->pm_domains[i].id;
> +               pd->priv = priv;
> +
> +               ret = rzg2l_cpg_pd_setup(pd, always_on);
> +               if (ret)
> +                       return ret;
> +
> +               if (always_on) {
> +                       ret = rzg2l_cpg_power_on(&pd->genpd);
> +                       if (ret)
> +                               return ret;
> +               }
> +
> +               domains->domains[i] = &pd->genpd;
> +               /* Parent should be on the very first entry of info->pm_domains[]. */
> +               if (!i) {
> +                       parent = &pd->genpd;
> +                       continue;
> +               }
> +
> +               ret = pm_genpd_add_subdomain(parent, &pd->genpd);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = of_genpd_add_provider_onecell(np, &domains->onecell_data);
> +       if (ret)
> +               return ret;
> +
> +       /* Prepare for power down the BUSes in power down mode. */
> +       if (info->pm_domain_pwrdn_mstop)
> +               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);
> +
> +       return 0;
>  }
>
>  static int __init rzg2l_cpg_probe(struct platform_device *pdev)
> @@ -1697,7 +1882,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
>         if (error)
>                 return error;
>
> -       error = rzg2l_cpg_add_clk_domain(priv);
> +       error = rzg2l_cpg_add_pm_domains(priv);
>         if (error)
>                 return error;
>
> diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
> index 6e38c8fc888c..d9a7357c4873 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -27,6 +27,21 @@
>  #define CPG_PL6_ETH_SSEL       (0x418)
>  #define CPG_PL5_SDIV           (0x420)
>  #define CPG_RST_MON            (0x680)
> +#define CPG_BUS_ACPU_MSTOP     (0xB60)
> +#define CPG_BUS_MCPU1_MSTOP    (0xB64)
> +#define CPG_BUS_MCPU2_MSTOP    (0xB68)
> +#define CPG_BUS_PERI_COM_MSTOP (0xB6C)
> +#define CPG_BUS_PERI_CPU_MSTOP (0xB70)
> +#define CPG_BUS_PERI_DDR_MSTOP (0xB74)
> +#define CPG_BUS_REG0_MSTOP     (0xB7C)
> +#define CPG_BUS_REG1_MSTOP     (0xB80)
> +#define CPG_BUS_TZCDDR_MSTOP   (0xB84)
> +#define CPG_MHU_MSTOP          (0xB88)
> +#define CPG_BUS_MCPU3_MSTOP    (0xB90)
> +#define CPG_BUS_PERI_CPU2_MSTOP        (0xB94)
> +#define CPG_PWRDN_IP1          (0xBB0)
> +#define CPG_PWRDN_IP2          (0xBB4)
> +#define CPG_PWRDN_MSTOP                (0xBC0)
>  #define CPG_OTHERFUNC1_REG     (0xBE8)
>
>  #define CPG_SIPLL5_STBY_RESETB         BIT(0)
> @@ -70,6 +85,8 @@
>
>  #define EXTAL_FREQ_IN_MEGA_HZ  (24)
>
> +#define CPG_PWRDN_MSTOP_ENABLE         (BIT(16) | BIT(0))
> +
>  /**
>   * Definitions of CPG Core Clocks
>   *
> @@ -234,6 +251,58 @@ struct rzg2l_reset {
>  #define DEF_RST(_id, _off, _bit)       \
>         DEF_RST_MON(_id, _off, _bit, -1)
>
> +/**
> + * struct rzg2l_cpg_reg_conf - RZ/G2L register configuration data structure
> + * @off: register offset
> + * @mask: register mask
> + */
> +struct rzg2l_cpg_reg_conf {
> +       u16 off;
> +       u16 mask;
> +};
> +
> +#define DEF_REG_CONF(_off, _mask) ((struct rzg2l_cpg_reg_conf) { .off = (_off), .mask = (_mask) })
> +
> +/**
> + * struct rzg2l_cpg_pm_domain_conf - PM domain configuration data structure
> + * @mstop: MSTOP register configuration
> + * @pwrdn: PWRDN register configuration
> + */
> +struct rzg2l_cpg_pm_domain_conf {
> +       struct rzg2l_cpg_reg_conf mstop;
> +       struct rzg2l_cpg_reg_conf pwrdn;
> +};
> +
> +/**
> + * struct rzg2l_cpg_pm_domain_init_data - PM domain init data
> + * @name: PM domain name
> + * @conf: PM domain configuration
> + * @flags: RZG2L PM domain flags (see RZG2L_PD_F_*)
> + * @id: PM domain ID (similar to the ones defined in
> + *      include/dt-bindings/clock/<soc-id>-cpg.h)
> + */
> +struct rzg2l_cpg_pm_domain_init_data {
> +       const char * const name;
> +       struct rzg2l_cpg_pm_domain_conf conf;
> +       u32 flags;
> +       u16 id;
> +};
> +
> +#define DEF_PD(_name, _id, _mstop_conf, _pwrdn_conf, _flags) \
> +       { \
> +               .name = (_name), \
> +               .id = (_id), \
> +               .conf = { \
> +                       .mstop = (_mstop_conf), \
> +                       .pwrdn = (_pwrdn_conf), \
> +               }, \
> +               .flags = (_flags), \
> +       }
> +
> +/* Power domain flags. */
> +#define RZG2L_PD_F_ALWAYS_ON   BIT(0)
> +#define RZG2L_PD_F_NONE                (0)
> +
>  /**
>   * struct rzg2l_cpg_info - SoC-specific CPG Description
>   *
> @@ -252,6 +321,9 @@ struct rzg2l_reset {
>   * @crit_mod_clks: Array with Module Clock IDs of critical clocks that
>   *                 should not be disabled without a knowledgeable driver
>   * @num_crit_mod_clks: Number of entries in crit_mod_clks[]
> + * @pm_domains: PM domains init data array
> + * @num_pm_domains: Number of PM domains
> + * @pm_domain_pwrdn_mstop: Specifies if PWRDN MSTOP is supported
>   * @has_clk_mon_regs: Flag indicating whether the SoC has CLK_MON registers
>   */
>  struct rzg2l_cpg_info {
> @@ -278,6 +350,11 @@ struct rzg2l_cpg_info {
>         const unsigned int *crit_mod_clks;
>         unsigned int num_crit_mod_clks;
>
> +       /* Power domain. */
> +       const struct rzg2l_cpg_pm_domain_init_data *pm_domains;
> +       unsigned int num_pm_domains;
> +       bool pm_domain_pwrdn_mstop;
> +
>         bool has_clk_mon_regs;
>  };
>
> --
> 2.39.2
>
>

