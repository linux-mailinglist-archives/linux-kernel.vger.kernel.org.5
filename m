Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FDF7FAF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjK1Akr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1Akp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:40:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5842FD45;
        Mon, 27 Nov 2023 16:40:51 -0800 (PST)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EBEE06602F33;
        Tue, 28 Nov 2023 00:40:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701132049;
        bh=h7YSTfO06hlkQSwOKq0bWn+ONs0St86lF+pU8MQKvuI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VmzBZg6CWKaixb4KhvHQgi7BX64H30ILpSwJn84YmYWZ/X9EQUVAtEmmGPbQpqjCJ
         HlT7k94u4qqZtBcttWVg+gCoMWQfTU58LRK9PgNINlDI92FYyfON2ZP2c7zMhbFGUq
         VtsKwOMjNIUtJW6ZTM6LsA6pmm6EnetWS5jxDZ6wPURQsBAzHiCw+prW9MpZHFbbgx
         D2IA6oWvtQXonHcb96Ec7wfwr49e/9EQCZ1huEjNJI0s2tbgruvzMtdY8cO8/g5kRd
         IUJOvu14Vz0cBTusg/X8G9ZIeIgdyGUPNFETVGWOlhz5XnDIp9Z88xnPCahH5UHD8F
         DW51oTFSIXKvQ==
Message-ID: <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com>
Date:   Tue, 28 Nov 2023 02:40:43 +0200
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
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 11/26/23 23:10, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
>> RGMII-ID.
>>
>> TODO: Verify if manual adjustment of the RX internal delay is needed. If
>> yes, add the mdio & phy sub-nodes.
> 
> Sorry for being late here. I've tested that removing the mdio and phy nodes on
> the the Starlight board works fine, but the rx-internal-delay-ps = <900>
> property not needed on any of my VisionFive V1 boards either. 

No problem, thanks a lot for taking the time to help with the testing!

> So I wonder why you need that on your board

I noticed you have a patch 70ca054e82b5 ("net: phy: motorcomm: Disable
rgmii rx delay") in your tree, hence I you please confirm the tests were
done with that commit reverted?

> Also in the driver patch you add support for phy-mode = "rgmii-txid", but here
> you still set it to "rgmii-id", so which is it?

Please try with "rgmii-id" first. I added "rgmii-txid" to have a
fallback solution in case the former cannot be used.

> You've alse removed the phy reset gpio on the Starlight board:
> 
>   snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>
> 
> Why?

I missed this in v1 as the gmac handling was done exclusively in
jh7100-common. Thanks for noticing!

>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
>> index 7cda3a89020a..d3f4c99d98da 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
>> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
>> @@ -11,3 +11,8 @@ / {
>>  	model = "BeagleV Starlight Beta";
>>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
>>  };
>> +
>> +&gmac {
>> +	phy-mode = "rgmii-id";
>> +	status = "okay";
>> +};
> 
> Lastly the phy-mode and status are the same for the VF1 and Starlight boards,
> so why can't these be set in the jh7100-common.dtsi?

I wasn't sure "rgmii-id" can be used for both boards and I didn't want
to unconditionally enable gmac on Starlight before getting a
confirmation that this actually works.

If there is no way to make it working with "rgmii-id" (w/ or w/o
adjusting rx-internal-delay-ps), than we should switch to "rgmii-txid".

Thanks,
Cristian
