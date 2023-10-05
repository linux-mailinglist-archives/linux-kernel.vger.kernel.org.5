Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9887BA58C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbjJEQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbjJEQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4F93583
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 21:24:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so865369a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 21:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696479874; x=1697084674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FDosmr4pTB4y3KlQsf5VlEUdTtkvwPO8SEeca8pbEI=;
        b=hX0m0BamELUggdQn39+7vtvWTGBxZchWqIskXYXn0EsJhWiMfZG57nQmTBttxulXPY
         Xp9GzqCPQRHEHQFrus/zUMu0smuaM4t7G5UDobUNAgHoZUpvQN7S7UFluwh367KmRreo
         DqT8hXm9WcmWoysGWdYnzJaKgSuu3hGmQQeOvEdijxo1Naa3DOsZEXk8s8TxHmPIsEnP
         ugJPDN4Fc3n8ceZW0Ko8UWenQn82/RHit9ogb2jacfS1BnaysYHyrwrWLEVKLHObJvMP
         UWtgKtpPaAJgRiPZtcjXOae2bJDRFAwUYEHyfjwZlQ6YzRtDv+fcB6lltK0jxowXi4k0
         k61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696479874; x=1697084674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FDosmr4pTB4y3KlQsf5VlEUdTtkvwPO8SEeca8pbEI=;
        b=Hd4t6AyolcqpEIKZgNNuBr2FhtLyiVpVN4K8pYxhBRAgKvaI9qgf1hdYalacECsSVQ
         V4yC3UyauCUvx3yDPOBg8qHtOMRaXZKqrYBEfDaN+rJ0SnuuK/ku5l81CVGgmDUdPbeK
         +QGTgpOv1foJYJvacocHkGCC4DmEPj2KNaMheFpvSlki9V6fibCYJ2tkErPX75KS1ddb
         /QM3Ufwo883S9XyyXeeCUKiLwweQ1IUFtf0jSkyTafWV8MtvoAjXExz1nNAThGJqtT95
         kez3m8T4cBSMo7I30yDDt4DvXQVpxzoTQW9XG23JSNwzq+4FecikdPkqnkoaUQV72S1d
         8uHg==
X-Gm-Message-State: AOJu0YxvnbKPGrahSMZ5E2BnHbtkxN3+bPPhYrSy0hu/jhApi2VxIZJN
        cpsUQe2jpkRxmKFxGU6LsoQbIA==
X-Google-Smtp-Source: AGHT+IHa/5RZ0/NvxslXh1L0yV6vSI7aQFJL/Ac85bcm5Do80CLgawrfw75osdtTrQOTg2Bt7hM+iQ==
X-Received: by 2002:aa7:da83:0:b0:533:d81b:36d5 with SMTP id q3-20020aa7da83000000b00533d81b36d5mr3553479eds.15.1696479873654;
        Wed, 04 Oct 2023 21:24:33 -0700 (PDT)
Received: from [192.168.32.2] ([147.161.130.252])
        by smtp.gmail.com with ESMTPSA id w25-20020a056402071900b00537fd4abdc5sm388339edx.54.2023.10.04.21.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 21:24:33 -0700 (PDT)
Message-ID: <0d0448c7-c33b-8960-d2ed-0a22e2f7fb3d@tuxon.dev>
Date:   Thu, 5 Oct 2023 07:24:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 10/28] clk: renesas: rzg2l: refactor sd mux driver
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
 <20230929053915.1530607-11-claudiu.beznea@bp.renesas.com>
 <CAMuHMdUJj+h5LfhQXTNkN3Cp2wP62SX6fY3frzytJQBcKXDJJQ@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUJj+h5LfhQXTNkN3Cp2wP62SX6fY3frzytJQBcKXDJJQ@mail.gmail.com>
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

On 04.10.2023 14:30, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
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
>> Along with struct cpg_core_clk::sconf the mux table indices are also
>> passed from platform specific initialization code.
>>
>> Also, mux flags are now passed to DEF_SD_MUX() as they will be later
>> used by RZ/G3S.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - s/indexes/indices in commit description
>> - mentioned in commit description that mux flags can now be passed to
>>   driver though DEF_SD_MUX() macro
>> - removed SoC specific names from macros' names
>> - added spaces after { and before } when initializing arrays
>> - preserved the order of .[gs]set_parent() API definitions for simpler
>>   diff b/w versions
>> - removed SD_MUX_NOTIF macro
> 
> Thanks for the update!
> 
>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> 
>> @@ -142,6 +146,77 @@ static void rzg2l_cpg_del_clk_provider(void *data)
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
>> +       return readl_poll_timeout_atomic(base + off, val, !(val & bitmask), 10, 200);
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
> 
> include/linux/clk.h:
> 
>  * PRE_RATE_CHANGE - called immediately before the clk rate is changed,
>  *     to indicate that the rate change will proceed.  Drivers must
>  *     immediately terminate any operations that will be affected by the
>  *     rate change.  Callbacks may either return NOTIFY_DONE, NOTIFY_OK,
>  *     NOTIFY_STOP or NOTIFY_BAD.

Indeed I missed these.

> 
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
> 
> Likewise.
> 
>> +}
> 
>>
>>  static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
>>         .determine_rate = __clk_mux_determine_rate_closest,
>> -       .set_parent     = rzg2l_cpg_sd_clk_mux_set_parent,
>> -       .get_parent     = rzg2l_cpg_sd_clk_mux_get_parent,
>> +       .set_parent     = rzg2l_cpg_sd_mux_clk_set_parent,
>> +       .get_parent     = rzg2l_cpg_sd_mux_clk_get_parent,
> 
> Please keep the old names, for consistency with
> __clk_mux_determine_rate_closest() and drivers/clk/clk-mux.c, and to
> reduce the diff.
> 
> Any existing inconsistent use of "clk_mux" vs. "mux_clk" can be resolved
> later with a separate patch, if anyone cares.

ok

> 
>> --- a/drivers/clk/renesas/rzg2l-cpg.h
>> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> 
>> @@ -272,4 +276,6 @@ extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
>>  extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
>>  extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
>>
>> +int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
> 
> rzg2l_cpg_sd_clk_mux_notifier()?

ok

> 
>> +
>>  #endif
> 
> The rest LGTM.
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
