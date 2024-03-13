Return-Path: <linux-kernel+bounces-101631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B418187A9A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44949B233AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D277947F;
	Wed, 13 Mar 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VW3FX9Ns";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJF0v230"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB44409;
	Wed, 13 Mar 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340940; cv=none; b=W1j7eU45MoqGZI+d8TCIb7Q8KTJRh+iHy+D/MTavSolkL3PAjwf1aHKujr9P0iWFI+1pfKNJx8LmhgYHwV3iXyixJicncRRnZi8j/+uti6dDX0Os7PyiYxAD79cxb2+Q8OyWo5KdTAuJBWpCUIHqN6zLMaV9cTtNOPkdMfJzDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340940; c=relaxed/simple;
	bh=U5c5j9lYX0V5EhN9W9NhQsGKnW1C1zrts03VpAiVNg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTZso5yBGZ42NVgMn2jzfAV2AUkSAxTeLGvFdbE2rCDcuC9TJ7biDtglGmGuY9mWeCTBM+ua1qk9KNdBs2Ht5d50jKqY1oN8B3f1AsnIQn15tWS2wYlQHe4pAsWlyDcAS3REROu95sN78r+bxDwhmXvUIvU+TE2JdH+mRVwT8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VW3FX9Ns; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJF0v230; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 15:42:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710340937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s56+A8op/q+HdIVsDoLHkIGjaMoZ34ZrAuFSbXAA8e8=;
	b=VW3FX9Nszwew+ZNsV7lgDshx2B+dlyawq7UgJUNk0Ze3vwPeQ7rHGLQTw/Qw860mUSTaI8
	P+QUfJETXssHsJeBeZDkYBazeM16XBd98PYxMObxCBV7FBkVNgbDdmZMPLCjKv4PM2bV+u
	mr+3h9U+ugtJEBtZtlNVVVcZX/rIjQ8ml0QspNnZPm76EDN0KHVuc3STWS40Qe0blCvlAR
	u0sqxMSEzaj0MdFus/PVMhYagX7QSO4gDP5Bf3EQ6x1zB/1ZNOHfJqL6u3DRmxNDwX7ghx
	HvhaRxr5iskQXcW9fq+oOcIDoC9LyoHQVpu6F/dS6+EugIc7T8hVMACdwmB5Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710340937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s56+A8op/q+HdIVsDoLHkIGjaMoZ34ZrAuFSbXAA8e8=;
	b=yJF0v230JK9QRq95rjjeV7q+BlD834eJebMVfmXKyXIA6T5x/UcdXTnBBtvrRFh0x4oNEs
	xq/BYZE2Iq3+3RAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] gcc-plugins: disable plugins when gmp.h is
 unavailable
Message-ID: <20240313154111-53729221-b8fb-4969-ac4d-ea74861f6c84@linutronix.de>
References: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
 <20240312-gcc-plugins-gmp-v1-2-c5e082437b9e@linutronix.de>
 <202403121452.701C91AF6E@keescook>
 <CAK7LNAQ=aSqUUStN_M8QVqeS9R1QVM5CPq7=kzpY0z060XJFDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQ=aSqUUStN_M8QVqeS9R1QVM5CPq7=kzpY0z060XJFDA@mail.gmail.com>

On Wed, Mar 13, 2024 at 12:47:59PM +0900, Masahiro Yamada wrote:
> On Wed, Mar 13, 2024 at 6:53 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Mar 12, 2024 at 04:03:30PM +0100, Thomas Weißschuh wrote:
> > > The header gmp.h is meant to be picked up from the host system.
> > >
> > > When it is unavailable the plugin build fails:
> > >
> > > In file included from ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13.2.0/plugin/include/gcc-plugin.h:28,
> > >                  from ../scripts/gcc-plugins/gcc-common.h:7,
> > >                  from ../scripts/gcc-plugins/stackleak_plugin.c:30:
> > > ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13.2.0/plugin/include/system.h:703:10: fatal error: gmp.h: No such file or directory
> > >   703 | #include <gmp.h>
> > >       |          ^~~~~~~
> > >
> > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > >  scripts/gcc-plugins/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> > > index e383cda05367..a664fb5cdde5 100644
> > > --- a/scripts/gcc-plugins/Kconfig
> > > +++ b/scripts/gcc-plugins/Kconfig
> > > @@ -10,6 +10,7 @@ menuconfig GCC_PLUGINS
> > >       depends on HAVE_GCC_PLUGINS
> > >       depends on CC_IS_GCC
> > >       depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)
> > > +     depends on $(host-cc-option,-include gmp.h)
> >
> > Why does the prior depends not fail? That's where plugin detection is
> > happening.
> >
> > --
> > Kees Cook
> 
> This patch set should be rejected.
> 
> 
> It was already discussed in the past.
> Just install a proper package, then gcc-plugin will work.
> 
> https://lore.kernel.org/all/CAHk-=wjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV4K6WYg@mail.gmail.com/

Thanks for the pointer.

As there is already consensus I agree that the patches should not be used.

Thomas

