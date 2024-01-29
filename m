Return-Path: <linux-kernel+bounces-42526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF888402AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF13281448
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624456460;
	Mon, 29 Jan 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORXb7VAq"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023855E79
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523573; cv=none; b=RQ2Gj5eA4mj3uSPABorkENdA2rcFNDWqat4xBmVUA5uNwBSCN1t0psuyjC6e17ZxmuptOYogKgzQO85gZqK/WhGsHYnCTbl8pAK9sP9GyLJpypmD4luY71ZuV0UjimqJIsKLDl60EzZrkB7DTw+1reLINqxQnQ/B7KhgTC4yEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523573; c=relaxed/simple;
	bh=Gpbu/Vqjsjo5lZEZJYu+eYuOskPpCGtfKvA4wvphzPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k++PjynPx1YS70vou2YCudCoRbi40/XkraAonJdgOKWSnaaQW2vCzxGbE9uu0jXV2udsSWyZZU/G+oDsHKA4KB8iIH9TNQT4KogQzEFwWXJxJjiTBliI1iCMagf6qZMAcU0ms99vga0TinxpgxeNDA7B1fP5mK25wHEbeS0utVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORXb7VAq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a357cba4a32so138177566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706523569; x=1707128369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaNEubiPkUR1v6WmBXDxQwACvXQoF6eccoNMfB7JCy0=;
        b=ORXb7VAqMO58CaWQrlCdHE7PhE8KkiALj4my0eWRpoQuClbuG7xV+9sHOSHNNKqfQd
         xG5UtI6bj+9QADT2uRurkYVK8eyeTa3+lDdTOEBPhospOeXJ7q5XOOROgHo2MTa7a61h
         bG+vJT7oxlb6qFhHdN2KpW5Jp2tom7tjpe+AVM7MzgptI0Z7r5nxWtt97S0KKChESZIa
         VlKg/LG9nwn3nMz6GeE6diKvH7vebWBPll9KSeYCa9XaiIhNYSqU1HgU7JFeMPzpqTZs
         fOKsWLwjeVOUFBBpCgNMmM2pkcTi0WiKKyO8pXQf8mJrGO7Eo71mg7vQ6rHz06iOI5Wl
         vPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706523569; x=1707128369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaNEubiPkUR1v6WmBXDxQwACvXQoF6eccoNMfB7JCy0=;
        b=fTWaExAZXZ3XOwVxwyjnR8jkax3Gv3zzAOqdA88Q6kHvL57d8oo6MjyRKir9nnxcNX
         /3x3qH7ikDt/1CORgyjVxUX1lx8ReOteIn0R2P2XT8enF66om83cqvXQP7MscJ3Qtel8
         qu8VXrxFwIMBmOmh+C7xbfuFeJSPc8gjocZvcM94L1Xa8nGXR/PEJg+/UhajrdCbwZL2
         8ww0WL7lHwbGlW2fRqw25j2KsUU0xn6W3BTPmpF1xS1xcPfgaej1v2XWMFz/9Wr0rzVF
         iV0f8KkFMD+ysj29wY4cEX8ph04CEjhytrWFxVxKdvSGNp5wAyNAdmd1cJyvZaP2gjjV
         AmGg==
X-Gm-Message-State: AOJu0YwceItWHfGzWm7ZYgq0R0n7CuGyLHo4ZHd56pHWDuh0bNj10B9/
	ZDWDllXC6C7l4mQ5Az5wrdzAC7qKcfUndhD3QDTImtpZT6uLD31CWcj2uJKoOyA=
X-Google-Smtp-Source: AGHT+IHOpbbBxcB32NCeuQ+FyZ+IbV9GrDqH7RjkKLdpDBY2Ec7dPJkRniiLmQXxLbi+sNAtXj259A==
X-Received: by 2002:a17:906:4c56:b0:a35:9414:f46f with SMTP id d22-20020a1709064c5600b00a359414f46fmr2226981ejw.13.1706523569608;
        Mon, 29 Jan 2024 02:19:29 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id ty17-20020a170907c71100b00a35698fe5d4sm2045745ejc.180.2024.01.29.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:19:29 -0800 (PST)
Date: Mon, 29 Jan 2024 12:19:27 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <Zbd7r797kkN8yu6O@linaro.org>
References: <20240129-x1e80100-pci-v1-1-efdf758976e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-x1e80100-pci-v1-1-efdf758976e0@linaro.org>

On 24-01-29 11:37:00, Abel Vesa wrote:
> Add the compatible and the driver data for X1E80100.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Ignore this one. Need to add bindings documenting update patch.

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
> ---
> base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
> change-id: 20231201-x1e80100-pci-e3ad9158bb24
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

