Return-Path: <linux-kernel+bounces-18443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0A825D9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77931F24612
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A83C28E7;
	Sat,  6 Jan 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv7bNaRO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3C1FAA;
	Sat,  6 Jan 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d4a222818so6155855e9.0;
        Fri, 05 Jan 2024 17:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704504247; x=1705109047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+LwwvTgXy+y50hXhTDzFaVo2soJwu1++LDN2TlQjOE=;
        b=gv7bNaROTNOEeOT4Dw4IIazFb2ymV+Cs+NsKhdhFsEstOP7U0x1goVAdhxL7ihW1Ae
         qXkWqH+sT+EqMbABQPi8NqQsorbAq32mNunefvu650NNgg4I1LuiQ0JK0yv7VulspOHX
         xh/SDLYUHRyGxxshtRWsTNnEd45CxTwFsWsIlvTrZl5bx+XVJ7Z/sc5TxnesYj3RJyTH
         aaTGik45zkwHoUTUKU6/Gr9/NgYJBqqLhgAEofwsbquNy86BddPWNmqdGThZHZYlm3K+
         qAfdHeJ2JWUscEOZ1Z9zCrMkdA/AjwKyOlZyVudrWXnJG0t9LpSwZU8Rj85kw4Ns6hwN
         fc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704504247; x=1705109047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+LwwvTgXy+y50hXhTDzFaVo2soJwu1++LDN2TlQjOE=;
        b=xDYBBgTM2o9wAlbhvjjtu1RX2qHLHCb440pUGZt3VyuHYLtoLkMiynFuxHFGOZVuTm
         kHEJX1UWw01XwzYPMa7kVeoi/akKSP3kqgYA89/j+wfYsXlrh2VwAREc8YDD0HSl7er2
         V4Ko/qFjgOfe5KUUEFztbStq1EI/fGCNYYrZG8wc0cRabGwflUT19VvJcIoYv78OV08T
         5zlGYQXZxnupsKTXHq2Fuph88pZA9X4Vwr/7Wb7eSYim0wPhAQpNlDsqiIUkviw19fYM
         LX5g+x8GF90rgKcShRW9Vx3SRqfDT/G95ewRk5kPcBlDlvYuVSRP88adqm7Mdb9VKZds
         g3RA==
X-Gm-Message-State: AOJu0Yx+CB8LIomHRL4DCmfz38uTc39AHC3UJdRzLoe9HMwiREIQZgWM
	/5mA9gdx5nFvYTcz1veLaPE=
X-Google-Smtp-Source: AGHT+IFkpguMwXGza55v35BMWdG0dcyUBko6M1Fn/IEd1zmonimpCsWkm5ruM4va+uoZsF1IZszGIg==
X-Received: by 2002:a05:600c:1712:b0:40e:3529:98d4 with SMTP id c18-20020a05600c171200b0040e352998d4mr120040wmn.80.1704504246486;
        Fri, 05 Jan 2024 17:24:06 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4bc3000000b00336843ae919sm2325192wrt.49.2024.01.05.17.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 17:24:06 -0800 (PST)
Message-ID: <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>
Date: Sat, 6 Jan 2024 03:24:03 +0200
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
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.01.2024 12:34, Jie Luo wrote:
> On 1/5/2024 10:48 AM, Sergey Ryazanov wrote:
>> thank you for explaining the case in such details. I also have checked 
>> the related DTSs in the Linaro repository to be more familiar with the 
>> I/O mem layout. Specifically I checked these two, hope they are 
>> relevant to the discussion:
>> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>
> Thanks Sergey for looking into this driver support.
>
>> Please find my comments below.
>>
>> On 03.01.2024 15:31, Jie Luo wrote:
>>> On 1/2/2024 7:01 AM, Sergey Ryazanov wrote:
>>>> Hi Luo,
>>>>
>>>> I have a few questions regarding the high level design of 
>>>> implementation. I hope that clarifying these topics will help us to 
>>>> find a good model for the case and finally merge a supporting code. 
>>>> Please find the questions below.
>>>>
>>>> On 25.12.2023 10:44, Luo Jie wrote:
>>>>> For IPQ5332 platform, there are two MAC PCSs, and qca8084 is
>>>>> connected with one of them.
>>>>>
>>>>> 1. The Ethernet LDO needs to be enabled to make the PHY GPIO
>>>>>     reset taking effect, which uses the MDIO bus level reset.
>>>>>
>>>>> 2. The SoC GCC uniphy AHB and SYS clocks need to be enabled
>>>>>     to make the ethernet PHY device accessible.
>>>>>
>>>>> 3. To provide the clock to the ethernet, the CMN clock needs
>>>>>     to be initialized for selecting reference clock and enabling
>>>>>     the output clock.
>>>>>
>>>>> 4. Support optional MDIO clock frequency config.
>>>>>
>>>>> 5. Update dt-bindings doc for the new added properties.
>>>>>
>>>>> Changes in v2:
>>>>>     * remove the PHY related features such as PHY address
>>>>>       program and clock initialization.
>>>>>     * leverage the MDIO level GPIO reset for qca8084 PHY.
>>>>>
>>>>> Changes in v3:
>>>>>     * fix the christmas-tree format issue.
>>>>>     * improve the dt-binding changes.
>>>>>
>>>>> Changes in v4:
>>>>>     * improve the CMN PLL reference clock config.
>>>>>     * improve the dt-binding changes.
>>>>>
>>>>> Luo Jie (5):
>>>>>    net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
>>>>>    net: mdio: ipq4019: enable the SoC uniphy clocks for ipq5332 
>>>>> platform
>>>>>    net: mdio: ipq4019: configure CMN PLL clock for ipq5332
>>>>>    net: mdio: ipq4019: support MDIO clock frequency divider
>>>>>    dt-bindings: net: ipq4019-mdio: Document ipq5332 platform
>>>>>
>>>>>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 141 ++++++++-
>>>>>   drivers/net/mdio/mdio-ipq4019.c               | 288 
>>>>> ++++++++++++++++--
>>>>>   2 files changed, 399 insertions(+), 30 deletions(-)
>>>>
>>>> I'm asking these questions because after checking the patches and 
>>>> following the earlier discussion, the series is looks like an 
>>>> overloading of the MDIO driver with somehow but not strictly related 
>>>> functionality.
>>>>
>>>>
>>>> First, let me summarize the case. Feel free to correct me if I took 
>>>> something wrong. So, we have:
>>>> - a reference design contains IPQ5332 SoC + QCA8084 switch/Phy;
>>>
>>> IPQ5322 SoC is currently connected with qca8386(switch that includes
>>> QCA8084 PHY), the pure PHY chip qca8084 is currently connected on the
>>> SoC IPQ9574.
>>
>> As far as I understand these chips have standardized interfaces and 
>> QCA8386/QCA8084 can be reused with another SoC(s) in future. As well 
>> as IPQ5332 can be used with different phy. So now we are talking about 
>> some specific reference design. Isn't it?
> 
> Not the specific reference design.
> You are right, these chips can be used with other SoC(s) with the
> standardized interfaces supported.
> 
>>>> - QCA8084 requires a reference clock for normal functionality;
>>>
>>> The reference clock is selected for the CMN PLL block, which outputs
>>> the clocks to the Ethernet devices including the qca8084 PHY for normal
>>> functionality, also for other connected Ethernet devices, the CMN PLL
>>> block is located in SoC such as ipq5332 and ipq9574.
>>>
>>>> - IPQ5332, as a chip, is able to provide a set of reference clocks 
>>>> for external devices;
>>>
>>> Yes, the CMN PLL block of IPQ5332 provides the output clocks as the
>>> working clocks for the external Ethernet devices such as the QCA8386
>>> (switch chip), the reference clocks we are discussing is as the
>>> reference clock source of the CMN PLL block.
>>
>> Ok, I feel we have some ambiguity regarding the reference clock term 
>> here. Sure, CMN PLL needs a reference clock to functioning. And in the 
>> same time, the output clock provided by CMN PLL is a reference clock 
>> for QCA8384.
>>
>> So, when I was talking about IPQ5332, I meant the whole chip including 
>> CMN PLL block. So, I asked about CMN PLL output clock. But you already 
>> clarified the SoC capabilities below.
> 
> Yes, Sergey.
> 
>>
>>>> - you want to configure IPQ5332 to provide the reference clock for 
>>>> QCA8084.
>>>
>>> The reference clocks for CMN PLL block is configurable, and the output
>>> clocks of CMN PLL are fixed, the output clocks are 50MHZ, which is given
>>> to the external Ethernet devices.
>>> here is the topology of clocks.
>>>                     ---------
>>>                     |        |
>>> reference clock --->| CMN PLL|--> output 50M clocks --> qca8084/qca8386
>>>                     |        |
>>>                     ---------
>>>>
>>>>
>>>> So, the high level questions are:
>>>> 1. Is QCA8084 capable to consume the clock from some other 
>>>> generator? Is it possible to clock QCA8084 from external 
>>>> XO/PLL/whatever?
>>> No, the clock of qca8084/qca8386 is provided from the output clock of
>>> CMN PLL as above.
>>
>> Right, in case of pairing QCA8386 with IPQ5332, it is a good option to 
>> provide the clock from the SoC. But in general QCA8386 will be Ok with 
>> any 50 MHz clock. Right? I would like to say that thinking about this 
>> specific reference design being a single possible combination limits a 
>> scope of driver implementation options.
> 
> Yes, from the view of qca8386(qca8084), any input 50M reference clock
> should be fine, but normally we should keep the same clock source for
> qca8386 and the connected SoC to avoid any pps offset.
> 
> For example, we also tried the crystal 50M as the reference clock of
> qca8386, since the SoC connected with qca8386 has the different clock
> source from qca8386, which leads to some packet drop because of the
> little bit of clock frequency shift.
> Normally we should keep the clock source of qca8386 same as the clock
> from the connected SoC.

Great, so we have to deal with solution that more or less following 
standards. So far, so good.

>>>> 2. Is IPQ5332 capable to provide reference clock to another switch 
>>>> model?
>>>
>>> Yes, IPQ5332 can provide the reference clock to all connected Ethernet
>>> devices, such as qca8386(switch), qca8081 phy and others.
>>
>> Ok. Thank you for clarifying this.
>>
>>>> 3. Is the reference clock generation subsystem part of the MDIO 
>>>> block of IPQ5332?
>>>
>>> the reference clock of CMN PLL block can be from wifi and external 
>>> xtal, the CMN PLL is integrated in the MDIO block, CMN PLL is the 
>>> independent
>>> block that generates the clocks for the connected Ethernet devices.
>>>
>>>>
>>>>
>>>> And there are some tiny questions to make sure that we are on the 
>>>> same page:
>>>> a. What is the mentioned Ethernet LDO? AFAIK, LDO is some kind of 
>>>> gate (or switch) that enables clock output through an IPQ5332 pin. 
>>>> Isn't it?
>>>
>>> That's correct, the LDO is for enabling the output 50M clock of CMN PLL
>>> to the connected Ethernet device, which is controlled by the hardware
>>> register on the IPQ5332.
>>>
>>>> And if it's true, then can you clarify, what exactly clock is 
>>>> outputted?
>>>
>>> the 50M clock is outputted to the external Ethernet devices.
>>>
>>>> b. Is the Ethernet LDO part of the MDIO block of IPQ5332? According 
>>>> to iomem addresses that was used in the example reg property, the 
>>>> Ethernet LDO is not part of MDIO.
>>>
>>> LDO is not the part of MDIO block, LDO has the different register space
>>> from MDIO, which is located in the independent Ethernet part.
>>
>> I have checked the Linaro's DTSs and noticed that mentioned LDO 
>> addresses belong to a node called 'ess-uniphy'. So these LDO(s) are 
>> part of UNIPHY block. So far, so good.
> 
> Yes, LDO is a part of uniphy block on IPQ5332.
> 
>>>> c. Is the CMN PLL part of the MDIO block of IPQ5332? Again, 
>>>> according to iomem address, the CMN PLL is not part of MDIO.
>>>
>>> No, CMN PLL is not the part of MDIO block, which is the independent
>>> block, but it generates the clocks to the connected Ethernet devices
>>> managed by MDIO bus, and the CMN PLL block needs to be configured
>>> correctly to generate the clocks to make the MDIO devices(Ethernet
>>> devices) working.
>>
>> I came to the same conclusion checking Linaro's DTS. So the CMN PLL 
>> block looks like a small block implemented outside of any other block. 
>> Now I am starting to understand, why everything was putted into the 
>> MDIO driver. This PLL is so small that it doesn't seem to deserve a 
>> dedicated driver. Am I got it right?
> 
> Yes, you are right. CMN block is a independent block, we just need to
> configure this block for selecting the reference clock and then do a
> reset, which is a simple configuration and the related output clocks
> to the Ethernet devices, so it is put in the MDIO driver currently.
> 
>>>> d. Are GCC AHB & SYS clocks really consumed by MDIO itself? Or are 
>>>> they need for the external reference clock generation?
>>>
>>> GCC AHB & SYS clocks are consumed by the uniphy(PCS) that is connected
>>> with the Ethernet devices, so we can say the GCC AHB & SYS clocks are
>>> consumed by the Ethernet devices, which is not for the external
>>> reference clock generation, external reference clock of CMN PLL are the
>>> fix clock that are from wifi or external XO.
>>
>> Again this UNIPHY block. The UNIPHY node was missed from the upstream 
>> DTS, so it was decided to assign AHB & SYS clocks to MDIO. Right?
> 
> Right, currently there is no UNIPHY node defined in upstream.
> 
>> What do you think about implementing this clocks handling 
>> functionality in a dedicated driver (e.g. uniphy) and create a 
>> dedicated DTS node for it? This driver could consume AHB & SYS clocks 
>> as well as consuming CMN PLL clock and be a clock provider for the 
>> Ethernet PHY (e.g. QCA8336).
> 
> As for AHB & SYS clocks, that can be consumed by the dedicated in the
> future uniphy driver, but it seem there is a sequence issue with
> qca8386(qca8084) as mentioned in the reply to your comment below.
> 
> Maybe we can enable these uniphy clocks in the GCC(SoC) provider driver?
> i am not sure whether it is acceptable by the GCC(SoC) provider driver.

I do not think that idea of putting the UNIPHY clocks into GCC is any 
better than putting its handling into the MDIO driver. UNIPHY and GCC 
look like belong to different chip blocks.

I just realized that the UNIPHY block is a MII (probably SGMII) 
controller. Isn't it? And I expect that it responsible more then just 
for clock enabling. It should also activate and perform a basic 
configuration of MII for actual data transmission. If so, then it should 
placed somewhere under drivers/net/phy or drivers/net/pcs.

>> And looks like CMN PLL should be implemented as a dedicated micro 
>> driver. A driver that consumes fixed reference clocks (XO or from 
>> WiFi) and provides the clock to UNIPHY, to be passed to the Ethernet 
>> PHY by means of LDO gate.
>
> the CMN PLL block can be realized as the independent driver.
> maybe this CMN driver can be put in the directory drivers/clk/qcom?

Yep, exactly.

As far as I understand, we basically agree that clocks configuration can 
be implemented based on the clock API using a more specialized driver(s) 
than MDIO. The only obstacle is the PHY chip initialization issue 
explained below.

>>>> To speed up the discussion, let me share my user's view of the 
>>>> reference clocks modeling. I would like to join the option that has 
>>>> already been suggested by the maintainers. It is better to implement 
>>>> reference clocks handling using the clocks API, and the clock 
>>>> subsystem will take care of enabling and configuring them.
>>>>
>>>> And considering the expected answers to the above questions, I would 
>>>> like to suggest to implement the clock handling using a dedicated 
>>>> clock controlling driver. Or even using several of such tiny 
>>>> dedicated drivers. So DTS will become like this:
>>>>
>>>>    ext_ref_clock: ext_ref_clock {
>>>>      compatible = "fixed-clock";
>>>>      clock-frequency = <48000000>;
>>>>    };
>>>>
>>>>    eth_cmn_pll: clock-controller@9b000 {
>>>>      compatible = "qcom,eth-cmn-pll-ipq5223";
>>>>      reg = <0x9b000 0x800>;
>>>>      clocks = <&ext_ref_clock>; /* use external 48MHz clock */
>>>>    };
>>>>
>>>>    phy0_ext_clk: clock-controller@7a00610 {
>>>>      compatible = "qcom,ipq-eth-ldo";
>>>>      reg = <0x7a00610 0x4>;
>>>>      clocks = <&eth_cmn_pll>;
>>>>    };
>>>>
>>>>    mdio@90000 {
>>>>      compatible = "qcom,ipq4019-mdio";
>>>>      reg = <0x90000 0x64>;
>>>>      clocks = <&gcc GCC_MDIO_AHB_CLK>;
>>>>
>>>>      ethernet-phy@1 {
>>>>        compatible = "...";
>>>>        reg = <1>;
>>>>        clocks = <&phy0_ext_clk>;
>>>>        reset-gpios = <&gcc ...>;
>>>>      };
>>>>    };
>>>
>>> Thanks Sergey for the reference DTS.
>>> Since the GPIO reset of qca8084/qca8386 is needed before configuring the
>>> Ethernet device.
>>>
>>> The configuration of and phy0_ext_clk(LDO) should be configured
>>> firstly, which enables the clocks to the Ethernet devices, then the GPIO
>>> reset of the connected Ethernet devices(such as qca8386) can take
>>> effect, currently the GPIO reset takes the MDIO bus level reset.
>>>
>>> So phy0_ext_clk can't be put in the PHY device tree node, one LDO
>>> controls the clock output enabled to the connected Ethernet device such
>>> as qca8386.
>>
>> I still feel lost. Why it is impossible to specify clocks and resets 
>> in the PHY node and then implement the initialization sequence in the 
>> QCA8386 driver? I read the discussion of the QCA8386 driver 
>> submission. That driver modeling also looks a complex task. But it 
>> still puzzling me, why a part of the QCA8386 driver should be 
>> implemented inside the MDIO driver.
> 
> Let me clarify the work sequence here.
> 1. configure CMN PLL to generate the reference clocks for qca8386(
> same as qca8084).
> 2. enable LDO and configure the uniphy ahb & sys clocks.
> 3. do GPIO reset on qca8386(qca8084), the GPIO reset is for chip,
> just need to do one GPIO reset on quad PHYs.
> 4. configure the initial clocks and resets, which are from NSSCC
> clock provider driver, the NSSCC is also located in qca8386(qca8084),
> these clocks and resets for all quad PHYs of qca8386(qca8084), which
> just needs to be initialized one time.
> 5. then the qca8386(qca8084) PHY capability can be acquired correctly in
> the PHY probe function.
> 
> Currently, The GPIO reset of qca8386(qca8084) takes use of the MDIO
> level GPIO reset, so i put the LDO enable in the MDIO probe function
> called before MDIO bus level reset.
> 
> To take your proposal, we can't use the MDIO bus level reset and MDIO
> device level reset from the MDIO bus framework code, we need to do
> reset in one PHY probe function, and the CMN driver and uniphy driver
> needs to be initialized before PHY probe function, CMN driver is fine,
> but it seems be not usual for uniphy(pcs) driver called before PHY probe
> function.

Thank you for this compact yet detailed summary. Now it much more clear, 
what this phy chip requires to be initialized.

Looks like you need to implement at least two drivers:
1. chip (package) level driver that is responsible for basic "package" 
initialization;
2. phy driver to handle actual phy capabilities.

In case of DTS, device enumeration on the MDIO bus will work like this 
(see __of_mdiobus_register() function):
1. will be probed all mdio node childs with 'reg' property;
2. will be probed all child nodes without 'reg' property;
3. in both cases 1 & 2 nodes will be probed sequentially and synchronously.

So, using two drivers (package level + phy) you can declare a node 
describing the package first, and then add per-phy nodes.

   ext_ref_clock: ext_ref_clock {
     compatible = "fixed-clock";
     clock-frequency = <48000000>;
   };

   eth_cmn_pll: clock-controller@9b000 {
     compatible = "qcom,eth-cmn-pll-ipq5223";
     reg = <0x9b000 0x800>;
     clocks = <&ext_ref_clock>; /* use external 48MHz clock */
   };

   uniphy: mii-controller@7a00000 {
     compatible = "qcom,ipq5332-uniphy";
     reg = <0x7a00000 0x20000>;
     clocks = <&eth_cmn_pll>;
     #clock-cells = <1>;
   };

   mdio@90000 {
     compatible = "qcom,ipq4019-mdio";
     reg = <0x90000 0x64>;
     clocks = <&gcc GCC_MDIO_AHB_CLK>;

     /* Package level node must be first, so it will be probed first */
     phy_pkg: multi-phy-controller@0 {
       compatible = "qcom,qca8084";  /* matches package-level driver */
       reg = <0>;                    /* value can be any */
       clocks = <&uniphy 0>, <&uniphy 1>, ...;
       reset-gpios = <&gcc 123>;
       qcom,phy-addr-fixup = <1>, <2>, <3>, <4>;
       #clock-cells = <1>;
     };

     phy1: ethernet-phy@1 {
       compatible = "ethernet-phy-id004d.d180"; /* matches phy driver */
       reg = <1>;
       clocks = <&phy_pkg 321>;
     };

     phy2: ethernet-phy@2 {
       compatible = "ethernet-phy-id004d.d180";
       reg = <2>;
       clocks = <&phy_pkg 322>;
     };

     ...
   };


And inside the package-level driver ("qcom,qca8084") you can easily 
request clocks from the kernel using the regular clock API. Request GPIO 
line, etc. And then perform any initialization sequence required by 
QCA8084. As soon as common initialization is done and PHY addresses are 
configured, return from the probe callback.

Then MDIO devices enumeration code will continue the enumeration 
process, find a next node, what will be PHY1, PHY2, etc.

I hope I understand the case correctly and this brief description and 
example DT will give some clues as to a possible solution.

--
Sergey

