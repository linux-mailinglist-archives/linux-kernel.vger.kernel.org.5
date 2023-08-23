Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A45785011
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjHWFsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHWFsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:48:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D25E57
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:48:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcfe28909so657909466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692769694; x=1693374494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46RStdP/Qt/K8w0DMGkBqPuTHcz/tk87RawMdnkHi6E=;
        b=VgnbV634oF+2LRhvV8FXPyOie3JKBlaALcCr128w+ZlL8ZIfQ8r6ez41La0WHMQEEv
         I39TW78SBxefwEkutIgzcPgSGg5ALNbnOowDrIIhr96Wlnpj7De27UijIe/vzPkX1J5V
         j23uk0VgJmhNHtcU5sMktyx6u5ntsWY4Rf6EpZnXy/yxnUFXUX4etFX2vBg3Mim0ULhI
         joaWvlpusrpccpDEXDUk0tHBf16bPiuRayxl7Wol4EBYguW4mJKhQsilGbrNu4zEa3it
         02p/sVtPyoFJaRgwb8MKv7xb1iapVPfRIa6BL3k2MTWidKlmYcaIeCc16UJiOo8XbKUc
         g1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692769694; x=1693374494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46RStdP/Qt/K8w0DMGkBqPuTHcz/tk87RawMdnkHi6E=;
        b=TTiyvE+sxNT7mS6WYEMA4aUSc4aqBjPt4LVbIwOAcfNZXrojpKHdhi8+4oMifGCneb
         GXjZt9YVZuD9/AMCntBQ4s1/ayCNV7j/dN47poiKhjA0E1XI+woz8deB500/ui/+PsX6
         4vmjTeNoxP9ANrlk0hROEF5nj5nFeJHHlTVFlyEmCRn784NXDiqMOfnW7eMRtBD+U/fE
         /Ur5yU4k5sARZeqLmHwI9mgpeYjcc17abyReOR+CbfVOOBLRc7ZQVfhvnkPf2D6XOfn+
         jdtaMvnYKAEXqRJZCo2sP6chrvkS5zYvPZ60UPwNTHkM92izpZ6ttClLuji+PunFONhF
         nc0w==
X-Gm-Message-State: AOJu0Yx4Sa1VdouTJVa44KtTfdLld6gkmXilYJW9wiWcbuNcraXqaT/6
        iQO0WewxC6Wk7IJIImHHN+5zoLRcQXa0CLiXs9g=
X-Google-Smtp-Source: AGHT+IFPbUlDSF0J1kdpdEmWO0Ky+QwxfXgQYdaLU5e/JsyKQcL8x8+JagL85rqm6r5cOkvvGNImBw==
X-Received: by 2002:a17:906:8477:b0:991:c566:979 with SMTP id hx23-20020a170906847700b00991c5660979mr9479926ejc.36.1692769694610;
        Tue, 22 Aug 2023 22:48:14 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id ke9-20020a17090798e900b00988e953a586sm9289732ejc.61.2023.08.22.22.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 22:48:14 -0700 (PDT)
Message-ID: <e1c69599-a894-4cc8-123b-f4654b08412d@linaro.org>
Date:   Wed, 23 Aug 2023 07:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 03/11] regulator: dt-bindings: mt6358: Convert to DT
 schema
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230822084520.564937-1-wenst@chromium.org>
 <20230822084520.564937-4-wenst@chromium.org>
 <5ad5ff92-1367-ba96-b126-da80511a2769@linaro.org>
 <CAGXv+5Gc+R-hUJi5gm8an+dkq3JMD2JGwP4kDakKaHbAX2P0gQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGXv+5Gc+R-hUJi5gm8an+dkq3JMD2JGwP4kDakKaHbAX2P0gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 05:54, Chen-Yu Tsai wrote:
>>> +
>>> +    regulator {
>>> +        compatible = "mediatek,mt6358-regulator";
>>> +
>>> +        buck_vgpu {
>>> +            regulator-name = "vgpu";
>>> +            regulator-min-microvolt = <625000>;
>>> +            regulator-max-microvolt = <900000>;
>>> +            regulator-ramp-delay = <6250>;
>>> +            regulator-enable-ramp-delay = <200>;
>>> +            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
>>
>> mt6397?
>>
>> Both cases look a bit confusing.
> 
> There's only two regulator binding header files, mt6397 and mt6360.
> They seem to correspond to the two classes of PMICs that MediaTek has.
> I believe the two header files and thus the macros are meant to be
> shared?

Defines have specific model name, so they do not look like meant to be
shared. If all the values of the binding match, they can be shared, but
then this should be mentioned in the binding plus it should be used in
the driver. I don't see your driver patches add include of this header.

> 
> MT6397 and co refer to their AP PMICs, i.e. PMICs that are companion
> chips to the SoC and provide most of the power rails a system needs,
> along with things like RTC, audio codecs, etc.. The MT6358 and MT6366
> belong to this class.
> 
> MT6360 and possibly others refer to their charger PMICs, which integrate
> a battery charger, USB type-C PD stuff, LED drivers, and a handful of
> regulators.


Best regards,
Krzysztof

