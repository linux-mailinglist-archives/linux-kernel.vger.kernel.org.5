Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B35A7A15A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjIOFqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjIOFqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:46:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77287270A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:46:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so3901128a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694756798; x=1695361598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBFecL9CWJp1g51f9tBvXZNbnBULvxEsI9jL0YhvbgI=;
        b=VFpOepHyhERpGBZraBCMkTsmwtJXinh95opofI3a4yui2AxBH/On8d1BeVKLiT4hrK
         BBNicKwuLfjRmWo7KFbCFb5ruwxAzFZTlXPwE3zTT65SzRapaBVAzOVEdUYEVZq2u1ht
         zd+7bgo5EPY9J69KftU/scB9i6PSLhQq3STqdFl1Tv8gZ9GHLzSV/xt+cEw3bbVNOMce
         zHCJ6pDN8BtgJrbGkSmzgf/MKHZSF0UZHHC7wBCEUB4kidM+KYlGgGbhbw15hAaBbQXE
         Inh2942nc5OaLQGQh29gu5HwzpewqjIcWBcgj28oQzAkwcm6eLac8o8lYIw47PaMyWjU
         zQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756798; x=1695361598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBFecL9CWJp1g51f9tBvXZNbnBULvxEsI9jL0YhvbgI=;
        b=jVB+9eXQsaXcRh6OsQPD91YCP9Y7HXBk2xqEp1uMpKtcsUgf4QBEJ91jx4o1naAtrN
         wvskTrwGsoMSxpC3ZSPvqb6qilq/afD7Df4tAcriLxxUChO7arpHzeDg2iMHhPaE98/3
         YOKNqYghaGHyTC8wbVWHEC5scZBzzJYSI6/5AY0yiU2EczkdD/8AXla6E3yL5XaaCRsU
         Fwt9Djh0W2e30CWoLiMVhird4eMTdZD21gjcTNu2scR7HGMp7Nxj/nW0+OgiW2eRt+8z
         fI9QBE0Ci2PMggc3dIwhFDgsL7d8RwMdvR/OokyNDYMnQvk/GArWO0vpXUzUu0/lRYYi
         58ow==
X-Gm-Message-State: AOJu0Yxm4q+iSXZAr5PbhoR9gx1/bsmus0NruuaHKTguPKGsivPKsHfh
        68Fhia6tHopXVn9V/rkR1Z4o1Q==
X-Google-Smtp-Source: AGHT+IEODL+RpbrigRr6ILUXdOUTmvcIqPQeQU6mBp3NXEa+wUaHYHJhFKWyE/sQXCzyI5YAWAIO1Q==
X-Received: by 2002:a05:6402:3485:b0:522:c226:34ea with SMTP id v5-20020a056402348500b00522c22634eamr4759852edc.7.1694756797898;
        Thu, 14 Sep 2023 22:46:37 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d997000000b0052a3edff5c3sm1742625eds.87.2023.09.14.22.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 22:46:37 -0700 (PDT)
Message-ID: <305ec65a-bc73-62fc-84a4-4f84ccd1ff1a@tuxon.dev>
Date:   Fri, 15 Sep 2023 08:46:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/37] clk: renesas: rzg2l: lock around writes to mux
 register
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
 <20230912045157.177966-8-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXo14JwdJE+b1zdnJ7Re5cn8ugzxueD1a=-n=PUQz7VKw@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXo14JwdJE+b1zdnJ7Re5cn8ugzxueD1a=-n=PUQz7VKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.09.2023 15:13, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> SD MUX output (SD0) is further divided by 4 in G2{L, UL}. The divided
>> clock is SD0_DIV4. SD0_DIV4 is registered with CLK_SET_RATE_PARENT which
>> means a rate request for it is propagated to the MUX and could reach
>> rzg2l_cpg_sd_clk_mux_set_parent() concurrently with the users of SD0.
>> Add proper locking to avoid concurrent access on SD MUX set rate
>> registers.
>>
>> Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>> @@ -189,6 +189,7 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>>         u32 shift = GET_SHIFT(hwdata->conf);
>>         const u32 clk_src_266 = 2;
>>         u32 msk, val, bitmask;
>> +       unsigned long flags;
>>         int ret;
>>
>>         /*
>> @@ -203,25 +204,27 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>>          * the index to value mapping is done by adding 1 to the index.
>>          */
>>         bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
>> +       spin_lock_irqsave(&priv->rmw_lock, flags);
>>         if (index != clk_src_266) {
>>                 writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
>>
>>                 msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
>>
>> -               ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
>> -                                        !(val & msk), 100,
>> -                                        CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
>> -               if (ret) {
>> -                       dev_err(priv->dev, "failed to switch clk source\n");
>> -                       return ret;
>> -               }
>> +               ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
>> +                                               !(val & msk), 100,
> 
> According to the read_poll_timeout_atomic() documentation,
> delay_us should be less than ~10us.

I'll update it, thanks for pointing it.

> 
>> +                                               CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
> 
> CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US = 20 ms, which is a long timeout
> for an atomic poll.

I'll have to find the the rationale behind the original timeout. It may be
random, experimental or hardware related.

> 
>> +               if (ret)
>> +                       goto unlock;
>>         }
>>
>>         writel(bitmask | ((index + 1) << shift), priv->base + off);
>>
>> -       ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
>> -                                !(val & msk), 100,
>> -                                CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
>> +       ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
>> +                                       !(val & msk), 100,
>> +                                       CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
> 
> Likewise.
> 
>> +unlock:
>> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
>> +
>>         if (ret)
>>                 dev_err(priv->dev, "failed to switch clk source\n");
> 
> The rest LGTM.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
