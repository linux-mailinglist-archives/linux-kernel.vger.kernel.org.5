Return-Path: <linux-kernel+bounces-57561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CE84DABE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB9E1C22420
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1E69312;
	Thu,  8 Feb 2024 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMiHKeOK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78D69317
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377761; cv=none; b=Rm3OgTYjr5hGb9Ai1CLad0ScjvPTgM/J5IsoElfsb/7dP206+XGck5NiMv7ShlFmnJX64UBBQ1um+AzW8hPGXBpjMBNuqL5yT333rPYO4Tpoc8iR6/cugvLVloR7KRDVT0I/PY4W9enUuZ1XQq0RyFdbc9yTWdMvXD1Qp2p0DbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377761; c=relaxed/simple;
	bh=aa4kb9kO/6HwC2sBMZ3XN3dRHiFy3qv7hZpu+moe0TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knZnylXb11zaqWmjwnhDkHZMVpiQjOaT9uznoevzejO7FCjofxIBQ9cJ/M94DkFSnYWaF3M+99y6FR+EfnF5dl5IAy3AFeeMU+FPo0olY/T2nHirBo9joANjsxlgPAxBGiVeNIem7uxk6S3UQmlfvcOx2KkwyTN2eDQ+dCe8aF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oMiHKeOK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511717cfa62so50314e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 23:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707377757; x=1707982557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHpbOFu/QuBJdf8RtOBlFdjZPcdlWvuXyL+y5YzzcMU=;
        b=oMiHKeOKZuMWbBiC+nxn34wjNp3Y/yrxp+xmM/IZvn4ORDl74f7I4XzU77QIJE/Qnb
         LEC92RZHFfvgdtUo7bT4aHplK1vqGMnG/ygo5i32YzcLD3UlCbMFhMq8zOv02tDmAWI5
         pnTWQqU0oUAkFDBl1GWbgU31gHzL6iKxlL4knm7/nKtOAQgNMNCysLdm4YcK3iikIz0r
         JlldrsW8oGOKXeZMM8i09Jsc5EmxxIHri2wGWv0og6nVrZNxewSs+pBA0YXCQOa+1SG2
         YIBKCAOIVQR9zRvVE0RzFI5jfFxNV9EeMNhbAyLR3YBK6+2RDcc/yi0oRb6d2kQb0Gkk
         ggjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707377757; x=1707982557;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHpbOFu/QuBJdf8RtOBlFdjZPcdlWvuXyL+y5YzzcMU=;
        b=QXCzc7F9R5S3FjS/kk04TNuAHNdO7mzPxeFS20C36Kgcn19ziN/fO1AAHF+kKC2TV5
         tjr1Ff7A/RfuFMMJ91OVnrvBKtiGDcnAWO+bthCur+CQlcwo+6Wcll8fr1cv8tbFDQl5
         R0fEipEdt/715UBzVkj+NgFiIVcD55i8KE5GNVKdGblwKdVCwlDHd6kGkmsoMmiNdCBn
         SG07oKmL/W+pSEP0lRxC7oBD5FKncStuqONRnuy+hwPi1Rm3aKnLhaFE3Nx//uUbdkEq
         L3HUmsfU2cSlcmCeEUrDRyb7Dd0wQfSFoDLQWM/toNQaRs0ClicDlU0jaKYihURDHy7o
         LSyQ==
X-Gm-Message-State: AOJu0YzCvnFZ69AZkq3qV1Dumu/TJLbHonWB8tB7j0OjGYA1UmVf/RRx
	dbHd46xHDap3+bpF9M54wPSAsxcy7DlxSCA9SbcEczhH6AKfqYr6+yAVmKJVXmY=
X-Google-Smtp-Source: AGHT+IE1ekW6UHnPSaA4BmQS/YftDLK8dpKt+2/ogJz0ziwHXjkjb4lp6AD1nXZjVOkmfGSzxM9YKQ==
X-Received: by 2002:a19:f607:0:b0:511:5686:f96c with SMTP id x7-20020a19f607000000b005115686f96cmr4903799lfe.58.1707377757386;
        Wed, 07 Feb 2024 23:35:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXq98nwFTu52b/Bs08gC+H0DEQqiy35XS/dquCUb+NCBDXTGyoHPquMgBZPTiPPORenDEJRMHT/Rne85Qn9hMUiM7xljqVb/WCH+ZG2Va+ofuzy3uuMHx3RPowrvWVjsM9/2//t+vQN0529JtqzBTeyZLx54X2Vy9tSVFTBr3IvX+pz1VTdaXhA4KK2YQ0mE5XRKNcC7KhYz1NEQcUge4+fC/TGHr8NoPvgp+cJE/VQRtYT4XlNXhJNKdcYFFn85Sk5kfaAGndNLkuSlvcdOWydMno9N0Xvm2IRvWsK00w/lI6LEQaO3PEu1WcuJjC0pNGWlrzs7FGuOnmqDsRiWX/vKw8lOFdj1M6vgORGszGm3vEI5ZZXXEVaghfWPMtNssGyukkEDHH8IuXLneuu5DvK+CJIz6VJvZoYc7Awer8l1RyjYq4DkOVxPPAKM57DiITcXpHcKvIDbO5WN7RJOZM1G3yF0G7ytut8Nv0SZNd54bxQerOoMIXLRA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b0040fe0bb761dsm788153wmo.16.2024.02.07.23.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 23:35:56 -0800 (PST)
Message-ID: <a4949983-f6ba-4d98-b180-755de6b11d0f@linaro.org>
Date: Thu, 8 Feb 2024 08:35:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: dp83826: support TX data voltage
 tuning
Content-Language: en-US
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bsp-development.geo@leica-geosystems.com,
 m.felsch@pengutronix.de
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2024 18:58, Catalin Popescu wrote:
> Add properties ti,cfg-dac-minus-one-milli-percent and
> ti,cfg-dac-plus-one-milli-percent to support voltage tuning
> of logical levels -1/+1 of the MLT-3 encoded TX data.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
> Changes in v2:
>  - squash the 2 DT bindings patches in one single patch
>  - drop redundant "binding" from the DT bindings patch title
>  - rename DT properties and define them as percentage
>  - add default value for each new DT property
> ---
>  .../devicetree/bindings/net/ti,dp83822.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> index db74474207ed..6bbd465e51d6 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> @@ -62,6 +62,24 @@ properties:
>         for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
>         to transmit data.
>  
> +  ti,cfg-dac-minus-one-milli-percent:
> +    description: |
> +       DP83826 PHY only.
> +       Sets the voltage ratio (with respect to the nominal value)
> +       of the logical level -1 for the MLT-3 encoded TX data.
> +    enum: [50000, 56250, 62500, 68750, 75000, 81250, 87500, 93750, 100000,
> +           106250, 112500, 118750, 125000, 131250, 137500, 143750, 150000]

I see all values being multiple of basis points, so why not using -bp
suffix?


Best regards,
Krzysztof


