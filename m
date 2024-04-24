Return-Path: <linux-kernel+bounces-157657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0965A8B141F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6D51C20C10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F9D13CAA7;
	Wed, 24 Apr 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1dpd8WRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB45219EB;
	Wed, 24 Apr 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989279; cv=none; b=jXm2NH4HRFTAI/pbCmW6aLanPIUFv20Zexq2lJOLcMKQxJq6fGcqaKzUIs0cevX6UtPHZfJxu84CwQO6Utp4ZLh7VW7rLblRcxFbIWFpMvjMjXOeEtiWlLGODVySvEzDY7FmvAcQ54swGiDtmMIuL9h8WgxM5DvU7Q02o84tpwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989279; c=relaxed/simple;
	bh=U2jql2GRAVcGnBOhlYEwRu6ttg7w0mHZp7AwL1XkfH8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G8eFOzqp/zHwoYW7zM/PcAjWaHCf1bVdSCAlMIrE9JSlPFeWKG5AY7eS6KDFEKi6s1J5PHYFkphagxX2l8yO2G4lzSqUg9dUWzdjkm09RZh37CefYGtDlhP/7uAw/kScO3De7jACNALA7J4J3Jz8bzYkR9CUMRwlxrwxrJbS0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1dpd8WRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE2CC113CD;
	Wed, 24 Apr 2024 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713989279;
	bh=U2jql2GRAVcGnBOhlYEwRu6ttg7w0mHZp7AwL1XkfH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1dpd8WRDMsEcnoEThRMZSkXPq0kXG2c/yPLHq9xCgf2yUMQWPcXFwqjO/jcK+9/JC
	 z8DJY32IgNxBb8lNApA3BnAA8R2ejY8JOe0KeYBKr9XFsI8FJrP+j4qodXlb81OBBr
	 d/aQDYAL9EIcQ/+uBU4rmflOROCSvZMbisAPhRJg=
Date: Wed, 24 Apr 2024 13:07:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kent Overstreet
 <kent.overstreet@linux.dev>
Subject: Re: linux-next: manual merge of the modules tree with the mm tree
Message-Id: <20240424130757.531be2842c505a62246d180c@linux-foundation.org>
In-Reply-To: <20240424123935.2f65e886@canb.auug.org.au>
References: <20240424123935.2f65e886@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 12:39:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the modules tree got a conflict in:
> 
>   kernel/module/main.c
> 
> between commits:
> 
>   7f014cdda4cb ("lib: code tagging module support")
>   5ab9b0c7ea5c ("lib: prevent module unloading if memory is not freed")
> 
> from the mm-unstable branch of the mm tree and commits:
> 
>   0746f9982603 ("module: make module_memory_{alloc,free} more self-contained")
>   18da532eefc8 ("mm/execmem, arch: convert remaining overrides of module_alloc to execmem")
> 
> from the modules tree.
> 
> I fixed it up (I think, see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

That's a shame.  I don't see much that we can do to reduce the damage here.

Suren&Kent, please review (and preferably) test Stephen's handiwork in
linux-next?


