Return-Path: <linux-kernel+bounces-29001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57983068C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DFF287652
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89551EB32;
	Wed, 17 Jan 2024 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YJcMqHZX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qv238zkP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YJcMqHZX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qv238zkP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF91F5E4;
	Wed, 17 Jan 2024 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496666; cv=none; b=FCpKaNFvY1r3NOQ08aeOTDpFEpcF6ZPHOYIiU+DU8PDFJWAmpZ6nDAnhGGQbVUoiMHuUSgmzv9FTBiVNe+kT+xhLdpiEf5n0I39tsYZS7Xt7PzbSU4g9Xy8uqO73A2DLN43eEMk+eUZyXKAaJ5eYG79Z8u5wva0hT33pGXQ2Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496666; c=relaxed/simple;
	bh=1R2HZrvhp3KGom/Ay0gBer7DWNBPzHmKQrXQrLaX39o=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=nyYNNPM32R3XHoxMdOdhPj42JG5YYVS6k0OkvdgCaxBDpkyCSFwMq8hmlANbJ4DXxavoV4/UrwisYrSiVYGPZGn++1R3sOzeL8hL+SO48z4oeuE3rQsCjKwDJBp9+JTNwtzpnP4deW5gOqQ69Qmuu4WepLQF15Htc99xaMVkHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YJcMqHZX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qv238zkP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YJcMqHZX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qv238zkP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2619622255;
	Wed, 17 Jan 2024 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705496662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlPrrvZB1x28a4WGN8IeT0/QmFSzTIfNiilDMxfO5Rs=;
	b=YJcMqHZXKlyH/FRfDMmTsYnI9Jm2EclpERipdemOUfe2FCRLEhSP/ewkuS2H+gZ3ip804y
	lofBlVkomrGQh20iL4Ic626Yl2lVQReKp9sydPGWBr3+pvtPTlCAjk5slDQaDEw9P2XA7W
	HQ2a/0s+6jzmObw2ecNYHkiah88h3qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705496662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlPrrvZB1x28a4WGN8IeT0/QmFSzTIfNiilDMxfO5Rs=;
	b=Qv238zkPk06bZ8SrcG2t67z7xrgGu76moeH3+qjPoLlsRMI5TZAisZ0Nx/ARxzEikeOGT5
	PZZ7W/yh1tUfwmAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705496662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlPrrvZB1x28a4WGN8IeT0/QmFSzTIfNiilDMxfO5Rs=;
	b=YJcMqHZXKlyH/FRfDMmTsYnI9Jm2EclpERipdemOUfe2FCRLEhSP/ewkuS2H+gZ3ip804y
	lofBlVkomrGQh20iL4Ic626Yl2lVQReKp9sydPGWBr3+pvtPTlCAjk5slDQaDEw9P2XA7W
	HQ2a/0s+6jzmObw2ecNYHkiah88h3qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705496662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlPrrvZB1x28a4WGN8IeT0/QmFSzTIfNiilDMxfO5Rs=;
	b=Qv238zkPk06bZ8SrcG2t67z7xrgGu76moeH3+qjPoLlsRMI5TZAisZ0Nx/ARxzEikeOGT5
	PZZ7W/yh1tUfwmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E56AB13800;
	Wed, 17 Jan 2024 13:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aR7eNVXQp2XsZQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 13:04:21 +0000
Date: Wed, 17 Jan 2024 14:04:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add man-pages git trees
Message-ID: <20240117130420.GA2711070@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240117122257.2707637-1-pvorel@suse.cz>
 <ZafHChsGiKCLh9od@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafHChsGiKCLh9od@debian>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.52
X-Spamd-Result: default: False [-0.52 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.25%]
X-Spam-Flag: NO

> On Wed, Jan 17, 2024 at 01:22:57PM +0100, Petr Vorel wrote:
> > The maintainer uses both.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Reviewed-by: Alejandro Colomar <alx@kernel.org>

Thanks!

> (We sent it almost at the same time.  :)

Ah, sorry for not checking the ML. I should just ask you to add it yourself.

Kind regards,
Petr

> > ---
> > Changes v1->v2:
> > * Add a second tree

> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 391bbb855cbe..3f6a19f3e5e0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12833,6 +12833,8 @@ M:	Alejandro Colomar <alx@kernel.org>
> >  L:	linux-man@vger.kernel.org
> >  S:	Maintained
> >  W:	http://www.kernel.org/doc/man-pages
> > +T:	git git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> > +T:	git git://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git

> >  MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP)
> >  M:	Jeremy Kerr <jk@codeconstruct.com.au>
> > -- 
> > 2.43.0

