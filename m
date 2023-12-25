Return-Path: <linux-kernel+bounces-11057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD181E0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE601F21354
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A051C55;
	Mon, 25 Dec 2023 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFW+HR8G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18D51C30
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26f5e937b5so38277766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 05:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703509542; x=1704114342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDk7ERblMSZzmxPuU2OCO6B0rTP+vS6gs+aSEfXyP2s=;
        b=NFW+HR8GcFaDUaBu86szFzDIZTomiAika9oA01c56ry8/xv/Va+4s2T6IHHJe5V6ti
         HowuC+4dx8motk2lHIYnV49OuwbfbXslMA4h+/mmapOZPYq+ma/XY+G8FKWEnV1ncRTg
         Af+L2tl6wOHOJ9Sdqbt0ILh5jh850OTh0Vyvdlwo4htd4/mSX19xmP6iT2t8k4C6ViPB
         fCLRONDJ9qp71MIGvFYJLnKDGZ6SOac2NqcvG+eM+Ddf0NEsteCXoC3m+J8UXxeRUUmh
         7i3cwpFG2WfCz99kUu19GvopICxfuCvRPKlU/AAECcGcXg0GFcdxSScbFyxuaCFknxDm
         1gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703509542; x=1704114342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDk7ERblMSZzmxPuU2OCO6B0rTP+vS6gs+aSEfXyP2s=;
        b=OLtoEmH+zXxbhQc5qcz0ZuehAaiMlCRO77PUTgjBdppphnH0v6+sCMx7gNo3JI6GiP
         FIspIbbERMd4bokraYA7SWt+P4oVlXnWeN3HIMZl14LWDOayAtXuZFB/crB0dRGmL+KW
         nEdqE2lSKP/jz7dShblbUXVfAbpfgxYeBi5WqEsW2YuWEMK9ZTRNvj/HvoU7mHgDWU/0
         f4b4DMPUrZIkOTOwkvQIa3ItUQrgCNK1riT26jtJb7dN0Jy1a0ezK4uteqIafm7trN2J
         TCTwdS/Tj0jsWOlQwSVQscYL2cITJcENnk1YUfqefhJGswZxopA3TKofT6V8DV2Ig0qo
         ZKeg==
X-Gm-Message-State: AOJu0YznmqwrQcnkKIt6efRf3eNYuO309hxGmPtt7cCVBpQB8m0qJFOi
	fP5u1nSSoZAbalkqeg/ly2oWQKF1+T9/cQ==
X-Google-Smtp-Source: AGHT+IFhJ4P90RyO4Idzt9nu7cpUEDy7mhDywJQMQXFCpXr2lx5qVV2Bpo30mJkA4wRh4rF+o3MYEw==
X-Received: by 2002:a17:906:1456:b0:a23:32bd:d166 with SMTP id q22-20020a170906145600b00a2332bdd166mr2511388ejc.48.1703509541798;
        Mon, 25 Dec 2023 05:05:41 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id pj25-20020a170906d79900b00a26b036affcsm3837174ejb.53.2023.12.25.05.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 05:05:41 -0800 (PST)
Message-ID: <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
Date: Mon, 25 Dec 2023 14:05:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 binding
Content-Language: en-US
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Conor Dooley <conor+dt@kernel.org>,
 Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 quic_ppratap@quicinc.com, quic_jackp@quicinc.com
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-2-quic_kriskura@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231222063648.11193-2-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2023 07:36, Krishna Kurapati wrote:
> The high speed related interrupts present on QC targets are as follows:
> 


>  
>    interrupt-names:
> -    minItems: 1
> -    maxItems: 4
> +    minItems: 2
> +    maxItems: 5
>  
>    qcom,select-utmi-as-pipe-clk:
>      description:
> @@ -361,60 +378,21 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,ipq4019-dwc3

Why do you remove it, without adding it somewhere else. Nothing in the
commit msg explains it.

> +              - qcom,ipq5018-dwc3
>                - qcom,ipq6018-dwc3
> -              - qcom,ipq8064-dwc3
>                - qcom,ipq8074-dwc3
> -              - qcom,msm8994-dwc3
> -              - qcom,qcs404-dwc3
> -              - qcom,sc7180-dwc3
> -              - qcom,sdm670-dwc3
> -              - qcom,sdm845-dwc3
> -              - qcom,sdx55-dwc3
> -              - qcom,sdx65-dwc3
> -              - qcom,sdx75-dwc3
> -              - qcom,sm4250-dwc3
> -              - qcom,sm6350-dwc3
> -              - qcom,sm8150-dwc3
> -              - qcom,sm8250-dwc3
> -              - qcom,sm8350-dwc3
> -              - qcom,sm8450-dwc3
> -              - qcom,sm8550-dwc3
> -              - qcom,sm8650-dwc3
> -    then:
> -      properties:
> -        interrupts:
> -          items:
> -            - description: The interrupt that is asserted
> -                when a wakeup event is received on USB2 bus.
> -            - description: The interrupt that is asserted
> -                when a wakeup event is received on USB3 bus.
> -            - description: Wakeup event on DM line.
> -            - description: Wakeup event on DP line.
> -        interrupt-names:
> -          items:
> -            - const: hs_phy_irq
> -            - const: ss_phy_irq
> -            - const: dm_hs_phy_irq
> -            - const: dp_hs_phy_irq
> -
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
>                - qcom,msm8953-dwc3
> -              - qcom,msm8996-dwc3
>                - qcom,msm8998-dwc3
> -              - qcom,sm6115-dwc3
> -              - qcom,sm6125-dwc3
> +              - qcom,qcm2290-dwc3
>      then:
>        properties:
>          interrupts:
> -          maxItems: 2
> +          minItems: 2
> +          maxItems: 3
>          interrupt-names:
>            items:
> -            - const: hs_phy_irq
> +            - const: pwr_event
> +            - const: qusb2_phy
>              - const: ss_phy_irq
>  
>    - if:
> @@ -422,37 +400,21 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,ipq5018-dwc3
> -              - qcom,ipq5332-dwc3
> +              - qcom,msm8996-dwc3
> +              - qcom,qcs404-dwc3
>                - qcom,sdm660-dwc3
> -    then:
> -      properties:
> -        interrupts:
> -          minItems: 1
> -          maxItems: 2
> -        interrupt-names:
> -          minItems: 1
> -          items:
> -            - const: hs_phy_irq
> -            - const: ss_phy_irq
> -
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,sc7280-dwc3
> +              - qcom,sm6115-dwc3
> +              - qcom,sm6125-dwc3
>      then:
>        properties:
>          interrupts:
>            minItems: 3
>            maxItems: 4
>          interrupt-names:
> -          minItems: 3
>            items:
> +            - const: pwr_event
>              - const: hs_phy_irq
> -            - const: dp_hs_phy_irq
> -            - const: dm_hs_phy_irq
> +            - const: qusb2_phy

Why qusb2_phy is after hs_phy_irq? In the earlier if:then: it is the
second one.


>              - const: ss_phy_irq
>  
>    - if:
> @@ -460,11 +422,13 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,ipq5332-dwc3
>                - qcom,sc8280xp-dwc3
>                - qcom,x1e80100-dwc3
>      then:
>        properties:
>          interrupts:
> +          minItems: 3

Hm, why? This commit is unmanageable. Your commit msg is already huge
but still does not explain this. Are you sure you are fixing only one
logical thing per patch? Does not look like.

Best regards,
Krzysztof


