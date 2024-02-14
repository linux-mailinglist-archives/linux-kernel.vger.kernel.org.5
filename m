Return-Path: <linux-kernel+bounces-65784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A1B8551CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597BC1F289FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A6A12C527;
	Wed, 14 Feb 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C/mTzAls"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211E129A8B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934253; cv=none; b=CL3sZHTFRQAVXXd3NpGbK4hiz5HAfb9WMjGiHw7iWop/8NsdBvfQewQ/0MJecdQwtPYZ5UZ7la/zey09M/xyIwBZR/D+7HpgT02gs5E/qemzQOiuQRzVAABbR3zyM8Zpgzfbtuq8WOrjv8NtFRsXeT7ZFogxM/ThMRpyZoqqrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934253; c=relaxed/simple;
	bh=MIJ/ViYPv4yUkUGTAszNObjOXCLAvjnskRl3Fsc5JuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUnSLt6hAZ9VFQb5Pj1nEC09fB+kOWEQjqmC8T2u+OvTbtRn8YUPaDoT9zTSw7pY5/gZJef7Fsu9R6RDkc3C9ej64dIVff7GqOBY6h0VtirXmlW9+fBd3ZFXSOFN5/Gp0A/YU5h82sk5tJZ7jYsst228wYrITP2kDhgwFeSKJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C/mTzAls; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68ce2fe86e3so324356d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707934251; x=1708539051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NxJECfpMRF8c2GbwL7RYFmi85n9Gnxdrw1xOB+mHj0=;
        b=C/mTzAlspTV0Mpyc+feUT7umE8u4kL8+xPxzMlGSIJy7TjBQ9uKLogAbnnBnYxAcw2
         fx878ms+xSivaVTVukGZ8aZdBcmwkRapYY9Q/LcEDVeU7322T4pNgi2G8bijeyqd6J3o
         XRluWwi4hgjWxhstv+fL6Vcecth/xfHoAFOzufHfWNhXszzEqZCi87orRmpZROOSoYAB
         JHWlYwaY94HJRXPJZx+4gkoAlTZreSOKBlZz5f152bya2+PLZ0KESKvfCcbRx45Wm07m
         k78K+BK7actHP3hYQCeBK7ETsq2nTrutqIQAzgMo8abdsf9cKhwn5LRFx9J6XQfSZ0kK
         YGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707934251; x=1708539051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NxJECfpMRF8c2GbwL7RYFmi85n9Gnxdrw1xOB+mHj0=;
        b=aakkZE5wPOC3RC4Wtx8Vz0BCTk7DkNmym2sVes9VmuqscWjk6tJdMgbJ5LobNsKCqz
         J6gfmKZUNBHs97PZdgPL1DzPaS5+GcKZzCx2c89ArJIxZMPUQGrEHR6A783I9zJaW8e6
         97UNdO+y2icPfUZYWNmiFA5Vvjm8X8gZscUeSeMW4IxHfO9uGYFNNOvjz9o7zZnU4ql2
         1ewY22Q/mT4tvnUYJyS/ALeFhYgRF+jW/jfiD1Rc+6/XRgaMVNfS+Z3FCmCb3jgs9udw
         H86foB4MuMwmmUwQTSBKMlTclCAfxlvRS51pg9/D/IyDv6FZBvJ8KafAWne+/vF1xJz4
         a7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWoGEtpSEDMPQ20m9Z1sOQhaioqv30E2Ce73x5FLsmy1uAU2MowsSP5nIKAa3+DCT+poLDekk+N++n8UmDEITIr0QBFr4ema+ceZuB3
X-Gm-Message-State: AOJu0YzHumBSQi6cy0Il+RXFqGWElPbMvw4UDyg53ekBSgZWKvqakjjt
	QE5NgJ3GSvjmIAJRZASmmT8aTaBSueJdirnAvSctiIQ3eoQEXVMNUWqvxwwCxrc=
X-Google-Smtp-Source: AGHT+IFxJ5Oyh0vuYSwporQYabR5lakJ3bNo5TaWRxTZ4pE3VjQhS2h6z4sU20cMHnc/Nzni0200LA==
X-Received: by 2002:a0c:e1d3:0:b0:68f:487:d26d with SMTP id v19-20020a0ce1d3000000b0068f0487d26dmr1918722qvl.44.1707934250871;
        Wed, 14 Feb 2024 10:10:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUacb9awFsWp+T7G87yMPADUj7s0lLcZZEQGbM4hxxWBROamLlFhBeh++usHhOAhKn2zu74tLgWkSPtspeTmkpbd3NK79jBpPKiO6TeqA1UdFrhGaPugRpewjCMGnEsjXS/M5DV9w8hxOyieiEpcMQLLjKECDkzUFiUDGIg/HA7S7+0V0F1VnbIO2gMi2sJifTmYGNInzSDmKuFXgusz8PwevnysXATZabqKMZPZ0jG3AiPGE2mIe+iH8ivaqqfD3yk30NY/nwfbrD73lS++9CK+41mnTACxu3Sl8T1eUrNfGdK6Muvfps3TadeNqS6xNqXiMXwcrgpE7Mh1BFrKalwhALWP56H84v1yjPjdRDaksKRYh8RvuUPF66g6eP8rEWxWL/+aEJ3BP5YRzxdcRn1tcuJ+9q6st/z7beWEX+F4Yp8Y3uOOny2oTlXHhxMYaQmSJKv6Ld7Uf1bUSGkElLK4mWEHGb9IFbHV3b7K6FXuSPuINKiPgt0RDS4UBHBvo5M//+I99gt2bTvdt2Onis92hi/71X+DVCUYOZsnT1lBhon
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id me15-20020a0562145d0f00b0068cdbdb8af8sm2490567qvb.119.2024.02.14.10.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:10:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1raJib-00BonQ-Px;
	Wed, 14 Feb 2024 14:10:49 -0400
Date: Wed, 14 Feb 2024 14:10:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, jroedel@suse.de,
	tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
	gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
	vaibhav@linux.ibm.com, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc/iommu: Fix the iommu group reference leak
 during platform domain attach
Message-ID: <20240214181049.GB1299735@ziepe.ca>
References: <170793401503.7491.9431631474642074097.stgit@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170793401503.7491.9431631474642074097.stgit@linux.ibm.com>

On Wed, Feb 14, 2024 at 12:09:24PM -0600, Shivaprasad G Bhat wrote:
> The function spapr_tce_platform_iommu_attach_dev() is missing to call
> iommu_group_put() when the domain is already set. This refcount leak
> shows up with BUG_ON() during DLPAR remove operation as,
> 
>   KernelBug: Kernel bug in state 'None': kernel BUG at arch/powerpc/platforms/pseries/iommu.c:100!
>   Oops: Exception in kernel mode, sig: 5 [#1]
>   LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
>   <snip>
>   Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
>   NIP:  c0000000000ff4d4 LR: c0000000000ff4cc CTR: 0000000000000000
>   REGS: c0000013aed5f840 TRAP: 0700   Tainted: G          I         (6.8.0-rc3-autotest-g99bd3cb0d12e)
>   MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44002402  XER: 20040000
>   CFAR: c000000000a0d170 IRQMASK: 0
>   GPR00: c0000000000ff4cc c0000013aed5fae0 c000000001512700 c0000013aa362138
>   GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000119c8afd0
>   GPR08: 0000000000000000 c000001284442b00 0000000000000001 0000000000001003
>   GPR12: 0000000300000000 c0000018ffff2f00 0000000000000000 0000000000000000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR24: c0000013aed5fc40 0000000000000002 0000000000000000 c000000002757d90
>   GPR28: c0000000000ff440 c000000002757cb8 c00000183799c1a0 c0000013aa362b00
>   NIP [c0000000000ff4d4] iommu_reconfig_notifier+0x94/0x200
>   LR [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200
>   Call Trace:
>   [c0000013aed5fae0] [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200 (unreliable)
>   [c0000013aed5fb10] [c0000000001a27b0] notifier_call_chain+0xb8/0x19c
>   [c0000013aed5fb70] [c0000000001a2a78] blocking_notifier_call_chain+0x64/0x98
>   [c0000013aed5fbb0] [c000000000c4a898] of_reconfig_notify+0x44/0xdc
>   [c0000013aed5fc20] [c000000000c4add4] of_detach_node+0x78/0xb0
>   [c0000013aed5fc70] [c0000000000f96a8] ofdt_write.part.0+0x86c/0xbb8
>   [c0000013aed5fce0] [c00000000069b4bc] proc_reg_write+0xf4/0x150
>   [c0000013aed5fd10] [c0000000005bfeb4] vfs_write+0xf8/0x488
>   [c0000013aed5fdc0] [c0000000005c0570] ksys_write+0x84/0x140
>   [c0000013aed5fe10] [c000000000033358] system_call_exception+0x138/0x330
>   [c0000013aed5fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
>   --- interrupt: 3000 at 0x20000433acb4
>   <snip>
>   ---[ end trace 0000000000000000 ]---
> 
> The patch makes the iommu_group_get() call only when using it there by
> avoiding the leak.
> 
> Fixes: a8ca9fc9134c ("powerpc/iommu: Do not do platform domain attach atctions after probe")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Closes: https://lore.kernel.org/all/274e0d2b-b5cc-475e-94e6-8427e88e271d@linux.vnet.ibm.com
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
> Changelog:
> v1: https://lore.kernel.org/all/170784021983.6249.10039296655906636112.stgit@linux.ibm.com/
>  - Minor refactor to call the iommu_group_get() only if required.
>  - Updated the title, description and signature(Closes/Reported-by).
> 
>  arch/powerpc/kernel/iommu.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks again,
Jason

