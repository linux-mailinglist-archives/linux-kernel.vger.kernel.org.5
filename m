Return-Path: <linux-kernel+bounces-151508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F68AAFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26B7283B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE812D1FE;
	Fri, 19 Apr 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyPK1FO6"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5912AAFD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534960; cv=none; b=e0xTmPBIDiEUFbvdhuZisZ1Kc2G2yFJfcf/Zoe00GmpPiioa6+q681jjiJb5K/9eeMqop5oMVujj+jUEUDdN/51XFzYkWh84cZqxvbO4SutB3wD+v+AB5vTmIxky4H6FBTBkpHCw7ft/IgMLpYj1zIRSJIEnUln40GuAgAqe5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534960; c=relaxed/simple;
	bh=cNe7mRTp1ogXGH2CNwBC4rc6nQxiA60pp6uYOkJrEZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUqmbFDZP/s4UsFQOQm7oCS9iN10KQNlIp2QcgaHWtPZ+xAWpW/yMobu6ubaKkz9XdJqY/S2QQag8hpKMKz6GedGQrkkzz8tGye2drvaDzuIyXyoFKZmPAdsi55qNPP3+VU6L01Kn+S70wPH+Rr0BH0HOPUzTJkGTkTYZE8EM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FyPK1FO6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4f341330fso17863715ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713534958; x=1714139758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HWswkpbNV5pVk026bNcNJlNDUWrsvsyYmi3izHouWVg=;
        b=FyPK1FO61mMuKT50NQ8qYjrF9/dGHrMefyxrgrSK+5AHqe5LEOQ4c+vbjivVIeDZ2w
         LYTQPYYgbCRvoWETpQBR019ey1TBHnRzmy+mxUEnGcn3i5UbRduHDRduSw1ruFBi7B+v
         k5jZpi50bBGW+gdNE3bAcHtGISpCoAosv0wc3eInAI5Uh++Lard25nfcvA/PKIofVj89
         sOB4yWLNTHZqQVqf/N5PWB7c4C9kL5IQ/JyTNmoXvdWpEfeQbwV2o9uC/QzNxYEW/9W1
         lYwqfn1beaMi0yZXnzQykONoaS9+Kj4ja3eT8MHT/2OA/ke1IKBdRIEa7NEPqL1W4w8B
         4uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534958; x=1714139758;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWswkpbNV5pVk026bNcNJlNDUWrsvsyYmi3izHouWVg=;
        b=W23Y9+69GdT1rypFzGFy/pk9LlkAMFVXACe6y4G8zIgXZbwzH4oJ/XHQJ/7ocaKc1H
         DK7maVHD3Qq55cofNLzdR05GlH/JwdSU1CGXY8UWUCNUXRja80tZg2V7v0ypefdk8XvU
         vQIa05AvDmW5lfVISArawhhpAaW4PiRTF2QsxiQVMScBGkVt8spMmYxtpgS1JURxk2bB
         wlsrRSu3yoIrMprYrIpB0xghysjLfdlq5C7TwUJykN6ol3wC502Q+SVOeynSuT5q8n0I
         HLezXp9yz8SU3dz/H0XihONX/V7PIog6YfQ4mkfUO5D3dRsFf+lMpwnXAqdbB4O/qReo
         zkJA==
X-Forwarded-Encrypted: i=1; AJvYcCWuVXFhYf/MsmVdakDfPiS7iFUiv+sd2lNL/y9Cxvo65FmwOxjYI1W/WmAgVkmANeC+Dul0WxgNvnQSOlqKkbJ1XG7G3NHKv5m7GAs2
X-Gm-Message-State: AOJu0YwMyKdM+FHtwY4pwuScPNV0jd8/+0yBngxdxjTLXD9NZsChgNNF
	VbSju5UuGyI1e+4jv9gX7m8zGD0rsA180IXzo+xm1zxvxyC8tuYhEw7DwLrjc10=
X-Google-Smtp-Source: AGHT+IGITd8TaYR2TmwYbKTCTxNimDmszkDAym37priI7z47wvsoXX0D0V31EVkpO7qpUVx+mo/O6A==
X-Received: by 2002:a17:903:249:b0:1e7:b775:64bd with SMTP id j9-20020a170903024900b001e7b77564bdmr2401471plh.53.1713534958543;
        Fri, 19 Apr 2024 06:55:58 -0700 (PDT)
Received: from [172.20.9.36] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b001e904f9717asm213609plr.87.2024.04.19.06.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:55:58 -0700 (PDT)
Message-ID: <a0eee08b-17c0-4089-85eb-d645cbcafae3@linaro.org>
Date: Fri, 19 Apr 2024 15:55:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dt-bindings: counter: Update TI eQEP binding
To: Judith Mendez <jm@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 William Breathitt Gray <william.gray@linaro.org>
Cc: David Lechner <david@lechnology.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20240418221417.1592787-1-jm@ti.com>
 <20240418221417.1592787-6-jm@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240418221417.1592787-6-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 00:14, Judith Mendez wrote:
> Update eQEP binding for TI K3 devices.

Here and in subject: everything is an update. Be specific.

A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  Documentation/devicetree/bindings/counter/ti-eqep.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> index 85f1ff83afe72..11755074c8a91 100644
> --- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> @@ -14,19 +14,23 @@ properties:
>      const: ti,am3352-eqep
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

Why? This must be constrained. Devices either have 1 or 2, no both at
the same time.

>  
>    interrupts:
>      description: The eQEP event interrupt
>      maxItems: 1
>  
>    clocks:
> -    description: The clock that determines the SYSCLKOUT rate for the eQEP
> +    description: The clock that determines the clock rate for the eQEP
>        peripheral.
>      maxItems: 1
>  
>    clock-names:
> -    const: sysclkout
> +    maxItems: 1

NAK. That's just wrong, not explained at all either.


Best regards,
Krzysztof


