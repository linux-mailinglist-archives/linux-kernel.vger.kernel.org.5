Return-Path: <linux-kernel+bounces-153920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196638AD4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA48E282781
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C115533B;
	Mon, 22 Apr 2024 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ozMTwlfw"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFE155330
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814265; cv=none; b=HRLkx+2osIrWsGm4Vq78piKNaD406MspNAxnFolRTQzEwxhAwGE8zbcb7duYqTg/lumSzggYk/yVEqTzckg33umwiXGTTT0rOaWUUf/ew8wau0Ox7K6baRzifTjDuX8RQZ+G6tsbkOj1dGdvdy/OnPqE5xHm4sL22WJHtgOArQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814265; c=relaxed/simple;
	bh=3uf88LX4hpj9MBbr+gHmp4PX3GIFmCWPggLOKfmTPMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNezCJrRLjgd+O64suD+4uXd5MqG3ngzVXw2nCrNm7GAOfYd/cGI7aqwMNs380SkehJrC0MalEcuEWlIQlsx+CIlULKHejYFKtcpcrwkvmgcnhzK1RAGgPu9tFClls425m9hbz6CvoGHwuXZj4N1Ex1joBwcxqbG7Tl78SPnflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ozMTwlfw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7da42caa377so208244139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713814261; x=1714419061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yh3rgiRcQXBNCIidxjhakiopwH4ays77o8Kd/hCbWDI=;
        b=ozMTwlfwZKB37Hb98oiOZhU/PNh/DBJlBuYXdzDa803v+k5PrriFzBTEJpCz7+iz8B
         D+ZTZa/WYx0Aer25Ax8TxoKhZq1qoT5YftQzH2bTVFQF4uNl+TjNztDpl6YW6lGnkebS
         flAq3a3ltNM8Oap3g1VOZ2ixYmzdKIGVdJ97HwZT372UOylqoefYlOWJS0ILyJb3iEiS
         5J0NRsIOm//wY7JnL5I1IQIzyx/Aa1vXMDMQDDe8wr8JMm3OmXcOCkQkPqIfuQdqpM66
         SEcA3FYKWmT+A1yOmnZGcMDU7I0tFjodyC7SOw8GO8jlMn5j7f7rzvgK/DexmbwA3a/d
         pIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713814261; x=1714419061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh3rgiRcQXBNCIidxjhakiopwH4ays77o8Kd/hCbWDI=;
        b=N6igXFhc+x7S6nuvAb0qWi7JdB2dtwnTBpsphDBB+ivriJE8x+IyfOhmOrfPA2gomf
         EekamyTBdteoVu3qJdpRjQn1ORYg0GAO8GY1urgdTa42Gu9IsawMsCmZhI+rYQoX2qsG
         G2H/TIWgQPOVPrwtzUNBIFuDubmpjgxSamyfR7kE/pWBpD4eKcDlG3hPMRcAKc4XFQpP
         wEsBlhMLtjgFjjSy83M8ABSnCqeQuBvSxEgi/dB2kD6NqrhqCRjEGDX3FXxwUTn0rwKK
         Zc8Uo2q8PFkD7bSj6QI8y08cXGWbLt26uiGaz/JFgZWswca/qJ9meJphB33cVKqE7aV8
         ktIg==
X-Forwarded-Encrypted: i=1; AJvYcCU9q6lDn2ezxG1c5OLWZWiMQuA/gubf2yadF6EdTV0ilrQAAFZD+yeUPi/EDvS5WZ/1l9M4H6Q8hRoCTX768bqezlnGulJ8XY/X20j9
X-Gm-Message-State: AOJu0YxCD79x9mI9W81mLNpIA/S36HEsqxCqWaxyR3Il8yOSRr6s9uTm
	dCiFxl6Q2POOsDosp5W3QkpqV+FGR42LgNk9MOFqPwnsDW04I3VjBxFomqdAiNQ=
X-Google-Smtp-Source: AGHT+IH895F9KLddG1s2eZCz4/bKHter3T6UNI8IsPcUq25R04uAGE5maPekZYiqnwm1PrKXKmatlA==
X-Received: by 2002:a05:6e02:b45:b0:36b:1868:fab7 with SMTP id f5-20020a056e020b4500b0036b1868fab7mr15663679ilu.15.1713814261611;
        Mon, 22 Apr 2024 12:31:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id u10-20020a0cdd0a000000b0069b60baec46sm4402412qvk.146.2024.04.22.12.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:31:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ryzNT-0015IM-Mf;
	Mon, 22 Apr 2024 16:30:59 -0300
Date: Mon, 22 Apr 2024 16:30:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
Message-ID: <20240422193059.GC231144@ziepe.ca>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
 <2f2750cd-a5bf-4486-8f50-c93d246f8b0c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2750cd-a5bf-4486-8f50-c93d246f8b0c@linux.intel.com>

On Mon, Apr 22, 2024 at 01:21:05PM +0800, Baolu Lu wrote:
> > +	/* Track domain to devices mapping. */
> > +	if (bond)
> > +		list_add_rcu(&bond->list, &domain->bonds);
> > +
> > +	/* Remove tracking from previous domain, if needed. */
> > +	iommu_domain = iommu_get_domain_for_dev(dev);
> 
> Calling iommu_get_domain_for_dev() in the domain attaching path is very
> fragile because it heavily depends on the order of calling the attach
> callback and setting the domain pointer in the core.

We have a couple places doing this already, the core code accomodates
it well enough for deleting from a list.. So I think it is OK to keep
doing.

> Perhaps the driver can use dev_iommu_priv_set/get() to keep the active
> domain in the per-device private data?
> 
> > +	if (iommu_domain && !!(iommu_domain->type & __IOMMU_DOMAIN_PAGING)) {
> > +		domain = iommu_domain_to_riscv(iommu_domain);
> > +		bond = NULL;
> > +		rcu_read_lock();
> > +		list_for_each_entry_rcu(b, &domain->bonds, list) {
> > +			if (b->dev == dev) {
> > +				bond = b;
> > +				break;
> > +			}
> > +		}
> > +		rcu_read_unlock();

But now that I look again, this is not safe, you have to hold some
kind of per-domain lock to mutate the list. rcu_*read*_lock() cannot
be used for write.

Jason

