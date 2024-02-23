Return-Path: <linux-kernel+bounces-78555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9F38614F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47C4B21644
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B522625;
	Fri, 23 Feb 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R3gaM+bM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151637C;
	Fri, 23 Feb 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700266; cv=none; b=MmmT1dMxENgovX6w5KjLhT+nSzlKPB1t5l9p4nDH0fhCFtcLtHWnT3TecXYHzsRufLLkO3N4UjEDpJhlWwCNqaBRIvAvGGWXQ2d1p3AXVWhk2CTboFMP9zs1/LzhR6hl+dVl2Bg7llKNHGRm8XHLlmIZ87oxBp1xV5DjX2RWTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700266; c=relaxed/simple;
	bh=aqYzrgPs0vwyVdnHULgjYRCMIV7gwU8t5kThNSUOc/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuEeCqYPeenctna8+nrlq4pKZsSZhfQOXpd66TUVKri+haOh/DVQvMR+z769F1fa6IdvpWtunpglE8O64ZfdtNhN4PllTl1lg502NAR04pbB27DhBBZZ+s5zAeoBKNUBLpjOON+yKdKei1yaMfTPYDQ9mZ7Rfxup5/k5G94zApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R3gaM+bM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E936C433C7;
	Fri, 23 Feb 2024 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708700265;
	bh=aqYzrgPs0vwyVdnHULgjYRCMIV7gwU8t5kThNSUOc/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3gaM+bMJBjmfPsdCHVJjg41M5f6+caUCkTc1/cv24l4QyOC41frM8pkv+/jYT6qj
	 bq3YZDAEZuRa5TPy8oaWkVwYM8s8CAg3s11/ULNYA5PaT6VTrr/gCki+WY3qqbo+nC
	 bMhgn1SHmnwRmFUPItkCjWQz3HCzuTkdEd1vpyYo=
Date: Fri, 23 Feb 2024 15:57:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 5.10.210
Message-ID: <2024022309-agreeing-ludicrous-1d2b@gregkh>
References: <2024022358-routine-selector-0770@gregkh>
 <2024022358-cope-dividend-760c@gregkh>
 <7806f609-35df-747f-1166-b83df8c25d82@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7806f609-35df-747f-1166-b83df8c25d82@ispras.ru>

On Fri, Feb 23, 2024 at 04:52:11PM +0300, Alexey Khoroshilov wrote:
> On 23.02.2024 11:18, Greg Kroah-Hartman wrote:
> > 16ad71c250c180a095f9d11b02579b81a47aaa84
> > diff --git a/Makefile b/Makefile
> > index a4b42141ba1b..613b25d330b0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  VERSION = 5
> >  PATCHLEVEL = 10
> > -SUBLEVEL = 208
> > +SUBLEVEL = 209
> >  EXTRAVERSION =
> >  NAME = Dare mighty things
> >  
> > 
> 
> Looks like something goes wrong with scripts here.

Argh, you are right, the release went right, this script went wrong due
to a tag/signing issue on my side.  I'll redo this announcement and send
it again, thanks for noticing!

greg k-h

