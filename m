Return-Path: <linux-kernel+bounces-143974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5678A403F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3851F21839
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA617BD2;
	Sun, 14 Apr 2024 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EYzihtcP"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020D17721
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713068403; cv=none; b=Sa5BBVPflwCNtPAhHhDoNqu0LbPnrUhc8tvF/a+GOeSfVlJnM/rs7FtxCAxCblFiFdwYLXECKBwgUgr4bybGt05KzAh1b8DwShH6Gf+FPADC6EKqiMfD+yincz0zYvoArWfXNs8v4xw85lGQHw/VrqxEHXvYlyVnxFBB8KVMnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713068403; c=relaxed/simple;
	bh=SB6ARZOhTMvrXawsmySuOnOm8Vrvme3M5GU3snPF6eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLsMfkdjLye7ZmiMYih/aTH2WuJJECEfOijELB21dgTDJK+HARTXA7sZ3ejXHdtgpMhnJwVaKqkbme6CaSP5cpcKgMk1zYvkYsC9jZuG7l93ytPgCrEQ1ksw/BbbqUqVspzo8CIBKeVvJhlpgb4bu9nGK1RBoCUEpSRrgg0XT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EYzihtcP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 13 Apr 2024 21:19:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713068399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh56ZyGbJGY/OXd/Aimq36lBQCcFbETossv2eMfjYH4=;
	b=EYzihtcPurjyOYM4mJrGzV3H6XjkCbnOgayvGXbdYwLOu6YGT/ZZSArVVcKAx7hu1DWjnO
	GfTkociOsmt/cruykfhG6lSXruJuco0v+DxB6kp5XMrVIPStTje1d199pE8N+eDzpAVvrM
	TYNKOc2VDSLNVWQEXY3C4B+f3XU01GA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	hannes <hannes@cmpxchg.org>, mhocko <mhocko@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaZ2VuZXJh?= =?utf-8?Q?l?= protection fault
 in refill_obj_stock
Message-ID: <y5pnw2czcfkgb427vjyv5jwjvafvl4zo7elja2rjtdsppuxsy4@oshxnaik44kp>
References: <91e1389e-0723-42e7-9ea4-396ec6b54e49.bugreport@ubisectech.com>
 <ZgtIuBlUVE1Lj_Tc@P9FQF9L96D>
 <a6b8148d-10b9-4fae-a987-39ae62bad0cb.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b8148d-10b9-4fae-a987-39ae62bad0cb.bugreport@ubisectech.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 02, 2024 at 09:50:54AM +0800, Ubisectech Sirius wrote:
> > On Mon, Apr 01, 2024 at 03:04:46PM +0800, Ubisectech Sirius wrote:
> > Hello.
> > We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.
> 
> > Thank you for the report!
> 
> > I tried to compile and run your test program for about half an hour
> > on a virtual machine running 6.7 with enabled KASAN, but wasn't able
> > to reproduce the problem.
> 
> > Can you, please, share a bit more information? How long does it take
> > to reproduce? Do you mind sharing your kernel config? Is there anything special
> > about your setup? What are exact steps to reproduce the problem?
> > Is this problem reproducible on 6.6?
> 
> Hi. 
>    The .config of linux kernel 6.7 has send to you as attachment. And The problem is reproducible on 6.6.

Can you please share the reproducer of this issue?

> 
> > It's interesting that the problem looks like use-after-free for the objcg pointer
> > but happens in the context of udev-systemd, which I believe should be fairly stable
> > and it's cgroup is not going anywhere.
> 
> > Thanks!
> 



