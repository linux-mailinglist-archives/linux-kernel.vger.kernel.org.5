Return-Path: <linux-kernel+bounces-90588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54AE8701C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8D2879D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01963D39A;
	Mon,  4 Mar 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HzA21dkH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yMcq3/+6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HzA21dkH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yMcq3/+6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056801E506;
	Mon,  4 Mar 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556335; cv=none; b=Gv5Hrm2r3Y0QNjPXcXHf46wdSs7v5/nwJMpWIqwOg4b+lD/3o5zELFaCmydn1Nl2A0ZigEHKP/PUjpXqIwUvdg16id51QNg9jp3Gy6J6a7aFdOvt/74Z16IcDzpInJZXggfMZk62M0yKX61MusPpCCY5BEa1bnD7ll1ZUOR/f+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556335; c=relaxed/simple;
	bh=hgg7ztDSEPRjWgfx5szBQ5vnIIPmCrUaIAUDotlaUXg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2z4dobhBt4jSQRzL2XeRMzeWZEC9MKJDOcQIjKqVuDWBp3CSOO36NxhPqD0VptQvVrhKm+cEdRPM4FmU5inWkAt2NpoR/BEqCPM7QYPHdyq26TwxjmJSTi2CI933FxUEbC7j/qYgxEqgn0Xzg4ADdL7tRc5x6/WNUBD4MGrd5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HzA21dkH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yMcq3/+6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HzA21dkH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yMcq3/+6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F04D4E584;
	Mon,  4 Mar 2024 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709556331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYwciqTpDEG3fTSKbV8dQHE0AxNIrAo1Mvf8rFjUd30=;
	b=HzA21dkHt6RNAEyo6l5tKymmNyJFSXhsUdamIt5gZkzy+u3wUfUomthDGaYE3soM+iIxDy
	p2F2SSvSe+3B35M0YEm/WhEXQHQVMMvEV6DqJDsS/au1NiUEnHF8Tw6OBoU893c1K5jWbt
	vD3FfunEe+nVZu5YRkHi1WO5tT4TyMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709556331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYwciqTpDEG3fTSKbV8dQHE0AxNIrAo1Mvf8rFjUd30=;
	b=yMcq3/+6vKMpWbQJqI6jPBF9+8N5EY9Rszo8BUWBqg/1og3OyCiUcWQHiFFrmu+RhW3GMG
	1CwLss5a8ILjj6Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709556331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYwciqTpDEG3fTSKbV8dQHE0AxNIrAo1Mvf8rFjUd30=;
	b=HzA21dkHt6RNAEyo6l5tKymmNyJFSXhsUdamIt5gZkzy+u3wUfUomthDGaYE3soM+iIxDy
	p2F2SSvSe+3B35M0YEm/WhEXQHQVMMvEV6DqJDsS/au1NiUEnHF8Tw6OBoU893c1K5jWbt
	vD3FfunEe+nVZu5YRkHi1WO5tT4TyMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709556331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYwciqTpDEG3fTSKbV8dQHE0AxNIrAo1Mvf8rFjUd30=;
	b=yMcq3/+6vKMpWbQJqI6jPBF9+8N5EY9Rszo8BUWBqg/1og3OyCiUcWQHiFFrmu+RhW3GMG
	1CwLss5a8ILjj6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFC4F13A5B;
	Mon,  4 Mar 2024 12:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9MgQOWrC5WVtOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 Mar 2024 12:45:30 +0000
Date: Mon, 04 Mar 2024 13:45:30 +0100
Message-ID: <874jdm17yt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Takashi Iwai <tiwai@suse.de>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Missing bcm5974 touchpad on Macbooks
In-Reply-To: <6ef6c5bf-e6e5-4711-81c6-6ae41de2e61e@wolfvision.net>
References: <87sf161jjc.wl-tiwai@suse.de>
	<6ef6c5bf-e6e5-4711-81c6-6ae41de2e61e@wolfvision.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,gmail.com,vger.kernel.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Mon, 04 Mar 2024 12:26:48 +0100,
Javier Carrasco wrote:
> 
> On 04.03.24 09:35, Takashi Iwai wrote:
> > Hi,
> > 
> > we've received a few regression reports for openSUSE Leap about the
> > missing touchpad on Macbooks.  After debugging, this turned out to be
> > the backport of the commit 2b9c3eb32a699acdd4784d6b93743271b4970899
> >     Input: bcm5974 - check endpoint type before starting traffic
> > 
> > And, the same regression was confirmed on the upstream 6.8-rc6
> > kernel.
> > 
> > Reverting the commit above fixes the problem, the touchpad reappears.
> > 
> > The detailed hardware info is found at:
> >   https://bugzilla.suse.com/show_bug.cgi?id=1220030
> > 
> > Feel free to join the bugzilla above, or let me know if you need
> > something for debugging, then I'll delegate on the bugzilla.
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> 
> Hi Takashi,
> 
> The commit adds a check to ensure that the endpoint type is interrupt.
> 
> According to that report, the issue arose with a MacBook Pro 5.1 (no
> button, only trackpad endpoint), so the check on the tp_ep address
> (0x81) returns false. I assume that you see an error message
> ("Unexpected non-int endpoint) and  the probe function fails returning
> -ENODEV.

Right, there is the message.

> Do you see any warning in the logs when you revert the commit? It was
> added to prevent using wrong endpoint types, which will display the
> following warning: "BOGUS urb xfer, pipe "some_number" != type
> "another_number""

The revert was tested on the downstream kernel, but it has also the
check of bogus pipe, and there was no such warning, as far as I see
the report.

> I am just wondering if for some reason the check on interrupt type is
> wrong here.

I'll ask reporters to give the lsusb -v output so that we can take a
deeper look.  Also, I'm building a test kernel based on 6.8-rc7 with
the revert, and ask reporters to test with it, just to be sure.


thanks,

Takashi

