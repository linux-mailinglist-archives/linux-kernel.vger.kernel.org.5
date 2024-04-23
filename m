Return-Path: <linux-kernel+bounces-154808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9188AE149
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266EE286CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E45C613;
	Tue, 23 Apr 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIy9VsGk"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C61E863
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865777; cv=none; b=sF6mZTd5eObEKfOJ0khetnvCMAvKTOD6pJfwNmItCqNXd7K8C+lRJm3MLM8KUAEMpMK0baIqU3WAoYwzStFK4tNefVxWZXRRCFX8kTceyPRVjTL+W7FNgzH6kACfCu8s4HMO72PUfZi3PYOLozEjImw7/Otldkl02G09Xy4PXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865777; c=relaxed/simple;
	bh=NwPBsU1LTEWXKuj15xiSO/1zVXaOkdb9/phHy+RmCfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDn/PYkUiX4qCVKIOzGT3j+KDNuilFGGuJUHmKCDdPtIqU7vncHmJnOIxzrBw/E9mcICA+exddcsp9v+GoP8XvVzNjeR9yCGg++lQDbjQOsJzmBieXF/x7Cfo53UFoUqDy92CYdOmRFOxPNphyUoVd3QJzXNoq8DHNYlO2MRc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nIy9VsGk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-347c197a464so4031226f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713865773; x=1714470573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Igu1DHe9/mbdgePnFlKk0Kt8J0+Ygp+bDiGAG2bpm6A=;
        b=nIy9VsGkGvUCtPYD9yqOtpnLq7wefroEckWccWVvQXShHCU9uVSJ0sbgDtePyiB2wX
         HOOiY3BAMBa/e/8CHYDicu/Fulz30OYhW7C5k8ZO/+RgwR7cwcbpfmcMxrDf72Lf+LOO
         X89bPgoZQ90g3KU758hPPtzGXrSqCoV6Jxo/jdTqP51DN5Dg+A0Ni5mvwS2SMnTMcf/O
         F5Wtg1NAcd87cM6SrqopldA9y/6t3aZeiI4udnrxlQYuv7mduFT31V3MLwGLH8QnyK7m
         OQ5gqNgUQ3scNY1BW7ZnfCGyKMjDsr+cYXMzE6gjHuYtRXoikR3DcKSb/TJDH9khF13R
         kqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713865773; x=1714470573;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Igu1DHe9/mbdgePnFlKk0Kt8J0+Ygp+bDiGAG2bpm6A=;
        b=gH4TwkQ8+ToRv6Fs+0bqyxQH5Mcd6eBWjnVh21t8NC6ylIqGmsf8R0bIHaj8ugEvHm
         hpfrAWl076tCdjKux5plaAqUIdTX5dUnAy1/jA/RO0FVsxYv6r5AT1hjynpT0eCJxii5
         3MMUIl+A3W4jf4SUEcqapKkVzHtip0pTCIE4GGTtnGwO0GwenuolxolyphaFAoczpXov
         qTkbfvKWWUQfRpvMvSFivvWY993lInXZaUkf+l1/Mrf+Fy3f60tBGNoXxnS43KC2edgN
         DhCyoFOM5Zl/JqTkcnl72cUCObuk7R6zqnXz7Vp51UAuEoKdRTxsFl7jim6CG9SCHSIN
         0u7w==
X-Forwarded-Encrypted: i=1; AJvYcCWvatDFDdAxrbd/Q5e56/nleCFoQS83AJy9h0HXLUJ99Q1vNoYo0ensiExOoxBbpz+CRbnFBlSEyV9dT6xyC/tMSlk+qVdDQlmOVvFS
X-Gm-Message-State: AOJu0YzpynNY6uYn7UANexNt4mffhGDQbZEukIENVyekFi+iJSCuA2No
	1FqBkovKRWMkw85W+zVcQJxfVZIHjU1+n/g44OhSx69vdxdRkaafgx0KUWIp3dc=
X-Google-Smtp-Source: AGHT+IHRgo8HGU7FZWnB41V7PjyatID5UWrOs8dLpeBKw2fehyBq06F7/Ka8YFaKJRJjS5uYDUGJxw==
X-Received: by 2002:a5d:4082:0:b0:343:b5f0:f511 with SMTP id o2-20020a5d4082000000b00343b5f0f511mr7052352wrp.12.1713865771621;
        Tue, 23 Apr 2024 02:49:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id j6-20020adff006000000b00349856b640bsm14183531wro.67.2024.04.23.02.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 02:49:30 -0700 (PDT)
Message-ID: <a5f8746f-14f8-4e56-9ac7-30c7ba6fad30@linaro.org>
Date: Tue, 23 Apr 2024 11:49:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: Add PDM controller for the
 StarFive JH8100 SoC
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Walker Chen <walker.chen@starfivetech.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org
References: <20240423083405.263912-1-xingyu.wu@starfivetech.com>
 <20240423083405.263912-2-xingyu.wu@starfivetech.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240423083405.263912-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 10:34, Xingyu Wu wrote:
> Add bindings about the PDM controller for the StarFive JH8100 SoC.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

If there is going to be resend/new version, three nits. Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

..

> +
> +title: StarFive JH8100 PDM controller
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Pulse Density Modulation (PDM) controller is a digital PDM out
> +  microphone interface controller and decoder that supports both up to 4
> +  channels, and an Inter-IC Sound (I2S) transmitter that outputs standard
> +  stereo audio data to another device. The I2S transmitter can be
> +  configured to operate either a master or a slave (default mode). The PDM
> +  controller includes two PDM blocks, each PDM block can drive one
> +  bitstream sampling clock and two bitstream coming data (mono/stereo)
> +  with sampling clock rising and falling edge.
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +  - Walker Chen <walker.chen@starfivetech.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: starfive,jh8100-pdm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: DMIC output clock
> +      - description: Main ICG clock
> +
> +  clock-names:
> +    items:
> +      - const: dmic
> +      - const: icg
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  starfive,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller sys_syscon_ne node.
> +          - description: PDM source enabled control offset of SYS_SYSCON_NE register.
> +          - description: PDM source enabled control mask
> +    description:
> +      The phandle to System Register Controller syscon node and the PDM source
> +      from I2S enabled control offset and mask of SYS_SYSCON_NE register.

This description duplicates items. Drop redundant parts (there is really
never a need to say phandle is a phandle because it cannot be anything
else). Instead say what is it used for.


> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - '#sound-dai-cells'

Use consistent quotes, either ' or "



Best regards,
Krzysztof


