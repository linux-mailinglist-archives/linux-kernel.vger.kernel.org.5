Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1775758C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGRHmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGRHl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:41:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1110EF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:41:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-993d1f899d7so761388566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689666104; x=1692258104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QL+lGx6841G8gfl/bjowZRwIdw7qo/vrHQjFMqcY+e0=;
        b=VUZ1dCMlD+XiY9Vc/ofh3RfnE54QF9J84WOyWPkTQMOJQW19u5GAfwKfLwVo8hoJLq
         CwRmxnCQPrukLePatF69KQUbRm47xZWqoDdiETHE09Sj8FtZHreSYbfIGg2Kr7KjLNjL
         BG3MNw1RX8iEuVLzKtnpOFyfBvAGQ5g8REK/OdQ8gjirCjvueX73HUCBwWMbfpfGZcsx
         3bRuKHgg/BnaDDsQljM9822YzXN398eOBMlVdeT4l34mIQcDJhLRyTIYZO6AmFzpcLm0
         WedJyJMDohrHAGqvL22focw21ESkD0J3iJJz7Uge55VuPiowim1+Q/SYi1xTB8ZQQNoz
         rlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666104; x=1692258104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QL+lGx6841G8gfl/bjowZRwIdw7qo/vrHQjFMqcY+e0=;
        b=UkDtsG3PVen2n1qaw7pkVL3FF58uXHuGnmbV7CFUPZj6gMur/qEeMZ0JRkDeUny8Xo
         djRF6JvzrT2Z8pEI/hQpUGt3gEKNv0vxIiTq3+HXdOiL5UUeMOWKQ8UHBugDY8prHRXT
         +8OccpWVcr8Rg+p+tZASeAs1eIv46YIWBt9A8+DZsdtAB9AV89x6G1Rptd0qlr5Vxldn
         NbbE6L6u2ctu0tHLknvbMu7+DWhmuPCUC0DqJ29cpiU4ORjZekHpdeSFQi6DlW7mRcct
         ugwymxrgv8cgIqq23bPMyW3145zllOPln9hEc3Ikoe4sZPN7QpT72nGpavhcrwLDnHhi
         pdxg==
X-Gm-Message-State: ABy/qLY9t4KlEgzCxSOjs7q8APxGNBixN5dzHFh3dK9Cs/cvKzseUf5d
        cNR8/e9daDBVzESurJ0LVoN/7A==
X-Google-Smtp-Source: APBJJlFLSWTia11KHMNO05afcHQNkDKS0eaGs6mD+/2wIgRR2oI6rJIHTPuEIuK9JTlDDMYic6RRJQ==
X-Received: by 2002:a17:906:7a5d:b0:993:f996:52d3 with SMTP id i29-20020a1709067a5d00b00993f99652d3mr13643450ejo.25.1689666103744;
        Tue, 18 Jul 2023 00:41:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709064ed200b0099364d9f0e2sm671308ejv.98.2023.07.18.00.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:41:43 -0700 (PDT)
Message-ID: <42e4d678-d114-332d-f1c5-61575cbc0e3b@linaro.org>
Date:   Tue, 18 Jul 2023 09:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230717120300.21388-1-jason-ch.chen@mediatek.com>
 <20230717120300.21388-5-jason-ch.chen@mediatek.com>
 <43ecf0b0-4b55-ab11-3b80-b9243b971c2c@linaro.org>
 <f0055b0f42388ff0da395bd9de7b86ce40bf77c1.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f0055b0f42388ff0da395bd9de7b86ce40bf77c1.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 08:36, Jason-ch Chen (陳建豪) wrote:
> Hi Krzysztof,
> 
> On Mon, 2023-07-17 at 21:58 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 17/07/2023 14:03, Jason-ch Chen wrote:
>>> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
>>>
>>> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6
>> CA55
>>> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
>>>
>>> We add basic chip support for MediaTek MT8188 on evaluation board.
>>>
>>> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
>>> Reviewed-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>>>  arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 401 +++++++++
>>>  arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 951
>> ++++++++++++++++++++
>>>  3 files changed, 1353 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile
>> b/arch/arm64/boot/dts/mediatek/Makefile
>>> index c99c3372a4b5..9bd2324259a3 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-
>> krane-sku0.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>> b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>>> new file mode 100644
>>> index 000000000000..d8906172390e
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>>> @@ -0,0 +1,401 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2023 MediaTek Inc.
>>> + */
>>> +/dts-v1/;
>>> +#include "mt8188.dtsi"
>>> +#include "mt6359.dtsi"
>>> +
>>> +/ {
>>> +model = "MediaTek MT8188 evaluation board";
>>> +compatible = "mediatek,mt8188-evb", "mediatek,mt8188";
>>> +
>>> +aliases {
>>> +serial0 = &uart0;
>>> +i2c0 = &i2c0;
>>> +i2c1 = &i2c1;
>>> +i2c2 = &i2c2;
>>> +i2c3 = &i2c3;
>>> +i2c4 = &i2c4;
>>> +i2c5 = &i2c5;
>>> +i2c6 = &i2c6;
>>> +mmc0 = &mmc0;
>>> +};
>>> +
>>> +chosen: chosen {
>>> +stdout-path = "serial0:115200n8";
>>> +kaslr-seed = <0 0>;
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>>
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>>
> 
> Thank you for your review.
> I actually ran dtbs_check, but it didn't display any problems here. I
> will remove it in the next version.

Ah, right, it is coming from dtschema, so the property could stay. I
don't understand though why adding 0 as seed. Shouldn't your firmware
set it?

Best regards,
Krzysztof

