Return-Path: <linux-kernel+bounces-146715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2E8A69C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECDEB212EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C37129A68;
	Tue, 16 Apr 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mqjkb4J0"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C34127B5D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267582; cv=none; b=HqQCpgOy/W6FAfshuGHvU+hGFJbHUJ1PqB0Y0rXutNGDWixvrv1a4S4on4X1jcUsdgyMQjoAfT1D2P3x6PA4L/ZnP+0rFrOAGB9nsOnnxlmKj9EBsPc3ph95SGUNCPwWyOXyC6tc9HkTwd02MdgGpCj0IfKxHpdR+sVkhpPw9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267582; c=relaxed/simple;
	bh=InoIyfxzvCQPOkhkpXX4VHXf6BcyC7JfNME5c9a2Ef8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGsFIvqcFpa8SCkKSIoxU7GnmeMVST+1iOtDlhrisJcaVxqqYUEkMsjqzRjsVDgHl5f4NxT2ZKSfw9vg28SD7QXUFSnKde0z2b2GjV9gA5+p1luJL3NrZAo4P5eJVMAsjbMNgemOgOzEKQ/BvdCWo38t9zCupU8tZiDloPXCy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mqjkb4J0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b47833dc5so11830806d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713267579; x=1713872379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z9PVIz4MTE4YzFeH8WAZ9AriysdnNs2lDXckOOjjO0Y=;
        b=Mqjkb4J0i+DG/VVvdMcTcQlSF1VUQRmZdxCOS+exhmfd2c7uAc0Hvld7uae5TC5aYW
         /Wwz15KjuybvZuqM9UBLz6O9ELXLMSh69NCb9EE7Y5X6DYaDhQdKG9QAbbDhwgUJ0iOG
         0JNiUUM5wzjucT43tLsV+FlDlAmIP2rlf7wcPj8McnTE4JRYBQY+bUpuHwFPeMFo4tuR
         ffNo4+yAOILnjBL7N1RvUo16SH3Oa+oHY9zyDTufNhdgS+Eo6+UDhS+qpZrTWleSD4Db
         uifBZm0z7gzMmqC8ZUZS9z6Bh5p2MebLQcZvvIpkg89C0lbDGLVxv8oWmFk6BPwtS0q8
         A2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267579; x=1713872379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9PVIz4MTE4YzFeH8WAZ9AriysdnNs2lDXckOOjjO0Y=;
        b=rFNg/SFmt3gBZ4Ck4kAPlHNPtLkO6iWeK7zEw+imCES1kZRQv+1mIBYg17kWfpi8AR
         1mxj7gnTHbqFp+5lW0n1GXSV4lAwkOC0cq5t0tz3P83ybDO2VUDi+mkSocN4BRJ8/8F5
         ZnMBn6jPC8AxH2jtTCZYu12ka6UKZHhtO7YCpCNFY8W4axRVQ3yxNw5pK/TbHuSZD1Gv
         WdjVIPSiu6H8/wxcQ3bTrgmB/2SQYIHYowBa1kRT4Sub4A9sNAuJsVNkbNzAEccKEs/9
         uimIqhvd1JgUnQ4JfiYMKXUvD+2MQb4YkwfBhfX4kT9id6EB8yBAIgmm0bq33EWcyUFs
         sY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh3k7xvW/CalGBax5yX07kdiFvYq+2oFTsOlJ+6rGK5AufaKEW3gxceQyqLSv6K7BGcw/XlhTtOcxR+fKagh35CUa7Ap7wgwg8WKbn
X-Gm-Message-State: AOJu0Yyr6bgN9nKEN896NimFBujlQKtn8A08UUf8oGHuBkMOas2Wc93K
	HIa0WQWIIbhTB7zM7N5wh2uuTQMEx7SuG22YscHlu/rIM2Hqmlzt/uxUJyES+QYwrWhRfHF5MZ9
	7
X-Google-Smtp-Source: AGHT+IGnl3TattqJdjvTobzss8eUIeX4uff21Y1NqSeGZBSY761Ab4B/DJXPR8G80OCLuExKCWZJng==
X-Received: by 2002:a0c:eac6:0:b0:69b:5f38:1a47 with SMTP id y6-20020a0ceac6000000b0069b5f381a47mr9693763qvp.42.1713267578889;
        Tue, 16 Apr 2024 04:39:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id l18-20020ad44532000000b0069cc3a02eebsm920453qvu.4.2024.04.16.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:39:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwhA1-008Zp0-S0;
	Tue, 16 Apr 2024 08:39:37 -0300
Date: Tue, 16 Apr 2024 08:39:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vashegde@amd.com>
Cc: Eric Wagner <ewagner12@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <20240416113937.GS223006@ziepe.ca>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <CAHudX3x-ofB=-K6UwWpf4r7Ge9AQbvLQ2qq2C7N-R5LG2qMz7Q@mail.gmail.com>
 <a80df9b9-92a5-4430-8802-1f8d159d6162@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a80df9b9-92a5-4430-8802-1f8d159d6162@amd.com>

On Tue, Apr 16, 2024 at 04:23:38PM +0530, Vasant Hegde wrote:
> >     Yes, if the driver wants to force a domain type it should be
> >     forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
> >     is incapable of supporting otherwise.
> 
> 
> @Jason,
> 
> Looks like before commit 59ddce4418da483, core IOMMU layer was enforcing
> 'IOMMU_DOMAIN_DMA' for untrusted device. If its trusted device then it was
> letting HW IOMMU driver to pick best domain type.

If the driver wants to force identity because paging doesn't work then
yes it needs to figure something out..

Really the drivers should not be designed to do this, they need to
accommodate paging domains in all cases if things are going to work
correctly. The def_domain callback should be a last resort.

> >     diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> >     index d35c1b8c8e65ce..f3da6a5b6cb1cb 100644
> >     --- a/drivers/iommu/amd/iommu.c
> >     +++ b/drivers/iommu/amd/iommu.c
> >     @@ -2758,11 +2758,16 @@ static int amd_iommu_def_domain_type(struct device *dev)
> >               *    and require remapping.
> >               *  - SNP is enabled, because it prohibits DTE[Mode]=0.
> >               */
> >     -       if (pdev_pasid_supported(dev_data) &&
> >     -           !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> >     -           !amd_iommu_snp_en) {
> >     +       if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && !amd_iommu_snp_en)
> >     +               return IOMMU_DOMAIN_IDENTITY;
> >     +
> >     +       /*
> >     +        * For now driver limitations prevent enabling PASID as a paging domain
> >     +        * on the RID together.
> >     +        */
> >     +       if (dev_is_pci(dev) && !to_pci_dev(dev)->untrusted &&
> >     +           pdev_pasid_supported(dev_data))
> >                      return IOMMU_DOMAIN_IDENTITY;
> >     -       }
> > 
> >              return 0;
> >       }
> > 
> > 
> > As it booted ok with Robin's patch above, these changes to
> > drivers/iommu/amd/iommu.c didn't seem to make a difference for me. I was
> > testing with amd iommu v2 off in the kernel config and I also have TSME
> > enabled in the BIOS if that matters.

There must be a mistake in the above then, it would be good to sort it
out because something like that is the right fix.

Jason

