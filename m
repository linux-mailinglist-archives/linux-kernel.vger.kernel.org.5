Return-Path: <linux-kernel+bounces-10439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EABA81D46B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A7A2831CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431B8DF49;
	Sat, 23 Dec 2023 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEHnsICM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F6DDA1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so3595079e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703340151; x=1703944951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6v3IHYCaxsrotfMWg+j0lELDhXBpXUqaNOjzWYbcrJk=;
        b=oEHnsICMvsAq9/eEM+xByOSPKBm6ZKx+9SWX3rGd20hyq7+bTt9jLPdEMn1j0waI6v
         QV2Uyb0nzn+YP6j57TOF7qvN3lEOo6T9vgX1uaVQUwDSlAVLAqnEWbNJyS8jTv+aVmWR
         EdIsPpfloagrHYS25pRnOEBOO2chgdqCssm4zMKVOLzMJHrFHDqBwDDPDCvrPFsqSNmC
         acPFOQllVUM3VK7it4Xoh28PgCDb3Ya5wxfzLSzWaExuynGTztlduMrAainfp2zITwB6
         +/WNKlsSb4DINb7fCJJwdDga/T4xMuYANr1MW4poZV5236vRW0/UIrY0xadt+V445+Ny
         En2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340151; x=1703944951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6v3IHYCaxsrotfMWg+j0lELDhXBpXUqaNOjzWYbcrJk=;
        b=If4eJSFzYfyMto7T4vbhr6Pl6WmGLdxESiXHZltv8JiMxyx7yiEC13MbCH2ry6eyql
         EKhdHPrFN6X1RpOF9KUV1jVZoYRluiV8lIOYzg3uVMWL3lDSp+/EEPvc9DtCmZ93oak6
         gOFjSwQXv0RL0eqaZy0CiPxKyIazNq13o4DkbuMvIXszRZ0kSh+YyL/Zs67UqZYmP7An
         k9ORApUw2DUMDl4GvXL/mem/hDmYQu3ybhNO+dX7wfY6DPDDFgMsopyfI7+IndmKVROH
         GwJ6bv3FxsauudSJpMYzduAiCL+MEB13jhw/H+nicjfkcRquuY6Y9yWPrW0IqvxjfuVw
         WA7g==
X-Gm-Message-State: AOJu0YycMHmR4B7B7lTIryVKaKwtic0YnNdfoBlTb21rhzzCG1GmQULF
	YbCIcDaUG3xlMvZT2DFzYqB6G5Z9mczOEw==
X-Google-Smtp-Source: AGHT+IEuySXJ3tVm5+hnlW0zGE7XWVXhbGRJDhZ0bFz/gXYAAfYIeTKNFQCi64EQUVcz0UTbDkttpQ==
X-Received: by 2002:a05:6512:b9e:b0:50e:700b:d92 with SMTP id b30-20020a0565120b9e00b0050e700b0d92mr904914lfv.46.1703340151137;
        Sat, 23 Dec 2023 06:02:31 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906169800b00a1f8bae93d3sm3098017ejd.215.2023.12.23.06.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 06:02:30 -0800 (PST)
Message-ID: <1d09b9bf-5709-410c-a598-9188a32e1bea@linaro.org>
Date: Sat, 23 Dec 2023 15:02:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-3-jbrunet@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231222111658.832167-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2023 12:16, Jerome Brunet wrote:
> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs,
> dealing with clocks differently. This does not enable new HW. It is meant
> to fix a bad DT ABI for the currently supported HW.
> 
> The original clock bindings describe which input the PWM channel
> multiplexer should pick among its possible parents, which are
> hard-coded in the driver. As such, it is a setting tied to the driver
> implementation and does not describe the HW.
> 
> The new bindings introduce here describe the clocks input of the PWM block
> as they exist.
> 
> The old compatible is deprecated but kept to maintain ABI compatibility.
> 
> The SoC specific compatibles introduced match the SoC families supported
> by the original bindings.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 50 +++++++++++++++++--
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index a1d382aacb82..eece390114a3 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -21,23 +21,35 @@ properties:
>            - amlogic,meson-g12a-ee-pwm
>            - amlogic,meson-g12a-ao-pwm-ab
>            - amlogic,meson-g12a-ao-pwm-cd
> -          - amlogic,meson-s4-pwm
> +        deprecated: true
>        - items:
>            - const: amlogic,meson-gx-pwm
>            - const: amlogic,meson-gxbb-pwm
> +        deprecated: true
>        - items:
>            - const: amlogic,meson-gx-ao-pwm
>            - const: amlogic,meson-gxbb-ao-pwm
> +        deprecated: true
>        - items:
>            - const: amlogic,meson8-pwm
>            - const: amlogic,meson8b-pwm
> +        deprecated: true
> +      - const: amlogic,meson8-pwm-v2
> +      - items:
> +          - enum:
> +              - amlogic,meson8b-pwm-v2
> +              - amlogic,meson-gxbb-pwm-v2
> +              - amlogic,meson-axg-pwm-v2
> +              - amlogic,meson-g12-pwm-v2
> +          - const: amlogic,meson8-pwm-v2
> +      - const: amlogic,meson-s4-pwm

If there is going to be resend:
This and amlogic,meson8-pwm-v2 before items: should be just in enum,
it's easier to read.

>  
>    reg:
>      maxItems: 1
>  
>    clocks:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 4
>  
>    clock-names:
>      minItems: 1
> @@ -58,7 +70,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - amlogic,meson8-pwm

I don't understand why removing it here.

The rest looks ok.
Best regards,
Krzysztof


