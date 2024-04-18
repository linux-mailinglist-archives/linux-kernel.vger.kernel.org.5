Return-Path: <linux-kernel+bounces-150592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3F8AA15E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110342849C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A1178CE4;
	Thu, 18 Apr 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZU/XydkV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E4175564
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462539; cv=none; b=oIM61XvEJd1/PVvG1gEz9OwAw7Aj3QgThySQfOQUwRlZH9YZQ6lkwiftNIykhHRNxp1CSmg7UtzWNrLuuFZzi2CJQ4NsfTJW6iuyNX2i1zbMfXwui0nitxzGqhedyyu277v8mp1/Ho4cFM/s3q1ipy8ANSY3VrblahZPvwgpowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462539; c=relaxed/simple;
	bh=/sLaLMxm/pf/57nX0v8l6P5XGG2k0kKxF4s+SUGkz94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1An3SYKR/r9OjRBvnsD7tsWhlhkkm2srUg/nZg5p81s15+rRbrGyCQTBVOWeQNPQD1ui/lNKyAxUQVwNWr6FUt7ltxXdeJhQ3bveDcv94B12lfhSllmFJuogrpj9ZNqJF4P85rpozkRGJbEIrOImFjWjXQxW7+WftVe4qruEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZU/XydkV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e50a04c317so7130595ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713462536; x=1714067336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8AGJ1IQ6tiz/LctjwygF7HGXNoi4FqqHByIEFe9p98k=;
        b=ZU/XydkV7vrC/DFtkZBIzxjnLW96PK13TaivnxA8DEq+WucpjYMres+q62tkcThiEu
         Vmhf1ECBt+0x4Kc1P5Php+PrT7HhFipGRPWacOTXXvSbPDrTWHhHuuYYYkPavVb/flXU
         admY0f0fsbwzUWb0wmOPrUAouc3MEJF1bWpmFWJTLQrKJk6hvGILVPc2uquDsUKwdEcv
         owovZC+iMnj+z9QcusIzvSejExYc72i4GEPUeqYLWAQsFEYcW0/WiEF2IdGyZqDwZGCj
         hwsDgNkMuLDl5NJzSDVMwKgy5JP2k3lXQ410xk2myqyj9untizCfy+3KYZW91ediJMaE
         Jmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462536; x=1714067336;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AGJ1IQ6tiz/LctjwygF7HGXNoi4FqqHByIEFe9p98k=;
        b=s2wCKzDo499IJX9q4dkJqvvLE2Q1Ab6e4v3GU8HYfCN1zxtA9WiV+gfXjHa7KwIlSi
         vIBI+fhOdbhiPsKA0bly0Mx2gnMgp60YbbyXhGaWJ2ivFiUIlYxHQ8JXbcARoljFPvmQ
         Ffb3ZFkgPBPW7/upiEnLwg5kGQArBb28ta3BicGiZoip96rvqN9+pZcq8t4D7YloDaX2
         GOchgzyydQywSIoaCDgNC++TCZnw90Hvzrp67MP/W9R7VcaBqCbgsqfmCsjxF5P12eEx
         OJNsLOA1EFudMJZY40fy7vn+M2m84cVPwiGPMGInW9lAjmIjHjm5OxaWyKMd6V8Mfpe+
         ailQ==
X-Forwarded-Encrypted: i=1; AJvYcCX73dCp1jeeEiXJwacnpqoyohKaTcUt/w8L7lkG5BAoDt0Sv66oE7Kl/EJ2+od/n2OpZgFMR1qc+0opoZpWYhvvp5UH+n2Hd0L4RatE
X-Gm-Message-State: AOJu0YxqXFJGwruJy5Ap9PemQq2jGxcE0V/MmSnNlD3RBO4imyfRZGJh
	MeEV8OWpOWBzW4oIu3TbDjk60CYRLse4DazQgas9dlxurTasWaLY+aDR1JxFQF0=
X-Google-Smtp-Source: AGHT+IFXBtZK+50NTuoGd+hdY97CGgC9O7nIgQHJlu8xnk26yefg9fLqJEWB5Xh55v0ss5+wj7vBww==
X-Received: by 2002:a17:90a:ea07:b0:2ac:39d9:dca8 with SMTP id w7-20020a17090aea0700b002ac39d9dca8mr864248pjy.31.1713462535839;
        Thu, 18 Apr 2024 10:48:55 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.159])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090aba0100b002a7b1c7db84sm3515191pjr.2.2024.04.18.10.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 10:48:55 -0700 (PDT)
Message-ID: <35f11a74-6671-4d43-bb68-6391be2d576a@linaro.org>
Date: Thu, 18 Apr 2024 19:48:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] spi: cadence: Add MRVL overlay bindings
 documentation for Cadence XSPI
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-3-wsadowski@marvell.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240418011353.1764672-3-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 03:13, Witold Sadowski wrote:
> Add new bindings for v2 Marvell xSPI overlay:
> mrvl,xspi-nor  compatible string
> New compatible string to distinguish between orginal and modified xSPI
> block
> 

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> PHY configuration registers
> Allow to change orginal xSPI PHY configuration values. If not set, and
> Marvell overlay is enabled, safe defaults will be written into xSPI PHY
> 
> Optional base for xfer register set
> Additional reg field to allocate xSPI Marvell overlay XFER block
> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

You already received *exactly* the same comment. Can you respond to
feedbacks and acknowledge that you will implement them?


Please provide changelog and explain what happened in between. There
were several comments already, so did you implement them? Were they ignored?

There was no single response from you.

>  .../devicetree/bindings/spi/cdns,xspi.yaml    | 92 ++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> index eb0f92468185..0e608245b136 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -20,23 +20,82 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: cdns,xspi-nor
> +    oneOf:
> +      - description: Vanilla Cadence xSPI controller
> +        items:
> +          - const: cdns,xspi-nor
> +      - description: Cadence xSPI controller with v2 Marvell overlay
> +        items:
> +          - const: mrvl,xspi-nor
> +
>  

No need for two blank lines. BTW, that's just enum.


>    reg:
> +    minItems: 3
>      items:
>        - description: address and length of the controller register set
>        - description: address and length of the Slave DMA data port
>        - description: address and length of the auxiliary registers
> +      - description: address and length of the xfer registers
>  
>    reg-names:
> +    minItems: 3
>      items:
>        - const: io
>        - const: sdma
>        - const: aux
> +      - const: xferbase
>  
>    interrupts:
>      maxItems: 1
>  
> +  cdns,dll-phy-control:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x707
> +
> +  cdns,rfile-phy-control:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x40000
> +
> +  cdns,rfile-phy-tsel:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  cdns,phy-dq-timing:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x101
> +
> +  cdns,phy-dqs-timing:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x700404
> +
> +  cdns,phy-gate-lpbk-ctrl:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x200030
> +
> +  cdns,phy-dll-master-ctrl:
> +    description: |
> +      PHY config register. Valid only for cdns,mrvl-xspi-nor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x00800000
> +
> +  cdns,phy-dll-slave-ctrl:

Please use some easier to read logical properties, not just register
values. Specifically, this is impossible to review whether any of these
are actually OS policy, instead of hardware configuration.

You also miss constraining these and reg per variant (but that was
mentioned by Conor, I think).

Best regards,
Krzysztof


