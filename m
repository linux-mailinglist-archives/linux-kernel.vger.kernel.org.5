Return-Path: <linux-kernel+bounces-152510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DB8ABF8B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9196E2811B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9617217BAB;
	Sun, 21 Apr 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJrMfaaO"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772A14006
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713708741; cv=none; b=iXo70mIknQI9NRxg0CarDNIfFBflyYfHsSao3RQUHbONfY3LbNnWY8rMGAmrZgW7+VVOh692B4B9ANaMUy2pPHhvrE7Ej6fbuj2VCfEM9x6w1QreUQbTW6VQdPaKOZlNHqAoCO4M0eO4WphBefKBT3bkxFOgAgFh24hLW/xdNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713708741; c=relaxed/simple;
	bh=j38FBvVpffwLMJ/5x+0Ljs8nKq3Z+wFOVRBj8Homfqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+SG2ExAFxmIECBKutjqHWaEamxAsH7a4KPYswp3glh/W9Xiuq8YOnq3NLwck8GXGNgD7MwmGqaL5pVRFOQAUMzJN8IgeO7bMgrXW8j28C5oPYNSwt0s/qmixpQ7+yHLHGRp3gIy9hrDV2vwuadmoQg5re7r+UZ8Ctl6OGU8rUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bJrMfaaO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a55b0213a0dso39876166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713708737; x=1714313537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9MEklzQv9IxzYen+J18adPH5pcve7DGyheVxmRR09c0=;
        b=bJrMfaaObshX8qKbQcIweZgmPH11unKE8pWvmg0r5E0j1akIB5xwFOUfiqLZhYAA0C
         RN52Pz6rf8aroaNrS8D3PJ133Wn4we5DEqmjcx8HAuHy7hyvDcUwYCxk13GmNnYklNGX
         2P9Cxne6V0DECNrddNyRaRehgzhBs6l+qctL/UyweaNHacUsCJYMcZ5XC4iDiXXhUqbl
         02QcQta5r084ZrW2Dck4XAbYdyO+LVDmyri/ih8Uxp7VWNSLnfSUSbDBuM1gmOuO0dM5
         UUTgxpkIQP0CaqlF2sFjea4I8bRHqFH+iMBY2MtBX/vFnwgprYKFYbp8+PvG28PygTU1
         h3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713708737; x=1714313537;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MEklzQv9IxzYen+J18adPH5pcve7DGyheVxmRR09c0=;
        b=gGIDnB5vIsDHqSEqCYt4p2KlGlbTHTXgT5qq+TmN3jc65EYmAptiJTxLuRUAKPd4+O
         c/OE2gj60Il2dvF+/9TaJIaay4y/jidmHdY3Zhz7NUaRXnc+Tf/onRlN1hGdaYynNtJR
         Z/pg5ro4NMU4X9GMy4KPPZy2Hae2tQ7M9glPtZAsL26x1ghq5mAgqW4qXCox2vH7O2Bm
         HA+tnVrpWS9nuowJlVUkMDU0WHt/b61qh+PqErfm01rVjKdj/JEpulD7zmelbLMXCsfw
         6p3WBvwAXVRz2bL4foqS+g3DM7q/ns0rADgV7lazRUcEFgGDm+VAuNNUkh6SZRgIbyH+
         uFog==
X-Forwarded-Encrypted: i=1; AJvYcCWac4tAqgcyrefiN7kL4l8Xy/XMOMnmhvxsLf4R4G7nN09YhCRF5yeHsN9vh09MJvlLAA5hxmZDRkG2kqRTswTawuZKdC2KWxYNnPa4
X-Gm-Message-State: AOJu0Yy5Gx+Set3Mv+aS9Jz/CjxkxRTV4B2qmwiFtQt8uQ1w4eKUZ1jA
	/maT5gKKoSu+2qWuJLc2D7l/7RYQ/1sb6dKM0nys2sX8EIrQ9VXbaZUXA9GkmSE=
X-Google-Smtp-Source: AGHT+IFl1o5q6L7vKYmfe8zfRJ79XSxelsD2JpT5zYYP6mbIkZ9KliA3NRV7gG3qvnhRe2RZq8mbJg==
X-Received: by 2002:a17:906:2693:b0:a52:4edb:6db7 with SMTP id t19-20020a170906269300b00a524edb6db7mr4214072ejc.54.1713708736881;
        Sun, 21 Apr 2024 07:12:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id kn9-20020a170906aa4900b00a534000d525sm4588367ejb.158.2024.04.21.07.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 07:12:16 -0700 (PDT)
Message-ID: <c30cc11a-209a-4919-a382-7588daff0d71@linaro.org>
Date: Sun, 21 Apr 2024 16:12:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: riscv: add Milk-V Duo S board
 compatibles
To: michael.opdenacker@bootlin.com, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Chao Wei <chao.wei@sophgo.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240421055710.143617-1-michael.opdenacker@bootlin.com>
 <20240421055710.143617-2-michael.opdenacker@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240421055710.143617-2-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/04/2024 07:57, michael.opdenacker@bootlin.com wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Document the compatible strings for the Milk-V Duo S board[1] which uses
> the SOPHGO SG2000 SoC, compatible with the CV1812H SoC[2].
> 
> Link: https://milkv.io/duo-s [1]
> Link: https://en.sophgo.com/product/introduce/cv181xH.html [2]
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---

Where is the changelog? It's v6!


>  Documentation/devicetree/bindings/riscv/sophgo.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> index 9bc813dad098..79546aa21021 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> @@ -24,6 +24,7 @@ properties:
>            - const: sophgo,cv1800b
>        - items:
>            - enum:
> +              - milkv,duo-s

? It was duo... and duos... now weirdly duo-s without explanation.

>                - sophgo,huashan-pi
>            - const: sophgo,cv1812h

It was CV1800 before... and you were asked for SoC compatible.

Please reach to your Bootlin folks to explain you how to send new
versions of patchsets and how to use compatibles.

Best regards,
Krzysztof


