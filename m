Return-Path: <linux-kernel+bounces-146044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C268A5F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABF81F21C77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B357A3D;
	Tue, 16 Apr 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Oo4Ki9pI"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545766FC7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227948; cv=none; b=bS9FDnH8VdcdnPpUeKo35usZ8LHSs7drUJ4mgDaBGSCCdT/2zhpDRa1+ML7fc9gKwYwoAh7ef0MHpngQ3ghN36h3Od05jCZKHW1mV9Lsrp9LAgJhAPjFxsu0dMMC4xl5mwj/88c9fMB4iSGi8iXCjRjHevl6pOWrG1dEnulEI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227948; c=relaxed/simple;
	bh=d2bYC2KeiHUqcBLgPzBPOh3gasiU0kpLQmM6QaRtQO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn5JzqzNa1dzOSCuqUz3k8uQqnCNBkj9tVVEjVjJCOCWE28+1evl2CGBmMRj+0xI2MmfgaQgchZaqAmog1/mwOlREzvkBtUVOJ+UXbwD90E9/UG+ZNgKRigaNPETOciLYw6FzMlMm1e2VDBh8WojF44BpwVgrcLpy1B6QxLtG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Oo4Ki9pI; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b5a87505cso12113346d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713227945; x=1713832745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SC+OXs/GZF0u24XHwRAC3c8xEl57m2qiEJ4YV7msZrY=;
        b=Oo4Ki9pIw4thXD2xgeaf76m3clScAOka0C1CZTa5+NtXfqCvofpdfDgnG3mzx0bgU+
         jWePwYkfqLD8UY+a+1dJC32yM6IW8prXiM5VSvBA/vERm56Nw6cRNSiwfRp/XraE50l8
         AAXnZxITNEK19f97c9MCdkLSa96mSQSdFK4YQ6UcXR7q0saevIjLWuv/t+5kxDW/z85W
         yQXeBkNhJl7l2nKqUA+Zyhn7xJRw3hGlhS0tA1eXdH/MVlXKSu8cdpUShCXnRLCfo1cJ
         O09kfwG2f0fECQ15QiN0TZ4KKAWa6y8y9HB7Ha7BOsnpShe2oZukdHcdhttIZTPaRCdM
         2oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713227945; x=1713832745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC+OXs/GZF0u24XHwRAC3c8xEl57m2qiEJ4YV7msZrY=;
        b=IzqNfv9BgfixXq2ktQF/0sKlGwO5W2rL0dtTu2Emai9b384TfZ5n2o3PZZgQ2i0p4h
         03pCW+BjahZga4eRLWCimAxZkcfntYlgQjUYbL9FQ57ekA4g3/d5vuX+bRoUUPNo8JhX
         1mfFiPKl+D0rViZGPUJQT+4BFnrd4G0N/uyl2igB73pv9pCaXIOiAqdn7f1KVYVcFAmU
         S1PirTpb3rL62KFQfqwRW9eMDN9m8lHzxsAKpfr4t9Am4UuMHH1L2ZIz7pirErxGwNu+
         TBV8Uel+4Ncwa02Cc54aZU1eoBPB62sQlUiIDKmz63+3r3FVEII6XP+37qKjvofZ528h
         3BUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpgC4v4oTRp/Ft8wDWWW+P4pRX6J7eyh0s/VeD5B+mimQ4gIqeDV63kXopq+UXKDz3HMWwZN6KlE3eTW+G4sbjzjhR/wS1s8l6yxZt
X-Gm-Message-State: AOJu0YxlyNGkJmVuSYEfLNZ4tRhFVKnbSrb46z54THiY9Pa8VqzfTH30
	Mi3ciPgpI8LmCel7TnKPyMoj5uMTzPXNnALN3Hk5XTz/7oQMYSwjCklH6/RL/lM=
X-Google-Smtp-Source: AGHT+IGZ3ByVJiZA7dsHED891rzWwy7eaTLceOAgh8WUU2Lful6iQcmJWnPlR6lkZm6ffVA/3NK9Aw==
X-Received: by 2002:ad4:58d1:0:b0:69b:1c78:158d with SMTP id dh17-20020ad458d1000000b0069b1c78158dmr10582744qvb.53.1713227945150;
        Mon, 15 Apr 2024 17:39:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id fb20-20020ad44f14000000b0069b4fe0569fsm6341395qvb.109.2024.04.15.17.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 17:39:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwWql-007FhP-RG;
	Mon, 15 Apr 2024 21:39:03 -0300
Date: Mon, 15 Apr 2024 21:39:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: Eric Wagner <ewagner12@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <20240416003903.GR223006@ziepe.ca>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>

On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
> On 2024-04-15 7:57 pm, Eric Wagner wrote:
> > Apologies if I made a mistake in the first bisect, I'm new to kernel
> > debugging.
> > 
> > I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
> > 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
> > Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> > as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
> > bisect log is attached. It ended up at the same commit as before.
> > 
> > I've also attached a picture of the boot screen that occurs when it hangs.
> > 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
> > problem.
> 
> Looks like 59ddce4418da483 probably broke things most - prior to that, the
> fact that it's behind a Thunderbolt port would have always taken precedence
> and forced IOMMU_DOMAIN_DMA regardless of what the driver may have wanted to
> saywhereas now we ask the driver first, then complain that it conflicts
> with the untrusted status and ultimately don't configure the IOMMU
> at all.

Yes, if the driver wants to force a domain type it should be
forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
is incapable of supporting otherwise.

> Meanwhile the GPU driver presumably goes on to believe it's using dma-direct
> with no IOMMU present, resulting in fireworks when its traffic reaches the
> IOMMU. Great :(

I wonder where is the missing error handling.. iommu probe failure
should not go on to allow driver attach, there is no guarentee any DMA
works now that many iommus are booting up in BLOCKED.

> However the other notable thing that also happened between 6.6 and 6.7 was
> the removal of the AMD iommu_v2 code, so there's some possibility that the
> GPU driver still may have only been working before due to that also

Most likely it is the above change interacting with this patch when
they are both combined in the merge:

commit 92e2bd56a5f9fc44313fda802a43a63cc2a9c8f6
Author: Vasant Hegde <vasant.hegde@amd.com>
Date:   Thu Sep 21 09:21:45 2023 +0000

    iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
    
@@ -2471,7 +2481,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
         *    and require remapping.
         *  - SNP is enabled, because it prohibits DTE[Mode]=0.
         */
-       if (dev_data->iommu_v2 &&
+       if (pdev_pasid_supported(dev_data) &&
            !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
            !amd_iommu_snp_en) {
                return IOMMU_DOMAIN_IDENTITY;

Which, IIRC, was intended to be temporary to work around limitations
in the DTE programming logic within the driver. Previously iommu_v2 as
a module option that Eric probably doesn't set, I guess.

The below will probably make it boot, but Vasant should check what
happens if PASID is eventually attached too.

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d35c1b8c8e65ce..f3da6a5b6cb1cb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2758,11 +2758,16 @@ static int amd_iommu_def_domain_type(struct device *dev)
         *    and require remapping.
         *  - SNP is enabled, because it prohibits DTE[Mode]=0.
         */
-       if (pdev_pasid_supported(dev_data) &&
-           !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
-           !amd_iommu_snp_en) {
+       if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && !amd_iommu_snp_en)
+               return IOMMU_DOMAIN_IDENTITY;
+
+       /*
+        * For now driver limitations prevent enabling PASID as a paging domain
+        * on the RID together.
+        */
+       if (dev_is_pci(dev) && !to_pci_dev(dev)->untrusted &&
+           pdev_pasid_supported(dev_data))
                return IOMMU_DOMAIN_IDENTITY;
-       }
 
        return 0;
 }

Jason

