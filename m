Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E83F7B510B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjJBLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbjJBLRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:17:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C275BF;
        Mon,  2 Oct 2023 04:17:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31B2266071CC;
        Mon,  2 Oct 2023 12:17:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696245426;
        bh=bCVKgfEyIBfkvclrAUIZ1OqNvdnA9MnuxWdGlizqr6Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dGelpfmPV3Gxl9o94SX9HiLf0VftMd5vk6eZVPdw++neoIcApTKChhvU0BNtLYC+F
         nvFr43vSS8XCuT+E2hhIKGn+THIgsk6eTDwf8b5oWymd00sGVhbX65dmBBApURW2/9
         NQD1DbxxQSqYFrbb7+i8PR4kf5fpj30amplLu3aCfrc0OspFxAHB6ejhXuLEXoPYks
         DM2yHcuk+cgogdQffJ/miCYK9zirv17YiwAioRtHptpzrJQmhM7hnYfMjJSSf62PLl
         /Iro39qCVKbrc7i3+bAQGrr8WunKR4n84t8ddzipPi06rQRQ+GBs3OcLfkQuwfQhkt
         zO4wxNgWYC1mA==
Message-ID: <318c050c-3007-d1d5-e727-6c117de12522@collabora.com>
Date:   Mon, 2 Oct 2023 13:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] media: dt-bindings: mediatek: Add phandle to
 mediatek,scp on MDP3 RDMA
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mchehab@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
References: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com>
 <20230919095938.70679-2-angelogioacchino.delregno@collabora.com>
 <e4311804-bb06-ec04-8479-dfa0466e4b35@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <e4311804-bb06-ec04-8479-dfa0466e4b35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/23 19:38, Krzysztof Kozlowski ha scritto:
> On 19/09/2023 11:59, AngeloGioacchino Del Regno wrote:
>> The MDP3 RDMA needs to communicate with the SCP remote processor: allow
>> specifying a phandle to a SCP core.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml       | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>> index d639a1461143..0e5ce2e77e99 100644
>> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>> @@ -46,6 +46,11 @@ properties:
>>         include/dt-bindings/gce/<chip>-gce.h of each chips.
>>       $ref: /schemas/types.yaml#/definitions/uint32-array
>>   
>> +  mediatek,scp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the System Control Processor (SCP) node
> 
> Why? Why do you need it? For what do you add here phandle? Your
> description should explain the purpose.
> 

Sorry for the slow reply, just seen your feedback, thanks!
I'll add a nicer description for v2.

Cheers,
Angelo

