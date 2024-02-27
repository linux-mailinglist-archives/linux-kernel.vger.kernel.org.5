Return-Path: <linux-kernel+bounces-83011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6F868CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FC01C22FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16842137C4D;
	Tue, 27 Feb 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPt4FQgB"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7D137C3C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028633; cv=none; b=R7t9Ph4p6WyAcrnyR+xhmu0BxHsdkJtrW0NT6aWn+i/SDnPSpoxuHkm+zyHnJMnj21goAARa7mJ0CM3tyPZ0ZLJONfQbg8YtDDFrcwbOxjzirsmD7Tiu8WguOkN91Ud2bwxdoL8YOB5kdsfPXVWtSeV3+225JUKszxRpUlvmjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028633; c=relaxed/simple;
	bh=axYkiK27hZmU3U5ZgLd8K7xnXx4RM0UWCxboUYZ9Wrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3FHjBZ/PvXuCbCs3iPqzmjQ7cV9WxM0ly3TQccUYXPrRhFuOa5+CMzmkHU+Vqynoqu/djqgp/b6v5yBM5Ye/rLW1gDLJ8wXzOCT5YKYUZ8/PUkKVYOW0pD45v6OOEVTLHCNarV3SRZtKhlHxSjKTcYl+mHnbNFwnwGaG5E6LRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPt4FQgB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5043883a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709028629; x=1709633429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XORW/Iqcagckfu19U8I7p8d13VH75gCtuVI6ZW/vguM=;
        b=zPt4FQgBcTGS0PnyScoR4CVDiUWJMjFdxvKAD6Vdg+2Cr5f4JW41YT4riCpFriTXdq
         QW6QZv4N80miPoFPZVnZkrYbSBgE6QvRsmzLIKi8MW3GgedmEwpHwz6uWuCrzVPmSQHP
         SEtYKkxAPo/kpYLuZBvKmTy8uAbaEimGSI1LJmqcPWQZPMCpAun3OuCaNqMW1c+I9nF+
         dXra96kMCwg7V2qXc/rJUxXx/GaZXskVhWeBa9PkMz7qwdgO2O26WhJlWmYR8hRyIKbj
         W2Zw9htrSaD081jwgXQsCzlQUhdUcx8Dpi3dDCo5Sn81ExAUQU+6PyvlSOwz96plRjXU
         6JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028629; x=1709633429;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XORW/Iqcagckfu19U8I7p8d13VH75gCtuVI6ZW/vguM=;
        b=OXAZdHXJuRWJqeRHJmSJygyQQCGEIOc/5iBt6T42YwOG3qESB32eufkmUjuCck3Ouk
         KJRi7fqetKGP39TjlsSQlbRNmTwcK6pMSdZqpZYLq+eeyfdAW6dN9i8vGGYQGhougLEW
         Hdy7c6AwJyooDWqieZiUSoz6rd19gfFq3KZYk4rzv43YoR+khKr5tOTWkUNtOwMAwFIJ
         ZogT4jEEy75sCUrSJEYjsPgmxj5rnXVuLF9XpXbCU5LGg3/MIzR1OLyx+bhI2JzwVGUM
         HNNLH6Mr6vRkgcdASfYgLnFH7TwF+CUB86TxnHyWCiB1Tu24nVta9cFm/JDcbgkdWl0H
         /Osg==
X-Forwarded-Encrypted: i=1; AJvYcCVKAXZQmCi+mZzKF1gbJCvwFwigtu7Qm+gU2S9c6XrpObS7kHMIrqir0E8WKs1he9biSCWKXLhZmruS7yMX8328miTm9qsleIh8e4OL
X-Gm-Message-State: AOJu0YxLyEPOvM/BIDKi9uosDnpQ2M/38W893ZEH3G0f5xMnrmKt3x6w
	cLzgr4aAFmqX6l+BzZhZXXAmfkXPfuXnN9oz+L83Zpg9RJOaOzbBNmyMFX2e5kw=
X-Google-Smtp-Source: AGHT+IFjcbEZbar9UxYuUJqI6s2AFCWSOGrFEY4venV9yuOsBPAxM+xYmyyooD8ohZEI7G1h9Aj5xw==
X-Received: by 2002:a17:906:c02:b0:a3d:78a:bffa with SMTP id s2-20020a1709060c0200b00a3d078abffamr6348294ejf.0.1709028629283;
        Tue, 27 Feb 2024 02:10:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id cw4-20020a170907160400b00a43a5bdd58bsm514990ejd.211.2024.02.27.02.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:10:28 -0800 (PST)
Message-ID: <4a9f0eef-590b-45df-92bc-b63ad9282e18@linaro.org>
Date: Tue, 27 Feb 2024 11:10:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
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
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
 <20240221195058.1281973-3-charles.perry@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221195058.1281973-3-charles.perry@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 20:50, Charles Perry wrote:
> Document the SelectMAP interface of Xilinx 7 series FPGA.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> new file mode 100644
> index 0000000000000..08a5e92781657
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
> @@ -0,0 +1,86 @@
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
> +      - xlnx,fpga-xc7s-selectmap
> +      - xlnx,fpga-xc7a-selectmap
> +      - xlnx,fpga-xc7k-selectmap
> +      - xlnx,fpga-xc7v-selectmap
> +
> +  reg:
> +    description:
> +      At least 1 byte of memory mapped IO
> +    maxItems: 1
> +
> +  prog_b-gpios:

I commented on this and still see underscore. Nothing in commit msg
explains why this should have underscore. Changelog is also vague -
describes that you brought back underscores, instead of explaining why
you did it.

So the same comments as usual:

No underscores in names.

Best regards,
Krzysztof


