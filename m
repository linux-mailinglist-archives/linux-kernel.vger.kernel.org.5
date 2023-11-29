Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105617FDAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjK2O7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjK2O7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:59:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E6DA3;
        Wed, 29 Nov 2023 06:59:53 -0800 (PST)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA15366022D0;
        Wed, 29 Nov 2023 14:59:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701269992;
        bh=6x7B3dSj+YnwWLnuQcvnmhm/T6O7NBwYRGfJTFvwlZQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GLivWpS4p2yMUcVGwYVDTweCueIhIn7lydOJhLs+sjtNNlOHnqZreuAkt3ve4IOq8
         yEO249dGpHflSCaYCz2791a56S5tkI0soi8G5dhpnhjA63T5TYQnLNMb1DBWc25tJl
         YKxCeC4pl3DaDXJt5JbM+aaJMdw6ncGR6hf/gQiu3Tn1VXd1k4HexlwR/icp9YjrXC
         L+1lO3wnZQxQFeeTdnoT+jJiYIXnRanr+MBw7F4MljYXv8iS7yV22Q7ruyiFFdxayQ
         hlo37VEkmlqaGZL9eszkPUOWZP96SlHfbvmefa9xYaFXSIIf6FMSSPpxL06N9ElqeO
         PLgzG30knpzHg==
Message-ID: <ea6f1313-95fd-4cb4-864d-84b92f0e5672@collabora.com>
Date:   Wed, 29 Nov 2023 16:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
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
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com>
 <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com>
 <CAJM55Z8vkMbqXY5sS2o4cLi8ow-JQTcXU9=uYMBSykwd4ppExw@mail.gmail.com>
 <054bbf2a-e7ba-40bf-8f8b-f0e0e9b396c6@collabora.com>
 <CAJM55Z9+j6CmfjNkPLCk1DR3EBuEMspsRtNvygDbPWJDCytQpw@mail.gmail.com>
 <5395f3ce-f9ec-474b-b145-5f62a3b7c4fc@collabora.com>
 <CAJM55Z-ff8btSQwJcWViUKLTJ8F2C_b70AaKJMwxgxZurUyGBA@mail.gmail.com>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAJM55Z-ff8btSQwJcWViUKLTJ8F2C_b70AaKJMwxgxZurUyGBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 16:28, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
>> On 11/28/23 18:09, Emil Renner Berthing wrote:
>>> Cristian Ciocaltea wrote:
>>>> On 11/28/23 14:08, Emil Renner Berthing wrote:
>>>>> Cristian Ciocaltea wrote:
>>>>>> On 11/26/23 23:10, Emil Renner Berthing wrote:
>>>>>>> Cristian Ciocaltea wrote:
>>>>>>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
>>>>>>>> RGMII-ID.
>>>>>>>>
>>>>>>>> TODO: Verify if manual adjustment of the RX internal delay is needed. If
>>>>>>>> yes, add the mdio & phy sub-nodes.
>>>>>>>
>>>>>>> Sorry for being late here. I've tested that removing the mdio and phy nodes on
>>>>>>> the the Starlight board works fine, but the rx-internal-delay-ps = <900>
>>>>>>> property not needed on any of my VisionFive V1 boards either.
>>>>>>
>>>>>> No problem, thanks a lot for taking the time to help with the testing!
>>>>>>
>>>>>>> So I wonder why you need that on your board
>>>>>>
>>>>>> I noticed you have a patch 70ca054e82b5 ("net: phy: motorcomm: Disable
>>>>>> rgmii rx delay") in your tree, hence I you please confirm the tests were
>>>>>> done with that commit reverted?
>>>>>>
>>>>>>> Also in the driver patch you add support for phy-mode = "rgmii-txid", but here
>>>>>>> you still set it to "rgmii-id", so which is it?
>>>>>>
>>>>>> Please try with "rgmii-id" first. I added "rgmii-txid" to have a
>>>>>> fallback solution in case the former cannot be used.
>>>>>
>>>>> Ah, I see. Sorry I should have read up on the whole thread. Yes, the Starlight
>>>>> board with the Microchip phy works with "rgmii-id" as is. And you're right,
>>>>> with "rgmii-id" my VF1 needs the rx-internal-delay-ps = <900> property too.
>>>>
>>>> That's great, we have now a pretty clear indication that this uncommon behavior
>>>> stems from the Motorcomm PHY, and *not* from GMAC.
>>>>
>>>>>>
>>>>>>> You've alse removed the phy reset gpio on the Starlight board:
>>>>>>>
>>>>>>>   snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>
>>>>>>>
>>>>>>> Why?
>>>>>>
>>>>>> I missed this in v1 as the gmac handling was done exclusively in
>>>>>> jh7100-common. Thanks for noticing!
>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>>>>>> ---
>>>>>>>>  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts | 5 +++++
>>>>>>>>  1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
>>>>>>>> index 7cda3a89020a..d3f4c99d98da 100644
>>>>>>>> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
>>>>>>>> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
>>>>>>>> @@ -11,3 +11,8 @@ / {
>>>>>>>>  	model = "BeagleV Starlight Beta";
>>>>>>>>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
>>>>>>>>  };
>>>>>>>> +
>>>>>>>> +&gmac {
>>>>>>>> +	phy-mode = "rgmii-id";
>>>>>>>> +	status = "okay";
>>>>>>>> +};
>>>>>>>
>>>>>>> Lastly the phy-mode and status are the same for the VF1 and Starlight boards,
>>>>>>> so why can't these be set in the jh7100-common.dtsi?
>>>>>>
>>>>>> I wasn't sure "rgmii-id" can be used for both boards and I didn't want
>>>>>> to unconditionally enable gmac on Starlight before getting a
>>>>>> confirmation that this actually works.
>>>>>>
>>>>>> If there is no way to make it working with "rgmii-id" (w/ or w/o
>>>>>> adjusting rx-internal-delay-ps), than we should switch to "rgmii-txid".
>>>>>
>>>>> Yeah, I don't exactly know the difference, but both boards seem to work fine
>>>>> with "rgmii-id", so if that is somehow better and/or more correct let's just go
>>>>> with that.
>>>>
>>>> As Andrew already pointed out, going with "rgmii-id" would be the recommended
>>>> approach, as this passes the responsibility of adding both TX and RX delays to
>>>> the PHY.  "rgmii-txid" requires the MAC to handle the RX delay, which might
>>>> break the boards having a conformant (aka well-behaving) PHY.  For some reason
>>>> the Microchip PHY seems to work fine in both cases, but that's most likely an
>>>> exception, as other PHYs might expose a totally different and undesired
>>>> behavior.
>>>>
>>>> I will prepare a v3 soon, and will drop the patches you have already submitted
>>>> as part of [1].
>>>
>>> Sounds good. Then what's missing for ethernet to work is just the clock patches:
>>> https://github.com/esmil/linux/commit/b5abe1cb3815765739aff7949deed6f65b952c4a
>>> https://github.com/esmil/linux/commit/3a7a423b15a9f796586cbbdc37010d2b83ff2367
>>>
>>> You can either include those as part of your patch series enabling ethernet, or
>>> they can be submitted separately with the audio clocks. Either way is
>>> fine by me.
>>
>> I can cherry-pick them, but so far I couldn't identify any networking
>> related issues if those patches are not applied. Could it be something
>> specific to Starlight board only?
> 
> No, it's the same for both boards. The dwmac-starfive driver adjusts
> the tx clock:
> 
> 1000Mbit -> 125MHz
>  100Mbit ->  25MHz
>   10Mbit -> 2.5MHz
> 
> The tx clock is given in the device tree as the gmac_tx_inv clock which derives
> from either the gmac_root_div or gmac_rmii_ref external clock like this:
> 
> gmac_rmii_ref (external) -> gmac_rmii_txclk     \
> gmac_root_div  (500MHz)  -> gmac_gtxclk (div N) -> gmac_tx (mux) -> gmac_tx_inv
> 
> ..where N defaults to 4 and the gmac_tx mux defaults to the gmac_gtxclk, so
> the gmac_tx_inv clock defaults to 125MHz suitable for 1000Mbit connections.
> See /sys/kernel/debug/clk/clk_summary for another overview.
> 
> When the dwmac_starfive driver request to change gmac_tx_inv to 25MHz the clock
> framework will that it has the CLK_SET_RATE_PARENT flag set, so it will try
> the gmac_tx clock next. This is a mux that can choose either the
> 125MHz gmac_gtxclk
> or the external gmac_rmii_txclk which defaults to 0MHz in the current
> device trees,
> so the request cannot be met.
> 
> That's why we need to set the CLK_SET_RATE_PARENT (and CLK_SET_RATE_NO_REPARENT)
> flags on the gmac_tx clock so the clock framework again goes to try setting the
> gmac_gtxclk to 25MHz, which it can because it's a divider and setting N=20
> does the trick.
> 
> On your board you can manually force a 100Mbit connection with
> ethtool -s eth0 speed 100
> 
> That fails on my boards without those two patches.
> /Emil

Thanks for the detailed explanation! I've been only verified with
gigabit connectivity, that would explain why I didn't notice the issue.
I will make sure to properly test this before sending v3.

Regards,
Cristian
