Return-Path: <linux-kernel+bounces-121819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096A988EE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC951C32BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3619014EC70;
	Wed, 27 Mar 2024 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o+7sWy4q"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9BB14C5BC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563654; cv=none; b=GZEhGL34AoahV4ZmBVngMM2bqVhv8XJkpyhpzlnRJtrSghDO9ENxjxoLoejj/olotOrnLfFrkBEPSeXCQSl+xCg3VzEKqlki+l+q4569sLE1xMsXNneMNarOpAUcnn8gbF+r/jqA31XPK8vxGV+sZ/mw05kgxxQGzKGugniPE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563654; c=relaxed/simple;
	bh=OPBDvQItJX4Hsvo8moNWtE2pEEwwXpr13o6Pqef6OaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbiyrthzE7iXQ9vFGNG0EyTBbscA42YGpGCQw9ZSHgBLN53xThfJk2UMzyrt0yYf/CwBecoxfPfy7NQznI+35ImOVo9ZyhNTICbPYHBBg5jjCiL82Cmci59AGLg+UmAhFCVDK4W39MmDuDc4kSinTBlfdwOaZMroqeGzov2wcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o+7sWy4q; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2282597eff5so123655fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711563651; x=1712168451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1XPHV72zhMXJ02AuGc5L64s8C1sqQEkTen4d+KPBBI=;
        b=o+7sWy4qzBUQ9IimGD582uGTlZgGps4knRneJpd40/mxrSd5w5bXFXS8m9HklTT8B3
         FRMbOaDVaYurxMBjLuLD4pGUjozE4/zbQRRny5UO9ccI/hosrZH+wBbWoQxdhDge09Ho
         xuRrasJrQhWviCtnFK7UzqXKVd0w4F/wXy+rsvJTTw9kxaj2MA0/Dt+gF02sLiwJ5OaB
         nMYzXUYIJfQKh2qBtvToQ9uL/ZNZAXmLP4Uu1pbwaGeKDmV9PDolZfSOSfeflWG5g4gH
         ZHkeZbuGXfehOZxZ6zg2PuMhg7sAFyv7d71a5d7iEm5DOpCgQQnCfhDd9BX/xRUPRMI8
         EYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563651; x=1712168451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1XPHV72zhMXJ02AuGc5L64s8C1sqQEkTen4d+KPBBI=;
        b=CvVl9XCWoJvSHAHLBelH3QeCwMcCnmWR0mzc82qHEitk72s4eLPf4px+ni/JZT8hyX
         Rkp2/5ga71zilywnCxLVxH6eaFjXxqDz+XlfdzAnXTH/jnu3TvdZy+xsg5AFDbaQ4G9T
         qy+A4VDyFdfgEjsvDsy3LMpLkw2nmB/WtUq/1a3rSM/CnzCOIZocr0CEUf/MvT7lTuvR
         zFrxHX8SOpPOoWgVfKXTrEJe3UUF8f3w7qd/iS8aB/6Yn94AGYD9mDrHD5noF2Xe9U7u
         iHM5LD8ZO3GrIqIeoXXcL2ZjGeXVon3yv+bK1KqHBAtKs9pdo2Zlfa8eYW2z9dFvHYS5
         6u/w==
X-Forwarded-Encrypted: i=1; AJvYcCUizqUj1zXx6fwKthc3Gi6bLM9atbQDtR1frWDpOfp/e5jWkjeicrM0/zOZVlGLCInM5IGQRg+ubvXZm+RVfbgOQNyzJwqS05o7ueI2
X-Gm-Message-State: AOJu0Yxk/Xa6Hy+kLaamVplBZf6E2zE12tUMrw+ztnxOSPCDygXSExI8
	4wS638n1YpsHSTqWPasppbsYgmxHMO5/ZxLeSSRud1bF58JehXPMg7sPv28SojE=
X-Google-Smtp-Source: AGHT+IGlQgJN+JO9e8sS/bsKvnN/YrOMwN05dTpPaEA23DiNm5LU+yVmVBI9B2EsLHVZQZQjT85IeQ==
X-Received: by 2002:a05:6871:4199:b0:220:be34:7ee2 with SMTP id lc25-20020a056871419900b00220be347ee2mr593358oab.26.1711563651410;
        Wed, 27 Mar 2024 11:20:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bs8-20020ac86f08000000b004317485a4e9sm1682338qtb.66.2024.03.27.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:20:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rpXtK-005ior-EV;
	Wed, 27 Mar 2024 15:20:50 -0300
Date: Wed, 27 Mar 2024 15:20:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Nicolin Chen <nicolinc@nvidia.com>, kernel@collabora.com,
	iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240327182050.GA1363414@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
 <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
 <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
 <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>

On Wed, Mar 27, 2024 at 06:09:37PM +0000, Joao Martins wrote:
> On 27/03/2024 17:49, Muhammad Usama Anjum wrote:
> > On 3/27/24 7:59 PM, Joao Martins wrote:
> >> On 27/03/2024 11:49, Jason Gunthorpe wrote:
> >>> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
> >>>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
> >>>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
> >>>>>> Even after applying this config patch and following snippet (which doesn't
> >>>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
> >>>>>> finding failed tests.
> >>>>>>
> >>>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> >>>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
> >>>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
> >>>>>>                    mmap_flags, -1, 0);
> >>>>>> -       assert(vrc == self->buffer);
> >>>>>> +       assert(vrc == self->buffer);// ???
> >>>>>>
> >>>>>> On x86:
> >>>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
> >>>>>> On ARM64:
> >>>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
> >>>>>>
> >>>>>> The log files are attached.
> >>>>>
> >>>>> You probably don't have enough transparent huge pages available to the process
> >>>>>
> >>>>>       echo 1024 > /proc/sys/vm/nr_hugepages
> >>>> After making huge pages available, the iommufd test always passed on x86.
> >>>> But there are still failures on arm64. I'm looking into the failures.
> >>>
> >>> Oh that is really strange. Joao? Nicolin?
> >>>
> >> Definitely strange, I'll have a look.
> >>
> >> So it set the expected number of dirty bits as that assert doesn't fail, but it
> >> is failing when we check that even bits are set but not odd ones. Like it's
> >> hasn't set those bits.
> >>
> >> For mock tests there should be no difference between x86 and ARM assuming the
> >> typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
> >> that I can think of that affected mock domain.
> > The config is attached. The defaults are being used i.e., 4k page.
> 
> Looks like CONFIG_IOMMUFD_DRIVER is not defined :(
> 
> Thus no bits are being set.

Oh! 

--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -37,6 +37,7 @@ config IOMMUFD_TEST
        depends on DEBUG_KERNEL
        depends on FAULT_INJECTION
        depends on RUNTIME_TESTING_MENU
+       select IOMMUFD_DRIVER
        default n
        help
          This is dangerous, do not enable unless running


???

Jason

