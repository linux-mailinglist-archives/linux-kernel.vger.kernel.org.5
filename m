Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE237A4914
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbjIRMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbjIRMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:00:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040DCD0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:59:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99de884ad25so588642666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695038366; x=1695643166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mx+1LEKjG08mHXdWiW0HFl/U3LRaOvUzyjCNt5ITLZc=;
        b=Fw4HkzC7pcvppLJYx2wITGv2sEElnkg7QPGY7lPh7ux1OM1cE15GesUPD7c2aSD7gd
         gq8V1nqYbytebM71PrH3/4Szgg8SpC/kOjXkxNN8twzIwSPvUwjPXNmQiYnvuDXEoo0w
         PveSKvaKppysaMOdITgl9uIfGINmxR6DeI0XZCp0wyLwU1i5H6MGcRjKDK+U5FSF3/Kf
         upMkjHEnlhjg7qOnu8PH5WGGjwRi2WTZ4xp6C25gS/f9X7Eg5LsVNJVAsMdXmzRxewVM
         KbEoeB9B5nilqxDXOGyk96GtBPx9SVgIjrwBc1/5XmvExhasUQXRIlI/TraaCXHatyQN
         jeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695038366; x=1695643166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx+1LEKjG08mHXdWiW0HFl/U3LRaOvUzyjCNt5ITLZc=;
        b=wvV89LBlaw9DdmL6Zwmd579GqeEwRqRPejUjVkfnOQJwivYjA0eLntGhaqG+9f/sJJ
         W94FjZcfUKXnuzKwpxcGfFZQUcWiq17iiHANu9lZfwxIM6CyJNT8/m2l2BOyk5U5EO/Y
         VzDNSZTKjVJbhFgOx23p/jkjNtPSO0pa+cI3Ej1qW9BCuRtbhKIEdkXQYT1/leDcnKy1
         5PU+q8guLJ/qQx6fh3sleH5g36OUwbFokwr7e86ph+UFFwdio+afLJC3Ov7cf/F5Rg9Z
         NrKHFRlOPKO1W5QmaIbb1d90rec6lVrYJigiDJgesrywJ37mDvgEIEChVJuYqPH5Ltd3
         gptw==
X-Gm-Message-State: AOJu0YysUsMWdEZ/tBUQqpmTodboJmUzsxY2G5bSqeHno9cT8JjfLwIi
        LNLZVFOaXOI3utLq3MSuDJA/Cg==
X-Google-Smtp-Source: AGHT+IEQU5aP9n0ZpbF9FIWm05VurFH/Lgko0yhluHa5UJmuOfDQoNjoIOALZWR4TY4wUZ0dcYYJAQ==
X-Received: by 2002:a17:906:5188:b0:9a1:db97:62a1 with SMTP id y8-20020a170906518800b009a1db9762a1mr7333228ejk.46.1695038366283;
        Mon, 18 Sep 2023 04:59:26 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906410900b0099cc3c7ace2sm6466812ejk.140.2023.09.18.04.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:59:25 -0700 (PDT)
Message-ID: <fad9eb3c-49f9-5ece-b51a-aaff4d8888ad@linaro.org>
Date:   Mon, 18 Sep 2023 13:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] dt-bindings: hwinfo: Add mtk-socinfo driver
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        William-tw Lin <william-tw.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230915152607.18116-1-william-tw.lin@mediatek.com>
 <20230915152607.18116-4-william-tw.lin@mediatek.com>
 <3e7bc476-ffc7-fb07-8e64-246427da736c@linaro.org>
 <9acc8d99-e3db-3df8-4051-21d95450b28d@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9acc8d99-e3db-3df8-4051-21d95450b28d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 10:47, AngeloGioacchino Del Regno wrote:
> Il 17/09/23 10:26, Krzysztof Kozlowski ha scritto:
>> On 15/09/2023 17:26, William-tw Lin wrote:
>>> dt-binding documentation for mtk-socinfo driver.
>>
>> Here and in subject, drop driver and instead descrbe hardware.
>>
>>> mtk-socinfo driver provides SoC-related information.
>>> Such information includes manufacturer information, SoC name,
>>> SoC segment name, and SoC marketing name.
>>>
>>> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
>>> ---
>>>   .../bindings/hwinfo/mtk-socinfo.yaml          | 48 +++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
>>> new file mode 100644
>>> index 000000000000..74f03f1dc404
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
>>
>> Nothing improved.
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
>>
>> Thank you.
>>
>>> @@ -0,0 +1,48 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwinfo/mtk-socinfo.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek SoC ChipID
>>> +
>>> +maintainers:
>>> +  - William Lin <william-tw.lin@mediatek.com>
>>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>>> +  - Kevin Hilman <khilman@kernel.org>
>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> +
>>> +description:
>>> +  MediaTek SoCs store various product information in eFuses, including
>>> +  Chip ID and Revision fields, usable to identify the manufacturer,
>>> +  SoC version, plus segment and marketing names.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,socinfo
>>
>> What happened to compatibles? No, this is just wrong and no explained.
>> You ignored other comments as well. Really, that's not the way to go.
>>
> 
> Practically, having different compatibles for each SoC is not needed, as
> the only thing that changes between SoCs is the eFuse(s) that you read to
> get the information - and that's all.


And how do you guarantee that no future SoC will have any difference?
How can you even predict it?

> 
> So ... we either use this driver with devicetree, giving it the right eFuses

I am talking about bindings, no driver.

> to read from, or we duplicate the mtk-efuse driver, or we statically assign
> the eFuses in the driver itself and we set compatibles like
> "mediatek,mt8195-socinfo" to select that... ideas?

Device specific compatibles followed by fallback, just like for every
other review coming from me.

Best regards,
Krzysztof

