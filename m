Return-Path: <linux-kernel+bounces-18770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CED8262CA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 04:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8B4282B57
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 03:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E71111A6;
	Sun,  7 Jan 2024 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zt3wDGPk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A91118E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-596175c0be0so615740eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 19:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704597314; x=1705202114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTSKHlVmMubC5kEPp4TOeWLAyI0E8w+0FU0X7VBdSK8=;
        b=Zt3wDGPkGtyQnLvEteR7tTQK0Qe3rz/z6nv2rXagrpQCxdpnWb9k6/h7hPBTtIQdPq
         NYWHuMhd1Hz12UzqCEyN+Teh4BlmY61M1rntq7VsNbj4xzF9aw1Nm4xoPDfm9qR0Ysk+
         4WqDaumFPaszr/hObcl/udDPzgYm4g7ePz26mdL/u+T+NsGyGs0IXk6EBTtyvwY29neS
         TlmUwdZmfwATzJx6niVlrYeDikjYns/bv/ZkZry/iJlAvfqoeeF248rvsnjBMvapu2xQ
         Acg4kQhs3uUcq2fm7nuWinMB6Y7f8cz4HT3evtkxgV8kysuufGmKRsW3HiuacnzIJ4oh
         Ak6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704597314; x=1705202114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTSKHlVmMubC5kEPp4TOeWLAyI0E8w+0FU0X7VBdSK8=;
        b=DGmpsuZ8n8TulFSZ04Pe0bExtZvSeMJ/fSiFpgrGECL4ambLxZ7XQD/s98fY1JOw8M
         bolv8vGSINqa86AFmXwpA4J5v8+u5GcMJzuHpODA+VTq4WmFBrfQNWaD8vG+BH0pPeqe
         Yj83ElgFoudRv5Czk2tCMPbwBse2VNzh/PvE9gIHv2+5c6wt5z9sg/ZYCKyHYurcY2Qt
         WI+iShWMR6PDBP8aCDeH5wiZYRRxHackX1LYhDstBCzrlwL0avkQS0AfXExMgDyc6WGT
         N1LeMx9nLrKnQrqPqcw0GL4skroIWSuaM16Sv9JMPD+vGckVlPc2+cKuDS90FqA55lC9
         SKUw==
X-Gm-Message-State: AOJu0Yw+coeiYvspZqyFFbGkNqoAdPtE8uWshrgl0aFTbSp92XLlWpQU
	nwCAjfuNrKbAHV7pa4AEPYdL921QtNSc
X-Google-Smtp-Source: AGHT+IGXkw6IM2mb9M0FTGw/gLZEPmq0TvilhKDKzYZWKSQNDUW24GLr3cdcVThMpJBJvlhJYBFffA==
X-Received: by 2002:a05:6358:7f1d:b0:175:b87:1a3c with SMTP id p29-20020a0563587f1d00b001750b871a3cmr1985625rwn.6.1704597314161;
        Sat, 06 Jan 2024 19:15:14 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001d4b685f82fsm3716601plo.165.2024.01.06.19.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 19:15:13 -0800 (PST)
Date: Sun, 7 Jan 2024 08:45:06 +0530
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
Subject: Re: [PATCH v7 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <20240107031506.GC3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227182727.1747435-5-Frank.Li@nxp.com>

On Wed, Dec 27, 2023 at 01:27:15PM -0500, Frank Li wrote:
> iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> proptery for iMX8MQ to indicate pci controller index.
> 

property

> This adjustment paves the way for eliminating the hardcoded check on the
> base register for acquiring the controller_id.
> 
> 	...
> 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> 		imx6_pcie->controller_id = 1;
> 	...
> 
> The controller_id is crucial and utilized for certain register bit
> positions. It must align precisely with the controller index in the SoC.
> An auto-incremented ID don't fit this case. The DTS or fuse configurations
> may deactivate specific PCI controllers.
> 

You cannot change the binding for the sake of driver. But you can make this
change in other way. See below...

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v5 to v6
>     - rework commit message to explain why need required and why auto increase
>     id not work
>     
>     Change from v4 to v5
>     - new patch at v5
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> index d91b639ae7ae7..8f39b4e6e8491 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> @@ -265,6 +265,17 @@ allOf:
>              - const: apps
>              - const: turnoff
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mq-pcie
> +              - fsl,imx8mq-pcie-ep

"linux,pci-domain" is a generic property. So you cannot make it required only
for certain SoCs. But you can make it so for all SoCs. This way, the drivers
can also rely on it.

Now, you should get rid of the commit message about driver internals:

> This adjustment paves the way for eliminating the hardcoded check on the
> base register for acquiring the controller_id.
> 
>       ...
>       if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>               imx6_pcie->controller_id = 1;
>       ...
> 
> The controller_id is crucial and utilized for certain register bit
> positions. It must align precisely with the controller index in the SoC.
> An auto-incremented ID don't fit this case. The DTS or fuse configurations
> may deactivate specific PCI controllers.
> 

- Mani

> +    then:
> +      required:
> +        - linux,pci-domain
> +
>  additionalProperties: true
>  
>  ...
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

