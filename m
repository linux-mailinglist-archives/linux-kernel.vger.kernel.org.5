Return-Path: <linux-kernel+bounces-118533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9F88BC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5829F2E236F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1D134407;
	Tue, 26 Mar 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Idb6tQtO"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F597133404
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441608; cv=none; b=gXeKhAYi6Ms1EQ4J0XxrY+N1JEu/gHBaHVMo24H6MVM6ck0N0Z+rmzhBjrpePsuqR1yQJh98x1+NSmqpMoERYUDsFYhGrBXaxbD9LBXKQ59FKYt5tlB6blAkLvJcLCYqF8S1LXyQwewJNX/0mNsKudHMtnTgAH1+kDQN0yKRTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441608; c=relaxed/simple;
	bh=U5m+8FX647w4/K2HXpnx2cvWPRgEHrgbpctLLo957Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzOG8oBbGbUCVphItPAU8jJrMR6Zh3UMfu30dU0UNBNULNLLNdFS82WahCZAK9Gbmt/+UqbKu+D6StuKWFcYL7rBfLEkbFBGVyZWJLAMDT+UpKm9N9wuEoAKKeRFho6Lg4Ds1Q2+laWXti02B3nWFBIn0igIyexdukxHrZkumzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Idb6tQtO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so3637878b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711441606; x=1712046406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8IntzFmsPrn2+uoKnC+EJNUNsN+NtjwIxBR/+rWXPmU=;
        b=Idb6tQtOZWceEwn3EChP7/g+o4u7prQN9I0Czp2LJ+WGjE2WeYa0aRquQfVERZAN2Z
         XOSn3yDI9FU8HUI8Iu9AiX0wLvAvdmSkmm0pTFNhLkTlFynr3fBEJJsz1p7R8l9OQ5XA
         8AHKlKVcHjHjmxF954NUj0HCdD3TYCouwTG3WuNtrsEaIT49KYjyUbRz89llwfoSdTSx
         +jkKrwYdceHhEox1Yz2UCph/tdAXG1gto8Ll2FiMs0CE7wuV0Kb1DhVT2FXKOds7Z6Tt
         hc0wEBFt5f2+lzi5Uvsdm/dILHW2kWUgS+1O3+/yOzxEOT152iLmNfaD6GRgZFPK0oGO
         PYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441606; x=1712046406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IntzFmsPrn2+uoKnC+EJNUNsN+NtjwIxBR/+rWXPmU=;
        b=Zp0yFuVHSm/I4xkmNe0MfXdvCkIcB9wNiYiPJHwc9pKP8uFRzcnNs6yA1tpDlreiip
         ApsDIs+l3mPEQl7IT+Gg649t9hpgTtCUFnNJtVt3yGZ6etNpVFzb3ucguyCi+CZdLoKk
         jMOyO4oznRk/Gg0oXkcPCFF3rU5hlZpXpKZK2WWjkVw1ytq4ZJh6H3Bl/zQQKx1uuCvB
         myZvK42j035wz6fCaaI0W3QgexCvYH8jeSSTBp94f/ygkObfXyr1MTWDsAeXRJIX6m+L
         33oVWkWUrwPyiQSSomR0aBzgNPSMXEVDZHum7YUQ6h169aw+3XJVxuiaQGxdEWsVU+MG
         smLg==
X-Forwarded-Encrypted: i=1; AJvYcCUoviwTVi1KhfTaqvSEUOWXeCByvxeUKU9Vjqh2n2aA/u7ufOYhITXxgt+Njie0A8QShU/XkLABL7VKebZDgtkDSX4vO3zpsrz1KEXs
X-Gm-Message-State: AOJu0Yz7AK2yw6Hx1YZlL6DnnWTHUzitx663y7Iut1bIm+ZKWTIs8B1y
	R9/Jx5+J1DW7EbNzU48p2I4DNNlHE7BjZbE4WMXU11NNMdJ7lIJ/WZgHFpv7cw==
X-Google-Smtp-Source: AGHT+IG2cCQjr2tiQ1gTo/RBtFnfWmQaUILNHd/nY6TpsRWeYwsnWDE7alZ4NDHWcHcOV3MNjKksBg==
X-Received: by 2002:a05:6a20:4da7:b0:1a3:dc61:d457 with SMTP id gj39-20020a056a204da700b001a3dc61d457mr164678pzb.3.1711441605602;
        Tue, 26 Mar 2024 01:26:45 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001e0a28f61d0sm6119095plb.70.2024.03.26.01.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:26:45 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:56:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 05/11] PCI: epf-{mhi/test}: Move DMA initialization to
 EPC init callback
Message-ID: <20240326082636.GG9565@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>
 <Zf2tXgKo-gc3qy1D@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf2tXgKo-gc3qy1D@ryzen>

On Fri, Mar 22, 2024 at 05:10:06PM +0100, Niklas Cassel wrote:
> On Thu, Mar 14, 2024 at 08:53:44PM +0530, Manivannan Sadhasivam wrote:
> > To maintain uniformity across EPF drivers, let's move the DMA
> > initialization to EPC init callback. This will also allow us to deinit DMA
> > during PERST# assert in the further commits.
> > 
> > For EPC drivers without PERST#, DMA deinit will only happen during driver
> > unbind.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> 
> For the record, I was debugging a problem related to EPF DMA recently
> and was dumping the DMA mask for the struct device of the epf driver.
> I was a bit confused to see it as 32-bits, even though the EPC driver
> has it set to 64-bits.
> 
> The current code works, because e.g., pci_epf_test_write(), etc,
> does:
> struct device *dma_dev = epf->epc->dev.parent;
> dma_map_single(dma_dev, ...);
> 
> but it also means that all EPF drivers will do this uglyness.
> 

This ugliness is required as long as the dmaengine is associated only with the
EPC.

> 
> 
> However, if a EPF driver does e.g.
> dma_alloc_coherent(), and sends in the struct *device for the EPF,
> which is the most logical thing to do IMO, it will use the wrong DMA
> mask.
> 
> Perhaps EPF or EPC code should make sure that the struct *device
> for the EPF will get the same DMA mask as epf->epc->dev.parent,
> so that EPF driver developer can use the struct *epf when calling
> e.g. dma_alloc_coherent().
> 

Makes sense. I think it can be done during bind() in the EPC core. Feel free to
submit a patch if you like, otherwise I'll keep it in my todo list.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

