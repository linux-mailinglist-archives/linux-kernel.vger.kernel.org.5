Return-Path: <linux-kernel+bounces-32541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E5A835CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C97E1C215A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29D38F94;
	Mon, 22 Jan 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0h3nTvF"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7C374DE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912980; cv=none; b=eUx1/2v8SK7zmWeVf+t3pK9q0Z0HaSHFI/bcSA5cLquxHG6FEKNv7GETOyFTk4wU0qwQkbBjEmfxCMwbImI++qmehGRbwwZkNGs3ErYVoVtCLE8B970HZnMSlbIljkpn49EjXaipPALbOv2T2jZnuuz7NAXV5V/02K+SmXKfJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912980; c=relaxed/simple;
	bh=n5Qbq1n5cLV+iONGulmYwMK+DXx9gzMF5gqMOJ03dWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EurS0G1S4KiLo+JiBWqhvhmsPD9PeEIdOom6M7grMUnjSS3a045fLjC3VJZvW0TGAiJcPSDI6MGcE8DmB8vi1TlrLxPAtNClg9A8mf1Nv8niMHeOhVnXiVvOKrxuXX8Nc7RACzvKAtFRteRdMAgMoipaU4kI1wLzObyNsA/4LQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E0h3nTvF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so7016458a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705912977; x=1706517777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cXJp2iHKCpHhIfNj6YucZ/54ivGE/1xCso8Q+jMjE4=;
        b=E0h3nTvF8o+r6cD4nbDBFC6CIal1B5Rrg/32QeZVtdfMH02NnD3cPZlY2/0k+3qnir
         +0BBi1KE5OgeVUk73I0MQlnfw+8R5jWwlJYJVCiRO26twMoRs3Cjttp6BpqcYkfNAppF
         xiBKVrhyKwskXVF4KUxi7oCf/5vpWZ6IjkM3fH6sNqKBsfBPb0B7pKecwB3ga6zw4GRo
         V4q6l06PDoJb+VfqUnqbQiONOpvRFIVyf2JNicNthXzArA56607jErXGcixnJgQGWe7n
         oEPdx6o2T+pbktGaLwDdsnumeG+Ijy1X4oEAo1FASYnjWKEbVdq/FF2RHxDUyVofMzJ3
         o5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912977; x=1706517777;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cXJp2iHKCpHhIfNj6YucZ/54ivGE/1xCso8Q+jMjE4=;
        b=DptVEnQGNujBk+Z+oENsDGZSklNoSIlpkLkMBRMd8LODnGhMGZiy4fsrtlaJqtSwTz
         96pI1tgsG5OwhiHfZU+Or1VIq0p+A7k0sGUNGPpeM4Gxsu2zzlfQRmlQI+7fxBhxQz0p
         WRGKxD6YzXE+K9p12rV+p3ERu4yz0Iej6l6KtueA16KAMfcBjOAudRjjY0Dj1BShbsh/
         nAcR994T091MWcizCrAAbFKce9RwbiEQN5oGrS9rawBp/Y47BLGnR02XGtrigzEJ6R17
         Vf4PGeFv1VR3oG8+REmLca+A8n6/BgEu0vSUldM/UnWqJ9FUPvSqw9rXI1LOsHMLex7b
         6sDg==
X-Gm-Message-State: AOJu0YwgVMCBN6uIMKiN1NrO6fmI9mVGAg3XA3LnbVSoLnPKSTLS0NLF
	Dt05iCIaNCa4dYzsWjUDv6VoadjOLdXCOtzav+jd5WVF/1WFNcu/b77PU97/yPA=
X-Google-Smtp-Source: AGHT+IFR5267HIZXn2DvthXiQPsUwsNr4cWAi4nNyYo1mdHH6MF0D9YOjNzYSbTK5K77ig6AGocwAg==
X-Received: by 2002:a17:906:31ce:b0:a2f:6a3d:e39c with SMTP id f14-20020a17090631ce00b00a2f6a3de39cmr5036521ejf.18.1705912977459;
        Mon, 22 Jan 2024 00:42:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906180f00b00a28cf49520asm13086332eje.203.2024.01.22.00.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:42:57 -0800 (PST)
Message-ID: <d81db1fa-371e-476b-8c48-893a22d11542@linaro.org>
Date: Mon, 22 Jan 2024 09:42:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] dt-bindings: arm: Add support for CMB element
 size
Content-Language: en-US
To: Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
 <1705634583-17631-4-git-send-email-quic_taozha@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1705634583-17631-4-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2024 04:22, Tao Zhang wrote:
> Add property "qcom,cmb-elem-size" to support CMB(Continuous
> Multi-Bit) element for TPDM. The associated aggregator will read
> this size before it is enabled. CMB element size currently only
> supports 32-bit and 64-bit.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-tpdm.yaml     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> index 61ddc3b5b247..507a5f887097 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> @@ -52,6 +52,15 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint8
>      enum: [32, 64]
>  
> +  qcom,cmb-element-size:
> +    description:
> +      Specifies the CMB(Continuous Multi-Bit) element size supported by
> +      the monitor. The associated aggregator will read this size before it
> +      is enabled. CMB element size currently only supports 8-bit, 32-bit
> +      and 64-bit.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [8, 32, 64]

Is this in bits? If so, then qcom,cmb-element-bits or something similar.
I don't quite get what is "an element" here, but I assume you do, so you
will come with reasonable name.

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +
>    qcom,dsb-msrs-num:
>      description:
>        Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
> @@ -110,4 +119,22 @@ examples:
>        };
>      };
>  
> +    tpdm@6c29000 {

You should explain why you need new example, so reviewers will not have
to go back to previous discussions to ask the same question over and
over again.

> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
> +      reg = <0x06c29000 0x1000>;
> +
> +      qcom,cmb-element-size = /bits/ 8 <64>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      out-ports {
> +        port {
> +          tpdm_ipcc_out_funnel_center: endpoint {
> +            remote-endpoint =
> +              <&funnel_center_in_tpdm_ipcc>;

Drop unneeded wrapping / line break.

Best regards,
Krzysztof


