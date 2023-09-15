Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B397A1782
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjIOHav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOHas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:30:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DE1BD4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:30:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c3c8adb27so236694366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694763033; x=1695367833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ee9af7igQa5HL8O6AExww0fv//8+9cpPLEMTss6zMNc=;
        b=nCjZM+bm+DcK18kJS3K/6Gl61tR/Wag3OjdFqBIiGDRrUwlTjwY1GBJ/eZhkfGhQCh
         8SJcnhFMlnuqJ/71EkhrJ+VBVomVyRCYgjCszjjunnuZbEhd9xcd7t9nTnrfkMg2mDtX
         hJcbujn4ZRisNVZhTkAZhTPgHvOqv8BAuWBqXb39sfhazKMpqQiKVvGyXvAvRbsECjsw
         29UtOmMKMLFT1/9s6Dndzlo9/Q2us56mtplcLraM5Pep6awEFe0AoClv4EZWTOAEGFr8
         YVFp1q78x51FIRD6srqDX3sl3JlVgGPVfgdHQHQqXqXoKK94nRXoE1iw7dRC8rE3ju/j
         7BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763033; x=1695367833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ee9af7igQa5HL8O6AExww0fv//8+9cpPLEMTss6zMNc=;
        b=Dkr87udYxmWoJYJdBZ5zf9AqOTY8F40xrLD/WAJNsEbU5tn/p/pBJ3VJAhPnHKmn0H
         9dEPCxG/H0JoOHFAkP0R8HF7GbJ7wtVlXlI7Zm7+kj5OLCBrI6Jbu9OgCZtttRLiQtgn
         rPCL0PByOESSUwpLT13lnfnAf6Sa18Ln5d+pqBs5gRL2QyhKPNOCrgKNtQtyQnKQQDGv
         9k3rdwmYDTbcHZS4WlpXvcU5TbKN7NCPl8tXcohAXyvblSyJw7Dj1VDYfZqn6cPQwJ0x
         FQK/omEgs19ow1/PHFPFCicmiAivXc6T/N5oZkLTO7ldpBdkURm/U+YzTCOEc+L2rxvh
         WMYw==
X-Gm-Message-State: AOJu0YxGmhrMruhrL5cdfQikc03shlFx5SLQukGe2Hkmj6/3a4wVnMLp
        fE1XfMRuCbW2swld6GwcQFdjGQ==
X-Google-Smtp-Source: AGHT+IGj4rVdjBzxSIQm/X1vlccA60OAhZ6GV3tGMV2MmaS4ONiCjIZhUwGSfIaEWjxK00Kuf9oe9Q==
X-Received: by 2002:a17:906:1c9:b0:99b:dd1d:bc58 with SMTP id 9-20020a17090601c900b0099bdd1dbc58mr686673ejj.41.1694763033178;
        Fri, 15 Sep 2023 00:30:33 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709066c9600b00993a9a951fasm2042519ejr.11.2023.09.15.00.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:30:32 -0700 (PDT)
Message-ID: <1ef2d7d4-93d4-969d-6618-3b81926418d5@tuxon.dev>
Date:   Fri, 15 Sep 2023 10:30:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 18/37] clk: renesas: rzg2l: refactor sd mux driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-19-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdX9PYdESi6OAFSUS1NsFs9oPPV7Cd+uMHTtFRhkaq3Xzw@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdX9PYdESi6OAFSUS1NsFs9oPPV7Cd+uMHTtFRhkaq3Xzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 14.09.2023 18:18, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch!
> 
> On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Refactor SD MUX driver to be able to reuse the same code on RZ/G3S.
>> RZ/G2{L, UL} has a limitation with regards to switching the clock source
>> for SD MUX (MUX clock source has to be switched to 266MHz before switching
>> b/w 533MHz and 400MHz). This limitation has been introduced as a clock
>> notifier that is registered on platform based initialization data thus the
>> SD MUX code could be reused on RZ/G3S.
>>
>> As both RZ/G2{L, UL} and RZ/G3S has specific bits in specific registers
>> to check if the clock switching has been done, this configuration (register
>> offset, register bits and bits width) is now passed though
>> struct cpg_core_clk::sconf (status configuration) from platform specific
>> initialization code.
>>
>> Along with struct cpg_core_clk::sconf the mux table indexes is also
> 
> indices are
> 
>> passed from platform specific initialization code.
> 
> Please also mention the passing of the mux flags, which is added so
> you can pass CLK_SET_PARENT_GATE for G3S_SEL_PLL4 later.

Ok.

> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- a/drivers/clk/renesas/r9a07g043-cpg.c
>> +++ b/drivers/clk/renesas/r9a07g043-cpg.c
>> @@ -21,6 +21,10 @@
>>  #define G2UL_SEL_SDHI0         SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 0, 2)
>>  #define G2UL_SEL_SDHI1         SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 4, 2)
>>
>> +/* Clock status configuration. */
>> +#define G2UL_SEL_SDHI0_STS     SEL_PLL_PACK(CPG_CLKSTATUS, 28, 1)
>> +#define G2UL_SEL_SDHI1_STS     SEL_PLL_PACK(CPG_CLKSTATUS, 29, 1)
> 
> Just like in [PATCH 17/37], there is no real need for the "G2UL_"-prefix.

Ok, I ususlly tend to guard everything with a proper namespace.

> 
>> +
>>  enum clk_ids {
>>         /* Core Clock Outputs exported to DT */
>>         LAST_DT_CORE_CLK = R9A07G043_CLK_P0_DIV2,
>> @@ -85,6 +89,8 @@ static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
>>  static const char * const sel_pll6_2[] = { ".pll6_250", ".pll5_250" };
>>  static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
>>
>> +static const u32 mtable_sdhi[] = {1, 2, 3};
> 
> { 1, 2, 3 };
> 
> (everywhere)

ok

> 
>> +
>>  static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
>>         /* External Clock Inputs */
>>         DEF_INPUT("extal", CLK_EXTAL),
> 
>> @@ -137,6 +141,77 @@ static void rzg2l_cpg_del_clk_provider(void *data)
>>         of_clk_del_provider(data);
>>  }
>>
>> +/* Must be called in atomic context. */
>> +static int rzg2l_cpg_wait_clk_update_done(void __iomem *base, u32 conf)
>> +{
>> +       u32 bitmask = GENMASK(GET_WIDTH(conf) - 1, 0) << GET_SHIFT(conf);
>> +       u32 off = GET_REG_OFFSET(conf);
>> +       u32 val;
>> +
>> +       return readl_poll_timeout_atomic(base + off, val, !(val & bitmask), 100, 20000);
>> +}
>> +
>> +int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event,
>> +                                 void *data)
>> +{
>> +       struct clk_notifier_data *cnd = data;
>> +       struct clk_hw *hw = __clk_get_hw(cnd->clk);
>> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
>> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
>> +       u32 off = GET_REG_OFFSET(clk_hw_data->conf);
>> +       u32 shift = GET_SHIFT(clk_hw_data->conf);
>> +       const u32 clk_src_266 = 3;
>> +       unsigned long flags;
>> +       u32 bitmask;
>> +       int ret;
>> +
>> +       if (event != PRE_RATE_CHANGE || (cnd->new_rate / MEGA == 266))
>> +               return 0;
>> +
>> +       spin_lock_irqsave(&priv->rmw_lock, flags);
>> +
>> +       /*
>> +        * As per the HW manual, we should not directly switch from 533 MHz to
>> +        * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
>> +        * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
>> +        * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
>> +        * (400 MHz)).
>> +        * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
>> +        * switching register is prohibited.
>> +        * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
>> +        * the index to value mapping is done by adding 1 to the index.
>> +        */
>> +       bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
>> +       writel(bitmask | (clk_src_266 << shift), priv->base + off);
>> +
>> +       /* Wait for the update done. */
>> +       ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
>> +
>> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
>> +
>> +       if (ret)
>> +               dev_err(priv->dev, "failed to switch to safe clk source\n");
>> +
>> +       return ret;
>> +}
>> +
>> +static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
>> +                                  struct rzg2l_cpg_priv *priv)
>> +{
>> +       struct notifier_block *nb;
>> +
>> +       if (!core->notifier)
>> +               return 0;
>> +
>> +       nb = devm_kzalloc(priv->dev, sizeof(*nb), GFP_KERNEL);
>> +       if (!nb)
>> +               return -ENOMEM;
>> +
>> +       nb->notifier_call = core->notifier;
>> +
>> +       return clk_notifier_register(hw->clk, nb);
>> +}
> 
> I am not sure a notifier is the best solution.  Basically on RZ/G2L,
> when changing the parent clock, you need to switch to a fixed
> intermediate parent first.
> What about just replacing the fixed clk_src_266 in the old
> rzg2l_cpg_sd_mux_clk_set_parent() by a (signed) integer in
> sd_mux_hw_data (specified in DEF_SD_MUX()), representing the index
> of the intermediate clock?
> -1 would mean an intermediate parent is not needed.

That should work too but .set_rate() will be bulky for both mux and div.

The idea was to have the .set_rate() common to the mux and the platform
specificities implemented as notifiers and only the needed platforms to
instantiate the notifier. And the same approach to be used by the divider
(patch "[PATCH 19/37] clk: renesas: rzg2l: add a divider clock for RZ/G3S")

With this it looked to me that the final code is more compact .set_rate
being simple and platform specificities being implemented in notifier
(valid for both MUX and DIV). The infrastructure is already there for
notifier to be called before .set_rate().

> 
>> +
>>  static struct clk * __init
>>  rzg2l_cpg_div_clk_register(const struct cpg_core_clk *core,
>>                            struct clk **clks,
>> @@ -197,72 +272,54 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
>>         return clk_hw->clk;
>>  }
>>
>> -static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>> +static u8 rzg2l_cpg_sd_mux_clk_get_parent(struct clk_hw *hw)
>> +{
>> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
>> +       struct sd_mux_hw_data *sd_mux_hw_data = to_sd_mux_hw_data(clk_hw_data);
>> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
>> +       u32 val;
>> +
>> +       val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
>> +       val >>= GET_SHIFT(clk_hw_data->conf);
>> +       val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
>> +
>> +       return clk_mux_val_to_index(hw, sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, val);
>> +}
>> +
>> +static int rzg2l_cpg_sd_mux_clk_set_parent(struct clk_hw *hw, u8 index)
>>  {
>>         struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
>> +       struct sd_mux_hw_data *sd_mux_hw_data = to_sd_mux_hw_data(clk_hw_data);
>>         struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
>>         u32 off = GET_REG_OFFSET(clk_hw_data->conf);
>>         u32 shift = GET_SHIFT(clk_hw_data->conf);
>> -       const u32 clk_src_266 = 2;
>> -       u32 msk, val, bitmask;
>>         unsigned long flags;
>> +       u32 bitmask, val;
>>         int ret;
>>
>> -       /*
>> -        * As per the HW manual, we should not directly switch from 533 MHz to
>> -        * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
>> -        * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
>> -        * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
>> -        * (400 MHz)).
>> -        * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
>> -        * switching register is prohibited.
>> -        * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
>> -        * the index to value mapping is done by adding 1 to the index.
>> -        */
>> +       val = clk_mux_index_to_val(sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, index);
>> +
>>         bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
>> +
>>         spin_lock_irqsave(&priv->rmw_lock, flags);
>> -       if (index != clk_src_266) {
>> -               writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
>>
>> -               msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
>> +       writel(bitmask | (val << shift), priv->base + off);
>>
>> -               ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
>> -                                               !(val & msk), 100,
>> -                                               CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
>> -               if (ret)
>> -                       goto unlock;
>> -       }
>> +       /* Wait for the update done. */
>> +       ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
>>
>> -       writel(bitmask | ((index + 1) << shift), priv->base + off);
>> -
>> -       ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
>> -                                       !(val & msk), 100,
>> -                                       CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
>> -unlock:
>>         spin_unlock_irqrestore(&priv->rmw_lock, flags);
>>
>>         if (ret)
>> -               dev_err(priv->dev, "failed to switch clk source\n");
>> +               dev_err(priv->dev, "Failed to switch parent\n");
>>
>>         return ret;
>>  }
>>
>> -static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
>> -{
>> -       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
>> -       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
>> -       u32 val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
>> -
>> -       val >>= GET_SHIFT(clk_hw_data->conf);
>> -       val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
>> -
>> -       return val ? --val : val;
>> -}
> 
> This would be easier to review if you kept the order and name of the
> .[gs]et_parent() callbacks.

Appologies about that, I'll try to adapt it in the next version.

> 
>> -
>>  static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
>>         .determine_rate = __clk_mux_determine_rate_closest,
>> -       .set_parent     = rzg2l_cpg_sd_clk_mux_set_parent,
>> -       .get_parent     = rzg2l_cpg_sd_clk_mux_get_parent,
>> +       .set_parent     = rzg2l_cpg_sd_mux_clk_set_parent,
>> +       .get_parent     = rzg2l_cpg_sd_mux_clk_get_parent,
>>  };
> 
>> --- a/drivers/clk/renesas/rzg2l-cpg.h
>> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> 
>> @@ -86,8 +88,11 @@ struct cpg_core_clk {
>>         unsigned int mult;
>>         unsigned int type;
>>         unsigned int conf;
>> +       unsigned int sconf;
>>         const struct clk_div_table *dtable;
>> +       const u32 *mtable;
>>         const char * const *parent_names;
>> +       notifier_fn_t notifier;
> 
> FTR, this is growing each core clock entry by 24 bytes (on arm64).
> We really should start using unions, but that is a bigger overhaul...
> 
>>         u32 flag;
>>         u32 mux_flags;
>>         int num_parents;
> 
>> @@ -272,4 +278,9 @@ extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
>>  extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
>>  extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
>>
>> +int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
>> +
>> +/* Macros to be used in platform specific initialization code. */
>> +#define SD_MUX_NOTIF           (&rzg2l_cpg_sd_mux_clk_notifier)
> 
> Any specific reason you are adding this macro?

It looked to me like a better name to be used in platform specific drivers.

> What is wrong with using &rzg2l_cpg_sd_mux_clk_notifier directly?

Nothing, just that it is a longer than SD_MUX_NOTIF.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
