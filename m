Return-Path: <linux-kernel+bounces-75180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B185E457
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79A01F25A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053C85283;
	Wed, 21 Feb 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gNeYemjg"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32683CCD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535838; cv=none; b=YNSnpo17LUgZmFCxYwRJYJ9BBQLl1oMLHBmHMTZ9iF/0b4PCBLF3ONPdXrXcpidOBaGH8W9UggO633Z3p/QBw1v1INzlX5AGNFLbqWX2BZrH57qP3GeA1O0tFmA6v4dcQ8ypjenOvw0EDPn9IOFyVAbKdska6SpGPzIla9SHKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535838; c=relaxed/simple;
	bh=I6khES5n4Q3QFdVdyokl8Q9e06u0EkQGwP83hqJGXFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKNO+kDvaqYV6dS5L5SD1kWDyY9eUum9ck3pi5EorLs7ue5wE+gcTiGe0bdzjIHtNDVbt3lWtzEepDMqG/Oh8pNIlW8pOc3wjL0/+5KxGPrpo1hb46yKJ5mPp++lUzGbzeJhdUXVVwbeTv6hZSJtMaJGXtGeLha2N7z3joy9F+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gNeYemjg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7872bc61fcbso361615785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708535827; x=1709140627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogePN8RGPDLuJ8HgPA1acfWfYqARY++z+F4K2/vUf44=;
        b=gNeYemjgTCtIghiRykd5AJj7P15cQPbSi8uQ+oW0V/VL/LHJf1bOut6YXqafdPVW0h
         GPt3FI2c8G6xWvPJOP8E7yhF77a/ANdo+gLAnvAkeSKhn+QMZwiltjQLmiCFEyun3ael
         tLps/lpOg7CvLI7N39ukutjiLXPbCktXMXYeEAt7hjDG5p12t5ZM7wf3M1xNQqFN4Lmy
         EkH7EPlkpR4uMl8qyinhxILMXe51/H7ydDkWgGHqrUWeiqKh4w2hVvcfBd3A3THlojtc
         lbxRDVMMstiWL93ogtD8SNkxaDWd2JaqAuXyo2yZQXjKILIMJBJFcD2ybfClfulaRqMN
         D3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535827; x=1709140627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogePN8RGPDLuJ8HgPA1acfWfYqARY++z+F4K2/vUf44=;
        b=OQW08c4K7D8t5hjAWowm5eXo5ul15u7GHDPFKzT+ZpFziE1lvXDbWS3avBSDfckSJs
         Sl5ibdqLaScayaq5/yfF6CM28BcnuHih6A3KYzZ6aMZA1hLA2lJb0blQt2w09E4XNtrP
         92zVYVWaawYlVkbXAqdhXatcP7hDvZxFusOcivwvB8V2gaKwhtoLmidpuNFb5e/vXmks
         JmN2nweI/CZoAE6h/5v+B0qLfKN0arKG73f1bEn4tAuRHvI3nCpcHjkIJgOVqKR4BX03
         Fytu79/j3eK6VvAx3MajACuotxTnAE3yn3eLnLepS6v+KbosC4hUbvvVpY+8U83pE/3q
         ztEg==
X-Forwarded-Encrypted: i=1; AJvYcCVIVgc1KVsgQvDus6fqOWp47FiyLvTL3wzZP7BdLEzoJueoiAJqJvMXkFCxMUlqsni5u9UnvBjT06uZHvWy0aIf3XpsMV8d2PywG8OO
X-Gm-Message-State: AOJu0YwHbYfal/PRYaJE4Nwy0p7diHLR7QOo+H5RG5GFr3XOuVdhuCJ9
	VE4Nhc2qm2Sa676VSnGgjoK0tMeyJ8ZzimfzkfgcCP3VQwN0C3zObWORIlQLcJ0=
X-Google-Smtp-Source: AGHT+IGuLuRpN+PTHBd7RaoAC+337L4NDMA++7+ttpW3UAa3hMqKYB6SUPKqh3Is4Ey9n7T+xmMITw==
X-Received: by 2002:a05:620a:1135:b0:787:3ac2:15ab with SMTP id p21-20020a05620a113500b007873ac215abmr19169877qkk.37.1708535827123;
        Wed, 21 Feb 2024 09:17:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id l8-20020ae9f008000000b007877add9363sm1479378qkg.103.2024.02.21.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:17:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcqDR-00Bmeh-LZ;
	Wed, 21 Feb 2024 13:17:05 -0400
Date: Wed, 21 Feb 2024 13:17:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shifeng Li <lishifeng@sangfor.com.cn>
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ding Hui <dinghui@sangfor.com.cn>,
	Shifeng Li <lishifeng1992@126.com>
Subject: Re: [PATCH v2] RDMA/device: Fix a race between mad_client and
 cm_client init
Message-ID: <20240221171705.GE13491@ziepe.ca>
References: <20240203035313.98991-1-lishifeng@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203035313.98991-1-lishifeng@sangfor.com.cn>


On Fri, Feb 02, 2024 at 07:53:13PM -0800, Shifeng Li wrote:
> The mad_client will be initialized in enable_device_and_get(), while the
> devices_rwsem will be downgraded to a read semaphore. There is a window
> that leads to the failed initialization for cm_client, since it can not
> get matched mad port from ib_mad_port_list, and the matched mad port will
> be added to the list after that.
> 
>     mad_client    |                       cm_client
> ------------------|--------------------------------------------------------
> ib_register_device|
> enable_device_and_get
> down_write(&devices_rwsem)
> xa_set_mark(&devices, DEVICE_REGISTERED)
> downgrade_write(&devices_rwsem)
>                   |
>                   |ib_cm_init
>                   |ib_register_client(&cm_client)
>                   |down_read(&devices_rwsem)
>                   |xa_for_each_marked (&devices, DEVICE_REGISTERED)
>                   |add_client_context
>                   |cm_add_one
>                   |ib_register_mad_agent
>                   |ib_get_mad_port
>                   |__ib_get_mad_port
>                   |list_for_each_entry(entry, &ib_mad_port_list, port_list)
>                   |return NULL
>                   |up_read(&devices_rwsem)
>                   |
> add_client_context|
> ib_mad_init_device|
> ib_mad_port_open  |
> list_add_tail(&port_priv->port_list, &ib_mad_port_list)
> up_read(&devices_rwsem)
>                   |
> 
> Fix it by using down_write(&devices_rwsem) in ib_register_client().
> 
> Fixes: d0899892edd0 ("RDMA/device: Provide APIs from the core code to help unregistration")
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Ding Hui <dinghui@sangfor.com.cn>
> Cc: Shifeng Li <lishifeng1992@126.com>
> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
> ---
>  drivers/infiniband/core/device.c | 33 +++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Applied to for-next, thanks

Jason

