Return-Path: <linux-kernel+bounces-32484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649D5835C38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14261286EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E918640;
	Mon, 22 Jan 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSeWhYHO"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DA17C68;
	Mon, 22 Jan 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910581; cv=none; b=KwidRjN/8oNCYyYvUckE0TzwGgvV/7MUS6e7hhgBaLcm4Kjx79PMjQDaB1kx2xTkjzdpiVa3l0rupJPs9/3MVX9rPUqm/NrISr+x7r+ngl/5t6Z4s0QEce/PAhqBnY5RmNA7McO2wlOni4Zg7xGZPnltJI3g2HW5OzcXHrcQCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910581; c=relaxed/simple;
	bh=WCL2HAPFSfzn/qaSLH4XXDInqiOUekK9lc9KWvkOr9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+hVp34bUeBwF7Y0Y1J1ghtvyRX6xQynYkM6pqrMBfN09+5txs5edZk083bXex+25KizpVHzGrFP8Lp4NLU71sVAHN6gAdFWhHPJHWbxjQMi7hN3zUZZaw9UhCkmFKtco03hVCR8ou13mJL43eI3L5fWoGB+t0T13KgbBuScGdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSeWhYHO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so2865759f8f.1;
        Mon, 22 Jan 2024 00:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705910578; x=1706515378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQQhKweIL/MfaRqaUUsl9viWbACAS6aXTW7gfUp7M7k=;
        b=iSeWhYHOzdaQLISrQm7r4+8uIEub4k4cXbINumB3nNPVlnRLZ60i/fpdjATZQ0l2+I
         7P0sFWSwPPrgT2bHKgfYQBjHDbGbFk+OgE23FEXq3GJ6OCPEMkAx3N4M5x7zKIJ7KtM7
         ZkAAgSb51nn5r3LKjUDBBCcwmpe+8kN9sX38xVBWHOz9yUYiydN8s5oPTpiBmmeysZAX
         yGkD+faZYd8z5A4r1RKHipW4vygaRnWs+j5SIXZuRipFdtS9Oe78wSna2ZU/aDzN+pqy
         GLlaFWMf4G46m4qDLmV2ky845222hIM44HzKHZQJNvsIxgmyZq5H/zs+MmVZK9/NnO/z
         Yymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705910578; x=1706515378;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQQhKweIL/MfaRqaUUsl9viWbACAS6aXTW7gfUp7M7k=;
        b=UmMUKOP/K3NBBuNKgF5bmjhgLKPmAtvMBMO1Mi2rMak0cFr2KPfBnRwsXAdyuWiDSk
         NMLeEy8LaZpO7UxYEgp+u94PiLzKicTl5q/Th6ZB8oLK8nlQ0EFthguygo35Rn+UlDZk
         puz7/AgiZhrwWOvB/eMxUIcz5VujVndZGDq2bVzHLzqngaHlu0PxkYSTIAR+a69f2/xy
         Vwjq2zhf+EmUsFlkBj7rlytPu7f3PFBe0cQ1tdNNY21RE5UEMtCLbY50ZFwq2uiv/nBq
         ICYVBwl4YwtkLIkKoVBn1uiTqZKrLJEQPsHh6CPagVSe9uWIorEn71qqxBfByyjzyX5Z
         WfCA==
X-Gm-Message-State: AOJu0YzXhp6+y8IouhWZHAeiIavsnIEkzg+nq5dsFNCzYSZ7pR1FZFs/
	StsLUKjcEdAaLgmLPH7Bsh6nynd0v/jmgSU4AZUwLqJT9hLtz//m
X-Google-Smtp-Source: AGHT+IG9+JuJqbT2TuU8J7qhPDQqp/HN08f8j/6H+CK0ZJJJOenew6gN7m8yBjpTbDcLQA3dWIudrA==
X-Received: by 2002:adf:fa04:0:b0:337:c528:c0e8 with SMTP id m4-20020adffa04000000b00337c528c0e8mr2558951wrr.49.1705910577824;
        Mon, 22 Jan 2024 00:02:57 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600010cd00b003392c1f40acsm4527284wrx.28.2024.01.22.00.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:02:56 -0800 (PST)
Message-ID: <d16723a6-5602-4fa8-9cfc-589846b75f5b@gmail.com>
Date: Mon, 22 Jan 2024 09:02:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] dt-bindings: arm: mediatek: Sort entries by SoC
 then board compatibles
Content-Language: en-US, ca-ES, es-ES
To: Chen-Yu Tsai <wenst@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eugen Hristev <eugen.hristev@collabora.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20231213150435.4134390-1-wenst@chromium.org>
 <20231213150435.4134390-2-wenst@chromium.org>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20231213150435.4134390-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/12/2023 16:04, Chen-Yu Tsai wrote:
> Some of the new MediaTek board entries were inserted in a chronological
> order, or just randomly. This makes it harder to search for an entry.
> 
> Sort the entries by first grouping by SoC, then sorting by board
> compatible strings. Also add a comment at the top asking people to do
> the same.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Does not apply cleanly, would you mind to rebase the whole series onto v6.8-rc1.

Regards,
Matthias

> ---
> Changes since v3:
> - Collected reviewed-by from Angelo
> Changes since v2:
> - none
> Changes since v1:
> - Collected ack from Conor
> ---
>   .../devicetree/bindings/arm/mediatek.yaml     | 123 +++++++++---------
>   1 file changed, 62 insertions(+), 61 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index a5999b3afc35..60337b439744 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -17,6 +17,7 @@ properties:
>       const: '/'
>     compatible:
>       oneOf:
> +      # Sort by SoC (last) compatible, then board compatible
>         - items:
>             - enum:
>                 - mediatek,mt2701-evb
> @@ -129,71 +130,10 @@ properties:
>             - enum:
>                 - mediatek,mt8173-evb
>             - const: mediatek,mt8173
> -      - items:
> -          - enum:
> -              - mediatek,mt8183-evb
> -          - const: mediatek,mt8183
> -      - description: Google Hayato rev5
> -        items:
> -          - const: google,hayato-rev5-sku2
> -          - const: google,hayato-sku2
> -          - const: google,hayato
> -          - const: mediatek,mt8192
> -      - description: Google Hayato
> -        items:
> -          - const: google,hayato-rev1
> -          - const: google,hayato
> -          - const: mediatek,mt8192
> -      - description: Google Spherion rev4 (Acer Chromebook 514)
> -        items:
> -          - const: google,spherion-rev4
> -          - const: google,spherion
> -          - const: mediatek,mt8192
> -      - description: Google Spherion (Acer Chromebook 514)
> -        items:
> -          - const: google,spherion-rev3
> -          - const: google,spherion-rev2
> -          - const: google,spherion-rev1
> -          - const: google,spherion-rev0
> -          - const: google,spherion
> -          - const: mediatek,mt8192
> -      - description: Acer Tomato (Acer Chromebook Spin 513 CP513-2H)
> -        items:
> -          - enum:
> -              - google,tomato-rev2
> -              - google,tomato-rev1
> -          - const: google,tomato
> -          - const: mediatek,mt8195
> -      - description: Acer Tomato rev3 - 4 (Acer Chromebook Spin 513 CP513-2H)
> -        items:
> -          - const: google,tomato-rev4
> -          - const: google,tomato-rev3
> -          - const: google,tomato
> -          - const: mediatek,mt8195
> -      - items:
> -          - enum:
> -              - mediatek,mt8186-evb
> -          - const: mediatek,mt8186
> -      - items:
> -          - enum:
> -              - mediatek,mt8192-evb
> -          - const: mediatek,mt8192
> -      - items:
> -          - enum:
> -              - mediatek,mt8195-demo
> -              - mediatek,mt8195-evb
> -          - const: mediatek,mt8195
>         - description: Google Burnet (HP Chromebook x360 11MK G3 EE)
>           items:
>             - const: google,burnet
>             - const: mediatek,mt8183
> -      - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
> -        items:
> -          - enum:
> -              - google,krane-sku0
> -              - google,krane-sku176
> -          - const: google,krane
> -          - const: mediatek,mt8183
>         - description: Google Cozmo (Acer Chromebook 314)
>           items:
>             - const: google,cozmo
> @@ -244,6 +184,13 @@ properties:
>                 - google,kodama-sku32
>             - const: google,kodama
>             - const: mediatek,mt8183
> +      - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
> +        items:
> +          - enum:
> +              - google,krane-sku0
> +              - google,krane-sku176
> +          - const: google,krane
> +          - const: mediatek,mt8183
>         - description: Google Willow (Acer Chromebook 311 C722/C722T)
>           items:
>             - enum:
> @@ -251,10 +198,64 @@ properties:
>                 - google,willow-sku1
>             - const: google,willow
>             - const: mediatek,mt8183
> +      - items:
> +          - enum:
> +              - mediatek,mt8183-evb
> +          - const: mediatek,mt8183
>         - items:
>             - enum:
>                 - mediatek,mt8183-pumpkin
>             - const: mediatek,mt8183
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-evb
> +          - const: mediatek,mt8186
> +      - description: Google Hayato
> +        items:
> +          - const: google,hayato-rev1
> +          - const: google,hayato
> +          - const: mediatek,mt8192
> +      - description: Google Hayato rev5
> +        items:
> +          - const: google,hayato-rev5-sku2
> +          - const: google,hayato-sku2
> +          - const: google,hayato
> +          - const: mediatek,mt8192
> +      - description: Google Spherion (Acer Chromebook 514)
> +        items:
> +          - const: google,spherion-rev3
> +          - const: google,spherion-rev2
> +          - const: google,spherion-rev1
> +          - const: google,spherion-rev0
> +          - const: google,spherion
> +          - const: mediatek,mt8192
> +      - description: Google Spherion rev4 (Acer Chromebook 514)
> +        items:
> +          - const: google,spherion-rev4
> +          - const: google,spherion
> +          - const: mediatek,mt8192
> +      - items:
> +          - enum:
> +              - mediatek,mt8192-evb
> +          - const: mediatek,mt8192
> +      - description: Acer Tomato (Acer Chromebook Spin 513 CP513-2H)
> +        items:
> +          - enum:
> +              - google,tomato-rev2
> +              - google,tomato-rev1
> +          - const: google,tomato
> +          - const: mediatek,mt8195
> +      - description: Acer Tomato rev3 - 4 (Acer Chromebook Spin 513 CP513-2H)
> +        items:
> +          - const: google,tomato-rev4
> +          - const: google,tomato-rev3
> +          - const: google,tomato
> +          - const: mediatek,mt8195
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-demo
> +              - mediatek,mt8195-evb
> +          - const: mediatek,mt8195
>         - items:
>             - enum:
>                 - mediatek,mt8365-evk

