Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45177C11D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjHNTzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjHNTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:55:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E6E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:55:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-997c4107d62so630074366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692042905; x=1692647705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RykofCguml6rSMpJYe0VPw+oopELw4ZN/ghN42VwsP4=;
        b=Md6ABwFmuunlVk+OyZekSEThFF9OwW/PY+wmBONune03X4WdEZk+I9BGLMPGrn1T26
         7kzogeviAVaxf38nOX1up595rjblj8oaP0LLshPZ5a2rcxY9kbisZMr2WXgWGOl9S3Py
         8n6D+ma22EtAAl79X6qXxsN0zag7Pa3N2Gc87NbTe9/N2ejQeKxtr0hXvBn2PCTy8tvV
         6oY2khWUg+f9S6xz/plJOu/sxwyUt6btOnNcjsREEQK87Qkk/CpK8Y8ztJTn0+gTuAG8
         +aJujmwl+tS/qWKkSItKBYW8f5J+7tS5Ab8OxJDyoUyiCv24wEYDDXBWlRi/FggwjtHq
         c6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042905; x=1692647705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RykofCguml6rSMpJYe0VPw+oopELw4ZN/ghN42VwsP4=;
        b=dV3JmKTn5+MQTNYfV627mbXLoNMFnYOWYVOyz5hj96cGICy1Z0wrG63+qSXbTmAz8y
         Q53EdXqFjkkmrRw26pYaIFdOBOhxV3lc7qrqH6VR0ZRQ5F5cQiZW7B385vEICvspwkGQ
         QI+MQ6xzDRWDPYApjc0jb9XKFIa0FWjPCLKgaKzGF5DzfTf/1xf449/c1td8Z9DGo75b
         ie4W/nIU/gLRGoOokeal0DZ8TixG2XSik5wGyxyPQmbDp67tWbAWCyx55jhFWvRpDV8W
         cHHvW/4jzDeLgdPNDbVJo9vEI2FLx/5ByT45MKc7quJIuwPFthQuabqHpPeWqQybyMEG
         XUmQ==
X-Gm-Message-State: AOJu0Yx2M2Ng4I5DzVXfv8303e3wGUe3oSIm4dDlWhjFmppCM2pKRdvF
        9iriq3qViRTohWYY/B0x7CM/6Q==
X-Google-Smtp-Source: AGHT+IFxdS8jB/vXR9RW8EAGNbjE/bRPZ4ed13Lyl3ZWTg86j0xk6ItclZVeE1vRwpbXZh8Gv0Ca6w==
X-Received: by 2002:a17:906:315b:b0:99c:a23b:b4f5 with SMTP id e27-20020a170906315b00b0099ca23bb4f5mr9496008eje.53.1692042905042;
        Mon, 14 Aug 2023 12:55:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b00993a37aebc5sm5972415ejb.50.2023.08.14.12.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:55:04 -0700 (PDT)
Message-ID: <e3d2ff98-8d05-fdf7-7df6-a5450c6cdc21@linaro.org>
Date:   Mon, 14 Aug 2023 21:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, ravi.patel@samsung.com,
        'Jayati Sahu' <jayati.sahu@samsung.com>, swathi.ks@samsung.com
References: <20230111075422.107173-1-sriranjani.p@samsung.com>
 <CGME20230111075455epcas5p1951d1981f15d252e09281621ef5fbf15@epcas5p1.samsung.com>
 <20230111075422.107173-5-sriranjani.p@samsung.com>
 <7d74a96e-e3a5-118c-04a9-e8ed95fffa54@linaro.org>
 <000101d9ce99$f454da20$dcfe8e60$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000101d9ce99$f454da20$dcfe8e60$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 12:27, Sriranjani P wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 12 January 2023 15:07
>> To: Sriranjani P <sriranjani.p@samsung.com>; davem@davemloft.net;
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> alexandre.torgue@foss.st.com; peppe.cavallaro@st.com;
>> joabreu@synopsys.com; mcoquelin.stm32@gmail.com
>> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; pankaj.dubey@samsung.com;
>> alim.akhtar@samsung.com; ravi.patel@samsung.com; Jayati Sahu
>> <jayati.sahu@samsung.com>
>> Subject: Re: [PATCH v2 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
>> Block of FSD SoC
>>
>> On 11/01/2023 08:54, Sriranjani P wrote:
>>> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP,
>>> one in
>>> FSYS0 block and other in PERIC block.
>>>
>>> Adds device tree node for Ethernet in PERIC Block and enables the same
>>> for FSD platform.
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
>>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>>> ---
>>>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
>>>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56
>> ++++++++++++++++++++++
>>>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 29 +++++++++++
>>>  3 files changed, 94 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> index ca0c1a28d562..2c0cbe775e04 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> @@ -39,6 +39,15 @@
>>>  	};
>>>  };
>>>
>>> +&ethernet_1 {
>>> +	status = "okay";
>>> +
>>> +	fixed-link {
>>> +		speed = <1000>;
>>> +		full-duplex;
>>> +	};
>>> +};
>>> +
>>>  &fin_pll {
>>>  	clock-frequency = <24000000>;
>>>  };
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>> b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>> index 7ccc0738a149..c955bf159786 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>> +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>> @@ -395,6 +395,62 @@
>>>  		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>>  		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
>>>  	};
>>> +
>>> +	eth1_tx_clk: eth1-tx-clk-pins {
>>> +		samsung,pins = "gpf2-0";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth1_tx_data: eth1-tx-data-pins {
>>> +		samsung,pins = "gpf2-1", "gpf2-2", "gpf2-3", "gpf2-4";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth1_tx_ctrl: eth1-tx-ctrl-pins {
>>> +		samsung,pins = "gpf2-5";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth1_phy_intr: eth1-phy-intr-pins {
>>> +		samsung,pins = "gpf2-6";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
>>> +	};
>>> +
>>> +	eth1_rx_clk: eth1-rx-clk-pins {
>>> +		samsung,pins = "gpf3-0";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth1_rx_data: eth1-rx-data-pins {
>>> +		samsung,pins = "gpf3-1", "gpf3-2", "gpf3-3", "gpf3-4";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth1_rx_ctrl: eth1-rx-ctrl-pins {
>>> +		samsung,pins = "gpf3-5";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth1_mdio: eth1-mdio-pins {
>>> +		samsung,pins = "gpf3-6", "gpf3-7";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
>>> +	};
>>>  };
>>>
>>>  &pinctrl_pmu {
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> b/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> index ade707cc646b..8807055807dd 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> @@ -33,6 +33,7 @@
>>>  		spi1 = &spi_1;
>>>  		spi2 = &spi_2;
>>>  		eth0 = &ethernet_0;
>>> +		eth1 = &ethernet_1;
>>
>> Nope for the reasons I explained last time.
> Sorry somehow I'm not able to find my previous mail chain.

If you reply like this after half a year, what can I say? Is that a
reason to ignore the feedback? No.

Just use the lore and find it:
https://lore.kernel.org/all/4fd9dabb-c8f3-b826-2eb2-ab8b5816102a@linaro.org/

> I had replied to your comment in the previous version of the mail.
> In this case alias id is used to differentiate between Ethernet instance 0 and 1 in the driver code.

NAK.

>>
>>>  	};
>>>
>>>  	cpus {
>>> @@ -882,6 +883,34 @@
>>>  			phy-mode = "rgmii";
>>>  			status = "disabled";
>>>  		};
>>> +
>>> +		ethernet_1: ethernet@14300000 {
>>
>> Do not add nodes to the end.
> If you mean to say that the nodes are supposed to be in the increasing order of physical address,
> I can see that the existing file is not arranged in that format. If that is required I can first fix the
> existing file and post the revised patch for the same. 

You can drop it in some place more or less matching its address, just
not to the end.

Best regards,
Krzysztof

