Return-Path: <linux-kernel+bounces-18785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E1826307
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FE8282AC2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A608125A8;
	Sun,  7 Jan 2024 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UoXyuj5b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD4125A1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2045bedb806so924022fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704605712; x=1705210512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAQHK5ll+I9fqZVygsC2SG0aCFgjVutNBXAQTzwAdEM=;
        b=UoXyuj5bVLw675K0mpq1mL0ahXQdzWArxEUG8wScYVJE4KMH+qtwmukl89cKDEevV4
         evh7n94Cr7mVTeGRQUtbteVt+LbLeOA4UMztqmpB9IGhUSi4XlgIxHiHyryMU4lIl5ln
         46d//kNT+sTcDsu2P4ws5w0ejJfLq9uIMFMZjqQjjoAemke4DJ8TAgaTqBx1qSIOkYH6
         EYOShYhsDqsxk3dREsEI55Fwsb2HQZNcqh4LlnKhHarRDGus56cAnnOl3PIFs7oyTIgg
         Su1kdJjprHd2ZvhnHQKpjxx/U57PPgXgnY/WxwNTxKhXQlvZeBSOblQ03SLW2T7QDAYt
         2hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704605712; x=1705210512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAQHK5ll+I9fqZVygsC2SG0aCFgjVutNBXAQTzwAdEM=;
        b=LmkubEc0qv8ENr6Ab2mwf757pqb15pztHLPatpKPMo3fKMAzPdofSKHEIFZXGBnbgx
         73KIo41chMykvCPlsA7OtSzKqEhApRbKr8XB5Gue784345BHx9hmxJXKJK442TrtH1/A
         Z68QXjQce1lbwI1xHuvuKCPjWBzrk6xtjcbiwoHvQTD3PiA3VnNOzVidxfElEDESY/OZ
         Y/ts0gBz5D1jdnY+39JAi96Cs+GPqD1gbou3WK6wu9SluhFJyzScOFsAWrrN0YvG1g71
         CbsZmtWhbucgDfr/rgTkhAbGSdnSf8jliVsPAymUU+ajojwEd6GZd2CjI+iSLu+bGUlR
         Ihiw==
X-Gm-Message-State: AOJu0YxvK3illgJnFzlMxZ1mjIYGAVmoSN46O9dk5uOtCPdXwcP+1iA9
	ZDifg9eVUAtxHsiTcSlFRiTZPkAoCEQF
X-Google-Smtp-Source: AGHT+IHFYUUCHFOG1zw6MP5ODbboKC5GLnr9M5Rq8WdYlLjMIPfuPqb7MhRt2tmk/+KAt8X2v5uycA==
X-Received: by 2002:a05:6870:2247:b0:204:3d7e:791 with SMTP id j7-20020a056870224700b002043d7e0791mr2796524oaf.17.1704605712652;
        Sat, 06 Jan 2024 21:35:12 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id fb32-20020a056a002da000b006d9a48882f7sm3803258pfb.118.2024.01.06.21.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 21:35:12 -0800 (PST)
Date: Sun, 7 Jan 2024 11:05:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 10/16] dt-bindings: imx6q-pcie: restruct reg and
 reg-name
Message-ID: <20240107053505.GJ3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-11-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-11-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:21PM -0500, Frank Li wrote:
> snps,dw-pcie.yaml already have reg and reg-name information. Needn't
> duplciate here.
> 
> Add 'if' check for existed compatible string to restrict reg and reg-names.
> This prepare to add new compatible string with difference reg-names sets.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Change from v6 to v7
>     - add Krzysztof's review tag
>     Change from v5 to v6
>     - Add if check for existed compatible string
>     Change from v4 to v5
>     - add Rob's Acked
>     Change from v1 to v4:
>     - new patch at v4
> 
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 30 ++++++++++++-------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 81bbb8728f0f9..eeca6b7b540f9 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -30,16 +30,6 @@ properties:
>        - fsl,imx8mm-pcie
>        - fsl,imx8mp-pcie
>  
> -  reg:
> -    items:
> -      - description: Data Bus Interface (DBI) registers.
> -      - description: PCIe configuration space region.
> -
> -  reg-names:
> -    items:
> -      - const: dbi
> -      - const: config
> -
>    clocks:
>      minItems: 3
>      items:
> @@ -90,6 +80,26 @@ required:
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx6q-pcie
> +            - fsl,imx6sx-pcie
> +            - fsl,imx6qp-pcie
> +            - fsl,imx7d-pcie
> +            - fsl,imx8mq-pcie
> +            - fsl,imx8mm-pcie
> +            - fsl,imx8mp-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: config
> +
>    - if:
>        properties:
>          compatible:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

