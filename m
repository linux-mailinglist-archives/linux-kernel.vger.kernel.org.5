Return-Path: <linux-kernel+bounces-24846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1CA82C358
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CAB1C225BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13873171;
	Fri, 12 Jan 2024 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OxYg5XEA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155373164;
	Fri, 12 Jan 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e+tJ5kJoCnbfdWjA6W10nryDlvSS14xOBq3EZoL+cnM=; b=OxYg5XEAXsuevPP0WSgv8y45tQ
	c25jgvQv4lkzefRq04BeleHtIa+G3asPf5XNu1qCmoGsArrPfS+TVjJTcrg5Nj4JsiYm4TvIjqw+E
	F0YgNitJXpXlnWvKmp1ZHufBvRDS4MRg1hsZFsjzo52qRquwu0NIO+ZxjCBo1oIP0y251+U2UdWSU
	HO+TuIDvaQiA8P+l6/CdKDwJIG0wRjxvMzRpy46jlkN5gamZRRzliWukkevMJ3cjVt2KvTgJqKBNW
	3xClg1P1/k22efUaCPNFFQBvdJEwZwgj9GmhtyF3OfskfxWTEcxZg8VHtg8ersbO+gJUBxF0AHckF
	jOvDj5Sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rOK5p-0006uj-Av; Fri, 12 Jan 2024 16:09:13 +0000
Date: Fri, 12 Jan 2024 16:09:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Documentation for 6.8
Message-ID: <ZaFkKdFyThJNLDcm@casper.infradead.org>
References: <87sf37vegj.fsf@meer.lwn.net>
 <CAHk-=whtqOvx4_GL8MX+bGroS5hfueP+Arch_qVYwQDJVvFCKg@mail.gmail.com>
 <87v87yk3xg.fsf@meer.lwn.net>
 <a445d391-4cc9-4d6d-85ad-02d23aa57ebb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a445d391-4cc9-4d6d-85ad-02d23aa57ebb@gmail.com>

On Sat, Jan 13, 2024 at 12:28:44AM +0900, Akira Yokosawa wrote:
> Official python 3.10 support was new to Sphinx 4.3.
> So, I guess reasonable version for recommending is Sphinx>=4.3.
> 
> But at the same time, The latest Sphinx 7.2.6 works only with
> python>=3.9.  If your base python3 is 3.8 (e.g. ubuntu 20.04),
> you can't have the latest one.

I don't know that I care about Ubuntu 20.04; that's almost 4 years old and
probably isn't being used by anyone who's building kernel documentation.

Oracle Linux 9 (2022) ships Python 3.9.14.  It also appears to ship python
3.11.2 as an optional install.  It doesn't seem to ship sphinx at all.
At least not that I can find from a quick rummage in the repositories.
The recommendation I'm finding is to use pip to install sphinx if you
need it.


