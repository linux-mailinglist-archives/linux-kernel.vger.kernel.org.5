Return-Path: <linux-kernel+bounces-28952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606DB830519
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE83928A356
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A21DFEB;
	Wed, 17 Jan 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ljigv4sc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+b3bxON";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ljigv4sc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+b3bxON"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F731DFD8;
	Wed, 17 Jan 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494042; cv=none; b=uStTmKIXPBazywmuPQzjrpHuZAt/41g55dnQ96MJ5wda0WyWiU422mt4auIIVdeU4ot4eMde4E/nfSc0XCZhfwFxd1OlZekmTOkE50o07zBC75m5HqKFl5WUB6JrB1SiY9Xj4RA6orOkc63whNJ4wNkcuIYLhCMOnwWYQZGild4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494042; c=relaxed/simple;
	bh=kvuQd91UibBpv/YoNSlaRFBACpxT8wMIPJqpCOFwz64=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Flag:
	 X-Spamd-Bar; b=NWNMHeI4Y1wOZZPbcdYy1qjxJFM/WgQUrBQqCWMxo/VEbss8WE7jDvmt3hw9ymvjtukBJZ4yUH/Tm1YotLBlF+n17J18UPUoDGn2gU2dcx1FYC4gbj/24iP+0VVIXDbt3kWCLuo+7br/YYAk1p0YPL/TXjb8rIIlMAG7SxTGOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ljigv4sc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+b3bxON; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ljigv4sc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+b3bxON; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 507AD21D85;
	Wed, 17 Jan 2024 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705494039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLGpIPYXJCrNPm7cP6Ew/Lf4YTo0XXNlisREfXlhOMA=;
	b=ljigv4scmT/nmlsCBw5oegsmCtRCXyS0EHW9hN0bqKPslkF22t69CzpnZt/V558vFBE6il
	xgITtv+HQTGIZl9gA4FiuRTCGS+zv9B49B0JwSjAQDegithPuBdC28koJ96P9qCz2yrnFR
	mECFiB36M0u3lPTyh7wtWgOtjdVrYbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705494039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLGpIPYXJCrNPm7cP6Ew/Lf4YTo0XXNlisREfXlhOMA=;
	b=f+b3bxONxv4dCIo5h/8cCKttX+V2H9tzLpjYHnow/mRUgQ4GU2Lcd33tK+74JtK+C9Erwt
	HS0gDd/9H/+sXyCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705494039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLGpIPYXJCrNPm7cP6Ew/Lf4YTo0XXNlisREfXlhOMA=;
	b=ljigv4scmT/nmlsCBw5oegsmCtRCXyS0EHW9hN0bqKPslkF22t69CzpnZt/V558vFBE6il
	xgITtv+HQTGIZl9gA4FiuRTCGS+zv9B49B0JwSjAQDegithPuBdC28koJ96P9qCz2yrnFR
	mECFiB36M0u3lPTyh7wtWgOtjdVrYbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705494039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLGpIPYXJCrNPm7cP6Ew/Lf4YTo0XXNlisREfXlhOMA=;
	b=f+b3bxONxv4dCIo5h/8cCKttX+V2H9tzLpjYHnow/mRUgQ4GU2Lcd33tK+74JtK+C9Erwt
	HS0gDd/9H/+sXyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9EA313800;
	Wed, 17 Jan 2024 12:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Mp2MBbGp2XAVgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 12:20:38 +0000
Date: Wed, 17 Jan 2024 13:20:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: Add man-pages git tree
Message-ID: <20240117122037.GA2706720@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240117091903.2668916-1-pvorel@suse.cz>
 <ZafC1MkKDAK2s6n1@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafC1MkKDAK2s6n1@debian>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ljigv4sc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f+b3bxON
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.89%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 507AD21D85
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Hi Alex,

> Hi Petr,

> On Wed, Jan 17, 2024 at 10:19:03AM +0100, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 391bbb855cbe..571749fe9e38 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12833,6 +12833,7 @@ M:	Alejandro Colomar <alx@kernel.org>
> >  L:	linux-man@vger.kernel.org
> >  S:	Maintained
> >  W:	http://www.kernel.org/doc/man-pages
> > +T:	git git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

> And there's a secondary tree, at
> <git://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git>

OK, I'm going to send v2.

Kind regards,
Petr

> Have a lovely day,
> Alex

