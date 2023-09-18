Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF97A451B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbjIRIs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbjIRIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:48:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B910E;
        Mon, 18 Sep 2023 01:47:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4750366071A0;
        Mon, 18 Sep 2023 09:47:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695026875;
        bh=PQUHws8Z1w+TcF0jCRyePlr50AeNkNWESN1De6xP8dY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cLEYwxEiW2Z8laabejsz3E+oq39RdP0AVM6njg/u5/bbU+4eLVyrUT9RPaweN01CA
         Pb7vMLBcp/lm5f0rhZ9kNADin2MewwuuMpDZmRNTmIca4b720JCsbPI3d5D0mRNZan
         AUGUyZn00oQmQe2i6Dt/ppeU3eu50jjq4klAD85PWwu4+cW5vSg+wK7KVgxQilm+uf
         LzZ5927BaNwAdV4r6hQbNEB7VtyiSadwF4YHvvS9UL7XElzBhPjD76fa9m50MS9+oA
         m4tnB2kBGJD/gpspLH8tKOQ5kidqMxVSmaT40X4bhX0zD1RqI+QA3CtKz8KkDGDPz3
         ggIPipT5GMKcA==
Message-ID: <9acc8d99-e3db-3df8-4051-21d95450b28d@collabora.com>
Date:   Mon, 18 Sep 2023 10:47:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/3] dt-bindings: hwinfo: Add mtk-socinfo driver
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
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <3e7bc476-ffc7-fb07-8e64-246427da736c@linaro.org>
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

Il 17/09/23 10:26, Krzysztof Kozlowski ha scritto:
> On 15/09/2023 17:26, William-tw Lin wrote:
>> dt-binding documentation for mtk-socinfo driver.
> 
> Here and in subject, drop driver and instead descrbe hardware.
> 
>> mtk-socinfo driver provides SoC-related information.
>> Such information includes manufacturer information, SoC name,
>> SoC segment name, and SoC marketing name.
>>
>> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
>> ---
>>   .../bindings/hwinfo/mtk-socinfo.yaml          | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
>> new file mode 100644
>> index 000000000000..74f03f1dc404
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
> 
> Nothing improved.
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 
> Thank you.
> 
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwinfo/mtk-socinfo.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek SoC ChipID
>> +
>> +maintainers:
>> +  - William Lin <william-tw.lin@mediatek.com>
>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>> +  - Kevin Hilman <khilman@kernel.org>
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +description:
>> +  MediaTek SoCs store various product information in eFuses, including
>> +  Chip ID and Revision fields, usable to identify the manufacturer,
>> +  SoC version, plus segment and marketing names.
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,socinfo
> 
> What happened to compatibles? No, this is just wrong and no explained.
> You ignored other comments as well. Really, that's not the way to go.
> 

Practically, having different compatibles for each SoC is not needed, as
the only thing that changes between SoCs is the eFuse(s) that you read to
get the information - and that's all.

So ... we either use this driver with devicetree, giving it the right eFuses
to read from, or we duplicate the mtk-efuse driver, or we statically assign
the eFuses in the driver itself and we set compatibles like
"mediatek,mt8195-socinfo" to select that... ideas?

Cheers,
Angelo

> NAK
> 
> Best regards,
> Krzysztof
> 

