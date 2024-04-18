Return-Path: <linux-kernel+bounces-150036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6A8A9970
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BFE2854FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7815F3EE;
	Thu, 18 Apr 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gWx3VBjN"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF515F302
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441748; cv=none; b=NcZQiv6dlDgUKd2eCYlj/jkbe9HpmKBPEYQ/KIHsulpQf7ioFmXJ0XAGrhFCFJWY0kYMPZFG+07a7E1lI6qbQggUrawtNiXPwywiFYsjhwziK05JeszJ7KlBqN58/3qVs6RMYydcJlyPtJ0sSPWgnEYB0Vc+rPcILoSD97hfnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441748; c=relaxed/simple;
	bh=ITsBhQ6SB3CHmSgX2EK/QEvUIJlCgmIXAKQpuqOzI0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/1PBLpfveuWkYMDaRs1OcNGaThmMH1XXN0u2MYbvMyQ1EzIPxI5MOJho9uJ4kx4xKIBP911yynTY2aqsf058PJMz4wRSVGWzTstS2wocngZDYezmN2CTNww4VsaBZaXVrKyN4KnaHKY5GdwfNoIJVFKiuYpDeeqDKy0RAUN/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gWx3VBjN; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa4a1246b1so487906eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713441746; x=1714046546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0iRrbqv6jSSKonYaBoI3Zi+BduXM/209JjylxcsUM4=;
        b=gWx3VBjNbB4IOCRbBYjmSjyEn2+MHco03V4Mf0ekyNBCsTwsS7r0atIRnIZ8jd5MEU
         gEEjj16WKgAErzLPNCzKHBY7o5pXKzpJiAKpNKoUo9QTDf6rhIE4I/j533nK3aqgkAJA
         eiQvd4gk2iZeg7L8kTC28igHCsuUt+z3kBy1TNsE37D8oBO653zDiB3ITuKjpSi/BRWd
         rlcenfIBJa3YtqxOrdDg6gnWjLrefhdy9Zhm1r6V0pmyDoU0wE4Cwt96S+WXsrAH0U1/
         h7PYCWv0NgGE6ISIfV6isR0U1CyoIRHiqDe8NgidZU4wiByWWNagjH43e42inVVFJDcs
         /a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441746; x=1714046546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0iRrbqv6jSSKonYaBoI3Zi+BduXM/209JjylxcsUM4=;
        b=LEzyCU0ZTStJCxZnZUjq/6U98JLTZ92JUt9mqlkBKrjMJOQCpv3JZUhMDebqkicKHn
         h0vy53KAvcrq0PDy2vd7+QtS88DID2Hgg/LT1dxzQt63NL2o4wuE2rLqfwsubC9j4uRu
         U0eqgzC4DLCwBe9CPl1DPwMPWJe55CMDvfhRCOI+QEl0V3qmWKqrQOUupjDBnkrHYMJ9
         tDeR4lnQm0/AwnISs1ErvLay4DKNJ7LL6/h7hzo93mp6hb1XImHQGPECTE6F3700gChe
         6TR/izLUvCgYHTxw7sZ9E8YeYn1c9VdfCafFOmKSzwynE8Q4hcv5KC0LiVpIQEZHYplg
         eL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9q515xH1v1bnTr4xzWMt1yux2VwBAerVJIKhQycQNFdv3azzlVY3LKUWs9pLzVZ+L8fsa8A3lbTC3BfsP9GMLutFe26PyUjXhpWzV
X-Gm-Message-State: AOJu0YzwMRatj+ROS1GNcFpGO6TLqMiBOsVDHGHPN3YUQ689pW0SAJne
	WGnEJTjqcN9C/tLPziFZGzUGKgl+jd4jaBQUE11sAdx0gD8OShJKTUfSlWMfLNs=
X-Google-Smtp-Source: AGHT+IGY7gxrX4srNIdUaUfos2H0Ztd97DKbnrqO5Q4gdLHyFgem0Nc0mOEUyNqIJ3bpHSP3UKeldg==
X-Received: by 2002:a4a:ad8e:0:b0:5a7:c78e:410e with SMTP id v14-20020a4aad8e000000b005a7c78e410emr3252880oom.2.1713441746389;
        Thu, 18 Apr 2024 05:02:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id k13-20020a4ab08d000000b005a5554a076esm353372oon.10.2024.04.18.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:02:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rxQTA-00DuPT-Kl;
	Thu, 18 Apr 2024 09:02:24 -0300
Date: Thu, 18 Apr 2024 09:02:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vashegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	ewagner12@gmail.com, suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
Message-ID: <20240418120224.GY223006@ziepe.ca>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <b0db9b48-e9c6-4e40-9d07-c353ab14e4ce@amd.com>
 <20240417160635.GW223006@ziepe.ca>
 <b014b871-1be0-4316-a72c-d699b8872604@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b014b871-1be0-4316-a72c-d699b8872604@amd.com>

On Thu, Apr 18, 2024 at 05:14:59PM +0530, Vasant Hegde wrote:
> We return IDENTITY only if SNP and memory encryption is not enabled and device
> is SVA capable. Upstream has below code (v6.9-rc4)
> 
>         if (pdev_pasid_supported(dev_data) &&
>             !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>             !amd_iommu_snp_en) {
>                 return IOMMU_DOMAIN_IDENTITY;
>         }
> 
> 
> and during boot, we will enforce Paging domain when Encryption/SNP is enabled.

It is very confusing considering the comment says identity isn't supported:

        * Do not identity map IOMMUv2 capable devices when:
        *  - memory encryption is active, because some of those devices
        *    (AMD GPUs) don't have the encryption bit in their DMA-mask
        *    and require remapping.
        *  - SNP is enabled, because it prohibits DTE[Mode]=0.
        */

Then it goes on to return IDENTITY anyhow.

If the HW cannot identity map it needs to return DMA for those cases:

/* SNP is enabled, because it prohibits DTE[Mode]=0, IDENTITY is not
 * supported */
if (amd_snp_en)
   return IOMMU_DOMAIN_DMA;

/* memory encryption is active, because some of those devices
 * (AMD GPUs) don't have the encryption bit in their DMA-mask
 *  and require remapping. IDENTITY is not supported.
 */
if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
   return IOMMU_DOMAIN_DMA;


> So far the policy was core layer to handle untrusted device which got changed
> and hence we hit this bug.

Well I would say the AMD driver changed to mis-use def_domain for
policy and that causes problems.

> I don't see any issue with enforcing these checks inside AMD driver.. If we go
> with this approach then IMO core should just adhere to what driver returned
> rather than failing. Having policy decision at two level is inviting trouble
> like this one.

Again, no policy in drivers.

def_domain should return only the HW capability. If it returns
IDENTITY then the driver must fail attaches of PAGING.

You should send a patch fixing this function and remove the PASID test
entirely for now.

Jason

