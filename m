Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17DD7B5FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjJCD5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJCD5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:57:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CF5C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 20:57:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so662884a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 20:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696305465; x=1696910265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vcj38yNtA7k/3hr4qGHtjbsEU4GTIRzNMyspAkCjhCA=;
        b=p3zo2HGEr+2OvrXEoU/Zye/b9aSgFuQ/6Cn7dI+WhkfiRd4RZIr6GEHOBeC2BSX8tJ
         uqp1SHn/SvcqCMew2MjGS+ooNVKU9t0g2/tR/kjh2uTBXWKX5c9kuhjNxkCoM5fiH/dm
         +i9aD/Yc3nv9V05xzEh+j3rMzWC8sHi52iIoWvEC0+kFo2H+PHr8znb9Z2q1CPzrXFvu
         KF4yBL/6uBN3w5zJM4YKXyeLB+qyDxbIs6nDjrXMqT9WJzT7d7/J/hDtdrWmftrVpq3z
         UIKnj5ci5Dfk0R0ch9bS7xcZDJLMEjvfLGYlxLJZKh59FgBr0qW/sm0j96/LBJOSTnmn
         /RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696305465; x=1696910265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcj38yNtA7k/3hr4qGHtjbsEU4GTIRzNMyspAkCjhCA=;
        b=B9N0oZul3GTnaz7MvQvzCoPFsDsM3UcIP7b8uMdWTJYFpEOsUkco2MPaLAmm73/pG9
         j77DT9Jj6kzs0WPUDsvIztihFi2hZshLOfGzhnBgWgH3KVmaYJOYLQ75Psv6i4FeIdfr
         OF4x88yBoTFdlWAFfw3osD5B24gtfO06iIRVyDg+WZr5XsT7QPD+Q1uMZqVvbsvqC3TK
         o5kOHIrdeNaFBBWijGDaT6wxDj0lgzBct7QsKXpraXYH1xkZVGBDS4nsJRGlYiUCWuWa
         xdtQoxEB5mHptjfSnKK+dQN1mIJDgARzMovchurl+TPUWSCS+OZKvq/z6m2J563KXcid
         FFrw==
X-Gm-Message-State: AOJu0Ywjzf2BhELYWQfnKdQyym9OrnjXBgyyuJ6H/res+Cm4aIj9PDgc
        A5rf/mBttvDKxvsvjIzMfxDwUw==
X-Google-Smtp-Source: AGHT+IEifMyPHsZPopKOT2VslyFdEw8uEukP8H3uRKxwv6r121ZBGIoVbrBHyNp4qTycGECLs+Yl3A==
X-Received: by 2002:a50:fa85:0:b0:534:63e:d0b7 with SMTP id w5-20020a50fa85000000b00534063ed0b7mr11688359edr.23.1696305465098;
        Mon, 02 Oct 2023 20:57:45 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id q17-20020aa7da91000000b00537f44827a8sm160947eds.64.2023.10.02.20.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 20:57:44 -0700 (PDT)
Message-ID: <ae156c07-955a-1257-2b1a-19ee938c1bcd@tuxon.dev>
Date:   Tue, 3 Oct 2023 06:57:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 19/28] dt-bindings: pinctrl: renesas: set
 additionalProperties: false
To:     Rob Herring <robh@kernel.org>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
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
 <20230929053915.1530607-20-claudiu.beznea@bp.renesas.com>
 <20231002145052.GA1690001-robh@kernel.org>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231002145052.GA1690001-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.10.2023 17:50, Rob Herring wrote:
> On Fri, Sep 29, 2023 at 08:39:06AM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Set additionalProperties: false.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
> 
> I did?

It is what I've understood from this:

https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230912045157.177966-30-claudiu.beznea.uj@bp.renesas.com/

> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - this patch is new in v2 and added as suggested by Rob
>>
>>  .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml     | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
>> index 4782f96feb7e..eb726770f571 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
>> @@ -106,8 +106,7 @@ additionalProperties:
>>          line-name: true
>>  
>>      - type: object
>> -      additionalProperties:
>> -        $ref: "#/additionalProperties/anyOf/0"
>> +      additionalProperties: false
> 
> With no properties defined, this only allows an empty node which is 
> probably not what you want. It's the other anyOf entry that needed it, 
> but I already sent a fix which Linus applied.

Thanks!

> 
> Rob
