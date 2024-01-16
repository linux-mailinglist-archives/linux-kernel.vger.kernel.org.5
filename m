Return-Path: <linux-kernel+bounces-27360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A9482EEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96EA2852FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE81B979;
	Tue, 16 Jan 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DLMEjBIB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECBB1B950;
	Tue, 16 Jan 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705406780;
	bh=Fxu/czZW/jT7hNLv/XBIT3iwaM6qWGV9i9J3Ejpkuuw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DLMEjBIB1ZKfVU8ldqQhumVvxKZEhJKMevjUnSiDru3olRWzI1CQqvIQPO3AErBqn
	 3i/FuH/zPq1opBuGhi7j+yoP6I9gW18FTNgnZxEygkzsMCd7F3xMD/nx7cgd5ZkZVr
	 OvSR3XnjeEbzvvNYs8klVfaOkg+nR1j2T41pJez8bRm4D9Qex5oC9VLSg1/drGPsBW
	 mtbtEwMuqEjNIseUQRp1Cu7pZOCEg9h4hXJNmJRZtoQa7y0YWyyLWg88eqcZy1gIwI
	 fZT7UA0+vhAUia6DDkT2LXWIZCi2hzmGn6hB5zorqzkic4ykCHf+Ct81PM1pyl4lUj
	 j4CuUKEQySUXA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C5B3137802F2;
	Tue, 16 Jan 2024 12:06:19 +0000 (UTC)
Message-ID: <e0143649-f268-4c10-8bc2-89cdb6244a01@collabora.com>
Date: Tue, 16 Jan 2024 13:06:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: remoteproc: do not override firmware-name
 $ref
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tinghan Shen <tinghan.shen@mediatek.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20240115182031.1610088-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240115182031.1610088-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/01/24 19:20, Krzysztof Kozlowski ha scritto:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

.. a better commit description:

The devicetree schema core defines firmware-name as a string-array:
remove the override and narrow the number of expected file names to 1.

Besides,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml     | 4 ++--
>   .../devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml       | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml       | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml      | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml       | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml       | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml       | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml       | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml       | 2 +-
>   .../devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml        | 2 +-
>   11 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 09102dda4942..507f98f73d23 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -47,7 +47,7 @@ properties:
>       maxItems: 1
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description:
>         If present, name (or relative path) of the file within the
>         firmware search path containing the firmware image used when
> @@ -115,7 +115,7 @@ patternProperties:
>           maxItems: 1
>   
>         firmware-name:
> -        $ref: /schemas/types.yaml#/definitions/string
> +        maxItems: 1
>           description:
>             If present, name (or relative path) of the file within the
>             firmware search path containing the firmware image used when
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
> index eb868a7ff4cd..ad45fd00ae34 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
> @@ -46,7 +46,7 @@ properties:
>       description: Reference to the reserved-memory for the Hexagon core
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description: Firmware name for the Hexagon core
>   
>   required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
> index c054b84fdcd5..66b455d0a8e3 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
> @@ -45,7 +45,7 @@ properties:
>     smd-edge: false
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description: Firmware name for the Hexagon core
>   
>   required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> index b6bd33438584..9381c7022ff4 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> @@ -80,7 +80,7 @@ properties:
>       description: Reference to the reserved-memory for the Hexagon core
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description:
>         The name of the firmware which should be loaded for this remote
>         processor.
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
> index 4744a37b2b5d..45ee9fbe0966 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
> @@ -42,7 +42,7 @@ properties:
>       description: Reference to the reserved-memory for the Hexagon core
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description: Firmware name for the Hexagon core
>   
>   required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> index 028287235912..758adb06c8dd 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> @@ -47,7 +47,7 @@ properties:
>     smd-edge: false
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description: Firmware name for the Hexagon core
>   
>   required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
> index f7e40fb166da..c1a3cc308bdb 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
> @@ -42,7 +42,7 @@ properties:
>     smd-edge: false
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description: Firmware name for the Hexagon core
>   
>   required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> index 3e4a03eb4532..7286b2baa19f 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> @@ -36,7 +36,7 @@ properties:
>       description: Reference to the reserved-memory for the Hexagon core
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description: Firmware name for the Hexagon core
>   
>     smd-edge: false
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> index 238c6e5e67c5..d67386c50fa4 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> @@ -46,7 +46,7 @@ properties:
>     smd-edge: false
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description: Firmware name for the Hexagon core
>   
>   required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> index 53cea8e53a31..4b9fb74fb9e9 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> @@ -47,7 +47,7 @@ properties:
>       description: Reference to the reserved-memory for the Hexagon core
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description: Firmware name for the Hexagon core
>   
>   required:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> index 45eb42bd3c2c..8e033b22d28c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> @@ -51,7 +51,7 @@ properties:
>         - const: stop-ack
>   
>     firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>       description:
>         Relative firmware image path for the WCNSS core. Defaults to
>         "wcnss.mdt".




