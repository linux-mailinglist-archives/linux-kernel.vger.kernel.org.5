Return-Path: <linux-kernel+bounces-160975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C88B4552
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806541F223C7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D447F57;
	Sat, 27 Apr 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X14pPsHG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8545C18
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209795; cv=none; b=hXilaf95XTSxvgS29g072+9tNGmxA/Bja+vTZerWpc7LKq8YqKgj+vYMaHljClSPbb1DqZdp8h/w0NzEcaIqkfvpZ4QXISUbfk9IiZ2wzyMNWCde9iU+buk2BlRMvBjQ8QEF6WF1uRD69WTmn1ElItXNEWnSfSZ7Sl41dhaG2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209795; c=relaxed/simple;
	bh=ul1FhTW7c8B0pI49fHW4jc0yMuX5lzfvSpesH5uhEZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBbvTSNdCk5SKSUB0QL8XLtwKac5BwCtCj0xDRvP5a/RTZCOdCEQlJZiSqyDswC5cmjBQZvb5sYk6zZ+Q8aBDTJDQd+zIq+Gz2HXROme9Cv6jPTQYogkC8SGJSI39HNqhkSFnffn+2K+AYHV92Fxrg5ehp4OaUuI4F1Mkmc3zn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X14pPsHG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2b137d666so22897095ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714209793; x=1714814593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1uIcEMzayP/6fZPxv4DuexUPxwxg9JGcxelfjHeE1sI=;
        b=X14pPsHG0pDxTwWKQKhAHP6w7GCmbCjjfR+0wFvC0SQjWEucAJA1NetyomNihohWuA
         7p6Ld0/6QUuyXUIcEgMFUTXBbinIcF3kye6sxN5Ip0EFfCtVqEHSh95ID5+XyfMV+1Wv
         POrgcBSyq9yZs7p+ia8CdKFeDA+vfEm9n7X5xn1HLcx0QyCfi6SgNZmL2i9jjDy/0Kr2
         ekN39BpK2yE/JTWwL69kAax3E+Iq6k7/bARe/ucpsa+iqJR9KzL4k2JqQUlbChk6JFh1
         DvGP4JRTjjA/x4ZXnbJimokXISqXpJZEv0Mz5KjxmcKsmGyTgxniDUn3hlLtnI/2+eDa
         aSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714209793; x=1714814593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uIcEMzayP/6fZPxv4DuexUPxwxg9JGcxelfjHeE1sI=;
        b=CLfPoad9HrPyV+JF61OL6zrxemxpyYJeqxyfhz2dZmHGMU/UaN5s09YxIH8qTuSdwZ
         Gsk129AKIDD5nEOW0iNDQTNmCkJD0qdQeteHRGoBDJUuk+cKezTgld041KLEZS4MLzY/
         79ht6o/o+9vtq/F7WrgrVWCY+jMC40kKHczqn8RDecPFtpKuByuBlWovyXuJ8SNBbFIF
         asRpEoaXUkuFUb4VIzPrvO1NoDT5fTRxz8MCq1y/CKsWtYQbZ8RA+WSfhRl0fQ85uqop
         wx3pHTq2CxISlSNj0TIrPocC3orwQjD5X+eJpeN/zFKhELjKJY7zJe3o4Y40tGPE2f1d
         v8cA==
X-Forwarded-Encrypted: i=1; AJvYcCUyzAcVsCnc+vVopkyc1l8p6IwiT8P5ElwvccZKOT7wdjC4HFJX+9IfBTSMaVcyXevCsuUmFW68h3xpx6B6jKuwISKfJ3IL6tOtlt9h
X-Gm-Message-State: AOJu0Yzs0ltIm/fij5batnOJQ2PpF2MEGMZvcijn4ul5ZHjAMfWBWyWF
	ZkGzRa5BuzhTz5zxhxphNS11Ka02vXAk7E0dG4x/m9Ycfo5m05PhfaVQngZj7g==
X-Google-Smtp-Source: AGHT+IHI9b4GXVPRNRKKViZzgQgyiBNt6NE3ezIewkxreKd8/BhI/Anp1b4JbkcwgsxxnXj43VBHCg==
X-Received: by 2002:a17:903:2445:b0:1eb:538e:6c6e with SMTP id l5-20020a170903244500b001eb538e6c6emr1443898pls.33.1714209793362;
        Sat, 27 Apr 2024 02:23:13 -0700 (PDT)
Received: from thinkpad ([117.213.97.210])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b001e668c1060bsm16712930plh.122.2024.04.27.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:23:12 -0700 (PDT)
Date: Sat, 27 Apr 2024 14:53:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v3 02/11] PCI: imx6: Fix i.MX8MP PCIe EP can not trigger
 MSI
Message-ID: <20240427092303.GG1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-2-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-2-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:38AM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Fix i.MX8MP PCIe EP can't trigger MSI issue.
> There is one 64Kbytes minimal requirement on i.MX8M PCIe outbound
> region configuration.
> 
> EP uses Bar0 to set the outboud region to configure the MSI setting.

I don't understand this statement. How EP can use BAR0 for MSI? MSIs are
triggered using outbound window memory while BARs are mapped as inbound.

- Mani

> Set the page_size to "epc_features->align" to meet the requirement,
> let the MSI can be triggered successfully.
> 
> Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e43eda6b33ca7..6c4d25b92225e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
>  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>  
> +	ep->page_size = imx6_pcie->drvdata->epc_features->align;
> +
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize endpoint\n");
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

