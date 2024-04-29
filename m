Return-Path: <linux-kernel+bounces-161784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B548B512B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B64B1F2214A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BA910A09;
	Mon, 29 Apr 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NikMa4Ub"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACC1427E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371506; cv=none; b=dBJmcP1z1J7Iq8MeocneUkWfs9Iqd0S5Fme8VqGipI0ofUrklRPWY5eYVaM0hlXGwQlUR/nHoEU2/wAaf7AMIbk8RdfuGAYhvAzXCv31W9//mJhmWB2rYZnZ+aGYxi3jL42C4JjQr9+mTMNEnCkf0Z2lyMAuO5v+D+DITkiaUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371506; c=relaxed/simple;
	bh=JNfqQCe5qBY4N6gY7+7ITLqVIA584kDToq0W6krzqyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUJuY3rY5GOauZ4nkSifhi7ud5ceE3T/51fq0T6+dMNIdkNFOGoU+/n99hijx8bb+uoLJag1RLgyQj8/zrzNWAnJubEqAAZKaIUZ86tjfBj6h2khX9t2WzzUq44f2R2hwrFciiYw0ZLoThYDcQcEPPIQ+8pmvDRo44foRJ7/NWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NikMa4Ub; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5724e69780bso4010373a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714371503; x=1714976303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6OSHcF0DscCNaMApD/9fxDqjNfdtcu5lM0oMff7W5GE=;
        b=NikMa4Ubhbd9IolvHTN2tTOX6HBq1hWR/NRPRCa0UxYzRosbscb4+0BCT5Dd7zyOhP
         qZItSx5liul0fBihOg2BUtDn+pwXmxW2JGe0Z7Q9X1myX7Gx27afNCy0DJgFNNAYwEuY
         2lJIS64xFdNtg2D+HKtSCm7ycxHDvznK9jU883JWszyishhm+wLriUevGTLn2vDlgJk/
         dpfKBIRY5cLp/zYDvZjDe9GIvuO9HWtAM0HwA0jNZiCoEzUhtxOx1MoV6xcAl+PJb+m2
         udbK1/oZmJq/WkhH/d2X4DvaalAtrbM2ifUYUNXATz86TW6ujzkj3Il2sj9M12BA/v88
         P6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714371503; x=1714976303;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OSHcF0DscCNaMApD/9fxDqjNfdtcu5lM0oMff7W5GE=;
        b=aetH9JD1Ga0D+iqW9vqVbhjUw9fnbG//+xZjpPZ4vhuji/lK/g2rO5s7LLGofcCwkp
         mRO+Zyx8YI4U3siswU905dNYM3+FPCZK4QTHjow8GZwIRjAlCWICo17EYkgsN2u3i15P
         gGy326xhHW5sFObJJu1KBuOfsY9tja+M4HK7RVZlrbFOuC7Tnm5agXTDxUX+RVwa3mo7
         hBVJHjK96L8DxUwb0JYvzAO4+KZmx8SCamYn5btg1DIuFNI5pIW1vLlh71Lx/cnIHXAs
         xfoBkHyRsgIV0rvUDa8iSOcW/i0VRGfSFoFTcwkrW2ava4n4R2/GoL2n4DMr3mCcMPda
         hNMA==
X-Forwarded-Encrypted: i=1; AJvYcCXhY91yUiR9iaHJzXkQtfgpStRjusxV9nZNeTLdkzuu+soYo29FMJIp5Z2iceNOEa3e0KKhCBkPf0xJjZwJJybSdNnz/uvPNW57mtt5
X-Gm-Message-State: AOJu0YwY0xS36hVdHI9ma0Nxq+C1Wje+vgcBkf3zPmiDGs+FI1fZeHop
	djPbmmZRkbpCXU29nlJfo92ljplp0GIR/3CsKlao3dw5dWuxoKLcpcv6BPuAOfY=
X-Google-Smtp-Source: AGHT+IGLANFVWHe8EE4z58eE9oJz2BA/NXRAYwi2DipvCTG9A2of1v4DQtCQq4Cg4tJvCclMirW1Wg==
X-Received: by 2002:a17:906:40d4:b0:a58:873e:a058 with SMTP id a20-20020a17090640d400b00a58873ea058mr6256671ejk.27.1714371503543;
        Sun, 28 Apr 2024 23:18:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906614200b00a588e0e0d9bsm6234685ejl.93.2024.04.28.23.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 23:18:23 -0700 (PDT)
Message-ID: <40eee0ca-fb15-40c7-80be-a1198f37663d@linaro.org>
Date: Mon, 29 Apr 2024 08:18:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: add sophgo spi-nor-controller
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, broonie@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 unicorn_wang@outlook.com, inochiama@outlook.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: dlan@gentoo.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
 <20240427075426.662671-2-qiujingbao.dlmu@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240427075426.662671-2-qiujingbao.dlmu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2024 09:54, Jingbao Qiu wrote:
> Add YAML bindings for cv1800 spi nor controller.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  .../bindings/spi/sophgo,spi-cv1800-nor.yaml   | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml b/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml
> new file mode 100644
> index 000000000000..121a80fbf2d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml

Filename like compatible.


> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/sophgo,spi-cv1800-nor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI controller for Sophgo RISC-V SoCs
> +
> +maintainers:
> +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,cv1800b-nor

A bit unusual that compatible has nothing in common with tile of the
binding, thus the name of the hardware block.

> +
> +  reg:
> +    maxItems: 1

No clocks? No interrupts? This looks incomplete.

> +
> +required:
> +  - compatible
> +  - reg


Best regards,
Krzysztof


