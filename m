Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4371F7C5259
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjJKLoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJKLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:44:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC7E8F;
        Wed, 11 Oct 2023 04:44:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5244B6607312;
        Wed, 11 Oct 2023 12:44:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697024667;
        bh=N4YKplRWJ6SDqnjedGaZQWvesSWK9mTeJQID5g1MjoI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VTJnx51lKG+BlnOCi8O3YIxIpn9ha3Yd+jN389ICrk6TvipPLABaaTGdRbI/88LZe
         2GAn4QSENinasDmlFEf0NTPaigZA15DuO6LJt8/EWuPbewd9ilnqCj9pkqd3TpS0IA
         dnNoabmRZItnOle1WKQW3/hGsHdyMV3b7oJ6cBtxw5qw+xjEBtkhHRBR+TgF39JLC5
         mVuLSuX1ncXEHLtpCO7srNqv8fLMcmgWAzJAzoOIrWlIz+RenKgMq+rIvN2TCIhPaN
         3E50cD1PFXD3fcbsSoMDeaSGfvswWBMp2o2/Ozg3f+v+TJNa4KISsJgutlkAGpfybC
         /DCrIFymcInHQ==
Message-ID: <d6386e5e-be7a-a68c-e592-1587380480d0@collabora.com>
Date:   Wed, 11 Oct 2023 13:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] media: dt-bindings: mediatek: Add phandle to
 mediatek,scp on MDP3 RDMA
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
References: <20231005104905.120544-1-angelogioacchino.delregno@collabora.com>
 <20231005104905.120544-2-angelogioacchino.delregno@collabora.com>
 <20231006-jinx-playing-261e5f41ff7f@spud>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231006-jinx-playing-261e5f41ff7f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/23 01:36, Conor Dooley ha scritto:
> On Thu, Oct 05, 2023 at 12:49:04PM +0200, AngeloGioacchino Del Regno wrote:
>> The MDP3 RDMA needs to communicate with the SCP remote processor: allow
>> specifying a phandle to a SCP core.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>
>> v2: I've dropped Conor and Chen-Yu's Reviewed-by tags because I have changed
>>      the description (so, the patch actually changed a bit).
> 
> I dunno, you made it more informative so you could probably have kept
> mine at least.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 

I just wanted to be cautious with keeping Reviewed-by tags.

Sometimes it's better to drop than unfairly keeping, I'm sure that you
understand my point here.

Btw, thank you!

Cheers,
Angelo

> Thanks,
> Conor.
> 
>>
>>   .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml     | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>> index 7032c7e15039..59dcea797b71 100644
>> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>> @@ -45,6 +45,14 @@ properties:
>>         include/dt-bindings/gce/<chip>-gce.h of each chips.
>>       $ref: /schemas/types.yaml#/definitions/uint32-array
>>   
>> +  mediatek,scp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the System Control Processor (SCP) used for initializing
>> +      and stopping the MDP3, for sending frame data locations to the MDP3's
>> +      VPU and to install Inter-Processor Interrupt handlers to control
>> +      processing states.
>> +
>>     power-domains:
>>       maxItems: 1
>>   
>> -- 
>> 2.42.0
>>
>>
>> _______________________________________________
>> Kernel mailing list -- kernel@mailman.collabora.com
>> To unsubscribe send an email to kernel-leave@mailman.collabora.com

