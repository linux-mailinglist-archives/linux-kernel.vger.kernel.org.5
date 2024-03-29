Return-Path: <linux-kernel+bounces-124314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6F891595
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2301F22A29
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F6C3B1B2;
	Fri, 29 Mar 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sEXM3Fmb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EA82AD2A;
	Fri, 29 Mar 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703792; cv=none; b=BNCJpAxI3f+/tb3yqlZ89YBYVtWqJlV8Gcj+TgCFYrzqdqVUKCw2gfYr1zOnNh8yPDbQ/fmd1cweNRmagd5kxwhYRwVQr4vpc53vwtVpuuQ08CmzvK/bsGZo9atdow/7NJcWjj4Xzv6YhSTXG4cFni7R7wRV/oOEtJzjrKmLUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703792; c=relaxed/simple;
	bh=ot+sbE0dJtMdhT9Zki789DWUHsOHuq0gkjdWSqJtxgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHe2H4CXtIfMnkxatF3P8Tn4tMfK9gNC6gasg4K0o3DzTpRM8tQlLB6pPXtiDW+OeucM0rGe3xWCQklGdjPq/rE8QvCVyybN7PlOukYFcCqEa+abmFseFHLykgoe/BYIl8RVYHNxGBt+Q10TuQ2p3RL2z3jYGdkVXJ1Cpv32lSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sEXM3Fmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DADDC43390;
	Fri, 29 Mar 2024 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711703792;
	bh=ot+sbE0dJtMdhT9Zki789DWUHsOHuq0gkjdWSqJtxgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEXM3Fmb8CxbHZms2EMzabtVckxIPrQ6YI5qDE7TD1ppCKmjl+RwsRKWOolTQThdJ
	 lFyuXKp+s+a0D5UXLB7qFEHa5GDl7LPqEloyK/fcxiTOyrNZCTwPFxjJiqD0KN1bXN
	 o6DS9wx1a6Xp/qVEbAc+Wwd9keMmPgtUyX+ogODQ=
Date: Fri, 29 Mar 2024 10:16:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "x86/efistub: Call mixed mode boot services on the
 firmware's stack" failed to apply to 6.8-stable tree
Message-ID: <2024032917-mossy-parkway-f298@gregkh>
References: <20240327120643.2824712-1-sashal@kernel.org>
 <CAMj1kXH8n4-8VHSVygUyEc4Zne-4gE0uijAkDe-Ufu6hUnFU+g@mail.gmail.com>
 <CAMj1kXG5bywFpNpMRTXsnaQ6gr4aOBTO7PZ9Op-JV37JT9StKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG5bywFpNpMRTXsnaQ6gr4aOBTO7PZ9Op-JV37JT9StKw@mail.gmail.com>

On Fri, Mar 29, 2024 at 08:13:36AM +0200, Ard Biesheuvel wrote:
> On Wed, 27 Mar 2024 at 15:46, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 27 Mar 2024 at 14:06, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > The patch below does not apply to the 6.8-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > >
> >
> > This applies fine on top of 6.8.2, 6.7.11 and 6.6.23.
> >
> > On 6.1.83, it gave me a warning
> >
> >   Auto-merging arch/x86/boot/compressed/efi_mixed.S
> >
> > but the change still applied without problems.
> >
> > Not sure what is going on here .....
> >
> 
> Ping?
> 

Give us time to catch up please, I'll go look at this now...

