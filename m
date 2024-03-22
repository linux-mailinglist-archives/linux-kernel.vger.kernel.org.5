Return-Path: <linux-kernel+bounces-111782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BCE8870EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE391C23A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B35D72F;
	Fri, 22 Mar 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JuJ6oBjw"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1F5CDC0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125126; cv=none; b=CFuihgwhESNJRgYZa3W3S8uNOF3MHrS1lr606X+sKlc7lKzQ6NV3ZXTdLlSdQuEOtttODmCor59ibPG64PfvAkcnHO0CBIx4lsmIk4uKgQa/MWkW+Ysy31aHyLTkCNv0t6abw47OyT0vMy8vqMGCiB7dW8s7pK3wE99gSwgxB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125126; c=relaxed/simple;
	bh=BuQG63lMcTmgNNl4rqvlHS29xM6nE11JEuyaJ7K23dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYrB/Dm7gFMXIkABb+8Lw5ZVxrgHUWYteQQQbtGLRtdlVB3dPFgTagYqwYL+CRIY2cC+kTBTCukp79EWGnFDSTFSeio/bSFfhQykBKql8M5g74LZOpZX8OcrDfriE68wtIA7GkhCgzj5hAXPf3KmxhIfbqrZRL2K1SrqgUz85sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JuJ6oBjw; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-789fb1f80f5so152549885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711125123; x=1711729923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/jKRcxkxWVwJBSpRibUSdG75lkZ4ocJycd1Mr6Bw2Y=;
        b=JuJ6oBjw8H7yZWUC46RLCQoesbwU9Lk6T9WPH3kye2vyYNHfTd+KhOz1wwfnD1igB7
         1p3mIFFWcgt2sWdN6hRnJ2z4cW4j93IxiGT/Oyjuh5sSqqA9XvkQmumHJwmHhBm8x3O1
         pVBhfk4LLMCLM2XYpDiEH/NXcdlqr2XGuJXMo+MUiisQg5nErFEVsv1z6rPH2bddD/Tf
         akyFuTxkvmUVwPH41wi30mNRTJoJwAAUZwGEYyXudgKdI+5OGBKrrLClSpkJt6QEfkcP
         /WMYN8fHNWXXkeu5oo32YIoGoFmLXCPOx5uP4bP5Yd9yRktMIkPkw07IF8VuaaqBwlEs
         PhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125123; x=1711729923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/jKRcxkxWVwJBSpRibUSdG75lkZ4ocJycd1Mr6Bw2Y=;
        b=ZrpxMssd8IjSozgZVHb+GHReiKzUVqxjKHhoiC+/HExflIe9ypwp0SmEjL69LpV5k+
         4glmeZq1XsCTnhw8C8UhkoWZig0f+bY+UuyVk3304s3KDAkUZLOhcR0F1dmNYE7DcuV7
         3TviIc3s8VVvkVUxJ6ihuNWpFTT+J6gs5keA9M9z28wPxh4mKHogZmEwDLDJhM1qoA5E
         Tqot4dIFib5/Ms/ES8kpm8Fret4Vg21155FUr0baRm8JWqP4iEOCN8HiB1yfhQEKEM7u
         gWyhUnHDYoaXOo09qtOx2wCsI6FdgkbNRnNHpH5HfwZ8yCxlS+bdVpHN1wKbre/m5YbB
         kNwA==
X-Forwarded-Encrypted: i=1; AJvYcCVpHCy8LHzZZovA+e0qPqVsUpJUk32l23Tq4uoD0M965R6VafVuFrP80xwKWqNvAFdA5joGtMcE4J6H45eZyxPh1+NTN0WXlB0ZabY8
X-Gm-Message-State: AOJu0YzaEgqbI99JDROHhaQAVYliaPOi6w3L2OH21p1tEyKg/WmGxfI+
	ds8Ayp2XFBf7MK9rgIiOnncOa/Jt8TBz/hGJSYUAkdU0N+04Wfsm2+79MdLZ7Hs=
X-Google-Smtp-Source: AGHT+IEmjNO3iVQtJ5/6Fyo+e6vZeQz1BIgmUNoeNHyvqSHC03UiQxcsrMArTCXiiRa/okEHUAyW2g==
X-Received: by 2002:a05:620a:57c3:b0:78a:1e39:2674 with SMTP id wl3-20020a05620a57c300b0078a1e392674mr2949227qkn.39.1711125123483;
        Fri, 22 Mar 2024 09:32:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r30-20020a05620a03de00b0078a07fc259csm899307qkm.40.2024.03.22.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:32:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rnhoI-00CMyb-0E;
	Fri, 22 Mar 2024 13:32:02 -0300
Date: Fri, 22 Mar 2024 13:32:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support congestion control algorithm
 parameter configuration
Message-ID: <20240322163201.GF66976@ziepe.ca>
References: <20240308105443.1130283-1-huangjunxian6@hisilicon.com>
 <20240310100027.GC12921@unreal>
 <c16e3cc2-1a70-a9ec-e533-e508cfbab18e@hisilicon.com>
 <20240311071119.GH12921@unreal>
 <f8354762-703c-16e2-fa8e-bc8519fdcd06@hisilicon.com>
 <20240312080522.GO12921@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312080522.GO12921@unreal>

On Tue, Mar 12, 2024 at 10:05:22AM +0200, Leon Romanovsky wrote:
> On Mon, Mar 11, 2024 at 10:00:27PM +0800, Junxian Huang wrote:
> > 
> > 
> > On 2024/3/11 15:11, Leon Romanovsky wrote:
> > > On Mon, Mar 11, 2024 at 10:00:51AM +0800, Junxian Huang wrote:
> > >>
> > >>
> > >> On 2024/3/10 18:00, Leon Romanovsky wrote:
> > >>> On Fri, Mar 08, 2024 at 06:54:43PM +0800, Junxian Huang wrote:
> > >>>> From: Chengchang Tang <tangchengchang@huawei.com>
> > >>>>
> > >>>> hns RoCE supports 4 congestion control algorithms. Each algorihm
> > >>>> involves multiple parameters. Add port sysfs directory for each
> > >>>> algorithm to allow modifying their parameters.
> > >>>
> > >>> Unless Jason changed his position after this rewrite [1], we don't allow
> > >>> any custom driver sysfs code.
> > >>>
> > >>> [1] https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> > >>>
> > >>
> > >> I didn't quite get the reason from [1], could you please explain it?
> > > 
> > > Before [1], we didn't allow custom sysfs. After [1], the sysfs code
> > > started to be more sane and usable for the drivers. However, it is
> > > unlikely that the policy is changed to allow driver sysfs code.
> > > 
> > >>
> > >> And it would be helpful if you could give us a hint about any other
> > >> proper ways to do the algorithm parameter configuration.
> > > 
> > > Like any other FW internals.
> > > 
> > 
> > If we add the capability of custom driver parameter configuration to
> > rdmatool (similar to [2]), would it be acceptable?
> 
> Moshe's patch is for devlink. We are working on a generic solution for
> other vendors to control/debug their devices.
> https://lwn.net/Articles/955001/
> https://lore.kernel.org/all/20240304160237.GA2909161@nvidia.com/
> 
> Feel free to join the discussion and reply that you are interested in
> this proposal as well and emphasize that your device is not netdev at
> all.

Yeah, I'm kind of expecting that all RDMA devices are going to need
something like fwctl for exactly reasons like this. Adding a special
driver sysfs is, IMHO, worse than just exposing a driver specific
sysfs. hns looks like it would fit nicely into that scheme as it has a
clean fw RPC interface - indeed this is just welding the FW RPC to
sysfs..

Congestion control does seem like it could have some sensible
commonality, but there are so many different takes on it and many
people are not doing per-port stuff but per-device or per-qp
variations, so I'm not really sure.

I wish there was more industry standards here..

Anyhow, feel free to respond in that thread that hns is also
interested, thanks

Jason

