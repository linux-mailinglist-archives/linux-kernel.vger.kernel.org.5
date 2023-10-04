Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70B27B7F22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbjJDMav convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 08:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjJDMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:30:49 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7CFA9;
        Wed,  4 Oct 2023 05:30:45 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f4f80d084so23389847b3.1;
        Wed, 04 Oct 2023 05:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422644; x=1697027444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+olLsWy4li2GDhejH+HbPOUf9oScrcKtWtNDWsUV2U=;
        b=SJiyIXn72lXKMmZVwFvZO8tp+RW7z1oWl2/JG+96pOKaSoGo9ZCcQU/FKiVmKCcpDu
         cumbjnXt44NBKIzi9MPr46lL9jjs7aXwWPO+LyeKC35o7UqAQOVDplqAqa7bDG6yh1RC
         /yGCISvn/xrVpswBiHp06IoUxvG/we0RDuUinx70+5V2ogPnf0BvzK+HM5LfRvvsvOgA
         uCMaCKASI7Axlf0IVzGDfLW4v+FfbuOPA06zGKV0EGdgNpDssfZGcYyVR6frETGp1158
         j8A8ni7KGbH2gc/Z1DsCD46YRS6IprvjKgs+PfD0vRM4GoIrJTrwJd5kZvbeLVGasYil
         eFSg==
X-Gm-Message-State: AOJu0Yzss0KnS9ENDY+qJEBDBSY6tS4tsGFfYFOiaBiJr4zk9jshh3UI
        3nY2Pt+b2tq04/CuDeA6xtwthH9Pv94dRQ==
X-Google-Smtp-Source: AGHT+IGQ8QAU2s4pIa8IlvZysvKVCRGJm+GdVx47a3sc6i2izURViyI6UiV5QfBF3KwxgnpkBJlJEw==
X-Received: by 2002:a25:8691:0:b0:d81:4ebc:242e with SMTP id z17-20020a258691000000b00d814ebc242emr1842511ybk.45.1696422644267;
        Wed, 04 Oct 2023 05:30:44 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id s7-20020a5b0447000000b00d815cb9accbsm995384ybp.32.2023.10.04.05.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:30:43 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59f7f46b326so23501947b3.0;
        Wed, 04 Oct 2023 05:30:43 -0700 (PDT)
X-Received: by 2002:a0d:dd94:0:b0:58f:96d8:e7ad with SMTP id
 g142-20020a0ddd94000000b0058f96d8e7admr2393828ywe.18.1696422643238; Wed, 04
 Oct 2023 05:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-12-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-12-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 14:30:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8wPNr4LsPJR7zk3Ktb8NnqcSMUEjsAURc2NJ_dpiDHw@mail.gmail.com>
Message-ID: <CAMuHMdX8wPNr4LsPJR7zk3Ktb8NnqcSMUEjsAURc2NJ_dpiDHw@mail.gmail.com>
Subject: Re: [PATCH v2 11/28] clk: renesas: rzg2l: add a divider clock for RZ/G3S
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add a divider clock driver for RZ/G3S. This will be used in RZ/G3S
> by SDHI, SPI, OCTA, I, I2, I3, P0, P1, P2, P3 core clocks.
> The divider has some limitation for SDHI and OCTA clocks:
> - SD div cannot be 1 if parent rate is 800MHz
> - OCTA div cannot be 1 if parent rate is 400MHz
> For these clocks a notifier could be registered from platform specific
> clock driver and proper actions are taken before clock rate is changed,
> if needed.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - removed DIV_NOTIF macro

Thanks for the update!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -91,6 +91,22 @@ struct sd_mux_hw_data {
>
>  #define to_sd_mux_hw_data(_hw) container_of(_hw, struct sd_mux_hw_data, hw_data)
>
> +/**
> + * struct div_hw_data - divider clock hardware data
> + * @hw_data: clock hw data
> + * @dtable: pointer to divider table
> + * @invalid_rate: invalid rate for divider
> + * @width: divider width
> + */
> +struct div_hw_data {
> +       struct clk_hw_data hw_data;
> +       const struct clk_div_table *dtable;
> +       unsigned long invalid_rate;
> +       u32 width;
> +};
> +
> +#define to_div_hw_data(_hw)    container_of(_hw, struct div_hw_data, hw_data)
> +
>  struct rzg2l_pll5_param {
>         u32 pl5_fracin;
>         u8 pl5_refdiv;
> @@ -200,6 +216,54 @@ int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event
>         return ret;
>  }
>
> +int rzg3s_cpg_div_clk_notifier(struct notifier_block *nb, unsigned long event,
> +                              void *data)
> +{
> +       struct clk_notifier_data *cnd = data;
> +       struct clk_hw *hw = __clk_get_hw(cnd->clk);
> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
> +       struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
> +       u32 off = GET_REG_OFFSET(clk_hw_data->conf);
> +       u32 shift = GET_SHIFT(clk_hw_data->conf);
> +       u32 bitmask = GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
> +       unsigned long flags;
> +       int ret = 0;
> +       u32 val;
> +
> +       if (event != PRE_RATE_CHANGE || !div_hw_data->invalid_rate ||
> +           div_hw_data->invalid_rate % cnd->new_rate)
> +               return 0;

NOTIFY_DONE for event != PRE_RATE_CHANGE
NOTIFY_OK for the other cases

> +
> +       spin_lock_irqsave(&priv->rmw_lock, flags);
> +
> +       val = readl(priv->base + off);
> +       val >>= shift;
> +       val &= bitmask;
> +
> +       /*
> +        * There are different constraints for the user of this notifiers as follows:
> +        * 1/ SD div cannot be 1 (val == 0) if parent rate is 800MHz
> +        * 2/ OCTA div cannot be 1 (val == 0) if parent rate is 400MHz
> +        * As SD can have only one parent having 800MHz and OCTA div can have
> +        * only one parent having 400MHz we took into account the parent rate
> +        * at the beginning of function (by checking invalid_rate % new_rate).
> +        * Now it is time to check the hardware divider and update it accordingly.
> +        */
> +       if (!val) {
> +               writel(((bitmask << shift) << 16) | BIT(shift), priv->base + off);

Haven't you exchanged the (single) write-enable bit and the (multi-bit)
division ratio setting?  According to the docs, the write-enable bit
is at 16 + shift, while the division ratio is at shift.

Also, using bitmask as the division ratio means the maximum value
that fits in the bitfield, which would be a prohibited setting in case
of DIV_OCTA.

Now, looking at rzg3s_div_clk_set_rate() below, perhaps you just wanted
to set the ratio to value to 1, but used the wrong size for bitmask?

> +               /* Wait for the update done. */
> +               ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
> +       }
> +
> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +
> +       if (ret)
> +               dev_err(priv->dev, "Failed to downgrade the div\n");

and return NOTIFY_BAD

> +
> +       return ret;

NOTIFY_OK

> +}
> +
>  static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
>                                    struct rzg2l_cpg_priv *priv)
>  {
> @@ -217,6 +281,146 @@ static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk
>         return clk_notifier_register(hw->clk, nb);
>  }
>
> +static unsigned long rzg3s_div_clk_recalc_rate(struct clk_hw *hw,
> +                                              unsigned long parent_rate)
> +{
> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
> +       struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
> +       u32 val;
> +
> +       val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
> +       val >>= GET_SHIFT(clk_hw_data->conf);
> +       val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
> +
> +       return divider_recalc_rate(hw, parent_rate, val, div_hw_data->dtable,
> +                                  CLK_DIVIDER_ROUND_CLOSEST, div_hw_data->width);
> +}
> +
> +static bool rzg3s_div_clk_is_rate_valid(const unsigned long invalid_rate, unsigned long rate)
> +{
> +       if (invalid_rate && rate >= invalid_rate)
> +               return false;
> +
> +       return true;
> +}
> +
> +static long rzg3s_div_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                    unsigned long *parent_rate)
> +{
> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
> +       struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
> +       long round_rate;
> +
> +       round_rate = divider_round_rate(hw, rate, parent_rate, div_hw_data->dtable,
> +                                       div_hw_data->width, CLK_DIVIDER_ROUND_CLOSEST);
> +
> +       if (!rzg3s_div_clk_is_rate_valid(div_hw_data->invalid_rate, round_rate))
> +               return -EINVAL;

Shouldn't this return the closest rate that is actually supported instead?

> +
> +       return round_rate;
> +}

But please implement .determine_rate() instead of .round_rate() in
new drivers.

> +
> +static int rzg3s_div_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long parent_rate)
> +{
> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
> +       struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
> +       u32 off = GET_REG_OFFSET(clk_hw_data->conf);
> +       u32 shift = GET_SHIFT(clk_hw_data->conf);
> +       unsigned long flags;
> +       u32 bitmask, val;
> +       int ret;
> +
> +       /*
> +        * Some dividers cannot support some rates:
> +        * - SD div cannot support 800 MHz when parent is @800MHz and div = 1
> +        * - OCTA div cannot support 400 MHz when parent is @400MHz and div = 1
> +        * Check these scenarios.
> +        */
> +       if (!rzg3s_div_clk_is_rate_valid(div_hw_data->invalid_rate, rate))
> +               return -EINVAL;

Can this actually happen? Wouldn't the notifier have prevented us from
getting here?

> +
> +       val = divider_get_val(rate, parent_rate, div_hw_data->dtable, div_hw_data->width,
> +                             CLK_DIVIDER_ROUND_CLOSEST);
> +
> +       bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;

Is bitmask the (single) write-enable bit?

If yes, that should be BIT(16 + shift), and the variable should be
renamed to reflect that.

I guess there should be a general "#define CPG_WEN BIT(16)", then you
can simply use

    writel((CPG_WEN | val) << shift, ...);

> +
> +       spin_lock_irqsave(&priv->rmw_lock, flags);
> +       writel(bitmask | (val << shift), priv->base + off);
> +       /* Wait for the update done. */
> +       ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +
> +       return ret;
> +}
> +
> +static const struct clk_ops rzg3s_div_clk_ops = {
> +       .recalc_rate = rzg3s_div_clk_recalc_rate,
> +       .round_rate = rzg3s_div_clk_round_rate,
> +       .set_rate = rzg3s_div_clk_set_rate,
> +};
> +
> +static struct clk * __init
> +rzg3s_cpg_div_clk_register(const struct cpg_core_clk *core, struct clk **clks,
> +                          void __iomem *base, struct rzg2l_cpg_priv *priv)
> +{
> +       struct div_hw_data *div_hw_data;
> +       struct clk_init_data init = {};
> +       const struct clk_div_table *clkt;
> +       struct clk_hw *clk_hw;
> +       const struct clk *parent;
> +       const char *parent_name;
> +       u32 max;
> +       int ret;
> +
> +       parent = clks[core->parent & 0xffff];
> +       if (IS_ERR(parent))
> +               return ERR_CAST(parent);
> +
> +       parent_name = __clk_get_name(parent);
> +
> +       div_hw_data = devm_kzalloc(priv->dev, sizeof(*div_hw_data), GFP_KERNEL);
> +       if (!div_hw_data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = core->name;
> +       init.flags = core->flag;
> +       init.ops = &rzg3s_div_clk_ops;
> +       init.parent_names = &parent_name;
> +       init.num_parents = 1;
> +
> +       /* Get the maximum divider to retrieve div width. */
> +       for (clkt = core->dtable; clkt->div; clkt++) {
> +               if (max < clkt->div)

"max" is used uninitialized

> +                       max = clkt->div;
> +       }
> +
> +       div_hw_data->hw_data.priv = priv;
> +       div_hw_data->hw_data.conf = core->conf;
> +       div_hw_data->hw_data.sconf = core->sconf;
> +       div_hw_data->dtable = core->dtable;
> +       div_hw_data->invalid_rate = core->invalid_rate;
> +       div_hw_data->width = fls(max) - 1;

Isn't that
> +
> +       clk_hw = &div_hw_data->hw_data.hw;
> +       clk_hw->init = &init;
> +
> +       ret = devm_clk_hw_register(priv->dev, clk_hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       ret = rzg2l_register_notifier(clk_hw, core, priv);
> +       if (ret) {
> +               dev_err(priv->dev, "Failed to register notifier for %s\n",
> +                       core->name);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return clk_hw->clk;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
