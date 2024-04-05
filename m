Return-Path: <linux-kernel+bounces-132402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D486899415
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D287B1F2938C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CD01CA9C;
	Fri,  5 Apr 2024 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YqwwOncu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9446179AE;
	Fri,  5 Apr 2024 04:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291063; cv=none; b=d6B5MeOgFtaZR5aZC80NTWh2hkfv6ul5REnXgbB+CFjJxUNUfTmivGo2jTP1nlN72YKx7bU8mEo415gMVmgxRyr2nv0646TLU28Iqb72HiZwcoEmj49uSd1yYE398TPZsQpMqwQQLOXBuVzheSTJmJdLO0o3ayru8TSnsFJPtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291063; c=relaxed/simple;
	bh=9o5wV1QCfHYIihBN11+4AlJcAeE9VpigPCtQCauwoMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeR5BUWgGx+5FXvvAPIGekAYWBUYp3Z/SoVR09nNSuV8bm5t/CxGF25p/XhZQR/x6LK/d5Tw686Fi0dR5sfkYh657P5UWaYnf0YGuJ2vy1WInDOcMxhR/zGR6jPhXTqkwvcvPrnapfe0EAGokf783vGJ/rBuk+P+6FzbUfoEK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YqwwOncu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C3DC433C7;
	Fri,  5 Apr 2024 04:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712291063;
	bh=9o5wV1QCfHYIihBN11+4AlJcAeE9VpigPCtQCauwoMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqwwOncuPvRJ3sYN11TDbutjlc86ENu9qlDd8r32VYtv4n6tYxH/FtmsSMbF59iyN
	 TLuB9q9P2KdC4m9oHgFaBd3AB/rStiFLAy/RGTJN/QaDY3uZTjBlQQhp9cDuZuF7ce
	 7eoGdS+ZXV04x9uT/CcG8JKr2rgdUGMNxwdM5oXM=
Date: Fri, 5 Apr 2024 06:24:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do we need a "DoNotBackPort" tag?
Message-ID: <2024040537-expel-armband-406d@gregkh>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
 <ZgylCe48FuOKNWtM@slm.duckdns.org>
 <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>
 <2024040328-surfacing-breezy-34c6@gregkh>
 <Zg10Keik4KORjXMh@slm.duckdns.org>
 <2024040319-doorbell-ecosystem-7d31@gregkh>
 <dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info>
 <2024040454-playful-tainted-7446@gregkh>
 <8488e647-d2f4-484f-939f-eb827802d5c6@leemhuis.info>
 <20240405025439.GC13376@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405025439.GC13376@mit.edu>

On Thu, Apr 04, 2024 at 10:54:39PM -0400, Theodore Ts'o wrote:
> On Thu, Apr 04, 2024 at 05:56:58PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > 
> > I know, as I wrote that (as you likely remember). ;-) But it seems it's
> > not well known; and maybe making it explicit that this can be used to
> > convey a "DoNotBackport" message is supported as well.
> > 
> > Guess I'll prepare a patch to do that then and we'll see how it goes
> > from there.
> 
> Maybe something like "ManualBackportOnly"instead?   The basic idea is
> that it's not that the commit should *never* be backported, but only
> with human intervention where someone has specifically requested the
> backport, perhaps with qualification test.
> 
> (For example, the XFS file system has an implicit ManualBackportOnly
> on all commits, and the XFS stable maintainers are responsible for
> backporting identifying commits with Fixes: tags, and running QA
> before passing on a request to having them be backported.)

For drivers/subsystems/files that no one wants to have backported at all
UNLESS there is an explicit cc: stable tag, just email us at stable@vger
and let us know and we will add you to the list of files that we ignore
for this.  We keep that list in the stable-queue repo for anyone to see
if they are curious.

That's what xfs and bcachefs and kvm and mm and other subsystems have
done, that way they can tag things with "Fixes:" to their hearts content
and we just ignore them.

thanks,

greg k-h

