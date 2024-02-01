Return-Path: <linux-kernel+bounces-47891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B614845439
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB191C25EBC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9415CD55;
	Thu,  1 Feb 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9Uap6oU"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3815B102
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780203; cv=none; b=WLkg7zSbN0X4s+GJeIqNQSPG3sohf20fOnY7owKNaOugW6NzJCt5HAyIDS63GE3OeHCBc7OoIrXZDBGxkrAq9iVnw61YQ18zllzyS3T+ENNK7KvnI4NgliL7l5ux87l4m0+NeKpPKuX3MVJ5/miOYdWOBOO++TC6oEZQR9kpxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780203; c=relaxed/simple;
	bh=VBJ3v7tZGm+k2N8ADxEK1r3ckzFwQWUh5/X8mvn9RBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3Q+7zLceQ8QGpwX6Ml1YRBYSU7bmLhjWRZmsVKT9RBrpUlBKXFNcWa+mBXKbIQ5uCoPVz5LV2OI25epvJQrLRVh5tcsTBGu7z206TXL1xFdG1OSsyK999uRJ6zhnYJEAP+lTrnVGnIlZOkX3bFZ1aNFa8qJwpbtYgUGum+Fs8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9Uap6oU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so87598966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706780199; x=1707384999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=poTuQf0LwQNiakczK1chklgkGLVMfrUoDvHBIrggrEc=;
        b=O9Uap6oU8H/FFBq/2aXvNc8Mc3Pgp7HbACN/cxnLdQB9UkkPftd5g64Upobh1Dk/Nm
         p4kx2LQmzYWdBCR2sb1tz76oa3xIfdwxB/DXCYgR225EHvOTbIrZz+ldxKl3AI7dXIs8
         6E0dvm81TIYHztNqL2OnLxo0yNa8k47tdE1VTrWnz/Ht9radGjvCmdMk7aBmOj86b6Kk
         y1nSTfefLfSe6QObe0oSfxsKsdC34vGX5bbDQq48Tdzup/nqDcZ6QcBjMv/7mrbO9TIf
         X38IgTD3XwIhpsjJGTd5EO4n37Yy8EUj5Nd9ORY2pkxHqCvp3+oMbbSTI17kWRAvA7C+
         tlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780199; x=1707384999;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poTuQf0LwQNiakczK1chklgkGLVMfrUoDvHBIrggrEc=;
        b=OdeI3gRZyhnDuim16OfeaeJQgEukFw11ezi1nIikLbVsIYRKM9TTE9vme4S+w4gFly
         SLXO+MRVudnnyWC6fIff0HB6NJ94tPn41TfjJwVOFmgCAVvh0ZA969cwoWzuTCqn5yMc
         MHlHOep2cDGLUApjcggPmAYcUE/6LWbpJlTpSQwmNNtqXNzlB3l1TjtrXh4CszQ32o9s
         6g1yEJOCUjYIwEMmtw+u/DWYe13wKNFHoQN349hal8q3GiE5jLQkH5vblpeJ/tfbKXbL
         u+jsvePeg+YJb4fijlx/1LLKwrvbIEL4EtD78M8fwO0KztpD3u/UCNzr/pUnqEbz40RU
         qUXw==
X-Gm-Message-State: AOJu0YyhUDWUBNf7OPdu0flynLNCCVkHtU/xQySppOoXpWZQaUe9ItUE
	l4xTz/ZX1/e8BNr0jkjLaG4WxfdT847nHDXo70Xp1sJavX7m3it1f//+NPzFmJA=
X-Google-Smtp-Source: AGHT+IElQ8/d4GLq3GOx5zQpFcggQ/15LvaFRwDCBRBrM0v2013xgeW8ql9X4WOe6h1VwivnkuqsHA==
X-Received: by 2002:a17:906:7f16:b0:a36:47d9:1c35 with SMTP id d22-20020a1709067f1600b00a3647d91c35mr2884287ejr.44.1706780199642;
        Thu, 01 Feb 2024 01:36:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWjDzvTr2BIqc0egXiReI2kXvxp8qEXSElKxpGISo3WO+j0Ix5B32p9BeeQJyWGvnHoC/I0RnKw+IE6RjTF+xifEep0kgf+7c8ZmktCmH+BCXhbU0Ux7T8gE3Sv1JolXa33jTNF9/XP9NMv1CmitIryH1zc68JkyPPi4kOhe04JRYzgtedHAqKrjbNQpM6W1Ik5yMWjRWLLoCU4zpcXUXqrOwk9oMBbNdI6uK1/5l5DJJLuGpvlH4GiWutax9xPGPWW1HnRrW0wn/T5xxHwjbyu2Pl6J+L0Bal/vNTpHrMtAWtFaTXJOLNYd64HcV+2mX54HylOo4bOEvRwO9ybmcLEh/+ny5yR0Y/aJTW3SufKyWsCtRK71I30ATQHgYQR3idJCdGDtgWVlJmPVYiAVN3MwSr+CGYiIFjl5zqQ9bQlpYxyOfQIj7NEft7ae/xyXbQjnxSbxq9E5kq0/pASDzY0mDoYVMdFbuj3QsOb/E8nr9IJpPE0yLjqdcBynOTQ6JOyde1ncAf1xFMP1U3xo146RZBxa/QIsB+eAwYqeSHH5Pf+XX3bRb8p3fxXufq0VYDoVmAc/FiZAz4apMYTlFRZSRx47jhFXObPcOYmdTMseczIPCuZ39NoPZF6mAVcsE8bIpw/dLzxaA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a353d1a19a9sm5929063ejc.191.2024.02.01.01.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:36:39 -0800 (PST)
Message-ID: <ca618c6e-ef29-4ee5-860f-68b48ebbeb9e@linaro.org>
Date: Thu, 1 Feb 2024 10:36:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/18] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-7-bcd00510d6a0@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131-mbly-clk-v4-7-bcd00510d6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 17:26, Théo Lebrun wrote:
> Add documentation to describe the "Other Logic Block" syscon.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 89 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 90 insertions(+)
> 

..

> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      system-controller@e00000 {
> +        compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> +        reg = <0x0 0xe00000 0x0 0x400>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x0 0xe00000 0x400>;

If there is going to be any resend:
1. ranges follows reg
2. Use lower-case hex

See DTS coding style.

> +
> +        clocks: clock-controller@2c {
> +          compatible = "mobileye,eyeq5-clk";
> +          reg = <0x02C 0x50>, <0x11C 0x04>;
> +          reg-names = "plls", "ospi";
> +          #clock-cells = <1>;
> +          clocks = <&xtal>;
> +          clock-names = "ref";
> +        };
> +
> +        reset: reset-controller@0 {

0 is before 2c, keep nodes properly ordered.



> +          compatible = "mobileye,eyeq5-reset";
> +          reg = <0x000 0x0C>, <0x200 0x34>, <0x120 0x04>;
> +          reg-names = "d0", "d1", "d2";
> +          #reset-cells = <2>;
> +        };
> +
> +        pinctrl: pinctrl@b0 {
> +          compatible = "mobileye,eyeq5-pinctrl";
> +          reg = <0x0B0 0x30>;

This looks incomplete. Your binding mentions children, so provide at
least one child.

> 

Best regards,
Krzysztof


