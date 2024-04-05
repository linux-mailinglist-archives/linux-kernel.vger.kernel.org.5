Return-Path: <linux-kernel+bounces-132867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD2899B71
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6241F214D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029916C43C;
	Fri,  5 Apr 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thiYcObJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93416C42D;
	Fri,  5 Apr 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314634; cv=none; b=ILQ/z+lsC/SBKflND9wx2cxyT3svPR3Chu7TnoJu+eXJKtcwwKF2wPhm81lBYA/jSq8dX4506Q1/O/KuuaywAswWqbRxy4w/7JwU4saGD3/q6oVoUipzQZzUevHr+hDHo0jhY8tc3OmB5MhM6WxYY7yhlm9SlNzeBNuV8qYyGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314634; c=relaxed/simple;
	bh=Xxn1NGkypp5P8z4HXd03oWTCZ2Bo1W8oA5c5ZlQz8xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uArHtp1Nr9BRBgJXExWPFvoIg5PyKJ/4ea+dCcldWts1y+2y+5SA3pd4+qMma8yczI8q6THN8rNN7NHzdihX3aaJubAum3uIfJAHyTTZPtVDMJ5DS5M9PeteHOjnN8Gyvfx7gGgrBN+B/Rdpgs57UtNY+yOyKEuu718zzbmyxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thiYcObJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C57DC43601;
	Fri,  5 Apr 2024 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314634;
	bh=Xxn1NGkypp5P8z4HXd03oWTCZ2Bo1W8oA5c5ZlQz8xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thiYcObJGO771zqY7FKooVjNcIEl5VihES03Q2bJIGkHn0qCkBYAVbnLtKjavvj71
	 ox5/uds0ETw5mlzefrkjrY7IW0FHfOTxxTUqtk1jCnDN31OAi0uIKjaRB09CVPR7wM
	 VgHMwK/q+zBXr42+5dStw4Ocr3Jytw9a0pNmNiUsXIZhNg3h9V1aQnG+/4Ccfl5oiW
	 na3Xtx3kBhdp/v7V500DEGpOQZe5xXaQapzbJ0Q+tzZpT70fzZCqD/vE/g1u6xGfon
	 F54x34Wo9Kd4AjjxiHoO707t8JyAp+dcLR2ua5G/eTPklUmhQz2A2R3WmAsh46+Rf5
	 D6Hk+BIxJ61iw==
Date: Fri, 5 Apr 2024 12:57:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>, 
	David Howells <dhowells@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <20240405-entkleidet-performanz-2f46c4f67751@brauner>
References: <20240404101038.11486a24@canb.auug.org.au>
 <Zg3tWULD56chInTG@codewreck.org>
 <5f56a81b-ac8a-417c-85ad-149f9f64649b@infradead.org>
 <Zg4F9SAGNcmKIa1v@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zg4F9SAGNcmKIa1v@codewreck.org>

On Thu, Apr 04, 2024 at 10:44:21AM +0900, Dominique Martinet wrote:
> Randy Dunlap wrote on Wed, Apr 03, 2024 at 05:21:01PM -0700:
> > > [off topic, I just spent 10 minutes looking for the list of urls of the
> > > repos merged into linux-next to check that 'vfs-brauner' tree commit as
> > > it doesn't appear to be in next yet, and couldn't find it as there's no
> > > "Merge branch x of ...brauner" commit in next at the moment.
> > > I'm sure it's there somewhere and I didn't look at the right place, but
> > > perhaps a link to such a list could be added to either of the following
> > > (which all describe linux-next to some level):
> > > - https://www.kernel.org/doc/man-pages/linux-next.html
> > > - Documentation/process/howto.rst
> > > - Documentation/process/2.Process.rst
> > > /off topic]
> > 
> > If you look in the Next subdir in a linux-next tree, for 20240403 it shows:
> > 
> > vfs-brauner	git	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git#vfs.all
> > 
> > in the Trees file and in the merge.log file it shows:
> > 
> > Merging vfs-brauner/vfs.all (35c44ac8370a Merge branch 'vfs.mount.api' into vfs.all)
> > $ git merge -m Merge branch 'vfs.all' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-brauner/vfs.all
> 
> Thank you, I wasn't aware of this Next directory -- I'll definitely
> look there next!
> 
> 
> So these two commits content is identical but they are completly
> different patches from different authors (I was wondering about the
> different subject), and David never sent it as is to me as it was part
> of another commit[1] and I guess the other half got dropped on a rebase
> and I didn't notice the overlap...
> 
> [1] https://lkml.kernel.org/r/20240328163424.2781320-3-dhowells@redhat.com
> 
> Given this I'd favor keeping Randy's older commit in my tree, so I'll
> send it to Linus as soon as Christian gives his ok on dropping the
> patch (or I guess it doesn't really make that much sense to wait any
> longer at this point?)

The patches are part of David's larger netfs-writeback series afaict.
So what patch do you need dropped?

