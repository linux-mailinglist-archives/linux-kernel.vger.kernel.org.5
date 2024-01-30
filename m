Return-Path: <linux-kernel+bounces-44075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D487B841D05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF5C28A996
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CC54FB1;
	Tue, 30 Jan 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Beqw0bnC"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DD55E51
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601166; cv=none; b=qEbSmo0ttmz41BgXfwa/AD8+XsyGPXsnM7k8FQTnXFnA9ZeCuYECzu9OdY214XTpfMb5RMiilAbaEhbbqSrvqums+1KNqByqociZp9plpBvHK/DBfpuv12eJp7yCh0utR2ujNx2l/7QZKmJUG6TXeLVowg9gu40SIsK8ZQdwsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601166; c=relaxed/simple;
	bh=wX/cSkVhOD37YLXx8TXC84or0oQIMYmpv13UUnXw4QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/7Kfbt6fhRrFYK/hsefJ3pNfgZH/SGULQA5w+5x2WuG6uOUE/BSV/udABHZJyAoNymuWduDNDkMj2YxWzmHHKjwho+wkq6wL8lEdXXgmZuBTbhbHf01RsvP4JWYEMVbRvEL+dfLdNEuG8JTQc0MH5/0palHjJ7fXkhM84vIn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Beqw0bnC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3604697d63so122585166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706601163; x=1707205963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XCQ3iVSw/+URR4a59LoweURL5k38c3LLPGYtZCSL04=;
        b=Beqw0bnCbw4gwSPVQA+yQEQ5AhR8Ng15URubPFxrBSVqHLEjVY2ESweWL8cu37mTWk
         AxFmrft4LnCs/ABsdsxVmZ8jh/lq3dqTU8LH96Dp3jVjodyWAMP5vFStIcqXV57/X/U0
         cyfUYWB4pw87/Mjuuujgo4afnvzI7omffP/+To5PRgOVSOXiR/SGjyNDYVACkoKJ6pdf
         tft5D5cn1ZS4Jzjwg9UOoTi5CTrvSRUqdzJzsVaPIB1U2jI4fI8nPLg0BWgscEgc+2X3
         I7i3tFZLRZAlxPR/03Ou7KaxnC2J0JTGHQ7nV87ZGD3Mw31CVEVL6DK3K2OJXwjnm3tE
         nArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706601163; x=1707205963;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XCQ3iVSw/+URR4a59LoweURL5k38c3LLPGYtZCSL04=;
        b=QZffa6MF7yUP+YIviCuP3aYsU87c9arEKs2GWX3XFhMVq+VjvWxwOX8DBbcdLO6G/L
         yBzTKqXlMY/iuSqR2gJf0k0nyRiQDdQ4LvCCj9+bAxDPUjbkSdmC6pmnT8vNsHkwp1ks
         trmSh0nqem6pSAGPOmjerweF+Nmr8971PK0yDmNum2QO9JirCK1jemyWOffJqHxUEjFa
         wNF+CUmFGQpRV9hxW4TAtY3JGIbesf6Vn7BDbOttWbdqkvjU9wMp0ECp84Gkfu5z/WkX
         MXkrQU1dNMSORR96EYC75hB/h1ZJ1sagjYUMHp7ygcVITWfpXTiLmZRIyveA3pwybBsi
         6Hjg==
X-Gm-Message-State: AOJu0YwkasYXEcQgS/O/d7MMBWL1UMJzttGHV0/n1DvNWqjfV+coNDBa
	mtOE4aITEnAX9r7gveLfQ93fPhJWQlEWkSCGWoyWlq+waf3jT0jeVfOVKCdxwkQ=
X-Google-Smtp-Source: AGHT+IFhkZxPz8ioygD1TXGOx+YvFAa7CxqLmJd3uZNH21JM4jO5puzb7L+VWSq9PiAqVOLJe4IsXw==
X-Received: by 2002:a17:906:f242:b0:a36:1ea8:f412 with SMTP id gy2-20020a170906f24200b00a361ea8f412mr595398ejb.43.1706601162832;
        Mon, 29 Jan 2024 23:52:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ss6-20020a170907c00600b00a3533f17981sm3846787ejc.219.2024.01.29.23.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 23:52:42 -0800 (PST)
Message-ID: <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org>
Date: Tue, 30 Jan 2024 08:52:40 +0100
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
Cc: hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 krzysztof.kozlowski+dt@linaro.org, bcody@markem-imaje.com,
 avandiver@markem-imaje.com, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 23:56, Charles Perry wrote:
> Document the slave SelectMAP interface of Xilinx 7 series FPGA.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  .../fpga/xlnx,fpga-slave-selectmap.yaml       | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
> new file mode 100644
> index 0000000000000..20cea24e3e39a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-slave-selectmap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Slave SelectMAP FPGA
> +
> +description: |
> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
> +  parallel port named the slave SelectMAP interface in the documentation. Only
> +  the x8 mode is supported where data is loaded at one byte per rising edge of
> +  the clock, with the MSB of each byte presented to the D0 pin.
> +
> +  Datasheets:
> +    https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,fpga-slave-selectmap

You did not test bindings, so only limited review.

> +
> +  reg:
> +    description:
> +      At least 1 byte of memory mapped IO
> +    maxItems: 1
> +
> +  prog_b-gpios:


No underscores in names.


> +    description:
> +      config pin (referred to as PROGRAM_B in the manual)
> +    maxItems: 1
> +
> +  done-gpios:
> +    description:
> +      config status pin (referred to as DONE in the manual)
> +    maxItems: 1
> +
> +  init-b-gpios:

Is there init-a? Open other bindings and look how these are called there.


> +    description:
> +      initialization status and configuration error pin
> +      (referred to as INIT_B in the manual)
> +    maxItems: 1
> +
> +  csi-b-gpios:

Where is csi-a?

> +    description:
> +      chip select pin (referred to as CSI_B in the manual)
> +      Optional gpio for if the bus controller does not provide a chip select.
> +    maxItems: 1
> +
> +  rdwr-b-gpios:
> +    description:
> +      read/write select pin (referred to as RDWR_B in the manual)
> +      Optional gpio for if the bus controller does not provide this pin.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - prog_b-gpios
> +  - done-gpios
> +  - init-b-gpios
> +
> +additionalProperties: true

Nope, this cannot bue true.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    &weim {

Drop or use some generic soc

> +      status = "okay";

Drop

> +      ranges = <0 0 0x08000000 0x04000000>;

Drop

> +
> +      fpga_mgr: fpga_programmer@0,0 {

No underscores in names, drop label.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +        compatible = "xlnx,fpga-slave-selectmap";
> +        reg = <0 0 0x4000000>;
> +        fsl,weim-cs-timing = <0x00070031 0x00000142
> +              0x00020000 0x00000000
> +              0x0c000645 0x00000000>;

NAK.

Please run your patch through Xilinx folks before sending.

Best regards,
Krzysztof


