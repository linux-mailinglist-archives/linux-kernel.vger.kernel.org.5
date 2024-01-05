Return-Path: <linux-kernel+bounces-17438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59892824D3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7FB2873C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B13146B3;
	Fri,  5 Jan 2024 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWoQBvYO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040220E4;
	Fri,  5 Jan 2024 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d89105365so9954845e9.0;
        Thu, 04 Jan 2024 18:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704422915; x=1705027715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NvYkLm26S6ebwPqIbQIT9BDgD9vjodsxLj/e0wbDLwk=;
        b=XWoQBvYO8Pq0Vg5JmWbCBwuE1uhrgpZv8wwMmxDNH9SK6TBWt3DVGlGBIpiaCqewn9
         5WWWboXa5LnjZIRcQ8H83dJseSLF9UVZ7OZWxx/IPp4btVP/xdTPP+7x0IOqUQFV4ZuX
         pnhBkyKMXjiJXbrEOtlkj+gq+L7ngVF23vt2gJS8iGsLVq5Bbk7sWFdtN9csRDImU6LR
         IOW/G0SJJ8Sjkvq98RV2HCWJtTfiofASRwLJ/NyRqroCzPgQ1IZg67dXU5rwy9tmCt13
         y6AzV10JzYLJ10HY3hR3eJaCPYTnapTiqLLGERaS8tWunrtdcp+xqTsKDXY2ECZkGFGi
         Hetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422915; x=1705027715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvYkLm26S6ebwPqIbQIT9BDgD9vjodsxLj/e0wbDLwk=;
        b=lF+3nVnsqZY2Ln/nJYOn6dHGGvWF5kpcJsk80TCPBQJkSAM14AsPAby815Z0OoFdCb
         B9ZjDVZQ9LV7jkbjgQBEKnEUJOX4s4MGOtuUc77XW8jMF55VB0BnUkTlBVKpnTTEPNQ/
         0nAQ6Rdaa/y8MhLYaLpa5No7qwRqLQe68ooQMHVncZcGW5ku3g90M8mVSbXkTkLkihrP
         ZgA1LXpdJ7SJl76a0ZdJr1FHSzcOT/zxjIFwJEKe/CZzmSuiCjTcXvx52WDGraOvAQDj
         kLH5wwOhaFOk52ITHly79N/oA5+S9CesOCitH7ss5FNbXUSKm7IgYxzzn8OnvbNCan61
         TCew==
X-Gm-Message-State: AOJu0YxZkDop/C6lZYZlUCZyTfKy58sCgkrWCdEcbdPhCOhMt8t4zlKZ
	3fA2mdmOo67QcHgM24TOg24=
X-Google-Smtp-Source: AGHT+IFQYpb6XhVztccrIVV5NT+BYOjFLZbTTO4XD3l3MnGWntw1jBWyueNMvVQ++RD45u9wY+DtjA==
X-Received: by 2002:a05:600c:6a89:b0:40d:92c1:6760 with SMTP id jl9-20020a05600c6a8900b0040d92c16760mr842934wmb.179.1704422914792;
        Thu, 04 Jan 2024 18:48:34 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b0040d5f3ef2a2sm110523wmo.16.2024.01.04.18.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 18:48:34 -0800 (PST)
Message-ID: <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
Date: Fri, 5 Jan 2024 04:48:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Content-Language: en-US
To: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luo,

thank you for explaining the case in such details. I also have checked 
the related DTSs in the Linaro repository to be more familiar with the 
I/O mem layout. Specifically I checked these two, hope they are relevant 
to the discussion:
https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq5332.dtsi
https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq9574.dtsi

Please find my comments below.

On 03.01.2024 15:31, Jie Luo wrote:
> On 1/2/2024 7:01 AM, Sergey Ryazanov wrote:
>> Hi Luo,
>>
>> I have a few questions regarding the high level design of 
>> implementation. I hope that clarifying these topics will help us to 
>> find a good model for the case and finally merge a supporting code. 
>> Please find the questions below.
>>
>> On 25.12.2023 10:44, Luo Jie wrote:
>>> For IPQ5332 platform, there are two MAC PCSs, and qca8084 is
>>> connected with one of them.
>>>
>>> 1. The Ethernet LDO needs to be enabled to make the PHY GPIO
>>>     reset taking effect, which uses the MDIO bus level reset.
>>>
>>> 2. The SoC GCC uniphy AHB and SYS clocks need to be enabled
>>>     to make the ethernet PHY device accessible.
>>>
>>> 3. To provide the clock to the ethernet, the CMN clock needs
>>>     to be initialized for selecting reference clock and enabling
>>>     the output clock.
>>>
>>> 4. Support optional MDIO clock frequency config.
>>>
>>> 5. Update dt-bindings doc for the new added properties.
>>>
>>> Changes in v2:
>>>     * remove the PHY related features such as PHY address
>>>       program and clock initialization.
>>>     * leverage the MDIO level GPIO reset for qca8084 PHY.
>>>
>>> Changes in v3:
>>>     * fix the christmas-tree format issue.
>>>     * improve the dt-binding changes.
>>>
>>> Changes in v4:
>>>     * improve the CMN PLL reference clock config.
>>>     * improve the dt-binding changes.
>>>
>>> Luo Jie (5):
>>>    net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
>>>    net: mdio: ipq4019: enable the SoC uniphy clocks for ipq5332 platform
>>>    net: mdio: ipq4019: configure CMN PLL clock for ipq5332
>>>    net: mdio: ipq4019: support MDIO clock frequency divider
>>>    dt-bindings: net: ipq4019-mdio: Document ipq5332 platform
>>>
>>>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 141 ++++++++-
>>>   drivers/net/mdio/mdio-ipq4019.c               | 288 ++++++++++++++++--
>>>   2 files changed, 399 insertions(+), 30 deletions(-)
>>
>> I'm asking these questions because after checking the patches and 
>> following the earlier discussion, the series is looks like an 
>> overloading of the MDIO driver with somehow but not strictly related 
>> functionality.
>>
>>
>> First, let me summarize the case. Feel free to correct me if I took 
>> something wrong. So, we have:
>> - a reference design contains IPQ5332 SoC + QCA8084 switch/Phy;
> 
> IPQ5322 SoC is currently connected with qca8386(switch that includes
> QCA8084 PHY), the pure PHY chip qca8084 is currently connected on the
> SoC IPQ9574.

As far as I understand these chips have standardized interfaces and 
QCA8386/QCA8084 can be reused with another SoC(s) in future. As well as 
IPQ5332 can be used with different phy. So now we are talking about some 
specific reference design. Isn't it?

>> - QCA8084 requires a reference clock for normal functionality;
> 
> The reference clock is selected for the CMN PLL block, which outputs
> the clocks to the Ethernet devices including the qca8084 PHY for normal
> functionality, also for other connected Ethernet devices, the CMN PLL
> block is located in SoC such as ipq5332 and ipq9574.
> 
>> - IPQ5332, as a chip, is able to provide a set of reference clocks for 
>> external devices;
> 
> Yes, the CMN PLL block of IPQ5332 provides the output clocks as the
> working clocks for the external Ethernet devices such as the QCA8386
> (switch chip), the reference clocks we are discussing is as the
> reference clock source of the CMN PLL block.

Ok, I feel we have some ambiguity regarding the reference clock term 
here. Sure, CMN PLL needs a reference clock to functioning. And in the 
same time, the output clock provided by CMN PLL is a reference clock for 
QCA8384.

So, when I was talking about IPQ5332, I meant the whole chip including 
CMN PLL block. So, I asked about CMN PLL output clock. But you already 
clarified the SoC capabilities below.

>> - you want to configure IPQ5332 to provide the reference clock for 
>> QCA8084.
> 
> The reference clocks for CMN PLL block is configurable, and the output
> clocks of CMN PLL are fixed, the output clocks are 50MHZ, which is given
> to the external Ethernet devices.
> here is the topology of clocks.
>                     ---------
>                     |        |
> reference clock --->| CMN PLL|--> output 50M clocks --> qca8084/qca8386
>                     |        |
>                     ---------
>>
>>
>> So, the high level questions are:
>> 1. Is QCA8084 capable to consume the clock from some other generator? 
>> Is it possible to clock QCA8084 from external XO/PLL/whatever?
> No, the clock of qca8084/qca8386 is provided from the output clock of
> CMN PLL as above.

Right, in case of pairing QCA8386 with IPQ5332, it is a good option to 
provide the clock from the SoC. But in general QCA8386 will be Ok with 
any 50 MHz clock. Right? I would like to say that thinking about this 
specific reference design being a single possible combination limits a 
scope of driver implementation options.

>> 2. Is IPQ5332 capable to provide reference clock to another switch model?
> 
> Yes, IPQ5332 can provide the reference clock to all connected Ethernet
> devices, such as qca8386(switch), qca8081 phy and others.

Ok. Thank you for clarifying this.

>> 3. Is the reference clock generation subsystem part of the MDIO block 
>> of IPQ5332?
> 
> the reference clock of CMN PLL block can be from wifi and external xtal, 
> the CMN PLL is integrated in the MDIO block, CMN PLL is the independent
> block that generates the clocks for the connected Ethernet devices.
> 
>>
>>
>> And there are some tiny questions to make sure that we are on the same 
>> page:
>> a. What is the mentioned Ethernet LDO? AFAIK, LDO is some kind of gate 
>> (or switch) that enables clock output through an IPQ5332 pin. Isn't it?
> 
> That's correct, the LDO is for enabling the output 50M clock of CMN PLL
> to the connected Ethernet device, which is controlled by the hardware
> register on the IPQ5332.
> 
>> And if it's true, then can you clarify, what exactly clock is outputted?
> 
> the 50M clock is outputted to the external Ethernet devices.
> 
>> b. Is the Ethernet LDO part of the MDIO block of IPQ5332? According to 
>> iomem addresses that was used in the example reg property, the 
>> Ethernet LDO is not part of MDIO.
> 
> LDO is not the part of MDIO block, LDO has the different register space
> from MDIO, which is located in the independent Ethernet part.

I have checked the Linaro's DTSs and noticed that mentioned LDO 
addresses belong to a node called 'ess-uniphy'. So these LDO(s) are part 
of UNIPHY block. So far, so good.

>> c. Is the CMN PLL part of the MDIO block of IPQ5332? Again, according 
>> to iomem address, the CMN PLL is not part of MDIO.
> 
> No, CMN PLL is not the part of MDIO block, which is the independent
> block, but it generates the clocks to the connected Ethernet devices
> managed by MDIO bus, and the CMN PLL block needs to be configured
> correctly to generate the clocks to make the MDIO devices(Ethernet
> devices) working.

I came to the same conclusion checking Linaro's DTS. So the CMN PLL 
block looks like a small block implemented outside of any other block. 
Now I am starting to understand, why everything was putted into the MDIO 
driver. This PLL is so small that it doesn't seem to deserve a dedicated 
driver. Am I got it right?

>> d. Are GCC AHB & SYS clocks really consumed by MDIO itself? Or are 
>> they need for the external reference clock generation?
> 
> GCC AHB & SYS clocks are consumed by the uniphy(PCS) that is connected
> with the Ethernet devices, so we can say the GCC AHB & SYS clocks are
> consumed by the Ethernet devices, which is not for the external
> reference clock generation, external reference clock of CMN PLL are the
> fix clock that are from wifi or external XO.

Again this UNIPHY block. The UNIPHY node was missed from the upstream 
DTS, so it was decided to assign AHB & SYS clocks to MDIO. Right?

What do you think about implementing this clocks handling functionality 
in a dedicated driver (e.g. uniphy) and create a dedicated DTS node for 
it? This driver could consume AHB & SYS clocks as well as consuming CMN 
PLL clock and be a clock provider for the Ethernet PHY (e.g. QCA8336).

And looks like CMN PLL should be implemented as a dedicated micro 
driver. A driver that consumes fixed reference clocks (XO or from WiFi) 
and provides the clock to UNIPHY, to be passed to the Ethernet PHY by 
means of LDO gate.

>> To speed up the discussion, let me share my user's view of the 
>> reference clocks modeling. I would like to join the option that has 
>> already been suggested by the maintainers. It is better to implement 
>> reference clocks handling using the clocks API, and the clock 
>> subsystem will take care of enabling and configuring them.
>>
>> And considering the expected answers to the above questions, I would 
>> like to suggest to implement the clock handling using a dedicated 
>> clock controlling driver. Or even using several of such tiny dedicated 
>> drivers. So DTS will become like this:
>>
>>    ext_ref_clock: ext_ref_clock {
>>      compatible = "fixed-clock";
>>      clock-frequency = <48000000>;
>>    };
>>
>>    eth_cmn_pll: clock-controller@9b000 {
>>      compatible = "qcom,eth-cmn-pll-ipq5223";
>>      reg = <0x9b000 0x800>;
>>      clocks = <&ext_ref_clock>; /* use external 48MHz clock */
>>    };
>>
>>    phy0_ext_clk: clock-controller@7a00610 {
>>      compatible = "qcom,ipq-eth-ldo";
>>      reg = <0x7a00610 0x4>;
>>      clocks = <&eth_cmn_pll>;
>>    };
>>
>>    mdio@90000 {
>>      compatible = "qcom,ipq4019-mdio";
>>      reg = <0x90000 0x64>;
>>      clocks = <&gcc GCC_MDIO_AHB_CLK>;
>>
>>      ethernet-phy@1 {
>>        compatible = "...";
>>        reg = <1>;
>>        clocks = <&phy0_ext_clk>;
>>        reset-gpios = <&gcc ...>;
>>      };
>>    };
> 
> Thanks Sergey for the reference DTS.
> Since the GPIO reset of qca8084/qca8386 is needed before configuring the
> Ethernet device.
> 
> The configuration of and phy0_ext_clk(LDO) should be configured
> firstly, which enables the clocks to the Ethernet devices, then the GPIO
> reset of the connected Ethernet devices(such as qca8386) can take
> effect, currently the GPIO reset takes the MDIO bus level reset.
> 
> So phy0_ext_clk can't be put in the PHY device tree node, one LDO
> controls the clock output enabled to the connected Ethernet device such
> as qca8386.

I still feel lost. Why it is impossible to specify clocks and resets in 
the PHY node and then implement the initialization sequence in the 
QCA8386 driver? I read the discussion of the QCA8386 driver submission. 
That driver modeling also looks a complex task. But it still puzzling 
me, why a part of the QCA8386 driver should be implemented inside the 
MDIO driver.

--
Sergey

