Return-Path: <linux-kernel+bounces-17916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EFC825514
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76E81F23B49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4AA2DF68;
	Fri,  5 Jan 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RsnRLGyf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B272D7AB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4283670b6e2so7974711cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704464331; x=1705069131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G64TENF8v9XGLMF69sUXWJ1UUFiz/bDgs2qLPj0J/K8=;
        b=RsnRLGyfK+K6L18YmPcE/82Bgpoc72gk78awYDZ51zkbyxXfrHTDyJSLRwRWhS80JR
         KNNLG/ZztV3U0B2VAf9UAgxdYc5IOGI8V5r9xz9gsMfrmeLcvULtWrOE3sYmC7ovL0gd
         N7WvNip3l9Tn+FHBJ8QJcfy7aSaBgdySR5Ee8ahDPEy1YR+3FPlptIuuakvZQRip+tM0
         FNyspeAUJMq60dE2g90vJcMvw31qxpg2UQktz+5kHxF2BJmikO89yosg6t1rtfxDjevK
         4JmF3vDscJzabjem3+EDH8UiRsdsnf6H554mDMz4j7jb0BMv8ZL1RldQ1BTNKuwpLar/
         v3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464331; x=1705069131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G64TENF8v9XGLMF69sUXWJ1UUFiz/bDgs2qLPj0J/K8=;
        b=bKHLD2+73VXEEPPM2WWtq3IEQFQvTfTeah79NFnKiLmoV6Uk9g+1MQrYhmguZ4fX9t
         FoY1SEftcx6FxzCQo0lyBiinXejSuCQeTHvm9SANtbOhRfKvcLChk3vDF1VYpDht75m2
         0/6GvrZ3nRJmTYmQEEfW/xk1xFTubcXImsz2sLRRK2XTyO4lA0H52ztddQj9Jq6D0UUe
         ldSVzpbUGPOzcw4VHpCt60/hTZTW+IzomGNq0eYPUWe10umsNL8tC3KYT1ZczjQY9P2y
         djjqdNLWiGdB8DlX0RGZRO3MDo5gH8a8NKk4/DEtAddpFfSZXl+wBZik5pOtP48NPzR7
         FiYA==
X-Gm-Message-State: AOJu0YxbUL0qAzv1RVqCplpbf1IgnFjkKOoaDZt1d8xcaTUjbHRjMz78
	w4RhnfHChcJZw+9r79gCdL95ibqHXn/mzQ==
X-Google-Smtp-Source: AGHT+IG5ezNj2ozGQN7mLlu76eVGBnmJM5hLjNLkeekZED1XSWHOk9qiReFc/mTuzs7pX2+tLmC3yQ==
X-Received: by 2002:a05:622a:138e:b0:428:34a7:4b89 with SMTP id o14-20020a05622a138e00b0042834a74b89mr2235497qtk.14.1704464331608;
        Fri, 05 Jan 2024 06:18:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bb23-20020a05622a1b1700b00427f358116csm750905qtb.10.2024.01.05.06.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:18:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLl29-001OwX-QR;
	Fri, 05 Jan 2024 10:18:49 -0400
Date: Fri, 5 Jan 2024 10:18:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 4/6] RDMA/hns: Support flexible pagesize
Message-ID: <20240105141849.GE50608@ziepe.ca>
References: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
 <20231225075330.4116470-5-huangjunxian6@hisilicon.com>
 <20231226085202.GA13350@unreal>
 <fbd65691-b0a2-0963-96fc-7e09a66cd203@hisilicon.com>
 <20240104202902.GD50608@ziepe.ca>
 <3d4cdc2e-0053-f486-7323-72127027886f@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4cdc2e-0053-f486-7323-72127027886f@hisilicon.com>

On Fri, Jan 05, 2024 at 01:55:11PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/1/5 4:29, Jason Gunthorpe wrote:
> > On Tue, Dec 26, 2023 at 05:16:33PM +0800, Junxian Huang wrote:
> >>
> >>
> >> On 2023/12/26 16:52, Leon Romanovsky wrote:
> >>> On Mon, Dec 25, 2023 at 03:53:28PM +0800, Junxian Huang wrote:
> >>>> From: Chengchang Tang <tangchengchang@huawei.com>
> >>>>
> >>>> In the current implementation, a fixed page size is used to
> >>>> configure the PBL, which is not flexible enough and is not
> >>>> conducive to the performance of the HW.
> >>>>
> >>>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> >>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >>>> ---
> >>>>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   6 -
> >>>>  drivers/infiniband/hw/hns/hns_roce_device.h |   9 ++
> >>>>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 168 +++++++++++++++-----
> >>>>  3 files changed, 139 insertions(+), 44 deletions(-)
> >>>
> >>> I'm wonder if the ib_umem_find_best_pgsz() API should be used instead.
> >>> What is missing there?
> >>>
> >>> Thanks
> >>
> >> Actually this API is used for umem.
> >> For kmem, we add hns_roce_find_buf_best_pgsz() to do a similar job.
> > 
> > But why do you need to do something like this for kmem? It looked to
> > me like kmem knows its allocation size when it was allocated, how come
> > you need to iterate over all of it again?
> > 
> > Jason
> > 
> 
> kmem was split into multiple small pages for allocation to prevent allocation
> failure due to memory fragmentation.
> 
> And now we add this function to confirm whether these small pages have contiguous
> address. If so, they can be combined into one huge page for use, which is more
> likely when iommu/smmu is enabled.

That seems unncessary. The chances you get contiguous pages from
a lot of random allocations is really slim.

If you care about this optimization then you should have the allocator
explicitly request contiguous pages with high order allocations in a
manner that quickly fails and falls back to PAGE_SIZE.

Then you just use the size that the allocator was able to get, not try
to figure it out after the fact.

Jason

