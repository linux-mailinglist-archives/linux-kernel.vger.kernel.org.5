Return-Path: <linux-kernel+bounces-117710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF6688AEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8EF1C60FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCB84D19;
	Mon, 25 Mar 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJebxdlf"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3765C900
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391399; cv=none; b=cn94YBPU8+JQZ3Nl5XNfRF/HwL1AUYMy4PSvQsw87ttXf3XBgichrzx/PgjWZCrKinlkbHFosmRYGwqkQj3W4gzB9OGj9/+hahUIWkr834ip5XNJu/eFNd64tNqh816uJ8ehh9aejG2Nq9wzA5EABGqovdfbkoAtaWFup5TSLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391399; c=relaxed/simple;
	bh=5A9bEatgpaVNwlc0KnC+nlXHE1Xh2u/nUrUsbXyNMlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGoXVmQznvsT4bq4tWLseUBGZDqNI8Wjd6AodpAyKIu5Lnb+ZixwovFGc0q4rxtmeVlyI5YnR066qQBrtyK1ENzlHfszxICFWdnbkwvQtTf7xsHeDWlQbCuxrbw4gtTpMgwDcUBy96LCE8B+PvnOAdNBd8XSMx72+EOWlh0JrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oJebxdlf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so804962166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711391396; x=1711996196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O74EmUiSstjmybMjda17zgqbkXw0yJnE6sWYaC/X1YY=;
        b=oJebxdlfnfA86yzCEkNJeXn4si8qSArspOyTmH46ASAVzhxEUVX2IiAWaVQnYinm3m
         X0TXPvR3gfa3Coxa3ZOOzYYkVv66UaXHcSNf0IwtWkqNwEfUQPUacWg/ipoTGKSEWLpb
         gsxJ3X5KX/6T4V28XF/iUdl7aXmcsp07/Ko24hJde5RY1ad8CPrYp+hCsMmQ7BV4BI3u
         7E25fJKhm3wKPgbs53ziZYUCXygjzkb+kh4A8TFYZHjsxC8zQRJ3kdDQllTJ4M9/o94+
         ozx2GADjHfdZBib0B8uzWTnWUNy1VAFtl9qZ5UyUuKAhqSlQFJZGLH4zXCq2reLZXlb4
         XFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391396; x=1711996196;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O74EmUiSstjmybMjda17zgqbkXw0yJnE6sWYaC/X1YY=;
        b=AY6wvAeNmMXgq4YE9Dfs0I9bePQ6LatNKN2eHzrei4dH22s6NjO9SII+wzV26HRWmO
         fijX5eZA8syeAZJ1ED9PVYyCfnr/vMD0TKbNCq3Ygzp4Zr9OjA9WSNI1GhrQUoMjQYCu
         SXeVkZTB3zi8anGe3mHmjTSsM0GESwfKfxwmDjgIvWckcsiK4XpU0kHGYfSs9FVnrtkr
         nCs2wzYAQWye73q0RSzx3MrWmZlP27pzuQfJL989QX6V7UR/izDolukcKmDxwIo6FFWL
         iDPDXKS3tUMPPrxSZoYTUvC7MYvqgPYhhN8fGnjDGOVX9fTmv7ZF1nFbFnvdcZPzuyzt
         /AmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1OO7e/rc+TDhm1s0NnDpQrYaqrIEQMxKBfwP4RGsvGJhpSWhF6SOhC5XqR27l2z440kZ7HSgQyZNsvWb6vQrzANYz3Wflhnj/q9ES
X-Gm-Message-State: AOJu0YyYjcMK8W46FcVGQShC3tVDkNQUonSZvxvP2sNPHn8Uhz0h/FWX
	6SJHnbXxUgo2lwz+Can9bpwfAP94YViYMTibZCvvJHYGy7CqPf3QAIHOSoeRPm4=
X-Google-Smtp-Source: AGHT+IGVdXsdSroplgg7wqHIN5VNzTN6/mXnV+YBCm9y+0BV0CHmxVtZTbktg8a2Ave9EZuFzWzC0A==
X-Received: by 2002:a17:906:744:b0:a45:f9c5:3024 with SMTP id z4-20020a170906074400b00a45f9c53024mr5625453ejb.11.1711391396204;
        Mon, 25 Mar 2024 11:29:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id lu7-20020a170906fac700b00a46a9cdcfa5sm3290491ejb.162.2024.03.25.11.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 11:29:55 -0700 (PDT)
Message-ID: <dc4251d1-8cbb-4a0c-834c-26f16f3f9484@linaro.org>
Date: Mon, 25 Mar 2024 19:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: add heartbeat led for stm32mp157c-ed1
To: patrice.chotard@foss.st.com, robh+dt@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240325170656.2829600-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325170656.2829600-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 18:06, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Add heartbeat led for stm32mp157c-ed1.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/boot/dts/st/stm32mp157c-ed1.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
> index 66ed5f9921ba..bd727455a7e4 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
> @@ -24,6 +24,15 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	led {
> +		compatible = "gpio-leds";
> +		led-blue {
> +			gpios = <&gpiod 9 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "off";

Please add function and color properties.

Best regards,
Krzysztof


