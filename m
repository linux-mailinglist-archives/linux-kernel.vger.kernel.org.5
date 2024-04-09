Return-Path: <linux-kernel+bounces-136363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C94F89D32C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407A71C20D16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B57CF17;
	Tue,  9 Apr 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ws8ji/tr"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5D7C6CC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647907; cv=none; b=jM8JG18QN9ToxEjv+cTpG9UMn7VAM2UzNne0TfBjnuKQdop09/M1asC+/acEU0ReTkFeJT96umHdeftJh0r+3HyECx/TRFGtnYxe01Su9l6kEMWG3CfygUCW778JnYk/iS5HZLPUN5UJPZ97fCBdZ7VzxCAtrU4MRNJ7x+1GpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647907; c=relaxed/simple;
	bh=UXBI3jkfowP+aEooQOQ8YM7SLHKhkm3eloke9hnpAz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6u3CUmAk4IAhfVdsR2UdVhWwyTdWG7nMCoY6swAkLYzV+xM5nR1ORgQ3aOpdNfQtKO0gFTmaomS/dKmZ7f8RzuUS+CpD4Cd/H4IYQQpwIF1jV5/8wiv/ysxvxxyRHPyCoQu8LaRoi1rZiUeQ0VV+2m7SKIt3tvRYem3KGQO7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ws8ji/tr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4169d7943c1so4951525e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712647904; x=1713252704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XodvKHmeivrTAnWcFQmCBIvpL3LJnIspAQXrfoilb6o=;
        b=ws8ji/trSUKSrEKOvq9kxZgWxLfiHELyN8P620+BgBI6LuHOew38ymdlBInvugApfq
         qq9twIxw80/xdRl+rFbl6f5nvrtPazELdoIjVX7iIfB12ynWnWB+Lkgi+tet+Xb0+bjc
         lDqFBoWdH4tAqIok+vdn2zBwzF1D1a+bfuXoTbnW6CRQd9syYXIcV2mXloEZn1Qu4bOS
         idVjn8SnCnOko+0ll4hP7jfKLMI/fEBSe/qH/jpE2kazw451ADGTEorYZueA4INpFm3H
         dWnBr+9rtkVRKLjt+BNq0UZlkwVBG/PiwqqJfA+41u+Ht35+5WL9ovcs9pabgGTRF8/2
         6J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712647904; x=1713252704;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XodvKHmeivrTAnWcFQmCBIvpL3LJnIspAQXrfoilb6o=;
        b=ffcl9a97p6arDVpEF8GhwtSS4D2hzLz3WokmprPH8b0yYBivYpbsK++ZFRYKEcB/Kh
         FPJ+dRCTsX4zls9XH0X2OVYA8Pdeqa7IuxtdcFN8glkYNjlXthIHODnip1PjdnVQheJr
         8vul4vxOf20oTQR6cV4yD15nSdTL/vcS/V1wA4yOr3kUs1j8SwZwdfO1HTim+jsNra1u
         pRg/Z64367H3OuzVqnLcqSLHgrtXWB8DrP70ECZ9ZmoCFFSYBBxnb/YDq/G7gEL2NpJY
         r0RNlQr9SVZasukFbVyzXuc8wyikLmepJ/9VdccNS2sP4IGS8PS2SY+JWkcuwdHVVH40
         3DbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXootCXv6juN7ytJhmaaQwL1QRXgWrRGH1i/d+yiaQqcx7E94o9MUMYzNnnHzoeBYmOqbrrYzqYDB5xKxEGNS1TuRItxKOUIN6dayGN
X-Gm-Message-State: AOJu0YxEjwn3rWCAD1jxKxARpOVZXSnCpCKg4F+T6d8PEtc5wjonXjCV
	ZF5ilGHeScNrM5BWpSeq933o7aG3PszPA7n31juMWkQDvP5IXpFRq44XN2T1edg=
X-Google-Smtp-Source: AGHT+IHtlbvg+rc7iLhLk4eBnCt0v60AAV8s8p2cpNnLl+PHZN2yZ6/Iuf0hcbczXexSE6Q2g1a7MQ==
X-Received: by 2002:a05:600c:4f83:b0:416:9aa9:ca3f with SMTP id n3-20020a05600c4f8300b004169aa9ca3fmr1357057wmq.21.1712647904399;
        Tue, 09 Apr 2024 00:31:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id be9-20020a05600c1e8900b004163ee3922csm11364127wmb.38.2024.04.09.00.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 00:31:43 -0700 (PDT)
Message-ID: <0bb1e7d3-ff2e-40c3-84cf-67f36278d2e2@linaro.org>
Date: Tue, 9 Apr 2024 09:31:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dt-bindings: rtc: orion-rtc: move to trivial-rtc
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-1-c447542fc362@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240408-rtc_dtschema-v1-1-c447542fc362@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 17:53, Javier Carrasco wrote:
> This RTC requires a compatible, a reg and a single interrupt,
> which makes it suitable for a direct conversion into trivial-rtc.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/orion-rtc.txt    | 18 ------------------
>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
>  2 files changed, 2 insertions(+), 18 deletions(-)

I assume you checked if any entry in MAINTAINERS needs updating.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


