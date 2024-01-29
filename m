Return-Path: <linux-kernel+bounces-42946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46865840922
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794751C24C54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE36D1534E6;
	Mon, 29 Jan 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kArXEvxu"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF12152E11
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540257; cv=none; b=CnJ1GBqAP3anmWfiMugMlA4M3UOZabpKX8K15f33E4IbRJAGWLzvL6RFjgIY4fqwyBnzfPvvU1q/LqtETLyCU0MWIAjQym1vWzZJbwjvtlvqiHIoWKEZPpJ3sg8eXIxSyjKL9OlR+dcKuUT8YiazIyYJ3nNVxPp4AQ0XRyB/3X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540257; c=relaxed/simple;
	bh=YHpJANTxleXUQc7Etefu3WOAFvTm2NiP/au00SDkl2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhMAq1rp52HM520ZSFcCtBqJEh0r9WFhCeF79BoG7j+rXYG5+S3RG37qK8zbk45qeIcjgIt9oJjd6jN12MZvXPCgygDa05ZwfQ9aAqVZzSbz9cBrgREiLHU3dI6A6+aj78xGFetOA+NaBuT8koDdddv1QIlirbJJUWllPPDbmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kArXEvxu; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3be6df6bc9bso349879b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706540254; x=1707145054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVF4k3bK1tmVpRSxaU3/SMcZMqTGWrDu+a1szTYxZBs=;
        b=kArXEvxuVVYpogZL3Mfjos2nqq2ipEdLbGxddNiJzkVgXtkjaEhTFAJEqkABi+oJeH
         e+MIwTe3H1xphiJUZT989MVpP+Cj+bj/rVjlB9lCGMRgVKHmNBQhs7Xgg/OtZWqXLSJv
         jrL7G8to3BJllL2g0y5dHfnNAr74WlklCNNQpGZgjrs2h7Xfp2ve2GKF4WOj2c0ezrY/
         TSW80sYEZmVQqWiR8+iwFKxgF1WPpDJ9o2TV6OMaJZ231y2iI4OMBmkiCObpMjppC0NP
         ry1L03/2QH9ptY9SYBo07MX6VespBYUE7SPptU038VExn0sHCfUuADiZWU78LQ95xwph
         IPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540254; x=1707145054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVF4k3bK1tmVpRSxaU3/SMcZMqTGWrDu+a1szTYxZBs=;
        b=ZSiuyymJ3nJgsPp5ZJG8aLT3Nv/sr1Wi4/6sgK8/lURI5lzx67VN4D/qOl0rPQ2MNf
         mQAw+3yFS3WaZVcSVv+CEpmX3fu+0nKf7FgZTimMhIs3ZW9wLvJv8b0uSwDPhEd9bSI7
         +9xkO6BH+Ump8iRXaj/dWc4kUFf9I6L/8bo5SjafEY1sOAgNRyC1yMKnETaXcVVFUNkX
         6D4pxCo2cQYRz19CjtrUe3ImftafHSqZ7eubZK9qERXu2k5eXUtHU3CLSCAyNhAlBlPs
         TD5+IOFOKifJBacPtP4CJn8ob7dlQZYsZQf9xBWPukugZCpODb3+CcBwBSSvOJepqjCE
         v4rg==
X-Gm-Message-State: AOJu0YwD8eOpJyxiJiPCNOMwKZjpaFglWK0LhfN32SlV/3wvhzE0On0w
	IoaTeUy1TgFY/00suREuAT2OMOeOTn2A4KxeMrdf0khMCJ2zl+GQ1NuieN0TQ0Q=
X-Google-Smtp-Source: AGHT+IHM0UgiqzxE42+B8o1wd1JtnMkZnMEzc9DwbMI9lJHOkViPkWLsfI2IUYUXYItE3p/l6Rn1Ag==
X-Received: by 2002:a05:6870:d287:b0:210:a68b:7066 with SMTP id d7-20020a056870d28700b00210a68b7066mr4254363oae.43.1706540253754;
        Mon, 29 Jan 2024 06:57:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ry11-20020a056871208b00b002149bb5d09asm2064275oab.56.2024.01.29.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:57:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rUT4l-00A9ie-VM;
	Mon, 29 Jan 2024 10:57:31 -0400
Date: Mon, 29 Jan 2024 10:57:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iommu: Use mutex instead of spinlock for
 iommu_device_list
Message-ID: <20240129145731.GD50608@ziepe.ca>
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
 <20240126105341.78086-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E9618612DCF4DAE0CAE68C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E9618612DCF4DAE0CAE68C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, Jan 29, 2024 at 08:04:35AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Friday, January 26, 2024 6:54 PM
> > 
> > The iommu_device_lock spinlock was used to protect the iommu device
> > list. However, there is no requirement to access the iommu device
> > list in interrupt context. Therefore, a mutex is sufficient.
> 
> I don't think that interrupt is the reason for spinlock otherwise
> spin_lock_irqsave() should be used instead.

Right, there is no touch of this from an interrupt

I suspect it is following the the general kernel wisdom that a
spinlock is better if the critical sections are very small.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

