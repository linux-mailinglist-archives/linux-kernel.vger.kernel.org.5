Return-Path: <linux-kernel+bounces-95657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4228750DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD9BB265F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FCA12D77D;
	Thu,  7 Mar 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZ8Jl/7P"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04012D740
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819407; cv=none; b=IM/HL/H1ChUaQSsaZ1pTYHB8lGv21/2qMZqizxMDWgtFYBbPZej43i4kW/yJ5TDDDlyiEceexEOTXsQwP3J3CoHhb8Zqj76QuEpAKawJnvPmseTx2FZxRk+N+Yp2euSmgBiZ3HpRqzFPJAq3FIrSsEhkSrvKLRWXejjbzypviOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819407; c=relaxed/simple;
	bh=vnd4c6cnqj+rJdtFd4bvEIxjpJ0lqw1Ghsmui5MeXx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5wwzB0/IRklUY1ox7iIg9KVURlaf6MDdo4LQwbki3bCCXY95azhYk1JFM00YO9Az/3nMYv7GUPCSBiWeJZubmfwg8BEGrx/3UITxf4wtJ9QEC5T50jkNZzFptJeTMevq8wgEmBRx/ONgMme9OSulcBQgfOwa32ffvCD72AIfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZ8Jl/7P; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so3778317a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709819404; x=1710424204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zCf/JC5V+iuDVBUGqSJGfNyePUZ8s9c9+9aUy2zAN4=;
        b=pZ8Jl/7PfgcWr2kZ5NjpNY41PxYzcLt/ckZy4u5a5M5l3rRhigI+JbkOdA7l59JXdu
         Q114icwjh/Z7wxry/Ujeuq+FlUD1h2Kf3uuobE2Cf/PpST66d1OEF9bEwFJ+zphXCat2
         3XOTb0VToAa6uQy9CgtX7RQgb9mZ9MUIwfmm58DH7rLSI9aMZNyouZV2OAFl/8hMpoko
         TWzY87tQp4kXOOUNg93S2p10++oetBCX462HzhT29Wke0C4ovHtutVkh5HOaVGtPzxLu
         ke7IF0HpDVqFv/2tP1MFmKbEO9/d2E/KT1LMQW2U16KhrmQfF9bt8O/wfOgz0z7AVTHt
         +nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709819404; x=1710424204;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zCf/JC5V+iuDVBUGqSJGfNyePUZ8s9c9+9aUy2zAN4=;
        b=hyDNacd7uK/WoLjCJx47Z6a99O2VFGCjp1kV8BdHx+YHUn8ngIT8tQkH3fm+pS/ps3
         4PsPQ0tJArG6flwHZI0hTla2fi/ZBzJ05KzMOz/GEuUtgneOHlwDIWVhQ5fqXGaCG1o7
         dvV7ypEA5/8z+Bt/8dsVMxkhk6b/EVc5rG6Lo3CTDNgcAI0CAJHwqX9m2PNCzWw5czUt
         PfDhOf2A50l0RHYKUbngEWWB9puT/gJHAI+53eLpT4zx/rNm5VlD8yvFh51yEzxxNqBB
         YnXtm1RiXI0TD15kLpR3dHPYIb7GBi3yW1VQ1GOMamOM+yk/WFa8Qlb9yJWnq9S0qDcX
         Zx+w==
X-Gm-Message-State: AOJu0YwnqoOONtSB+k3tf2m/1VF75vKcNnFta69cfsmqJiqGjhHJOiCj
	DexYFa0BvwXHBsQ1ileWeuMzm4s2C7mDla+/aDDb/ePhNpAq1G5aXe2UTdhjiJk=
X-Google-Smtp-Source: AGHT+IF+zo83JGuJkj2a1tPxUpbfF7MN1LfaQIo3F6HZMQZ/6daguz3NoayN+RHaVGLtxsJrp410hw==
X-Received: by 2002:a50:8d55:0:b0:568:145a:4a22 with SMTP id t21-20020a508d55000000b00568145a4a22mr277121edt.4.1709819403918;
        Thu, 07 Mar 2024 05:50:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056402399900b00566a461e1ecsm8026076edb.73.2024.03.07.05.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:50:03 -0800 (PST)
Message-ID: <4ba7af38-5cc1-428a-afec-75610934fc72@linaro.org>
Date: Thu, 7 Mar 2024 14:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240307114217.34784-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240307114217.34784-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 12:42, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> This commit adds support to validate the 'interrupts' and 'interrupt-names'

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> properties for every supported SoC. This ensures proper handling and
> configuration of interrupt-related properties across supported platforms.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Defined the properties in top-level block instead of moving into
>   if/else block for each SoC.
> * Used Gen specific callback strings instead of each SoC variant

You are sending quite a lot of patchsets touching the same, all in one
day. This just adds to the confusion.

> ---
>  .../bindings/serial/renesas,scif.yaml         | 90 +++++++++++++------
>  1 file changed, 62 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index af72c3420453..6ba6b6d52208 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -83,36 +83,24 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    oneOf:
> -      - items:
> -          - description: A combined interrupt
> -      - items:
> -          - description: Error interrupt
> -          - description: Receive buffer full interrupt
> -          - description: Transmit buffer empty interrupt
> -          - description: Break interrupt
> -      - items:
> -          - description: Error interrupt
> -          - description: Receive buffer full interrupt
> -          - description: Transmit buffer empty interrupt
> -          - description: Break interrupt
> -          - description: Data Ready interrupt
> -          - description: Transmit End interrupt
> +    minItems: 1
> +    items:
> +      - description: Error interrupt or single combined interrupt

That's not correct, your first interrupt can be combined.

> +      - description: Receive buffer full interrupt
> +      - description: Transmit buffer empty interrupt
> +      - description: Break interrupt
> +      - description: Data Ready interrupt
> +      - description: Transmit End interrupt
>  
>    interrupt-names:
> -    oneOf:
> -      - items:
> -          - const: eri
> -          - const: rxi
> -          - const: txi
> -          - const: bri
> -      - items:
> -          - const: eri
> -          - const: rxi
> -          - const: txi
> -          - const: bri
> -          - const: dri
> -          - const: tei
> +    minItems: 4
> +    items:
> +      - const: eri
> +      - const: rxi
> +      - const: txi
> +      - const: bri
> +      - const: dri
> +      - const: tei
>  
>    clocks:
>      minItems: 1
> @@ -173,6 +161,52 @@ allOf:
>        required:
>          - resets
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,rcar-gen1-scif
> +              - renesas,rcar-gen2-scif
> +              - renesas,rcar-gen3-scif
> +              - renesas,rcar-gen4-scif
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1

You need to list the items here.

> +
> +        interrupt-names: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,scif-r7s72100
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 4
> +          maxItems: 4

List the items

> +
> +        interrupt-names:
> +          maxItems: 4
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,scif-r7s9210
> +              - renesas,scif-r9a07g044
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 6

List the items

> +
> +        interrupt-names:
> +          minItems: 6
> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof


