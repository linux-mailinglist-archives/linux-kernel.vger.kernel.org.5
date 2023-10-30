Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D87DC039
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJ3THi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3THg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:07:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA0A9F;
        Mon, 30 Oct 2023 12:07:34 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8022660738E;
        Mon, 30 Oct 2023 19:07:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698692850;
        bh=g4DDJuitIKJOlaC+ixH0Wb45kPbDiZzr2p0K8FyumpE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BEmtIzPo3S4H7O1AHyvDo+IXxMdDZSlntO4lLHl1X1K2x3YrnPYagnlGbmfVOwz0h
         oMFdDDEKqmYeCcrQxeto5UKqriXyLuUFJUCiPw0Mgx2kIPhtNplLT9d/TRMB2PZo1Z
         TuwhR3wHaGUtK14kujhs/PsUDSZq5LL7FlQTzxe8Rkcgm31t6MA0+xQqJ3O02+S4DN
         m03zIAJiFhh3Go5VToLu5gxKKcrz3TXBDZ/Wz6KYLHJZ8l7oOBd3idspoZatWNUBwI
         /VAhAP/HqBfOG5yH62yaSA67qf8KiXU3rRqFBt6GQKd5BIGnWmVhLZp9VGZME1kJa+
         uWWh6eQ8TWYgA==
Message-ID: <d532514a-524c-4607-b97b-2f89bc563406@collabora.com>
Date:   Mon, 30 Oct 2023 21:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: net: snps,dwmac: Allow exclusive
 usage of ahb reset
Content-Language: en-US
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
 <3016eff2-fce5-4b5e-bbb2-d56cbb45df85@linaro.org>
 <05186c62-fcad-4d56-8ae8-d802f87a39e2@collabora.com>
 <98d90ba9-7e69-4b54-830d-bdbc0e6c54fe@linaro.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <98d90ba9-7e69-4b54-830d-bdbc0e6c54fe@linaro.org>
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

On 10/30/23 09:26, Krzysztof Kozlowski wrote:
> On 29/10/2023 23:24, Cristian Ciocaltea wrote:
>> On 10/29/23 13:25, Krzysztof Kozlowski wrote:
>>> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>>>> The Synopsys DesignWare MAC found on the StarFive JH7100 SoC requires
>>>> just the 'ahb' reset name, but the binding allows selecting it only in
>>>> conjunction with 'stmmaceth'.
>>>>
>>>> Fix the issue by permitting exclusive usage of the 'ahb' reset name.
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> index 5c2769dc689a..a4d7172ea701 100644
>>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> @@ -146,7 +146,7 @@ properties:
>>>>    reset-names:
>>>>      minItems: 1
>>>>      items:
>>>> -      - const: stmmaceth
>>>> +      - enum: [stmmaceth, ahb]
>>>
>>> Also, this makes sense only with patch #4, so this should be squashed there.
>>
>> I added this as a separate patch since it changes the generic schema
>> which is included by many other bindings.  JH7100 just happens to be the
>> first use-case requiring this update.  But I can squash the patch if
>> that's not a good enough reason to keep it separately.
> 
> If there is no single user of this, why changing this? I would even
> argue that it is not correct from existing bindings point of view -
> nothing allows and uses ahb as the only reset. Even the commit msg
> mentions your hardware from patch 4.

Sorry, I'm not sure I follow. JH7100 is (or will be) the user of it and,
as a matter of fact, something similar has been done recently while
adding support for JH7110.

In particular, commit [1] changed this binding before the JH7110
compatible was introduced in a subsequent patch. On a closer look that
commit made a statement which is not entirely correct:

"dwmac controller may require one (stmmaceth) or two (stmmaceth+ahb)
reset signals"

That's because stmmaceth is also optional in dwmac's driver, hence the
correct message would have been:

"[...] may require one (stmmaceth OR ahb) [...]"

Hence, I think it makes sense to keep this patch, after adding the above
details in the commit message.

[1] 843f603762a5 ("dt-bindings: net: snps,dwmac: Add 'ahb'
reset/reset-name")

Thanks,
Cristian
