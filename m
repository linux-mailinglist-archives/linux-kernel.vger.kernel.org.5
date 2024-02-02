Return-Path: <linux-kernel+bounces-49858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E475847094
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12C11C26D87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CFF1FAE;
	Fri,  2 Feb 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecRXyb8E"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCC185A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877890; cv=none; b=Retp5VTWqDPhev1hYs23IFM7N9LL2wNF1JGsNZhLLtWOEmG+b9W57tFdXiN0dDek0/uEDGOuP1LKUsdbcFlwGlhYBf2OoC1tumCaiU4IFE7bWO6HnZPAAHAIA/bI5CT8Y7LsoqrFadH716TNgnwZb/W+Bqh6g/9gLyqqTxPdr3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877890; c=relaxed/simple;
	bh=PpBzCGG1kfdSEKS6ZVE0DfABNyS1LEwesMsku1vqKHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT8141upoR4NIaX0TAlKTvdUmLuj58a54+NvnypWKk5Rlsv3w3GzuY4c1Vk6vLhc0YJx1rPCkfvxzk8NT0racxoqsBa2rLn92152NvTgW/aET+wSlEFJaW9ZzQNg6AkewJ9hipddBvX6NC1KqGu5SE71lNY+Nm3C9F28VzRa4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecRXyb8E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93edfa76dso17001575ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706877889; x=1707482689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6uHxgJc6SIrgskffi3vozHz8JcpTZE+U0V1Oe4eJ8Bk=;
        b=ecRXyb8E0LjsU7i9/UG5OcDpIGMYTjpMA83vmVuTsPhjm4eq5SYbMOnm8XnXrjdDu6
         yAtW+gApEJVdUXXGJ1SI2qjXJQTopQDDqNXir79SwlhstSQEE63LnBFzPJtQREr4H5TZ
         JmbPBPlZZKPGiWN0NXe7Jsiu61eQQaIGpsLTHb2h9YxW5H20dfiuUC2D286Y2oqBYFpW
         Mr4FINFqTcdEeQW2aTMtbY+MzsBnNGltJkuQmXa9Mtg7cu9Hc155HN1jf+Woro2TCU0d
         jGSJ0on/wNGoKQl702bb2RSwmk/FQ8SI7NWnEa7axCCq1YZ+Pnyx+nLy44IYdXeWdJk8
         Gz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877889; x=1707482689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uHxgJc6SIrgskffi3vozHz8JcpTZE+U0V1Oe4eJ8Bk=;
        b=Z7VS5uQobmdkaEXTWBPj1/gEDiY75YClXQTCAWgK1MRWspdmZ5IEix98BVlJJADbnM
         hxS8UB2tCT/4hPTDeIibs9zTDQ3Y7RTdzGHTkNRZbTikjBF2Gakfg6Crgzgzd0piuTjr
         M80xhJQpjZLqZjeGDYbRNK58f4bkgYvE8zdHK/sWZVuRzAqaujpShJ+5YL2tz6uFZjlW
         j4lfX0/az6UPDqAw3/PvscXspfol/8EsKX2x0/vSgMr7dOzB50PC3b5D9A7ohgvH5xxW
         wYntMkRR5lZ4JMfi3dwHFxuwlUHIn40LPL0jQbfxhsTnGi9lbJElgTzA1+4UpyUa6ARt
         vJ6Q==
X-Gm-Message-State: AOJu0YzjJrWeqfYp3tGIoeGJYWMR3QJVcSSiuKvb5/5s3QqEqbnLYYel
	hNxT10pZoNYGPrb4sWuiHV7uJq8x3L9Wk6TN5jhk14m3y2uZ6ezBlHUfPeiU/A==
X-Google-Smtp-Source: AGHT+IH1pBIPnV4+Kw7l0S2rRr96oqEx/hAT/W7h4rSfgtu6ZverhYAVJudCiBYv3w47WdCdnYCA5A==
X-Received: by 2002:a17:902:7d85:b0:1d9:21bc:c607 with SMTP id a5-20020a1709027d8500b001d921bcc607mr4825111plm.60.1706877888773;
        Fri, 02 Feb 2024 04:44:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUFWHhEo/HupTFPZosTA5Leq5aQb3CTr4YUIIlNYt5Zmj5LOJxkReBu0YLZkFkZK06LBpvBp4n7sUY6oYEWHq8EfSHOV8AO7L1Gelz7C1cCRJUNMmxosDe/90NuMbCaPH7izSpTAEEbux0hAUN63dABuenN0hV7k8Xi+/k6W/NN0tB4yq3d5qGkBMfxaevPDwXya9MftMv0/DxGGzbtkczUz9e4K66PfcukM0k6echRwsH2NmnWwqhWKDufLEc2FsbpqXimCR8YE5BDRCR55wKA1y9moEIFJ+xpHuSBYas9hHq2b+9tE9ADzDpq
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902f24a00b001d9834f2946sm42190plc.46.2024.02.02.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:44:48 -0800 (PST)
Date: Fri, 2 Feb 2024 18:14:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <20240202124444.GG8020@thinkpad>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>

On Mon, Jan 29, 2024 at 01:10:27PM +0200, Abel Vesa wrote:
> Add the compatible and the driver data for X1E80100.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 10f2d0bb86be..2a6000e457bc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
>  	{ }
>  };
>  
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

