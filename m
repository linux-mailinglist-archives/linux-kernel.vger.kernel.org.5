Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBC7903D9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351123AbjIAWzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351114AbjIAWzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:55:05 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A457172A;
        Fri,  1 Sep 2023 14:06:01 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8C6488470A;
        Fri,  1 Sep 2023 23:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693602359;
        bh=T5ppM+hgDLNOtzXqZpuHfRJkf0h6CLW4GEyZrbv/dZI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BzvfltVXLI3Z/vlBO7Rwzt7Zbe0QRH/NpmA48YQhr1xT/XQ5W+jZIg9t27H4OegZM
         hpv1/qsIs0Hk/Gtnxuq9VIgEP0WmE/aqSUh6D3i175CYMqi+IcA/OnX1yVLh4Z++Lb
         ktdIfEp2l+PAJyZMRshn5KzjOXzAxl+a03/qSwnIDdEgPxvCupvMoM8RHg3FI/I/tT
         4cu6uuTSXrAluCF1n8vSv0On1EETiFwEdmSdb2/6XhgqaBk4uT6gwEfblOjXeA8/YV
         GzF99kqH8JYhLjCfS/zoDrwEBESaXv3F535rxLBj2WQ1whpaPPuwG+LKIFWeQtLWRB
         v6R1rLf9jkLBg==
Message-ID: <4ec813ef-aa0d-655e-3f78-7c669d72551c@denx.de>
Date:   Fri, 1 Sep 2023 17:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 1/3] arm64: dts: imx8mp: Add easrc node
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
 <99204fbf-3246-6124-2e35-bdc353d7e7b6@denx.de>
 <CAHCN7xJGGSaO949=u2W6jybdE5R1dE8ihdP9wSrCgk5+9=9H6g@mail.gmail.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xJGGSaO949=u2W6jybdE5R1dE8ihdP9wSrCgk5+9=9H6g@mail.gmail.com>
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

On 9/1/23 13:02, Adam Ford wrote:
> On Thu, Aug 31, 2023 at 4:52 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 8/31/23 06:44, Adam Ford wrote:
>>> The i.MX8MP has an asynchronous sample rate converter which seems
>>> to be the same as what is available on the i.MX8M Nano.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>> V3:  No Change.  The dt-binding update was already accepted into the sound tree, so that patch
>>>        was dropped from the series
>>>
>>> V2:  No Change.
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> index 83d907294fbc..3167706d81e1 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> @@ -1459,6 +1459,26 @@ sai7: sai@30c80000 {
>>>                                        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
>>>                                        status = "disabled";
>>>                                };
>>> +
>>> +                             easrc: easrc@30c90000 {
>>> +                                     compatible = "fsl,imx8mp-easrc", "fsl,imx8mn-easrc";
>>> +                                     reg = <0x30c90000 0x10000>;
>>> +                                     interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
>>> +                                     clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_ASRC_IPG>;
>>> +                                     clock-names = "mem";
>>> +                                     dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
>>> +                                            <&sdma2 18 23 0> , <&sdma2 19 23 0>,
>>> +                                            <&sdma2 20 23 0> , <&sdma2 21 23 0>,
>>> +                                            <&sdma2 22 23 0> , <&sdma2 23 23 0>;
>>> +                                     dma-names = "ctx0_rx", "ctx0_tx",
>>> +                                                 "ctx1_rx", "ctx1_tx",
>>> +                                                 "ctx2_rx", "ctx2_tx",
>>> +                                                 "ctx3_rx", "ctx3_tx";
>>> +                                     firmware-name = "imx/easrc/easrc-imx8mn.bin";
>>
>> Should the firmware name really be imx8mn or should it be imx8mp ?
> 
> The firmware blobs provided by NXP only has easrc-imx8mn.bin and would
> be concerned that having a different name might confuse people if they
> try to go look for it and they only find easrc-imx8mn.bin.  To me,
> this is no different than the SDMA driver using firmware called
> sdma-imx7d.bin

On the other hand, there is "fsl,imx8mp-easrc" compatible string -- to 
differentiate between IPs in case some difference between the IPs that 
cannot be predicted so far is found later on.

>> I think the later is better, you can always add a symlink for the
>> firmware name, and you can discern mx8mn/mp firmwares on the same rootfs
>> in case that was ever needed in the future.

Which is what this part of my comment ^ is all about.
