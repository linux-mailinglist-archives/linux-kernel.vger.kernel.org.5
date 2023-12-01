Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F0800FA8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379485AbjLAPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379461AbjLAPcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:32:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EABC1738;
        Fri,  1 Dec 2023 07:32:25 -0800 (PST)
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 88F3E660739A;
        Fri,  1 Dec 2023 15:32:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701444744;
        bh=tNdSmYTDgv9TDc5k/n3GNbFZ1OQJA3GgTmeWeu7A4x8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z6E7zwKeTZgTXBpUwQV/3AUvSEy1KeCPkbw/7VMdxJN+uykpCdyaS7JAE3NAbRzc7
         4B7RFcXoUvZ2F9iSURyGjptLaVmDAB+WyuMU4HVGGm8n8l55h7Vj/TarpfWrIw9RLz
         9KuUkSv8DFdG5HneVf3pMH0cpGqNFe4CXdCPdVb+C0eNRrvacsCyEikKkNGKTEI4ek
         SVRo049kcwUsPKEDPhSrFmC81NXpCACgb9SvTvvuyQj9T3UaHmNsjdbiPzvCuDRUYb
         n2T/JbRCXRndQMECr5Ms4kiAidVeAjVb+25aLwWQ466vbvNkGifv7hECjgnETjcsQv
         SauXuJyjmAeoQ==
Message-ID: <525f20de-4eb8-4786-84b5-64eb989bdc4c@collabora.com>
Date:   Fri, 1 Dec 2023 17:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-7-wenst@chromium.org>
 <60beb523-292b-4c77-9030-1bfdfd73c140@collabora.com>
 <CAGXv+5GmjZbzLbxADoNXDiF8dTAwnxva29vuM0FG8vY-6wTJcQ@mail.gmail.com>
 <4c15c9a4-bf04-492d-9e02-d630092b6caa@collabora.com>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <4c15c9a4-bf04-492d-9e02-d630092b6caa@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 15:05, AngeloGioacchino Del Regno wrote:
> Il 27/11/23 05:00, Chen-Yu Tsai ha scritto:
>> On Mon, Oct 23, 2023 at 5:05 PM Eugen Hristev
>> <eugen.hristev@collabora.com> wrote:
>>>
>>> On 10/13/23 02:02, Chen-Yu Tsai wrote:
>>>> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
>>>> Krabby design.
>>>>
>>>> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
>>>> convertible device with touchscreen and stylus.
>>>>
>>>> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
>>>> device. It does not have a touchscreen or stylus.
>>>>
>>>> The two devices both have two variants. The difference is a second
>>>> source touchpad controller that shares the same address as the original,
>>>> but is incompatible.
>>>>
>>>> The extra SKU IDs for the Tentacruel devices map to different sensor
>>>> components attached to the Embedded Controller. These are not visible
>>>> to the main processor.
>>>>
>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/Makefile         |    4 +
>>>>    .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  130 ++
>>>>    .../mt8186-corsola-tentacool-sku327681.dts    |   49 +
>>>>    .../mt8186-corsola-tentacool-sku327683.dts    |   26 +
>>>>    .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
>>>>    .../mt8186-corsola-tentacruel-sku262148.dts   |   28 +
>>>>    .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1704 +++++++++++++++++
>>>>    7 files changed, 1985 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>>>
>>
>> [...]
>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>>> new file mode 100644
>>>> index 000000000000..42ebab1bafeb
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>>> @@ -0,0 +1,1704 @@
>>
>> [...]
>>
>>>
>>> Hi Chen-Yu,
>>>
>>> These two aud_gpio_tdm empty entries cause this message to be printed:
>>>
>>> [   12.949519] mt8186_mt6366_rt1019_rt5682s sound: there is not valid
>>> maps for state aud_gpio_tdm_off
>>> [   12.959025] mt8186_mt6366_rt1019_rt5682s sound: there is not valid
>>> maps for state aud_gpio_tdm_on
>>
>> I guess we need to teach the sound driver to ignore empty pinmux states?
> 
> ...and we need to teach to the bindings that the aud_gpio_tdm_{off,on} are
> optional states and can be omitted.

Hello Angelo,

The binding does not appear to specify any required states. Am I getting this
wrong? Hence, we can just remove these states from the DT node.


Hello Chen-Yu,

The error message comes from the pinctrl, from dt_to_map_one_config() .
I believe we can safely just remove these two if corsola device does not use TDM.
From my perspective it is pointless to have two empty pinctrl states just for the
sake of it if there are no pins involved.
Please correct me if you have more knowledge about it.

Thanks,
Eugen

> 
> Cheers,
> Angelo
> 
>>
>> ChenYu
> 
> 
> 

