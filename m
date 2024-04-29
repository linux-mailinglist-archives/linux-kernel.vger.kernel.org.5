Return-Path: <linux-kernel+bounces-161915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390038B533C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719D0B21C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095D17BBB;
	Mon, 29 Apr 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mx9QXgo6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACD14A8C;
	Mon, 29 Apr 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379801; cv=none; b=mavg66inV0WeXXHzMCIgJcVTLEyUAXZGT3pUcUb+FMzLP87ocSuxzFsrJ+DHe61v8oMrx475HId9ZLwGQA4p0bfVJuXnHX9GjwNbaoC1GEJYYxQ2CHEMqWsac6Nf+IKstyHDr0Qxy1bMxRv4rlxXvcGKkp14VlmeRj/Pw/CfeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379801; c=relaxed/simple;
	bh=tqnqj5bYRDYYmHHW3t4b3JcGXP2u6dMCeU1YcEoYQB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcHHKh8F2axVy9zPHXTz7osUSbCr2W9rrhfK+ynaWsZAZURwaOgW0ib3VvoNScmoxh6bQ9A/rpy42lpwaSJzooVG4f47MvHLy1zrjO9BVcmVIBVFeNiJWQk2crOIL3r9J+QHlOLGzij0NQjGRJOMPWVLb4e21nIDO4JXTmQ1jQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mx9QXgo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAA1C113CD;
	Mon, 29 Apr 2024 08:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714379800;
	bh=tqnqj5bYRDYYmHHW3t4b3JcGXP2u6dMCeU1YcEoYQB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mx9QXgo6uCpYFlnlEPQFxsloKgzlWFJ9nfrOLlzaIN18UierazL/l4HJZeeYXbtyq
	 vgaslwGrusML/Dte0Ss47I9ZWSPTGOsAnCcvuuH7J37wFGu5KmoeISTXSsFhkpeLG1
	 +e/gLzQHsFP94UcJgddRC7YeESEnj3lMneYXzocg=
Date: Mon, 29 Apr 2024 10:36:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] docs: stable-kernel-rules: explain use of
 stable@kernel.org (w/o @vger.)
Message-ID: <2024042900-sabbath-switch-69f1@gregkh>
References: <cover.1714367921.git.linux@leemhuis.info>
 <6783b71da48aac5290756343f58591dc42da87bc.1714367921.git.linux@leemhuis.info>
 <2024042957-revision-sublevel-57c2@gregkh>
 <2dde6e68-bdac-437a-bd89-73dddf446211@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dde6e68-bdac-437a-bd89-73dddf446211@leemhuis.info>

On Mon, Apr 29, 2024 at 10:30:49AM +0200, Thorsten Leemhuis wrote:
> On 29.04.24 09:51, Greg Kroah-Hartman wrote:
> > On Mon, Apr 29, 2024 at 09:18:29AM +0200, Thorsten Leemhuis wrote:
> >> Document when to use of stable@kernel.org instead of
> >> stable@vger.kernel.org, as the two are easily mixed up and their
> >> difference not explained anywhere[1].
> >>
> >> Link: https://lore.kernel.org/all/20240422231550.3cf5f723@sal.lan/ [1]
> >> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> >> ---
> >>  Documentation/process/stable-kernel-rules.rst | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> >> index b4af627154f1d8..ebf4152659f2d0 100644
> >> --- a/Documentation/process/stable-kernel-rules.rst
> >> +++ b/Documentation/process/stable-kernel-rules.rst
> >> @@ -72,6 +72,10 @@ for stable trees, add this tag in the sign-off area::
> >>  
> >>    Cc: stable@vger.kernel.org
> >>  
> >> +Use ``Cc: stable@kernel.org`` instead when fixing unpublished vulnerabilities:
> >> +it reduces the chance of accidentally exposing the fix to the public by way of
> >> +'git send-email', as mails sent to that address are not delivered anywhere.
> > 
> > The "fun" part of just saying this is that then it is a huge "signal" to
> > others that "hey, this might be a security fix!" when it lands in
> > Linus's tree.  But hey, we do what we can, I know my scripts always use
> > this address just to put a bit more noise into that signal :)
> 
> Yeah, that's likely true. :-D
> 
> FWIW, we could stay more vague here and use a text like """Use ``Cc:
> stable@kernel.org`` instead when fixing something that should be kept
> private for the timing being: it will prevent the change for
> accidentally being exposed to the public through 'git send-email', as
> mails sent to that address are not delivered anywhere."""
> 
> The sign would not be that huge anymore, but I'm not sure if that makes
> any difference.

Yeah, let's leave this as-is for now.

> > That being said, it's good to have this documented now, thanks for it:
> 
> yw!
> 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Many thx for your feedback to this and the other patches. Do you want to
> pick those up (last time I changes something in that text that was the
> case) or let Jonathan handle them?

Which ever Jonathan finds easier is fine for me.

thanks,

greg k-h

