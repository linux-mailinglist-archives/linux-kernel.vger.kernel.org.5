Return-Path: <linux-kernel+bounces-47753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64D845260
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21351C236B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA4159585;
	Thu,  1 Feb 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWeNVJhH"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18A158D73
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774860; cv=none; b=n5d00Iu9ynHz7kyIHONUbzr7TrMyJvDLNOjrP9TjcyBii8KFX1PzhthN+I9jN71VJ3VZAsb87hh8QZZT8VM0g861XYs5mO+wTlglr8Lxdej6zB+HzDeIlNEiPVbTElrLyxAPoS7Os9GXcbQOk9bmtTJd4VxrDcDYpZaXF/qMAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774860; c=relaxed/simple;
	bh=USQ13aZ+rV6iGwkRKMbbqSfiZqcawCNaWDOlstQWM0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtdjV7FGJnfAzb/hWmpoxrDMNvC1rexTaEqmv2BJEHO7DtBrT5DEoRh5/3TbmaC4O3tYiipX2qduemPGWLYWfWWiBCr1mrQXy55YK8vzwr5/Dl9fSzTj8nVVukib/IYptlitXP1j1dvPcrOQpO7M4TKpyeKB+SGaV7Sz+Vmiess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cWeNVJhH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1030197a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706774857; x=1707379657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhYsK52Kis24WxaL+kBzGIActO/T1+nmrCSum9NZSj8=;
        b=cWeNVJhHdI28O+jIn1WFbYDsyLis1Zb+M2uCTXQ/42WeZNaESwcfNU/NDGXU/rDVce
         n5hTJHiCJtDekqy2Mhc0AaE8s86rirPwgap9NyQk/H1MZgHuSQ4eMmlZqE2OnB7nF1PE
         gIjCHo3IvvZmGDsb9D4oGMyFatvC2RZvY5zgoZfvsbWqlrsTOHxefcHoTqkNktphwLNZ
         MVOC4WcbaGqsv82fvjobyu5nud1v+0BfIuAQGIMfEza8CLUhsfcQPymay06paLw0PbYR
         VQcEqERF/fBG+YtFxDaEg1KzYG3EfZ4U5ktCFfZcXzWAuSVZQ1Azl3nSh8SGV3YHHb6U
         TOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706774857; x=1707379657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhYsK52Kis24WxaL+kBzGIActO/T1+nmrCSum9NZSj8=;
        b=dPx4B6kETkOAsQo8XjlASQshuknHKQxzjbtN5OAHWRLGQmfJIKGHuXnHMqfjoOY6uc
         n/W1r3x0tCWMNAA6pYvkrtuMw1dcMMmwKPFtfxDyFxeFUb0thpLM9dyhCyq4xSjoReNq
         pR5H/L4MTYZdw7qiyQ83w9NUIjlWVHq79w2gKGC30L0PymjUqjt20pdAKGn32DvIoyZX
         EObsFCEXYKb6yzhrYUuI09t8Js6+Jtqa0pHbWbXlJB/SfwlRS9aYuDtpK8PsrSmUJBeH
         P8lJZPo3AFteczzhd5gdjiNN85L6q9Ko0u5pr++V3aB2si17mgXv6Iuf4i0WU/mfLHf3
         9cQw==
X-Gm-Message-State: AOJu0Yz5aHR1HUdw3wa/HqsfxR9X9iFfUXfAfc0BnAEUvYINtJhWUte7
	yrxemNVAHUp2AhSPkZacc3CFULfyIpYeARRyFahDrOI0b037PNdNVTkkvpI+l1I=
X-Google-Smtp-Source: AGHT+IEX5Kqci7fZQHEEOSQZ/q8zByfhnqr1/3GR8aFZDgdNQcYGJdfxu19t0u10OfX9U8yvyG0cAg==
X-Received: by 2002:a50:c359:0:b0:55f:ca00:f0ab with SMTP id q25-20020a50c359000000b0055fca00f0abmr84626edb.18.1706774857102;
        Thu, 01 Feb 2024 00:07:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2n6LRu1Vtb4sI3Id3x5GMUZGycLv2NEXZBUgZdPo+Kb7/WmthyygFMVNo0l79hROJlUpgNrXXOyl2OkGyFhJIb2WfUoumCb4rnKW0hlpEvINOchrugssrj+E0EHb1sJjGkw4zZU+5yf98Ihqf0tWYRC7Vnshh8bweCFhltlXonwAICaQY02pTUXuDofa0ujq7E9bxWyvYyN7rx77o3fJwCbHuJpw4whOVbCSFEocP8FbeJJpmUaCwdhjVWYeKTTOfbnFnvvqzPGGRwzidmgOOvELVQ0zfy0KwSv3uMkxz/ma6MYwLov1kmuUvEevG4t6pcw47x8nifcx4jQM0n9YgY6bs/18Cfjkl1iU/brfgvY81fkWl5UMozCaeiaL1I90J+De3EGE6xAATKmWMURTiPz6qEsdhFS8vK9Ci0Sd1rrY9dibkhy+PGSZoPdTgTkRJ5uKxALHongrnCmM2dZMs84Y+2Dyis4cSWKA=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id v6-20020aa7d646000000b0055f129cea52sm3369489edr.49.2024.02.01.00.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:07:36 -0800 (PST)
Message-ID: <d5fe1ec2-b647-4902-a599-fb866e96e9cf@linaro.org>
Date: Thu, 1 Feb 2024 09:07:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT
 schema
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>, mdf@kernel.org
Cc: avandiver@markem-imaje.com, bcody@markem-imaje.com,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-3-charles.perry@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131230542.3993409-3-charles.perry@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 00:05, Charles Perry wrote:
> Document the slave SelectMAP interface of Xilinx 7 series FPGA.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> new file mode 100644
> index 0000000000000..c9a446b43cdd9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx SelectMAP FPGA interface
> +
> +maintainers:
> +  - Charles Perry <charles.perry@savoirfairelinux.com>
> +
> +description: |
> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
> +  parallel port named the SelectMAP interface in the documentation. Only
> +  the x8 mode is supported where data is loaded at one byte per rising edge of
> +  the clock, with the MSB of each byte presented to the D0 pin.
> +
> +  Datasheets:
> +    https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
> +
> +allOf:
> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,fpga-selectmap

Your description mentions "7 Series" which is not present in compatible
and title. What is exactly the product here? Interface usually is not
the final binding, so is this specific to some particular FPGA or SoC?


Best regards,
Krzysztof


