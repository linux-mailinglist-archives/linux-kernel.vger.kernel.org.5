Return-Path: <linux-kernel+bounces-50032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED9847376
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7421F26F12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D2145B39;
	Fri,  2 Feb 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Eanzd07O"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0914198F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888377; cv=none; b=uN1qfUoN2/5VPvDWdX8bTanyHf+ws9pX2sw9fS94l6I2CZGYJwtEdjSakqvj0u+VkFoNasRdPcd9JzlFptYIqckQ9QZfwaA+j7pZcFO+m+Qtg6zIMwe3qnYVpcY1olVAcvA0PRjkvZFUGPDm3jtiwPvpIQOQ1xSR03C44l2IAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888377; c=relaxed/simple;
	bh=4ZWofalsuZmb/ntmgNIW+GtgsDeiz2TAm4x47GB9Y40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnBZB1BG7ut493ED8knxYm3kGLP55Es3B7sFNLPH1wpQh72jB+yA666Z2QgKFNRFRc+IIJRovPnUN/E5CJ8yEfdGAi4pxDKeFb2BXYGDrHVZ7ej1c0Xk+w+le9dnaLyuryuNxCYKj99+2INKoKoe27X0seTsbu9hcmk28e2aHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Eanzd07O; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783d4b3a026so137645085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706888375; x=1707493175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lU39QnoNXjcBC7nfuMXyZD80hgMpGm0/TrjMwiAD348=;
        b=Eanzd07O11HXTWELGYmK6w3r44SgZTBxl1/tW0JiA41HyR8bfaIQGSjwWPfWi6YbjU
         f+ExuL8+Y6wVtX39aIg3BgzCjhddWuN8QmmFRja7YHXbfkFkdnchkQC8f23VRT2MUMhz
         uCvxokoBm7aGCYNORI9LUlFKyGObgdVLVu9mYk5fRZ/1XlFXn896nOWusZuRbQQsHent
         5ia2j4JtThZ+sXtuXMzs+K4WOdtEw3XtAN3M4LqRCmjw7XkpLoE4p56hNlAhgKwgdt6G
         JiFA7POqoe9Uz96/7HzOFEYluBFSqwbjdeABjt1imstP0Sq8a8KeAvyaTtfa5A0zoY9f
         dFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888375; x=1707493175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU39QnoNXjcBC7nfuMXyZD80hgMpGm0/TrjMwiAD348=;
        b=RPq85Q3ADDA9Pu9WQ0LPEQNLBtqxxPtbssTMuF1eKomWlJArOvIu6wcENvx2L3F0LQ
         ap+MYdi/yMC4eDDxQzaQHhZgw6YJZ2BWcdz37smS53WsuW/hFTu9rFXQEnsWHiXtlEom
         gkxgcqVLO6UBccivIVzZ6NSnHAL6NSHTMrsg7hN4IfCRqU1JMdC2VVhCByHXfZRJ4y2H
         xWUYX4mLCntiqaszEmu+Gl/1bqCuLhxKtLBcP55b1HcnffjfczAb0veBoZYNT4+2va4n
         Yc2Slu84pnR6UMsZj6MFxLmKDOVxW16ya0HbKkRwHvUK9S6ETNrv+yb6fhmOIuaqs608
         RxRQ==
X-Gm-Message-State: AOJu0Yz5zV/jpalBRR7TiOCV22lciY8WsU6Xrh0k0NKM1WIBkDv27VJ+
	KksNIuG7Ic72Qs9o5L+bDUM3BafNxIPOguL86NhAwhBCzuvZK5TR9TzOhY2Dq8w=
X-Google-Smtp-Source: AGHT+IHiw+AEztOJJqEv+FuIsKu3uPT1wuYZJmWuQWWrW1zNDN04EQCohZ3acbfSojrNbGI++36prA==
X-Received: by 2002:a0c:f38f:0:b0:68c:83f9:fa3c with SMTP id i15-20020a0cf38f000000b0068c83f9fa3cmr2468777qvk.65.1706888375070;
        Fri, 02 Feb 2024 07:39:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVAceCf+KoqRHjUTfSYwJrnQ15qAFsD6FwrGJ2OFm83JtDL7BCcZ/JsXY/5AxhcVyY4PpqDhCNhmskIo4bnmfKFlnH1gdyuljk9N9A6RnVbD7VFgPyIBMiqoE7i3je93SXXFLHvDaNhqHmcMAJHesqukN2bjxRk80vE9JnS8KH13l3/qeMgcXk5+9R0/zQz9GPCOSwQuXjSJt5A57Jx00cSKDI7wE+ak37jQMuUKmDmKDWRbBaAwyoy/zwmAwHto2S4SNtSHUVKoA3T4Dx/Fk8HPdodxFAAcwWVoODL7tzBMw6nO4Hoe+jHcs3lTw158b5TQWmXQ9KoSlg3gamJsCzztQ3HoAMsji5xXx5ui9rJ7AmYnYSUazsT258mSUBa4rhB/BL5gpgyom1msg+dVxRl/otZiHF9Fy3QcRq1SV9hbIB6vHMa
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a240500b007840a2586cbsm760828qkn.110.2024.02.02.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:39:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvde-00AwI7-14;
	Fri, 02 Feb 2024 11:39:34 -0400
Date: Fri, 2 Feb 2024 11:39:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 16/16] iommu: Make iommu_report_device_fault() reutrn
 void
Message-ID: <20240202153934.GB50608@ziepe.ca>
References: <20240122054308.23901-1-baolu.lu@linux.intel.com>
 <20240122054308.23901-17-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122054308.23901-17-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 01:43:08PM +0800, Lu Baolu wrote:
> As the iommu_report_device_fault() has been converted to auto-respond a
> page fault if it fails to enqueue it, there's no need to return a code
> in any case. Make it return void.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                       |  5 ++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 ++--
>  drivers/iommu/intel/svm.c                   | 19 +++++++----------
>  drivers/iommu/io-pgfault.c                  | 23 +++++++--------------
>  4 files changed, 19 insertions(+), 32 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Typo in subject 'reutrn' -> 'return'

Jason

