Return-Path: <linux-kernel+bounces-41052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB9B83EAD1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CA41F25257
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD443125B0;
	Sat, 27 Jan 2024 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFu4WjlZ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653DBBE48
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 04:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328229; cv=none; b=WoV9E+eEMDVwpNooTP4JTLrNpNpPQEGSs3/l69NnYr7AFM+OkaHx45kHsTCSkL0Ang/Ms1cK2J6ThPzHPKsnGLP3mQFxYxPu+KWWS6PXDYOC7Btsaz5Qf8R5co7mgp5lCoBji6qyyyu92p2E70SSYsO4o38vlz/07IkSCtFCTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328229; c=relaxed/simple;
	bh=ibPIG32KDz5lkYlFOZqgY9Su1g2LgI59+9TH7QrBfEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRP6xBl6R3EMH/O2JDGdCqoERy+HOZn/aaGHnK0/OeRskaVCOxAHxy398PCOjKbBE46EC5Vw2izKpfT5x0vrOgNcbCRQCZ9VQWqGUTETBks34Pf0xyjANJxhb9gI3sKx/orcJGihDaPgZv9LqAp7L2SoNia5NYCxigJ3OhA2ZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFu4WjlZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51028fadfe2so1068158e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706328225; x=1706933025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AhVLIlzeBK5qY5g8wi502EuRXY3kZQUh5Yr30GtXoR4=;
        b=nFu4WjlZDPrhvPHRTRXGoWCZvXPAXEFAJ5KR1mKS7EdyGevpV/OYvS9P7A5sqQUU3Y
         EHjPb710IGSUsqbjZeU+UBPpioe/TQYEJBCbNj5aLC1bCtghJCwLY+EGpsMd0ndTMAUS
         15mi6Ob0p9usZTq8RQVKHukrMFRWSrwNPZhdMsNgB8DjdNHIn/jnnBzY5lpHs9yVsWdV
         9Ul+DcwrdZzWlKQ+/a14Ek6LNIH/+M7MksowT7UMXFEdCF+FGZ+zELetcHVS6TOTY2mb
         TZ6sqhCea/ViLAx7Ha19GGpEvl2/k6ut4DzuMZ9MVUaQNkC6aTXIhntrSGbHAzBax8L6
         7Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328225; x=1706933025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhVLIlzeBK5qY5g8wi502EuRXY3kZQUh5Yr30GtXoR4=;
        b=PKGjCWgh2AjFl8Npb1IZTsi4vPq7w9LAgAwe2/Yd36DBRL+fWZNB4tYmVoVUJcYWm3
         kiHoM33X7jkQLQsbIezAhdHGEUAZ1zWwTFttnA9erJTxdyHXIFQiDGMs1DU1v6dPCALq
         kepLAh4dsXY/GpK6/kUB+2kONfRvJJWvsTlCo+8WaHVih4DiKi3XTlc6tBE+Wig3/wQ4
         4gcvox9got2oyFAxnqRlK7YNGeuRZEZ/mMhf7naErO9Vy2nCdiPio5z4xcmFgEuDoVNY
         xT33edlzt3Jt37gTk5kMNt++Wpz74vuo7JrTObA0ul0LnDEP/vApprLntfjVLNMYvvwu
         rrrA==
X-Gm-Message-State: AOJu0Yzc6LkeBuiCvwJ6D8ecvPXQAN3Kye1vW89uSV5SLBU1Bu33z48A
	vQc9lULHj4HThs/hTr71kigAQQ29oiX04nYK10GnYuTyYOe4hCXn8wbZydUb+Cw=
X-Google-Smtp-Source: AGHT+IGqPf0Y4JlE0TDyayzJ4+4DkjB7KETghuDJrX0IvXWt4UWKxRjXEnwgnh8i1uo8NmohOi+woQ==
X-Received: by 2002:ac2:4c13:0:b0:50e:b65b:4944 with SMTP id t19-20020ac24c13000000b0050eb65b4944mr513639lfq.21.1706328225421;
        Fri, 26 Jan 2024 20:03:45 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id f19-20020a17090624d300b00a2f15b8cb76sm1298403ejb.184.2024.01.26.20.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 20:03:43 -0800 (PST)
Message-ID: <6ccf359a-faeb-485b-8047-fa61bb1a3fc8@linaro.org>
Date: Sat, 27 Jan 2024 04:03:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: exynos: gs101: use correct clocks for
 usi_uart
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, semen.protsenko@linaro.org,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org
References: <20240127003607.501086-1-andre.draszik@linaro.org>
 <20240127003607.501086-5-andre.draszik@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240127003607.501086-5-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/27/24 00:35, André Draszik wrote:
> Wrong pclk clocks have been used in this usi8 instance here. For USI
> and UART, we need the ipclk and pclk, where pclk is the bus clock.
> Without it, nothing can work.
> It is unclear what exactly is using USI0_UART_CLK, but it is not
> required for the IP to be operational at this stage, while pclk is.
> This also brings the DT in line with the clock names expected by the
> usi and uart drivers.
> 
> Update the DTSI accordingly.
> 
> Fixes: d97b6c902a40 ("arm64: dts: exynos: gs101: update USI UART to use peric0 clocks")
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index e5b665be2d62..f93e937d2726 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -410,7 +410,7 @@ usi_uart: usi@10a000c0 {
>  			ranges;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_USI0_UART_CLK>,
> +			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,

As I said in the previous email, I don't think this is correct. This is
just a heads up for Krzysztof to not pick these 2 patches yet. We'll
come back on this matter on Monday.

>  				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
>  			clock-names = "pclk", "ipclk";
>  			samsung,sysreg = <&sysreg_peric0 0x1020>;
> @@ -422,7 +422,7 @@ serial_0: serial@10a00000 {
>  				reg = <0x10a00000 0xc0>;
>  				interrupts = <GIC_SPI 634
>  					      IRQ_TYPE_LEVEL_HIGH 0>;
> -				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_USI0_UART_CLK>,
> +				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,
>  					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
>  				clock-names = "uart", "clk_uart_baud0";
>  				samsung,uart-fifosize = <256>;

