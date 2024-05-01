Return-Path: <linux-kernel+bounces-165362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F18B8BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D284A1F21D81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70AE12F368;
	Wed,  1 May 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kCG3zPe0"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CF12EBEE
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573061; cv=none; b=EIGmky7dco6lyt/Gsai86MIuRK1Ab4vCmjk37OlX16yPN4sJUEwCRxAxRMaaub9zYXFil27wAtABVIBxA4L0wc+nXXBlc/Ez9GJ6UR3jRMdeiEFXNUl63lK33mft9mLoe05JN22PsA9BAp0gZr7AFK8VCniDFgjfKL61dXc/nME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573061; c=relaxed/simple;
	bh=McZ0JXWkmIU34gRskou0jhystrqelVQo23cGQ5KD7YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BClrdalmVywsF/nGsNgUd2pJp9OO3JDmv2t5l4Z2YoQyz6AcL5n/RONJYYJ81H+9MlCbCYfmJiX6wyPjpu58drdokQa9vX+oaLV8wWVh0RQM19Qrj46an2vkrnkhnj5DCqkgBpYsi1mmmxIDoTJqPiNr3vjdn9u9Ufxl2k0x3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kCG3zPe0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-790605809cbso601511185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714573058; x=1715177858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=McZ0JXWkmIU34gRskou0jhystrqelVQo23cGQ5KD7YM=;
        b=kCG3zPe0l+QV43H+NGjs6YvffMUOpxVrBFXl26Ch1EC+NJJRxhtMlXtL8vurIrbZnN
         rw8D4fTa8IvD73Cxk0MV+zYC2GeP44Izq/aV/09v7rsdoc0Bv3S4iCWkKzNfpRQ0LnCS
         YlzOORvfJf0KvUKbeJcpCHRUAIaX5LBGqxVmuU/9YWVZJ5hmVD3CP2bZAZ5y7n5FYUvR
         BB2KXJD/QBUapHZagA3fVyAnVVZJg9t3yfeE6GNbhI6JzRicvXhmPgtpWPSr+4kqcmAx
         Zr6aLcZxE2js7aiDfVfK+sjfLCRzjHd6mO9dwmtFVTlVAk/WfYw1CSD/Wa0hDhagAgMI
         35Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714573058; x=1715177858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McZ0JXWkmIU34gRskou0jhystrqelVQo23cGQ5KD7YM=;
        b=B0CMZUDda/ZFMeee9w+eAsKfN6QbtDGK03Sq8LPfzmnJUezAyppE6/RY6nT7NteF6v
         u1kqq5d5nf+LzSYlQdYny6CSbCbIlXpyinxICwuXz+jHLblakVta+0mKCoIPRTDEg7NE
         8PiLMz/vmlu1B7adLj3hZNjWPQyfcOFcqMSnxF/004dIE5tylO3C/WkCDkx0uapbGbLD
         Qjik20yQGI0nL9vANTfbOvE/1F3FVqP1/I2amIyfkNEv9U2Qs7BrperJICn0J647KyF5
         DS2HQFGDeaQTL0BY5Cgduaq6REsZIoYwPg0mVlCKz284zzRmF95nWqfMwI+RcZ+EMNtA
         elug==
X-Gm-Message-State: AOJu0Yx7r5u6Uwy0ziNKiuSo+Pljc1WBkFOfoKFiAdbhPWmw6f3ZO8Tn
	SiluD72L2qYldIy5j0dINUG+OrKRkK48U2sjhoZd0i/ifMrIvYWeTHsLzoZMBfc=
X-Google-Smtp-Source: AGHT+IFwnbV79fDvZ96M7alsio2h8eMlQXeEgKJ8b2nHbiez1qQwf98dejV4NtLT3Yi/fqMqo4Q0vQ==
X-Received: by 2002:a05:6214:f03:b0:6a0:b6a9:39b0 with SMTP id gw3-20020a0562140f0300b006a0b6a939b0mr3028929qvb.59.1714573058580;
        Wed, 01 May 2024 07:17:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r1-20020a0ce281000000b0069fcd0520easm8965463qvl.17.2024.05.01.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:17:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2Am9-00DRt7-CM;
	Wed, 01 May 2024 11:17:37 -0300
Date: Wed, 1 May 2024 11:17:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
	jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH 9/9] iommu/amd: Set default domain to IDENTITY_DOMAIN
 when running in SEV guest
Message-ID: <20240501141737.GB1723318@ziepe.ca>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-10-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430152430.4245-10-suravee.suthikulpanit@amd.com>

On Tue, Apr 30, 2024 at 03:24:30PM +0000, Suravee Suthikulpanit wrote:
> Since SEV guest depends on the unencrypted swiotlb bounce buffer
> to support DMA, the guest AMD IOMMU driver must be force to setup to
> pass-through mode.

You should block the creation of paging domains as well if the HW
can't support them.

But, is there actually a functional problem here? Doesn't swiotlb work
OK with iommu even with the encrypted memory cases? What is missing if
not?

Jason

