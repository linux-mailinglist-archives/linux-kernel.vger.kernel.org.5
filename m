Return-Path: <linux-kernel+bounces-63469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D1A852FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DEB1C20DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5BA38DCD;
	Tue, 13 Feb 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqAuEMz3"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279B381A0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825299; cv=none; b=TZHKhqnDdgshhgRU8Cdp0opxlYIdNLWUnsq2uigpFN9cpNe/EIjcqf0npbmsDBwZx6SX1hjb3d2qVUlHC/sGK7d8x3qw1ugAWA+QHb8FOtQrsVIBfhc5lW8jp+CYCENLkA/BMYWreun78rSFOHidFWv/J5iNEGDm/U+c6e2qsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825299; c=relaxed/simple;
	bh=/l8jT+qwmT+Vo95Bg/QU8/IpsNn/o9NZPpaF1N0moJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVJxPwOt6jg6kW1iAtPC8gukHDY1I9REFcLS5FATe1r96kFwBoIl1mudWu+pECy7USyD1DYHejHu0RnwFjoYMxM9N6eZTPSLmVCuLMs4iAOGv/AR8Nko34IALO/8NwUXhzlxoeQay3qXSVhemEper9qwkVQ+vj/j54nuzzvcorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hqAuEMz3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-411d253098eso126595e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707825295; x=1708430095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99tKWXJsyD1+GaANADhQPLuJwfmrp0nEqtu0ZF/vQt0=;
        b=hqAuEMz3lIhBxjltbsKr2nGGckNuj3tVLpcADy1h1pUuyrjSMCpkjTOnwc2PTEvhmy
         WBTyP/bcbjtw6xCFYjIXzMIYn8p8EjMhqaqJdlqtHgWEZqY1PfJUQQt7vr9jikHlvwZx
         akplAZzBsfZXVylm+S88eBOPyLWS0jAXIvdlWUtriFavWy7s1XyIfQYFqSi3JHTE2P3M
         jDRNOo8MWapaZFAJUWPCAphZ1PQh8rMUW9X+zyMr8Nf/1X1UuTOMmneLh5XPobt8nAbq
         Y3gNqxs7RtH0B832MlXkscawusXWQE4TsMQXYc674vRSOmCCei/yp9y2eQ4YGYs2znCS
         4rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825295; x=1708430095;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99tKWXJsyD1+GaANADhQPLuJwfmrp0nEqtu0ZF/vQt0=;
        b=IypZZT9qn9mcwlXUgUl54S7lA3oxJgPaRbJ8eDSZCrBZaYS0rdqkIxEDCneBCq1bd7
         obDjVXY6PvyUdOAJ8y2GSD3g9UW+QHIRD/kJvHkpaVvfDFJiWCocgWc2Ub1UeikX/4WP
         0JtmiGu1MGloASWG+2d87DPNl9OAotQFugm5NNtnZvgctDJdtd4+Wo6Ub/MFBhYB5cQw
         rx5y16fSGICzAJ1Cscleo14QYQjGAKFA4gnTvLQs4EGE2QtkRERCBbC/sDtTwsfsWFfE
         xSx0c6Xy639Bg0R/9pUW8Jr+qxGEoDoZeDWhAfje0Zbc0bLjh6P/TrFjf79TEzli0A56
         Ohlg==
X-Forwarded-Encrypted: i=1; AJvYcCURv+qQQMk7dySBPzYstHgpr3VDn2sOToeqEIAU7XSQgZSpF/ycIRlujyoRy7LPH5NfCEdfqemxfoFtCpjaScq0/8LTqxjOBCWBifkt
X-Gm-Message-State: AOJu0YyqvbqvIxdA7ttr3QBgObbf5qSkj+jS/H8nN19A1HkrvYBPuyBM
	TeTpQLFfSgEWatf+iFPUL/MGIYc968a50BWlVt1QSgRlLPEE2CxRSUVc7PtGttk=
X-Google-Smtp-Source: AGHT+IHGQ2aMYIdGYJIv42FsAKrZu/3Fya8npB6QiuMT/v02JoCEShYniIGIiBnoXqvMFeFB91zkyg==
X-Received: by 2002:a05:600c:3587:b0:410:880c:b85c with SMTP id p7-20020a05600c358700b00410880cb85cmr7924099wmq.2.1707825295677;
        Tue, 13 Feb 2024 03:54:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYS7ABtKfHePj92eloyH20dIgAwggcorlQW5Qj2CAsMPmY3pH1U80cdjS+bu2EyYuqDa1g+0AIxr/ow2Qkha/a107DVw2ZAM77L0lEdS4tW3l50MKXvhTJI5pFzOeJMF/NyVcX7dy1PEauexYDMyzVpHZt/ckfsV2/zDxaw/VRMdSF1mDd4ZXT+k80Hx29M5yamjtOTpXhfd6VAIorjg/UDohrhCGsTlLuWFRs4AM3jp7tBJV00rLHT1eFIhek32+7yUir6fuwY2yvY1Ek8UfoIWUx9hSx20rMn3B+iL+FB5lNTyIqChgpv+qasAqb2huwyKIB99NWnLhZ0ZBe0RhvtZ8YJGwcNau1rI1/p3F2irakNmhkHuDebCViZTB10HXKHyIl31MCRwHcQs74ECo7p03UOXx3jAt3ZEKr3pnWUEN03C6p59dBtqACdrBqQbmmEwjqk1rbDGnofz5iL4P+ynHGkWquLglKdLOlXnzaTCfRDGtC0kOqHP+EiAuG9dMyhLbW7xaPJCp9hXvnj3nw
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c458b00b00410504b582csm11595700wmo.11.2024.02.13.03.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 03:54:55 -0800 (PST)
Message-ID: <272705aa-a942-4676-8010-d001e336b26e@linaro.org>
Date: Tue, 13 Feb 2024 12:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: convert MediaTek controller to the
 json-schema
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ryder Lee <ryder.lee@mediatek.com>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213074747.26151-1-zajec5@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240213074747.26151-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2024 08:47, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/ata/ahci-mtk.txt      | 51 ----------
>  .../bindings/ata/mediatek,mtk-ahci.yaml       | 98 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 51 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


