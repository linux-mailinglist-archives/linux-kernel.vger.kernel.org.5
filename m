Return-Path: <linux-kernel+bounces-27560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB7982F230
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E75F285FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE3C1C6A5;
	Tue, 16 Jan 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHPAigRX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AF1C698
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d5f37cf8c8so3064945ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705421629; x=1706026429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEOjtDtYVBOB1Sc9meCvWqA+RQADIvF7Dvcqsf5Mj80=;
        b=fHPAigRXvq91Yyo5oDw9gZOuwd0jPyNknew+iqoUxkl53/bSeEDTYttjIl/MGkN4rn
         yLUnLso6T4NJGLntV3edsa8VmZXIH6QCEruAuGc65WR/r3kfAbqOoMQDZVPPWc7ZGtMa
         7OH+O3vyk2c0T/is7HFggungIuQksF26rPeQEgXN//2Av9ES4jT2ivCdUDbZp0imSEio
         Jlcte8Rr4Q2DYsHB+U/sdzQm9JQ9ejQ93l1KvTW1hU3an46wmgxzsrPyNf9pXTIfUJsZ
         XsSaDSGu09AeE4+plNlrTm79VVjrx2bR0ZGsSgLK4QPV8JQ2eJot/1ZKbLRin+FVVrKI
         X41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421629; x=1706026429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEOjtDtYVBOB1Sc9meCvWqA+RQADIvF7Dvcqsf5Mj80=;
        b=bg1QBxXd+4jmlA7z2SCRvw4PPM6EPR0bQ/LLlLAtfSAtTgR1EU3/OGoVZ7Ik8t39D+
         80ZyV5DubtJQEBRZTtisg2e0Zvv78gt2sfDPCurCInQ/FVuRQjH/UjrvBVNJLOluv4Ax
         cJ23272crAJVI9o+4DzmY91SNzp47a8HTClOSDspqRzCR8t1uUlLFtjPMxFULLi61N88
         pd2rZgstKALgyolJCpTN9+YqF8ujsbwdoMcC2kRfsiUNyV8ohwmc6tlOtQtcRWSVA2Dg
         O9qcPALqWlxuMFi1kOIMvbGbVrDODcMSMQ338yRB17IS7z2UZAya1Vly0mrw8yxCZgME
         41hw==
X-Gm-Message-State: AOJu0YyCMoSPaV9VWAaNp5wi3Yjo15zpA0wBxsZ+n5FVBMwnhImLoZyZ
	i3LaSLkYPknOryoig1maO3vpKCW9DrNVwQ==
X-Google-Smtp-Source: AGHT+IGqo6AFxOY/lJm+DyF6xmEXUShCosfyfZqWOZaC24dFB/lBB7V8xo1CdgEHQp2/QnY9hCKm0A==
X-Received: by 2002:a17:90a:ad8b:b0:28d:b72f:a63b with SMTP id s11-20020a17090aad8b00b0028db72fa63bmr3758818pjq.69.1705421629666;
        Tue, 16 Jan 2024 08:13:49 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800::5ced])
        by smtp.gmail.com with ESMTPSA id sd5-20020a17090b514500b0028d573397dcsm14451049pjb.42.2024.01.16.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:13:49 -0800 (PST)
Date: Tue, 16 Jan 2024 09:13:46 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: do not override firmware-name
 $ref
Message-ID: <ZaarOuqx3jzftWU3@p14s>
References: <20240115182031.1610088-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115182031.1610088-1-krzysztof.kozlowski@linaro.org>

On Mon, Jan 15, 2024 at 07:20:31PM +0100, Krzysztof Kozlowski wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml     | 4 ++--

For the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  .../devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml       | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml       | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml      | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml       | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml       | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml       | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml       | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml       | 2 +-
>  .../devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml        | 2 +-
>  11 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 09102dda4942..507f98f73d23 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -47,7 +47,7 @@ properties:
>      maxItems: 1
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description:
>        If present, name (or relative path) of the file within the
>        firmware search path containing the firmware image used when
> @@ -115,7 +115,7 @@ patternProperties:
>          maxItems: 1
>  
>        firmware-name:
> -        $ref: /schemas/types.yaml#/definitions/string
> +        maxItems: 1
>          description:
>            If present, name (or relative path) of the file within the
>            firmware search path containing the firmware image used when
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
> index eb868a7ff4cd..ad45fd00ae34 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
> @@ -46,7 +46,7 @@ properties:
>      description: Reference to the reserved-memory for the Hexagon core
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description: Firmware name for the Hexagon core
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
> index c054b84fdcd5..66b455d0a8e3 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
> @@ -45,7 +45,7 @@ properties:
>    smd-edge: false
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description: Firmware name for the Hexagon core
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> index b6bd33438584..9381c7022ff4 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> @@ -80,7 +80,7 @@ properties:
>      description: Reference to the reserved-memory for the Hexagon core
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description:
>        The name of the firmware which should be loaded for this remote
>        processor.
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
> index 4744a37b2b5d..45ee9fbe0966 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
> @@ -42,7 +42,7 @@ properties:
>      description: Reference to the reserved-memory for the Hexagon core
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description: Firmware name for the Hexagon core
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> index 028287235912..758adb06c8dd 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> @@ -47,7 +47,7 @@ properties:
>    smd-edge: false
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description: Firmware name for the Hexagon core
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
> index f7e40fb166da..c1a3cc308bdb 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
> @@ -42,7 +42,7 @@ properties:
>    smd-edge: false
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description: Firmware name for the Hexagon core
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> index 3e4a03eb4532..7286b2baa19f 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> @@ -36,7 +36,7 @@ properties:
>      description: Reference to the reserved-memory for the Hexagon core
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description: Firmware name for the Hexagon core
>  
>    smd-edge: false
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> index 238c6e5e67c5..d67386c50fa4 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> @@ -46,7 +46,7 @@ properties:
>    smd-edge: false
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description: Firmware name for the Hexagon core
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> index 53cea8e53a31..4b9fb74fb9e9 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> @@ -47,7 +47,7 @@ properties:
>      description: Reference to the reserved-memory for the Hexagon core
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description: Firmware name for the Hexagon core
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> index 45eb42bd3c2c..8e033b22d28c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> @@ -51,7 +51,7 @@ properties:
>        - const: stop-ack
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description:
>        Relative firmware image path for the WCNSS core. Defaults to
>        "wcnss.mdt".
> -- 
> 2.34.1
> 

