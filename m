Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F97F9B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjK0Hhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0Hhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:37:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC68134
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:37:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a00a9d677fcso524872666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701070655; x=1701675455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scHiT0Xo/KLWsBCLyWjvRQ5uVQcQfMVVyC6A152Vb/c=;
        b=DjeYRCldpxx4QjpEftRKp7OFMnhUrm1/De0s6kHU/Wjxa0YyhWcf6n0KB7ww0JnRfw
         oxWK0BW2xc5PwWvapo7kRp6AvaysdsIEQJWXSltjVIKG0a5ogwsT/+eJuGLHWOl09Rr3
         JphJKqhX0qyVTzfOKG69ZAzS8yGau/OQkStugZUmipy0LHOTcj7OG9y/qraWxYE/99kg
         iWrRg8gjMvqROn+lCMK9oTDzu2thXZxbOPrboCCx/rGJ6FKGv0mosYPGHMSCZj+OHiYj
         IbNFJf4XzMagnLOdp9yo/jUN/0q9LREJ1rX+c5u9S8LcrX0hKN81c23CD2eKqWJfpa3b
         18RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701070655; x=1701675455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scHiT0Xo/KLWsBCLyWjvRQ5uVQcQfMVVyC6A152Vb/c=;
        b=EoUlpGFVlKyS67h2q2lMJ7J44L02oNQXtRM6ozdYpfKJzbtIAtB+5Xss0Qp10vZtTc
         +KrNybOnXdkNwMG9V48KdtZ7ze+eQBY2YKb6oCdKpAFvGzl+hfZU8D9GuAlHMk3DE9VN
         Swkmh1IVbo2Rbw7KbdGEl4PvtKJndhMCpRg1BGSbzMH/6UAjx20LhqrW+NkQl6r/CPqi
         fGptY71GFMK23V4rSwKNKJoqyr3Um9xzoqZN1wioivF/hKdb2+QfTXkKb1gmTgNbcol0
         FmC9K2YXeamx824aJl3Z/Qfl5O2YtK0Ev/PVjxBDtzTwmeBUs1gRD4f/MQdBOBxQFdNK
         KNAw==
X-Gm-Message-State: AOJu0Yzl5u0KeRrIFi7tbY8a4k4M7itK2+MJ4t40nvMm3ZrD+xKTyncV
        CrYdKReKzVEyaEfPgWF/MOGQ1w==
X-Google-Smtp-Source: AGHT+IFUHRZrWVKXHlqz5bmA/5BdGKLgt9BLh5gYYMZivaNLtxnVAdSXgaVpZJ/zGe8IZJJLh7JXsQ==
X-Received: by 2002:a17:906:10d7:b0:a0c:85f8:c1f4 with SMTP id v23-20020a17090610d700b00a0c85f8c1f4mr3850762ejv.56.1701070654693;
        Sun, 26 Nov 2023 23:37:34 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906351600b00a0c01560bdfsm2579128eja.139.2023.11.26.23.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:37:34 -0800 (PST)
Message-ID: <55a0048a-7fa1-49cd-a70f-8f7d948adf27@tuxon.dev>
Date:   Mon, 27 Nov 2023 09:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] clk: renesas: rzg2l-cpg: Add support for MSTOP
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVMpKVY8WX7dbtHfgnwgePH+i9+2BAumb37sFmqccb44g@mail.gmail.com>
 <CAMuHMdVWvVtFMUe+J9R2ZU8Hi5CGs0NQfwUxitganM85183KkA@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVWvVtFMUe+J9R2ZU8Hi5CGs0NQfwUxitganM85183KkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 24.11.2023 11:08, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, Nov 23, 2023 at 5:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> RZ/{G2L, V2L, G3S} based CPG versions have support for saving extra
>>> power when clocks are disabled by activating module standby. This is done
>>> though MSTOP specific registers that are part of CPG. Each individual
>>> module have one or more bits associated in one MSTOP register (see table
>>> "Registers for Module Standby Mode" from HW manuals). Hardware manual
>>> associates modules' clocks to one or more MSTOP bits. There are 3 mappings
>>> available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW manuals):
>>>
>>> case 1: N clocks mapped to N MSTOP bits (with N={0, ..., X})
>>> case 2: N clocks mapped to 1 MSTOP bit  (with N={0, ..., X})
>>> case 3: N clocks mapped to M MSTOP bits (with N={0, ..., X}, M={0, ..., Y})
>>>
>>> Case 3 has been currently identified on RZ/V2L for VCPL4 module.
>>>
>>> To cover all 3 cases the individual platform drivers will provide to
>>> clock driver MSTOP register offset and associated bits in this register
>>> as a bitmask and the clock driver will apply this bitmask to proper
>>> MSTOP register.
>>>
>>> As most of the modules have more than one clock and these clocks are
>>> mapped to 1 MSTOP bitmap that need to be applied to MSTOP registers,
>>> to avoid switching the module to/out of standby when the module has
>>> enabled/disabled clocks a counter has been associated to each module
>>> (though struct mstop::count) which is incremented/decremented every
>>> time a module's clock is enabled/disabled and the settings to MSTOP
>>> register are applied only when the counter reaches zero (counter zero
>>> means either 1st clock of the module is going to be enabled or all clocks
>>> of the module are going to be disabled).
>>
>> Thanks for your patch!
>>
>>> The MSTOP functionality has been instantiated at the moment for RZ/G3S.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>>> @@ -1177,6 +1177,17 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
>>>                 core->name, PTR_ERR(clk));
>>>  }
>>>
>>> +/**
>>> + * struct mstop - MSTOP specific data structure
>>> + * @count: reference counter for MSTOP settings (when zero the settings
>>> + *        are applied to register)
>>> + * @conf: MSTOP configuration (register offset, setup bits)
>>> + */
>>> +struct mstop {
>>> +       u32 count;
>>> +       u32 conf;
>>> +};
>>> +
>>>  /**
>>>   * struct mstp_clock - MSTP gating clock
>>>   *
>>> @@ -1186,6 +1197,7 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
>>>   * @enabled: soft state of the clock, if it is coupled with another clock
>>>   * @priv: CPG/MSTP private data
>>>   * @sibling: pointer to the other coupled clock
>>> + * @mstop: MSTOP configuration
>>>   */
>>>  struct mstp_clock {
>>>         struct clk_hw hw;
>>> @@ -1194,10 +1206,46 @@ struct mstp_clock {
>>>         bool enabled;
>>>         struct rzg2l_cpg_priv *priv;
>>>         struct mstp_clock *sibling;
>>> +       struct mstop *mstop;
>>>  };
>>>
>>>  #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
>>>
>>> +/* Need to be called with a lock held to avoid concurent access to mstop->count. */
>>
>> concurrent
>>
>>> +static void rzg2l_mod_clock_module_set_standby(struct mstp_clock *clock,
>>> +                                              bool standby)
>>> +{
>>> +       struct rzg2l_cpg_priv *priv = clock->priv;
>>> +       struct mstop *mstop = clock->mstop;
>>> +       bool update = false;
>>> +       u32 value;
>>> +
>>> +       if (!mstop)
>>> +               return;
>>> +
>>> +       value = MSTOP_MASK(mstop->conf) << 16;
>>> +
>>> +       if (standby) {
>>> +               value |= MSTOP_MASK(mstop->conf);
>>> +               /* Avoid overflow. */
>>> +               if (mstop->count > 0)
>>> +                       mstop->count--;
>>
>> Should we add a WARN() here, or is it sufficient to rely on the WARN()
>> in drivers/clk/clk.c:clk_core_disable()?
>>
>>> +
>>> +               if (!mstop->count)
>>> +                       update = true;
>>> +       } else {
>>> +               if (!mstop->count)
>>> +                       update = true;
>>> +
>>> +               /* Avoid overflow. */
>>> +               if (mstop->count + 1 != 0)
>>> +                       mstop->count++;
>>
>> Trying to avoid an overflow won't help much here.  The counter
>> will be wrong afterwards anyway, and when decrementing again later, the
>> module will be put in standby too soon...
>>
>>> +       }
>>> +
>>> +       if (update)
>>> +               writel(value, priv->base + MSTOP_OFF(mstop->conf));
>>> +}
> 
> After giving this some more thought, it feels odd to derive the standby
> state of a module from the state of its module clocks, while the latter
> are already controlled through Runtime PM and a Clock Domain.

Thanks for sharing this.

> 
> A first alternative solution could be to drop the GENPD_FLAG_PM_CLK
> flag from the RZ/G2L CPG clock domain, and provide your own
> gpd_dev_ops.start() and .stop() callbacks that take care of both
> module standby and clocks (through pm_clk_{resume,suspend}().
> (See https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/base/power/domain.c#L2093
> for the GENPD_FLAG_PM_CLK case).
> That still leaves you with a need to associate an MSTOP register and
> bitmask with a device through its module clocks.
> 
> A second alternative solution could be to increase #power-domain-cells
> from zero to one, and register individual PM Domains for each module,
> and control module standby from the generic_pm_domain.power_{on,off}()
> callbacks.  Devices would specify the module using the power-domains =
> <&cpg <id> > property in DT, with <id> one of the to-be-added list of
> modules in include/dt-bindings/clock/r9a08g045-cpg.h.  The RZ/G2L CPG
> driver can handle the mapping from <id> to MSTOP register and bitmask.
> This solution requires updates to DT, but you can keep compatibility
> with old DTBs by only registering the new PM Domains when
> #power-domain-cells is one.
> The extra power saving would only be applicable with new DTBs, though.

I prefer this alternative even though it cannot be applied for old DTBs, it
looks to me that is more modular. What do you think?

The only thing is that MSTOP is not really a power off/on switch (if it
would be implemented with generic_pm_domain.power_{on, off}) but is more
like a clock disable/enable functionality (it should not be an issue
though, just saying)... According to manual (I'm referring to Figure 41.4
Block Connection Overview for Module Standby Mode of HW manula of RZ/G3S),
it disables/enables the module's bus clock.

Thank you,
Claudiu Beznea

> 
> Thoughts?
> 
>>> --- a/drivers/clk/renesas/rzg2l-cpg.h
>>> +++ b/drivers/clk/renesas/rzg2l-cpg.h
>>
>>> @@ -68,6 +73,10 @@
>>>  #define SEL_PLL6_2     SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
>>>  #define SEL_GPU2       SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
>>>
>>> +#define MSTOP(name, bitmask)   ((CPG_##name##_MSTOP) << 16 | (bitmask))
>>
>> I believe the bitmask is always a single bit.
>> So perhaps let MSTOP() take the bit number instead of the bitmaskl?
>> You can still store BIT(bit) inside the macro.
> 
> I was wrong, the N->N or N->M cases need a bitmask.
> 
>>> +#define MSTOP_OFF(conf)                ((conf) >> 16)
>>> +#define MSTOP_MASK(conf)       ((conf) & GENMASK(15, 0))
>>> +
>>>  #define EXTAL_FREQ_IN_MEGA_HZ  (24)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
