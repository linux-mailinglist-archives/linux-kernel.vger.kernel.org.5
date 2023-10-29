Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C517DAEB6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjJ2WCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJ2WC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:02:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23EB7;
        Sun, 29 Oct 2023 15:02:25 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B00166072BB;
        Sun, 29 Oct 2023 22:02:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698616943;
        bh=vk26fELTpT3lCmDhyB1BjvWl5h7dQQR7ACLCNBDPifc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=O+GZqN62WN5APTjARqZkYPmUNIns8iAzqU5RwVcknHv5gn2dalAdOrAvgfZZAN1wO
         FR82nLLqV7LKaCA7id+z6mFSgps0dFV/FVfrU722pMDmqJAhs2QB+72cdXVQc4mbJm
         ugmR5k8zhDJur7w4odrYO6R9fzpo8xTaNIDiOc+I8d9lL5nI7uONAbE9g99uLOcFYp
         iKLWHjI0BNIHuPBK0QNimyIhU/DPJ6bRVtAC4C4vnL2sstX4h0/vYgTydKKegOW1p9
         jI9XG6Nb3s2U5Qo/oOAeoxmpiYi2fBBwM0sTcipjkdQC5sO398jKwS7iXzNMKYSnqo
         JxdXwhGZ4fZjw==
Message-ID: <ee857617-9be9-45ae-a488-3842caf9013b@collabora.com>
Date:   Mon, 30 Oct 2023 00:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: net: snps,dwmac: Allow exclusive
 usage of ahb reset
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-2-cristian.ciocaltea@collabora.com>
 <e2c65d01-3498-4287-a6dc-b926135df762@linaro.org>
 <564503dd-b779-4e9f-851d-f34d9ea5fa65@collabora.com>
In-Reply-To: <564503dd-b779-4e9f-851d-f34d9ea5fa65@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/23 23:55, Cristian Ciocaltea wrote:
> On 10/29/23 13:21, Krzysztof Kozlowski wrote:
>> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>>> The Synopsys DesignWare MAC found on the StarFive JH7100 SoC requires
>>> just the 'ahb' reset name, but the binding allows selecting it only in
>>> conjunction with 'stmmaceth'.
>>>
>>> Fix the issue by permitting exclusive usage of the 'ahb' reset name.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> index 5c2769dc689a..a4d7172ea701 100644
>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> @@ -146,7 +146,7 @@ properties:
>>>    reset-names:
>>>      minItems: 1
>>>      items:
>>> -      - const: stmmaceth
>>> +      - enum: [stmmaceth, ahb]
>>
>> Your patch #3 says you have minimum two items. Here you claim you have
>> only one reset. It's confusing.
> 
> At least the following use-cases need to be supported:
> 
> - JH7110: reset-names = "stmmaceth", "ahb";
> - JH7110: reset-names = "ahb";

I've just realized my mistake here - this is for JH7100, sorry for the
confusion:

- JH7100: reset-names = "ahb";

> - other:  reset-names = "stmmaceth";
> 
> Since this is the schema which gets included later in other bindings,
> the property needs to be generic enough to cope with all the above.
> [added actual content here for more clarity]
> 
>   reset-names:
>     minItems: 1
>     items:
>       - enum: [stmmaceth, ahb]
>       - const: ahb
> 
> Therefore, only the lower limit (1) is enforced here, while
> starfive,jh7110-dwmac.yaml (which PATCH 3 relates to) adds further
> constraints (limiting to precisely two items):
> 
>     reset-names:
>       items:
>         - const: stmmaceth
>         - const: ahb
> 
> I understand the generic binding also allows now specifying 'ahb' twice,
> but I'm not sure if there's a convenient way to avoid that (e.g. without
> complicating excessively the schema).
