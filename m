Return-Path: <linux-kernel+bounces-44371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE984210D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1198628962E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3360ED2;
	Tue, 30 Jan 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbeFUlKH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmMuECqy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019260B8D;
	Tue, 30 Jan 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610022; cv=none; b=dmKU2ink7UJ5bAfSH9KVRPm2YJDbt904E0L9trkqCKyvt/ryE+G0FKIW0M7bRSvq+LqEu5Y2KwbY1zhmLeqQ2aBHX9Wz7qYPNJs1is3XFIx22NnNbCtxRok1U7SyXg82Tbzds/6r/x200uI10Mx3sUga6nb0/MuUJB1Jc6xnLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610022; c=relaxed/simple;
	bh=Vu3/rb2+o9A3xavD6zhieunf/6dYSlSau376+ZTpvg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+nHkcKbfCsxZ7bKvT/Iw0TRXEask8woEHkbzuCJViu4CMkHNTQCMCudM4riomvJR0vz+aVffuQRxvKTWAd1Nr08IVWU1x1aKD+BJia0xTRSCLJsknV86zq3EH4VEdrtqif/G3LG1Oul48DflOlQDM2MNZSJhq9TjTAWVtY/69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbeFUlKH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmMuECqy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 11:20:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706610013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33I6KUptN215uQ8/TCY4CSKquwhpzQOMErJY2s/Iee0=;
	b=dbeFUlKHES4fesoAHnLXHJ+VSYqlpTZw1eJPWS31UM8nLcj3mswTX5ykMcL2FtN/QiNDD2
	fYKdSvcPQLz33oL+y/Xj3PL2IBBqzAZq0GCAIOMAvIn0vHHkERJMr3BCoCvCB/bLp/cRFn
	8hPmIJKDqlDM82IvxIlTSu39xkFreBDnB/Jl4+B5Y1YoIVRHTIR2yGonu4WdLUvmrDV1xq
	GuHgWKh2dDJw77bwgVlUPXd56YEPBJyq1rRRTG+0U9w+Am3AdqiUynzZog8cejZDYibWmC
	aSSFol7cgwyOHlyoL+iX5KN0uj7Y2A/njaw2KtTYqMxPrSpV5bCSFeq0NsF1Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706610013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33I6KUptN215uQ8/TCY4CSKquwhpzQOMErJY2s/Iee0=;
	b=RmMuECqyH8DIcdQfe7Trm2myMgd3pEznT6Bm+Y1jq2PCdSuiRKCXyvehmLz1jJDFtmE4Av
	KcY1D98rUSikL6DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, tglx@linutronix.de
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
Message-ID: <20240130102011.rX9Qjnp1@linutronix.de>
References: <20240130091300.2968534-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130091300.2968534-1-tj@kernel.org>

On 2024-01-29 23:11:47 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> As suggested, this patchset implements BH workqueues which are like regular
> workqueues but executes work items in the BH (softirq) context and converts
> several tasklet users.
> 
> - The name bh is used instead of the suggested atomic as it's more in line
>   with widely used execution context interface - local_bh_enable/disable()
>   and friends.
> 
> - The system default BH workqueues - system_bh_wq and system_bh_highpri_wq -
>   are provided. As queue-wide flushing doesn't exist in tasklet, all
>   existing tasklet users should be able to use the system BH workqueues
>   without creating their own.
> 
> - BH workqueues currently use tasklet to run the work items to avoid
>   priority inversions involving tasklet_hi and WQ_BH | WQ_HIGHPRI. Once all
>   tasklet users are converted, tasklet code can be removed and BH workqueues
>   can take over its softirqs.

If one context creates multiple work item which are then moved to
tasklet I don't see the difference vs workqueue with a bh_disable()
around it.
Looking at the USB changes, I would prefer to see it converted to
threaded interrupts instead of using tasklet or workqueue. Both
approaches (current tasklet, suggested workqueue) lose the original
context where the request was created. Having threaded interrupts would
allow to keep everything in the same "context" so you could prioritize
according to your needs.

Sebastian

