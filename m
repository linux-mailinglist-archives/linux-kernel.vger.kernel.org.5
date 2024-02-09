Return-Path: <linux-kernel+bounces-59100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F984F130
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B561C225CB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088665BB7;
	Fri,  9 Feb 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOatRVWf"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506D65BA7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465770; cv=none; b=KTt15d8HAdgmlOuo5vMa44UW4uxQ6eaAOcXdITKb4UPN4pa1OQ8YX4cJHaQDrLN25l1kR/1x/R9qiPRbzGs2pdzg6csj1x9Id81+Fa3WJCyjMytBJxGg4STDbmKM8EkZ0ZLhSCddAoGgv4vjKrQN/1wFWitQam4MkCyBAToDZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465770; c=relaxed/simple;
	bh=YKF97+kj1TUSn4rR5DMTV1dj9+fjhTBNOGGqMwOxrXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko9GeBmrvtncl+4mLfuQnwkCucEJDlEfQYg3DHUk1wNJ4tyWjbjYQcEyKWsTiCBhGW+YSpFRKEGMAELDy/vi7tMgE74Ruw0efCA2rYDnLBqNRad9exmS+49t7tEfyeg01UyRvNfn7jEbDuH2z3RJ8fZ/ZJvAU9sgaSKjBfO3DkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pOatRVWf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so9704075e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707465767; x=1708070567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ft7kNfa2lDGC1Uv3PrG9uiV0ZqWiOvG7bd23u7IX8s=;
        b=pOatRVWflU7gZ99HpKruDZZCpcf8L5PA7TGN+FTez1YpmMNKa1mv30jcWhJ0dwKsoL
         ju+dgNZD2dmcaw2Yp21hniVUrndg4Od6q/eSEIi3jxv4RUmytb7EQg+HX3DbVIohr03G
         v6Ucx2XDh7fPVx7rNN4v5KasUoIuAnp4KIgIPym+8D/tHYVefzCg/L2WLbiVsk8dfem9
         +ljXg8mx6XSzAHsO8GNRMMIMzsxJSOANR1yv1oaSnSXeg0HDo12GAcY3aHvedTzugxoq
         FQ0X86jYXJFcqwxFOva/yCGZGmJOWfTaKYqdIDZ6Pg8dC6nfwY78YZZYf54T/7oDikkf
         xl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707465767; x=1708070567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ft7kNfa2lDGC1Uv3PrG9uiV0ZqWiOvG7bd23u7IX8s=;
        b=RFwfMoD7T9U0uuo4UxqIJM4slVvGtTB5DpA1TMHtBpOAjNsk4zPRe3iscjHAcvR3q0
         Zldjz0py1tji0QrQNbJTxzMbipIfnmFo0zTNqhEcMdfpsRsehuawQTr2bVbmvZfnFYQL
         rlU1XSw39wH0Bdw4bA5VC57+ne7zAxTNeRVyIvMIXeLpquAm+3PCZhUcolx38y9w7YZt
         7YMwWr0lnUzs4Dxq462TIWiPqMh5Y8vOrPx633G+Id+YklK1ZKSbib1rOOl2jTMEaMsS
         Q7OtxfeIpzSGraZsiW5QAaG7QotRfNqzxZL1RDDcOLgeGLb4zUKgX2czKIVyTZ2n72Dt
         VOGw==
X-Gm-Message-State: AOJu0YwYpYY+U+O21LMk/VY+Mdoq8YeYEQGn4YwW1wBLoIS0uDDIUdNc
	mnLUx49L+X2GB0l+WZwOl/rzBYBpBdAi/yOUuDWpoYZpjAqU8vrGsfo7OWx1k6U=
X-Google-Smtp-Source: AGHT+IF8NTjawrsr+yZm2+uZUiq/7pLI0u3aIlRY8BecWFpFPxc0flX2+wZuPV/gpPWlFBPzJylkdw==
X-Received: by 2002:a05:6000:11ca:b0:33a:e9d5:a760 with SMTP id i10-20020a05600011ca00b0033ae9d5a760mr208539wrx.14.1707465766649;
        Fri, 09 Feb 2024 00:02:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUM4zNse6WS4w+KYKYZpF3hQnjlrBqxRz/E1HoE5sigmEBPCuvIKkcrvGzRaSMlP97TiogSciMFaQVsYppwoS2lo15Z2kJ+uiKm6DgO2u1wJltzs52jfYpNAdPWOhtjtn3eWpFo/RJE13HrNeob7HpMnPpc0WE3eLzmmNPQQS4AZTXtW2e3xArmn0bUth263Q2D5CT+KtztdkpA+OhpVZDnwk+dECImPpO/suBw/HBDpxnEdIKI6HvCDUsGogwk5cHCHDy9IyEHp5YNa611gBLuH2WMvU/inqfIh/tadu2nzYpmZlUjNdrmlEwG3Riui5VTFJDn
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id w5-20020adfcd05000000b0033b1b01e4fcsm1133118wrm.96.2024.02.09.00.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:02:46 -0800 (PST)
Message-ID: <55b4a973-653c-4798-81ec-198f204a09e1@linaro.org>
Date: Fri, 9 Feb 2024 09:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
 <20240208184919.2224986-15-andriy.shevchenko@linux.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240208184919.2224986-15-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 19:48, Andy Shevchenko wrote:
> Add initial device tree documentation for Maxim MAX6958/6959.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../bindings/auxdisplay/maxim,max6959.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
> new file mode 100644
> index 000000000000..49ce26176797
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/auxdisplay/maxim,max6959.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX6958/6959 7-segment LED display controller with keyscan
> +
> +maintainers:
> +  - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +

Please describe the device, e.g. bus/interface.

> +properties:
> +  compatible:
> +    const: maxim,max6959

Your title said also max6958, so I would expect it to be here as well.
Cam be followed by 6959 fallback compatible, if they are compatible.

> +
> +  reg:
> +    maxItems: 1

No power supplies? No reset pins?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +            #address-cells = <1>;

Use 4 spaces for example indentation. 2 is also fine.

> +            #size-cells = <0>;
> +
> +            max6959: max6959@38 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
e.g. display-controller or display

> +                    compatible = "maxim,max6959";
> +                    reg = <0x38>;
> +            };
> +      };

Best regards,
Krzysztof


