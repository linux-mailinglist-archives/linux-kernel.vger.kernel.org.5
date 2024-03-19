Return-Path: <linux-kernel+bounces-107611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA7087FF20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3FDB2547F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A681733;
	Tue, 19 Mar 2024 13:53:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB481723;
	Tue, 19 Mar 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856420; cv=none; b=E37sCljsOah45leqNovwdv6x+8dpgCkbz/nc5ISD47HlocfA4esK4sURQ2iYt0OH3fEbQZeubCnSOVYFcjZ7mw6GKZf0d3XuoKcPdFMVlTJqR/cUa3saVKfyjUX9CcRLg0xtRDALYKAkSe7yxhVVUM56hJcVzBKxKC0g7ZFnG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856420; c=relaxed/simple;
	bh=l1tlpDCQ2bSEpQZ9E3s9/g28w3A6nWny3ZLXbyWSsDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVW/jqh8yCp3N6/zeAq+ViFeDeB6lziP/yAcVEz8QwKlQ35zOSJgGXbPVgSHcpx2LCfLdCoIXjkTS9XDEKjl9o8ulpj4IxQOefUlTqIgM/ghuhYtC55LrCw88VWrnTOz70sFEGsn2C5AYT5IZ1aK9/XKQx8pj1I7ycoWcSJ0VOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F600106F;
	Tue, 19 Mar 2024 06:54:12 -0700 (PDT)
Received: from [10.57.52.192] (unknown [10.57.52.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123473F762;
	Tue, 19 Mar 2024 06:53:34 -0700 (PDT)
Message-ID: <9b2a681e-1191-4cf7-8da7-14aa2c1fa455@arm.com>
Date: Tue, 19 Mar 2024 13:53:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iommu: arm,smmu-v3: Add SC8280XP
 compatible
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>
References: <20231219-topic-8280_smmuv3-v2-0-c67bd3226687@linaro.org>
 <20231219-topic-8280_smmuv3-v2-1-c67bd3226687@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231219-topic-8280_smmuv3-v2-1-c67bd3226687@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-09 1:31 pm, Konrad Dybcio wrote:
> The smmu-v3 binding currently doesn't differentiate the SoCs it's
> implemented on. This is a poor design choice that may bite in the future,
> should any quirks surface.

That doesn't seem entirely fair to say - the vast majority of bindings 
don't have separate compatibles for every known integration of the same 
implementation in different SoCs. And in this case we don't have 
per-implementation compatibles for quirks and errata because the 
implementation is architecturally discoverable from the SMMU_IIDR register.

We have the whole mess for QCom SMMUv2 because the effective 
*implementation* is a mix of hardware and hypervisor, whose behaviour 
does seem to vary on almost a per-SoC basis. I'm not at all keen to 
start repeating that here without very good reason, and that of 
"documenting" a device which we typically expect to not even be 
accessible isn't really convincing me...

Thanks,
Robin.

> 
> Add a compatible for the instance found on Qualcomm SC8280XP.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index 75fcf4cb52d9..f284f7b0c1d8 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -20,7 +20,11 @@ properties:
>     $nodename:
>       pattern: "^iommu@[0-9a-f]*"
>     compatible:
> -    const: arm,smmu-v3
> +    oneOf:
> +      - items:
> +          - const: qcom,sc8280xp-smmu-v3
> +          - const: arm,smmu-v3
> +      - const: arm,smmu-v3
>   
>     reg:
>       maxItems: 1
> 

