Return-Path: <linux-kernel+bounces-81792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFD867A21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397771C23890
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403312A17C;
	Mon, 26 Feb 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sw9TPOVA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wf46oY5s"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6907E794
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961113; cv=none; b=a+Purzu9aYUjBrYRFg1KVhyS/Z3wrXOK7U0zCZsNBhaJslt+aF25o/h7Qi5pvZMDBJlA8T6DSgGB13DDbf7HrG8MkKxZ3xDfAnRhGqJkDo9P8TKQfdK9cKn2ozlBTxMWClpUnmSPQIn8OApanapAVBKKHI3Zh9f562teLHxIr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961113; c=relaxed/simple;
	bh=Wz3peqSOXV4dKmVdRx7esjbJxrGrcE0UlnIR0sOULR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT3H0QCh+z6r0X+oi5y+Z/myXMGUi+gWava0RzzugSD4SpAy8CLfTJP2kQ30B8ths+NbXN0MZSZu4BvGyZFUfzwZU43b1Vd5Up2DXfGDpK091AbgS9u2gDgrqrl/prFIKlJeSFmTL/xM3JMJEokv9AyKI9Sw9UlDKl3Gm5J3WAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sw9TPOVA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wf46oY5s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EED261FB47;
	Mon, 26 Feb 2024 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708961110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mH19wd60ZFkQYGWsbwG2uFfjoFrKPwmGO1SmRTa2+qA=;
	b=Sw9TPOVAorw5k78xLTHAX5LR+cEg5fKbQWFLtFhquklO81+KwmNxFvZHnuJI7YAEFOy9Xe
	QDHMioc9UVxQHZ0Dc+8eber/6lciIHsjPxcZsdVeY99bTjqV81f1rGoDlv+XrTCyqqT9C4
	/nHJvLwkIqEmqSqqPuEUQ3ztT9b74es=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708961109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mH19wd60ZFkQYGWsbwG2uFfjoFrKPwmGO1SmRTa2+qA=;
	b=Wf46oY5sIJQVK+oO3JIiTcQR80AVs/cPjhG1wbRS8F0H552DB/6bYQgBGD5qntS8bTUlp1
	BfOui31IGcxvd7RnRSLTIcdFgtzjNpUqcXl15Cmq4A51MEwig9saCZbah8aP0GHFso1jvU
	d3C5y6X1E9+Pn6XgxOt31GGMsClAC5Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D39BC13A58;
	Mon, 26 Feb 2024 15:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LRu2MVWt3GWPfQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 26 Feb 2024 15:25:09 +0000
Date: Mon, 26 Feb 2024 16:25:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <ZdytVTOgfvKBBvtn@tiehlicka>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022639-wronged-grafted-6777@gregkh>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Wf46oY5s
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EED261FB47
X-Spam-Level: 
X-Spam-Score: -4.81
X-Spam-Flag: NO

On Mon 26-02-24 16:06:51, Greg KH wrote:
> On Mon, Feb 26, 2024 at 03:52:11PM +0100, Michal Hocko wrote:
> > On Thu 22-02-24 17:21:58, Greg KH wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > powerpc/pseries/memhp: Fix access beyond end of drmem array
> > > 
> > > dlpar_memory_remove_by_index() may access beyond the bounds of the
> > > drmem lmb array when the LMB lookup fails to match an entry with the
> > > given DRC index. When the search fails, the cursor is left pointing to
> > > &drmem_info->lmbs[drmem_info->n_lmbs], which is one element past the
> > > last valid entry in the array. The debug message at the end of the
> > > function then dereferences this pointer:
> > > 
> > >         pr_debug("Failed to hot-remove memory at %llx\n",
> > >                  lmb->base_addr);
> > 
> > While this is a reasonable fix and the stable material it is really
> > unclear to me why it has gained a CVE. Memory hotplug is a privileged
> > operation. Could you clarify please?
> 
> As you know, history has shown us that accessing out of your allocated
> memory can cause problems, and we can not assume use-cases, as we don't
> know how everyone uses our codebase, so marking places where we fix
> out-of-bound memory accesses is resolving a weakness in the codebase,
> hence a CVE assignment.

Does that mean that any potentially incorrect input provided by an admin is
considered CVE now? I guess we would need to ban interfaces like
/dev/mem and many others.
 
> If your systems are not vulnerable to this specific issue, wonderful, no
> need to take it, but why wouldn't you want to take a fix that resolves a
> known weakness?

I have explicitly said, the fix is reasonable. I just do not see a point
to mark it as CVE. I fail to see any thread model where this would
matter as it would require untrusted privileged actor to trigger it
AFAICS. I am happy to be proven wrong here.

-- 
Michal Hocko
SUSE Labs

