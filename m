Return-Path: <linux-kernel+bounces-160659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4228B40B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461A1B21E00
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D9722334;
	Fri, 26 Apr 2024 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LKz5p9fq"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11846A4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162280; cv=none; b=pIshWQDL+FghLYxECtyVZqNsXMp2xf3itKi2pFXF1tqERogL/l07sZJeHRwkEzmqBfKpuTiQ3NCd6FmTP7KRT672pQcRdM54KiQOnnpO0l2FaDpcbOHHYz+sFmZpSxpOwBcd2U5rLGWdAQ1aTsqWDzmlzfKaik0u4BvxzuBHiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162280; c=relaxed/simple;
	bh=CCtrDmowOfUzSRgAL6a/caO428RWP0SEeDG7dtLDLu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3ROFSd2DB+zZySZjNjdnfW4kdLo2YumPFtKrsE+XqGiz5XNxa8J9nzsHLZ/Wx3YM9qrkn+5XO/AYn4zR97QBC3yRkh3T9JIQMrFvSKoXU2MXcATz4RmB1mCWt9Zv+COFzAlr7WArl4CoY0m0putZPJ87IPM5f6jo0D3ucYjltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LKz5p9fq; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c751bf249cso1652734b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714162276; x=1714767076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CwGplRyVlrAojs0p2Bji7yf6qM7XioPGpQcoYE219Y=;
        b=LKz5p9fqrQuDYdCfGxq7VMw3zzd2k+fVYbrPnBE49UogwCka8EC7lu+/RyKUFawqJ+
         XcpN2obHhLp9watFnRtosuTZU8UI+mUktNgiH+1jo4mhs7bcrAp2k+YzV3EMDLh7St8N
         5uB/cHn7Ab0Cu6ITrxmkSDQLCa++u5cwAHJcRTqCOXspQWBOQCOJRhx8Xr08n/ao+72o
         Rjwo/psXVmMYnKo30ev5Bl2GSeiyHEs1POHRM2RQYu63R6VYNMn/NXk755+Qf8eWPmsZ
         kleXOhfKluaqe1pUVvikyNn0y1ovkU98uakFMMxC9N0Ydle9i4ZwjF7Twr86384UYLQ7
         Le/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714162276; x=1714767076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CwGplRyVlrAojs0p2Bji7yf6qM7XioPGpQcoYE219Y=;
        b=Z1GFwzBUL1uF+TsMRvTdIrLXxN5Yo1CzpyiF/SSeL3ELv6j8rpz839Le18G4lmZAPc
         8QrtlgHw6CogykDOsxqpoKvHH1tXJdoo5iF9iz3x/50x6EunTUn9jpdwy3YYVeXs1d4g
         t+/JrW7PzHsobQbswl7Zvl9nVbR9QC5lMvHrRmXQIgSWftO8iXfUATW9Ut5LHdP8GjOJ
         ILiirSeBb487OW3wnOKJT/V0PcJGn+yTbGidLPmDDHIV2lhq9uusxpRyCBgGJx4zZEH5
         yvoeNDy1UaZloWsWpBwOOKtw8IqwyTxB+C6akbyN3dvMUBdvRv+mVssrBX/yJ8IQbTwX
         VVBw==
X-Gm-Message-State: AOJu0YyFzvWosCc7uvx2uN1r0nWSpbVXxLfQvx0jymCLtGZL4EN5ZaN7
	rK7LSODPLZ0yKoKnQCMZ+H7Oj0mhdMv3oPqrAvHKVtFtxJ3CJi+5J+ccubgNogo=
X-Google-Smtp-Source: AGHT+IGmGPMXguo4qOP7xmoYacLCC657AcV/qNocAoxOLQZB8ATEhQX5SkqofkF+5cuwjvIkYsjtUA==
X-Received: by 2002:a05:6808:628e:b0:3c7:546a:33b4 with SMTP id du14-20020a056808628e00b003c7546a33b4mr3467736oib.20.1714162276318;
        Fri, 26 Apr 2024 13:11:16 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cca87000000b006969f5d3159sm8227068qvk.50.2024.04.26.13.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 13:11:16 -0700 (PDT)
Message-ID: <8bc13253-db16-4801-9f69-b06ba4e129be@baylibre.com>
Date: Fri, 26 Apr 2024 16:11:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v5] dt-bindings: pwm: Add AXI PWM generator
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
References: <20240424125850.4189116-1-tgamblin@baylibre.com>
 <20240424125850.4189116-2-tgamblin@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240424125850.4189116-2-tgamblin@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-04-24 8:58 a.m., Trevor Gamblin wrote:
> From: Drew Fustini <dfustini@baylibre.com>
>
> Add Analog Devices AXI PWM generator.
>
> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Note that I missed the following two acks from the v4 series when 
preparing v5:

Acked-by: Michael Hennerich<michael.hennerich@analog.com>
Acked-by: Nuno Sa<nuno.sa@analog.com>

Trevor

> ---
> v5 changes:
> * Modify to list only the supported axi-pwmgen-2.00.a version
>
> v4 changes: None (rebased, added maintainer's previous Reviewed-by)
> v3 changes: None (rebased, added maintainer's previous Reviewed-by)
>
> v2 changes:
> * Address feedback for driver and device tree in v1:
>    * Relocate "unevaluatedProperties" in device tree binding
>    * Remove redundant "bindings for" in description
>
> ---
>   .../bindings/pwm/adi,axi-pwmgen.yaml          | 48 +++++++++++++++++++
>   MAINTAINERS                                   |  8 ++++
>   2 files changed, 56 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>
> diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> new file mode 100644
> index 000000000000..ec6115d3796b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/adi,axi-pwmgen.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI PWM generator
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description:
> +  The Analog Devices AXI PWM generator can generate PWM signals
> +  with variable pulse width and period.
> +
> +  https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: adi,axi-pwmgen-2.00.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pwm@44b00000 {
> +       compatible = "adi,axi-pwmgen-2.00.a";
> +       reg = <0x44b00000 0x1000>;
> +       clocks = <&spi_clk>;
> +       #pwm-cells = <2>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebf03f5f0619..d02ece54ccf6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3465,6 +3465,14 @@ W:	https://ez.analog.com/linux-software-drivers
>   F:	Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
>   F:	drivers/spi/spi-axi-spi-engine.c
>   
> +AXI PWM GENERATOR
> +M:	Michael Hennerich <michael.hennerich@analog.com>
> +M:	Nuno Sá <nuno.sa@analog.com>
> +L:	linux-pwm@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +
>   AXXIA I2C CONTROLLER
>   M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
>   L:	linux-i2c@vger.kernel.org

