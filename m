Return-Path: <linux-kernel+bounces-137261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54EC89DF95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89E81C20ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FAE13DB9F;
	Tue,  9 Apr 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jL964Hmt"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C2136999
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677617; cv=none; b=lDgrjMbAm/G7IiKVlI4PEg5Wlzk7hLvXLJh+30uckbxkUv88GSY0c1EMOaZEoCPaZgHqcCSyuHwB43r03jTM1i7NxSNLtVZ11fXbgKXg7/gbuku1Nb3NyTWvtlCLihNC/ugH96m5P6U9jO6y6tEdWuCRFr91/YANnUUjQPF5OTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677617; c=relaxed/simple;
	bh=BDErqaONOw/NheOlMB0Ewp9ma2cyw7Wy9NHVDoOliXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLRDyczVbBLibZwJSFfFM7LowerBA92t0q0Z5BHb9XJzW3PW0kcSkrgdXy1rV7Dwf+6fimM/ezVo3j93i7P/+PVha6O2jfqATwFgbXtFOWbir/Rg268kOm3XVRtK5tkW5XbmkEWiJZsMWntiELC6CIuKKsNg0AnsKDztDKwauQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jL964Hmt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-415515178ceso37498265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712677614; x=1713282414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K6BgW7TKW7TJF3BVL0a/s0l7TG5JEGfNfhDuPjBIbTQ=;
        b=jL964Hmt94K+Oo5lkQH8YoWSRu8RqE4gNf12SvYvuRwtCmcTlzQrEJeX5v16HMJr7Z
         uRivst9lO3jzsjv1Y8dqJRpd98k10P47VX3Oxfui7GU1ACpicuUBOYc3uOt2+IftyZGj
         1opkSKGCXV97mFVBvPYnjKV39yj/aNBcnfHKZVa1H2vL35OFfMFHVYLN4u4RwzRzA6dh
         Y09hZFivhDXYn7skDqyXZo75yaJPuvoEmXIQt7cJHiIlcmlhkQO7nOfyM8Qd8jG9V8Z3
         UFlCBhVsgzUzS4no7ZGnPG/NwSGXPL16lA/AAZV61KycEPAG3/aA02N8TKRFPMDNyKhO
         RSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677614; x=1713282414;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6BgW7TKW7TJF3BVL0a/s0l7TG5JEGfNfhDuPjBIbTQ=;
        b=gkn78eU1IxfN+OHz9uEmPnVXd6q6o+3W08h/uOV+Cp/TPmov/VYx8Mp4BLXjCKuuRa
         yzYKV5n1w2O0eVYkLG99Ki+2s8beA1bI12OOXqDw74eOpI8vqw32PJmnxGrDKYkcoJ11
         5NGloz6+5QW09+gcCWyqKG3GxjFACV+hcH1rkyjqRJDwHPkJ5xDfzD8cmnFhBkJ/4Ez3
         PpVuAA95bHTIWDme0NHpbvmxqi1htcC+8Oxm+n4zPM4uwgdNVRLxGMQ6kJlGFTd63BHG
         VZkpBFi8ubCA2F6lJbKvchCfkenk3krh4ne0nGP90QJDFHULM0T+cDB4El7q3SCbdL4N
         8LEg==
X-Forwarded-Encrypted: i=1; AJvYcCUkEAb2o0nnnjmGdeIZicQFjiyTrbISv4seZaqT+qfEUxN0SxW+ZaGpsLr6kX+sG8QpAhUNBFQ6RBVj2FH8zi2NewPbrqCvwESpglP0
X-Gm-Message-State: AOJu0YyAgUwS3d6tB91ikG2YqNCncgInfSLWWKlosAPlmQ5zdxTkJHr8
	kuUkJ/oWAzWmO4iqj1VXB2iDRc+iUNDTW6ThT5Xj7EfA1b6xizMR6ryFqzzhX5M=
X-Google-Smtp-Source: AGHT+IH7yLU9ymU3WSBUPIfLwxHfg1GJE0CJH8Nj4cDnB1ykPmPR7bTIlNdKgyMi2etLwEzgtU2KqQ==
X-Received: by 2002:a05:600c:4e93:b0:416:950b:6aee with SMTP id f19-20020a05600c4e9300b00416950b6aeemr69127wmq.9.1712677613868;
        Tue, 09 Apr 2024 08:46:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b00416b28651e1sm1896045wmq.36.2024.04.09.08.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:46:53 -0700 (PDT)
Message-ID: <e0b48da7-b33c-45e4-b3f3-a6d71bb0afe2@linaro.org>
Date: Tue, 9 Apr 2024 17:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/18] ASoC: dt-bindings: mediatek,mt8365-afe: Add
 audio afe document
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
 <20240226-audio-i350-v3-1-16bb2c974c55@baylibre.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240226-audio-i350-v3-1-16bb2c974c55@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 15:41, Alexandre Mergnat wrote:
> Add MT8365 audio front-end bindings
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---

> +properties:
> +  compatible:
> +    const: mediatek,mt8365-afe-pcm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: 26M clock
> +      - description: mux for audio clock
> +      - description: audio i2s0 mck
> +      - description: audio i2s1 mck
> +      - description: audio i2s2 mck
> +      - description: audio i2s3 mck
> +      - description: engen 1 clock
> +      - description: engen 2 clock
> +      - description: audio 1 clock
> +      - description: audio 2 clock
> +      - description: mux for i2s0
> +      - description: mux for i2s1
> +      - description: mux for i2s2
> +      - description: mux for i2s3
> +
> +  clock-names:
> +    items:
> +      - const: top_clk26m_clk
> +      - const: top_audio_sel
> +      - const: audio_i2s0_m
> +      - const: audio_i2s1_m
> +      - const: audio_i2s2_m
> +      - const: audio_i2s3_m
> +      - const: engen1
> +      - const: engen2
> +      - const: aud1
> +      - const: aud2
> +      - const: i2s0_m_sel
> +      - const: i2s1_m_sel
> +      - const: i2s2_m_sel
> +      - const: i2s3_m_sel
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mediatek,dmic-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates how many data pins are used to transmit two channels of PDM
> +      signal. 1 means two wires, 0 means one wire. Default value is 0.
> +    enum:
> +      - 0 # one wire
> +      - 1 # two wires
> +
> +  mediatek,topckgen:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the mediatek topckgen controller

Nothing improved, so again, so something which is not obvious. What is
it used for? Why AFE needs topckgen for example?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - power-domains
> +  - mediatek,topckgen
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mediatek,mt8365-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        afe@11220000 {

Did you implement the comment or decided to keep afe?

BTW, whatever "consistency" you have in mind, it does not really matter
that much for that example. And for sure do not add incorrect code
intentionally just to fix it in next patch.



Best regards,
Krzysztof


