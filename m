Return-Path: <linux-kernel+bounces-130821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E7897D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89503B27215
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9116107A0;
	Thu,  4 Apr 2024 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="LkaQGJSn";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="nFOpUmy9"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3388C06;
	Thu,  4 Apr 2024 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712195096; cv=none; b=BRVmNDxC1nGfdbWlTzN7Carsj/GdYKYcPv4mZHD/8dEkAqreQcgKuss0CO+JZ3LuO9Js0RBrO6v2iX+CbM7asmol9Ne4ZXO4Pn+/N6/yZfnQLZxRv/mGpHA2UIbI35A61/3hiBfPRFGIzCe9Gpmxrim2Jb9J0P2Kd9iK++LNXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712195096; c=relaxed/simple;
	bh=dMoH9Vg+1Bi3+7AR8WsjQXWDweoU4Re7EGLQUJCnPVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c23w4dR0lROrmkzaznBgxoTigouiR6tX4YcB21wJLzadgilX5lOXa3XoPqIEfwylXi4OvN394TRWfG3FBmL4RBsRSxXVzbbqJeaaON4xQHQDZQO5OFM84JJBml5tPEJNdK8OsCvk81AVcQ+GKiXZdCochSMHXTq0Pr7jAcR1Ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=LkaQGJSn; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=nFOpUmy9; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id A95DEC01C; Thu,  4 Apr 2024 03:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712195091; bh=ez7RpFFtNKkVqgyN8ik0uVaRLnZQHr9zXjg8W/RjfrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkaQGJSnc5ct2Z3qaLSkZIIdfNRzUaEqKX4906Y0PACWKT+oysGhcpm2IT26DnSUw
	 +AkqTkjeAh2D4E6/nSkY5T8QHeUV7c0lkWMw4Sm4Qp3f5btXOcxR7R6bq+kb4/fmr8
	 cBZ9P6X0CyAsKAhAu0ztG4PkAr5YAZp1sW4s4bWbL9Z2Qbwlw72XOvB7qf0O+Yg+sq
	 BJc3xwCZNmDvfRu/ApXEnDv4cd7Md1oDzWw3ED2u0xbXl21sB0zkYnS+eGn0sbcsAu
	 2rwyVUMU+C+iSt7dWdj56lcq2sYx3AlbjzmoKLeRYDpRxt9cGaj9loaWau0QfcQyhk
	 rtUSGJBcBU88w==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 95772C009;
	Thu,  4 Apr 2024 03:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712195082; bh=ez7RpFFtNKkVqgyN8ik0uVaRLnZQHr9zXjg8W/RjfrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFOpUmy9/qmhd9FhI5UhJqXKtDbIGFdej4Ju04nXmL2hauo7GtXoXCQW5MsRyZWf5
	 oSAw6ATX850yI6ym7nY3207aFy+7o5KVaj2xVuscNfAMU6gMHID6j5E132Dq45ldqB
	 vg2fYfXzSmbw5IpMsGCz3N9kCn/OIBAUBNxJJn8jw111WIjBNVufq1BQsf3ZvrFpxQ
	 z7L1LiObxOsBsq7c2zeAaSk1oFfKg+42yvk9o4fldvUdvOLIHEQZkLioVM+CxpulTn
	 eXI0XnXsRteJzOg39vufAUm9y1bufp6pE5iJFTmb2cKbb0hDvhllTbC7b9sWoJ08J2
	 5wfcn1Wv0Qblg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id bd0225a9;
	Thu, 4 Apr 2024 01:44:36 +0000 (UTC)
Date: Thu, 4 Apr 2024 10:44:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <Zg4F9SAGNcmKIa1v@codewreck.org>
References: <20240404101038.11486a24@canb.auug.org.au>
 <Zg3tWULD56chInTG@codewreck.org>
 <5f56a81b-ac8a-417c-85ad-149f9f64649b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f56a81b-ac8a-417c-85ad-149f9f64649b@infradead.org>

Randy Dunlap wrote on Wed, Apr 03, 2024 at 05:21:01PM -0700:
> > [off topic, I just spent 10 minutes looking for the list of urls of the
> > repos merged into linux-next to check that 'vfs-brauner' tree commit as
> > it doesn't appear to be in next yet, and couldn't find it as there's no
> > "Merge branch x of ...brauner" commit in next at the moment.
> > I'm sure it's there somewhere and I didn't look at the right place, but
> > perhaps a link to such a list could be added to either of the following
> > (which all describe linux-next to some level):
> > - https://www.kernel.org/doc/man-pages/linux-next.html
> > - Documentation/process/howto.rst
> > - Documentation/process/2.Process.rst
> > /off topic]
> 
> If you look in the Next subdir in a linux-next tree, for 20240403 it shows:
> 
> vfs-brauner	git	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git#vfs.all
> 
> in the Trees file and in the merge.log file it shows:
> 
> Merging vfs-brauner/vfs.all (35c44ac8370a Merge branch 'vfs.mount.api' into vfs.all)
> $ git merge -m Merge branch 'vfs.all' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-brauner/vfs.all

Thank you, I wasn't aware of this Next directory -- I'll definitely
look there next!


So these two commits content is identical but they are completly
different patches from different authors (I was wondering about the
different subject), and David never sent it as is to me as it was part
of another commit[1] and I guess the other half got dropped on a rebase
and I didn't notice the overlap...

[1] https://lkml.kernel.org/r/20240328163424.2781320-3-dhowells@redhat.com

Given this I'd favor keeping Randy's older commit in my tree, so I'll
send it to Linus as soon as Christian gives his ok on dropping the
patch (or I guess it doesn't really make that much sense to wait any
longer at this point?)

Thanks,
-- 
Dominique Martinet | Asmadeus

