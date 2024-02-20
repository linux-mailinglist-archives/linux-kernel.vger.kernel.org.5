Return-Path: <linux-kernel+bounces-72864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F077885B9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C941F228D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11C65BA3;
	Tue, 20 Feb 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqopVx7G"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1F3EA88
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426613; cv=none; b=hQHqn10PY9PRy2FAIFt/A3BH0vMuEi2aMUUcKclz74q+VLFIItTC6eW2Zq2Q/r0dd454/+BW6opvPkyH/RmVI+7LHJgNKOfiuY/aIHKyX8BTqv4ntzGhKNdJGUD264j2Nhw+XP7YUCmEEzCzSX9ZyjvnvRqIfhtN4w1+ae4nlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426613; c=relaxed/simple;
	bh=nWQ92AIuovPEq7nxx7/tay/7jvNblznRUaxt3Xz4H/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWfAHrL90Gl1f71ggufPZ9S6btAfICuH+rCf0fhqv4tU7r0Kuwp0SiP5g579R0BiNtmFGMqZKo4j8ygEkeJI3hOym3ijryCNtX2JHYUdQjTWSbeUb6It9vueI4TK56vDxKjPhISYTzsVZZw7/3g3lrnm71SMIphuRFXggcH2KZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqopVx7G; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so222218f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708426610; x=1709031410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FwM7K8WiwUEU7a9HGJEH4r3DrCZNFS2j+599+gDIDY=;
        b=uqopVx7Gcthi8/fQA2mO959WcvRhmCIT3r3pDQMtHNSDkkK4rXjL4qXqiDe6aeiadu
         SucoWUg3FyEFn1vtJfefoSe/MyNBy1zydnadMPjo+U551JoJfiOJm+3C4oYvZMiaBvyD
         ti3z/5adppthUIQQZ6dtD9zXyRChqz80T/4Lfgl56h7MqHpBxAuAGQmi3NXhwgxxjsbj
         UzilPHWZ7FfbkFhkaPLP5NibJSMnahUfAZwQJVjMb4oFQARP4N2Q17knMkYZWVZRo/bz
         4h746ydI7DrRjM6j6Kzs2eWWpxk/c6COB7Ohnee0HH4MmPq9MJePWQ0iK691QfsJ8U3S
         TbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426610; x=1709031410;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FwM7K8WiwUEU7a9HGJEH4r3DrCZNFS2j+599+gDIDY=;
        b=Pvo4l4TLk72qYuanP+pWphm41DfqllSbq4LvkfHw5qAhOXCQFkiFEh9djRIIXOKvjT
         /VA+cyd8Hh+UOSZD+jDWAbBBAU4ao8rifpU68BZHWiksE+StagLwWwz8SNDFo+CvYhkf
         QPYB9IfCPfY24WGwsOZ4u8022K14P8Rd3ruQCUeNgV5wmHqcs49fNRK8x07sTd/5mbkj
         x9+vu5FYknsjGM2XON/VsBpanLw36ohwQfJBWbSAvEMoAjKnMz/2uJYAj/suQp9qytqg
         wIPpTwVo+bII5omELxXZ0aFuE15EQHDUP12p13JzLSCERwPEg67lAtside9JxiIg3vFQ
         MAsw==
X-Forwarded-Encrypted: i=1; AJvYcCUoO74XTdmDY34m/IejpVxp3fb1t1DnNpANxbHaFPN5DI1X4wEHr9VZ+MG6vDF06Ij3yY5NP0HQeNLataV2BLHZ9Pypgp5ULpisJaUR
X-Gm-Message-State: AOJu0Yz9ZBdtC4KLpql+Dvmo9raswCcjFxsxhSMbX96rXgAaLHKOEplW
	UMsvxjnX8YzPhmk7Bv4JK6ElwrmPle4Bi3GpPrZhDF1R5CNKdZMyyLjv///c4kY=
X-Google-Smtp-Source: AGHT+IEifoW2VfhCdiEiYcUvBgw89zA4PAjhkrY6kCn0VZDOabUK2dWA2kNdlTsGGEtNrjbxcsiZ/A==
X-Received: by 2002:a05:6000:1a8a:b0:33d:3a00:554d with SMTP id f10-20020a0560001a8a00b0033d3a00554dmr6143760wry.8.1708426610238;
        Tue, 20 Feb 2024 02:56:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id h7-20020a056000000700b0033ce214a97csm13052019wrx.17.2024.02.20.02.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:56:49 -0800 (PST)
Message-ID: <25fde6ca-e1f4-4ca7-a534-efaae8a2a324@linaro.org>
Date: Tue, 20 Feb 2024 11:56:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] clk: samsung: Pass register layout type explicitly
 to CLK_CPU()
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
 <20240216223245.12273-10-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216223245.12273-10-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 23:32, Sam Protsenko wrote:
> Make it more obvious which register layout should be used for a CPU
> clock. It prepares clk-cpu.c for adding new chips support.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/samsung/clk-cpu.c        |  2 +-
>  drivers/clk/samsung/clk-cpu.h        | 12 ++++++++++--
>  drivers/clk/samsung/clk-exynos3250.c |  2 +-
>  drivers/clk/samsung/clk-exynos4.c    |  6 +++---
>  drivers/clk/samsung/clk-exynos5250.c |  3 ++-
>  drivers/clk/samsung/clk-exynos5420.c |  8 ++++----
>  drivers/clk/samsung/clk-exynos5433.c |  8 ++++----
>  drivers/clk/samsung/clk.h            |  4 +++-
>  8 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
> index 4c46416281a3..21998c89b96d 100644
> --- a/drivers/clk/samsung/clk-cpu.c
> +++ b/drivers/clk/samsung/clk-cpu.c
> @@ -464,7 +464,7 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
>  	cpuclk->lock = &ctx->lock;
>  	cpuclk->flags = clk_data->flags;
>  	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
> -	if (clk_data->flags & CLK_CPU_HAS_E5433_REGS_LAYOUT) {
> +	if (clk_data->reg_layout == CPUCLK_LAYOUT_E5433) {

Why flags cannot work for it and we need one more property? The point of
flags is to customize the variant entirely. You basically split now
flags into flags A and flags B.

Best regards,
Krzysztof


