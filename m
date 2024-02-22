Return-Path: <linux-kernel+bounces-77468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7B8605B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F91C2128C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB1617C6B;
	Thu, 22 Feb 2024 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MuR9drm3"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500AE17738
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641214; cv=none; b=fdoGqItA6fBbCzuPbKZGXkDtIQpPh6pk6meGvKkB8rkdS3wJxxWvDDJ3AH2ODH3HwAHMsyPN+ZYxYY8FLPe5QBMA5gaQ2D4jOSyg4n01FxZrTp4klIGjB+2hJV/dY8g4d2xr+xBT8Fd61YGMJNIV82ReNmc3dwJJ6H3CbPdzFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641214; c=relaxed/simple;
	bh=E+SWdmGTLir/b6HZIa9AiZf3LmSGkycPI2zblqWjQFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEiHWdQ66SK+UFxE5XHgwu9ZO2Hl5EzM/opXwJ0kh13gIiBksTx/Pfpk+nh4hNWplk3tiNFwnJmCdkLpzykP1jg39gbSnofuZuQrQbqiOPy5Y6KBAO1YsMUXYKd8d7EQHYRTeuute9wcnOD4lHwfZSvSwmvHsQFf6VEP74fIH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MuR9drm3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Feb 2024 17:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708641209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rsx2SzFybZFwH77WhP7HHzs8MmI+mtm/sz5SDmv6Z/Q=;
	b=MuR9drm38psKelnXD7AREGT2IlE4g/+yZ+95Jt71ltP5JhqTksOEZh7hGaBBF/9paUm9pO
	NZq9bWS7XfezXJGz1ddjd8FNplf6TPIJPWk2wA2OT8EMc6kA8f5iUmXyNWwdUO4SUunXLI
	et8aU183TsoXrCdnLyWiMxRUvugwZgQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pavel Machek <pavel@ucw.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	kernel list <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>, Jiri Benc <jbenc@redhat.com>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: stable-kernel-rules was Re: fs/bcachefs/
Message-ID: <bhqwmyfmd3a5mgsdbfom6hz2cvhf75felzf2bu3aiusr6f3ael@6qo7buimzot2>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
 <ZdeeKiTXc7WidRcs@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdeeKiTXc7WidRcs@duo.ucw.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 08:19:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Personally I think we are not taking enough, and are still missing real
> > > fixes.  Overall, this is only a very small % of what goes into Linus's
> > > tree every day, so by that measure alone, we know we are missing things.
> > 
> > What % of what goes into Linus's tree do you think fits within the rules
> > stated in Documentation/process/stable-kernel-rules.rst ? I don't know but
> > "very small" would be my guess, so we should be fine as it is?
> > 
> > Or are the rules actually still being observed? I doubt e.g. many of the
> > AUTOSEL backports fit them? Should we rename the file to
> > stable-rules-nonsense.rst?
> 
> There seems to be just one rule being observed: "It or an equivalent
> fix must already exist in Linus' tree (upstream).". Every other rule is
> broken pretty much all the time.
> 
> AUTOSEL is a problem.
> 
> Plus there's problem with dependencies -- if a patch A is need for fix
> B, the rules pretty much go out of the window, huge patches are
> applied, whitespace fixes are applied, etc.
> 
> There are even known-bad patches being applied, and then
> reverted. Greg explained that it heps his process somehow.

This seems to be a pretty consistent theme theme - thins are done baesd
on whatever makes Greg's process easier, not input from the people
stable ought to be working with. Pretty questionable set of priorities
if you ask me.

