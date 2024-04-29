Return-Path: <linux-kernel+bounces-162688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498648B5F09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63681F24CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E84585276;
	Mon, 29 Apr 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ga7I3Ezj"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BF2F25
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408286; cv=none; b=rLRgoXwQUodCZmRQwTTGqXC3hoc0QwF9w4VsPk1hcE01NhqtEnJZoPI07YX/3qd1M7StDS39MH/h7PAa/l9x79cI3OfqJWg3T3L8Yt4mcDYNZl/1xojzjVA+ER2NBMH4KnBp9e+sxn3Uf2aOvgemvG0ktTtgznJaliWxWW1rxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408286; c=relaxed/simple;
	bh=eDE2L21JKW8N96Vi3ng/YDqFma0PceL01iOHHG7iHr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTHBZb/Cb/CkJ0Zu3V7KfWZ65/Yvj39l3iz4z8VjQOmSRfjTrg15CJz02NldYh0ZQ/Y+NNfp82B4LwqX5UartelIGU4pqDwDN6msj1GhfyYKQP60Rh3Wedu2UscQ816TDn5jsJLtMxYKIdwjRCWs/hozlU8wuMoGkKqJDXxd840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ga7I3Ezj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e049cfe645so8030661fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714408282; x=1715013082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzGLiR69PoJGRhtxNKXAUaM6fxmHvGr503ePlBzc+m0=;
        b=ga7I3Ezj6Bh9Y7IKjN4AkwZeUr/08cTH2ZrlL8igbsZyoeRV6Cx1FHeqLili6rrQ1w
         EXSRdd75oqS1r+KzTKHmUV1eYFMH/BTiMaATHHnBNgUzyOeObIjmdvjzOV7ZKWuiDJW9
         yRLlbAgn4V/1ATL3KPTmb7tqaZUzf/yTm5io6J2MJRHzeGgreX1g9L9tDVQmtE/gfI/H
         /W09EflLcX0l+p0VmN0nVsW9fExaxu+dFFJLciZhs3kk26boNs4asiGBIYYQ3wauXOV0
         35t4NHWVbdf1bSPu0nxlxlyhWhvSH60BEGGkD3f9GiXwTtScUf8qkcgXXUHDwP85fSqU
         p4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408282; x=1715013082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzGLiR69PoJGRhtxNKXAUaM6fxmHvGr503ePlBzc+m0=;
        b=ciIysG8GXKwjWO22lCNWGSzpy6xaHK3GZWkDsW4Kw7UAtR1N6rAdchnYRKoVnQEMQJ
         mVGrsDdNHvjW6AkOpjbrxPMid8gf7K19V6xrygNqZqugbLzXkYxeBqKNwAq1XbjZVMhe
         oXMFoU2WsAXmUE/GuIgw3kHJg9JS3C0do3lykgHzptPaxBgqlpIEkMajI8AB7hHGg4Y6
         OFrEZpjMTEMy4kMD1zisn0c/W9WsteVS9fs0KyAFfc6LX9XU+VXfafkntM4+dbWIlJsN
         9V4or0DJ0hegUQKLw5ZlTGcKODSOQxbtHlc6JWSH+Lh4+duXbcloc7cjXIFs/1u+eaUA
         T9PA==
X-Forwarded-Encrypted: i=1; AJvYcCW5pUp5sLvNfxzXGo916nK0qaHCCdtkkpFS3QfM9YZ+QzXNtoIn7MxM6/9agjg7wYOPPPTIyZgDM+VyD3VYDC63k+TQPFNvWTmH3tWj
X-Gm-Message-State: AOJu0YzArfDttDQmZQA4tucpf0qQCnDUOkFDNJwKF6lOf6WSH4OBrBjn
	SVveZRdWd5FxnX0jgKS/B8xwTgOu++KTmlQS1y7bCpCM24z91T/2+5l94S3OBxo=
X-Google-Smtp-Source: AGHT+IHk3Z5XGDbb0v+Fmz92VybJVjDFdKDawu/AbXxfV/kYiZFIeb4QW5ZOrzeqL0UzpA0hXaFkSQ==
X-Received: by 2002:a05:651c:1992:b0:2de:6f52:5c8d with SMTP id bx18-20020a05651c199200b002de6f525c8dmr53916ljb.21.1714408281677;
        Mon, 29 Apr 2024 09:31:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id h22-20020a2eb0f6000000b002dfa8b1a07asm961511ljl.111.2024.04.29.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:31:21 -0700 (PDT)
Date: Mon, 29 Apr 2024 19:31:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>

On Fri, Apr 19, 2024 at 05:54:45PM +0100, Robin Murphy wrote:
> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> which means there should be no harm in achieving the same order of
> operations by running it off the back of iommu_probe_device() itself.
> This then puts it in line with the x86 and s390 .probe_finalize bodges,
> letting us pull it all into the main flow properly. As a bonus this lets
> us fold in and de-scope the PCI workaround setup as well.
> 
> At this point we can also then pull the call up inside the group mutex,
> and avoid having to think about whether iommu_group_store_type() could
> theoretically race and free the domain if iommu_setup_dma_ops() ran just
> *before* iommu_device_use_default_domain() claims it... Furthermore we
> replace one .probe_finalize call completely, since the only remaining
> implementations are now one which only needs to run once for the initial
> boot-time probe, and two which themselves render that path unreachable.
> 
> This leaves us a big step closer to realistically being able to unpick
> the variety of different things that iommu_setup_dma_ops() has been
> muddling together, and further streamline iommu-dma into core API flows
> in future.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com> # For Intel IOMMU
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
>     is covered as well, with bonus side-effects as above.
> v3: *Really* do that, remembering the other two probe_finalize sites too.
> ---
>  arch/arm64/mm/dma-mapping.c  |  2 --
>  drivers/iommu/amd/iommu.c    |  8 --------
>  drivers/iommu/dma-iommu.c    | 18 ++++++------------
>  drivers/iommu/dma-iommu.h    | 14 ++++++--------
>  drivers/iommu/intel/iommu.c  |  7 -------
>  drivers/iommu/iommu.c        | 20 +++++++-------------
>  drivers/iommu/s390-iommu.c   |  6 ------
>  drivers/iommu/virtio-iommu.c | 10 ----------
>  include/linux/iommu.h        |  7 -------
>  9 files changed, 19 insertions(+), 73 deletions(-)

This patch breaks UFS on Qualcomm SC8180X Primus platform:


[    3.846856] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x1032db3e0, fsynr=0x130000, cbfrsynra=0x300, cb=4
[    3.846880] ufshcd-qcom 1d84000.ufshc: ufshcd_check_errors: saved_err 0x20000 saved_uic_err 0x0
[    3.846929] host_regs: 00000000: 1587031f 00000000 00000300 00000000
[    3.846935] host_regs: 00000010: 01000000 00010217 00000000 00000000
[    3.846941] host_regs: 00000020: 00000000 00070ef5 00000000 00000000
[    3.846946] host_regs: 00000030: 0000000f 00000001 00000000 00000000
[    3.846951] host_regs: 00000040: 00000000 00000000 00000000 00000000
[    3.846956] host_regs: 00000050: 032db000 00000001 00000000 00000000
[    3.846962] host_regs: 00000060: 00000000 80000000 00000000 00000000
[    3.846967] host_regs: 00000070: 032dd000 00000001 00000000 00000000
[    3.846972] host_regs: 00000080: 00000000 00000000 00000000 00000000
[    3.846977] host_regs: 00000090: 00000016 00000000 00000000 0000000c
[    3.847074] ufshcd-qcom 1d84000.ufshc: ufshcd_err_handler started; HBA state eh_fatal; powered 1; shutting down 0; saved_err = 131072; saved_uic_err = 0; force_reset = 0
[    4.406550] ufshcd-qcom 1d84000.ufshc: ufshcd_verify_dev_init: NOP OUT failed -11
[    4.417953] ufshcd-qcom 1d84000.ufshc: ufshcd_async_scan failed: -11

-- 
With best wishes
Dmitry

