Return-Path: <linux-kernel+bounces-4700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FD8180C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E8A1C217A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985B129EE1;
	Tue, 19 Dec 2023 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dKOLq3yO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7D79F0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Dec 2023 23:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702961983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yqAAM+hG1YQjR8yR0HnAvR8S5xm3iuPj/MFvnQD7W9Q=;
	b=dKOLq3yOt4WNFZqoTZC5vGm4+rSSEeNXn2qfcunItmH8scRw1og5q0s0k0HFAuE2PeoOWr
	08QHS3zfRfFmgHUagbFOVd+t+z3Hv7O/iRSvx4G6U1WEJgCt/X+NojCMi9JdKk4h6mOTgC
	QLjBEv4BWt9Hcgx+XUtGCwV0FeV7sBM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the header_cleanup tree
Message-ID: <20231219045940.tl42emmfdcyzjruz@moria.home.lan>
References: <20231219152545.54ac44cd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219152545.54ac44cd@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 19, 2023 at 03:25:45PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the header_cleanup tree, today's linux-next build (s390
> defconfig) failed like this:
> 
> arch/s390/kernel/signal.c: In function 'arch_do_signal_or_restart':
> arch/s390/kernel/signal.c:491:17: error: implicit declaration of function 'rseq_signal_deliver' [-Werror=implicit-function-declaration]
>   491 |                 rseq_signal_deliver(&ksig, regs);
>       |                 ^~~~~~~~~~~~~~~~~~~
> 
> Presumably caused by commit
> 
>   cd1146fc0ad3 ("rseq: Split out rseq.h from sched.h")
> 
> I have applied the following patch for today:

I've applied the same fixup to my tree.

