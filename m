Return-Path: <linux-kernel+bounces-117238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DA88A8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F1C3672D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6A512FB39;
	Mon, 25 Mar 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="niS8Okqv"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD17F7C1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376443; cv=none; b=QSrcQhMJvnbUsXenmRfpbEOgR2zWH6NohpJj+SOCR7Dmf43ZmQRBdxgY2fFyJ9uLWgFq7Mb9iiW7Ixus9hsyOAQvAEQhkD5O1tB3UUaXDu0RwQSjFQhHOHkEcVmcU5QvqX6sLwrx9Z00fpUKEB8fru+Ull9UMP2zsiY0RZwoYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376443; c=relaxed/simple;
	bh=63TCN/grSYA1rWAH+qH7a+lfvhQsFmLttF5pjeCdXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW3hfbdaIRAjycQlUADPT7YClohD5QJ0WD8W0mtw+/920Ldz/VPGdq3BrHah4HwQik+/1oA/gqHKyZnBKly5sOl/aDQ3yMccDzm8x87B3ql3VzogWbKtRDp/Ohtjz/E893SyQzLsBVX9WAR10MnvuQayXJAFIP+L/EUQh9A+Oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=niS8Okqv; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78a3bccc420so209021285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711376441; x=1711981241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4khMi8YsL4x6qQRj8U1+7HQEKktCZ8TqyaiPDmkbrE=;
        b=niS8OkqvREAy5sfkqblXb7DquNydE4CioXOa7hGbfZQF1yxQ4qltJ+ByyKehTHMvPC
         8efjoZk/dQ3NrIbSJM6+TNMXxQiE2IcgKLuFwckAwk9eoJ/7X1cfVHwbCVcXy4C4RH1k
         Fd6kETk7w19wS0Mlv+PdT2qSsWyZGfoMUyeS1baiVjVIKgMDf7cgU/Fkgf8MNlhzTPc4
         Y8CgLv1oxcXBw/olWk0d480abcrQZtVx7XA0TDZMTJx4DZYEkpSX7Bjps46UlaCwRk3Y
         VXQ6sLZKy9kPdBIEAR/YITwBDpgqTOUUmVOYKfPqjxSuzwvaguOPCaOuKMDzMJZYBjrP
         YbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376441; x=1711981241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4khMi8YsL4x6qQRj8U1+7HQEKktCZ8TqyaiPDmkbrE=;
        b=uZqMwcVLuEJDR2d6f9zbcZLYEUAQxIHmx4LjYP3p50X43cd4gx4JQ+xnqyxYnGoSji
         tbiK/p2L3TIPSFg0umONu6oieNN+mdW53a/YAGLGdQ88aMMj7X3UJjKHSSKNSMC5wU+P
         cpJHf+Wx463S5QC7b2oAal3KSqI6adJGl4JNE6tw2NRYcGKQWmX9R1T2fOpy2bZdDdEt
         XY+IJ7Cc7OObIANbC7+SRgFa5Ljg0rL3HwNmwI8LzvlrCM0nnsht20loCnFva13rojVs
         cFHXoN2ORacR91D5I784eOkn0H+4tUk75c1TVrE3OhD+YM24NX8gK+Q9WJwnRaNJEkrE
         xYMA==
X-Forwarded-Encrypted: i=1; AJvYcCVxzRfwqMRCVyCCDcRlFMtcfjn/U9CWRpdQ67plk/FfX45P6kTmvov9fh0ud/1hzFeyjvkZ9YHaDG2L1XrzQYngQef+Z9otKQYtIsnk
X-Gm-Message-State: AOJu0YyKy2Udj87gyP6bIg7ZFOIfIK1httAWCzJd1wwZhDLng2r8D0ZU
	FaId6l2FKw+oBZC8PkABwI+Gt6s4cd8puhK9MTsQKzR3LTN6Z4RcnWu450VQqFY=
X-Google-Smtp-Source: AGHT+IEIDvH4aJX0QxV4yhRacQicWFP/ioH96fdSaZc4HTl73ipKGoKLrbARimpUoqXo7Z7Mj3Cjjg==
X-Received: by 2002:ae9:e64a:0:b0:789:e917:ac8d with SMTP id x10-20020ae9e64a000000b00789e917ac8dmr12632qkl.71.1711376440895;
        Mon, 25 Mar 2024 07:20:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ou8-20020a05620a620800b007882e204d45sm2170804qkn.37.2024.03.25.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:20:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rokgy-000ME6-0a;
	Mon, 25 Mar 2024 10:48:48 -0300
Date: Mon, 25 Mar 2024 10:48:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Bixuan Cui <cuibixuan@huawei.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: support suspend/resume
Message-ID: <20240325134848.GA8419@ziepe.ca>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
 <20240324-smmu-v3-v1-3-11bc96e156a5@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-smmu-v3-v1-3-11bc96e156a5@nxp.com>

On Sun, Mar 24, 2024 at 08:29:00PM +0800, Peng Fan (OSS) wrote:

> +static void arm_smmu_resume_unique_irqs(struct arm_smmu_device *smmu)
> +{
> +	struct device *dev = smmu->dev;
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	if (!dev->msi.domain)
> +		return;
> +
> +	desc = irq_get_msi_desc(smmu->evtq.q.irq);
> +	if (desc) {
> +		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	}
> +
> +	desc = irq_get_msi_desc(smmu->gerr_irq);
> +	if (desc) {
> +		get_cached_msi_msg(smmu->gerr_irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	}
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> +		desc = irq_get_msi_desc(smmu->priq.q.irq);
> +		if (desc) {
> +			get_cached_msi_msg(smmu->priq.q.irq, &msg);
> +			arm_smmu_write_msi_msg(desc, &msg);
> +		}
> +	}
> +}

I wonder if this should be done instead by converting the driver away
from platform MSI to the new MSI mechanism?

Jason

