Return-Path: <linux-kernel+bounces-64610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01328540D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3ED61C209B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E8E801;
	Wed, 14 Feb 2024 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A7o9oOwc"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7B372
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870582; cv=none; b=tcfjRQA1jGvIuvbrXJbqCRvDghOZLfR99VRreL/mXeruLtmtayA+Vrhl1wvIY/QnFb4iWE8f/I06eYvovOagAOAK+FhxtSXUVpiMJeyJGyAp5CFNTDtSMD7zG68Sj61cxNySWQKS2ATpTtLZ3tIz4IaK4+f7PCcNTFgfaVaF3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870582; c=relaxed/simple;
	bh=rXuw7s6WvFKQGoq551oldTwuYldo5BeFRsshFQZ4pFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUcvQoxxCjKY050hcsZSdWL0mpEWBDG4Vom6fkC5P1cThnqmRV22XMHDRHEFDs+XE8XPqkUX9K7+Ad+ADhi1HJdqakaJabdFR2aRat5J7rhxhbFVZ2128sHeKrQCk7/K+SV3ftE0LzuAiGFirtih4mmEavGIeVuc3akwQ3Cja2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A7o9oOwc; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 19:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707870578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RErxcJZwveQ+zI7kZ+ENeWs343mFPuU1/yMk17d5IE=;
	b=A7o9oOwchLJpbMYbSpZQABMPotBWdqfgFut2M7eavhAiKbaNtRZzMK9vuGI3+EdsYxtubi
	hKQuBS6DHAeUm7AgCi7e8vK1b751c+LtFjbfPX46FXvwHKaTyzRpktS8aOR832gsd6c0NN
	tuhZoCyB/GkV4QfFuG/THvVrB9r9/oc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <u6z6hyxhpjecbaw5zhevsd4hco253ec2pobijidj5bsd5ojbrw@mbu2r4o67nad>
References: <20240212105456.65194f29@canb.auug.org.au>
 <202402131606.A70D5347F3@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402131606.A70D5347F3@keescook>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 04:16:34PM -0800, Kees Cook wrote:
> On Mon, Feb 12, 2024 at 10:54:56AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the bcachefs tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > ERROR: modpost: missing MODULE_LICENSE() in lib/thread_with_file.o
> > ERROR: modpost: "stdio_redirect_vprintf" [fs/bcachefs/bcachefs.ko] undefined!
> > ERROR: modpost: "thread_with_file_exit" [fs/bcachefs/bcachefs.ko] undefined!
> > ERROR: modpost: "run_thread_with_stdio" [fs/bcachefs/bcachefs.ko] undefined!
> > ERROR: modpost: "__darray_resize_slowpath" [fs/bcachefs/bcachefs.ko] undefined!
> > ERROR: modpost: "stdio_redirect_readline" [fs/bcachefs/bcachefs.ko] undefined!
> > ERROR: modpost: "run_thread_with_file" [fs/bcachefs/bcachefs.ko] undefined!
> > ERROR: modpost: "__darray_resize_slowpath" [lib/thread_with_file.ko] undefined!
> > 
> > Caused by commit
> > 
> >   f894f9e5f0ad ("thread_with_file: Lift from bcachefs")
> > 
> > I have used the version of bcachefs from next-20240206 again.
> 
> I've mentioned this before, but this patch (and I assume others) was not
> posted to any mailing list before it appeared in -next. This process
> failure really needs to be fixed. Please post _everything_ going into
> your tree to at least linux-bcachefs mailing list, and for things that
> toss stuff into lib/ it really needs to go to lkml too and CCed to some
> subset of people who have touched lib/Kconfig, etc last.

thread_wih_file definitely was; the patch moving it to lib/ might not
have, I'd have to check.

We're having ongoing discussions among us fs developers about how to do
patch review, and the emerging consensus seems to be that we actually
don't want to spam the list with every patch (because not every patch is
interesting!) - we don't want the human-to-human interaction to be
drowned out on the list.

That doesn't mean we're not doing code review, though! We're
experimenting with different workflows, there's different thoughts out
there right now.

Regarding CCing people who have touched lib/Kconfig - you sure that's
the best way to get interested parties who'll do real review? I would
think review from the people actively working with and using that code
would be more valuable - that's Darrick, in this instance.

