Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347F17F6536
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345690AbjKWRTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjKWRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:19:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CC10F8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:24 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548d4fc9579so2107582a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700759963; x=1701364763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x83P9eLZHnvhnKYPL9PHMDu1keqvrFTzzBoRrDNtJt8=;
        b=WVqwfhW7cUhwUQlRqZLDb/rM4TWHJspsFLJZM+J8QD6RfXJTG1yIio+2qDukVGage0
         M6ILRF1J9PzRP4sTH/S4p0qGC9qyARrRQvC8p+7Su6+4SL3tjx5xyKXExkcLjDPVodsW
         s7WkNAUpiA+QlURm6f3RlLf2bLDiTi6sZtkghoSEd+yGW6dwS1W2cH0/FYT1Nrxh5IMZ
         hHpsTAa6167t7g5rddD4BNjn6IC1aL4sr+hGVdlKmS3/NEKR9tBLIM7BDq4gvKc7v66P
         iIBHMW0ygOP1j9x2z6nkx6jdtR71doyJ8/q6k0GmS92saVrJXUvXuR4+mnmSjGhG1UqE
         ZH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759963; x=1701364763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x83P9eLZHnvhnKYPL9PHMDu1keqvrFTzzBoRrDNtJt8=;
        b=Vv3vU5dhJgnmcDlfXZvVqD5ZCQksB6qOQT2DC08PYcQKvoJ3gYa+1Jv+3fsUlk864v
         cjayur8KOk12LVMiV9dvDSPH1olgzEIzw6r2AqlQxWlYKubdgGIBcQXU+fHoN1BOue7w
         HQrVqLmisTyyTn4Gb9Rmp1tPvglBlrnIxo5rB9x3RQBiQWaSwt/W50xG/bmI+aE5MNe2
         B1Ti7MnUJccs9DhDTmVuSl0DMe2ZPx4dmDBMwQmtyo9ejLxCVif6i4bpEFELnaV0bPwr
         L8X/9DN02h8gIouhNWbvhBKBUZLK5SS4RtTWBHZ3jJ6xkZ4+i+PCAZBpg5X7DscTPjdZ
         NgCQ==
X-Gm-Message-State: AOJu0YyILRuSDtIFO3WxK3J9W5h83nLqmhCqlPj3PvmBXE6kI5Nmk4pk
        BYHyFi9zgivNWfne7QzFliVTPw==
X-Google-Smtp-Source: AGHT+IE1OC0oC6PR+P9u8JHzfQFAvqIfUkwM1w9mU3rz2WBz0ondFofMAdcnjef4Dp7B3G/RSzdCYw==
X-Received: by 2002:a05:6402:1a36:b0:548:dfbb:258c with SMTP id be22-20020a0564021a3600b00548dfbb258cmr2974434edb.11.1700759962758;
        Thu, 23 Nov 2023 09:19:22 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.3])
        by smtp.gmail.com with ESMTPSA id q1-20020a056402040100b00536ad96f867sm854415edv.11.2023.11.23.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 09:19:22 -0800 (PST)
Message-ID: <ce7ad295-bcf9-45d8-a7e6-43b6a416aba1@tuxon.dev>
Date:   Thu, 23 Nov 2023 19:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] clk: renesas: rzg2l-cpg: Check reset monitor
 registers
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, geert+renesas@glider.be,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
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
 <20231120070024.4079344-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXTO+cteN7fW+n3=Vzpa5Nk7oxj+sF2vBMLf2gwS=aNGw@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXTO+cteN7fW+n3=Vzpa5Nk7oxj+sF2vBMLf2gwS=aNGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 17:53, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hardware manual of both RZ/G2L and RZ/G3S specifies that reset monitor
>> registers need to be interrogated when the reset signals are toggled
>> (chapters "Procedures for Supplying and Stopping Reset Signals" and
>> "Procedure for Activating Modules"). Without this there is a chance that
>> different modules (e.g. Ethernet) to not be ready after reset signal is
>> toggled leading to failures (on probe or resume from deep sleep states).
>>
>> Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> In case you apply this patch and patch 1/13 as is, please add a Depend-on
>> tag on this patch to point to patch 1/13 for proper backporting.
> 
> There is no such Depend-on tag? Anyway, this patch won't apply if 1/13

typo again... it should have been "Depends-on" which is true, it is not
documented anywhere, but I saw it is used in some commits. Maybe I should
stop using it...

> is not backported...
> 
>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>> @@ -1416,12 +1416,23 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
>>         struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
>>         const struct rzg2l_cpg_info *info = priv->info;
>>         unsigned int reg = info->resets[id].off;
>> -       u32 value = BIT(info->resets[id].bit) << 16;
>> +       u32 dis = BIT(info->resets[id].bit);
>> +       u32 value = dis << 16;
>> +       int ret = 0;
>>
>>         dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
>>
>>         writel(value, priv->base + CLK_RST_R(reg));
>> -       return 0;
>> +
>> +       if (info->has_clk_mon_regs) {
>> +               ret = readl_poll_timeout_atomic(priv->base + CLK_MRST_R(reg), value,
>> +                                               value & dis, 10, 200);
>> +       } else {
>> +               /* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
>> +               udelay(35);
>> +       }
> 
> I think this should also take into account CPG_RST_MON on RZ/V2M,
> cfr. rzg2l_cpg_status().

Hm... ok, I'll have a look though it will be a bit difficult to test it ATM.

> 
>> +
>> +       return ret;
>>  }
>>
>>  static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
>> @@ -1432,12 +1443,22 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
>>         unsigned int reg = info->resets[id].off;
>>         u32 dis = BIT(info->resets[id].bit);
>>         u32 value = (dis << 16) | dis;
>> +       int ret = 0;
>>
>>         dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
>>                 CLK_RST_R(reg));
>>
>>         writel(value, priv->base + CLK_RST_R(reg));
>> -       return 0;
>> +
>> +       if (info->has_clk_mon_regs) {
>> +               ret = readl_poll_timeout_atomic(priv->base + CLK_MRST_R(reg), value,
>> +                                               !(value & dis), 10, 200);
>> +       } else {
>> +               /* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
>> +               udelay(35);
>> +       }
> 
> Likewise.
> 
>> +
>> +       return ret;
>>  }
>>
>>  static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
> 
> The rest LGTM.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
