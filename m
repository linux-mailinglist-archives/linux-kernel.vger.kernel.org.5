Return-Path: <linux-kernel+bounces-125797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B9892C32
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C67282143
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5013C473;
	Sat, 30 Mar 2024 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKVagu8s"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFF38389
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820592; cv=none; b=RJoGsbm0il4Bj0E8EjGNAKUrROylML2xRXGbi1JgAPqbKhxAFZZ/ShT+q9CSNtrtWJROw7/WEt3P3WAssykg7DQb2GY95JZlpyH8pe8j/pddXAIocCjXVdZx8OCMd4R8VEkQDPOvcUxiRsWps+m0y9U5uuTcwuIM7nnHUi/+9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820592; c=relaxed/simple;
	bh=CfpRFPGIfob7trlZW2wu+ujH6HUQkXp2SuU7JhXDuOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q+0h/UHDZbUbjOLMxU6sh4p7hRQVH5Q9/kWiiibCXtJywiVdYlQnt7L2KvraZUxVMozT6u2OxvF8YB2T+cKO/XSj64RXFy13YQ9tlF8Bkf9jQPaCjicPIUzONkzfXl9Q4J13CZqpSM3EyMQzcrzk8+BgmMZcvRHUy0bzDOnvEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKVagu8s; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-341c9926f98so1806233f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711820589; x=1712425389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0n/av8KZIdardidKCuzPQ5VyLC8pIxiCd9sqfVgxL+0=;
        b=FKVagu8sXUTcexEhgGRFIfYIO9v9blWNbbrtGLvdYAFJ0XW+OYcZGQU3HFyDluxEqV
         NZmbANF2C1hFzmnsH7F+5n1GgATt63A0ni0Dvd5naBwPlTBcR9eA1pzOfX7mEL1ZxRyC
         dw0iEEDemfpPMDazanIMUvnmarxC8T0LRSSSFxlUeTbJUY1yt8BCia2JHxk8skfAHEyq
         ysgdvzryzJgmgMVPBirr4YwpVNCpXrhlQp5rXzou2udgdKLugUNs/8NhqblMLH92mjlq
         WKm9wETMJzFJt9C3lVnh8En5p2f9kurP5c9fSGoA52+oRziT0Au64pZWsTZ31A/HGRCa
         YViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711820589; x=1712425389;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0n/av8KZIdardidKCuzPQ5VyLC8pIxiCd9sqfVgxL+0=;
        b=BCE6AcBO46AuqptaWRgcHBNDe4+gzxkDa7xDEAF870lw9PeFcwl+jjQOcwcKfLXn/c
         iMDPsKAe8WVPHdYwlnjo8eehK3mwGBs2GFnvND4v4W+8JSDsEukRyZMCES7m+Jj8+U1m
         2M5/edQYQx6L75yNPohTvHzOwTSJqYkG/eLFh+Zv3IZoRO052AsjV4Y71od3wSuOAJ3B
         10j/DGTl3WAY8ejBSSgPKQTTcBYfV2zNkOFgdvNwX+UHG2yRLPb/b27DTZRbazpztplx
         m1cxyP9yjLS9aklt+QV/BleKKiNFg/NKN7UDDSbTcICZSwsV0SJIX7hcu+Yb3vhqy4pD
         XsSA==
X-Forwarded-Encrypted: i=1; AJvYcCVApjfMHNsleEt+OLae48cng9xzfz0MT3F7KSKf5XRmY4GAFXNdc3m3SxpPhJwydh6LH9hl9ulNsUzdyAR2jZddU2QJANuLmQWUhpmR
X-Gm-Message-State: AOJu0Yz/8vlq1hC7t1H7SICHRNV/ALaI3synAB/0L8E6fy4Q3XT1uv7l
	bQbKdiB9FYSa+uSvMBEmc1Pgx+FGjYTGgMMldeQN+Mpli4smJYjtinyFG3LTuEc=
X-Google-Smtp-Source: AGHT+IG/FHudcUle4NBL4vcESpYnLYjI5gkfhJ7lp/SbU/seBAbctjUSq6NWeSsYKa52N0T9BvoxwA==
X-Received: by 2002:a5d:4b8a:0:b0:33d:7e9e:4eb with SMTP id b10-20020a5d4b8a000000b0033d7e9e04ebmr3371461wrt.12.1711820589397;
        Sat, 30 Mar 2024 10:43:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v17-20020adfe291000000b0034174566ec4sm6920841wri.16.2024.03.30.10.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 10:43:08 -0700 (PDT)
Message-ID: <3b97b29e-f214-4abe-b37e-627cc5f0370d@linaro.org>
Date: Sat, 30 Mar 2024 18:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] spi: dt-bindings: add Siflower Quad SPI
 controller
To: Qingfang Deng <dqfext@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Qingfang Deng <qingfang.deng@siflower.com.cn>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329015147.1481349-1-dqfext@gmail.com>
 <20240329054657.1602450-1-dqfext@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240329054657.1602450-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 06:46, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> Add YAML devicetree bindings for Siflower Quad SPI controller.

Not much improved.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

Allow people to actually review your code - give them some time, like
24h between postings.

> 
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
> v2: fix dt_binding_check reported errors
> 
>  .../bindings/spi/siflower,qspi.yaml           | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/siflower,qspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/siflower,qspi.yaml b/Documentation/devicetree/bindings/spi/siflower,qspi.yaml
> new file mode 100644
> index 000000000000..15ce25a2176a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/siflower,qspi.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/siflower,qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Siflower Quad Serial Peripheral Interface (QSPI)
> +
> +maintainers:
> +  - Qingfang Deng <qingfang.deng@siflower.com.cn>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: siflower,qspi
> +

My previous comments stay valid. Respond to them.

Best regards,
Krzysztof


