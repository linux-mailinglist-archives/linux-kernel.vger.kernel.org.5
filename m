Return-Path: <linux-kernel+bounces-35230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754CE838E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24701283734
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69985DF03;
	Tue, 23 Jan 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6MkMbWm"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C605D916
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011753; cv=none; b=a9sY5woJZ5vBZXkxtlJFVWIA4bKtwx/8oS7WxpFDHFxlzIXnD27TX3u9vzCHh988LwbAncnEaVTxGl4BEFj4mydY9YoCNUIz083XAK8r1lHxGiC1qAnxw7/EiW346HqzcL7qP+YUJkCJ1BDecNd7JMl2cJyC3vQso02XJkop/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011753; c=relaxed/simple;
	bh=FFfT5q80Hs3zDMjLI3EodrE/Zh2o/sWHApPCFclFeC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3Weyqo41rB23ZYdmp4bfY+zBTKA5bny8zrMoFpcXNE72dqKBklBC5K7ekpEilpMC9lgwPD31DpNIe4ZSdzu8LF2oeqytBFA9ZuL+MIjkDZ78YZCUn7ySTxAngCTIAEEaVQGFVNZ99FIfLfiOocsGqdzCvW2onTOaEHdvrXfQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6MkMbWm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392291b21bso3608113f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706011749; x=1706616549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3C8Fw5l+jhncPA4wDIldFznr0WXO1yKPR2qB2QrPqU=;
        b=j6MkMbWm/Ky+OXkpG8xFxAoK6HPI8/NmzIXR/+CHWPrj8HvPFbQGmX7CKu+xqi1z1m
         lkls/ofkWLmM1H2JLoGr9b86FFF6if14T8L4VlzkvMVQC//RzL6P5lHwPEwyC/7wumU+
         2VNodlIz4kV5EAFz/aLK7o6zzFhTjcuPv4xzXr5mt6OTEHcRiu1Krtjf8Wbw2t5uS//9
         Z8dzEcuFEMCUe/hXKbCdnbVv0eso1qkUpdKDNYZjNsEZyFlc7Z704XyQlFDUUrzO/M8w
         S8ZgtjyQnT+E1tPZTAKb5NaXT875yQKnYEtWotHLGIVd6n7YDJnED64ddHCAg93kllTW
         TA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706011749; x=1706616549;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3C8Fw5l+jhncPA4wDIldFznr0WXO1yKPR2qB2QrPqU=;
        b=i27eUq0dTo+LA5cqATC8394QF8VKM4sLWQnvRdIz4GAUeGe4gPG2qnl0u0ag6YQ922
         tX4tvkvYyS3FOymtRVm3WZTkwjzejrAdNjE99AB33Yd9wHSTTRki9YdKcsu7Vq5H+Oa3
         Po+V9sETQ4M+dZyQZWdeIh8GN6jtEr11sT25j4MpREqZ0pzzwTrzryGQ1+9TdY3QaPqc
         JcZf2rAdsbMWI+xR/yT7KD2UDnX1W0W4vOmQd/KhpHe3m1sAjtrEg2QDQEH+vdnXP0yh
         bIELgSu3W0znuuELnThXA930FpwGAbmliIM1JgOb14rs8Afx0Cx7Ku1MWlKKQhwxhBDr
         Ilww==
X-Gm-Message-State: AOJu0YzYVoF5JDl0x1LiYwYW7xleIUYVDt+aaOVAVjbCnSiCqcSGdxkl
	BE/OpGJfWuLdAborPrpYJzihxuPcXNUUzVIFRe38On74EYxYWlHii7fDNibobTA=
X-Google-Smtp-Source: AGHT+IHQmsUP+BU7Tso5igJYN5GTEPdX50NGuYMN9RVsXOr4bhNHRPYgbh0Bp1hDTMEC9YUNwolbyQ==
X-Received: by 2002:a05:6000:1f89:b0:339:372e:7714 with SMTP id bw9-20020a0560001f8900b00339372e7714mr2297966wrb.32.1706011749386;
        Tue, 23 Jan 2024 04:09:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d604e000000b003392cdeb3a2sm7140080wrt.103.2024.01.23.04.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 04:09:09 -0800 (PST)
Message-ID: <1fc9815e-76dd-41d7-aa1a-caa72ef4ad34@linaro.org>
Date: Tue, 23 Jan 2024 13:09:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Content-Language: en-US
To: Amrit Anand <quic_amrianan@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
 Elliot Berman <quic_eberman@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/01/2024 12:20, Amrit Anand wrote:
> From: Elliot Berman <quic_eberman@quicinc.com>
> 



> 
> How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
> -------------------------------------------------------------
> The selection process for devicetrees was Qualcomm-specific and not
> useful for other devices and bootloaders that were not developed by
> Qualcomm because a complex algorithm was used to implement. Board-ids
> provide a matching solution that can be implemented by bootloaders
> without introducing vendor-specific code. Qualcomm uses three
> devicetree properties: msm-id (interchangeably: soc-id), board-id, and
> pmic-id.  This does not scale well for use casese which use identifiers,
> for example, to distinguish between a display panel. For a display
> panel, an approach could be to add a new property: display-id,
> but now	bootloaders need to be updated to also read this property. We
> want to	avoid requiring to update bootloaders with new hardware

Some mis-indentation in two lines above.

> identifiers: a bootloader need only recognize the identifiers it can
> handle.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> ---
>  .../devicetree/bindings/hwinfo/board-id.yaml       | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwinfo/board-id.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwinfo/board-id.yaml b/Documentation/devicetree/bindings/hwinfo/board-id.yaml

I think we should add it to dtschema, because bootloaders are using these.

> new file mode 100644
> index 0000000..82d5ff7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwinfo/board-id.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwinfo/board-id.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Board Identifier for Devicetree Selection
> +
> +maintainers:
> +  - Amrit Anand <quic_amrianan@quicinc.com>
> +  - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Device manufacturers frequently ship multiple boards under a single
> +  software package. These software packages will ship multiple devicetree
> +  blobs and require some mechanism to pick the correct DTB for the board
> +  the software package was deployed. board-id provides a mechanism for
> +  bootloaders to select the appropriate DTB which is vendor/OEM-agnostic.
> +
> +select:
> +  anyOf:
> +    - required:
> +        - 'board-id'
> +    - required:
> +        - 'board-id-types'
> +    - required:
> +        - '#board-id-cells'

I don't fully get why do you need this select. Isn't the schema selected
by nodename? Or maybe it is for the final required: but then this could
be just set of dependencies.

> +
> +properties:
> +  $nodename:
> +    const: "/"

Blank line.

> +  board-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      A list of identifiers that can be used to match with this devicetree.

s/devicetree/Devicetree/ ?

> +      The interpretatation of each cell can be matched with the

Typo: interpretation

> +      board-id-type at the same index.
> +
> +  board-id-types:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      Defines the type of each cell, indicating to the DeviceTree selection

s/DeviceTree/Devicetree/ ?


> +      mechanism how to parse the board-id.
> +
> +  '#board-id-cells':

 What are the cells for?

> +    minimum: 1
> +
> +required:
> +  - board-id
> +  - board-id-types
> +  - '#board-id-cells'


> +
> +additionalProperties: true

Best regards,
Krzysztof


