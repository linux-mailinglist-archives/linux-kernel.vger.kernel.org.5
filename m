Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD2800691
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377997AbjLAJIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377963AbjLAJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:08:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7674B1725;
        Fri,  1 Dec 2023 01:08:45 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AC51660739A;
        Fri,  1 Dec 2023 09:08:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701421724;
        bh=PrNOiryV2LYy+Uuh76/Z7l/ZUYqlS9fP9X5q/gjltQA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kEvXUR3YKIgGpnJipALuVIaL1ELMcPFqwdfQTihCWtCUznQgsfPU6z6+h/7vwHpax
         CjE/RbwjYK681YEWe7jxwZgYcfVk38p0+DyIgfCjd65aezEKSiV5Yo/GswRXkJd4Yt
         cEqDBqtBvo+S4VcXNZBjCmOjXJ00bKNOq5Bay27zNK9HCT8ocGkwpDrFeyQTZeTMjq
         U6DmOdYoHrIjmGjkilxMTSG0fGuanWhNHrq2W2u14+Bi6x6EvfDxbWM8B07/CqS9hV
         tgEchnPGERtFi2W2ft9YSOxW2Oo2TAiqy2tmICV4e3RwmtunB0uOs27k029+O6DhKZ
         Fxb2mHk34uqqg==
Message-ID: <d4f33b5c-f80d-4808-8e94-5c01eda34f10@collabora.com>
Date:   Fri, 1 Dec 2023 10:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi
 unnecessary cells properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        kernel@collabora.com, hsinyi@chromium.org
References: <20230814071053.5459-1-eugen.hristev@collabora.com>
 <170126437824.153055.10626099314938040381.b4-ty@collabora.com>
 <299f569f-c3e7-4807-a141-4bbc06435f03@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <299f569f-c3e7-4807-a141-4bbc06435f03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/11/23 10:01, Krzysztof Kozlowski ha scritto:
> On 29/11/2023 14:27, AngeloGioacchino Del Regno wrote:
>>
>> On Mon, 14 Aug 2023 10:10:53 +0300, Eugen Hristev wrote:
>>> dtbs_check throws a warning at the dsi node:
>>> Warning (avoid_unnecessary_addr_size): /soc/dsi@14014000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>>
>>> Other DTS have a panel child node with a reg, so the parent dtsi
>>> must have the address-cells and size-cells, however this specific DT
>>> has the panel removed, but not the cells, hence the warning above.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties
>>        commit: 4b66a34afe29d991155081b2f1e10482bd00cbaa
>>
> 
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
> 
> You know, your SoB implies review. Unless you want to say you
> usually apply code without reviewing it...
> 

Yeah, of course it does imply review ... but if there's no actual problem with me
also sending a R-b tag, it's more practical for me, because:
  1. I have mail filters to show me what I reviewed, and
  2. Matthias also can see what I reviewed....

...but I get it that in the specific case of *this* patch, I've sent a R-b just
before applying, so I agree in that this was actually really really useless to do.

so.. whoops :-)

Thanks, btw!
Angelo

