Return-Path: <linux-kernel+bounces-69896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D7858FF5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08D71F21DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE17BAFA;
	Sat, 17 Feb 2024 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3euXprI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73E7AE59
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178642; cv=none; b=gDAo+59e9ZqX7IoDd7qRpCFTcZrVgZ45TiJN0i8HuwtEmpjJTphuRh/wgoD1oAgaTBf6fft7I5I0cia4aeTUjcuQGe5sXC0xaf3m9LMdZ2jCv+tIPNGKJhvJktr019TZRqQptkunaECPB4qyuebFAIdFYMbJgLCB2p4mShWUFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178642; c=relaxed/simple;
	bh=lvU2v64WlGR1dhPmLDI3saZHTA5WwbIw32SsPwsghx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuAo5bbDk2Il9xCI7LeN2aZ2ivYxxM/GykxXdNwqGhNH56GWW8+P+GOrrFf9EQZZi8MLmp5vkv1+wvuvCOyc/LVxT14q/YtYSr9J9PNWukOZzW32qYuNB6zql7R9FFSbXp9l/rR/Ajr9dBBXpoNjEMDZXHLGf74MT8ETJ9/8py0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A3euXprI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d159220c7so232136366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708178638; x=1708783438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PhPFHuwtO8w2QKXW2gu/QUXLYzvkW53YBBCtnvtQko=;
        b=A3euXprILIKyt3sT8BbgdPHJqT/AbuBWORghk6JUE5ZXDqCz4bn/dhJLicUWQZoPtS
         5VCyw6mpq24pcmsKhA5BL3gliNcTjIc4/gJhNIM9cgUJtLP4+xq1ImvX2CD8I2svrjCM
         4US20uPI2WDvcRjmOyG4ljTKISsWukQM4THVCTy/YecyToAK/dI5gB3O4zHHFtmsMtxk
         QOjsu7HpHfjpYaChOAIX6arKyWfREzdWkn2ro/QHMepQXAg1PC9yJd9t6JP9XmTgpgso
         nm606TRZji/aED+m0vClOq1vIECTXiO3GtLxZDODPYl6P50+3SHdd9Lgg2peqQD9ni2U
         g8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708178638; x=1708783438;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PhPFHuwtO8w2QKXW2gu/QUXLYzvkW53YBBCtnvtQko=;
        b=rOjBHFYsjlkX5W1Je0U1qsJ+vPXCf6ZRqxmtMaP/aGbaZuH4QYK5k0Li+/awiHgxBr
         Hpuq+bnxvyT+v+v72bWbx0G7J7YPr0PZdOttabxao/RGxCmJoWO4gt2WPS0EMgpzRupp
         C6NlFWRvWdvHRCu6OL6CokT1kA24OGCRRh17Qgz+3aEcwwMSkpm+TZhAjpAFFDVAgpsv
         yVt8NMnNIWZ7n9gqVHH6kPG0VvcV86iiW93H8wzB7MGXdDWb/O4MxiC2op6OoWd3ZAKb
         VuJA+BgrCGTTJKhm9g48MwdpZxXAvJJhn6lywI3cK8uJLS+fN6w6XnCe9/v1tUAsCv3k
         F/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVu0kNbMwDhvGnUDGPPQD+rGgSSVdHhs5iTELv8IccM4YXNJG7SWaCh+Ii8aMoY9HcLHMwMKNx5xRlHI2Nn5Tp0zUIWlvgVMEefmGQ+
X-Gm-Message-State: AOJu0YwWrrf8ns/dhbjSN6vl8BcilSTE44xE2nsuyOoYSRz9iEHVUfJ5
	f+uqMQgGt1hXW2n2F9O1/hnKC4A38VJQV+4xHjybAhmGWN7MAxdEsEl9po8EKdk=
X-Google-Smtp-Source: AGHT+IEMiUUmnWgyp+ORJN47SOriX5JyCWX4KtveNRE93Pf9HncV9Ax1r3ILLXn5hh3mGU3gukp3Bg==
X-Received: by 2002:a17:906:b106:b0:a3d:dc7f:6e92 with SMTP id u6-20020a170906b10600b00a3ddc7f6e92mr3346084ejy.73.1708178638301;
        Sat, 17 Feb 2024 06:03:58 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a3df24aebdbsm998881ejc.126.2024.02.17.06.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:03:57 -0800 (PST)
Message-ID: <848b6e87-357b-4935-857e-337ad72a2b06@linaro.org>
Date: Sat, 17 Feb 2024 15:03:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russ.weight@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 17:02, Kory Maincent wrote:
> Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
> 
> This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - Enhance ports-matrix description.
> - Replace additionalProperties by unevaluatedProperties.
> - Drop i2c suffix.
> 
> Changes in v3:
> - Remove ports-matrix parameter.
> - Add description of all physical ports and managers.
> - Add pse_pis subnode moving to the API of pse-controller binding.
> - Remove the MAINTAINERS section for this driver as I will be maintaining
>   all pse-pd subsystem.
> ---
>  .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 157 +++++++++++++++++++++
>  1 file changed, 157 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> new file mode 100644
> index 000000000000..57ba5365157c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> @@ -0,0 +1,157 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PD692x0 Power Sourcing Equipment controller
> +
> +maintainers:
> +  - Kory Maincent <kory.maincent@bootlin.com>
> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pd69200
> +      - microchip,pd69210
> +      - microchip,pd69220
> +
> +  reg:
> +    maxItems: 1
> +
> +  managers:
> +    $ref: "#/$defs/managers"
> +    description:
> +      List of the PD69208T4/PD69204T4/PD69208M PSE managers. Each manager
> +      have 4 or 8 physical ports according to the chip version. No need to
> +      specify the SPI chip select as it is automatically detected by the
> +      PD692x0 PSE controller. The PSE managers have to be described from
> +      the lowest chip select to the greatest one, which is the detection
> +      behavior of the PD692x0 PSE controller. The PD692x0 support up to
> +      12 PSE managers which can expose up to 96 physical ports. All
> +      physical ports available on a manager have to be described in the
> +      incremental order even if they are not used.
> +
> +required:
> +  - compatible
> +  - reg
> +  - pse_pis
> +
> +$defs:

Why do you need defs for it? You use it only in one place.

..

> +
> +        pse_pis {

Again... no underscores in node names.

> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pse_pi0: pse_pi@0 {

Just compile your DTS with W=2.


Best regards,
Krzysztof


