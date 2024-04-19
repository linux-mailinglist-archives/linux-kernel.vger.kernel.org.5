Return-Path: <linux-kernel+bounces-151400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF708AAE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A60282A94
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F085951;
	Fri, 19 Apr 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d/Ym2Roc"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3A8563B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528841; cv=none; b=MbOV8cMzAVfat6ier5ggq/ajJjffxvdWEWU+BphT0ysRi+r0jKW1horpzHmR4lHDHuy0mQOUAmjiiah2KNiHHdIHOTK/6aoy7pOLEEd6udSXL0wofCGw1XdUJuO46CCkyITIrhvw+EYhrZoFl7XFVT7Aby27qDKWCPZCjMGRpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528841; c=relaxed/simple;
	bh=ExrFTBEMLysOlFee1rplMJqRkLcyI8BEBxqM1v/q8vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJdieT48hMzi4ThfeOLeEwAwSY3QB4PTRT1ZDtxoQ+E589udGfN1H6cCrvG5b2PAhRChSkbCHNXpqF5WI3wleUU3Nrf0cXkwrcuJ0cxjD8OX9pcTlSVscfhrfaqeIuyDwLbNiE5b7a6yGlpAYZnStcSEdpdMoIZGTt4Y5zxpDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d/Ym2Roc; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea2436de79so990810a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713528839; x=1714133639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hClZeCrWEscg3J5h83DbwJ64WLBmvjGwEZ7n9vuYDf0=;
        b=d/Ym2RocXeUfT4NSLSANYFCbVNbq4JWuZJSHDzT31qCrFN/rJ+0KM29vaVzNTcgmLa
         TziCCiv3FvYHNIDuYz/RAwnIdtsXFvqSW6sjcEgRsM5U2l7zknedscv6zl+NaFsljGNy
         i3dFHEbgF8JZFAQlIV20NW6EmMOl890DL8qIDu544YnrfBSba7JNjtXZXp4PsJyuVxwi
         8RkQM9pgn1Q4J5YAb9ywUFVpus06Dk4m1L0kk6JINvQoM3M09a/+TMNG631EnlEW7fl8
         VXQvkIPHpCIDA5SFP6OzMTtQg97Fv5t1nq+OaYem5Q0mTQ5ww3DHZTpucQbEI4mJw9A3
         JO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713528839; x=1714133639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hClZeCrWEscg3J5h83DbwJ64WLBmvjGwEZ7n9vuYDf0=;
        b=GdEmBFQJY05TKcHE4AlnroL40EgJcLKTlK7UvzG1Jd14pqJe+d9TVT98rfT43A9bnp
         Ma3ZRr0P/8AOasJTqLNw2jpm/rcU7LYx1OKeg3/x2YxFbfOpyj3OMv6KrG+Hbho56MhT
         QCOvyIStu9T9tclwXap7xg+IVNTJkzKO9kl7REQFy4ZYvvuKVCJ+QdutdtTRhfHTmTpd
         Qm7IWxjql+O4os0KVpYXz283UFrqYV9gPsjW63IVYGQ3XV3gkpqsgWAtVwcduhMFYr2a
         xdvcVR7fg9QJn65JUMNJUuWsKK40R+rymKNbWKqi2HUpLC/V9Sjn7Rmbj8orvIDr8SgJ
         LwVg==
X-Forwarded-Encrypted: i=1; AJvYcCVQmmpq09pk8FhKfigbBLhr5h/0LRUMHI+8Ripe0wJ0l4gCCwuEZhZd4GHaI5EH4LyNHt8hLsZ/gdkE7e9kvO7Unx0wUVOZCpjYBcQC
X-Gm-Message-State: AOJu0YyEZLfZ9T3M6tnVyibBpyt1a1DIxb0x3jrb8Uc4jgrucVEcesop
	Eu4GOHxcSNY83L6+3drdUH8VQhuXK4sYAZdVomZ1gavXvBnbBY9y/Wtx0s8R+TfGdLoBv+c3LgJ
	5
X-Google-Smtp-Source: AGHT+IFXe1Uvgf42Jw4ozBKiARbrTyiKg6q2CPN8avKsqmplfA08fWwIoKVSuopw8vPdavC70O3dLA==
X-Received: by 2002:a05:6830:7306:b0:6eb:d6f0:fed5 with SMTP id ex6-20020a056830730600b006ebd6f0fed5mr1195950otb.6.1713528839059;
        Fri, 19 Apr 2024 05:13:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id b8-20020a056830104800b006ebc74943bbsm550833otp.18.2024.04.19.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:13:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rxn7t-00FN5C-NG;
	Fri, 19 Apr 2024 09:13:57 -0300
Date: Fri, 19 Apr 2024 09:13:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Message-ID: <20240419121357.GB223006@ziepe.ca>
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240417145106.GV223006@ziepe.ca>
 <PAXPR83MB055789D898814B9F73B15C3BB40D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB055789D898814B9F73B15C3BB40D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>

On Fri, Apr 19, 2024 at 09:14:14AM +0000, Konstantin Taranov wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > On Wed, Apr 17, 2024 at 07:20:59AM -0700, Konstantin Taranov wrote:
> > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > >
> > > Implement allocation of DMA-mapped memory regions.
> > >
> > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > ---
> > >  drivers/infiniband/hw/mana/device.c |  1 +
> > >  drivers/infiniband/hw/mana/mr.c     | 36
> > +++++++++++++++++++++++++++++
> > >  include/net/mana/gdma.h             |  5 ++++
> > >  3 files changed, 42 insertions(+)
> > 
> > What is the point of doing this without supporting enough verbs to allow a
> > kernel ULP?
> > 
> 
> True, the proposed code is useless at this state.
> Nevertheless, mana_ib team aims to send kernel ULP patches after we are done
> with uverbs pathes (i.e., udata is not null). As this change does not conflict with the
> current effort, I decided to send this patch now. I can extend the series to make
> it more useful.
> 
> Jason, could  you suggest a minimal list of ib_device_ops methods, that includes
> get_dma_mr, which can be approved?

Is there any chance you can send a single series to support a
ULP. NVMe or something like?

Jason

