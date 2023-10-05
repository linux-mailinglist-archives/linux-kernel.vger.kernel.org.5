Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484657B9F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjJEOVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjJEOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:19:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D630346B7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 22:04:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b98a699f45so97034566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 22:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696482278; x=1697087078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pk7xhwaEkFwHhfMjiYSi4Y46b4kEa0zBr986kaxm2TY=;
        b=Vir067bCwojLHC0ot/HGBLreO2CUq3JuqbLfPY68+RAIiriiKKGHcT2IHpwKzpf/ll
         iEIVMz9PvFd/6pWp3UaOF2iGUuaGvaH3cSlp8WOOUws/USDfSJOjjsXTSE2yp+PQoMwU
         FCxbylRVSVoOfisbkeus46hNsfCFwfk5ldPyCJ+HGqzwYwdbQpGkqHm15UhFeI6FYZKW
         /XAgWORw5WWlAQboFVi6NZWmLKiEFuA4MmrIrrvkNPQpNwXxCBfTC0mdFB2ItY9WxYbb
         XXMUfL3MDzFIEaHbc15/kKhpeoAXapIx3GQUbqzR+iUbtYxhfbddfoW+kWdgklIHciB6
         k6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482278; x=1697087078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk7xhwaEkFwHhfMjiYSi4Y46b4kEa0zBr986kaxm2TY=;
        b=cc31CZsQpasyMFPyW216rtRucxk1lJcdy85MPfpQICXt95FYIuTyDK2cTJ6Q9mBOLE
         XLq2i414VexCL9HcltfqAsp0V+ujC8rzM4qcv4E7B4KamJ4p3e66RXerl+an9N5OZDOt
         BNUXALv6zD9nmTJ2FEmUsfsiAWGvVSuGacOZKU8g7oQR8SjB4rLI0FJY8RvNmAy5NeAv
         lIhu7tWv23gUaqtUVEle+5k7dok+oQIgRKkHx8bgPtdfpBlUAKlaK+jKi2YIimeilTW8
         AFoh+IB+3PG/bUzzlLaZ9chiJ6eAH3w1LWURXQfs8z71KKwRxreC9uOA7KLiXjqxtRC2
         fgVw==
X-Gm-Message-State: AOJu0Yz6esIOz9fBmVBoCj9WQTssDmMjMbuB99Le+zNctTgSLy3Ip3Cb
        bmFo8wRf9G7HCOuQ01blYgR6sw==
X-Google-Smtp-Source: AGHT+IGzJcUaJeonUrdeYzfxApEYs0xmavQL/PnwdaussVLk71huq1WhzcxLhuwdCLhFhyXgP9U4TA==
X-Received: by 2002:a17:907:2cd7:b0:9b9:4509:d57a with SMTP id hg23-20020a1709072cd700b009b94509d57amr2161870ejc.13.1696482278069;
        Wed, 04 Oct 2023 22:04:38 -0700 (PDT)
Received: from [192.168.32.2] ([147.161.130.252])
        by smtp.gmail.com with ESMTPSA id n2-20020a1709061d0200b009a0955a7ad0sm483292ejh.128.2023.10.04.22.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 22:04:37 -0700 (PDT)
Message-ID: <45949999-47f5-6811-9709-41abddb18cdf@tuxon.dev>
Date:   Thu, 5 Oct 2023 08:04:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 11/28] clk: renesas: rzg2l: add a divider clock for
 RZ/G3S
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
 <20230929053915.1530607-12-claudiu.beznea@bp.renesas.com>
 <CAMuHMdX8wPNr4LsPJR7zk3Ktb8NnqcSMUEjsAURc2NJ_dpiDHw@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdX8wPNr4LsPJR7zk3Ktb8NnqcSMUEjsAURc2NJ_dpiDHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 04.10.2023 15:30, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add a divider clock driver for RZ/G3S. This will be used in RZ/G3S
>> by SDHI, SPI, OCTA, I, I2, I3, P0, P1, P2, P3 core clocks.
>> The divider has some limitation for SDHI and OCTA clocks:
>> - SD div cannot be 1 if parent rate is 800MHz
>> - OCTA div cannot be 1 if parent rate is 400MHz
>> For these clocks a notifier could be registered from platform specific
>> clock driver and proper actions are taken before clock rate is changed,
>> if needed.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - removed DIV_NOTIF macro
> 
> Thanks for the update!
> 
>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>> @@ -91,6 +91,22 @@ struct sd_mux_hw_data {
>>
>>  #define to_sd_mux_hw_data(_hw) container_of(_hw, struct sd_mux_hw_data, hw_data)
>>
>> +/**
>> + * struct div_hw_data - divider clock hardware data
>> + * @hw_data: clock hw data
>> + * @dtable: pointer to divider table
>> + * @invalid_rate: invalid rate for divider
>> + * @width: divider width
>> + */
>> +struct div_hw_data {
>> +       struct clk_hw_data hw_data;
>> +       const struct clk_div_table *dtable;
>> +       unsigned long invalid_rate;
>> +       u32 width;
>> +};
>> +
>> +#define to_div_hw_data(_hw)    container_of(_hw, struct div_hw_data, hw_data)
>> +
>>  struct rzg2l_pll5_param {
>>         u32 pl5_fracin;
>>         u8 pl5_refdiv;
>> @@ -200,6 +216,54 @@ int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event
>>         return ret;
>>  }
>>
>> +int rzg3s_cpg_div_clk_notifier(struct notifier_block *nb, unsigned long event,
>> +                              void *data)
>> +{
>> +       struct clk_notifier_data *cnd = data;
>> +       struct clk_hw *hw = __clk_get_hw(cnd->clk);
>> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
>> +       struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
>> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
>> +       u32 off = GET_REG_OFFSET(clk_hw_data->conf);
>> +       u32 shift = GET_SHIFT(clk_hw_data->conf);
>> +       u32 bitmask = GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
>> +       unsigned long flags;
>> +       int ret = 0;
>> +       u32 val;
>> +
>> +       if (event != PRE_RATE_CHANGE || !div_hw_data->invalid_rate ||
>> +           div_hw_data->invalid_rate % cnd->new_rate)
>> +               return 0;
> 
> NOTIFY_DONE for event != PRE_RATE_CHANGE
> NOTIFY_OK for the other cases

Sure!

> 
>> +
>> +       spin_lock_irqsave(&priv->rmw_lock, flags);
>> +
>> +       val = readl(priv->base + off);
>> +       val >>= shift;
>> +       val &= bitmask;
>> +
>> +       /*
>> +        * There are different constraints for the user of this notifiers as follows:
>> +        * 1/ SD div cannot be 1 (val == 0) if parent rate is 800MHz
>> +        * 2/ OCTA div cannot be 1 (val == 0) if parent rate is 400MHz
>> +        * As SD can have only one parent having 800MHz and OCTA div can have
>> +        * only one parent having 400MHz we took into account the parent rate
>> +        * at the beginning of function (by checking invalid_rate % new_rate).
>> +        * Now it is time to check the hardware divider and update it accordingly.
>> +        */
>> +       if (!val) {
>> +               writel(((bitmask << shift) << 16) | BIT(shift), priv->base + off);
> 
> Haven't you exchanged the (single) write-enable bit and the (multi-bit)
> division ratio setting?  According to the docs, the write-enable bit
> is at 16 + shift, while the division ratio is at shift.

Indeed, I messed this up. Though, I've tested quite some use cases and they
all worked... I'll review this anyway, thanks for pointing it up.

> 
> Also, using bitmask as the division ratio means the maximum value
> that fits in the bitfield, which would be a prohibited setting in case
> of DIV_OCTA.
> 
> Now, looking at rzg3s_div_clk_set_rate() below, perhaps you just wanted
> to set the ratio to value to 1, but used the wrong size for bitmask?

Yes, the idea was to set a safe divider.

> 
>> +               /* Wait for the update done. */
>> +               ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
>> +       }
>> +
>> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
>> +
>> +       if (ret)
>> +               dev_err(priv->dev, "Failed to downgrade the div\n");
> 
> and return NOTIFY_BAD

Sure!

> 
>> +
>> +       return ret;
> 
> NOTIFY_OK

Sure!

> 
>> +}
>> +
>>  static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
>>                                    struct rzg2l_cpg_priv *priv)
>>  {
>> @@ -217,6 +281,146 @@ static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk
>>         return clk_notifier_register(hw->clk, nb);
>>  }
>>
>> +static unsigned long rzg3s_div_clk_recalc_rate(struct clk_hw *hw,
>> +                                              unsigned long parent_rate)
>> +{
>> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
>> +       struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
>> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
>> +       u32 val;
>> +
>> +       val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
>> +       val >>= GET_SHIFT(clk_hw_data->conf);
>> +       val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
>> +
>> +       return divider_recalc_rate(hw, parent_rate, val, div_hw_data->dtable,
>> +                                  CLK_DIVIDER_ROUND_CLOSEST, div_hw_data->width);
>> +}
>> +
>> +static bool rzg3s_div_clk_is_rate_valid(const unsigned long invalid_rate, unsigned long rate)
>> +{
>> +       if (invalid_rate && rate >= invalid_rate)
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>> +static long rzg3s_div_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                                    unsigned long *parent_rate)
>> +{
>> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
>> +       struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
>> +       long round_rate;
>> +
>> +       round_rate = divider_round_rate(hw, rate, parent_rate, div_hw_data->dtable,
>> +                                       div_hw_data->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +
>> +       if (!rzg3s_div_clk_is_rate_valid(div_hw_data->invalid_rate, round_rate))
>> +               return -EINVAL;
> 
> Shouldn't this return the closest rate that is actually supported instead?

The divider_round_rate() already choose it as the closest rate that it is
actually not supported, thus I chose to just return -EINVAL. I chose it
this way to use divider_round_rate(). Don't know if there is way around
this using divider_round_rate() I'll have a look.

> 
>> +
>> +       return round_rate;
>> +}
> 
> But please implement .determine_rate() instead of .round_rate() in
> new drivers.

Indeed, I missed this one.

> 
>> +
>> +static int rzg3s_div_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                 unsigned long parent_rate)
>> +{
>> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
>> +       struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
>> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
>> +       u32 off = GET_REG_OFFSET(clk_hw_data->conf);
>> +       u32 shift = GET_SHIFT(clk_hw_data->conf);
>> +       unsigned long flags;
>> +       u32 bitmask, val;
>> +       int ret;
>> +
>> +       /*
>> +        * Some dividers cannot support some rates:
>> +        * - SD div cannot support 800 MHz when parent is @800MHz and div = 1
>> +        * - OCTA div cannot support 400 MHz when parent is @400MHz and div = 1
>> +        * Check these scenarios.
>> +        */
>> +       if (!rzg3s_div_clk_is_rate_valid(div_hw_data->invalid_rate, rate))
>> +               return -EINVAL;
> 
> Can this actually happen? Wouldn't the notifier have prevented us from
> getting here?

I remember I added it here as a result of testing. I'll double check it.

> 
>> +
>> +       val = divider_get_val(rate, parent_rate, div_hw_data->dtable, div_hw_data->width,
>> +                             CLK_DIVIDER_ROUND_CLOSEST);
>> +
>> +       bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
> 
> Is bitmask the (single) write-enable bit?
> 
> If yes, that should be BIT(16 + shift), and the variable should be
> renamed to reflect that.
> 
> I guess there should be a general "#define CPG_WEN BIT(16)", then you
> can simply use
> 
>     writel((CPG_WEN | val) << shift, ...);

OK.

> 
>> +
>> +       spin_lock_irqsave(&priv->rmw_lock, flags);
>> +       writel(bitmask | (val << shift), priv->base + off);
>> +       /* Wait for the update done. */
>> +       ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
>> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
>> +
>> +       return ret;
>> +}
>> +
>> +static const struct clk_ops rzg3s_div_clk_ops = {
>> +       .recalc_rate = rzg3s_div_clk_recalc_rate,
>> +       .round_rate = rzg3s_div_clk_round_rate,
>> +       .set_rate = rzg3s_div_clk_set_rate,
>> +};
>> +
>> +static struct clk * __init
>> +rzg3s_cpg_div_clk_register(const struct cpg_core_clk *core, struct clk **clks,
>> +                          void __iomem *base, struct rzg2l_cpg_priv *priv)
>> +{
>> +       struct div_hw_data *div_hw_data;
>> +       struct clk_init_data init = {};
>> +       const struct clk_div_table *clkt;
>> +       struct clk_hw *clk_hw;
>> +       const struct clk *parent;
>> +       const char *parent_name;
>> +       u32 max;
>> +       int ret;
>> +
>> +       parent = clks[core->parent & 0xffff];
>> +       if (IS_ERR(parent))
>> +               return ERR_CAST(parent);
>> +
>> +       parent_name = __clk_get_name(parent);
>> +
>> +       div_hw_data = devm_kzalloc(priv->dev, sizeof(*div_hw_data), GFP_KERNEL);
>> +       if (!div_hw_data)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = core->name;
>> +       init.flags = core->flag;
>> +       init.ops = &rzg3s_div_clk_ops;
>> +       init.parent_names = &parent_name;
>> +       init.num_parents = 1;
>> +
>> +       /* Get the maximum divider to retrieve div width. */
>> +       for (clkt = core->dtable; clkt->div; clkt++) {
>> +               if (max < clkt->div)
> 
> "max" is used uninitialized

Yes, you're right.

Thank you for your review,
Claudiu Beznea

> 
>> +                       max = clkt->div;
>> +       }
>> +
>> +       div_hw_data->hw_data.priv = priv;
>> +       div_hw_data->hw_data.conf = core->conf;
>> +       div_hw_data->hw_data.sconf = core->sconf;
>> +       div_hw_data->dtable = core->dtable;
>> +       div_hw_data->invalid_rate = core->invalid_rate;
>> +       div_hw_data->width = fls(max) - 1;
> 
> Isn't that
>> +
>> +       clk_hw = &div_hw_data->hw_data.hw;
>> +       clk_hw->init = &init;
>> +
>> +       ret = devm_clk_hw_register(priv->dev, clk_hw);
>> +       if (ret)
>> +               return ERR_PTR(ret);
>> +
>> +       ret = rzg2l_register_notifier(clk_hw, core, priv);
>> +       if (ret) {
>> +               dev_err(priv->dev, "Failed to register notifier for %s\n",
>> +                       core->name);
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       return clk_hw->clk;
>> +}
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
