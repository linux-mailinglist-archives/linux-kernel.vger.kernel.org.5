Return-Path: <linux-kernel+bounces-17917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB7825517
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F6B1F23C03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD12D7BE;
	Fri,  5 Jan 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AzKz6oEn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282E2E3EB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bc0fe6e60fso1053888b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704464387; x=1705069187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DsKBPt1K3dp72jnnoUQSgV5XP7ynD+rz6hhuIBxWAk0=;
        b=AzKz6oEn4xEdANTzpyNVObV6F0VG/cgXnU14fd6WVPpnzFimobY43KkDwC+xx//vzE
         Ceg6avDUhTZ9reQ4xZQABD+a8Fm6xnNUAJUVqQ9QqyupjjmwNSU3Cqg2IrMZ+lmnIxvy
         PXSbGXDh4H1On7cjEh/+uG1T/rcC+pmgFuikExoDK4lfzNAXe8AFVyiXu+vL9jmx2pqT
         9RMvheTnQ+W7sFi0ZRzvWNsDW9Up5hrtE8E6ByczKwz5Ftf2l0bwWwT/LJ4eNqhP7Rve
         mgdeH4I3LVug1srVfzPHaL7XNcMbRllpQQ9z7XRaajh4bby6EE7srOSfpMH79x1lwatQ
         F8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464387; x=1705069187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsKBPt1K3dp72jnnoUQSgV5XP7ynD+rz6hhuIBxWAk0=;
        b=q2VcgLN4AoZhxt+xYSYcdQvRFe2zwtO/gB8MnSfYQ2BFc1lZsQ73avS8fCHSwc2yx2
         AP/RmSdkiiuz+iBwxwqoYZUy3Ze/OAn0GKYBwIIzq9jAPtEQJAXYIM8kpm563cK3utbt
         DeiFUj0Y673GJMfvMMcL90x2XMvrZqMKdGIlPWFXQymbZOIFbjEff6SZ8L0g6mGT3YWn
         keCUz7BgGlEMRX/WW5EbcWlIwlbusUTlOCgHSYqptrZkEwqKBG7OXVdthAI7FxYVycdb
         cS5NXsGM1AXvqFHCsBRKq1pWDySUrM8rD0JqZrvG1CvFViJLXJ2CI5U0SABBdS3yllJc
         36Ww==
X-Gm-Message-State: AOJu0YyHNs+H+SazxfQ+XsCdg3yYeoZM4mcan31RPULxz01wMk6BssZN
	XRo1EOf44Jujz/7FymUvwBxaG4nAiNxn0g==
X-Google-Smtp-Source: AGHT+IGtOckFc6VnOrlxOrWHq38+hmIj/3CHF5jVLuzn/DNW2TrEr5k+oTxTFxMq0gJ6+3bMLjITMw==
X-Received: by 2002:a05:6808:10c6:b0:3bc:2a62:7483 with SMTP id s6-20020a05680810c600b003bc2a627483mr2457626ois.28.1704464385953;
        Fri, 05 Jan 2024 06:19:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id l12-20020ad4452c000000b006800a150d42sm639643qvu.20.2024.01.05.06.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:19:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLl32-001OxF-TM;
	Fri, 05 Jan 2024 10:19:44 -0400
Date: Fri, 5 Jan 2024 10:19:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shifeng Li <lishifeng@sangfor.com.cn>
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shifeng Li <lishifeng1992@126.com>,
	"Ding, Hui" <dinghui@sangfor.com.cn>
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
Message-ID: <20240105141944.GF50608@ziepe.ca>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
 <20240103184804.GB50608@ziepe.ca>
 <80cac9fd-7fed-403e-8889-78e2fc7a49b0@sangfor.com.cn>
 <20240104123728.GC50608@ziepe.ca>
 <62db1a02-41b8-44b0-960b-6d6f5bec5d19@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62db1a02-41b8-44b0-960b-6d6f5bec5d19@sangfor.com.cn>

On Fri, Jan 05, 2024 at 04:15:18PM +0800, Shifeng Li wrote:
> On 2024/1/4 20:37, Jason Gunthorpe wrote:
> > On Thu, Jan 04, 2024 at 02:48:14PM +0800, Shifeng Li wrote:
> > 
> > > The root cause is that mad_client and cm_client may init concurrently
> > > when devices_rwsem write semaphore is downgraded in enable_device_and_get() like:
> > 
> > That can't be true, the module loader infrastructue ensures those two
> > things are sequential.
> > 
> 
> I'm a bit confused how the module loader infrastructue ensures that mad_client.add() and
> cm_client.add() are sequential. Could you explain in more detail
> please?

ib_cm has a symbol dependency on ib_mad, so the module loader will not
allow ib_cm to start running until all its symbol dependencies have
completed loading.

> We know that the ib_cm driver and mlx5_ib driver can load concurrently.

Yes, this is possible

Jason

