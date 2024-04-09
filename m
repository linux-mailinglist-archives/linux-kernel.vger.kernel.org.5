Return-Path: <linux-kernel+bounces-137281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDBC89DFE1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF311C20C25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463713D52E;
	Tue,  9 Apr 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+CMn3rL"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212713B598
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678347; cv=none; b=QcMTFO7I5LupHgGgsEDdxO/cmKTGnH5Xzyn5xg7Dvx2csrD9/jgsA2ORPO/aL5qqSHOu7T0coRqskFtK+7MW9TztGJyYd+/nt6Y86aGh8f/l120cx9B5yLTFUcFpk4VGBYC3qng6azqByO8704Xw2kaNTE0RapCeR7VSlnEFWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678347; c=relaxed/simple;
	bh=Vv25AKERhFsHr4YrXD0B25x8zatblSoZXGU3IP7qq/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vaq12WPi+jlhATZ4p6tFHStAlcIaZPvo8rHnECYo+cRle5rPbQ4QusH2SmTfhWQrGBb0Q4HS8XZFqhpbbgKeSoUlMUipig3FlfykOWF4GkuxCQ91/dpq2AV/L0Mj5gLq1JHIKEqG77dlpQz1GYN7xzyS0vTufT4MVl3/NzgAf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+CMn3rL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d700beb60bso94039961fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712678343; x=1713283143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+/spKUkA9slzNHp8vKtqr5Sqc4bQ9ZR/k/vJJvywmg=;
        b=o+CMn3rLwqH12ci+ZGUruJ37oP/wPzmeuSMCTAObsfRbC6/cg5nUlH0tLc/F0OQyDW
         D/y4FBjOtdS5SXxN7NfRs82OGXryoL51KlmgwYj2dDdtDDgGgdguBYUdw6bALBC12YN8
         OFfOFStLWoAglis9EZn9xJTD3cz+fG2BRRdNWp1+B5NQOH5Mvk8szIfFL+KCMPwkJqe5
         anTHkgUPITPNRDNWD/j1s3fZQOUCiv28L96rDCJ0QAuHmMItFdbSbfQX2j/zBFueMrNo
         MkWggvJOoM8F2yiYnpcDzI978qWYP3KThhkDQ5SzLXE28TkKss8JUFL+HptVGV8VrgyG
         +QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678343; x=1713283143;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+/spKUkA9slzNHp8vKtqr5Sqc4bQ9ZR/k/vJJvywmg=;
        b=DTS+N2vLvJIDWc1NyWsNMxtzwXktMCKQ7mh8vYlEeo7nKBQPjAfUz1e+VnqAX3cDGH
         FkoIrekkQnu6vA/ZDRi6e/juMxgvzQhLwvxRK9Su2R3c64YV2KOsgHJR5jj1jySlsfcE
         9LGFYk9b2b9XUEewYlJjb/0WwjRyl/nJKUiRXVzfsNvRAb9xeR+ug8xR+Je4gBvWtXqt
         ELiktQq+JeE5vYhUn3uCsQ1aIvbbFUs/hVsL1uTAK9Tq20lnK4KhV4NV7WV58DqEDfFc
         meOCmkApBHYtpTiWSuS4mrVm30tyjiNYkjtufchBNWUZ3wDExDZEPGJ5pGwdR7WDbQ86
         1GTg==
X-Forwarded-Encrypted: i=1; AJvYcCWKQkPTWMBEsDG4KK14l7wtwfRe51C7l0xfxC7YuNR3nBMuwt1t/PIbE2SVPGUP+pBcEVXdfTuD+e4LGQMaele6CrN+KIZNDB3r0z/g
X-Gm-Message-State: AOJu0Ywaz3jJ9MzAUzffI2gNEHDfdkiqReY+Y+BnKDJdj4GIF7WrheS7
	KtDceGd4Q8XReec1D7bJyXTtwoAAs6WE3ykDmhUuJdtHMyFAA3spSxzlvNq87ZY=
X-Google-Smtp-Source: AGHT+IEwmvmvRUWELqbbts3tqSXfa50z4eY5lQY39SDTovI1YrizSuwrb6EVAJvqAhL1f+F/VWmctA==
X-Received: by 2002:a2e:8303:0:b0:2d8:6a04:3bcd with SMTP id a3-20020a2e8303000000b002d86a043bcdmr222197ljh.3.1712678343286;
        Tue, 09 Apr 2024 08:59:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dm14-20020a170907948e00b00a4e24d259edsm5749071ejc.167.2024.04.09.08.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:59:02 -0700 (PDT)
Message-ID: <60fd9942-1621-452d-b7ae-40dd11ee1ae0@linaro.org>
Date: Tue, 9 Apr 2024 17:58:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/18] arm64: dts: mediatek: add mt6357 audio codec
 support
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
 <20240226-audio-i350-v3-16-16bb2c974c55@baylibre.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240226-audio-i350-v3-16-16bb2c974c55@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 15:42, Alexandre Mergnat wrote:
> Add audio codec support of MT6357 PMIC.
> Update the file header.

Why?

> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6357.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6357.dtsi b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
> index 3330a03c2f74..ade410851524 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6357.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (c) 2020 MediaTek Inc.
> - * Copyright (c) 2023 BayLibre Inc.
> + * Copyright (c) 2024 BayLibre Inc.

That's not a reasonable change. The file was published on 2023, wasn't
it? If this is not correct, please explain why/how and make it separate
patch.

>   */
>  
>  #include <dt-bindings/input/input.h>
> @@ -10,6 +10,9 @@ &pwrap {
>  	mt6357_pmic: pmic {
>  		compatible = "mediatek,mt6357";
>  
> +		mt6357_codec: codec {
> +		};

There is no single point of having empty nodes.

NAK.



Best regards,
Krzysztof


