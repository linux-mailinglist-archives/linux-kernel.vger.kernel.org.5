Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D77A83BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbjITNqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjITNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:46:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E69BD7;
        Wed, 20 Sep 2023 06:46:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BAF4B66071F1;
        Wed, 20 Sep 2023 14:46:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695217567;
        bh=lgCLhSgqYXiCQOsoRyh80+UifQuGl+xnEfv3AbTIkHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ekLM8GwFSzEQXn88ANZmrr+Hi8sx5bO0pJMQ31aROgmbFzB2+rEKbuwbxmNxOiBns
         6Mvzke16k+NIVsZmqAsESvRju+F4oc4gzsur/sBjxPqVz+8Zg4LhqNBbZM8I/IuAMs
         uq/+7L0p7jy1LICwHBpImFHk8CumKIRr9VYlL2Vn2YIoYk++ZrMgWUiNSZu038EY6p
         uHUCXTbiLe+PCX+8UYgB4ijCR6jmBTiRphaH5uVr2oY8LOQeCBOZSW0asoZFQaCsWg
         lQjmVlob55NL2oVoXq0ie8gKd9Uf8OwkmwGXlnadi1wus9tW54n++VRo5d/rxf5vLk
         j4zRc/rUH+j+g==
Message-ID: <dbd818a2-8290-68c7-a624-4939731b8a1a@collabora.com>
Date:   Wed, 20 Sep 2023 15:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/3] dt-bindings: hwinfo: Add mtk-socinfo driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <fad9eb3c-49f9-5ece-b51a-aaff4d8888ad@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <fad9eb3c-49f9-5ece-b51a-aaff4d8888ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Il 18/09/23 13:59, Krzysztof Kozlowski ha scritto:
> On 18/09/2023 10:47, AngeloGioacchino Del Regno wrote:
>> Il 17/09/23 10:26, Krzysztof Kozlowski ha scritto:
>>> On 15/09/2023 17:26, William-tw Lin wrote:
>>>> dt-binding documentation for mtk-socinfo driver.
>>>
>>> Here and in subject, drop driver and instead descrbe hardware.
>>>
>>>> mtk-socinfo driver provides SoC-related information.
>>>> Such information includes manufacturer information, SoC name,
>>>> SoC segment name, and SoC marketing name.
>>>>
>>>> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
>>>> ---
>>>>    .../bindings/hwinfo/mtk-socinfo.yaml          | 48 +++++++++++++++++++
>>>>    1 file changed, 48 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
>>>> new file mode 100644
>>>> index 000000000000..74f03f1dc404
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
>>>
>>> Nothing improved.
>>>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my previous comments were not fully addressed. Maybe my
>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>> Please go back to the previous discussion and either implement all
>>> requested changes or keep discussing them.
>>>
>>> Thank you.
>>>
>>>> @@ -0,0 +1,48 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/hwinfo/mtk-socinfo.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: MediaTek SoC ChipID
>>>> +
>>>> +maintainers:
>>>> +  - William Lin <william-tw.lin@mediatek.com>
>>>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>>>> +  - Kevin Hilman <khilman@kernel.org>
>>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> +
>>>> +description:
>>>> +  MediaTek SoCs store various product information in eFuses, including
>>>> +  Chip ID and Revision fields, usable to identify the manufacturer,
>>>> +  SoC version, plus segment and marketing names.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: mediatek,socinfo
>>>
>>> What happened to compatibles? No, this is just wrong and no explained.
>>> You ignored other comments as well. Really, that's not the way to go.
>>>
>>
>> Practically, having different compatibles for each SoC is not needed, as
>> the only thing that changes between SoCs is the eFuse(s) that you read to
>> get the information - and that's all.
> 
> 
> And how do you guarantee that no future SoC will have any difference?
> How can you even predict it?
> 

You're right, it's too much long sighted and at some point in the future this
assumption will be *inevitably* wrong.

Thanks,
Angelo

>>
>> So ... we either use this driver with devicetree, giving it the right eFuses
> 
> I am talking about bindings, no driver.
> 
>> to read from, or we duplicate the mtk-efuse driver, or we statically assign
>> the eFuses in the driver itself and we set compatibles like
>> "mediatek,mt8195-socinfo" to select that... ideas?
> 
> Device specific compatibles followed by fallback, just like for every
> other review coming from me.
>  > Best regards,
> Krzysztof
> 

