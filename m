Return-Path: <linux-kernel+bounces-80716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC877866BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE62284644
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1691C68C;
	Mon, 26 Feb 2024 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJks3vWa"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63D1CA82
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934514; cv=none; b=Yxk9PHX8eDgWGa5j4PR8MmQfXdnpfoetGzvvTo6Wcyze7cBJazG3MxpQZd+OUp2nN62iTTtl1QXdr3yTxKPNGsKOW51ZxjHPpGgU19YpcnQFxHt6vO5wg/xziBX/XO0XKL07NIQbFXHO3vfgdEH4TTkIMRSp96NwgF33UOtABhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934514; c=relaxed/simple;
	bh=VGxWxy9skHW9/UiaM1LL46KGhCSFefhCm25LomCpg5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTin6wEpWi3MVlZdFv4HgSEqjVcHQtH0kvhlrtj4xTixi/a4o6bvgFTjJ79sWIONaxkg25d0VGyxQQiOsbY9efsesOegyTdWq/sBJiZ2DvzZv5Vv2K4RH7BUuGBXWIpW7RUddEZvKwANPUvtWMJeujGEIuqmXCFX6vdRjnN8vAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FJks3vWa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso3566944a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708934511; x=1709539311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUXF7KhDywrA7hvLz9/cRwe+/meEyC6uqfp1PEa82vQ=;
        b=FJks3vWaxGRA6GHL83Kg3AdOs+WZ0m/kBD23hdMtxojBkdyaPddNukofmw257PSRK+
         nth/MUcJSSFzNOw/DwCXRxZzmZzzYNY4CCwRjmQPiBwGUzP4S+lOWpCBP3Qt4ger3Xv/
         tsRgGST56HbiqUdjZ0lrUvwsRDhEVTEkM49p+basBWBgx8WFG6BMxXpRZ9BW6DI6isZf
         IS8IjFE9wuS0Ux5xTjSTSyiBPmcw91zb5nU3rDCju1YafXHCuJ3SDVn8RzaD3DbiAmkP
         wSMW0JREQz9x9Vx1VCSXeYi3f/TN3ex1rYTPB/9m/3kbUZ4M1r5/ER9fsSBga3n+cL7X
         l3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708934511; x=1709539311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUXF7KhDywrA7hvLz9/cRwe+/meEyC6uqfp1PEa82vQ=;
        b=XTTqnX5mcJmZyiaZxbv6VebSyOpSEG0gotwEhscjm9f/fBR3kbvA5YYmT5p5g/GpqO
         Y1iiBnhbseNpwLeGGC9ziKGtisEOBcw/rVKzYY0/gYPvGC1XOLLKNbXL/CcDykF8iMu0
         s0nA7dGFg36goPnOMVequCKr7J5nqMBM26lSp7K+T8IlsSZN3SR7uz60nP4cruqIljoE
         J5oU0DHWK7hUFS7nVkaQE6ml5g1ez3HFdGidlQufP5v9dXd7h5iGsCgFqMqMNIv+DM9O
         MN8IZqA31v3HGgVeTP3XGN6aWjZYQK4VfkBUwlkFsxDwK2F39w5cihyrOkzPp8GEhmHw
         uAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Bq/n+8Q1Or8t0qrZyjmHHmIWnkohwQepVwUhcsj8c5Mb8g+hjcoRyI35EoMgLuSO/APxG7H+8n2TZvvt8WRahhvUJxjTaDEpgMra
X-Gm-Message-State: AOJu0YzDPYE9Cu5ixBdja2UaRKhgxs8WLOdaKeKEqDsprgO4PPNJATRp
	mDacWGCwyz1Cq0/AVbAq/n801Bh4lr7P1qU06prLt0x0K2kRpKGUTW+OyIpxYMpcqK/BC8oIxtT
	6
X-Google-Smtp-Source: AGHT+IFyWjHSVF4dvCCMiYIPLpQhIt9lexeXyEpjA5Mi3B9gAbJQGNDvRjTpLOT8qPFZXZkBH3mz/Q==
X-Received: by 2002:aa7:d297:0:b0:563:ccd1:26bd with SMTP id w23-20020aa7d297000000b00563ccd126bdmr3970060edq.2.1708934511019;
        Mon, 26 Feb 2024 00:01:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7cfd6000000b0056536eed484sm2102206edy.35.2024.02.26.00.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:01:50 -0800 (PST)
Message-ID: <5ac7534e-3fc3-4e96-84af-035ea30462ac@linaro.org>
Date: Mon, 26 Feb 2024 09:01:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: simple-pm-bus: Add optional resets
Content-Language: en-US
To: forbidden405@outlook.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240223-b4-bus-v2-0-da8ba83c1a5f@outlook.com>
 <20240223-b4-bus-v2-1-da8ba83c1a5f@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240223-b4-bus-v2-1-da8ba83c1a5f@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2024 11:10, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> For some on-soc buses, it is also needed to deassert the resets before
> access. Document it in the binding.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  Documentation/devicetree/bindings/bus/simple-pm-bus.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml b/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
> index 182134d7a6a3..430638104980 100644
> --- a/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
> +++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
> @@ -14,8 +14,9 @@ description: |
>    driver, as it's typically initialized by the boot loader.
>  
>    However, its bus controller is part of a PM domain, or under the control
> -  of a functional clock.  Hence, the bus controller's PM domain and/or
> -  clock must be enabled for child devices connected to the bus (either
> +  of a functional clock, and it might have a reset control signal.  Hence,
> +  the bus controller's PM domain and/or clock must be enabled, reset control
> +  signal must be deasserted for child devices connected to the bus (either
>    on-SoC or externally) to function.
>  
>    While "simple-pm-bus" follows the "simple-bus" set of properties, as
> @@ -49,6 +50,8 @@ properties:
>      # Required if clocks is absent, optional otherwise
>      minItems: 1
>  
> +  resets: true

If you have to toggle some resets (and often actually in some order),
then it is not a simple-bus anymore.

This looks more and more like a one-binding-to-rule-them-all.

Especially that description clearly states: "does not need real driver"
and "typically initialized by the boot loader", but here I see more and
more of a driver, and more and more of doing things by Linux.

Best regards,
Krzysztof


