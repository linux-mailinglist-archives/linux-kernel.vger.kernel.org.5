Return-Path: <linux-kernel+bounces-69792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C0858EA0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FB6282429
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1E1DDEB;
	Sat, 17 Feb 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JI4rgLda"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D711DA23
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164973; cv=none; b=nSBY5D2c9D6AXIutoO1reABhTTJypodPB2/tKtD7J4WDS0S5UFvsPSb93hCSzxbwtlNv+8aBxL5T84bNNDjhHFO/CASHFv1k7Nlmp+rb5R0+vjeZXgptb/UEEAXswRG+1jWFih6+BkysWZyWUtM6Xk3OmwJ1XW0UqBRxfeLGUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164973; c=relaxed/simple;
	bh=1i65Vg+jyYUlQIU+zqAMul2GhpqmVUcgXzg3Y4DPhjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW9qTiRQF+ejcfnEPFLb7MhvaqDVlUODaRyyhDMdEc+ULuH6ql0lLOLlq/inVN+WiG26CiXiCS5yQkVHsbu9QnBOvfvFgdUkcYAa95NHEVxZTQDEuqKtCH0xkKJNpzF4Hz7LiMRZWAbIePUKHlqwF7vdPaDsh2QacbhZhzEvGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JI4rgLda; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51299d29e43so1324967e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708164970; x=1708769770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSht4um5QdxkKEwk9U46YwTYDsntPvBYfxqz99LVvew=;
        b=JI4rgLdarxT/5g8VVeY185/ha8V/+VLAbPmOy8gEYcb4rhGOqRuIDyLGShdHvRMlcR
         /nVqAG5RLWSh5mm4YXB6Gy5hBe6oxNHrT94VJtWlQFNOCNQs5pq1LzxkzIj7Vy7Rk9CT
         /2b03NVSsOjc1r5gbKt1hDJDbljde9nd5snvIxo47Zl+JdGTqBVEnB6TREwGwi+swn+J
         LX4fg32qQLSUkbsuBThtb5YGwc7BGCoUdO9szYdjxe0WjaLIrb+Fz+PKVe8mm+vk6G49
         df19QD0ODmoS0FoiBN8pH7p1SvyL7ZqMViLu1keZIj7NQ9mhrLvsARJ75PX2CKjKg0uL
         5Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708164970; x=1708769770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSht4um5QdxkKEwk9U46YwTYDsntPvBYfxqz99LVvew=;
        b=NJ/Eu3bBvIa6hsktXjDmr3abEzh00Qs1ukmhW6Yh3T+yLVsumAca8NumGhXV2kUUkS
         39iztYFzUBjqyz4Y3kl9r8A01HJwTeSql5E1eiKyLEsCR1RpvMwcmemx8GOXfcOT+SFl
         09RFOH16gzeQFK72JSBgEt15IOxaaXhxNulXucdLIJXrS8/WrFsfEwa+z1I3fNwxwFaE
         vv/x9UWHXHIAtC1n3Dbc+5yxci+VQunKi9Nv7+bgkxtPlAo3900XifDgRJQ09xHKsxLF
         gTH3axgX19IN7N7idBZtnNKGqmh5mcNA0Aaik0h9pVfBVDJVdhLjyM7yOcsnNxiQncw7
         IVgA==
X-Forwarded-Encrypted: i=1; AJvYcCXEQL2cjU+9EWwA2SQjNWHpNcgShN8Qm7J+unWGjTUlQXSNUnF7fuTF/W66skqZKepYouS6cVd620iIC+XW64EoLB5ODl+mVLiLfFJg
X-Gm-Message-State: AOJu0YzIWK36/NyIhmtc78KHnijkbZ4m+TxE3UtXtI5uswP56gpBAbND
	W7NiqKw7SZOOEQ01XNUOwkxY0z/K84XPb/iXRHkil4aHolduJUmm4+y7Mp43I6M=
X-Google-Smtp-Source: AGHT+IFLrQJGZ4VI12ihSlw3Jd/DMgL9mrvE+VrzDKyHCNPqpi8fuvM2A6Rd/Ngj4t4uLF2zc0BAJA==
X-Received: by 2002:ac2:5f84:0:b0:512:a982:6dc3 with SMTP id r4-20020ac25f84000000b00512a9826dc3mr232769lfe.6.1708164970334;
        Sat, 17 Feb 2024 02:16:10 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id tl23-20020a170907c31700b00a3da5bf34absm846758ejc.207.2024.02.17.02.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 02:16:09 -0800 (PST)
Message-ID: <55f8815e-fbfc-4587-9edb-bbff6ef84deb@linaro.org>
Date: Sat, 17 Feb 2024 11:16:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] dt-binding: phy: hisi-inno-usb2: add compatible
 of hisilicon,hi3798mv200-usb2-phy
Content-Language: en-US
To: forbidden405@outlook.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
 <20240216-inno-phy-v1-4-1ab912f0533f@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216-inno-phy-v1-4-1ab912f0533f@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 16:21, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> It is accessed by direct MMIO, making "ranges" property mandatory for
> it.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> index 73256eee10f9..d702878b8e6e 100644
> --- a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> @@ -16,6 +16,7 @@ properties:
>        - enum:
>            - hisilicon,hi3798cv200-usb2-phy
>            - hisilicon,hi3798mv100-usb2-phy
> +          - hisilicon,hi3798mv200-usb2-phy
>        - const: hisilicon,inno-usb2-phy
>  
>    reg:
> @@ -64,6 +65,15 @@ required:
>    - '#size-cells'
>    - resets
>  
> +if:

allOf: above.

> +  properties:
> +    compatible:
> +      contains:
> +        const: hisilicon,hi3798mv200-inno-usb2-phy
> +then:
> +  required:
> +    - ranges
So please test your DTS first.

> 

Best regards,
Krzysztof


