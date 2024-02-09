Return-Path: <linux-kernel+bounces-60032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8135884FEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF321F23E03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF9E17BD7;
	Fri,  9 Feb 2024 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q+aQmEMh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="esFzffAk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q+aQmEMh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="esFzffAk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BCDD294
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514225; cv=none; b=ulfyXdbMdB3QQUZkNmkbzSF2zoRqoeOtSRtIsDoKRX+OB5prxu6g1xnEXhKPifkNL4DqlWU9PJMH8YBTS2pA2hwwCtdq7TDkwZQNmZjNJKSn8g2xE17397NlweYc3qvYOSB7+rCvI0Yx6g+apjuzGRLOyLRwD37xPR8j8MDekxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514225; c=relaxed/simple;
	bh=Ia4rorXlvk69/sAV7FeT1EPD4+PG5IEjZ1tXo4PLaGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDjM7RH2X6C8ejfI6QNhjKs9oJ2dvveu0pk3RpbgMyZpIFGE5MqEWad7FUOvNpCuUpS4cR53Q+KdZxG3zAGghqTLIBQNfmyk9zmqXzy8ab9XWQzK20tEpBR0BGSZ4GnHIxcJSxntLNg5mqwguT240E8p8Ghd5obX/kLvJIfW1R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q+aQmEMh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=esFzffAk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q+aQmEMh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=esFzffAk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 028B721C7A;
	Fri,  9 Feb 2024 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707514222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp0dxQbFEUpfqMPPcFXAyGBEsa9A8LuelYecqqm//04=;
	b=Q+aQmEMhWPNZ+MVf1/zqwNdjgWSFK9m4lLZYkTw2naW4Ww7C2cgj+26ZRcv6t1zNwsahhm
	U3fLCM17taU6ay/+92ijFp0+9md4RPhu5JI+t45evBEWUZDGpinZXabfZuAL4JsiJLiDQY
	PtX+lpAmHp/b1ulMOA3QAhlGF0Bx1jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707514222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp0dxQbFEUpfqMPPcFXAyGBEsa9A8LuelYecqqm//04=;
	b=esFzffAky6mwPhZoT0CLJ8Mo0JIa2Kgaxg0vpx0gjrFImdcBbUOZLOf9Td2Y/iH/43XVtV
	kBEfgFmjRsUyEnCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707514222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp0dxQbFEUpfqMPPcFXAyGBEsa9A8LuelYecqqm//04=;
	b=Q+aQmEMhWPNZ+MVf1/zqwNdjgWSFK9m4lLZYkTw2naW4Ww7C2cgj+26ZRcv6t1zNwsahhm
	U3fLCM17taU6ay/+92ijFp0+9md4RPhu5JI+t45evBEWUZDGpinZXabfZuAL4JsiJLiDQY
	PtX+lpAmHp/b1ulMOA3QAhlGF0Bx1jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707514222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp0dxQbFEUpfqMPPcFXAyGBEsa9A8LuelYecqqm//04=;
	b=esFzffAky6mwPhZoT0CLJ8Mo0JIa2Kgaxg0vpx0gjrFImdcBbUOZLOf9Td2Y/iH/43XVtV
	kBEfgFmjRsUyEnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75154139E7;
	Fri,  9 Feb 2024 21:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SkfYGW2ZxmUCaAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 09 Feb 2024 21:30:21 +0000
Date: Fri, 9 Feb 2024 22:31:28 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v7 0/4] page_owner: print stacks and their outstanding
 allocations
Message-ID: <ZcaZsH0kuZCDPEtX@localhost.localdomain>
References: <20240208234539.19113-1-osalvador@suse.de>
 <20240208162818.369c7abc3ecb06d49adaeebb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208162818.369c7abc3ecb06d49adaeebb@linux-foundation.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[28.49%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Thu, Feb 08, 2024 at 04:28:18PM -0800, Andrew Morton wrote:
> Oh, there it is.  I wonder why we didn't use /sys/kernel/mm/

I just followed the convention we use at the moment, which happens
to be /sys/kernel/debug/page_owner_xxx.

> Would a new /sys/kernel/debug/page_owner_something/ be a good idea?  We
> might add more things later.  Then it can be
> /sys/kernel/debug/page_owner_something/full_stacks. 
> /sys/kernel/debug/page_owner/ would be nice, but it's too late for
> that.

Well, we could certainly do that, so we do not scatter the files
in /sys/kernel/debug/ but rather gather them in pagE_owner directory.
Let me see if I can come up with a proper name.

> > Oscar Salvador (4):
> >   lib/stackdepot: Move stack_record struct definition into the header
> >   mm,page_owner: Implement the tracking of the stacks count
> >   mm,page_owner: Display all stacks and their count
> >   mm,page_owner: Filter out stacks by a threshold
> > 
> >  include/linux/stackdepot.h |  72 ++++++++++++++++++++
> >  lib/stackdepot.c           |  97 ++++++++++++++------------
> >  mm/page_owner.c            | 136 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 262 insertions(+), 43 deletions(-)
> 
> Documentation/mm/page_owner.rst?

Heh, we are definitely going to need some documentation.
Let me prepare something.

Thanks Andrew


-- 
Oscar Salvador
SUSE Labs

