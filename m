Return-Path: <linux-kernel+bounces-47837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952C845385
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B1D1F290C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82FC15AADD;
	Thu,  1 Feb 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUNwUqYb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48415AADE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778817; cv=none; b=YpcM+9ebjI10V/T/+ogEBpWIJJ0W9uG/fwAR90aoFT3vLYaZDRSGMKNoXhFa7U2Ybs02QxkuLRhMgrPFmxOXaXgUETNwlbomjtYiqVnFy/4TMVSIrVwPqLywufEujmuE6mQLdKuwK12P/yCJMswWwZCAYZsozqoiIkiSwGhvQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778817; c=relaxed/simple;
	bh=EXlxsw0xqSjeNDi02pBDKRQOcESkn5FmTw1AInyjnJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnwkyzT3bO1NLxj2f9kc/YH4RpRUCdZ8pFr/AXVLA/UXBFKfEAKoJO8klvHUnYXbV0TB5ZIA/+ZlAqNPjlXeTA9NT/s72u+bnQpdNP4vPzVVhGaqXT9v59TowiIwPHrYiEHNbkfCYQ+Ctt/8fTBXr5ZvE8kgbzlosrPGthEds8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUNwUqYb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55fc06c0dbeso325022a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706778813; x=1707383613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVBkwdIPyLUypbilq6LG32fGQrEMtBwFKfcA1+LPZ58=;
        b=fUNwUqYbjQlTWatZ5r4Z7ct+5gAud5+uXTDBoMcJ960NOfCSthPuYAbJVaa4djsqeF
         nJ74z4H/6gVgjellaPfDlM5F8ZBNpbxJxZETNgyhmUAf5MdeTM2iGn3tcdP+Nv6yn37y
         SCxoXiSNGzW57+MzvZfWQ6E/kPJV26pKGDRN/LSKvqbH3WeosxMA38VHo/Op5o63EOjA
         L9imkOh4JRYsnE9VUkC2nEvnByibSx2AbvLyD7G/o75sVR+pPtrVONPnKnxCofCh8wx3
         8W5eRBYNFn+2z3gr2OLRUv3hDJIZW57XuY4XeUd8CPN3uwtk5EsFR6kFJ7Vf7d7D3T8U
         O4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778813; x=1707383613;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVBkwdIPyLUypbilq6LG32fGQrEMtBwFKfcA1+LPZ58=;
        b=T/I5M9qDBieP2P7sceVeMqeTjSAfroIl4EuhUtw4byj1DssIhgAowqGyxNaQWmo1Nm
         fRXua+pUMc1bDSi1sO1SKg30ApCCpcbl0ShqMYN8PthpkswEc6Ul8OPR74/eLwjYxxlX
         rOSjsZ1cDBsj08Cac4eVGSiDCuYfdNBtFOsxa5ojOkEE3mXZ6XVFwPeAn7sGvkZ9e4mC
         R4i9fpgxJrbSw+Od3Os+2VYSl6J7DIugQYgImfCnGnLKQ0ebuDMHfmgwtWX3uJpyYC1Q
         PDzs23PWlXAtvK3bY3EoEz330siL3DAgu6qbE32IMiDuLsTgGVMJssEBcMlYWgNDYqLH
         evbg==
X-Gm-Message-State: AOJu0YyPVyGXkdM/cK0K+yEaW63WI4qkmBwpWHacZaOHW25hVqQMucTt
	VMNarBbR5xS7sAOwLaM7ZwFsC/RlpEKYEyEctUrnE53Fj6ltBOc7iLFq/MkFZLI=
X-Google-Smtp-Source: AGHT+IE4qnm2DIQsSgmPSzKp1c6qW7MxR8EbRnV04IPJh6u8tkzlDCS687XiAx+TKbL7abrOQjh3Ug==
X-Received: by 2002:a17:906:806:b0:a35:8d47:70a with SMTP id e6-20020a170906080600b00a358d47070amr2877746ejd.36.1706778813652;
        Thu, 01 Feb 2024 01:13:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXC/YFbKMImqTMzScpqUK9HZa0xsbhGtNvzJ+9fiI5jrpAt5WkFxCu7CW1um1cPIhWJ5j7kqCoMzyg2T54VqEtcB3/pOi2RmPMrLyGoO/We7EPgI93wAE3o2dOsujk++D+c8GXbLOgTaj1+GQvKlEjhxdejELD7yccQiGy7r1xYfX7Tp5DUYcbG7/aVX56EJra7HtGXJYy//503X5s+TjfEys7kX+E0yMYmqu84KfPwIIaAeURvzVCk3Y0VfsfEiYaCbHNSvs45MErdSVHTp/7VTC/lQamqAn9xDpzBwWJb4HyKE+gYKCEmz8+H3ACE+yHc2/zmNEa60WqEEJWZdl3tu2GXB58eDcsxUoJolJlx3KcmVvv/ijQkXN1ecfGxdKUQLdC0jlbcZynjoPAgoABkgwcqZy6NPbGd8qyzOczCedJE8NC2/gEEsAhufs0Tae8p/yJ3paaUShCW1NqpjzR85kUtkK8/CJkpF7U0ixpwUD04CoT6O2pkvrzI8vnqK+eh7ZDgP/vOlCrMKJP4iSSX7bhOAJQJD3mRfqml9+oVqF8KKJSWQQ4IOmzBBpjxmN7Vo9vKCGRYL4kNNMT/61sf1wMSWvizlQCcEM5DqpzgFW76B6hNJGrbWDMzhyb8C1HzkZn9Ooyqw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu3-20020a170906ba8300b00a368903fc98sm1165092ejd.136.2024.02.01.01.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:13:33 -0800 (PST)
Message-ID: <3f3b1665-30d4-4581-84a8-7894a4a03b93@linaro.org>
Date: Thu, 1 Feb 2024 10:13:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/18] MIPS: mobileye: eyeq5: add reset properties to
 UARTs
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
 <20240131-mbly-clk-v4-16-bcd00510d6a0@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131-mbly-clk-v4-16-bcd00510d6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 17:26, Théo Lebrun wrote:
> UART nodes have been added to the devicetree by the initial platform
> support patch series. Add reset properties now that the reset node is
> declared.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  arch/mips/boot/dts/mobileye/eyeq5.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> index 06e941b0ce10..ece71cafb6ee 100644
> --- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> +++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> @@ -78,6 +78,7 @@ uart0: serial@800000 {
>  			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks  = <&uart_clk>, <&occ_periph>;
>  			clock-names = "uartclk", "apb_pclk";
> +			resets = <&reset 0 10>;

You touch the same file. Squash the patch with previous one. It's the
same logical change to add reset to entire SoC. You don't add half of
reset, right?

Best regards,
Krzysztof


