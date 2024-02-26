Return-Path: <linux-kernel+bounces-81035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E84C866F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08951C21FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893514D9E3;
	Mon, 26 Feb 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohczpYfV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09F208A0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939104; cv=none; b=m0xXwFJPHzb0beQbITls4N6GRXcmKJCUzfL2SVb2PpmUxHFkG6FNWOz4A/CqrxD3wLga6ACfkuN1O8ZjYT5/o9u6dimcDUXANsxqb9aX/tUMiU0mxNOGLXlLNKw+OMKcYoUef3/uy9tOzVtM2F8Q7f4v57bSD/97YzLcaopkf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939104; c=relaxed/simple;
	bh=oSSQbxewwkiCTAJJJjuwTTELqb9roNIFmZQ3BUDDy0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rC9buNbCvdliypF1G2W94ge37em59o70xUQzxKnmLAI4mO40yprDpFnpSWgTrS1hj3QmUDPgV7RAt+aZ5pupAsajbqYhvOCIszvX0HRhw3KWwHEhJ6Ae9Prw/ysAW0suLJf5CkFTYG/0+30omF1ZfTuCfchYGWEOcESkk0FZ01I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ohczpYfV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so3605392a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708939101; x=1709543901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucm6vFZxgjviA8ED6AOBXD2ZlZTqDUsseLQUG6Wd3NM=;
        b=ohczpYfVmkJw4S2WTdkmnR4zvvh3hsVidtwPJRXymmBP5UjXUd1LC7pfZDo09U4yYu
         9f8rR4u9kqASFW5Y6DS6YGX1miXcGzmhCh4wTqcBTGywGSelaU5RZ1Zjtom6DpWinX2s
         iMCb7xVYw+Ome+H2J4fLO/zO1F6Y6WUIv0FY4qb5UwUycJoy9L19iIPjEcp83zRBDBpq
         nar66jR5y+uFAqXSiHSSmHIoZwfXt19x70LnYuBrXC/WjIC/cOdetB4dRMmEBs0EH2n7
         KIBPNOyYX2dU3AAK+K3FZbkLsU932me4OIrmtvFhR5X3UoGunBNZiHqfpsY3Ukcqmf8D
         QfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939101; x=1709543901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucm6vFZxgjviA8ED6AOBXD2ZlZTqDUsseLQUG6Wd3NM=;
        b=oi0zyEZTWWTBxLqYmmwI7OmqJF7C5ni8nnW8asKNQzdtHBpPdv8cPOj8XifsFPPaFR
         tifh6X65fCmK6TzqIgYNxI41UccRFm3yXB2j0V5EWLKMFKzgQbbHvFzwtNxSilcSwz7x
         P8A0HhDwMbNa1sT7oFrO+4o9tE54wfq82miXRjjUbJ8AvTzOrIMOGgBlKYv9zj7CW8m9
         o1/CmqXtW83kik+SZsu/zuegR+pvHUF1yIb7qbh0TLaNvZADGSSnxv0UZ+AvkkGdYutt
         PTX6I59KZtk1G+chyQmIT2ZoinqVTdxIqQAcfiun54dwbJqVTiG5UiVuBYhjfKLkMKtW
         ZZFg==
X-Forwarded-Encrypted: i=1; AJvYcCVyCZcIKSnb/UsxIHgYYPEP58cuQ0tyrDhjEgBjmBnnXQPsjTzH/Rb1x8K4aHWTuyLMO31ZNJItw+PyXjEDZ6xxXwJ/KqpJXVy20LBZ
X-Gm-Message-State: AOJu0Yypj9u4E0xdxrZUWku0qiqSTWCTN7oChHDVLO8GN2fTONXl3lfe
	wyskdoX9m3E7mKUU5eS52WtlLcIvpFt+FjoIGCy2wBNWv3gUEQQo2M7r3UeKBxs=
X-Google-Smtp-Source: AGHT+IFSzRtV7hUd1SxBY54p3xRGDOmJfide+2i5AKgxhJIMRl1tmf+EwE1va4acICFG9JPe5pEW3w==
X-Received: by 2002:a05:6402:1a5b:b0:564:5c90:f521 with SMTP id bf27-20020a0564021a5b00b005645c90f521mr3995439edb.14.1708939101385;
        Mon, 26 Feb 2024 01:18:21 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id t9-20020a056402240900b005648745b23bsm2150707eda.90.2024.02.26.01.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 01:18:21 -0800 (PST)
Message-ID: <4c1ee741-a0e9-41f0-99e1-5c2a6da06728@linaro.org>
Date: Mon, 26 Feb 2024 11:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/39] dt-bindings: crypto: add sam9x7 in Atmel AES
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172310.671661-1-varshini.rajendran@microchip.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240223172310.671661-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:23, Varshini Rajendran wrote:
> Add DT bindings for atmel AES.
>

This would have deserved a better commit message, I (we) spent a lot of
time deciding whether this is the correct approach.
https://lore.kernel.org/linux-arm-kernel/342de8f3-852f-9bfa-39c4-4d820f349305@linaro.org/

> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>

Anyway:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> Changes in v4:
> - Updated Acked-by tag
> ---
>  .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml   | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> index 0b7383b3106b..7dc0748444fd 100644
> --- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> @@ -12,7 +12,11 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: atmel,at91sam9g46-aes
> +    oneOf:
> +      - const: atmel,at91sam9g46-aes
> +      - items:
> +          - const: microchip,sam9x7-aes
> +          - const: atmel,at91sam9g46-aes
>  
>    reg:
>      maxItems: 1

