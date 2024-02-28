Return-Path: <linux-kernel+bounces-85142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B8986B110
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E96F285047
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29617151CC5;
	Wed, 28 Feb 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8MBNb36"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D614F992
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128794; cv=none; b=dr782vQV419i5BEzHqzi0kK3Yb6xa3ZvCX+7I+Fntol5kCbAs04n5DuDtaqD++rAbkky8Wx9nJCdhlAIkRWsWRYTJG56sUZXPp5TF3vhC0GlPnbLSFs8sJ0TBMTGj3qfXXaNmdxU0ni9G0/S5wlu7GirpPWF47Ii2+t5ZfSN3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128794; c=relaxed/simple;
	bh=Ia2M0qxwtcNcfSaVEpSG+cjzWqtLFrxF+mIkAJQUGhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mignk7NPMaJKcs70xUapS0m8TjhUjwCvgfam5rq8XXdQrZ5dKYWkbD64bqLPO0SCIqAGIbhL5Q5jTCIPdu5jz1xBWQNbeOgCJySImD4uCUP4ZIrYMW+cnTaZuh6y4WuCZAibaHmcmSRcvFIUbqKWtb0uAOFUZLtLXYC5Ck7Espo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W8MBNb36; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e550ef31cso628186066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709128791; x=1709733591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9NqnkdPX6paOI+O7RwBWR73KUtzFSBhK812pkEn7md8=;
        b=W8MBNb36pfGoOeWVaYCQ+hAXHjj1N6auzMMjlx/5Qxw1KmqVq3WT7Hc8+7QGWjED8A
         uTfXpEwyAkk0sz7FOLQGlMiNOplMAE/HbXq1QFr057Fa0pqcpwZgfORqI/qnStZmTlYq
         VvEqBiOe77/2eOk/d/HQlpQ9dCxGeI2MbcnBWyDqMijWMmNV/+krvT6lwVG0k2i8dE7O
         K2vkNPryrO4/8tVtm12B7IxJJzG4wWP3ik5rE1FK7KnKhfVs5yebWXl7tDwXaie4H9Cn
         pqeB6hlkgNJs0zIwyphsohGsrAdkHQzZ5xTtoL9tpoyk/cqRy3OYK1iJHOy7npdFNjmc
         gE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128791; x=1709733591;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NqnkdPX6paOI+O7RwBWR73KUtzFSBhK812pkEn7md8=;
        b=uWGUX2hxUwRlsTPrqnUWyJVn69MASV0AO0sVPJkX+9cEqtvauTBTJrCis9faIiQX6w
         VqRiAUZEWeTbhzsb22CubrIZvfrkXoeOWhLJl82iYx0dMsGVTxoFQEMLZnINmaZxBfDo
         JXDZ2G3wWOW6dckmFR1viLO/Z8k+JAkTXkaaz9xFAnVGx8chjxHCO0Bcs00ohcvyAuee
         dTOD/sBgDzchhS1aa3P1NaPTOoyang3YwVc19d/fK77c/0GBkD9LRMP4wNRBDUbFpzWc
         OeoyrOgxucZNUx4+VzvrN7yE5z89BRGhsMhG90sHj57gcUqMA1o1WLvq/Rpn7tugiyns
         06mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjIg+NhISSq543cCYCTERgJTmuucX6v/74ttxjHl2YazfPa8UmZ2Z0E9XgBMAaVLpqAUirmYY+IkS+GuvNa/ACVQXQjX/f8qUlTZuI
X-Gm-Message-State: AOJu0YwqYfAziz8UYr/D3+7st9oGzOSvid85vv3mT9iYnMCQFqVrls2O
	7WvvV0MTLkxAulxaGdyxDJMz/gZRowUQpSPjg3CUCOxpebv2+fLk1r8E+MrXVFY=
X-Google-Smtp-Source: AGHT+IEPfj9suyKmqUMmFTefs1BwjpmX4BCCIkOQNyZStovYfhxfKEjSJ4N+hLi+WRu+2hs8+y+DkA==
X-Received: by 2002:a17:906:565a:b0:a3e:6a25:2603 with SMTP id v26-20020a170906565a00b00a3e6a252603mr9232878ejr.33.1709128790687;
        Wed, 28 Feb 2024 05:59:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id cm27-20020a170906f59b00b00a3f3d0d30c8sm1859841ejd.213.2024.02.28.05.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 05:59:50 -0800 (PST)
Message-ID: <6dd18b29-6e45-4c35-8f7e-5248b057449d@linaro.org>
Date: Wed, 28 Feb 2024 14:59:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: pwm: add support for MC33XS2410
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240228133236.748225-1-dima.fedrau@gmail.com>
 <20240228133236.748225-2-dima.fedrau@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228133236.748225-2-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 14:32, Dimitri Fedrau wrote:
> Adding documentation for MC33XS2410 pwm driver.

Driver as Linux driver? If so, please rephrase to describe hardware.

> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  .../bindings/pwm/nxp,mc33xs2410.yaml          | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
> new file mode 100644
> index 000000000000..bd387dbe69be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/nxp,mc33xs2410.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MC33XS2410 PWM driver

Driver as Linux driver? If so, please rephrase to describe hardware.

> +
> +maintainers:
> +  - Dimitri Fedrau <dima.fedrau@gmail.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: nxp,mc33xs2410
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 10000000
> +
> +  spi-cpha: true
> +
> +  spi-cs-setup-delay-ns:
> +    minimum: 100
> +    default: 100
> +
> +  spi-cs-hold-delay-ns:
> +    minimum: 10
> +    default: 10
> +
> +  spi-cs-inactive-delay-ns:
> +    minimum: 300
> +    default: 300
> +
> +  reset-gpios:
> +    description:
> +      GPIO connected to the active low reset pin.
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  pwms:
> +    description:
> +      Direct inputs(di0-3) are used to directly turn-on or turn-off the
> +      outputs. The external PWM clock can be used if the internal clock
> +      doesn't meet timing requirements.

pwm is input for pwm?

> +    maxItems: 5
> +
> +  pwm-names:
> +    items:
> +      - const: di0
> +      - const: di1
> +      - const: di2
> +      - const: di3
> +      - const: ext_clk

Aren't these clocks?

> +
> +  vdd-supply:
> +    description:
> +      Logic supply voltage
> +
> +  vspi-supply:
> +    description:
> +      Supply voltage for SPI
> +
> +  vpwr-supply:
> +    description:
> +      Power switch supply
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Instead:
unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +       pwm@0 {
> +           compatible = "nxp,mc33xs2410";
> +           reg = <0x0>;
> +           spi-max-frequency = <4000000>;
> +           spi-cpha;
> +           spi-cs-setup-delay-ns = <100>;
> +           spi-cs-hold-delay-ns = <10>;
> +           spi-cs-inactive-delay-ns = <300>;
> +           reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> +           #pwm-cells = <3>;

Make example complete, so provide all properties, like interrupts, pwms
and whatever you have in the binding.

Best regards,
Krzysztof


