Return-Path: <linux-kernel+bounces-17198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B39824992
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F19F1F24521
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23FD2C6A0;
	Thu,  4 Jan 2024 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RhmouT7p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8E2C69A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-781b9922f44so51641185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704400152; x=1705004952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Js6JSpUmigYbW6w6fgAM+QgqXQNUIDobYA2AIx1gbcU=;
        b=RhmouT7pE+7OoKHkS2N3bEsRfn1WJNFm4Tot8uaPx5yW9rDRu7phJ2UQ/7t4yAhV/k
         BYNtpqNxflfP6F1pxdbb5s7QpAV/jsIF67eTV/9vVyRcFYjQi0R0TPzdHRHjz1JqZ2AR
         yRaAGcYKBvyQb8ds5sdq+ZmcAMf1rOVhnNV//NElJW5ZBnOMYlcBkp3rlDSv2zAfUJB1
         WwmyJ9o8dU3eerPnw9sBqwYvCX4layZMBRZ9VObM6b5EVuXdGSeAl8QAZOeow8vVbP9N
         iSf0QG8PwHn+5x5yAcMQ7AVGASIJ6ZQV24WZoHGrkgDhqPzOnB+besUj8N0WVyFyO+Wk
         1SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704400152; x=1705004952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js6JSpUmigYbW6w6fgAM+QgqXQNUIDobYA2AIx1gbcU=;
        b=Tty6JbP32eRE01AS6tGtPFY6JfbBxrugVFl82a9RAzt4+pRBpN3+by84dhNSvg9JUC
         DtggTp78TvDfcBvgnmhiJQOx5yXg606GMT9CRPI77ybovxCLiBfKNgTPc8MuZSHax65X
         QrE6G/brNxRI2+r8owBjaJwNvlfkErV7RnMIeH+1/aBZGFNVTlsDbFlp88o2G/qB6JQs
         JqNHyT8BdfMjWM9TU1ULdLMG0geH2klrv30H12ImAK+cKuq5fxxnt8YQWWTVjB8Grf/C
         +j0vjyF7OK63oJ56WDF21uax+3lW06PaD8S6+oLwmlKmwl494bn5NTBXRztZrGM8VD9i
         yclw==
X-Gm-Message-State: AOJu0Yzl2mtEwt1MfaRkY/2NcXZg0hXY9KP1t14EdjnYFOA+Rmzl3Ejp
	qKSKtxLI7bW55zMVHbzr19ovl9jMhaJH/Q==
X-Google-Smtp-Source: AGHT+IFHA7MyY6SluE5Lmfef+n0mZa0GrfDdvhlhI7a5zI3AOX5Y02JTsMjZgV59//5Oh7B0nRArXg==
X-Received: by 2002:a05:620a:8517:b0:781:30a1:62e0 with SMTP id pe23-20020a05620a851700b0078130a162e0mr1198421qkn.32.1704400151951;
        Thu, 04 Jan 2024 12:29:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bk8-20020a05620a1a0800b0076db5b792basm63070qkb.75.2024.01.04.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 12:29:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLUKs-001GcK-1n;
	Thu, 04 Jan 2024 16:29:02 -0400
Date: Thu, 4 Jan 2024 16:29:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 4/6] RDMA/hns: Support flexible pagesize
Message-ID: <20240104202902.GD50608@ziepe.ca>
References: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
 <20231225075330.4116470-5-huangjunxian6@hisilicon.com>
 <20231226085202.GA13350@unreal>
 <fbd65691-b0a2-0963-96fc-7e09a66cd203@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbd65691-b0a2-0963-96fc-7e09a66cd203@hisilicon.com>

On Tue, Dec 26, 2023 at 05:16:33PM +0800, Junxian Huang wrote:
> 
> 
> On 2023/12/26 16:52, Leon Romanovsky wrote:
> > On Mon, Dec 25, 2023 at 03:53:28PM +0800, Junxian Huang wrote:
> >> From: Chengchang Tang <tangchengchang@huawei.com>
> >>
> >> In the current implementation, a fixed page size is used to
> >> configure the PBL, which is not flexible enough and is not
> >> conducive to the performance of the HW.
> >>
> >> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   6 -
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |   9 ++
> >>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 168 +++++++++++++++-----
> >>  3 files changed, 139 insertions(+), 44 deletions(-)
> > 
> > I'm wonder if the ib_umem_find_best_pgsz() API should be used instead.
> > What is missing there?
> > 
> > Thanks
> 
> Actually this API is used for umem.
> For kmem, we add hns_roce_find_buf_best_pgsz() to do a similar job.

But why do you need to do something like this for kmem? It looked to
me like kmem knows its allocation size when it was allocated, how come
you need to iterate over all of it again?

Jason

