Return-Path: <linux-kernel+bounces-138449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FD89F16F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D8A286147
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70E15B0F3;
	Wed, 10 Apr 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGi2OweF"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03815B0F2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749833; cv=none; b=dj9YNot9tQbPoGj60vlycw/qjyK3rvR2OppXShuGUDHT54hfUNw6Ixsfpohe3DF9OeIwKgs6aeUNRQ1h1xtX8/B01LBtJ6miVjWzuChQFGwi2MEzp0BHI1IebuPfFOCNa70queDWRx3xCFJDovG7uUDFz7amzC7KmqFQJ50kkHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749833; c=relaxed/simple;
	bh=Bk/2GDxBgBKZaokHcOMTz49eyI+1QVoNozIXUpW4/VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tY715hOK7WodU6WdUZzq8uIF5h7awL5ihqmCP5Yzxby9CuQlaoxKEeLNZ8H4OKMFSZKTamzIHKQbUkN44StHGZLRXoSaNicrFC+J1zWinB7scaai+k1AUJCDwOL5kjd2N88VoaNoq7tjfgVMNfcPac2NQBWsbQmXAcJ4P1miJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lGi2OweF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso36172251fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712749829; x=1713354629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AHVovJjaRrYuJwPpCH1ehDBd4Vwot0WGnmrkIqnd/o=;
        b=lGi2OweF2dH7yt9e+SHcm31mGPkw22hWHWqjb0ZP4vd39Xj1A+ESeos95h81KSt+MD
         MoxiSE7U0Jg7cuabG86qScKHA8Ust52gDji2mM3xeGh8sMYwLXKjQhKzmvF67vm9yAbz
         Zlv98QRCI2scWtJmU85qxvbRinFs3JuahNy9Q72BOtuwoy5VpRF4XjifD+pfAY2gf2Bz
         ebWD8bAbli1P0IQtgHKON6q/ZUVDDSOVPkQZ1MncXVGZCkQhLLOJEBab3/vimT+OTwgc
         jGF3O7uuLsrgBA15HBOWAGik8yCedfIsinmFyFTtSz7qvCmRo5frHRY40xZfNwIQmceC
         RROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712749829; x=1713354629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AHVovJjaRrYuJwPpCH1ehDBd4Vwot0WGnmrkIqnd/o=;
        b=U82XJfwHkVb5lEtlMOnYP954uvEAkJGmXNZg5TAzXUYhRJDtYzFE4hkzfMrpkJteAP
         T/cseqzFrgpAEViri9YNikN54LEBuuT0k0mSvItYC3AzbgtEBNK9VwskkgTO/Ag4aUzd
         0bVLcswyz7Bj5Yunu3wvlkAGS8ULyEEO3EyUcppUhctukFPsZ4ZhZELONQVMhBfGhl+Z
         pYP01JR0WxwiAZxa0bdSOorAa/mS2K2PHq6gCALLfsW1Vlxc1QPHuNT0OXW/zWkLDj4x
         C1wNS7q9MJEVZ2NRJ334QfjwIyhx7SbF9WVYnkii8173V5wHLIkp7MFN9m8D+KLx4hmo
         w+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIX976ZXr5ZbSIyqYN3NobAOu6iVIeMzrufuwinN2mH1f9UzxpVzgt3l+cvneQyEt50JpIkqK58FM6z3GZHd30g2oT15TLCbLojmnh
X-Gm-Message-State: AOJu0YxOh0EKmhrq91Os178lRD2zgu4UDPK3vgulbY+NItyrGR50BmXR
	1tPIJt6CFIt3QrNH68cZSB8j6kKx61hKwLuto/kt0x6R4gbHmO/2dD6bHTAaw46A2O98pbXZ5Wo
	syW0=
X-Google-Smtp-Source: AGHT+IEvZt4fpCQvn84d60RRfmCkGOF/8hWNSU6M08yMMsd4ImingIW/9UKEH3GBojO8JqkAxMB5tA==
X-Received: by 2002:a2e:904e:0:b0:2d8:4af7:1235 with SMTP id n14-20020a2e904e000000b002d84af71235mr1342410ljg.44.1712749829600;
        Wed, 10 Apr 2024 04:50:29 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u34-20020a05651c142200b002d86678e0b0sm1741662lje.109.2024.04.10.04.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 04:50:29 -0700 (PDT)
Message-ID: <dca1e891-cfde-4e95-864e-419934d385e5@linaro.org>
Date: Wed, 10 Apr 2024 13:50:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] PCI: qcom: Add support for IPQ9574
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-5-mr.nuke.me@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240409190833.3485824-5-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 21:08, Alexandru Gagniuc wrote:
> Add support for the PCIe on IPQ9574. The main difference from ipq6018
> is that the "iface" clock is not necessarry. Add a special case in
> qcom_pcie_get_resources_2_9_0() to handle this.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 14772edcf0d3..10560d6d6336 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>   	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>   	struct dw_pcie *pci = pcie->pci;
>   	struct device *dev = pci->dev;
> -	int ret;
> +	int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
>   
> -	res->clks[0].id = "iface";
> +	res->clks[0].id = "rchng";
>   	res->clks[1].id = "axi_m";
>   	res->clks[2].id = "axi_s";
>   	res->clks[3].id = "axi_bridge";
> -	res->clks[4].id = "rchng";
>   
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +	if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
> +		res->clks[4].id = "iface";
> +		num_clks++;

Or use devm_clk_bulk_get_optional and rely on the bindings to sanity-check.

Mani, thoughts?

Konrad

