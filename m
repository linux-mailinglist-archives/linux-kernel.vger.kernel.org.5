Return-Path: <linux-kernel+bounces-23182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A082A8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B93282094
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEEFD528;
	Thu, 11 Jan 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MkcXV7QH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="raBg4Mh0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MkcXV7QH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="raBg4Mh0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1AD2FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30FC121C9A;
	Thu, 11 Jan 2024 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704960282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrlouPu7lYbcAZ19XcJtQf5G/BZvUSRNLHHXsJSm7L8=;
	b=MkcXV7QHPBmxYpq98MNfbOA3DWKC8ePOXqnroMeWRr0H7pkKlIVP9gysf2KmSeozT9QQs0
	s8KMJC34Bd8WvVipoIph2ToNHGr7iPODX8na2dvdFtpCDn4rE3TFSDbeqBxV9UYdgfhIxj
	w9ni6C+tJtnxyvKFF/LEXsMHupG7aHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704960282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrlouPu7lYbcAZ19XcJtQf5G/BZvUSRNLHHXsJSm7L8=;
	b=raBg4Mh0V1rLVyPJ4QttefO8fNJCcNZVkVvcYP0SQrwuQfPlkxhrBBxjkkwcb2In1/OJfP
	eUCSGyfaMUhplGCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704960282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrlouPu7lYbcAZ19XcJtQf5G/BZvUSRNLHHXsJSm7L8=;
	b=MkcXV7QHPBmxYpq98MNfbOA3DWKC8ePOXqnroMeWRr0H7pkKlIVP9gysf2KmSeozT9QQs0
	s8KMJC34Bd8WvVipoIph2ToNHGr7iPODX8na2dvdFtpCDn4rE3TFSDbeqBxV9UYdgfhIxj
	w9ni6C+tJtnxyvKFF/LEXsMHupG7aHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704960282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrlouPu7lYbcAZ19XcJtQf5G/BZvUSRNLHHXsJSm7L8=;
	b=raBg4Mh0V1rLVyPJ4QttefO8fNJCcNZVkVvcYP0SQrwuQfPlkxhrBBxjkkwcb2In1/OJfP
	eUCSGyfaMUhplGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD17813635;
	Thu, 11 Jan 2024 08:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bz6nLBqhn2X0ZQAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Thu, 11 Jan 2024 08:04:42 +0000
Date: Thu, 11 Jan 2024 09:06:34 +0100
From: Andreas Herrmann <aherrmann@suse.de>
To: Neal Gompa <neal@gompa.dev>
Cc: jirislaby@kernel.org, dhowells@redhat.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, pinskia@gmail.com,
	kent.overstreet@linux.dev
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <20240111080634.GB4609@alberich>
References: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org>
 <20240110130456.142763-1-neal@gompa.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110130456.142763-1-neal@gompa.dev>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,redhat.com,zytor.com,vger.kernel.org,gmail.com,linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[33.31%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Wed, Jan 10, 2024 at 08:04:53AM -0500, Neal Gompa wrote:
> Hey all,

Hi,

> I would like to speak in support of this too. It is not uncommon
> to see operating systems code written in C++ (notable examples are
> Haiku OS, Serenity OS, and Zircon/Fuschia) and I do feel that there
> are benefits to C++ for Linux code. Modern C++ (such as C++14 and
> newer), offers a lot of nice base language features that can make
> some of the kind of stuff that Linux does easier (as H. Peter Anvin
> has detailed in his post[1]).
> 
> While I personally have some experience in a variety of programming
> languages, C++ and Python are my preferred tools, and I would
> personally be much more interested in contributing in C++ than in C.
> I imagine there are a lot of other folks out there who feel the same,
> but just don't feel like they can say it. I'll stick my neck out for
> those who won't. ;)

I had some doubts, when I've seen hpa's thread and first I've thought
of it rather as a threat. But now this paragraph totally convinced me.

> Even though this started out as a "joke"[2], I really would like to
> see C++ code permitted in Linux.

Great, let University of Minnesota contribute the code.

> Thanks in advance and best regards,
> Neal
> 
> [1]: https://lore.kernel.org/lkml/3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com/
> [2]: https://lore.kernel.org/lkml/152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk/
> 
> 
> -- 
> 真実はいつも一つ！/ Always, there's only one truth!


PS: IMO, Rust shouldn't have been allowed into the kernel tree (a gut
feeling). But who am I.

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)

