Return-Path: <linux-kernel+bounces-109768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3BF885573
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBE91F22010
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFCD7829A;
	Thu, 21 Mar 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpcTj5w7"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290E78299
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008897; cv=none; b=MjqF0hGZ34DDy8vTsIvZONsUBzTAriWq5HcMNqiRZi/5Epb8dkLR91uJRT9xjibOHeF0rViMOW58Xj2udOg16iEMPStOuaG+74jq5dGHd5ar6El3MDCJ8vaK3mVeW+Xs7Ae5ocnxXBeJ9eGTSaNi7S2u5ZGxRc+DvgvJJBr3R4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008897; c=relaxed/simple;
	bh=QyEyGaUWJamL4qBLiU3qsxQbgR8JFUEDJ/D7kEW4/ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3R3oR8BrH9NzpNR1tB4WrUkyi4g6cI+d9xwk4bWQQ98jUrZ22yTy/ao2+Rv9008xGkopyy6dSoZ0TOSwMNc7jFUFe0A/KS1Ka1tid9cnmzK3mVsRCS6XeNipTfZkK76CQqH+mU1uHARt8CqTGn8BOmHUizxVelfBlUVUHZROo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpcTj5w7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46dec5d00cso88948366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711008894; x=1711613694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bumbK4Iq37XZI7PAaRcKjKb4r9QAOyHdGVrz+smI1ho=;
        b=bpcTj5w7kTNSQfMJe2G/KX8vCtIhB4LOkuGcFyoXMv4/wpfxlwaXfgsVuCPIw6Lka8
         WIBvVg6InbAXanTnxGToEEQWMobBWsWORtZdJCPsI9UtZTaMI4Uwex0Hf7FQLKsIdoWG
         FjWubK+pQzEW13jvqFrxcuuFCk10M7VeETV2vsnmGnTelk/+Sedn+4SfDcg2fqjKU+XI
         M6LSV0O74KrwSDKgUbcSbhCGOG4VKTz0IQ8EE7nPM3n22OW5cx+ghy/xkYT6DbgQ3mW8
         SRubO2WFhYDoZG+dKttOwpSq7dXkKChKQx+0oOhnwBzRs2KdueVr7FQI6GySvsGbuVeS
         Jolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711008894; x=1711613694;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bumbK4Iq37XZI7PAaRcKjKb4r9QAOyHdGVrz+smI1ho=;
        b=HzBHI5OZlKhATDH0BkyVynLPhAcqRKnJ1Z55knsaoryRtKf4hFgXHxU34gydLffK95
         7uTR4u2sfyWBLigCEIhI0AE0p/i0XEjQDRMhRhGM1uyERTbHxhKSBTxYOei9epBDeSwj
         9AwgatkRfAFxqEHGbIxhgU7LfD3cDZUOpD79sF5Bbu8xpZFFL4gSNS/uUKQX0SG6vZju
         bsYzQ083UfSDUqE4m+Od9Ed0DLbNnDf2yqrEsneS12MryrPXMEf2EN0rM2nn8nfXC/8u
         FO/C+XOO6J8QQJ/FYPaUFCI/vhVGajv+mengUcY6HE4E6dE3XJIJfur6v14R+5gyW/Km
         FY6g==
X-Forwarded-Encrypted: i=1; AJvYcCWTHfbmtdcjp/ibD7DyW37TkYhuyHzmKvmIVY4/KI70FNdqFtrrJ18doEmFkRUAJR5EYvJj7SY0BQfDbFoIrIeG+aVuz280JUIVz/zR
X-Gm-Message-State: AOJu0YzZtLOuWF4fb0T5XxbBSuZyB+GcZUv+vVpq7vdqPpG2RjjO1CeV
	13sz9NyOPg8Gxekwl1hRSzjeoD3B6mH1z5rX2ChKvdCxNo71jdNdFlU1/RoQ3AY=
X-Google-Smtp-Source: AGHT+IHnQrPGnZT2/iidhGyn8HX5rcqqkqaLrfSr6V+AeAqqQrXxfQKRJGbNVs83QEsinhw56m91Kw==
X-Received: by 2002:a17:906:2cc7:b0:a46:2e1b:a11f with SMTP id r7-20020a1709062cc700b00a462e1ba11fmr718296ejr.31.1711008894227;
        Thu, 21 Mar 2024 01:14:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id en6-20020a17090728c600b00a465a012cf1sm8283979ejc.18.2024.03.21.01.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:14:53 -0700 (PDT)
Message-ID: <4c05d3c0-aa79-4ce0-918c-7d0967ace520@linaro.org>
Date: Thu, 21 Mar 2024 09:14:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2/4=5D_media=3A_dt-binding=3A_media=3A_Doc?=
 =?UTF-8?Q?ument_rk3588=E2=80=99s_vepu121?=
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <20240320173736.2720778-3-linkmauve@linkmauve.fr>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240320173736.2720778-3-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 18:37, Emmanuel Gil Peyrot wrote:
> This encoder-only device is present four times on this SoC, and should
> support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
> encoding).
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> index 9d90d8d0565a..947ad699cc5e 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3568-vepu
> +      - rockchip,rk3588-vepu121

What is 121?

Best regards,
Krzysztof


