Return-Path: <linux-kernel+bounces-69754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8AC858E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760451F22218
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452A1CF80;
	Sat, 17 Feb 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HqUo6A9U"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E091BC5C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708159198; cv=none; b=ZGC2xjytTpQISz8q/Xfu7ZMgc0gQOGt/txt6iaEN7zXT94+zPm5WXtqjLXEXAz+pWf/7l2zD3JHVvbSggpDOdOvzstSmymxNP5CUDETCTJlEj/+2D1CIyodnOvHNMi6K0cjYTtCMi8F+SNNKw4COAlHUx/+qDkTnzf97k7oCvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708159198; c=relaxed/simple;
	bh=IX0qrK1/QseELipebrOaV9eTrTWOg4XYGR3lEj8VZb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7OoAjJgP9lmyc/4NV6PzckS5C3it+ADYL05NAHiG6SZNOSSoOtqj1r0akXVwQX0vDwB0vsJnzOsIHS/SkzFOWfTzMpfSUq1hWUsmF9EetyTevAcniOT6dXZincn0fZNB5UdjzW06029wtAdRpgL7XYBw0oVzhOhx5g6U8VO6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HqUo6A9U; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5116b540163so2482861e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708159194; x=1708763994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTknjKPDGr7oASNHeHI2dPjCHur74JiO2aFb8Uy4tB4=;
        b=HqUo6A9UfjCPV6H9Lsh6PbOdb2MWqPVUH4GsLn53VtGl+any0U8tWJRRvrXSd4tnBP
         0h8KYYonvUrna0ECsMjBUdfJPaHI4H0t/bO8M6FPoZS3gOALXJgGKnlJlEUPvyJHh3Tp
         idsYI+sSHSEnJ09RnWxlISdOGREl9aBw+lXBxhy1ur49l4FRE7y58DMmOQNw9r5F7Lgd
         Un+Ape0+nZgaAu8b6tfzsQS/JbF70p2TM6jEPDBo4JH/bfgUE+FxPGvaQAkItNCOSxob
         LtNXYQ4QH4rszEPPj4lGPVwrjd40shVLT7YMS1UNs9nb2MjIrRzheMj4Ia2XYA0k7k2U
         iIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708159194; x=1708763994;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTknjKPDGr7oASNHeHI2dPjCHur74JiO2aFb8Uy4tB4=;
        b=L+xqu4f1tnGU4IzifzmN8E6CzHm4RIynADWOPT5uWNrU0X/ZYH4URsOwaTzTtcvFk0
         rNIe6r7Ulf2oprGbJO3QDjvafipB/Ee4PT4nGLeevgj/dSr/1Nj2o2WUp7wkI1/ss5X/
         whkXxdd2aO4ISFIHM+SdsfPBIThTXNOwS2b44OrfUmZtsuk1y1hd6XlA3pV6X6oiJIVs
         mAi7eWqb5VWQUWALYsLf4Q4nVUGd5KINMGy4aC+XOvaWBTupiQSjXY0JTKhfBsw5aic3
         1mjQADbQFf1UVVcJwwXJ2zZ2VGYRsG6H/G1c/Fe+rDKJkogXOZNyz/8031lXNU/CxRCl
         X7LA==
X-Forwarded-Encrypted: i=1; AJvYcCUmjHEUikGMfH7WcKsXhJSnxIw1Kx82FN6VX3cddExp8MkOSBdwR904K/MG0WgWEAAcsjE8ccXBY52eUQucA1WQ6FlcVvjzX3IqxXyF
X-Gm-Message-State: AOJu0YzFk5KERdAn/LGibnu83kaWywITTiq1aPBCx1CeQX7KaRP5Xatc
	VDiW/GfQcux+RWyqcMymGM/Z1Mc8FhNRM8Bi5XOg2EkTqj65r801bGRlPM8lR1Y=
X-Google-Smtp-Source: AGHT+IGupTyXP3VFhYptxjZt2BlbjA6bGnEpUfRCy9ZfeL+fpR8L1bb+zQEyJd3qV+QwRwWD+5yCkw==
X-Received: by 2002:a05:6512:3d09:b0:512:8f96:92c4 with SMTP id d9-20020a0565123d0900b005128f9692c4mr4219561lfv.43.1708159194157;
        Sat, 17 Feb 2024 00:39:54 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id n9-20020aa7c449000000b0055ef4a779d9sm730481edr.34.2024.02.17.00.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 00:39:53 -0800 (PST)
Message-ID: <e3b54b1c-79ab-4f25-8b42-fadc922c0d25@linaro.org>
Date: Sat, 17 Feb 2024 09:39:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] dt-bindings: bus: imx-weim: convert to YAML
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240216223654.1312880-1-sre@kernel.org>
 <20240216223654.1312880-3-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216223654.1312880-3-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 23:34, Sebastian Reichel wrote:
> Convert the i.MX  Wireless External Interface Module binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/bus/imx-weim.txt      | 117 ----------
>  .../fsl/fsl,imx-weim-peripherals.yaml         |  31 +++
>  .../memory-controllers/fsl/fsl,imx-weim.yaml  | 203 ++++++++++++++++++
>  .../mc-peripheral-props.yaml                  |   1 +
>  .../fieldbus/arcx,anybus-controller.txt       |   2 +-
>  5 files changed, 236 insertions(+), 118 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
> deleted file mode 100644
> index e7f502070d77..000000000000
> --- a/Documentation/devicetree/bindings/bus/imx-weim.txt
> +++ /dev/null
> @@ -1,117 +0,0 @@
> -Device tree bindings for i.MX Wireless External Interface Module (WEIM)
> -
> -The term "wireless" does not imply that the WEIM is literally an interface
> -without wires. It simply means that this module was originally designed for
> -wireless and mobile applications that use low-power technology.
> -
> -The actual devices are instantiated from the child nodes of a WEIM node.
> -
> -Required properties:
> -
> - - compatible:		Should contain one of the following:
> -			  "fsl,imx1-weim"
> -			  "fsl,imx27-weim"
> -			  "fsl,imx51-weim"
> -			  "fsl,imx50-weim"
> -			  "fsl,imx6q-weim"
> - - reg:			A resource specifier for the register space
> -			(see the example below)
> - - clocks:		the clock, see the example below.
> - - #address-cells:	Must be set to 2 to allow memory address translation
> - - #size-cells:		Must be set to 1 to allow CS address passing
> - - ranges:		Must be set up to reflect the memory layout with four
> -			integer values for each chip-select line in use:
> -
> -			   <cs-number> 0 <physical address of mapping> <size>
> -
> -Optional properties:
> -
> - - fsl,weim-cs-gpr:	For "fsl,imx50-weim" and "fsl,imx6q-weim" type of
> -			devices, it should be the phandle to the system General
> -			Purpose Register controller that contains WEIM CS GPR
> -			register, e.g. IOMUXC_GPR1 on i.MX6Q.  IOMUXC_GPR1[11:0]
> -			should be set up as one of the following 4 possible
> -			values depending on the CS space configuration.
> -
> -			IOMUXC_GPR1[11:0]    CS0    CS1    CS2    CS3
> -			---------------------------------------------
> -				05	    128M     0M     0M     0M
> -				033          64M    64M     0M     0M
> -				0113         64M    32M    32M     0M
> -				01111        32M    32M    32M    32M
> -
> -			In case that the property is absent, the reset value or
> -			what bootloader sets up in IOMUXC_GPR1[11:0] will be
> -			used.
> -
> - - fsl,burst-clk-enable	For "fsl,imx50-weim" and "fsl,imx6q-weim" type of
> -			devices, the presence of this property indicates that
> -			the weim bus should operate in Burst Clock Mode.
> -
> - - fsl,continuous-burst-clk	Make Burst Clock to output continuous clock.
> -			Without this option Burst Clock will output clock
> -			only when necessary. This takes effect only if
> -			"fsl,burst-clk-enable" is set.
> -
> -Timing property for child nodes. It is mandatory, not optional.
> -
> - - fsl,weim-cs-timing:	The timing array, contains timing values for the
> -			child node. We get the CS indexes from the address
> -			ranges in the child node's "reg" property.
> -			The number of registers depends on the selected chip:
> -			For i.MX1, i.MX21 ("fsl,imx1-weim") there are two
> -			registers: CSxU, CSxL.
> -			For i.MX25, i.MX27, i.MX31 and i.MX35 ("fsl,imx27-weim")
> -			there are three registers: CSCRxU, CSCRxL, CSCRxA.
> -			For i.MX50, i.MX53 ("fsl,imx50-weim"),
> -			i.MX51 ("fsl,imx51-weim") and i.MX6Q ("fsl,imx6q-weim")
> -			there are six registers: CSxGCR1, CSxGCR2, CSxRCR1,
> -			CSxRCR2, CSxWCR1, CSxWCR2.
> -
> -Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
> -
> -	weim: weim@21b8000 {
> -		compatible = "fsl,imx6q-weim";
> -		reg = <0x021b8000 0x4000>;
> -		clocks = <&clks 196>;
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0x08000000 0x08000000>;
> -		fsl,weim-cs-gpr = <&gpr>;
> -
> -		nor@0,0 {
> -			compatible = "cfi-flash";
> -			reg = <0 0 0x02000000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			bank-width = <2>;
> -			fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
> -					0x0000c000 0x1404a38e 0x00000000>;
> -		};
> -	};
> -
> -Example for an imx6q-based board, a multi-chipselect device connected to WEIM:
> -
> -In this case, both chip select 0 and 1 will be configured with the same timing
> -array values.
> -
> -	weim: weim@21b8000 {
> -		compatible = "fsl,imx6q-weim";
> -		reg = <0x021b8000 0x4000>;
> -		clocks = <&clks 196>;
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0x08000000 0x02000000
> -			  1 0 0x0a000000 0x02000000
> -			  2 0 0x0c000000 0x02000000
> -			  3 0 0x0e000000 0x02000000>;
> -		fsl,weim-cs-gpr = <&gpr>;
> -
> -		acme@0 {
> -			compatible = "acme,whatever";
> -			reg = <0 0 0x100>, <0 0x400000 0x800>,
> -				<1 0x400000 0x800>;
> -			fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> -				0x00000000 0xa0000240 0x00000000>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
> new file mode 100644
> index 000000000000..82fc5f4a1ed6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX WEIM Bus Peripheral Nodes
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +description:
> +  This binding is meant for the child nodes of the WEIM node. The node
> +  represents any device connected to the WEIM bus. It may be a Flash chip,
> +  RAM chip or Ethernet controller, etc. These properties are meant for
> +  configuring the WEIM settings/timings and will accompany the bindings
> +  supported by the respective device.
> +
> +properties:
> +  reg: true

Your pattern in weim schema suggests you have here minItems: 2.
maxItems: can be 2 or 255.

> +
> +  fsl,weim-cs-timing:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Timing values for the child node.
> +    minItems: 2
> +    maxItems: 6
> +


..

> +patternProperties:
> +  "^.*@[0-7],[0-9a-f]+$":
> +    type: object
> +    description: Devices attached to chip selects are represented as subnodes.
> +    $ref: fsl,imx-weim-peripherals.yaml
> +    additionalProperties: true
> +    required:
> +      - fsl,weim-cs-timing
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#address-cells'
> +  - '#size-cells'

Plaese keep consistent quotes, either ' or "


> +  - ranges
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - fsl,imx50-weim
> +                - fsl,imx6q-weim
> +    then:
> +      properties:
> +        fsl,weim-cs-gpr: false
> +        fsl,burst-clk-enable: false
> +  - if:
> +      properties:
> +        fsl,burst-clk-enable: false

This does not work, or at least should not IMO.

What you want is
  not:
    required:

https://elixir.bootlin.com/linux/v6.4-rc7/source/Documentation/devicetree/bindings/net/qcom,ipa.yaml#L174



> +    then:
> +      properties:
> +        fsl,continuous-burst-clk: false
> +

Best regards,
Krzysztof


