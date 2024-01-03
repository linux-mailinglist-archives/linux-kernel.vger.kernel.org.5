Return-Path: <linux-kernel+bounces-15243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23E822909
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300641C22FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5118032;
	Wed,  3 Jan 2024 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqrYAGyz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA61802E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a271a28aeb4so623897266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 23:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704267488; x=1704872288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wvs+OsFm5Ki6aS4nraTJgj/TgsvojVRU2nA9dGRj5Ek=;
        b=dqrYAGyz04YpmJNbeJhLCOUvlSQKVUiANA8nVrSiKWRss/OqtLg5zDIL/SIjtsRKcI
         Cy2YD3fZBSklpDKN9V+Q9BZNQwM0RfEpZTro1VGhI/oyFQmYWsQN8SVRG9BB9s8KXUdZ
         jvKKx6r+FIYy/iT8TUvxf5fq2G2EG1HHuN6+gf8NbJfgIX2rLj9UmaQkyPpeke1Y3tVT
         Y9ktYRtP9Yw2PwArujzjsP6SHFueu0NWnw0XByC8V/02ePgObcVpAzpuyDmGFyuu5CGf
         N09I34nnUi94VBd4ALUvjwVMkj2922x3clVOlx8NZyE0QdyYBxzun09QNkHFaY5CO1qh
         Getg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704267488; x=1704872288;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvs+OsFm5Ki6aS4nraTJgj/TgsvojVRU2nA9dGRj5Ek=;
        b=w0KqtvcFT00Yi2hkRm7bnvCJFPM/PtMN6uBHofQ3l/MPYHwLOW5M9ienGBtCFEHc5v
         p7cxATvjPATf8ijXf4FrZfg+bG19y21yFaT15HSJapqSJUqbBDXb9uUhBfwX60EuriEu
         PP5RL6EQXV62FJJ4jWLRWTU1lyGaCR9eTQLyJVXymXJzlcUGbkBXsvnLnhnWEuwFZ7+a
         GgvTtsVHPnvdnQNqVZ9qgbJoSTytQvbkZk/LWMo/rMGdRffjjiIyNp8l9x/Xxr9cX9EQ
         HvfXyBgj8ZkFhAw8JO1PWFzE8HZGd884PTaTVx/xTsNIHakDwNB+uBpfOSy+b4SIgD6p
         FMow==
X-Gm-Message-State: AOJu0Yw4E9fDatP/7Q8I5L1VDMNQhrZNribbCmZXtqtljR1pyngpZG+g
	0AmHPCZn4oqTJcRvRqRgyR8kHZFSA2CVHQ==
X-Google-Smtp-Source: AGHT+IFM1EKytI/0oFBOySzL9GIOkqH4m1Vxzz0N5qI8oV0VrerHoCkVDNHliRaySLlJ53npWclRIA==
X-Received: by 2002:a17:906:8c5:b0:a1f:6eac:6f9e with SMTP id o5-20020a17090608c500b00a1f6eac6f9emr8121000eje.137.1704267488255;
        Tue, 02 Jan 2024 23:38:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id p10-20020a170907910a00b00a26aaa47cc0sm11980805ejq.129.2024.01.02.23.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 23:38:07 -0800 (PST)
Message-ID: <9315a1ea-5ebe-47b7-a108-4a72b647bb4f@linaro.org>
Date: Wed, 3 Jan 2024 08:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] ASoC: dt-bindings: move tas2563 from tas2562.yaml
 to tas2781.yaml
Content-Language: en-US
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org,
 conor+dt@kernel.org
Cc: robh+dt@kernel.org, andriy.shevchenko@linux.intel.com, kevin-lu@ti.com,
 baojun.xu@ti.com, devicetree@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de, peeyush@ti.com,
 navada@ti.com
References: <20231228153024.1659-1-shenghao-ding@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231228153024.1659-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/12/2023 16:30, Shenghao Ding wrote:
> Move tas2563 from tas2562.yaml to tas2781.yaml to unbind tas2563 from
> tas2562 driver code and bind it to tas2781 driver code, because tas2563
> only work in bypass-DSP mode with tas2562 driver. In order to enable DSP
> mode for tas2563, it has been moved to tas2781 driver. As to the hardware
> part, such as register setting and DSP firmware, all these are stored in
> the binary firmware. What tas2781 drivder dooes is to parse the firmware
> and download it to the chip, then power on the chip. So, tas2781 driver
> can be resued as tas2563 driver. Only attention will be paid to
> downloading corresponding firmware.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> Change in v4:
>  - remove tas2563, which will be move to tas2781 driver.
>  - Add more comments on why to move tas2563 to tas2781 driver.
>  - Provide rationale in terms of bindings and hardware, not in terms of driver.
>    Or at least not only.
>  - Reorder chip, tas2563 is first, tas2781 is second.
>  - Add datasheet linkings.
>  - squash both tas2562 and tas2781 binding patches.
>  - Put allOf: to the end of the file, after required: block.
> ---
>  .../devicetree/bindings/sound/tas2562.yaml    |  2 -
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 85 ++++++++++++++-----
>  2 files changed, 64 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
> index f01c0dde0cf7..d28c102c0ce7 100644
> --- a/Documentation/devicetree/bindings/sound/tas2562.yaml
> +++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
> @@ -18,7 +18,6 @@ description: |
>  
>    Specifications about the audio amplifier can be found at:
>      https://www.ti.com/lit/gpn/tas2562
> -    https://www.ti.com/lit/gpn/tas2563
>      https://www.ti.com/lit/gpn/tas2564
>      https://www.ti.com/lit/gpn/tas2110
>  
> @@ -29,7 +28,6 @@ properties:
>    compatible:
>      enum:
>        - ti,tas2562
> -      - ti,tas2563
>        - ti,tas2564
>        - ti,tas2110
>  
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> index a69e6c223308..78d89008c36f 100644
> --- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -5,36 +5,41 @@
>  $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Texas Instruments TAS2781 SmartAMP
> +title: Texas Instruments TAS2563/TAS2781 SmartAMP
>  
>  maintainers:
>    - Shenghao Ding <shenghao-ding@ti.com>
>  
> -description:
> -  The TAS2781 is a mono, digital input Class-D audio amplifier
> -  optimized for efficiently driving high peak power into small
> -  loudspeakers. An integrated on-chip DSP supports Texas Instruments
> -  Smart Amp speaker protection algorithm. The integrated speaker
> -  voltage and current sense provides for real time
> +description: |
> +  The TAS2563/TAS2781 is a mono, digital input Class-D audio
> +  amplifier optimized for efficiently driving high peak power into
> +  small loudspeakers. An integrated on-chip DSP supports Texas
> +  Instruments Smart Amp speaker protection algorithm. The
> +  integrated speaker voltage and current sense provides for real time
>    monitoring of loudspeaker behavior.
>  
> -allOf:
> -  - $ref: dai-common.yaml#
> +  Specifications about the audio amplifier can be found at:
> +    https://www.ti.com/lit/gpn/tas2563
> +    https://www.ti.com/lit/gpn/tas2781
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,tas2781
> -
> -  reg:
> -    description:
> -      I2C address, in multiple tas2781s case, all the i2c address
> -      aggregate as one Audio Device to support multiple audio slots.
> -    maxItems: 8
> -    minItems: 1
> -    items:
> -      minimum: 0x38
> -      maximum: 0x3f
> +    description: |
> +      ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
> +      DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
> +
> +      ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
> +      Protection and Audio Processing, 16/20/24/32bit stereo I2S or
> +      multichannel TDM.
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,tas2563
> +          - const: ti,tas2781
> +      - enum:
> +          - ti,tas2781
> +
> +  reg: true

min/maxItems must stay here

I already reminded this in v3.


Best regards,
Krzysztof


