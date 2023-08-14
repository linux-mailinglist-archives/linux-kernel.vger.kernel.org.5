Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D677C117
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjHNTxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjHNTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:52:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A610E5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:52:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso70018761fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692042750; x=1692647550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFPHil3VN5VwOd9/RmmBPUpBPRF2hJNyEcrMRkz91WI=;
        b=Nam9WGvo4nse9P/4+o9yT+MKRo93lZvZHbPhUqsCqsxSqC+5apKdj4HhJzfvLLqHi7
         LfY6GPUnphqbJeVm/ixnvHQwSBHw0x1nfKrOSX/IhAqh0FtC5m6PPFydxki0FhFMGswh
         PiZQqa2aBx+KPbQKn/XEj/0AiId1qtcEmYdh9J2Ccm5j3gaEj8xsXSEGC1Sjzo6sMSCj
         DLScG5MqrwHCBXSrrPIZ8SirEkOqxF7p8xSoY/rR1f1uV0GXQtLqstc8L6zKQSnfRqNW
         p+H2gPpJJIoS2GIwDnWKI9ue0iA1EqbMCGMAjuUj6YdqzJYrOs6MbJAh4xRZwycyr8uX
         Pdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042750; x=1692647550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFPHil3VN5VwOd9/RmmBPUpBPRF2hJNyEcrMRkz91WI=;
        b=bx3dioeV232Q+Q3sYsQYNobgIeYEHWQZl/wkd64recbfUdJ5DWAwL81pkR7xvbpU8q
         IPGLofcHvE9Z8Dckhtk+WHL443B6a9x0bvICWGuRTT7C70XsI5Dol0P//57B/b7c601X
         gRD7MoxgFb0ZAIxDFTr5Xng8eDQ+tIaUCRw9AScQT/AK8Pu8HKHORQoTWTbQvgAvAEV8
         h3+8nUoKpLdUYR4JU1xvogn4c+Q0+rKv7IIB7OFOZF8avmD4ynP0N76VrcdKOgo4zjqy
         G4Aagq5FwyOtNXQLMptC/FCxaHtn9zkHMiQ6cnz02xfiZRiVdK72lhSgUBZdobiDN6nq
         tY7g==
X-Gm-Message-State: AOJu0YzwY5VOoJqKYfey7jCVBcpcAwp6ZrjYSnhS7UlNwwwF5n72ZHMD
        FwA6p7nCC9LzMomNgfdiwXU5UA==
X-Google-Smtp-Source: AGHT+IGk2WlvhxtBGwqxOHsyQt43Gr+unp4SPvZqT4Q4QVuwozdHl+Yvgtrlo/0sKdCp5JEZFiCN6g==
X-Received: by 2002:a2e:96d4:0:b0:2b9:4492:1226 with SMTP id d20-20020a2e96d4000000b002b944921226mr7726372ljj.11.1692042750567;
        Mon, 14 Aug 2023 12:52:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906110b00b00977cad140a8sm5980721eja.218.2023.08.14.12.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:52:30 -0700 (PDT)
Message-ID: <5319fd76-8ac3-18ce-4065-d90bca29a54e@linaro.org>
Date:   Mon, 14 Aug 2023 21:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
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
 <CGME20230111075450epcas5p3f13b94bfeaa66d386aa51f87ca4ec5bf@epcas5p3.samsung.com>
 <20230111075422.107173-4-sriranjani.p@samsung.com>
 <2590a514-81f7-1876-c43b-80c8abe40cf9@linaro.org>
 <000001d9ce98$bbaedb90$330c92b0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000001d9ce98$bbaedb90$330c92b0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 12:18, Sriranjani P wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 12 January 2023 15:05
>> To: Sriranjani P <sriranjani.p@samsung.com>; davem@davemloft.net;
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> alexandre.torgue@foss.st.com; peppe.cavallaro@st.com;
>> joabreu@synopsys.com; mcoquelin.stm32@gmail.com
>> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; pankaj.dubey@samsung.com;
>> alim.akhtar@samsung.com; ravi.patel@samsung.com; Jayati Sahu
>> <jayati.sahu@samsung.com>
>> Subject: Re: [PATCH v2 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
>> Block of FSD SoC
>>
>> On 11/01/2023 08:54, Sriranjani P wrote:
>>> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP,
>>> one in FSYS0 block and other in PERIC block.
>>>
>>> Adds device tree node for Ethernet in FSYS0 Block and enables the same
>>> for FSD platform.
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
>>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>>> ---
>>>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
>>>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56
>> ++++++++++++++++++++++
>>>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 22 +++++++++
>>>  3 files changed, 87 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> index 1db6ddf03f01..ca0c1a28d562 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> @@ -30,6 +30,15 @@
>>>  	};
>>>  };
>>>
>>> +&ethernet_0 {
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
>>> index d0abb9aa0e9e..7ccc0738a149 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>> +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>> @@ -64,6 +64,62 @@
>>>  		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
>>>  		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
>>>  	};
>>> +
>>> +		eth0_tx_clk: eth0-tx-clk-pins {
>>
>> Wrong indentation.
> Will fix in the next version.
>>
>>> +		samsung,pins = "gpf0-0";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth0_tx_data: eth0-tx-data-pins {
>>> +		samsung,pins = "gpf0-1", "gpf0-2", "gpf0-3", "gpf0-4";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth0_tx_ctrl: eth0-tx-ctrl-pins {
>>> +		samsung,pins = "gpf0-5";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth0_phy_intr: eth0-phy-intr-pins {
>>> +		samsung,pins = "gpf0-6";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
>>> +	};
>>> +
>>> +	eth0_rx_clk: eth0-rx-clk-pins {
>>> +		samsung,pins = "gpf1-0";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth0_rx_data: eth0-rx-data-pins {
>>> +		samsung,pins = "gpf1-1", "gpf1-2", "gpf1-3", "gpf1-4";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth0_rx_ctrl: eth0-rx-ctrl-pins {
>>> +		samsung,pins = "gpf1-5";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
>>> +	};
>>> +
>>> +	eth0_mdio: eth0-mdio-pins {
>>> +		samsung,pins = "gpf1-6", "gpf1-7";
>>> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
>>> +		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
>>> +		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
>>> +	};
>>>  };
>>>
>>>  &pinctrl_peric {
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> b/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> index f35bc5a288c2..ade707cc646b 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> @@ -32,6 +32,7 @@
>>>  		spi0 = &spi_0;
>>>  		spi1 = &spi_1;
>>>  		spi2 = &spi_2;
>>> +		eth0 = &ethernet_0;
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all requested
>> changes or keep discussing them.
> Sorry somehow I'm not able to find my previous mail chain.

Why? It is in the lore. I think this proves that responding after half a
year make it difficult for both reviewer and submitter.

> I had replied to your comment in the previous version of the mail.
> In this case alias id is used to differentiate between Ethernet instance 0 and 1 in the driver code.

Nope. Aliases are per board, not per SoC, so how is this supposed to
work if we number them reversed (1->0) in another board?

Best regards,
Krzysztof

