Return-Path: <linux-kernel+bounces-100809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F85879D81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6058FB21357
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B86143737;
	Tue, 12 Mar 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hjibWYV2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="77AmclRT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CWCkO8em";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4fjSacG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848716FF3B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279015; cv=none; b=R9q11Ymc7ZtsJw5DXFlQ7Dj2AemPzEFdjRtj8Jb06CpegYjxlVZjnHKCbQtvpNZ+gaoSvK01yLakIJ/tkXCBfGnLh6P7hfCj2eQHodOuQjrPQ1vPO3h/AfsRtuU9X1EE72LYXqz0fa7zi/O5JszmYvTg61HUy0fMYF+bxLWWbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279015; c=relaxed/simple;
	bh=RIvCH5330AZwKZMq4buSpCOtnJNHJ90elB11Bpe+me0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzNeDL33Yk/MXzFDugxLgUs50L7x+xX2EAx7QV/plDr68aXTh18DCKhCby3f2XgNezxaKznfsWUX7h8t80rHT5FKHiFstZMfaWjVHXyZ1jHqiPAXz1XhYAolbbU281RXFK2XvlwNn0AW7Zn+2kZUANoKdMacXyORBCyHZU5Yqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hjibWYV2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=77AmclRT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CWCkO8em; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4fjSacG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB06521BE4;
	Tue, 12 Mar 2024 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710279010;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rv3pH8/gpDisWCQoznqBwhpmAdKptqyYTVgazHVMUSU=;
	b=hjibWYV2Ol3mUDxM6inDFVyIQ1/k/N50q8jPX6GTqDyUQbaMy3fFyHaYbrT8Z4M92ulZFK
	HezWFM1MtwtGXlH7tkJrFc3y7zmRzBGmdtP3BSnNlSnBPtqIW2NhqPsSCdn4Py4r2mldWp
	g2drrJQwa6umpniXrZzW/isZMdicCiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710279010;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rv3pH8/gpDisWCQoznqBwhpmAdKptqyYTVgazHVMUSU=;
	b=77AmclRTql7Xr2LM51YqxKiVG6++FTjOukm4z7Ha29Mt1ooNLSYWLsfF6PXzE6a3n90Ye+
	hx4hO544q9lenDCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710279009;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rv3pH8/gpDisWCQoznqBwhpmAdKptqyYTVgazHVMUSU=;
	b=CWCkO8emZqp0vpZkrJBfIkYLt0n9bNIdlqZJKfKtbsyg+BxYZtZKziMTJvm1NvCI2WpsKT
	vBo2CpXHH0Tz5fakSqv7b3s5gwusxdFaOJKvArM8J8sM5sNSR3YrPESUM3Xcsdassv6c8F
	BtMF3DQ0dr9AqAwkFuwMKtDQjUPPgEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710279009;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rv3pH8/gpDisWCQoznqBwhpmAdKptqyYTVgazHVMUSU=;
	b=B4fjSacGmKsyVMhzZV/GXxBh3Rha8OmfpuOSf9wy3Z+TkxtOby3JIF/kcObTcTHh0tzwpz
	8Mm+uNPgYg69gzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B04461364F;
	Tue, 12 Mar 2024 21:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tnahKmHJ8GX1KAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 12 Mar 2024 21:30:09 +0000
Date: Tue, 12 Mar 2024 22:22:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
	vbabka@suse.cz
Subject: Re: [GIT PULL] AFFS update for 6.9
Message-ID: <20240312212259.GX2604@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710185320.git.dsterba@suse.com>
 <CAHk-=wji0u+OOtmAOD-5JV3SXcRJF___k_+8XNKmak0yd5vW1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wji0u+OOtmAOD-5JV3SXcRJF___k_+8XNKmak0yd5vW1Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CWCkO8em;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B4fjSacG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: CB06521BE4
X-Spam-Flag: NO

On Tue, Mar 12, 2024 at 01:02:47PM -0700, Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 12:37, David Sterba <dsterba@suse.com> wrote:
> >
> > please pull one change to AFFS that removes use of SLAB_MEM_SPREAD,
> > which is going to be removed from MM code.
> 
> I've pulled this, but I don't really see the point in removing these
> one by one like this.
> 
> SLAB_MEM_SPREAD is already a no-op, the MM people could just do a
> coccinelle thing to remove it everywhere.

That's of course valid and was also suggested as an option. However I
would prefer to let actively maintained code pick the patches first
and then do the rest as sed or coccinelle script. This usually leaves
whitespace damage behind and not everybody takes the care to fix it
manually.

I agree that for AFFS it's a bit too much for just one change but I did
not realize that as I happened to do the same change for btrfs.

> I think you could do 90% even just using a few variations of 'sed', eg
> variations on
> 
>    git grep -l 'SLAB_MEM_SPREAD' |
>         xargs sed -i 's/SLAB_MEM_SPREAD *|//'
> 
>    git grep -l 'SLAB_MEM_SPREAD' |
>         xargs sed -i 's/| *SLAB_MEM_SPREAD//'
> 
> and then some manual fixups for (a) whitespace cleanup of the result
> and (b) the couple of cases where it wasn't a bitwise or into other
> fields (or where the bitwise or was on a different line)
> 
> And then you'd end up with something like the attached.

I don't know if MM people have such change queued but you could apply
the diff at the end of 6.9, the formatting seems OK.

