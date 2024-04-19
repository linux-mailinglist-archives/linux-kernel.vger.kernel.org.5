Return-Path: <linux-kernel+bounces-151236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F998AAB8E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EF31F21F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7747BAFE;
	Fri, 19 Apr 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8Wgpovf"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70D42AAF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519536; cv=none; b=DBwAsGE/zqrJKSLk1HeJBrVkWx4I1DNa3Yac/2/rB7XAn0rjNUAizyCaiCWZhRamDY43RW54nPvxvUPbVSehWhGeseBgQ2y+dJnTGB5t8gSpuakqA6gsXdMKJDxZzD3ykOwWFgpoF2Wovq1QfV9RTuB295LbRctrs4ll57fC22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519536; c=relaxed/simple;
	bh=N2UXq2U4pdLZn+hJU/sN9WPbe0o2JK8fp42YrnciohQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F06jkLcA44KxltnyQtol6FkGpFBGQ5H0y/sBO4dNiOdYFpZhIlh3TnUR1mX7ooDXJ5ozzVV64I0D4gBI4kxStbTcsg/1szyQBBXF4fiZZe16kzIlgYn4MFZcHSCM8lDTTDqiSkskrnGCb8Krc2DAEaDJhlTLEPudQJ+g0VSmlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r8Wgpovf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0bec01232so15372295ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713519534; x=1714124334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vhyd8ERSjL+j/lnHLclAKIR9eCMnjtkAQONWEXxntro=;
        b=r8WgpovfxHO+9o4Vk2OdGmDFDpoVuLXB8t2kMlsau672uhITC5nhwpDfKnWMTJiEEO
         75XepK41XF3j5Ie76I2YX3wISpTEm8GycyBj770De4CLCTNW72N/qjDBHp2Nkm0GWp/+
         jjJUbW1XUt8eCxHA0XzDRKCAy9K14L0N78HbstXmpZQgJw6i0UnZvTgKtmd9ACwyWs+y
         nt1I5v/567QrYLs8XimgqcdJF+TXDrbJDByQprxlPm5KcT8uLBhfAnAdapkEXdoCLybU
         wmsAy0Pe8duichiU/LVlZVfvOKXwtGs/iBvYgronLw6pkit6zXvFLce8IGmzCCNSC/yw
         U54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713519534; x=1714124334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhyd8ERSjL+j/lnHLclAKIR9eCMnjtkAQONWEXxntro=;
        b=ntzYOB+0ZEq7sROOgWNtIEpHupqctF5ZDKKYd35tLBnxVsLwvW4+X/LRryQBQMYQRI
         zipdVC0yVhuzW+GV7eEnAbP0IE5KjRLTM8tI8FL+sKR/qOhskbmRCP7RY4ZgYRMDAZGi
         ylu0laIG6G5s+pmUtD5B/y5HLva2UY2HLiTUjHYOxXGxVpYqcli5/5Z9bECBS93gl30O
         RPZNccM9Np86KbpnZIrVRC3AD9KizTZSSjju7OYdbpqkHad2BUxFR5wD7KdxRAIEoZLg
         ogqTHyRrl9j4ePT/jSRjvyZGZJ3KgpB3K+WrHxYbqD2t/Q+pWTFYV5LYo68IgSpe9nau
         CMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAUbYJt2XE9Sh4d1FsOJCydxNEYv4ylW0uCqnxa8mKjPfZN9I6OEf1M+ZDJTQXF1P+GmB41pPMpFf7Vk9EhlPi3bryJZMfAfslKhZL
X-Gm-Message-State: AOJu0YzGHfeS9r2HjV/6gcZHigbIexMjH1VJ7+qaUD3owLkFPL8CQEsH
	tlcsWLLWo1DRYCrqW6ZQhxauH7AlVg7FfqHAXyBORUeTaTRdznn95BO4q51F3A==
X-Google-Smtp-Source: AGHT+IFgkuWsPXN+rSZfXHVUnr0hyu5KXgc5mjxITXWDgbYW6u2XoyVyZFujajA80aZnB7uRLwsNkw==
X-Received: by 2002:a17:902:ec81:b0:1de:f93f:4410 with SMTP id x1-20020a170902ec8100b001def93f4410mr1752104plg.8.1713519533970;
        Fri, 19 Apr 2024 02:38:53 -0700 (PDT)
Received: from thinkpad ([220.158.156.51])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902b21400b001e3e081dea1sm2946412plr.0.2024.04.19.02.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:38:53 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:08:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 3/9] PCI: endpoint: Rename BME to Bus Master Enable
Message-ID: <20240419093847.GB3636@thinkpad>
References: <20240418-pci-epf-rework-v3-3-222a5d1ed2e5@linaro.org>
 <20240418161209.GA239309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418161209.GA239309@bhelgaas>

On Thu, Apr 18, 2024 at 11:12:09AM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 18, 2024 at 05:28:31PM +0530, Manivannan Sadhasivam wrote:
> > BME which stands for 'Bus Master Enable' is not defined in the PCIe base
> > spec even though it is commonly referred in many places (vendor docs). But
> > to align with the spec, let's rename it to its expansion 'Bus Master
> > Enable'.
> 
> Thanks for doing this.  I'm always in favor of using terms from the
> spec.
> 
> > -		dev_dbg(dev, "Received BME event. Link is enabled!\n");
> > +		dev_dbg(dev, "Received Bus Master Enable event. Link is enabled!\n");
> 
> Nothing to do with *this* patch, but this message reads a little weird
> to me because setting Bus Master Enable has nothing to do with link
> enablement.
> 

That's my bad. I'll remove it.

> Also incidental: some of these messages and comments refer to a "Bus
> Master Enable *event*".  Does "event" here refer to the act of the
> host setting the Bus Master Enable bit in the Command register?  This
> is in qcom_pcie_ep_global_irq_thread(), so I assume there's something
> in the endpoint hardware that generates an IRQ when the Command
> register is written?
> 

Yes, the PCIe endpoint controller generates an IRQ when host sets Bus Master
Enable bit.

> > - * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
> > - *			  the BME event from the Root complex
> > - * @epc: the EPC device that received the BME event
> > + * pci_epc_bus_master_enable_notify() - Notify the EPF device that the EPC
> > + *					device has received the Bus Master
> > + *					Enable event from the Root complex
> > + * @epc: the EPC device that received the Bus Master Enable event
> >   *
> >   * Invoke to Notify the EPF device that the EPC device has received the Bus
> > - * Master Enable (BME) event from the Root complex
> > + * Master Enable event from the Root complex
> 
> There's no "set Bus Master Enable" transaction that would appear on
> the PCIe link, so I assume "the Bus Master Enable event from the Root
> Complex" is a way of saying something like "host has written the
> Command register to set the Bus Master Enable bit"?
> 

Yes. But looking at it again, it could be reworded as below:

'Invoke to notify the EPF device that the EPC device has generated the Bus
Master Enable event due to host setting the Bus Master Enable bit in the
Command register.'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

