Return-Path: <linux-kernel+bounces-125266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9708892309
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497E3B22801
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B151137751;
	Fri, 29 Mar 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmZRNi0Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41106130AF3;
	Fri, 29 Mar 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734967; cv=none; b=hryTAwiIl8SoTxItjWJQQojmQ/jNxefRR1voTlkNtjUusFZz3lI5lJKBGzCENEWU2sVyYaF1OOuOfE52OlrDbMVJ3EUXOqit2z1GlA7qiaQ+qdgFvjvTgPJxVTn2ytS/Dt3VcLrExSiTBau/K+lQuhqgtjIPkmMsbeQg7o0VBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734967; c=relaxed/simple;
	bh=yfuKhVprgj4pAgBB42cQCWS7eNlorSnHhCe4eT1lj7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCugNndvcEGK1gzN9fxzHVhoPd3PGIm+vOhQSG2ZaCBigUdbqDnn6tBkxTurUDw4sdPgqfbPiUiF4GL2PZUOv6+LA5XHmr5ZoMdAqw4Bqkt+FLJDMHGrTu+c0AoW+EpjACT6QtoqDkL/d6iq6teSXXAQCBeJxrKtOG9ckqm/pdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmZRNi0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23524C433F1;
	Fri, 29 Mar 2024 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711734966;
	bh=yfuKhVprgj4pAgBB42cQCWS7eNlorSnHhCe4eT1lj7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmZRNi0ZOnkJ9M8iH5UR7WnsfFTkDNh9MDX6hFkzsgCy/ujN9OAm/W4Dmv89g6Gs3
	 1jMsTfLdThxBCdUtCuI2EcqjKXP54eBRgzuYMC7gWQJ1dbrhM9pymyX/b7qX30Xqgk
	 Bfm0u0ZJ55/ePlyfkKQ7VFLLYty6NGiVpVkkvQBM=
Date: Fri, 29 Mar 2024 18:56:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Borislav Petkov <bp@alien8.de>, stable@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "x86/sev: Fix position dependent variable
 references in startup code" failed to apply to 6.8-stable tree
Message-ID: <2024032942-implant-pyramid-e3cf@gregkh>
References: <20240327120810.2825990-1-sashal@kernel.org>
 <CAMj1kXGNneD2E=iGM18DMrAqKySi6JdDF-f-Sd+Vs036-_RL2g@mail.gmail.com>
 <2024032916-statue-skyrocket-af59@gregkh>
 <CAMj1kXEtH5NdRL2Ya3+h0wJqsLwQudNmfxepsw5x4hcS2K1T-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEtH5NdRL2Ya3+h0wJqsLwQudNmfxepsw5x4hcS2K1T-Q@mail.gmail.com>

On Fri, Mar 29, 2024 at 05:25:35PM +0200, Ard Biesheuvel wrote:
> On Fri, 29 Mar 2024 at 13:56, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 27, 2024 at 04:39:20PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 27 Mar 2024 at 14:08, Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > The patch below does not apply to the 6.8-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > >
> > >
> > > I will send the v6.8 backport separately right away.
> > >
> > > v6.7 and v6.6 can take this patch unmodified but will need to take
> > > 29956748339aa8757a7e2f927a8679dd08f24bb6 as a prerequisite first.
> >
> > Now done, thanks.
> >
> > > (v6.8 no longer applies because of the way Linus fixed up a merge
> > > conflict in the 6.8 cycle)
> >
> > I fixed this up by hand, hopefully got it right :)
> >
> 
> Thanks - I will double check once the patches are sent out.
> 
> > > v6.1 and older need separate backports so i will send those out later.
> >
> > Wonderful, thanks!
> >
> 
> I sent this out on Wednesday but I don't see them in lore. Please let
> me know if I should resend these.
> 
> [PATCH -stable-6.1 1/4] x86/coco: Export cc_vendor
> [PATCH -stable-6.1 2/4] x86/coco: Get rid of accessor functions
> [PATCH -stable-6.1 3/4] x86/Kconfig: Remove
> CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
> [PATCH -stable-6.1 4/4] x86/sev: Fix position dependent variable
> references in startup code

I can't see those anywhere, so yes, please resend as they are not in my
queue, or archive, at all.

thanks,

greg k-h

