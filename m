Return-Path: <linux-kernel+bounces-28696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D278301F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937D11F277DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4359134D3;
	Wed, 17 Jan 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="08dFBzXg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbOjr/Va";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="08dFBzXg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbOjr/Va"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78612B87;
	Wed, 17 Jan 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482904; cv=none; b=r20frNf+URdztRRAAVlP37TvdJrnBt+i8gjrao6WXY9ml5foWntvctoF/8AngDGhON4h2hiMUgBCKjrHMRxSJwgvK+lbRtRy4OPmlnauVrkCanfh29OLhnsK59dEGFCwJ9Z/PhEkrP5BkE22Ew3HPeZR5nWFg02+Ba9k4tgp+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482904; c=relaxed/simple;
	bh=Q08/0JPUmIF735thgSiaVRZ0/n+iC0wKqyNqiaQTRFg=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=t4/HjmfyFDatEDKso0hDGIBER4GWgBYSJRGCuF0mjblBMnUyKlC61RoM16uZeNAYGYtwkT5eSJy6wSxNKSufSTkq2n4L4Vz0E1N+x/yNACQb1P2DIZZ/FKeJIpRmtOiRp5SZMHD9XykRf6JceHN+8b77ab/draMWIvsKy/fQ2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=08dFBzXg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbOjr/Va; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=08dFBzXg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbOjr/Va; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C65C21FCD;
	Wed, 17 Jan 2024 09:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705482894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5zaWhkvNJdBjASJuwpU3R0cBDYHMrXzV9WEzpYwfmw=;
	b=08dFBzXgiQcE1i2hs0Fm5UkqqLW8hPMRXWciY5xmruF5ZOkZm++PsoMJ0KuLh0BFebuS5+
	jBCguZCyj7BvOkJL/mQkvEnHkeF/dPka72G9rUULvlvihfz2JrjH0c6GnvsjT6sxUpnoaU
	/ARfTChNZLhp/1TH9IyEZMeRPBu3ugQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705482894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5zaWhkvNJdBjASJuwpU3R0cBDYHMrXzV9WEzpYwfmw=;
	b=rbOjr/VaeEC81vSd6ewwPHV/noSE8NXRAnsTQXHx6eab+mkd8gtLftkbyMS4nvn7S0+zJP
	OwBakJJznCCNmsAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705482894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5zaWhkvNJdBjASJuwpU3R0cBDYHMrXzV9WEzpYwfmw=;
	b=08dFBzXgiQcE1i2hs0Fm5UkqqLW8hPMRXWciY5xmruF5ZOkZm++PsoMJ0KuLh0BFebuS5+
	jBCguZCyj7BvOkJL/mQkvEnHkeF/dPka72G9rUULvlvihfz2JrjH0c6GnvsjT6sxUpnoaU
	/ARfTChNZLhp/1TH9IyEZMeRPBu3ugQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705482894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5zaWhkvNJdBjASJuwpU3R0cBDYHMrXzV9WEzpYwfmw=;
	b=rbOjr/VaeEC81vSd6ewwPHV/noSE8NXRAnsTQXHx6eab+mkd8gtLftkbyMS4nvn7S0+zJP
	OwBakJJznCCNmsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1C6B137EB;
	Wed, 17 Jan 2024 09:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0mrONI2ap2WUFgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 09:14:53 +0000
Date: Wed, 17 Jan 2024 10:14:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org,
	Maciej =?iso-8859-2?Q?=AFenczykowski?= <maze@google.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Matthias Gerstner <matthias.gerstner@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [PATCH 1/1] socket.7: Mention CAP_NET_RAW on SO_MARK
Message-ID: <20240117091452.GB2665992@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240116110418.2577798-1-pvorel@suse.cz>
 <ZaadPmLFCI4rsGy_@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaadPmLFCI4rsGy_@debian>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=08dFBzXg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="rbOjr/Va"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.30 / 50.00];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.09)[64.27%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.30
X-Rspamd-Queue-Id: 5C65C21FCD
X-Spam-Flag: NO

Hi Alex,

> Hi Petr,

> On Tue, Jan 16, 2024 at 12:04:18PM +0100, Petr Vorel wrote:
> > Added in 079925cce1d0 ("net: allow SO_MARK with CAP_NET_RAW") in v5.17.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Patch applied.  Thanks!

Thank you! BTW I don't see this patch in git tree [1], maybe you just haven't
push yet.

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/


> Have a lovely day,
> Alex

> > ---
> >  man7/socket.7 | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)

> > diff --git a/man7/socket.7 b/man7/socket.7
> > index 3ff8fe51b..3ebfc770b 100644
> > --- a/man7/socket.7
> > +++ b/man7/socket.7
> > @@ -614,7 +614,9 @@ Changing the mark can be used for mark-based
> >  routing without netfilter or for packet filtering.
> >  Setting this option requires the
> >  .B CAP_NET_ADMIN
> > -capability.
> > +or
> > +.B CAP_NET_RAW
> > +(since Linux 5.17) capability.
> >  .TP
> >  .B SO_OOBINLINE
> >  If this option is enabled,
> > -- 
> > 2.43.0

