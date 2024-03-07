Return-Path: <linux-kernel+bounces-95081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E92874903
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482B81C23C92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685AF633EA;
	Thu,  7 Mar 2024 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdZN+/Sg"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744F6313F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797578; cv=none; b=DIKEAW0WB4bek9T7DKe1HLdxDZ8wYWX1uSx69bNaEkjEDOd7VUrXQZj0tqq+c5K6r8jI7LPczZ0Bk+wLhSv9KgZUaOgwhHE8iZAESo8h41nmX2WAXRQIEAfUHx1/uWa4nJuKzd4CrFpUc3Qexitjvy4WzIkx4oQ6iQKxLtFUeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797578; c=relaxed/simple;
	bh=K4UuCTqbtVUs+hCPRMX+6oAiv0iEWBzeHyg7GI4cknA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVFedOl9F/WUjPBK4VjL4OPlOhEGs43/xIJct6JtzBRWOB2hILRVlyeKrgIYSX4Sb0yQmwqtiiYSXAJZrEcwEhb4fmw1HvDWso0vnsvBnLS8mL3lJWUVXHW7CW3HjbClDYcM2mZfSHB7AracIR+olHP2Krhdt8a51qsZJp06wsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YdZN+/Sg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a452877ddcaso76008766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709797575; x=1710402375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vEFocjxe/C7G6zRYMMM39IplkNHkFI1xgU3DzRRjSU=;
        b=YdZN+/SgNH/Vdlq8IlKEOIXy09qQZVsa4c7yADuu/Ygj+cy2Pm+EG9iKX5AXBDatfG
         9Xdbhw/z+Xo/ExUwLuOXzTSyz5TDTTU1sBGVWIoDaTTweZh5lToM53AERDIoFZUA3gAM
         RKWJuuScGJj9B/mpgFZYZZCdz4ZyMhXDQBSoMWh6c05urNCjzzU1CFKbe0U1wnhbymFt
         pBuumrRousQOixwWHY38oV+Ha4sZDURrPfe09ohfvHURFLF7x5UE9rjrUKw3jdHSYGpx
         LORROZO5rJ2VEEL0KHof4MFT970iQrAiykDMvZ1JHwJuB9Rd4EunkJOrtNEwGxdeujjT
         Hd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709797575; x=1710402375;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vEFocjxe/C7G6zRYMMM39IplkNHkFI1xgU3DzRRjSU=;
        b=VjhokWj9vfIlfqp9lDBBo0L7SWLqMK6hAHt5kKh4no5f7EcmWtEm6YDOJuxTbu/H5e
         QjI3LgJlbDVsi2x5OjQYBryWpLUL6hDzYvEzRmlK9UixHNB8znM/ky/Z0dXeN4+DR8qz
         EZPRpzp85QHD+rXZCBYVbhMP7AdHxyhym3swuUZVI1ya34QRBZuTUPXU7qC2Mu425uF4
         lG2sbjq1DEDrLu0fNZy9dCXzC0uLOgxKIO1jceW+aabfdEKmiZdepOQe6ztBl6VsM8J2
         VZrwLPF4Zi6hky83tju/Z1oNEtEZwptdltFs5dkJqKfy9KfgJpj73deSigzNFWav/zkN
         Wr4w==
X-Forwarded-Encrypted: i=1; AJvYcCWuybKAL3V2vG6j4PHFJBLKy8ukdeNFehmniWVtIr5Z3Q+2f1Ba3pnwXDhF2kifuVETkZ8BV1k5UZ2ztdtLYKUV55T8/l4b3k+AZwI2
X-Gm-Message-State: AOJu0YwoOvOx0hMJCt1o8zakdxlLXKqFP4wtZr520veQk/eGJKAyxUEE
	FKG2zVyogfiz6DYhfQPKaFKyBOhxT7R79aSzMgqwpmVqkSnn1kmmV1sucJzRzr4=
X-Google-Smtp-Source: AGHT+IFpl4af52prw6dvxD6VpZHr8XiDzYEFEVnS7NoLGOSu1hUyybkH3c+zyzSjt/Clbzqqa8vELA==
X-Received: by 2002:a17:906:f6d1:b0:a45:d712:7b3e with SMTP id jo17-20020a170906f6d100b00a45d7127b3emr372989ejb.52.1709797575088;
        Wed, 06 Mar 2024 23:46:15 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id tj7-20020a170907c24700b00a413d1eda4bsm7959287ejc.87.2024.03.06.23.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:46:14 -0800 (PST)
Message-ID: <19d3c024-38aa-4526-b6c1-d9543b41fa2b@linaro.org>
Date: Thu, 7 Mar 2024 08:46:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] spi: dt-bindings: add binding doc for
 spi-qpic-snand
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20240307041726.1648829-1-quic_mdalam@quicinc.com>
 <20240307041726.1648829-2-quic_mdalam@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240307041726.1648829-2-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 05:17, Md Sadre Alam wrote:

There is no commit msg.

Subject did not improve. This is a friendly reminder during the review
process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.


> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v3]
> 
> * Updated commit message, removed "dt-bindings" from commit
>   message
> 
> * Updated compatible name as file name
> 
> * Added hardware description
> 
> * Documented clock-name
> 
> * Moved dma-names property to top
> 
> * Droped unused label "qpic_nand"
> 
> * Fixed indentation in example dt node
> 
> Change in [v2]
> 
> * Added initial support for dt-bindings
> 
> Change in [v1]
> 
> * This patch was not included in [v1]
>  
>  .../bindings/spi/qcom,spi-qpic-snand.yaml     | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> new file mode 100644
> index 000000000000..3d20a4bc567f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/qcom,spi-qpic-snand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QPIC NAND controller
> +
> +maintainers:
> +  - Md sadre Alam <quic_mdalam@quicinc.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The QCOM QPI-SPI-NAND flash controller is an extended version of
> +  the QCOM QPIC NAND flash controller. It can work both in serial
> +  and parallel mode. It supports typical SPI-NAND page cache
> +  operations in single, dual or quad IO mode with pipelined ECC
> +  encoding/decoding using the QPIC ECC HW engine.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,spi-qpic-snand
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3

Drop

> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: aon
> +      - const: iom

Missing blank line

> +  dmas:
> +    items:
> +      - description: tx DMA channel
> +      - description: rx DMA channel
> +      - description: cmd DMA channel
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +      - const: cmd
> +


Best regards,
Krzysztof


