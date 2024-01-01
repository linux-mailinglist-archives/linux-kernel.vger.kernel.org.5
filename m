Return-Path: <linux-kernel+bounces-13956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 486CA8215E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 00:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4DA3B20F19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7AEEAED;
	Mon,  1 Jan 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQqx/0UY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF537E558;
	Mon,  1 Jan 2024 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d3ae326f6so97818675e9.3;
        Mon, 01 Jan 2024 15:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704150074; x=1704754874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrKm7t1i2mlLowjRCmL7V9GHjwmfua61oDjbd7rip80=;
        b=DQqx/0UYlfr55wa7cU1h6sxkEplK+2JAM51+/13rs+Y2jNd2BtkVOM6dtnMkTEqiaJ
         fP4eLEIfQ/K+p82A/9q2MwkbAIA3QoDUjzs6KLftDfnEXG9dUds7lBIW5K0qFODQNZH1
         P2Q2dOOO4oXVk9WPy16jJAv27F1erk+3779vAnAyeINalOnFkUZFa5Pu+oo9u7s4WcW9
         uGLiWA6TsGwkXhtX7ECccbxp83OHhnF1UbGhZPI4DmMDNM/thp3QxFziDo9JKa4cbkhM
         hrSicwWu6KPJ4yv3opvsGDPGP0ffKsDagMx5LNyZqOhq5L+UHdcWiYj0TNqP0wZE1DZE
         QSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704150074; x=1704754874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrKm7t1i2mlLowjRCmL7V9GHjwmfua61oDjbd7rip80=;
        b=l/hugZU8bpTem5V+ZQaIRIwQ5UTqM36S4Drfrvv8rEW09WzLm1FqppkGaq56qwVGvO
         yrQ5RaWjt54PJsbEhQtORDn4lQhBCOjIRn8HW1Sa9o7RT+pB8IlGg8DbrmLGEwsGl1/R
         atUj9dxFKIdFFqal63dBr9LCDBkTqP7JaFaEQ6S9o8ARgdbywcrq+s0DFihOAJk5tWxC
         /w1TbwO+ALuZqj7txGFwJOXXj/Ir1nNSFj+XDDa+uegI1YvuPihHGVJL9t8gR473GMn2
         HUYsqxN2A6Fi8aOeCjCvOLSsDQwNBsqpp0BkYW97dO4GdWdGfyBG0mOkNsc8Bq+FTa2d
         LdBw==
X-Gm-Message-State: AOJu0YwtP9dsz0DFGpSw8D7KO1G8oI3YNMjOPVEIN9/wRBc+9byonijU
	RcFF/8oqdt9FVDhhUsFGKE4=
X-Google-Smtp-Source: AGHT+IHashEg1mfq0osZfh9zZXl0d0jKyXaC+vbsJAPRObsYzSorC2ceK8zjo3kxj3JmUhBzyo/H8w==
X-Received: by 2002:a05:600c:5405:b0:40d:2dbe:b127 with SMTP id he5-20020a05600c540500b0040d2dbeb127mr9218413wmb.166.1704150073733;
        Mon, 01 Jan 2024 15:01:13 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0040c3953cda5sm50191307wmo.45.2024.01.01.15.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 15:01:13 -0800 (PST)
Message-ID: <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
Date: Tue, 2 Jan 2024 01:01:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Content-Language: en-US
To: Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20231225084424.30986-1-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luo,

I have a few questions regarding the high level design of 
implementation. I hope that clarifying these topics will help us to find 
a good model for the case and finally merge a supporting code. Please 
find the questions below.

On 25.12.2023 10:44, Luo Jie wrote:
> For IPQ5332 platform, there are two MAC PCSs, and qca8084 is
> connected with one of them.
> 
> 1. The Ethernet LDO needs to be enabled to make the PHY GPIO
>     reset taking effect, which uses the MDIO bus level reset.
> 
> 2. The SoC GCC uniphy AHB and SYS clocks need to be enabled
>     to make the ethernet PHY device accessible.
> 
> 3. To provide the clock to the ethernet, the CMN clock needs
>     to be initialized for selecting reference clock and enabling
>     the output clock.
> 
> 4. Support optional MDIO clock frequency config.
> 
> 5. Update dt-bindings doc for the new added properties.
> 
> Changes in v2:
> 	* remove the PHY related features such as PHY address
> 	  program and clock initialization.
> 	* leverage the MDIO level GPIO reset for qca8084 PHY.
> 
> Changes in v3:
> 	* fix the christmas-tree format issue.
> 	* improve the dt-binding changes.
> 
> Changes in v4:
> 	* improve the CMN PLL reference clock config.
> 	* improve the dt-binding changes.
> 
> Luo Jie (5):
>    net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
>    net: mdio: ipq4019: enable the SoC uniphy clocks for ipq5332 platform
>    net: mdio: ipq4019: configure CMN PLL clock for ipq5332
>    net: mdio: ipq4019: support MDIO clock frequency divider
>    dt-bindings: net: ipq4019-mdio: Document ipq5332 platform
> 
>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 141 ++++++++-
>   drivers/net/mdio/mdio-ipq4019.c               | 288 ++++++++++++++++--
>   2 files changed, 399 insertions(+), 30 deletions(-)

I'm asking these questions because after checking the patches and 
following the earlier discussion, the series is looks like an 
overloading of the MDIO driver with somehow but not strictly related 
functionality.


First, let me summarize the case. Feel free to correct me if I took 
something wrong. So, we have:
- a reference design contains IPQ5332 SoC + QCA8084 switch/Phy;
- QCA8084 requires a reference clock for normal functionality;
- IPQ5332, as a chip, is able to provide a set of reference clocks for 
external devices;
- you want to configure IPQ5332 to provide the reference clock for QCA8084.


So, the high level questions are:
1. Is QCA8084 capable to consume the clock from some other generator? Is 
it possible to clock QCA8084 from external XO/PLL/whatever?
2. Is IPQ5332 capable to provide reference clock to another switch model?
3. Is the reference clock generation subsystem part of the MDIO block of 
IPQ5332?


And there are some tiny questions to make sure that we are on the same page:
a. What is the mentioned Ethernet LDO? AFAIK, LDO is some kind of gate 
(or switch) that enables clock output through an IPQ5332 pin. Isn't it? 
And if it's true, then can you clarify, what exactly clock is outputted?
b. Is the Ethernet LDO part of the MDIO block of IPQ5332? According to 
iomem addresses that was used in the example reg property, the Ethernet 
LDO is not part of MDIO.
c. Is the CMN PLL part of the MDIO block of IPQ5332? Again, according to 
iomem address, the CMN PLL is not part of MDIO.
d. Are GCC AHB & SYS clocks really consumed by MDIO itself? Or are they 
need for the external reference clock generation?


Please answer these questions one by one and we will have a good basis 
to move forward.



To speed up the discussion, let me share my user's view of the reference 
clocks modeling. I would like to join the option that has already been 
suggested by the maintainers. It is better to implement reference clocks 
handling using the clocks API, and the clock subsystem will take care of 
enabling and configuring them.

And considering the expected answers to the above questions, I would 
like to suggest to implement the clock handling using a dedicated clock 
controlling driver. Or even using several of such tiny dedicated 
drivers. So DTS will become like this:

   ext_ref_clock: ext_ref_clock {
     compatible = "fixed-clock";
     clock-frequency = <48000000>;
   };

   eth_cmn_pll: clock-controller@9b000 {
     compatible = "qcom,eth-cmn-pll-ipq5223";
     reg = <0x9b000 0x800>;
     clocks = <&ext_ref_clock>; /* use external 48MHz clock */
   };

   phy0_ext_clk: clock-controller@7a00610 {
     compatible = "qcom,ipq-eth-ldo";
     reg = <0x7a00610 0x4>;
     clocks = <&eth_cmn_pll>;
   };

   mdio@90000 {
     compatible = "qcom,ipq4019-mdio";
     reg = <0x90000 0x64>;
     clocks = <&gcc GCC_MDIO_AHB_CLK>;

     ethernet-phy@1 {
       compatible = "...";
       reg = <1>;
       clocks = <&phy0_ext_clk>;
       reset-gpios = <&gcc ...>;
     };
   };

--
Sergey

