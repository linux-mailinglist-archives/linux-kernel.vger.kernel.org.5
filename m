Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E987A15C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjIOFv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjIOFvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:51:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE421FC8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:51:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso2016075a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694757105; x=1695361905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAviJiHnDWn37yrY/+TDS6dv356bJe/3IP+axIRqyaY=;
        b=PrUxW2H8unYtNgDLDeqdFYWFgVpt/4cUd3x7liLJvrutVZVewvdFn8vZQkUsh32tSz
         ZXBIvEDbXswEYTir+wlToCQYaSglOSki/p1hSjqIxrlZ98tevtYKwMSOtX5vCCy7GYZY
         GLjmYY+8I8mOpLIzkBOdpa2o03l82+nU7GBqo0X8pgYRfIOEv20P4M1UAVGCBRjfz/JF
         c10y2w4bDG4IeIpbiqJE7DMu5lXfMzZ1NDVZ7VvZbxENFDgFV0fYMGml8jO4ekkKowBH
         7yXGxICf/yzY1VtbMJOl5ODVZPEH3srPhVkglre8iNFPIkdvwL37gJpAFpjL8ODJBd5m
         e5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694757105; x=1695361905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAviJiHnDWn37yrY/+TDS6dv356bJe/3IP+axIRqyaY=;
        b=I3/YizgUMcWbFL+h8ucez9E3Dq0wOFBY0x4cwTRBaFSBfCYPMHE1fyf/aDU7s4aE5p
         NQsWnRnlFLfJ5vHJX5hE20guu+xRgsk1BEwUJooa6I42IXgY+uBnWIDWWUHl6OXHVjFs
         5dmOtNlyHOWhH5vKGqOC8QMN5lI5ouxllawzaG9Ix33x/oOJA9hsRKStshtCTqcTcacy
         rpr+JTVfBKmgn9Htj8XXpBjBe+aUJq+XCoKo1k2KMHDg/CRjptN/jK5i8mK/ptvOivow
         ps+jvjCkJn6mo92SEPgeslKbZEZ0UZEv3vfp5/edrWW97M3RXtSmgf5WupptbOIxDlkW
         zYhw==
X-Gm-Message-State: AOJu0YxvO55jVTslewvVPw8KYQzTfAT/6rE21OBFdK8p6lhmrcTukZer
        HneHBzF4O9OT3ct5KyscNNnKRw==
X-Google-Smtp-Source: AGHT+IF8/RuLa2dvtV/6+atyydlIiT0muAbHJl0SRDscKsAC1bMSvB/A1IkkRbsxTp4mEQITtSGTeA==
X-Received: by 2002:a05:6402:164b:b0:523:2e63:b9b with SMTP id s11-20020a056402164b00b005232e630b9bmr571283edx.24.1694757104741;
        Thu, 14 Sep 2023 22:51:44 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402065800b005231e3d89efsm1747955edx.31.2023.09.14.22.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 22:51:44 -0700 (PDT)
Message-ID: <f0aa7983-0300-ce21-8726-41d033f6afbe@tuxon.dev>
Date:   Fri, 15 Sep 2023 08:51:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 12/37] clk: renesas: rzg2l: reduce the critical area
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
 <20230912045157.177966-13-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVLx1d-6=5xx_GLAb7LxxRR9FwhAU56fxNc3b=9wj286g@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVLx1d-6=5xx_GLAb7LxxRR9FwhAU56fxNc3b=9wj286g@mail.gmail.com>
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



On 14.09.2023 16:12, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> spinlock in rzg2l_mod_clock_endisable() is intended to protect the accesses
>> to hardware register. There is no need to protect the instructions that set
>> temporary variable which will be then written to register. Thus limit the
>> spinlock only to the hardware register access.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>> @@ -912,13 +912,13 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
>>
>>         dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
>>                 enable ? "ON" : "OFF");
>> -       spin_lock_irqsave(&priv->rmw_lock, flags);
>>
>>         value = bitmask << 16;
>>         if (enable)
>>                 value |= bitmask;
>> -       writel(value, priv->base + CLK_ON_R(reg));
>>
>> +       spin_lock_irqsave(&priv->rmw_lock, flags);
>> +       writel(value, priv->base + CLK_ON_R(reg));
>>         spin_unlock_irqrestore(&priv->rmw_lock, flags);
> 
> After this, it becomes obvious there is nothing to protect at all,
> so the locking can just be removed from this function?

I tend to be paranoid when writing to hardware resources thus I kept it.
Would you prefer to remove it at all?

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
