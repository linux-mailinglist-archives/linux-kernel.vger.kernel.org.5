Return-Path: <linux-kernel+bounces-47794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089DE8452F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3366287791
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF115AAC6;
	Thu,  1 Feb 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTYHeUHt"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF615A4AC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776943; cv=none; b=O1Wu6q24ITVgUiEgNJ+WNQXlhDaaTIORJLJWK0d3ipeAGnhGb88UAJqxahMC1Y4UvgrAGRtz+Z9nm4r6fvjbioUgPtti6vBDQUvoG5mnsnVslmtSACpzVMnoEixQW0glsG0LP/PgTktKV94/2/49pybxIPtOMvLGH+UF5pTtrOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776943; c=relaxed/simple;
	bh=vgiPod43xhLyOoPaHEagKYyNTn3pVFH1lDZaGMO3OFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXqmEs6FHjoBk/gQvQcUABaTknZVlC1LsEdPldsQafuTWtnj5RkajOQsTHkzO5nTn0Y7M69cWB78UlYmbX19ufmYE9RHFzmdp0isgvaib8XMEmpVrf9ZgMAQrt7Uiu4VrDXBiWiNJmGr5lEUMzf2/rzput72HGmFYMDV0Vg2iwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WTYHeUHt; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3566c0309fso76871166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706776940; x=1707381740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCTc7fVbkCuXSdUKTNH0vQzpLy6v4+x8zgaNHVx5L2Y=;
        b=WTYHeUHty6bgA1Vddd+V9Eps9JHLH9gCjurIu7IrYniPdFq1RfjHWgheYq0t94hU3V
         xYAFHT8AXvvJs0bhOLnoyrZZuijXV4D+XKgwTc6GkxKqt3VznSOOtskRlK3xPUCuaxMW
         8gO2Gbf4osue60AWoKlj0y7dxcEWnRVFiBCaegNjMD7DK9JEVkBLIZknpfK+5ninigig
         yUvLHgLyFaioFQrHQl2QbRxOcEPX+NgYVtWS+ze2pZzRJPGM+VWK/4NSV00BRGWSChHA
         x87BuO2fJoRDRRFvWQ+myF/tdQCa/jc6dO9K06d2Jqd/8hrcf/j9rTAb3+zYVLXsGr8u
         ClXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706776940; x=1707381740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCTc7fVbkCuXSdUKTNH0vQzpLy6v4+x8zgaNHVx5L2Y=;
        b=k3PZBBEiQ93qz8z9lhz+g81tNVQp9fC5Kw0syg0CQiPTBCcrdhwmx0pmdvrqiVRWVM
         RHEY+Z6fM/1H+wvAyNwXphMKVH/gV4iAThHk21JkSnC3Sbzvp/B0zaz2JcaCcXa5qP6a
         xLv+PMnIbpUZO4SJoWRRyYib9f4+qG0o0wZuFOkoVSWQJFl+uaBEammIVbfvZnXUkA+V
         AwToFNuXtI5KKWWwd372rgdY4dn9QaWi1mP2FrB6DOS0h8OSGbepLLtQLQccx9a/wnmX
         82NYz1Ly7JlVMPBMJVMAxtaHPIFIMAoMoYka1PG9fPlo2L2gp2JB+EsXhKDnGvaQBa+Z
         glNg==
X-Gm-Message-State: AOJu0Yx+YY3p9bDFt/MLJB888jYdP7I6JHvp7VQGS8fWGYXLzyNM8SQO
	PyzZ22gfgTRf/OL7X6mE858DmkYyLrLypQ/95BMXBVQgg1tUVzJn0/xIY+7h69Y=
X-Google-Smtp-Source: AGHT+IE3SRD84yqANYo4Gdyj5Z+8WGSrGX0np8lIu0e5XxJwCoQB5XHXhr5TdOJUF1f+qbgEMEiptA==
X-Received: by 2002:a17:906:bc89:b0:a30:fc7b:5b37 with SMTP id lv9-20020a170906bc8900b00a30fc7b5b37mr3345970ejb.62.1706776939854;
        Thu, 01 Feb 2024 00:42:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUOBzPU+F+fBp/GgyPU2c4gyjDdwI80vqc1myC+RyU2jwxFDeccUv12gU6Vz7uQGB5AjMQ9ojG8X48d5DmnADnYRCg4YxFkFBDCD6a/hQxuvcIbUfllnp0P7SCHt2BOOCZ5hZSS7nYnLqeAISbOWCOnqivyZTA8zM7+Dkh4qgEEK3wjBJbXu/YddAoqJeqzJ8jSnaHlfusazmPGyrmnzJX4XH6zK077fHlPyAfgIQWSSI3hs6UKHZ4QRLMTqgcsK6PSuBa7LUr4uHCHOQR+/eFuby6m1fNTeF+Jk3o3MVX8T1Z1FqE/Gb9PIPP854HBHMaWC+sceAY1m7jEZ6tlxsBZ6MwIj8lLn/IV+XEZ2Ewfo1/F7xP5Fg35o6XEtkYtIxEg4m+IrET62OfDeggcdj396w3FnMxYJ5A0dDQJITJvHH0g4p1auiqG/chp
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ll5-20020a170907190500b00a36c7a7b4f7sm234612ejc.207.2024.02.01.00.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:42:19 -0800 (PST)
Message-ID: <48d4a6b0-6dd4-4227-ae46-45c7e1c6e60b@linaro.org>
Date: Thu, 1 Feb 2024 09:42:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Content-Language: en-US
To: Tomer Maimon <tmaimon77@gmail.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 tali.perry1@gmail.com, joel@jms.id.au, venture@google.com, yuenn@google.com,
 benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240131182653.2673554-1-tmaimon77@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131182653.2673554-1-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 19:26, Tomer Maimon wrote:
> This patchset adds clock support for the Nuvoton 
> Arbel NPCM8XX Board Management controller (BMC) SoC family.
> 
> This patchset cover letter is based from the initial support for NPCM8xx BMC to
> keep tracking the version history.
> 
> for your note:
>  1. dt-bindings clock modification started from v22 since the upstream npcm8xx 
>     clock driver haven't merged yet and requires dt binding update according to 
>     the new npcm8xx clock driver.
> 
>  2. all the other initial support patches had been applied to Linux kernel 6.0.
> 
> This patchset was tested on the Arbel NPCM8XX evaluation board.
> 
> Addressed comments from:
>  - Rob Herring: https://www.spinics.net/lists/devicetree/msg663403.html
>  - Krzysztof Kozlowski: https://www.spinics.net/lists/devicetree/msg665206.html

Use lore links which are way much more helpful.

Best regards,
Krzysztof


