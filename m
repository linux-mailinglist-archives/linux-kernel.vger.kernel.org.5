Return-Path: <linux-kernel+bounces-63617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C011C853255
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FA9284E26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F35647F;
	Tue, 13 Feb 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oOUclkgO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oVVngrqJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oOUclkgO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oVVngrqJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E86653814;
	Tue, 13 Feb 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832372; cv=none; b=I06Yt/qwj8ny570usbUCWjRJOVrbITskgbwiQ0KhQd2scu/d2jAy5j8q/CrhSrhYjSlEXV4k0Srkdk3ugRPn0+luf0H0mOi0LdZ4cRohWaY5Nw+TO7+z7Kr6kX/QJtBxgRLOt4pwKzvGzBdmYsPRQvMkGJJr9dfzL1hOf8qMjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832372; c=relaxed/simple;
	bh=tDYUYkwt0jWYmiGMewia3DcAp346T9qWYlapwc9BdYY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Df/lckvkieS56g/BFWM/dJl5mLnMf7vyfY+Uvo0iVehStb7ixzRJz5FTCgvfpDKzpXzm3HZqUaAtGu2a15QPH9vpFrPBcpjqwnYOF+h1HFtr70W6skOTyyi/OioVOKHvAaDdqQd2rznMTUbpkc0yPZ/Nu9q5OgED2MIvmTA/BWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oOUclkgO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oVVngrqJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oOUclkgO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oVVngrqJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82FAE1F7E0;
	Tue, 13 Feb 2024 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707832368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q8MfSjK7OYP4lN/v8gPjTRD3zGyOCoKTDfBuu++L2E=;
	b=oOUclkgOjJaWlyvC1GJ10bmTaiUtT8V3ET5t2lBxSSG3/uZ5pnGMGTjFDJFLbD0pQDNjnZ
	uTRddSNyR55o77Ft5aEiZcQPNJVYuAgMXl2o3U7d0qsxyj6TdFNx//wFeCBOo6EyP/arjk
	qddGd349OqYK888P1B61l/ZL1a78lU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707832368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q8MfSjK7OYP4lN/v8gPjTRD3zGyOCoKTDfBuu++L2E=;
	b=oVVngrqJEoPji8kvRfo1L9xO7Hhi3NEI9YX/M8RE3W3NOhXnASOrB8Q6cN+1D5BOWxYwdc
	RvZyAEmIc6b1iFDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707832368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q8MfSjK7OYP4lN/v8gPjTRD3zGyOCoKTDfBuu++L2E=;
	b=oOUclkgOjJaWlyvC1GJ10bmTaiUtT8V3ET5t2lBxSSG3/uZ5pnGMGTjFDJFLbD0pQDNjnZ
	uTRddSNyR55o77Ft5aEiZcQPNJVYuAgMXl2o3U7d0qsxyj6TdFNx//wFeCBOo6EyP/arjk
	qddGd349OqYK888P1B61l/ZL1a78lU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707832368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q8MfSjK7OYP4lN/v8gPjTRD3zGyOCoKTDfBuu++L2E=;
	b=oVVngrqJEoPji8kvRfo1L9xO7Hhi3NEI9YX/M8RE3W3NOhXnASOrB8Q6cN+1D5BOWxYwdc
	RvZyAEmIc6b1iFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 595781370C;
	Tue, 13 Feb 2024 13:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6tpAFTB0y2VgHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 13:52:48 +0000
Date: Tue, 13 Feb 2024 14:52:43 +0100
Message-ID: <87a5o4xyhg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Jaroslav Kysela" <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>,
	"Nathan Chancellor" <nathan@kernel.org>,
	"Nick Desaulniers" <ndesaulniers@google.com>,
	"Bill Wendling" <morbo@google.com>,
	"Justin Stitt" <justinstitt@google.com>,
	"Curtis Malainey" <cujomalainey@chromium.org>,
	"Dmitry Antipov" <dmantipov@yandex.ru>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: fix function cast warnings
In-Reply-To: <6a52b971-227b-4433-bdf9-b4a69a41d061@app.fastmail.com>
References: <20240213101020.459183-1-arnd@kernel.org>
	<87il2sy13f.wl-tiwai@suse.de>
	<6a52b971-227b-4433-bdf9-b4a69a41d061@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oOUclkgO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oVVngrqJ
X-Spamd-Result: default: False [-1.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,kernel.org,perex.cz,suse.com,google.com,chromium.org,yandex.ru,vger.kernel.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.35)[76.31%];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 82FAE1F7E0
X-Spam-Level: 
X-Spam-Score: -1.16
X-Spam-Flag: NO

On Tue, 13 Feb 2024 14:30:56 +0100,
Arnd Bergmann wrote:
> 
> On Tue, Feb 13, 2024, at 13:56, Takashi Iwai wrote:
> > On Tue, 13 Feb 2024 11:09:56 +0100,
> 
> >>  
> >> -int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
> >> -			const unsigned char *buffer, int count);
> >> +int snd_rawmidi_receive(void *ptr, const void *buffer, int count);
> >
> > If it were only about the type of the buffer argument being a void
> > pointer, it's fine.  But the substream argument should be explicitly
> > typed, otherwise it's confusing for other normal call patterns.
> >
> > I guess the suitable fix for now would be to provide wrapper functions
> > that are used for callbacks and bridge to the actual function with
> > pointer cast, something like below.  Eventually we can put more const,
> > but it's basically irrelevant with the warning itself.
> 
> Right, makes sense. I gave your patch a spin and it addresses the
> warnings I saw in randconfig builds, so please apply that with
> "Reported-by: Arnd Bergmann <arnd@arndb.de>".

OK, will do.


thanks,

Takashi

