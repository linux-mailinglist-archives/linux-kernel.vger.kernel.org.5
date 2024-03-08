Return-Path: <linux-kernel+bounces-97415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7899C876A2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C31C20C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39C4085D;
	Fri,  8 Mar 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g1t4A1/F"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A820B04
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920213; cv=none; b=B54thTyWd6t/49SAYE4cNmBZoQLy3TBzGBv5trygIMtMF+z3zd3VnYL1B7MqfDr6PRiRWodjXJTB6L9OS3pbdVGKZjCH/612H+3uB7776FjSR33eEn2UWy6fDJSlZZQ9DweMu1A64uopqFmWLIUXDZW8RYv36Tmzsy1vKJLlleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920213; c=relaxed/simple;
	bh=D4lAezz1Fe85IAGC56X4pGJ4Or5jTbAWiToJS9KUs+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZQ3bcWWXQ3JXIfpcx9tBEgpwo9WtBuxbi0pYj0AqgTVutU7x0lr985A7Ih5L/w+wwrJ4RkWE+IAkOtmPRX7lNZL1ZE3ZDpW8s76R0Htt+Ra1mjTfOy1lC1vnbG/YhXi8rem6UjbDh/UuKMbjPb4Alp2Wi5U3PYBEBmxvKueJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g1t4A1/F; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c213690558so427656b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709920211; x=1710525011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExG2PAh8KBxjdV5p9HMOJ0D9TzLucoEgJI4R5jjzcnY=;
        b=g1t4A1/F3VBoXhwgA47Z/5SI1la55bjbx0dPpr6r1kj06r8XTRuDs0GnXT3UqiyYx5
         0QJswKUHTruZxalRUFswV3qWq0O/nOHrc22YDEcAqx3KFFczwyPMZSBlMkEBWvbJUOhq
         e6ISKN2bOIG4yTohIPygo2XT1XJoczuCn7DyMTtjxBUBTJR/42CORcXW7hnZeFYZNzX0
         5deY0j3aUunes8ne1P0XFtdmb6sVtuR/3jnQPyQdBWyvv7KPw+9B088I+RJTPHBX0Mgk
         niTF7Wefk3Dop1xqg3+t2h1qXI5gtXdfFvauQ5xqVHADCYjGbpav+IuNgJsSX4Im9ob4
         oB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709920211; x=1710525011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExG2PAh8KBxjdV5p9HMOJ0D9TzLucoEgJI4R5jjzcnY=;
        b=bjxw1op4+jJOrC4xJ21SeWK3hqYDuIrFQO59P4luIS/jT8POJ+2iIFNbElVLg+8EO7
         czsFJ0JEVD669KFPvS7kyGJ4a57spkbera5pJmPfV+0eW9zcSnrwXaNajt7wAST3bjqJ
         YQrJg+StXtgG++Dk9pcqmIGhvrbYmRZgxlDV/A4ZaKM5UjBsGd6rlTU/BHfHwk6Jy6Eo
         zMp62x1NSnt2+MVtKQqLc9vB8qihBl/xtUM62kdAmQCG2egcU0peuo3W1CJWDfJ+Lu+I
         YrdfLDAAGjGYjRr5yXnSmflGMxCCCuIPCqt4Bu2KGtyhzCZEC/8X+55U2w+o7KcLoBmP
         rhLg==
X-Forwarded-Encrypted: i=1; AJvYcCWBJH+EmeP2zNDAqZcUaQ0fH9hapU8xnLJUxLUlqEMjA5w1YIC+kdNxbbRtI4pdnA/98GJWXB77cRWgoiJP4OXhWL+ytjVMz5N3zBoq
X-Gm-Message-State: AOJu0Yy8kkS4AmWQ9VJTesy2TAf5doRNW/IMsMDyKMkHZxafviWYMi3/
	S4hCpxSilvcnckH2tQ2gtAPx+TGQCAcVA83PdQEQ4s+LqlkqBmYpi1bXcCqCVBA=
X-Google-Smtp-Source: AGHT+IHqotrzjMlulGgfxn/O3daDWLB1M/i0FqmA6MZtfAe0W8HVLP0YT6jYEI77fyNP3sENbK2zQA==
X-Received: by 2002:a54:4781:0:b0:3c1:ebff:89a2 with SMTP id o1-20020a544781000000b003c1ebff89a2mr10704452oic.55.1709920209271;
        Fri, 08 Mar 2024 09:50:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id t11-20020a0568080b2b00b003c1f461d1cbsm1447808oij.37.2024.03.08.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:50:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rieMB-007Z0m-Os;
	Fri, 08 Mar 2024 13:50:07 -0400
Date: Fri, 8 Mar 2024 13:50:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iommufd: Add fault and response message
 definitions
Message-ID: <20240308175007.GW9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-4-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:38:58PM +0800, Lu Baolu wrote:

> +/**
> + * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
> + * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
> + *                                   valid.
> + * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
> + */
> +enum iommu_hwpt_pgfault_flags {
> +	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
> +	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
> +};
> +
> +/**
> + * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
> + * @IOMMU_PGFAULT_PERM_READ: request for read permission
> + * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
> + * @IOMMU_PGFAULT_PERM_EXEC: request for execute permission
> + * @IOMMU_PGFAULT_PERM_PRIV: request for privileged permission

You are going to have to elaborate what PRIV is for.. We don't have
any concept of this in the UAPI for iommufd so what is a userspace
supposed to do if it hits this? EXEC is similar, we can't actually
enable exec permissions from userspace IIRC..

> +enum iommu_hwpt_pgfault_perm {
> +	IOMMU_PGFAULT_PERM_READ			= (1 << 0),
> +	IOMMU_PGFAULT_PERM_WRITE		= (1 << 1),
> +	IOMMU_PGFAULT_PERM_EXEC			= (1 << 2),
> +	IOMMU_PGFAULT_PERM_PRIV			= (1 << 3),
> +};
> +
> +/**
> + * struct iommu_hwpt_pgfault - iommu page fault data
> + * @size: sizeof(struct iommu_hwpt_pgfault)
> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
> + * @dev_id: id of the originated device
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
> + * @addr: page address
> + */
> +struct iommu_hwpt_pgfault {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 perm;
> +	__u64 addr;
> +};

Do we need an addr + size here? I've seen a few things where I wonder
if that might become an enhancment someday.

> +/**
> + * struct iommu_hwpt_page_response - IOMMU page fault response
> + * @size: sizeof(struct iommu_hwpt_page_response)
> + * @flags: Must be set to 0
> + * @dev_id: device ID of target device for the response
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @code: response code. The supported codes include:
> + *        0: Successful; 1: Response Failure; 2: Invalid Request.

This should be an enum

> + * @addr: The fault address. Must match the addr field of the
> + *        last iommu_hwpt_pgfault of a reported iopf group.
> + */
> +struct iommu_hwpt_page_response {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 code;
> +	__u64 addr;
> +};

Do we want some kind of opaque ID value from the kernel here to match
request with response exactly? Or is the plan to search on the addr?

Jason

