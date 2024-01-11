Return-Path: <linux-kernel+bounces-23578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9282AE98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07021C211AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF215ACE;
	Thu, 11 Jan 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZwpg6ff"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D815AC4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd8bd6ce1bso4179531fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 04:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704975618; x=1705580418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F040GXsz7aRwgMvtBRucVujHPaJzjQl/6qLu2uyGLh8=;
        b=iZwpg6ffXiRObStYf9SKqBFE/RQd/cbaqWR97Ent+dmafKGZpbNfQU635M5VxXHpuT
         Eu0w7nM/Uh6IXBGr5bBrmb7V8Irc2iXnQjtKSIkw0+wf2heBzQanSeY1h3enPWxCTEO5
         s/mxKYrcmINiMIwm5BkWBJ68VJOg8MK3vMb0UvZSvHQ/UCyqB6VEaJW02Q0ymHOnOwWl
         +UikUKDUzbiOyeiM4ZUl/qhmuhKpNIys2UjpVPuTxONUu1b6rgTYbUY05A4IKLCMaIdd
         ihNyGCS7MvrLf0+zKvufX6dlXV1DgfaGk47WhEtaPGO1PMCXqsR82ZHZUjLV4D7wKN4y
         iekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704975618; x=1705580418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F040GXsz7aRwgMvtBRucVujHPaJzjQl/6qLu2uyGLh8=;
        b=IWtlYX+Ho+XXy1S49zHXkBmVOOzTa7UfZTh8tsXPPx2qhXdf/oc98EuSNZJBuYPsB0
         Jrn9tVVnQz0fCNUfTt6ap6mf9KNo389AT+02+KgedOt6BvcKice1VZCYo2C4DnpRZS54
         ztFlRYt1V401bEYZuW6rqrMEqLcpRAjLxGdbb23HS8vR75X86T5ywh89B6Yxy8Xxizc2
         fymZhXwQi52M8QwRNMrA48CW6jsol7JjvBkmVH1ihGcGNDSQpoVyQ4coU8V9+sXkWjCc
         0mVKpSsGgtFQDEfQ4rBmJPRT5v5j9AT8yRcXp+5Ibr4IfLdO+zqGqz6eBNVdUvhwyw8e
         X0og==
X-Gm-Message-State: AOJu0YwPl5xQ6eNjWlTL+wWXP8XdK0zorZ+Sahe5/YqsrEpxe397vVe4
	HIolR4LRAgPT4R3j+fJPyfn0JX/e+Fk7QA==
X-Google-Smtp-Source: AGHT+IHBrXffXq3Iy0z3sPhEatUN4tzY0PObMQGMO6VcrV3VZAerTte6eD3Ee5riS9A4t1J28qefIA==
X-Received: by 2002:a2e:8896:0:b0:2cb:2c91:e174 with SMTP id k22-20020a2e8896000000b002cb2c91e174mr259502lji.27.1704975618626;
        Thu, 11 Jan 2024 04:20:18 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n25-20020a2e7219000000b002cc83210f65sm126181ljc.89.2024.01.11.04.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 04:20:18 -0800 (PST)
Message-ID: <ccd791a2-a070-4433-b86d-5c6135e8962d@linaro.org>
Date: Thu, 11 Jan 2024 13:20:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sc8280xp: camss: Add CCI
 definitions
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org>
 <20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-3-b8e3a74a6e6a@linaro.org>
 <4f8aafa2-2145-4090-afba-8a26242d5ac3@linaro.org>
 <c98a234d-3c4a-43bd-b26b-52cd72588cc7@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c98a234d-3c4a-43bd-b26b-52cd72588cc7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/11/24 12:46, Bryan O'Donoghue wrote:
> On 10/01/2024 11:03, Konrad Dybcio wrote:
>>
>>
>> On 1/9/24 17:06, Bryan O'Donoghue wrote:
>>> sc8280xp has four Camera Control Interface (CCI) blocks which pinout to
>>> two I2C master controllers for each CCI.
>>>
>>> The CCI I2C pins are not muxed so we define them in the dtsi.
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 307 +++++++++++++++++++++++++++++++++
>>>   1 file changed, 307 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> index febf28356ff8..f48dfa5e5f36 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -3451,6 +3451,169 @@ usb_1_role_switch: endpoint {
>>>               };
>>>           };
>>> +        cci0: cci@ac4a000 {
>>> +            compatible = "qcom,sc8280xp-cci", "qcom,msm8996-cci";
>>> +            reg = <0 0x0ac4a000 0 0x1000>;
>>> +
>>> +            interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
>>> +
>>> +            clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
>>> +                 <&camcc CAMCC_SLOW_AHB_CLK_SRC>,
>>> +                 <&camcc CAMCC_CPAS_AHB_CLK>,
>>> +                 <&camcc CAMCC_CCI_0_CLK>;
>>> +            clock-names = "camnoc_axi",
>>> +                      "slow_ahb_src",
>>> +                      "cpas_ahb",
>>> +                      "cci";
>>> +
>>> +            power-domains = <&camcc TITAN_TOP_GDSC>;
>>> +
>>> +            pinctrl-names = "default", "sleep";
>>> +            pinctrl-0 = <&cci0_default>;
>>> +            pinctrl-1 = <&cci0_sleep>;
>>> +
>> property-names goes below property-n, just like with clocks 10 lines
>> above :/
> 
> Didn't you ask for this to be re-ordered ?

Sorry, I probably had the property ordering in mind.. that definitely
came out as confusing.

Konrad

