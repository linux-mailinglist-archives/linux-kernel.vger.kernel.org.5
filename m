Return-Path: <linux-kernel+bounces-81918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC9867C28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A961C20FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3093612BF1B;
	Mon, 26 Feb 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kg4Ga9pq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kg4Ga9pq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8BA819
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965422; cv=none; b=Wdwfg81p4uxGJOf0Fb3PQC4IRM9/Op5uDvR/KvUO0KfcxlGJTQeepAxelr3XcE1PW/uGaXG8i6TvFnDHT9DhKxrxNUWkCMlviCnBkjxfCBfJ0XFh6ryJ6//Ks/EwETitMoo7iVRLGIJh+iVDoSVjZOrD1EZm7MDInnoKu6UbF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965422; c=relaxed/simple;
	bh=m5uEE0J/0gplulyhcRxPAZP9nBxR735Jv+WoSYhGm8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT9xeYs6qMnpv98wCt1hauoO26O8dSD++qGCaEZex8BSzg8r3GiCgUYBABFjl3RUAuEJVYbmecdmKHgqBB/RHd2pfYeLvMxvG5hXmiXM4ZZvYvNT8HYYYeg1c4BdNZWG+uUu50qssnihp+0FbPhsxx5pFa0P2Uwy+r5IeKhuJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kg4Ga9pq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kg4Ga9pq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B221122093;
	Mon, 26 Feb 2024 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708965418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsXJGZI9slwa6ZOo7UegHQyBDIXFrwYJPBC2yyVzFys=;
	b=Kg4Ga9pqE6H4ZvZ3NdYBBCLMaLOZgg4V0Mhy25R7tPgZvUYbIHoG/xRwFxmjfdW+WZl56X
	vwdIOZame8oO5Y9WJqp/CMpuuQuYEvrShxdoL2fAN5ZgqFnU645kgkaWPJm9V0XfYPOYLT
	u+aDeufM/RuoeR9SN9VphkJ+U4zfTLM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708965418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsXJGZI9slwa6ZOo7UegHQyBDIXFrwYJPBC2yyVzFys=;
	b=Kg4Ga9pqE6H4ZvZ3NdYBBCLMaLOZgg4V0Mhy25R7tPgZvUYbIHoG/xRwFxmjfdW+WZl56X
	vwdIOZame8oO5Y9WJqp/CMpuuQuYEvrShxdoL2fAN5ZgqFnU645kgkaWPJm9V0XfYPOYLT
	u+aDeufM/RuoeR9SN9VphkJ+U4zfTLM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97BE413A58;
	Mon, 26 Feb 2024 16:36:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MeMOIiq+3GWqEgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 26 Feb 2024 16:36:58 +0000
Date: Mon, 26 Feb 2024 17:36:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <Zdy-KbmSt0egNV3c@tiehlicka>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <2024022652-defective-fretful-3d13@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022652-defective-fretful-3d13@gregkh>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.60

On Mon 26-02-24 17:12:19, Greg KH wrote:
> On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
> > On Mon 26-02-24 16:06:51, Greg KH wrote:
> > > On Mon, Feb 26, 2024 at 03:52:11PM +0100, Michal Hocko wrote:
> > > > On Thu 22-02-24 17:21:58, Greg KH wrote:
> > > > > Description
> > > > > ===========
> > > > > 
> > > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > > 
> > > > > powerpc/pseries/memhp: Fix access beyond end of drmem array
> > > > > 
> > > > > dlpar_memory_remove_by_index() may access beyond the bounds of the
> > > > > drmem lmb array when the LMB lookup fails to match an entry with the
> > > > > given DRC index. When the search fails, the cursor is left pointing to
> > > > > &drmem_info->lmbs[drmem_info->n_lmbs], which is one element past the
> > > > > last valid entry in the array. The debug message at the end of the
> > > > > function then dereferences this pointer:
> > > > > 
> > > > >         pr_debug("Failed to hot-remove memory at %llx\n",
> > > > >                  lmb->base_addr);
> > > > 
> > > > While this is a reasonable fix and the stable material it is really
> > > > unclear to me why it has gained a CVE. Memory hotplug is a privileged
> > > > operation. Could you clarify please?
> > > 
> > > As you know, history has shown us that accessing out of your allocated
> > > memory can cause problems, and we can not assume use-cases, as we don't
> > > know how everyone uses our codebase, so marking places where we fix
> > > out-of-bound memory accesses is resolving a weakness in the codebase,
> > > hence a CVE assignment.
> > 
> > Does that mean that any potentially incorrect input provided by an admin is
> > considered CVE now? I guess we would need to ban interfaces like
> > /dev/mem and many others.
> 
> If you have your system set up to prevent admins from accessing /dev/mem
> (isn't there a config option for that), and you can access it, then yes,
> that would be a CVE-worthy issue.
> 
> But if you configure your system to allow an admin access to /dev/mem
> then you wanted that :)

OK, I thought we are having a serious discussion here. Now I am not
really sure about that.

> > > If your systems are not vulnerable to this specific issue, wonderful, no
> > > need to take it, but why wouldn't you want to take a fix that resolves a
> > > known weakness?
> > 
> > I have explicitly said, the fix is reasonable. I just do not see a point
> > to mark it as CVE. I fail to see any thread model where this would
> > matter as it would require untrusted privileged actor to trigger it
> > AFAICS. I am happy to be proven wrong here.
> 
> We can not determine threat models when filing CVEs as we do not know
> what your threat model is.  All we can do is determine if this resolves
> a weakness in the system.  A use-after-free is a weakness and this
> resolves that issue.

Sure, you cannot make any assumptions and nobody questions that. We do
have a certain common sense though. And if somebody comes up with a
usecase that we haven't anticipated then we can surely assign a CVE.
I though that level of control is exactly the reason to own the process
by the community.

All that being said I dispute the issue fixed here has any more security
relevance than allowing untrusted user to control memory hotplug which
could easily result in DoS of the system.
-- 
Michal Hocko
SUSE Labs

