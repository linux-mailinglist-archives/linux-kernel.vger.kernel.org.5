Return-Path: <linux-kernel+bounces-16376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A83823D99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F54E1F24B44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F311DFFA;
	Thu,  4 Jan 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHx3G9q0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031471DDCD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55539cac143so320090a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704357720; x=1704962520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkAvidZ3xgL3LyDJ+kTMXwdem4qrhqmW8XT+H+hB9Nw=;
        b=aHx3G9q0U9dT1p2Jhigi9UFl/bL6vPSXgjLtzW4fC25IuReNF2JAZ2/DfciSADlAY3
         L36o3LVmAABtznuom6P++04ti52zgniDyAiI6XtNbd9BvIN86Keu7MSqeoiZk4Q7OoMO
         cziEQDpBbPNObmC8ePkAgsRfGFPt0q7tg9wGnRCYkP0cTAumGVR+X25Llk+t1NtfUDmq
         ci95odcvvg4yJj6bPeKB7wgkf896kgyfZnASYHUQ4XDBbkXpClGONYiz910CyeSZwuVr
         VvpiGksih0R6qS4/zzzPEHf0kX31+nkDXlDuD+oZrboiANx3k++LqNwlALG3OhwcNUG3
         oVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704357720; x=1704962520;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkAvidZ3xgL3LyDJ+kTMXwdem4qrhqmW8XT+H+hB9Nw=;
        b=g17sSmkjtk/69MXA5ehrn9ZwzZhNS4RJ6VlAdGr0oGnLzJ/f1Pkn9i6fa4Ob0r6L9G
         WbAA+4jmZ+x8Lu8dQfpHAEf93V92G4lDpbbShLgI/8r30yN4vQli64jfJGJunk/w7M76
         JkqxET/zaPeSc4giNTCo2QXXg6staN81LLVB1KDX509RmH1MvMQmmfnoN5+tBulr7gg+
         g2mnRZtVMdocv0CROOiHD2Ua0kglvr9bhTBVLKbBZ5Mo3hff5iKDqMSKusANWb0RnIuZ
         vxPY96EpYEwJGGZ5jO55MA8xDt7nAcuTsoUwkT6jl0tC7+8+0ObZiuadDTbwX4SSGbT0
         oAzg==
X-Gm-Message-State: AOJu0YwhKfHZUJJjnv7lYouGOSjcoYyiL/SDgF0kJclY/YzSZE7Hw9NB
	7hmaG5frjM4Qhniy45h0lz6ZjHyI1fp9kw==
X-Google-Smtp-Source: AGHT+IGkfTouuSc0V4+b4cPz0sF5sFfv0F2WsHl/Dag0nMZ4JlfO7q/0frazXKnSPST3RXegnmqzog==
X-Received: by 2002:a17:907:9195:b0:a28:e303:3799 with SMTP id bp21-20020a170907919500b00a28e3033799mr134291ejb.127.1704357720222;
        Thu, 04 Jan 2024 00:42:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906128200b00a28ec89674bsm131107ejb.173.2024.01.04.00.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 00:41:59 -0800 (PST)
Message-ID: <099f3dfb-0557-4c8e-9e69-abc76463f659@linaro.org>
Date: Thu, 4 Jan 2024 09:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] dt-bindings: marvell: a38x: add solidrun armada
 388 clearfog boards
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
 <20231230-support-clearfog-gtr-l8-sfp-v4-3-1d7f0e2c7128@solid-run.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231230-support-clearfog-gtr-l8-sfp-v4-3-1d7f0e2c7128@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/12/2023 16:44, Josua Mayer wrote:
> Add DT compatible for SolidRun Armada-388 based Clearfog Base and Pro
> boards, which are already in place in-tree.
> 
> There are already 3 distinct dts in tree for these *two* boards,
> declaring particular compatible strings:
> - armada-388-clearfog.dts:
>   compatible = "solidrun,clearfog-a1", "marvell,armada388",
>                "marvell,armada385, "marvell,armada380";
> - armada-388-clearfog-base.dts:
>   compatible = "solidrun,clearfog-base-a1", "solidrun,clearfog-a1",
>                "marvell,armada388", "marvell,armada385,
>                "marvell,armada380";
> - armada-388-clearfog-pro.dts:
>   compatible = "solidrun,clearfog-base-a1", "solidrun,clearfog-a1",
>                "marvell,armada388", "marvell,armada385,
>                "marvell,armada380";

Drop code from commit msg. Commit msg should explain why and what, not
copy the code.

> 
> This has historic reasons, the first entry is a legacy name for the
> "pro" version, old versions of u-boot built when only one variant
> existed explicitly boot by this name.
> 
> Note that both compatibles and model field include the string "A1".
> At least up to revision 2.0 of the board, this had been printed
> on the pcb. However in marketing material and conversations it is
> usually omitted. "Clearfog Pro" and "Clearfog Pro A1" always mean
> exactly the same product.
> 
> Technically Base and Pro variants are similar enough that they can
> successfully boot with each other's dts. Hence it makes (some)
> sense for them to share the "clearfog-a1" compatible.
> 
> Add bindings for the explicit variants including base / pro suffix.
> The legacy "armada-388-clearfog.dts" is not supported by these
> bindings" as it does not make sense having two bindings for one board.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../devicetree/bindings/arm/marvell/armada-38x.yaml       | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> index 5af222e6db18..4950b840bf1c 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> @@ -15,17 +15,14 @@ properties:
>    compatible:
>      oneOf:
>  
> -      - description: Armada 380 SoC
> -        items:
> -          - const: marvell,armada380
> -
> -      - description: Armada 385 SoC


You just added these lines. It does not make sense to add them and
immediately remove. It's a noop.
> 

Best regards,
Krzysztof


