Return-Path: <linux-kernel+bounces-157685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E778B1497
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED861C21DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6C149C52;
	Wed, 24 Apr 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AydR2iiG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E911494C7;
	Wed, 24 Apr 2024 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990664; cv=none; b=it3+PMqNNPAT1pyFpsN+zBJTUxUR4c54uT3HFQ4z4XdC3WkrD6uxAwO7tWOYILb786ESc6x6LW4IloRr4aLvc3qceZmlk86tR/3N80rWM1nnNz3DFtepgnMKlZ+aEX7V1gzQqMZQ5PFB7xU4d/xxcLpU9++lzXW3d6mG5NMGBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990664; c=relaxed/simple;
	bh=X3+SR8L93hd/tQzhXVvjIe+Gst0XwlZvwU45CVj7bI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToG8Lqbvskh7AnEdjntJo4ZPO2aNa2qa9ofE3GaM5en5DyFq7kI3mjpwnFaZwASh9qZk6TcbPUWQWDVKtvZG+pxwFdZyCgEaO7WBsTzSjIAr3wRS/a7zj1x5ZFkeCgrnHq46F92uKeOiAq+UfYSyOR06PXQ7qhvjtsnWuAvqnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AydR2iiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A28C113CD;
	Wed, 24 Apr 2024 20:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713990663;
	bh=X3+SR8L93hd/tQzhXVvjIe+Gst0XwlZvwU45CVj7bI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AydR2iiGO57EJd086JSzW562kfLj8xEFSWgidXf21z0DdtTbiDBzLlxd7KsSR4pZI
	 AYDKj3uv5rl8IRuccwtg6NuRVrHO9a4MamG913fvV30X8XnYGY2zcZnr6CiKh9pDMk
	 rRrz7UaCsBjJfnGF7REcxB7A8dzqd/zLHxWwNbTTAGU5gE51R3CcP4zqZaAKe0He8G
	 cb8QAiTZxKa2lGUaUDEinvnm661lfCN8LMmiiBqXNjgtovSFFibliEVknRZOWX0A3+
	 /bwlrX4rLx0YEKTYgAtIwJabx/BxI0LS6ZCn3pNR9qhvcWcqAbzdtwcwfzFE3xXPIM
	 Pq00/rLMkb7EQ==
Date: Wed, 24 Apr 2024 23:29:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: linux-next: manual merge of the modules tree with the mm tree
Message-ID: <ZilrutXaEB0laSvr@kernel.org>
References: <20240424123935.2f65e886@canb.auug.org.au>
 <20240424130757.531be2842c505a62246d180c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424130757.531be2842c505a62246d180c@linux-foundation.org>

On Wed, Apr 24, 2024 at 01:07:57PM -0700, Andrew Morton wrote:
> On Wed, 24 Apr 2024 12:39:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > Today's linux-next merge of the modules tree got a conflict in:
> > 
> >   kernel/module/main.c
> > 
> > between commits:
> > 
> >   7f014cdda4cb ("lib: code tagging module support")
> >   5ab9b0c7ea5c ("lib: prevent module unloading if memory is not freed")
> > 
> > from the mm-unstable branch of the mm tree and commits:
> > 
> >   0746f9982603 ("module: make module_memory_{alloc,free} more self-contained")
> >   18da532eefc8 ("mm/execmem, arch: convert remaining overrides of module_alloc to execmem")
> > 
> > from the modules tree.
> > 
> > I fixed it up (I think, see below) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> 
> That's a shame.  I don't see much that we can do to reduce the damage here.

I can rebase it on mm-unstable and this can go via the mm tree.
 
> Suren&Kent, please review (and preferably) test Stephen's handiwork in
> linux-next?
> 

-- 
Sincerely yours,
Mike.

