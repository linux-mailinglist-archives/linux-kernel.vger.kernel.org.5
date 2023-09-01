Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1727903D5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351151AbjIAWzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351109AbjIAWzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:55:05 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188A172D;
        Fri,  1 Sep 2023 14:06:02 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3E57F86784;
        Fri,  1 Sep 2023 23:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693602361;
        bh=9ni6WpCLFXsfPtmtSSKyYdoZ+OPfotsSV4r5eavgMAA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=w3jvVWugIgtBjjHtQNuDByeDxff9KmrcUaUiHLNzOS1O+KedXs3NNSfttnZET8v98
         4lXYzXBfSeAHbHOD2/R92jn8KUwEdH0pG3cEuc9zy+LhtA7y6f5Y+7s+dHZfFAnxb+
         sEUAJjRc+MDmIsE6tlZCKxmz71GLzJXaK+EhlUWUT/3EBQBzIDhJlQRt6fXk6hwHaM
         02q5iDEkNx23fjj3J0/n9N//wXU7ZdJNKAWASDXkWeYFfxHC+vp+hzrG/z2X28Iq+j
         hSTgqizwNXvvVEYfowTAmYenlgSl472HppFnOpX5jbYTLKXKQ1ScZ5RWrofkdhhTZD
         Bj8Byno9PAe+g==
Message-ID: <c14a6e7b-3bfc-2dd9-378e-fb587e3e03e8@denx.de>
Date:   Fri, 1 Sep 2023 17:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 2/3] arm64: dts: imx8mp: Add micfil node
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230831044431.250338-1-aford173@gmail.com>
 <20230831044431.250338-2-aford173@gmail.com>
 <4d700304-3e10-a19b-d3f0-d0a1aec11580@denx.de>
 <CAHCN7xJpug+ap4koX_3w_YTvHF9NC8-2S0f69SsDNY_6T+rcPQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xJpug+ap4koX_3w_YTvHF9NC8-2S0f69SsDNY_6T+rcPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 13:06, Adam Ford wrote:
> On Thu, Aug 31, 2023 at 4:53 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 8/31/23 06:44, Adam Ford wrote:
>>> The i.MX8MP has a micfil controller which is used for interfacing
>>> with a pulse density microphone. Add the node and mark it as
>>> disabled by default.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>> V3:  The AUDIOMIX_PDM_ROOT doesn't exist and the real clock is
>>>        called IMX8MP_CLK_AUDIOMIX_PDM_SEL, so swap it out.
>>>
>>> V2:  No change
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> index 3167706d81e1..341fd0369ce9 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> @@ -1479,6 +1479,27 @@ easrc: easrc@30c90000 {
>>>                                        fsl,asrc-format = <2>;
>>>                                        status = "disabled";
>>>                                };
>>> +
>>> +                             micfil: audio-controller@30ca0000 {
>>> +                                     compatible = "fsl,imx8mp-micfil";
>>> +                                     reg = <0x30ca0000 0x10000>;
>>> +                                     #sound-dai-cells = <0>;
>>> +                                     interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                                  <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                                  <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                                  <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>>> +                                     clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_IPG>,
>>> +                                              <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_SEL>,
>>> +                                              <&clk IMX8MP_AUDIO_PLL1_OUT>,
>>> +                                              <&clk IMX8MP_AUDIO_PLL2_OUT>,
>>> +                                              <&clk IMX8MP_CLK_EXT3>;
>>> +                                     clock-names = "ipg_clk", "ipg_clk_app",
>>> +                                                   "pll8k", "pll11k", "clkext3";
>>> +                                     dmas = <&sdma2 24 25 0x80000000>;
>>> +                                     dma-names = "rx";
>>
>> Is dma-names really required if there is only a single DMA channel in DT ?
> 
> I would normally agree with you, the DT binding file shows it's
> required, and the driver looks like it's searching for a channel name
> called 'rx'

Maybe something that can be improved both in the driver and bindings ?
