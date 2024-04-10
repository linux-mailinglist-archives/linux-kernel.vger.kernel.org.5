Return-Path: <linux-kernel+bounces-138927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841689FC14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281C01F248AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F8016F0FA;
	Wed, 10 Apr 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HUqZcgbs"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A737156C67
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764538; cv=none; b=MUr7uh2hiQf1mSdoRm170ekI1kP+561Y2DVm0ur/gdMdvHALSarsmySSri26+FZSVS/Tk2rXyBlC+tww7NKoj46ZVpVbq0DJzxDs1kA2477IcJyzQ5BBpg9VFhig6mnDmUTSWLrPCHgmEsc2mD27ksLOGweQ1seNf3gN0I4uMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764538; c=relaxed/simple;
	bh=YgnL7jcir981RH55ITpvaqSgvPK1CEMYZBReNU3yk2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep5Z8KYDSR6y2vWYbbSaNleBTpdjhQiWOnShkWQfFHp2Urj6c7g/raRrkEzpS0LNEPYFGXjmNn3bmoCMWcUX8Ou8Q6TTf9Auz/zbzWSM++5lHSBpkXH37YLZL0lLoejdJ8RlMOUeVStA+reLliL7ATEwDczym/r8t3Vm06xKObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HUqZcgbs; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69629b4ae2bso54230136d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712764536; x=1713369336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXUImnNxV09JBTgxvo4M2YuJDwI+AB7aa82NvkhuYtk=;
        b=HUqZcgbsY1x825GpqKAYK7V7/QMuc0qq4XMVBEL51nRRTpI7uBTuciePECOa6oRqn4
         TwfY5jSta8ufvQLF9mfCd+oiY9qTXVdhEuZa3kensck4Iec4vLYl+SFRHXgBJiHw5WJf
         b492iC2Kwmucvhyxh6xj4Mc3uepDw44puE2ArZXN7MJGLrXO7nXkPS6qqOrFEjywZlE+
         CFHaNsgGcVvX9PMRLxFr0tWl2e6TIVyLOlQpVaurXJ7nQXYfzqeTg5NfKgBjTIiyOC+X
         K2fSK+AbjncykM9agFi2EkOyKvfxHL9785sWq1lh7C45w2hyINvvI/IaO/slKgleAICT
         H2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764536; x=1713369336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXUImnNxV09JBTgxvo4M2YuJDwI+AB7aa82NvkhuYtk=;
        b=MqLjGTRYjz8J9zlqDaxKBEp5pqhlLKENuWTLIOTRaejWyiScQrOhyfE1ypVaP2e2Pd
         DyHU+yx+UrowEvK73XicOF94q+LHIeILDQWXt9v4/U4QiocLxF9ZFhY73Leno1ezqcSS
         sa8gU4IOwFSY1zAvgnM8OX6+FXaqZIQ4FCZ7iw1x+2mumfeQQNo3MI7cxSU53WF1Ooy2
         dD7PC17DTBqzZFStQnXpHR8bzm90iFzVdDYSTxpXjlNB5U/sLjDPntuELdBOsRo0cp++
         lO+IrEtU8/Nw9HtL60nVqfyWwTWThXGeKOTMhgAq5eP5Vk8BlOZx0qJ3gbO8TUinrv0v
         8nLg==
X-Forwarded-Encrypted: i=1; AJvYcCXtP9nACiYwUCH+n/I7JQQPHJDjhYgewkupU72kCHchTteXOEIO2k6x15UoSmvlmKS9MgooIAribKYlDpEvotCgdPYMNyXoQUU6+edC
X-Gm-Message-State: AOJu0YxRZbUVUYspjDS1JOJhr2gHcBF/nnSjH+D8hMNrMusnApmAzZY4
	2m401sr0+d+EBj0uNn9eFjau8SIw0/eOpj7bvctbTAruOAE23vfd7J5Ee9Rh2s4=
X-Google-Smtp-Source: AGHT+IGnLTu8iKva5GUlMCiRXZBoEBA2BHf3PHT7xxCia8wpcTL3uQ+NzL/WcsUXgwErHK9GXqr3xA==
X-Received: by 2002:a05:6214:ca4:b0:69b:1930:6914 with SMTP id s4-20020a0562140ca400b0069b19306914mr2957329qvs.28.1712764536057;
        Wed, 10 Apr 2024 08:55:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b00698f7eb9997sm5233380qvm.54.2024.04.10.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:55:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruaIR-008Fb1-2n;
	Wed, 10 Apr 2024 12:55:35 -0300
Date: Wed, 10 Apr 2024 12:55:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/12] iommu/vt-d: Use cache helpers in
 arch_invalidate_secondary_tlbs
Message-ID: <20240410155535.GI223006@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-10-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410020844.253535-10-baolu.lu@linux.intel.com>

On Wed, Apr 10, 2024 at 10:08:41AM +0800, Lu Baolu wrote:
>  /* Pages have been freed at this point */
>  static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  					struct mm_struct *mm,
>  					unsigned long start, unsigned long end)
>  {
>  	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
> +	struct dmar_domain *domain = svm->domain;
>  
>  	if (start == 0 && end == -1UL) {

ULONG_MAX ideally.

> -		intel_flush_svm_all(svm);
> +		cache_tag_flush_all(domain);
>  		return;
>  	}
>  
> -	intel_flush_svm_range(svm, start,
> -			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
> +	cache_tag_flush_range(domain, start, end, 0);

Be mindful of the note from the ARM driver:

        /*
         * The mm_types defines vm_end as the first byte after the end address,
         * different from IOMMU subsystem using the last address of an address
         * range. So do a simple translation here by calculating size correctly.
         */
        size = end - start;

Given that the cache_tag_flush_range's are all tied directly to the
iommu gather API, this is probably missing a -1 though perhaps it does
not cause a functional problem here.

Jason

