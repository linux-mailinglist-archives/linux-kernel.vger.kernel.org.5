Return-Path: <linux-kernel+bounces-97559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D072B876BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7A42830D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5735E087;
	Fri,  8 Mar 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HLshlY0J"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6A5D90F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930240; cv=none; b=MjnIXNb6J77ibXFB9g8A+IC7l3bln1hgGHo9BKxJvQRev2DfnwTwIbC5bm0r9wK7ud6kWPYTH1+v84ktNfUUQvgNcnRe14YSDV6fohuLlEAl7c4yrEbTuahA9pwga79iZQTIpdxy5Dfo2FywMtWztVFArIXYNgzhyz8GrS6SQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930240; c=relaxed/simple;
	bh=Bi3P4E1LMVNI9ICHZizJgPWFi1cAG6MJcwmbCUE+tB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB4nARsuQ2dt7OS7L3ifEz8YZf3EctJg0A51fMXYpAJMELcm51LfTTzuOuxH+K1P23griY9DgUtz6yXsQAdTRw9xSHcJX3Qvll8fvh6YvXzghPsLQG4736S3bcudpajko3IcztVELiVxZBpFXYtqoP4ANxdYJXHYMYjEFA2eV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HLshlY0J; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a1cba5d46fso426623eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709930237; x=1710535037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjWpdrEe1CBSB6fUsA969odLMNfAGSgF6jvNlFE06WQ=;
        b=HLshlY0JdEldHta3JUKzPHooseYZMDrj2DHryLYDs5peuYjAuXzdIHxf1El6VBnEzY
         ksY0Rv2pL6VWtrierriq21rd9UsObnawXA4p4AIgBlizBDnz9aN1Vh/qFXOdoilqfmdl
         2Msr1y8zrAmn+ef3dwTz7cREbJzefJTqGBtl0lcciyj0SoinX7jsRrdF+1eBzX5YjImP
         lj65zjhX8XvLydEBSxgTC0EZyrS7BlRIo9qZVM1T2PbyOJ3DUyJDTxQMaUlsRBWWeQGO
         R4A1v7dzeGxbht847VPfHRQHWbUApaKkCZJcU9B6aNAtLgR36Z1fZ1yNTw+AOPWOkl7S
         ddug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930237; x=1710535037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjWpdrEe1CBSB6fUsA969odLMNfAGSgF6jvNlFE06WQ=;
        b=R+rgN4Eqc+oBGMj0+AqhWz8LDa28H1q2StvxVPwEh02DeE830OOwV8GfPgAdk8zyAj
         924zZzorfZ/kO0CCNoFsXFqwlLiV+FOIqQ5Q9mW138IU0u3fnr+WfnSJqoY+Fj7SzxFP
         hSLEr2bg+C8uBATypNwyXpniJsgEHk7uXXNLy2VNb8CE5s8itsZ0lZU4bfs8jYG3qLhn
         fooB1R2IEUdqblNXNT3PjdKI9hNmF7GdxfdhdCmv3pXgI2L2Wz+h/Xe/mx9P7S+PgsLc
         z9G+FVGlpAGmoPbcHOdnecfHOh1tYJ7RRq+XRokmS72ukdyVFxECmlJ2k1Ld/lIhc4wU
         +o2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT8q8njBUA4SxWA3+L3SUuRyLnNKpQlorae8BwFq7KQC2+E74M7g/a1vPevbMcOR56caWjrB2EQ65Q/s2UK+4BljlYE9XO3Oh9fFOY
X-Gm-Message-State: AOJu0YwaIARuZvbPNaOnRWj3nc5qRzPFQ3c04uackC0+L3+VdmbIeIpH
	4edl8mnch9CddMJWdI4Vw0gnYt3V5LDpZKSnPoWZJVUM3KweXaWXEGMi1oHpqiI=
X-Google-Smtp-Source: AGHT+IEqmZ/bPScFDErmd2Bdge5ElcWmdcXhPkDOr+1siQATWKStEMzgbLHSA9vyfoc0LpJeGpIgyw==
X-Received: by 2002:a4a:2b11:0:b0:5a1:25fc:7be0 with SMTP id i17-20020a4a2b11000000b005a125fc7be0mr413338ooa.3.1709930236902;
        Fri, 08 Mar 2024 12:37:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bi3-20020a05682008c300b005a0859a4a01sm19059oob.36.2024.03.08.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:37:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rigxv-007xzf-Er;
	Fri, 08 Mar 2024 16:37:15 -0400
Date: Fri, 8 Mar 2024 16:37:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <20240308203715.GA9225@ziepe.ca>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <202fcca3269201bc9c4a8198253f195433d0c4ff.1707493264.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202fcca3269201bc9c4a8198253f195433d0c4ff.1707493264.git.robin.murphy@arm.com>

On Fri, Feb 09, 2024 at 04:50:03PM +0000, Robin Murphy wrote:
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

