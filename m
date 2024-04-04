Return-Path: <linux-kernel+bounces-131208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B1898486
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBCA1F2A900
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C45757F5;
	Thu,  4 Apr 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Omc8JwnB"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B459B7F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224816; cv=none; b=kI6HC638AbLNvGfZci3MbAzRJHhG7virJcI8Wq+TIrRUMrljHKzupIwWMnL7mr4ZiY16NIpWd2S9ucO3gsziU+fRak/6YS5c2auoAWoRPABt0sa0KpYsW0FIerBlWyruHlawLF7Fl23FZChv+x2iK1p75nwBiSXWoIHC8gCfU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224816; c=relaxed/simple;
	bh=/Zv2Mmkyeknbs1cQs3cIQ1t1IUN6v39fcrntA/XgcZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCdwqd44rRvQ5vSys8qPKdeW9S+V/RfgXEmARZ4KND6KDUbKTVBsDfTSR0rr8YvMP8CqVJrMdZ9IhDck+2F8pEq9cHHFhUfzRX2WzOVA5h06dbVPaGkF80yxUBoISZt0X7kB6Yd7YsQO+jPlIdTdLXdwP1T4dqG//FY526e94oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Omc8JwnB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4644bde1d4so110283266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712224812; x=1712829612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PLemqlCVgdSk6fHHLXtaSYo8vRodhoKn4waofG0cC2g=;
        b=Omc8JwnBeoIKbndedzc/605jVynUCgcQ7rRFOQUOHOEWEu45s133KGuLMKbF5B7rN0
         c/uv2s2LcG7b/JhiAtjxRBR7UWXgXt1/Sx8G0YdG2aw2+Ge5L4vyug7VXMaGi59nmqhb
         U3Cx5WTKfyqA4sqSJoqiXkTpOBgG7aAEaPtdCmzi+KhANvQGKwWyp0udbmzpXYeVUxCe
         fsTWEzimSPS9aEKIAqfwhkKmspgDpDSN2IyEnysurW8EiZc5tT+xuuqxJKGGhahKbN2Z
         9o6JcUVwtVCv2gzflhYem8+vhTSgCQRTcINNyj7EnUBR1fExj85mXr0X6ZTCydfquWya
         mYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712224812; x=1712829612;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLemqlCVgdSk6fHHLXtaSYo8vRodhoKn4waofG0cC2g=;
        b=AD8bwCEQWxAjc4sYNceNdaAXh5I8PlHUHYPX8WJS7z/Fu+9Ch/SmAKIsDwvtz5s+rE
         ntZg3VrKOA6O0HL3Maw0kv/eQpvGsyfRwaGxO2cWMsucBD8Pf1t0Nj1K60mm0drD4nAL
         slFIdOA4oUi60OYr7aRVWPEzAmb3PY/K0XIBhLhfPP1SvqsdispVokA73A1yD58w5SFz
         lIPH7FDw8OdWrie9Y+RcC5lrjsfOJvwWIBzUPbIp3MQwziA80YIVZ1AvLoSN4qSCi8Fl
         Pytu9JA/bL4PN8Sja/5DkIk7FqYZGL2RwoZKmCz+/Tvs+mxqbuNyu6Fs2a9VlFrGh/Z9
         PB6g==
X-Forwarded-Encrypted: i=1; AJvYcCUV4GlmooYrDQNfSuuTrB5wvcx/fAHibghYPtIZ5tjmq0SX/1X7Sn6XZADDEAEIEWwV35r0fsMI7hetjJ6qYgCgDKQU0JEUM89zPlGK
X-Gm-Message-State: AOJu0Yzt1+fHG8sIAFs1Pe6TWJKot8WNVTS7nwsxy4QrzxZGXp/iU+vW
	3QXwUA47VCv0nHnnzruXELifmBDvDhG9zgZUa6PVMAT5OtA9Cp9nDS2mlLjoWmw=
X-Google-Smtp-Source: AGHT+IH3aNut1aQM1czCUuksasKGSfNmvmvxaL0dMKQ3yeF/mmfQCxRSAnuXsKxW+T2V2jB9s/kASw==
X-Received: by 2002:a17:906:a51:b0:a4a:aaa9:8b3b with SMTP id x17-20020a1709060a5100b00a4aaaa98b3bmr1070546ejf.77.1712224812361;
        Thu, 04 Apr 2024 03:00:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id js19-20020a170906ca9300b00a4e8353be19sm3361456ejb.224.2024.04.04.03.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 03:00:11 -0700 (PDT)
Message-ID: <903ad855-ab26-4ef3-80bd-249917056188@linaro.org>
Date: Thu, 4 Apr 2024 12:00:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62p: use eFuse MAC Address for
 CPSW3G Port 1
To: Siddharth Vadapalli <s-vadapalli@ti.com>, afd@ti.com
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
References: <20240404081845.622707-1-s-vadapalli@ti.com>
 <18eb0e55-38ad-44f9-90b7-1917d8c0d5bb@linaro.org>
 <75b53dda-23aa-4915-944a-4d9a619bd165@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <75b53dda-23aa-4915-944a-4d9a619bd165@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 11:12, Siddharth Vadapalli wrote:
> On Thu, Apr 04, 2024 at 10:43:04AM +0200, Krzysztof Kozlowski wrote:
>> On 04/04/2024 10:18, Siddharth Vadapalli wrote:
>>> Add the "cpsw-mac-efuse" node within "wkup_conf" node corresponding to the
>>> CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the compatible
>>> "ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations on these
>>> registers. The MAC Address programmed in the eFuse is accessible through
>>> the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree property
>>> points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver to fetch
>>> the MAC Address and assign it to the network interface associated with
>>> CPSW3G MAC Port 1.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>
>>> This patch is based on linux-next tagged next-20240404.
>>> Patch depends on:
>>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
>>> for the newly added "ti,am62p-cpsw-mac-efuse" compatible.
>>>
>>> v1:
>>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402094200.4036076-1-s-vadapalli@ti.com/
>>> Changes since v1:
>>> - Since "wkup_conf" is modelled as a "simple-bus" rather than being
>>
>> And maybe the hardware representation is not correct? What bus is it?
> 
> I will let Andrew comment on it. Andrew had posted a patch at:
> https://lore.kernel.org/r/20240124184722.150615-10-afd@ti.com/
> to convert an equivalent "main_conf" node for AM62 SoC to "simple-bus"
> from the existing "syscon".
> 
>>
>>>   modelled as a System Controller node with the "syscon" compatible,
>>>   directly passing the reference to the "wkup_conf" node using the
>>>   "ti,syscon-efuse" device-tree property will not work.
>>>   Therefore, I posted the patch at:
>>>   https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
>>>   in order to add a new compatible to be used for modelling the
>>>   CTRLMMR_MAC_IDx registers as System Controller nodes, thereby
>>>   allowing the existing "ti,syscon-efuse" property to be used.
>>>   Now, "ti,syscon-efuse" points to the "cpsw_mac_efuse" node within
>>>   "wkup_conf" node, with "cpsw_mac_efuse" being a "syscon" node.
>>>
>>> Logs verifying that the CPSW driver assigns the MAC Address from the
>>> eFuse based on the CTRLMMR_MAC_IDx registers at 0x43000200 and 0x43000204
>>> to the interface eth0 corresponding to CPSW3G MAC Port 1:
>>> https://gist.github.com/Siddharth-Vadapalli-at-TI/9982c6f13bf9b8cfaf97e8517e7dea13
>>>
>>> Regards,
>>> Siddharth.
>>>
>>>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 1 +
>>>  arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 5 +++++
>>>  2 files changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>> index 7337a9e13535..848ca454a411 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>> @@ -696,6 +696,7 @@ cpsw_port1: port@1 {
>>>  				label = "port1";
>>>  				phys = <&phy_gmii_sel 1>;
>>>  				mac-address = [00 00 00 00 00 00];
>>> +				ti,syscon-efuse = <&cpsw_mac_efuse 0x0>;
>>
>> Why this is not nvmem cell, like or efuses?
> 
> Since it belongs to the MMIO register set. You had recommended *not*
> using nvmem for such MMIO registers at:
> https://lore.kernel.org/r/48902771-5d3b-448a-8a74-ac18fb4f1a86@linaro.org/
> "nvmem is for non-volatile memory, like OCOTP and eFUSE. This is not for
> accessing regular MMIO registers of system-controller..."
> 
> Despite the "ti,syscon-efuse" property containing the term "efuse" in its
> name, it is reading the CTRLMMR_MAC_IDx MMIO registers. So I assumed that
> the existing approach which has been used on all K3 SoCs apart from this
> one, will be suitable for this SoC as well.

OK, I totally forgot we discussed this.

> 
>>
>>>  			};
>>>  
>>>  			cpsw_port2: port@2 {
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>> index a84756c336d0..df9d40f64e3b 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>> @@ -18,6 +18,11 @@ chipid: chipid@14 {
>>>  			reg = <0x14 0x4>;
>>>  			bootph-all;
>>>  		};
>>> +
>>> +		cpsw_mac_efuse: cpsw-mac-efuse@200 {
>>
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> I was following the convention that other mfd-syscon compatible nodes
> seemed to be using:
> https://github.com/torvalds/linux/blob/41bccc98fb7931d63d03f326a746ac4d429c1dd3/arch/arm64/boot/dts/ti/k3-am65-main.dtsi#L502
> The node is:
> dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0
> corresponding to the compatible:
> "ti,am654-dss-oldi-io-ctrl"
> which was added by commit:
> https://github.com/torvalds/linux/commit/cb523495ee2a5938fbdd30b8a35094d386c55c12

So if that one was wrong, then what? I don't know really what type of
device is it, but just because one contributor called it that way, does
not mean you should keep going. Maybe investigate why that contributor
did not decide to follow Devicetree spec recommendation?

Best regards,
Krzysztof


