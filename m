Return-Path: <linux-kernel+bounces-119098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389C88C421
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D212E745F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7F74BF7;
	Tue, 26 Mar 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUu4VDnr"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF34EB37
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461324; cv=none; b=I3Gj/E9hwhagD+yhxREoEKEHma1VFI07q618JMJyRQFNoWpM6VfS9DX2K4PSJJB1LU20CnJxdelGFYH7dtE0DTBAK8XtS8uCu27fhyK8OA1FcpxFMcy3501+P9Ur1hWcm9Qt+QWRFPgoQASKmpEbTXY7SlapT/6OFFHEfFs9T3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461324; c=relaxed/simple;
	bh=g5rSC54oRDFG3++0xhSBEsvKtp7+DPDEaeW7Lwz7adU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDULjdw+nPZREF/uS8h13z6vceFhdGieFgd3M/88X7oQo7GiKuS/R3GcitEb+2DkcMiM99NiMCKsMZlRSKWLTLimheYP8J55P/u7W6POTiLr5ZX6hblCtzbLNZVT+5TN3LW2bAbZYg+oVMUTZj3PRBmKYf3ICVobBM83bxiZcUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUu4VDnr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3333959a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711461322; x=1712066122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b1M0Y1XkDNHVcLc0TZz7shYAMA8ewv5L9mN1HcUgUKI=;
        b=sUu4VDnrSwxRC3gNcm/nSsPWzWDG6gi4nkSoSyZKBT4i0bo1riIQhZ/E9xvjDMg372
         fMGvRNssPASKjSM7xrhrIa4usa0ZpkdZohfFIbrp3clfQeJEhXTJCUyiJysDWGIfx3Jd
         L5gHQkTZJ8n3CiM/jdkSd4ub1HKaJJdSU4FF1j4DoZv++egH7uLMhDOh++eC1GjFK5LP
         ehSMKqe/6n4l5uPHILheH9qMhMTcKPq2FhxO8FyrzKTU/H6Y8+l2ZH9prl0PPr1kbVbZ
         3XNZZbiiqL361fRW+Iyk1Y12BSNa6SPq/9RGcj+MDyFY/VlsBcHMu8AAODEVOThZr9J/
         FrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711461322; x=1712066122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1M0Y1XkDNHVcLc0TZz7shYAMA8ewv5L9mN1HcUgUKI=;
        b=qhFg6ydnw5iH0gVnd7B7XYSV1evI2j5lPTNMo755D7ydxa2MtLfdR/kIztPpr6hBH4
         CLP47jux3WnomjWcMU1ZqZzf1wj+ASvADIZof61O+7uNlkU6TSRVoT/BPrJNvAizWWmp
         zBELlejxAX3eWEtb5Qddjhw5xVWglhzqxNiXy6FqnM/OZFR9iriSd2ScReah6QRzMS7s
         5pt9A/z9bQslbQHe4D01hWvE2Zom9+hbotsYMu42I/X0NRuVz4pmTcId+tBaiG3Oc3mz
         QDZz5RHTC7CAK6s7ayxVdIrvashBcMe3y51FTmLwwQDlE8iNAC26aLmFWU8eudl+4SUJ
         fbYg==
X-Forwarded-Encrypted: i=1; AJvYcCWlh2lf5f6hRXygHbDBC7oQoa4CzZ+UoDP9Zl+QmRWXTBbdERziuYeI0gY4VbrFhjGf7abKE0J85gFvx/BZmcu9SNygU6qiw1gqsBa4
X-Gm-Message-State: AOJu0YyHlJKlaYtVlmpGlU2W4Qj+PbGL9ZAPqY/I2m+qpv7zXVkP6i6p
	XYy0YBQyW7FHlZYjB9HOuPDoFbijT0PVJ1NkXA7oDE+R08Wh5GdbqeNjb7ix9A==
X-Google-Smtp-Source: AGHT+IHNOqXq6qL+ejk+jw9dkVs1U9l/d19WyMAcSDikAR4pgbYIYUs/kI+YvP7/ptELAWipSgmUOA==
X-Received: by 2002:a17:902:f68a:b0:1e0:a678:5b55 with SMTP id l10-20020a170902f68a00b001e0a6785b55mr1175640plg.11.1711461321584;
        Tue, 26 Mar 2024 06:55:21 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001e0c91d448fsm3213867plc.112.2024.03.26.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:55:21 -0700 (PDT)
Date: Tue, 26 Mar 2024 19:25:14 +0530
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
Subject: Re: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Message-ID: <20240326135514.GB13849@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
 <Zf2s9kTMlZncldWx@ryzen>
 <20240326074429.GC9565@thinkpad>
 <ZgKiUogkgrMwV1uD@x1-carbon>
 <20240326111021.GA13849@thinkpad>
 <ZgLR8jWfBcZB8laa@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgLR8jWfBcZB8laa@ryzen>

On Tue, Mar 26, 2024 at 02:47:30PM +0100, Niklas Cassel wrote:
> On Tue, Mar 26, 2024 at 04:40:21PM +0530, Manivannan Sadhasivam wrote:
> > 
> > I was planning to drop enable_resources() from Qcom driver once the DBI rework
> > series gets merged. Because, the resource enablement during probe is currently
> > done to avoid the crash that is bound to happen if registers are accessed during
> > probe.
> > 
> > But what your observation reveals is that it is possible to get PERST# assert
> > during the EP boot up itself which I was not accounting for. I always assumed
> > that the EP will receive PERST# deassert first. If that is not the case, then
> > this patch needs to be dropped.
> 
> From what I saw when having debug prints from my old email to you:
> https://lore.kernel.org/linux-pci/Zalu%2F%2FdNi5BhZlBU@x1-carbon/
> 
> 
> ## RC side:
> # reboot
> 
> ## EP side
> [  845.606810] pci: PERST asserted by host!
> [  852.483985] pci: PERST de-asserted by host!
> [  852.503041] pci: PERST asserted by host!
> [  852.522375] pci: link up! (LTSSM_STATUS: 0x230011)
> [  852.610318] pci: PERST de-asserted by host!
> 
> 
> 
> So in my case, I assume that the RC asserts PERST during a SoC reset.
> 
> This is obviously from the RC driver asserting PERST + sleep 100 ms +
> PERST deassert:
> [  852.503041] pci: PERST asserted by host!
> [  852.610318] pci: PERST de-asserted by host!
> 
> The two before that:
> [  852.483985] pci: PERST de-asserted by host!
> [  852.503041] pci: PERST asserted by host!
> 
> appears to be because the RC I am using, incorrectly sets the PERST gpio as
> ACTIVE HIGH:
> https://github.com/torvalds/linux/blob/v6.9-rc1/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L300
> 
> Well, at least they are bug compatible and sets the output to:
> https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L170-L184
> 
> 0 and the 1, which, since the DT binding is incorrect, will actually
> do the right thing and assert and the deassert PERST.
> 
> The problem seems to be that the initial flags:
> https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L242-L243
> is: GPIOD_OUT_HIGH
> 
> which explains why I get the extra:
> [  852.483985] pci: PERST de-asserted by host!
> before
> [  852.503041] pci: PERST asserted by host!
> 
> with basically no time between them..
> 
> 
> I guess I should send a patch to set the initial value to
> GPIOD_OUT_LOW, so that the RC driver does not trigger a
> "spurious" PERST deassertion when requesting the IRQ.
> 
> 
> So I think this patch should be fine if the RC is not buggy,
> but as we can see, in reality there are at least one platform
> in mainline that does manage to get this wrong.
> 

I've validated with x86 and Qcom RCs so far and didn't see this behavior. So I
guess I'll just keep the patch for now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

