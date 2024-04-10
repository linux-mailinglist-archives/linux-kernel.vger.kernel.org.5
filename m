Return-Path: <linux-kernel+bounces-139049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B725489FDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DAA1C2205A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E117BB02;
	Wed, 10 Apr 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZnTku62o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B717BB05;
	Wed, 10 Apr 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769067; cv=none; b=V3SdrRAbuTSisGadFvug41mw9YWew2E6a3iSwTP3FiWzO6PPTDP2kupxo2/m27unLNyoEUWBwXGCfjf8H7Qlk3Fa7trMwTlubBJ1iO4XQS8+Z18KQo8R2Lea8yiKcXJyg/lGg1shcrgxOT5G/X6KaApwWZFePObGfVa7x/2nV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769067; c=relaxed/simple;
	bh=ZGMs4eaw7dazW68rXM4OhUV3d8QFUB+5AWT1J8PJOOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abwVUnv8nNgZVUGZkaxLRcXHCD16NWZlbcVqRvLFHmUdHjk0jPAKNhWznd+CkLZxZY7KOWb1SZmflQil+zxOpaQhGfDjiE7JiRdoavw0SmgNqqiuK8peBpcNI1TRIVfhgz23UX53qLz5osB2j3hRloYwQpp8eCCaYI4j13dQ5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZnTku62o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A503BC433F1;
	Wed, 10 Apr 2024 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712769067;
	bh=ZGMs4eaw7dazW68rXM4OhUV3d8QFUB+5AWT1J8PJOOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnTku62oSu7dzbXbtHbKdxdkZCjWSlQNPYz08CqnLdYPDMoHOvRdowI3qIZEDv+Kd
	 FEWutw6k+OWB7ROvHbbUJhZdiv/Io/ybnrUY3zzG6JF9ZukipycH0eOs31K8DHk66Q
	 0ieea41dUD4O24dSNLKPn0s7FRDHoryWqXvVX9+I=
Date: Wed, 10 Apr 2024 19:11:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev, linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: Re: [RESEND PATCH v3 1/2] VT: Add KDFONTINFO ioctl
Message-ID: <2024041027-overload-striking-c9a5@gregkh>
References: <cover.1710252966.git.legion@kernel.org>
 <cover.1712053848.git.legion@kernel.org>
 <ed056326540f04b72c97a276fbcc316e1b2f6371.1712053848.git.legion@kernel.org>
 <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
 <ZgwF72yHH_0-A4FW@example.org>
 <6bb4f4fb-573c-4f63-967c-2cb08514fc91@kernel.org>
 <Zha-X8QS_8L9eF0r@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zha-X8QS_8L9eF0r@example.org>

On Wed, Apr 10, 2024 at 06:29:19PM +0200, Alexey Gladkov wrote:
> On Wed, Apr 03, 2024 at 07:27:55AM +0200, Jiri Slaby wrote:
> > On 02. 04. 24, 15:19, Alexey Gladkov wrote:
> > >>> --- a/include/uapi/linux/kd.h
> > >>> +++ b/include/uapi/linux/kd.h
> > ...
> > >>> +struct console_font_info {
> > >>> +	unsigned int min_width, min_height;	/* minimal font size */
> > >>> +	unsigned int max_width, max_height;	/* maximum font size */
> > >>> +	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */
> > >>
> > >> This does not look like a well-defined™ and extendable uapi structure.
> > >> While it won't change anything here, still use fixed-length __u32.
> > >>
> > >> And you should perhaps add some reserved fields. Do not repeat the same
> > >> mistakes as your predecessors with the current kd uapi.
> > > 
> > > I thought about it, but I thought it would be overengineering.
> > 
> > It would not. UAPI structs are set in stone once released.
> > 
> > And in this case, it's likely you would want to know more info about 
> > fonts in the future.
> > 
> > > Can you suggest how best to do this?
> > 
> > Given you have flags in there already (to state that the structure 
> > contains more), just add an array of u32 reserved[] space. 3 or 5, I 
> > would say (to align the struct to 64bit).
> 
> struct console_font_info {
>        __u32 min_width, min_height;    /* minimal font size */
>        __u32 max_width, max_height;    /* maximum font size */
>        __u32  flags;                   /* KD_FONT_INFO_FLAG_* */
>        __u32 reserved[5];              /* This field is reserved forfuture use. Must be 0. */
> };
> 
> So, struct should be like this ?
> 
> I wouldn't add the version to the flags. Maybe it would be better to add a
> separate field with the version?

Versions do not work for ioctls, just use flags for stuff.  And you
might want to put flags first?

thanks,

greg k-h

