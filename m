Return-Path: <linux-kernel+bounces-21678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1861C8292AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464072894B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF23FEF;
	Wed, 10 Jan 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxdK1hJc"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC823B1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f00bef973aso35094127b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704856304; x=1705461104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4d6kdLM2zyfXppW2Q5zuzpAXCPsQmw5b1RArNBQ9sVU=;
        b=fxdK1hJckKgGXMK0xg1E+A+rE0ItGHJJ81GA9w4EHyGU8UJGq2yNTrvTyiKkukdF3d
         s/c211krNhhx3Tc8UgfaMP4Ian1AjizSQ4wlufo9QCNpNb5o0wtd+l/cZAoxlcw1OMI5
         +iYNkCajkqIWvJ65RlMGRnlWwnwmN3uztyWiQ1Wl8ykwkV4LMJaqJEHzmQUsHP1h+f8M
         hzjhwtG8gUjPXYLFi9vHjE+zT+YRVT69zFXEQtOUn1ojzMD6nFnEIx/CmDgd78gYfyYf
         TSn/6z57q7nsBe1lue+WGJf4gI/qOH+a4tjsoXx7Bo2G5kpgQHQRb3BBqjJQpSrp0Sxl
         5Gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704856304; x=1705461104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4d6kdLM2zyfXppW2Q5zuzpAXCPsQmw5b1RArNBQ9sVU=;
        b=UkGcb8MT9xPrJmknmo6Zkpbf6os+1E31KihnxOzCx83oU2uR8i78Rsj/wgq48JEj+0
         2CP1UkpzXgRXamC5wqaaK0QGksOywk9ZBCNlb9nL0AKbRA5Ob4u12ozz2evYARFHC0MM
         9wxDxoX9XgEjFwjABJNZH5xQgQozsiSkee8nrYmDJFXFfLFc89Sh8H+tjvjIvYTC62+7
         9e2IQk02yMv3qyA9oXOQJjYH6nW1rExnHxW5Z43f9VnKTpRMuAv90YhDZCHSpMUO1YBO
         3X2N4PUHNjh+qSfyd/EZtzCgl7z+QfBjWfaE5fSZry1xy2dMKGFwBHUVLirk6v+bbwV3
         Iy7A==
X-Gm-Message-State: AOJu0YxKhlflpbYqKmftqlBBOoFp0s5jS/MOMZGNMQFc7jLuEFhE8A1j
	NMsW/07cPUh9ka5y4RE0OQunYHVXme09
X-Google-Smtp-Source: AGHT+IExGw+hfQ3V07Z4sxUL0Zg/OgE7HO0brqGsNbKIQpRdruQQOOldw8LcAacx3e3s35Nb3rvCtg==
X-Received: by 2002:a81:9142:0:b0:5f7:d06c:7464 with SMTP id i63-20020a819142000000b005f7d06c7464mr435219ywg.61.1704856303904;
        Tue, 09 Jan 2024 19:11:43 -0800 (PST)
Received: from thinkpad ([2409:40f4:8:c69c:51f1:be5e:dfa1:6e66])
        by smtp.gmail.com with ESMTPSA id mj22-20020a17090b369600b0028be0ec6e76sm259409pjb.28.2024.01.09.19.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 19:11:43 -0800 (PST)
Date: Wed, 10 Jan 2024 08:41:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
	"vidyas@nvidia.com" <vidyas@nvidia.com>
Subject: Re: [PATCH v7 0/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20240110031137.GA2630@thinkpad>
References: <20231120084014.108274-1-manivannan.sadhasivam@linaro.org>
 <20240107072707.GC3450972@rocinante>
 <ZZ2JXMhdOI1Upabx@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZ2JXMhdOI1Upabx@x1-carbon>

On Tue, Jan 09, 2024 at 05:58:53PM +0000, Niklas Cassel wrote:
> On Sun, Jan 07, 2024 at 04:27:07PM +0900, Krzysztof Wilczyński wrote:
> > Hello,
> 
> Hello Krzysztof, Manivannan,
> 
> > 
> > > This series is the continuation of previous work by Vidya Sagar [1] to fix the
> > > issues related to accessing DBI register space before completing the core
> > > initialization in some EP platforms like Tegra194/234 and Qcom SM8450.
> > 
> > Applied to controller/dwc-ep, thank you!
> > 
> > [01/02] PCI: designware-ep: Fix DBI access before core init
> >         https://git.kernel.org/pci/pci/c/d3d13b00a2cf
> > [02/02] PCI: designware-ep: Move pci_epc_init_notify() inside dw_pcie_ep_init_complete()
> >         https://git.kernel.org/pci/pci/c/a171e1d60dad
> > 
> > 	Krzysztof
> 
> Considering that we know that this series introduces new problems
> for drivers with a .core_init_notifier (i.e. tegra and qcom), see:
> https://lore.kernel.org/linux-pci/ZWYmX8Y%2F7Q9WMxES@x1-carbon/
> 
> Do we really want to apply this series as is?
> 
> 

Niklas, I think I explained it in this thread itself. Let me reiterate here
again.

The fact that you are seeing the dmaengine warnings is due to function drivers
not releasing the channels properly. It is not the job of the DWC driver to
release the channels. The channels are requested by the function drivers [1]
and they _should_ release them when the channels are no longer required.

I know that the PCI_EPF_TEST driver is not doing so and so you are seeing the
warnings. But I do not have a device to test that function driver. Qcom
platforms use a dedicated function driver and that releases the channels when it
gets the LINK_DOWN event from EPC [2].

So my conclusion is that the issue is there even without this series. If you
still want me to fix the EPF_TEST driver, I can submit a change, but someone has
to test it.

- Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/endpoint/functions/pci-epf-test.c#n229
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/endpoint/functions/pci-epf-mhi.c#n563

> Reading the patch, it appears that (at least some) tegra and
> qcom boards currently causes a whole system hang, which IIUC,
> renders those boards unusable.
> 
> So perhaps the new issues introduced by this series is preferable
> to a whole system hang.
> 
> As such, I can understand the urgency to merge this series.
> However, at the very least, I think that it might be worth amending
> the commit message to mention that this will currently not deregister
> the dma device in a clean way, leading to e.g. superfluous entries in
> /sys/class/dma/ and debugfs warnings being printed to dmesg.
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

