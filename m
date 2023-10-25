Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095837D7053
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjJYOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjJYOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:54:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C8A189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:54:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso9094809a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698245691; x=1698850491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9kyPYaH34uXr/cQUy0a+/J35UlgWvNyNVDDPOzDD20=;
        b=vwfiQfIlGu/vdxgpQtk/HEex7/wvVE5n326PyaNMbT3qg7hLXguSZVVskLTGlCLWeM
         IjPJtPK2+wBdPgxtxdJYuo9dU4F19XOxcxx3K1dwyY4Tw7j+tLsYkijnpOcEThgTuFhE
         HOtq5c4nJoUgkWd//bZ/0U3lmQzOOef3ELSVdn88cXnkjfY5duPg1TWRvJ3s0KPtNN1c
         Yn/uRAVeGONSKHnSY/HE7DnLSi3ukq7g89XhjctkZ7roUzCsoC+ZVpOql1v+/AkVT2B5
         ceO5WWRzyYggY97+ctc0jdx0yyZGzupwb75JvCQmYbcSWVOfbYWDLJwhgOoNjzJ+kT35
         MzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698245691; x=1698850491;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9kyPYaH34uXr/cQUy0a+/J35UlgWvNyNVDDPOzDD20=;
        b=U05NgJEWXYyCpEnVkanpluAydk0J9ElAg3VW1wU0m7ngcZnBPsw8nWiGe79Q2wtf1n
         JE0JkDASEWJquOTjtZD2/i5ofPFQpB/FMLTM/VYsLrW3BGyeWEyyC29hWpsthYbzJoNU
         RYVaTuzH1YCxttIPXmZlOcx3TCkwUpsiuHGF/Y66TF06TeN79M/mXjQs5vpqW4xzj7YQ
         AGa88v3K7B4GcMSfofh2TjfdYXZrw7IJQZmFhmiAmw8XnGNE3le60du/9sKz4MLGXjBG
         wv1r2PPLgdBdUr25ZFcN7NIDZEucan9FtJYexb+BKDbEZu+Xe2c0/mHnDm+ja4J8lQ+m
         wm9A==
X-Gm-Message-State: AOJu0YxdQYKXjSYUnC81/RvaZ3QcpuomihxZukidu64UR487i8R/r+KX
        cixz5G4/KLRWfvqwHDEywRQvmQ==
X-Google-Smtp-Source: AGHT+IGj0fFxYNY36al9jSzjkXSJLC5nVtaMMT/PBL+VhovZqKrqS244UWVpW3AW6QcPC7cKDl3T6A==
X-Received: by 2002:a05:6402:40ce:b0:53e:94f8:85aa with SMTP id z14-20020a05640240ce00b0053e94f885aamr13877701edb.0.1698245690869;
        Wed, 25 Oct 2023 07:54:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id gy5-20020a0564025bc500b0053d9cb67248sm9448133edb.18.2023.10.25.07.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:54:49 -0700 (PDT)
Message-ID: <d33bf9c9-b6a6-42aa-acc7-675b2c7aa1f9@linaro.org>
Date:   Wed, 25 Oct 2023 16:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-makomo
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>, Conor Dooley <conor@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231024000724.57714-1-hsinyi@chromium.org>
 <20231024000724.57714-4-hsinyi@chromium.org>
 <20231024-bobbed-although-06f341259ebb@spud>
 <CAJMQK-hvhjNGFUfgqb7pm=pAYjJ0wZAhkPGXxDCUJ5cnUDh2gw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJMQK-hvhjNGFUfgqb7pm=pAYjJ0wZAhkPGXxDCUJ5cnUDh2gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2023 20:22, Hsin-Yi Wang wrote:
> On Tue, Oct 24, 2023 at 8:17 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Mon, Oct 23, 2023 at 05:02:26PM -0700, Hsin-Yi Wang wrote:
>>> Add makomo sku0 and sku1 which uses different audio codec.
>>>
>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>> ---
>>>  Documentation/devicetree/bindings/arm/mediatek.yaml | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> index fe8c488a3207..b131e0bdbf01 100644
>>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> @@ -250,6 +250,18 @@ properties:
>>>                - google,kodama-sku32
>>>            - const: google,kodama
>>>            - const: mediatek,mt8183
>>> +      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK 2)
>>> +        items:
>>> +          - const: google,makomo-rev4-sku0
>>> +          - const: google,makomo-rev5-sku0
>>
>> With these bindings, how does one describe a makomo-rev5-sku0?
>> What you have here is only suitable for describing the makomo-rev4-sku0.
>>
> makomo-rev5-sku0 and makomo-rev4-sku0 uses the same dts:
> 
> compatible = "google,makomo-rev4-sku0", "google,makomo-rev5-sku0",
>                       "google,makomo", "mediatek,mt8183";
> 
> In this case, can bindings be listed like that?

If they use the same DTS, then I would expect rev5 (as newer model, more
specific) followed by rev4 (older).

Best regards,
Krzysztof

