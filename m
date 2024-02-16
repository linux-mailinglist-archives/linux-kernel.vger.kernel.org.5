Return-Path: <linux-kernel+bounces-68163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0368576B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182401C22DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E8A15491;
	Fri, 16 Feb 2024 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nY+MSBVz"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A217591
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067965; cv=none; b=e1r8Svy35apIqSXjk1HF8AoL5zb8MBiOhmfG6oT6i1RjwtvB33z6OJRpBrFxoS4uQ7hCSnwWawOIgspxapFP8deGZsj58ud4iTp/aIK27hZKJi2Jl7qwFDnxkqKYEG25Kh7orgMMyLpZeZFhFXoAsdh4srHSviPDWN/MDf8i+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067965; c=relaxed/simple;
	bh=mPt89Dshg//Ai7O81VpvjN2S+/3YCtZODyxTpurTePQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdPYYYfP4CSX4YZKaoR0B5a+ayjevHg9CMLAPOJAQgoD90/M7bbCXgL88qX8byD6Gnlg4GVCITPOAaGhIDeOzPd6YqMtdXn4/ggTrvC2pTV0JBpPQp2UHpPh3Mj+oru6BHKCuT/Ff1WvQrEwlunsS1GQXKJEOLGZCGyA9HBGRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nY+MSBVz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so231078266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067962; x=1708672762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UQjShMCN41Ts8SfE/2ISnD/M8GeYJsGe4+v2pFuM7Y=;
        b=nY+MSBVzSiP3fgwS8t4M1G28eUNk/VF2FNN3IqVeAII2mm+upVwQ3mp4U+hL9t/5Hd
         e0LmErkOn+SHvcg9O6+jGfWZAZAqnBEh6E+zdA5yOxvvk77tG7EQKdOlMt4mHoGKhrga
         lDEMxjoY8w2PoNXR6yOTQhIYr7iqK2PymN4Ce3QKRHRiCNxtU1blV/LFRazHWMixsAT6
         Rno7jKwo+RLxzQjjfOuX/zT4NjJwqu5o9JL5iO0hgg0htNeKJegu/5rNfuknmGi9Jh7S
         Lahtut4MOGn+6Yk6B2H9NRQbuif1MtTEpZfnhRYvEG1XZrdMG3n7csbE6kjBnF+SDrP7
         dYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067962; x=1708672762;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UQjShMCN41Ts8SfE/2ISnD/M8GeYJsGe4+v2pFuM7Y=;
        b=X4ciSoaVmOw/n7H8QBI4s9Fm5Z7cWK2X0wsSGbmhXCSnb9g4Ic7Ey2rwv3nA0Uc0tf
         xx3KrI9qYn5JMnRPBz5heO7uUbigP4fFYGJGWEdyT0TsD2uQVRoF2tVIkJvkLrmQX+qf
         XxVAIpZSNCKuJZ7ibwEGj+uThH8sgSojd4fp46cOHwVj+FKmUr1CJQfKDF9dfY3UBlhW
         3jc8p47YaZT9Q6cwGGuHAavblAUcS5qSZy/LAKt1k3h90zE1VvZ9z4IMVyvhhY6Opxt/
         ZtbJRiIrkThccSu/BUULB2qCtDvEbDQkP2s2t2+MFVrPTQj0vaGlKhlais6nveuQhjuY
         f2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXwewzSiUGE03Y3lJk/GCqQTpV+8aa+CcWgEyWxDkXl2Y93KJ7WP5SOnyGna/fLEWNIJztZiDEcZ9lJ2HjTzhtubFwb3Eaz1Bjbsb/6
X-Gm-Message-State: AOJu0YwoOvfU8DawTTf4zeAwqmTMrg8Zxurf+ssFWI+Yu0w3XAzZG0kY
	6DdLQMXl7obXmRPsnwegnb4CfYvzYCZnzRg6PIFywSwAa2EjKybXW3hqffUCaAs=
X-Google-Smtp-Source: AGHT+IF9mKdwXKqFaP966IwekhIrHTLvRqdrVw4aqMmn6Oi9e3Y5PM2CIMeGhRTNs05erCsIfxDuGQ==
X-Received: by 2002:a17:907:9873:b0:a3d:e22d:3d3d with SMTP id ko19-20020a170907987300b00a3de22d3d3dmr423704ejc.60.1708067961915;
        Thu, 15 Feb 2024 23:19:21 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id tl21-20020a170907c31500b00a3dcab6f8dfsm455118ejc.5.2024.02.15.23.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 23:19:21 -0800 (PST)
Message-ID: <263bb77f-b91d-4139-91a5-0ddeda0ece17@linaro.org>
Date: Fri, 16 Feb 2024 08:19:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: trivial-devices: Add qca,qca4024
Content-Language: en-US
To: frut3k7 <frut3k7@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Peter Yin <peteryin.openbmc@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Fabio Estevam <festevam@denx.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <20240207224546.44030-1-frut3k7@gmail.com>
 <20240207224546.44030-2-frut3k7@gmail.com>
 <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
 <CAKEyCaAy9U_qQ=pXPYaGetEuuuVuoejxjKPrG92fBFauy1wwuw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAKEyCaAy9U_qQ=pXPYaGetEuuuVuoejxjKPrG92fBFauy1wwuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 23:01, frut3k7 wrote:
> The device I use has the QCA4024 chip connected via the spi controller:
>         blsp1_spi4: spi@78b8000 {
>             compatible = "qcom,spi-qup-v2.2.1";
>             #address-cells = <1>;
>             #size-cells = <0>;
>             reg = <0x78b8000 0x600>;
>             interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>             clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
>                  <&gcc GCC_BLSP1_AHB_CLK>;
>             clock-names = "core", "iface";
>             dmas = <&blsp_dma 18>, <&blsp_dma 19>;
>             dma-names = "tx", "rx";
>             status = "disabled";
>         };
> 
> and apart from setting the frequency and gpio there is nothing else:
>         &blsp1_spi4 {
>             status = "okay";
> 
>             pinctrl-0 = <&spi_3_pins &quartz_pins>;
>             pinctrl-names = "default";
> 
>             /* Qualcomm QCA4024 IoT */
>             iot@3 {
>                 compatible = "qca,qca4024";
>                 reg = <0>;
>                 spi-max-frequency = <24000000>;

That's your downstream or fork DTS, not hardware description. You could
have several regulators not listed here, because your downstream has
always-on, or clocks which are not taken and works due to
assigned-clocks in other places... Sorry, that's not an argument. Never
use downstream DTS as proof how hardware looks. It is usually dis-proof,
that things are certainly missing.

Best regards,
Krzysztof


