Return-Path: <linux-kernel+bounces-51329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489F8489DA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5092D285241
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8664B399;
	Sun,  4 Feb 2024 00:16:51 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44280181
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707005811; cv=none; b=N5ZmgmKLqmTAQYNMw4cQApRnnYzzFBMId6OI6LKSlcgMz6SDbxLjYD/B1koaEaNr5XnDOaMzRGXK07drXWGRb6kQm/gF95ycInQLDctyp0+G+hzw2J5EKbLTOToOEJXBCRx2JABO14HId63nE73AXzbqCwvr2CLEAdughPlN0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707005811; c=relaxed/simple;
	bh=licWhbjcN3EFOqXDynleAY1ry+Keeno01HnMIFur7+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEz7CureDDRNITyRZnY1wSAzVEq0M2xtrHP0gCpOtfZhjcVgCxdfGZjcHqDS3khIoa46q5IE11Bf1VLXtK2cq2cVb/bkbxbmzuXIsIgHUoLvsGBWsbneaepuZn96BBRCIG/us2WYkbObQZ5kQ9GM4bRO+7QgTDXat488tPcTViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 86526A0174;
	Sun,  4 Feb 2024 01:16:46 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sCcj7J_Kdhpu; Sun,  4 Feb 2024 01:16:46 +0100 (CET)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 57BB2A011B;
	Sun,  4 Feb 2024 01:16:46 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rWQBh-000000042i0-2ZWx;
	Sun, 04 Feb 2024 01:16:45 +0100
Date: Sun, 4 Feb 2024 01:16:45 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH] speakup: Fix 8bit characters from direct synth
Message-ID: <20240204001645.oj44wnx3ifk2l7tg@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org
References: <20240203233600.gu4qci36fpnro3ui@begin>
 <2024020308-until-overact-a7b1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024020308-until-overact-a7b1@gregkh>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Greg KH, le sam. 03 févr. 2024 16:03:20 -0800, a ecrit:
> On Sun, Feb 04, 2024 at 12:36:00AM +0100, Samuel Thibault wrote:
> > When userland echoes 8bit characters to /dev/synth with e.g.
> > 
> > echo -e '\xe9' > /dev/synth
> > 
> > synth_write would get characters beyond 0x7f, and thus negative when
> > char is signed.  When given to synth_buffer_add which takes a u16, this
> > would sign-extend and produce a U+ffxy character rather than U+xy.
> > Users thus get garbled text instead of accents in their output.
> > 
> > Let's fix this by making sure that we read unsigned characters.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > Fixes: 89fc2ae80bb1 ("speakup: extend synth buffer to 16bit unicode characters")
> > Cc: stable@vger.kernel.org
> > 
> > ---
> >  drivers/accessibility/speakup/synth.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --- a/drivers/accessibility/speakup/synth.c
> > +++ b/drivers/accessibility/speakup/synth.c
> > @@ -208,8 +208,9 @@ void spk_do_flush(void)
> >  	wake_up_process(speakup_task);
> >  }
> >  
> > -void synth_write(const char *buf, size_t count)
> > +void synth_write(const char *_buf, size_t count)
> >  {
> > +	const unsigned char *buf = (const unsigned char *) _buf;
> >  	while (count--)
> >  		synth_buffer_add(*buf++);
> >  	synth_start();
> 
> Nit, I think you need a blank line after the new variable definition.

Ok.

> And why can't we just change these to be u8 instead of "char"?  Wouldn't
> that solve this issue overall better?

I was wondering, but an example of caller is synth_direct_store, which
calls string_unescape_any_inplace on the buffer, which does take a char*
and I guess won't change.

Samuel

