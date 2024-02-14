Return-Path: <linux-kernel+bounces-64681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE01285416A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014601C262FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0B38F56;
	Wed, 14 Feb 2024 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l1c2Tq7W"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED653BE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876983; cv=none; b=sUZ4Vh0N0G5bq2/AtJB6oY1UJ8EgR9XPPvzgFSSP5joPZ9DbRKKsyaVutolPqJyeOxw73OZ9kz/FEqvwuBrnHa6vnQG65dS4ltht4BfKeHoUUuE66mUnJfEhAG++gskuyHqZQWjd25aYEXdQ9FY/N1GJS41CZlpItyVWQ8xw7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876983; c=relaxed/simple;
	bh=iuxI6YgKspcrKvyEQmU8Mrpps9ANMvPaobvGKTHdBUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awk75ayCi8UhzfpPwR0iIIIaG8q/FUCWQWOzr1SugGZV9jT1ZwR8tWh7U+ew3vuk2pB+ra2VE+zp2G3tNb3+sO8g8/6SOY7OpkhqfDnHuFhNhUZIYt76qToccv57J/pss3TgHAv86Ltyu42zu2/pRGyxExUXhufw6hCbu6LGptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l1c2Tq7W; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 21:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707876979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKcZYelQ3mQpgjTTUmYpkiR/PdoQNrHP6TmzEhQHtHs=;
	b=l1c2Tq7WpUkKS3LnbF61FKIoWRLGygt8C25g02dZVEs9tjzu8XGJCHu18bIhZ2//X++XKg
	FNdzlVBwez1Ma648XlCHlO8afR58ofVG2Ru1hHjInlWL5kOaPOca01WLS+K5pceuZv5fVy
	vtvgNon/OW73gxwFulDgE05LDYartJc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs stable updates for v6.7
Message-ID: <lt2fhreexozfddp676fcyhulbsjjvdan7lza3eczk7jkixmeoe@aynpcpcwspol>
References: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>
 <2024021307-reactive-woven-8543@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021307-reactive-woven-8543@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 03:38:10PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 08, 2024 at 08:14:39PM -0500, Kent Overstreet wrote:
> > Hi Greg, few stable updates for you -
> > 
> > Cheers,
> > Kent
> > 
> > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > 
> >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240208
> > 
> > for you to fetch changes up to f1582f4774ac7c30c5460a8c7a6e5a82b9ce5a6a:
> > 
> >   bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-08 15:33:11 -0500)
> 
> This didn't work well :(
> 
> All of the original git commit ids are gone, and for me to look them up
> and add them back by hand is a pain.  I'll do it this time, but next
> time can you please include them in the commit somewhere (cherry-pick -x
> will do it automatically for you)

Ah, apologies - I was pretty sure I was supposed to do something like
cherry-pick -x; couldn't find the option and then went looking through
the stable log, and I didn't see the tag anywhere?

New pull request inc momentarily...

