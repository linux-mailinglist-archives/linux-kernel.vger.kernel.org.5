Return-Path: <linux-kernel+bounces-87560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB1D86D5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DA21C23C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FDD13E7CE;
	Thu, 29 Feb 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9DYyfyA"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5506D53A;
	Thu, 29 Feb 2024 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240892; cv=none; b=bfIZ8ze8FCu70kwLBubStrjXmNQ9FwsV4C5SNn5XiHLSkQBLZJOiP2T/EATZ6h7aj7euENrqkWfUU+YuvmisU8VzN3z+uMJDopZG19vRpYNjlKqQt55ua1aLZ6Kc1lmtNZoKljnddHIdu3RrultrRT4rfZU+a80gSgUtbGRq6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240892; c=relaxed/simple;
	bh=BVoEXyJnWOjPf9N3vsI8NOsWHEJGIkMDpIW0yRsXLAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4zw0hIYm4ZCknrgX34ucleFh8l3DIQYFN/QHLCSLrKwiB6y1u7ynXGdL1+bZt4O9B9k3IJxXTvaWI8AFAARpQZ5Ad2zWkp/+WeWluenS4n/+N2/7nDsN2JnOa7WyVToLAEoBr13lJRSPJ+oBw74mCbnJ3ugmYb+RHKahLoBTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9DYyfyA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-787a843003eso92843885a.0;
        Thu, 29 Feb 2024 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709240890; x=1709845690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzIxZF8ZIEwD2OTEM2JEqlEHNkUn9G6VGUCr6uISdK4=;
        b=m9DYyfyAutfYeflUm2oEeEAk/qVk3HdZ6SJIjbmXZ2+dVgS9krCc4bJQD0zll5tVlW
         n1G4tqbUqr+N6p03rtTVLHC57d1scoQ7Q9UMZ2QQpnYPdJHUv16K0I+rKN7knOdCqsom
         EfrRloZ103V46HQwJJUlX01PpuOrUWcC+fGqlUrlJGsImxCTz0CQ6KL99aFUCjRyepU+
         xkmafBoql7FsUVI7ObbleQkqj6PKtZbmdNq4PiyNFdik7L/kj6exOUhh3IARFTepO0AF
         OwcUbCB76EX2C7iEINSg033nRYcqnpuyInPyA5ec7FKlY6YcqnjRhA/aLC3yiOsbhWy+
         3Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240890; x=1709845690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzIxZF8ZIEwD2OTEM2JEqlEHNkUn9G6VGUCr6uISdK4=;
        b=mHk4vsq2D/8ys/o9SASw7/jFIHmjy/Y8FrvyBMPLHlZ2Gz1z3ZvRURhvYG794yi2I5
         9QnGJHAprT2tpE0hca+IzXRbrRNQ18aMctBdHGCSqNdyyzjUw/Azyx4cZ7vFN53lIcoA
         mnAOPISUskhH6BX3v8Tk1xI7RSJFbwHy6sXPlNWa+5OMm0jAx7yaZDpWZcBju8BbMFsb
         6I0Ofa51qcvY86wOMilKS3lcm5hnLf2uX2aVq1v+RL0/tWrphckTvJZrdExTkljJAlRn
         zyZzDPhJnEBJ647myL8YgfBOGW8L9ylC59VBaVIr3dRvAsQF88QTYyYP1oENN8lH2Jzc
         FinQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8KMHA3mF+GUCIo6q+E53GWco5TB2Iay7Ld+rcy+zNSySAPUCry4n11E3B9+hj8Dnd6d/76XvrtPjEW9NTgs7ffr14Uz1+lgmg+yti9jYORTMq9soPOQZMAh/b7XXQohMsjWTj
X-Gm-Message-State: AOJu0YxdKC8Pev6t0Bf+DTEOrL6/TVq8BlDudcu3geGO8nNI2EJqBubf
	AM8bT+pMBBCzq0tKVeun+0PqhhdzgLh6ly1g1eLBdIdM/ZOQrD71
X-Google-Smtp-Source: AGHT+IEduBApnN3IdnWR7zWPFrPtizlWPB/ExuBF30NfQzCCsxQ9RICtJGOeKdJqwuFXiCiNJthvmw==
X-Received: by 2002:a05:620a:4ada:b0:787:cecb:626f with SMTP id sq26-20020a05620a4ada00b00787cecb626fmr3415801qkn.70.1709240889831;
        Thu, 29 Feb 2024 13:08:09 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a404700b00787fb9e2d2esm979317qko.125.2024.02.29.13.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:08:08 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 4CB5B1200043;
	Thu, 29 Feb 2024 16:08:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 29 Feb 2024 16:08:08 -0500
X-ME-Sender: <xms:N_LgZeo4osw_ckdcp9azOsRRPMl-DmPGpS9P_4s1X_q2r7SXOFo-mw>
    <xme:N_LgZcqT4ov5ST7NouC2jjEDbEfoKaMZQiztazWX8Xar2GIHcK_toegmUywxArvHO
    RlMXZtaxGYRLWbEPQ>
X-ME-Received: <xmr:N_LgZTPB2IEdkh4dDRs8GpYnu4ZxnKp7CCELoAsvqG_JvI2ttt3El4xGCtGstg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghes
    ghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeite
    ejieehvdetheduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:N_LgZd6AxaAItX02csyB8UI-CdMo93Xm4eppdIRbPURu7MmQHVgcwQ>
    <xmx:N_LgZd4Wy3LVC-ihFX8wnGNgQwOBg44vm8Bv8vSxPdldqpNJ_6daZw>
    <xmx:N_LgZdjMknBv7WKB-ERUofxk2vJpxT2CoN5gLa9PuSRvWGmI0NUwtw>
    <xmx:OPLgZRq7_96QZPvB2rXCp9MCRiKDaSctbXmmWKqN7-pudqkF5QIjuQ9qP2c>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 16:08:07 -0500 (EST)
Date: Thu, 29 Feb 2024 13:07:21 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH for-6.9] workqueue: Drain BH work items on hot-unplugged
 CPUs
Message-ID: <ZeDyCSxtshb6MFLA@boqun-archlinux>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-4-tj@kernel.org>
 <ZcABypwUML6Osiec@slm.duckdns.org>
 <Zdvw0HdSXcU3JZ4g@boqun-archlinux>
 <Zd09L9DgerYjezGT@slm.duckdns.org>
 <ZeDrCMLlzVZpvbrG@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeDrCMLlzVZpvbrG@slm.duckdns.org>

On Thu, Feb 29, 2024 at 10:37:28AM -1000, Tejun Heo wrote:
> On Mon, Feb 26, 2024 at 03:38:55PM -1000, Tejun Heo wrote:
> > Boqun pointed out that workqueues aren't handling BH work items on offlined
> > CPUs. Unlike tasklet which transfers out the pending tasks from
> > CPUHP_SOFTIRQ_DEAD, BH workqueue would just leave them pending which is
> > problematic. Note that this behavior is specific to BH workqueues as the
> > non-BH per-CPU workers just become unbound when the CPU goes offline.
> > 
> > This patch fixes the issue by draining the pending BH work items from an
> > offlined CPU from CPUHP_SOFTIRQ_DEAD. Because work items carry more context,
> > it's not as easy to transfer the pending work items from one pool to
> > another. Instead, run BH work items which execute the offlined pools on an
> > online CPU.
> > 
> > Note that this assumes that no further BH work items will be queued on the
> > offlined CPUs. This assumption is shared with tasklet and should be fine for
> > conversions. However, this issue also exists for per-CPU workqueues which
> > will just keep executing work items queued after CPU offline on unbound
> > workers and workqueue should reject per-CPU and BH work items queued on
> > offline CPUs. This will be addressed separately later.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reported-by: Boqun Feng <boqun.feng@gmail.com>
> > Link: http://lkml.kernel.org/r/Zdvw0HdSXcU3JZ4g@boqun-archlinux
> 
> Applying this to wq/for-6.9.
> 

FWIW,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

(I took a look yesterday, but hasn't gotten the time to reply..)

Regards,
Boqun

> Thanks.
> 
> -- 
> tejun

