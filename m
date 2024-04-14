Return-Path: <linux-kernel+bounces-144000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F078A4097
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1651C20F20
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825FA1CA82;
	Sun, 14 Apr 2024 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5WUGxAG"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556A3C30
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713075745; cv=none; b=GL/Z/6pZLk7nPV0J3Fb8nK+3vDRObGU3DgpogJrqRiNkuyA3fGO9SG3jCeUdKW5xJ4Xn6wbykIGlldJmAXPqLPK/Q4CjH1F+bOjA/fIsZZMtAW+ARCbULemswJY2oD1MxW7bBK/HluI0V3fel+lOKp7heTrnKQjNCXgZuh9csao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713075745; c=relaxed/simple;
	bh=/EUXoIswG/2USlCjpQ1Daaq8DWiEhhNI96eY7ntZgV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jcgsW6PjRbW6vjdkZrcg2dijs3LoS5Ygn8/Y2Et7VPbBjRe17yGp4ck0fAZvFZR4MTr8R1wnBrG+kYN1mDegal1juC/IBlbyh3Mlef8ZnCEO04mlPMb/65VMcZHbvpU2y6VUbKEbg42ChRZP1s5z6VB7WqJsfiDiqxB6G+yjmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5WUGxAG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5252e5aa01so89202666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713075740; x=1713680540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ESZUR43YNISui6b6Za2luMgFmqRnPT4/h2xjqbBiFJo=;
        b=O5WUGxAGR3YR5GnwKfTZlviCK0f8wO3u2UwIZxFMZRZSUWK9EVwhD+pQenWMEE3ivl
         jqhi9fxj0qga2PH64L1ipC4bJNyz8jphhaiiJcC02hASNcDRuUVJFqQ+PXW9RdssSqGp
         uXkthVB9p6Y9Pq+M2dl6TqXSipZ2aSEc5oFSUojxdvTXzs1q7ZhBA43BQQA5dzORKExU
         P0Abr32Qhey31TLS0K29usLTXphrhZpDAH3Pzt6URspD+LQPoQ1Lo8OntFIrN5Lai4mo
         dVqob+CG3FcdssUr0Zv1q7aJHbEk4JX0pqxE89bnoXv1Q9RF676we4aPFcKeL6caOFCI
         3K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713075740; x=1713680540;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESZUR43YNISui6b6Za2luMgFmqRnPT4/h2xjqbBiFJo=;
        b=h+JmE2cFAOUFGiwZXhOhCgCgXJz+WXHqxspsBnIY3aBWSroAAxewYbU5N1dmoLSnWn
         Cv4xxzqQRJrrIeZo8GCvbZiF4bbdwfDoD/H9eH9HAqSbYmpILWFbbMj3s9wd94m09Vc+
         LZF/fDORmiwS5yJwGqW3uhgQK2pmk2wOld9Im0olgyPKNWIpd4a9E1C9qpoh6tDoqKkG
         vfKC1RPDoA2PKUck4U2eFti+OBHQa4tew5GEVrRtX/9Y9bViKXSz3hPRj2MV7oHohnJe
         ntT1S00hynV+LLS0aAOgrWf26j8uGwitb+Gi/tbqX/EC8lmbqGgikQC9z6LCWsPGr6d7
         5hDw==
X-Forwarded-Encrypted: i=1; AJvYcCX6HW9tX6ILlMD7HBM4t9+rOjejHOXSfVenowCvrS6M3GSzGD+krBQCC/a7Cn0fYcEy7fqBnP8QPJ3mp+6i4qJqmPFV7mW8P8Qvmlm6
X-Gm-Message-State: AOJu0Yw618B9ORg+LJQ5uT7QxFA6H9M3UGJrKHYD4oKb88JThXNH4Tb3
	azkJF17GFRZ5Cs38RXIzvsB3tNZGnMszTwXCOsWn+UKld2i0oJV+ffBbDWtclMk=
X-Google-Smtp-Source: AGHT+IHIwbsWydwhkdHxy978rjebg/Tnh9VYuX0SIvSfQH5zKN6Uuqo+RVy1zq9eFq9H7Us1aeAg4Q==
X-Received: by 2002:a17:907:9450:b0:a52:5df2:ab4c with SMTP id dl16-20020a170907945000b00a525df2ab4cmr464442ejc.16.1713075740007;
        Sat, 13 Apr 2024 23:22:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170906fd8400b00a5252e69c7dsm1263393ejb.160.2024.04.13.23.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 23:22:19 -0700 (PDT)
Message-ID: <99b45ee0-6762-4c94-b1f3-89769537e352@linaro.org>
Date: Sun, 14 Apr 2024 08:22:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: broadcom: Add support for BCM2712
To: Andrea della Porta <andrea.porta@suse.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
Content-Language: en-US
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
In-Reply-To: <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2024 00:14, Andrea della Porta wrote:
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     | 313 +++++++
>  arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi |  81 ++
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 841 ++++++++++++++++++
>  4 files changed, 1236 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> 
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index 8b4591ddd27c..92565e9781ad 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -6,6 +6,7 @@ DTC_FLAGS := -@
>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
>  			      bcm2711-rpi-4-b.dtb \
>  			      bcm2711-rpi-cm4-io.dtb \
> +			      bcm2712-rpi-5-b.dtb \
>  			      bcm2837-rpi-3-a-plus.dtb \
>  			      bcm2837-rpi-3-b.dtb \
>  			      bcm2837-rpi-3-b-plus.dtb \
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> new file mode 100644
> index 000000000000..2ce180a54e5b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/reset/raspberrypi,firmware-reset.h>
> +
> +#define spi0 _spi0
> +#define uart0 _uart0
> +
> +#include "bcm2712.dtsi"
> +
> +#undef spi0
> +#undef uart0
> +
> +/ {
> +	compatible = "raspberrypi,5-model-b", "brcm,bcm2712";

This patch did not pass basic tests. Like checkpatch.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


> +	model = "Raspberry Pi 5";
> +
> +	/* Will be filled by the bootloader */
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0 0 0x28000000>;
> +	};
> +
> +	leds: leds {
> +		compatible = "gpio-leds";
> +
> +		led_act: led-act {
> +			label = "ACT";
> +			gpios = <&gio_aon 9 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +			linux,default-trigger = "mmc0";
> +		};
> +	};
> +
> +	sd_io_1v8_reg: sd_io_1v8_reg {

Don't push to us downstream code. Please fix it first and adjust to
match DTS coding style. Underscores are not allowed in node names.

> +		compatible = "regulator-gpio";
> +		regulator-name = "vdd-sd-io";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-settling-time-us = <5000>;
> +		gpios = <&gio_aon 3 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x1
> +			  3300000 0x0>;

Aren't these two tupples?

> +		status = "okay";

Why? Where is it disabled?

> +	};
> +
> +	sd_vcc_reg: sd_vcc_reg {

Underscores...

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpios = <&gio_aon 4 GPIO_ACTIVE_HIGH>;
> +		status = "okay";

Why?

> +	};
> +
> +	wl_on_reg: wl_on_reg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "wl-on-regulator";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-0 = <&wl_on_pins>;
> +		pinctrl-names = "default";
> +
> +		gpio = <&gio 28 GPIO_ACTIVE_HIGH>;
> +
> +		startup-delay-us = <150000>;
> +		enable-active-high;
> +	};
> +
> +	clocks: clocks {
> +	};

Drop, useless.

> +};
> +
> +// Add some labels to 2712 device
> +
> +// The system UART
> +uart10: &_uart0 { status = "okay"; };
> +
> +// The system SPI for the bootloader EEPROM
> +spi10: &_spi0 { status = "okay"; };

Use standard coding style. Look at other recent platforms how it is done.

&spi {
	foo;
};

> +
> +#include "bcm2712-rpi.dtsi"

This goes to the top.

I must say this DTS is terrible to read.

> +
> +/* SDIO1 is used to drive the SD card */
> +&sdio1 {
> +	pinctrl-0 = <&emmc_sd_pulls>, <&emmc_aon_cd_pins>;
> +	pinctrl-names = "default";
> +	vqmmc-supply = <&sd_io_1v8_reg>;
> +	vmmc-supply = <&sd_vcc_reg>;
> +	bus-width = <4>;
> +	sd-uhs-sdr50;
> +	sd-uhs-ddr50;
> +	sd-uhs-sdr104;
> +	cd-gpios = <&gio_aon 5 GPIO_ACTIVE_LOW>;
> +	//no-1-8-v;

Do not add dead code to the kernel.

> +	status = "okay";
> +};
> +
> +&pinctrl_aon {
> +	emmc_aon_cd_pins: emmc_aon_cd_pins {

Again, no underscores.

> +		function = "sd_card_g";
> +		pins = "aon_gpio5";
> +		bias-pull-up;
> +	};
> +
> +	/* Slight hack - only one PWM pin (status LED) is usable */
> +	aon_pwm_1pin: aon_pwm_1pin {
> +		function = "aon_pwm";
> +		pins = "aon_gpio9";
> +	};
> +};
> +
> +&pinctrl {
> +	pwr_button_pins: pwr_button_pins {
> +		function = "gpio";
> +		pins = "gpio20";
> +		bias-pull-up;
> +	};
> +
> +	wl_on_pins: wl_on_pins {
> +		function = "gpio";
> +		pins = "gpio28";
> +	};
> +
> +	bt_shutdown_pins: bt_shutdown_pins {
> +		function = "gpio";
> +		pins = "gpio29";
> +	};
> +
> +	emmc_sd_pulls: emmc_sd_pulls {
> +		pins = "emmc_cmd", "emmc_dat0", "emmc_dat1", "emmc_dat2", "emmc_dat3";
> +		bias-pull-up;
> +	};
> +};
> +
> +/ {

Why the heck this appears in the middle? This is top level section. I am
sorry, but this DTS looks really poor and not like existing coding
style. Please do not introduce some entirely different coding styles.


> +	chosen: chosen {
> +		bootargs = "reboot=w coherent_pool=1M 8250.nr_uarts=1 pci=pcie_bus_safe snd_bcm2835.enable_compat_alsa=0 snd_bcm2835.enable_hdmi=1";

Not a DTS properties. Drop entire bootargs.

> +		stdout-path = "serial10:115200n8";
> +	};
> +
> +	pwr_button {

Srsly...

> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwr_button_pins>;
> +		status = "okay";

???

> +
> +		pwr_key: pwr {

OK, you definitely did not test it. The code looks worse and worse I
keep looking, so I will stop.

This did not pass basic internal review, checkpatch, basic tests.



..

> +
> +		// Pad bank0 out to 32 entries
> +		"", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
> +
> +		"HDMI0_SCL", // AON_SGPIO_00
> +		"HDMI0_SDA", // AON_SGPIO_01
> +		"HDMI1_SCL", // AON_SGPIO_02
> +		"HDMI1_SDA", // AON_SGPIO_03
> +		"PMIC_SCL", // AON_SGPIO_04
> +		"PMIC_SDA"; // AON_SGPIO_05
> +};
> +
> +/ {
> +	aliases {

OK, now you are trolling us. It is third top-level node!

Limited review follows.

> +		blconfig = &blconfig;
> +		blpubkey = &blpubkey;
> +		console = &uart10;
> +		mailbox = &mailbox;
> +		mmc0 = &sdio1;
> +		uart10 = &uart10;
> +		serial10 = &uart10;
> +		gpio1 = &gio;
> +		gpio2 = &gio_aon;
> +		gpio3 = &pinctrl;
> +		gpio4 = &pinctrl_aon;
> +	};
> +
> +	__overrides__ {

?

Drop

> +		button_debounce = <&pwr_key>, "debounce-interval:0";
> +		random = <&random>, "status";
> +		sd_cqe = <&sdio1>, "supports-cqe?";
> +		suspend = <&pwr_key>, "linux,code:0=205";
> +		act_led_activelow = <&led_act>,"gpios:8";
> +		act_led_trigger = <&led_act>, "linux,default-trigger";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
> new file mode 100644
> index 000000000000..d04e39b9c0b6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi

What is this file for?

> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/power/raspberrypi-power.h>
> +
> +&soc {
> +	firmware: firmware {
> +		compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";


> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		mboxes = <&mailbox>;
> +		dma-ranges;
> +
> +		firmware_clocks: clocks {
> +			compatible = "raspberrypi,firmware-clocks";
> +			#clock-cells = <1>;
> +		};
> +
> +		reset: reset {
> +			compatible = "raspberrypi,firmware-reset";
> +			#reset-cells = <1>;
> +		};
> +	};
> +
> +	power: power {
> +		compatible = "raspberrypi,bcm2835-power";
> +		firmware = <&firmware>;
> +		#power-domain-cells = <1>;
> +	};
> +
> +	/* Define these notional regulators for use by overlays, etc. */
> +	vdd_3v3_reg: fixedregulator_3v3 {

W=2 warnings.

> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "3v3";
> +	};
> +
> +	vdd_5v0_reg: fixedregulator_5v0 {

W=2 warnings.

> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "5v0";
> +	};
> +};
> +
> +/ {
> +	__overrides__ {
> +		arm_freq;

NAK, drop.

> +	};
> +};
> +
> +&rmem {
> +	/*
> +	 * RPi5's co-processor will copy the board's bootloader configuration
> +	 * into memory for the OS to consume. It'll also update this node with
> +	 * its placement information.
> +	 */
> +	blconfig: nvram@0 {
> +		compatible = "raspberrypi,bootloader-config", "nvmem-rmem";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0 0x0 0x0>;
> +		no-map;
> +		status = "disabled";
> +	};
> +	/*
> +	 * RPi5 will copy the binary public key blob (if present) from the bootloader
> +	 * into memory for use by the OS.
> +	 */
> +	blpubkey: nvram@1 {
> +		compatible = "raspberrypi,bootloader-public-key", "nvmem-rmem";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0 0x0 0x0>;
> +		no-map;
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> new file mode 100644
> index 000000000000..fd5a19f68b49
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -0,0 +1,841 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/bcm2835-pm.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +/ {
> +	compatible = "brcm,bcm2712", "brcm,bcm2711";

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

> +	model = "BCM2712";

Drop



> +
> +	clk_27MHz: clk-27M {

No upperscore letters.

> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <27000000>;
> +		clock-output-names = "27MHz-clock";
> +	};
> +
> +	clk_108MHz: clk-108M {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <108000000>;
> +		clock-output-names = "108MHz-clock";
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		ranges     = <0x7c000000  0x10 0x7c000000  0x04000000>;
> +		/* Emulate a contiguous 30-bit address range for DMA */
> +		dma-ranges = <0xc0000000  0x00 0x00000000  0x40000000>,
> +			     <0x7c000000  0x10 0x7c000000  0x04000000>;
> +
> +		system_timer: timer@7c003000 {
> +			compatible = "brcm,bcm2835-system-timer";
> +			reg = <0x7c003000 0x1000>;
> +			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +		     		     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> +		     		     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <1000000>;
> +		};
> +
> +		mailbox: mailbox@7c013880 {
> +			compatible = "brcm,bcm2835-mbox";
> +			reg = <0x7c013880 0x40>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <0>;
> +		};
> +
> +		disp_intr: interrupt-controller@7c502000 {
> +			compatible = "brcm,bcm2711-l2-intc", "brcm,l2-intc";
> +			reg = <0x7c502000 0x30>;
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		dvp: clock@7c700000 {
> +			compatible = "brcm,brcm2711-dvp";
> +			reg = <0x7c700000 0x10>;
> +			clocks = <&clk_108MHz>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		/*
> +		 * This node is the provider for the enable-method for
> +		 * bringing up secondary cores.
> +		 */
> +		local_intc: local_intc@7cd00000 {

You really need to clean this up...


> +			compatible = "brcm,bcm2836-l1-intc";
> +			reg = <0x7cd00000 0x100>;
> +		};
> +
> +		uart0: serial@7d001000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x7d001000 0x200>;
> +			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_uart>,
> +				 <&clk_vpu>;
> +			clock-names = "uartclk", "apb_pclk";
> +			arm,primecell-periphid = <0x00241011>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@7d001400 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x7d001400 0x200>;
> +			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_uart>,
> +				 <&clk_vpu>;
> +			clock-names = "uartclk", "apb_pclk";
> +			arm,primecell-periphid = <0x00241011>;
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@7d001a00 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x7d001a00 0x200>;
> +			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_uart>,
> +				 <&clk_vpu>;
> +			clock-names = "uartclk", "apb_pclk";
> +			arm,primecell-periphid = <0x00241011>;
> +			status = "disabled";
> +		};
> +
> +		sdhost: mmc@7d002000 {
> +			compatible = "brcm,bcm2835-sdhost";
> +			reg = <0x7d002000 0x100>;
> +			//interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;

No dead code.


..

> +
> +		random: rng@7d208000 {
> +			compatible = "brcm,bcm2711-rng200";
> +			reg = <0x7d208000 0x28>;
> +			status = "okay";

Drop.

I just ignored the rest. Quality does not improve. This DTS is in very
poor shape and not suitable for mainline submission.

Please very carefully read DTS coding style and send DTS only after
fixing all automation errors (all! so checkpatch, W=1, dtbs_check W=1)
and after aligning this in 100% to DTS coding style.

Best regards,
Krzysztof


