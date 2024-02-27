Return-Path: <linux-kernel+bounces-82889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD7E868B44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4161A282CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24516130AF0;
	Tue, 27 Feb 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kFfHqR3u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kFfHqR3u"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E612FF61
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023906; cv=none; b=ctxxzoUBGZKkzkudgkReA3j0GQpKUZTl06eT4f8JwwaxIaQw15JjCPhNjUa5zeWmocjLdsC4FTKEcV7x/Z+IMy4MNjebmz0jlHqstaVLypeOoAkTotnA8J6DYfpofAF5/xNEzPXSTGXBSQ4cwZzO+UrbbzlHTnhiP89t5Ztw8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023906; c=relaxed/simple;
	bh=CSDI6mafTkU7ve9xzNnR+5Tgow2PQP5GkHltM0IvTkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etjDQHfy798TWGMQHQmozTx5pPIDlRgF10wucClr4P2MgYE3w/3yKoEDY7paokwV+RYnC7H9KwIuWO8Na+uJUYic53myBWk06D0BUbigmYnfdBGT3uXpaPixwBMDipvpDJYqmQKNrAGXomGrQ/SJCllvVv4aCK0s9f7EjOtxVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kFfHqR3u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kFfHqR3u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9218A1F449;
	Tue, 27 Feb 2024 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709023902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evwipRZQ70ZzKL4/OITcrRUSm3xAO+gUHyRjxqANGug=;
	b=kFfHqR3u/ANrbNjSeX8LDy6/m2Pj/Ad2fLhGb3lII2MM7NVvZUB2sDBmzSseR1KzkJFpkl
	d2bSywR2hMVvi2VyNpeakmxU8NHqpme9aZgq+QQArfP+7yfnGJ05heJSsstAa2PQ0EI7Go
	gh0tDDE0jUTrLPqAKBsJvZaiPTyj8Ow=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709023902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evwipRZQ70ZzKL4/OITcrRUSm3xAO+gUHyRjxqANGug=;
	b=kFfHqR3u/ANrbNjSeX8LDy6/m2Pj/Ad2fLhGb3lII2MM7NVvZUB2sDBmzSseR1KzkJFpkl
	d2bSywR2hMVvi2VyNpeakmxU8NHqpme9aZgq+QQArfP+7yfnGJ05heJSsstAa2PQ0EI7Go
	gh0tDDE0jUTrLPqAKBsJvZaiPTyj8Ow=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8600513A58;
	Tue, 27 Feb 2024 08:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dp5uIJ6i3WVGaQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 27 Feb 2024 08:51:42 +0000
Date: Tue, 27 Feb 2024 09:51:38 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <Zd2imtvvKrHY9LAA@tiehlicka>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <2024022652-defective-fretful-3d13@gregkh>
 <Zdy-KbmSt0egNV3c@tiehlicka>
 <2024022750-treble-wish-b009@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022750-treble-wish-b009@gregkh>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.69
X-Spamd-Result: default: False [-0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.91)[0.972];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

[Let me add Michael as PPC maintainer - the thread starts with
http://lkml.kernel.org/r/2024022257-CVE-2023-52451-7bdb@gregkh]

On Tue 27-02-24 06:14:45, Greg KH wrote:
> On Mon, Feb 26, 2024 at 05:36:57PM +0100, Michal Hocko wrote:
[...]
> > All that being said I dispute the issue fixed here has any more security
> > relevance than allowing untrusted user to control memory hotplug which
> > could easily result in DoS of the system.
> 
> Ok, I traced this call back, and here is the callpath, starting with a
> write to the the 'dlpar' sysfs file (conviently NOT documented in
> Documentation/ABI, and it looks like it violates the "one value per
> file" rule...)
> 	dlpar_store()
> 	handle_dlpar_errorlog()
> 	dlpar_memory()
> 	dlpar_memory_remove_by_index()
> 
> Yes, the kernel by default sets 'dlpar' to 0644, BUT that means that
> root in a container can cause this use-after-free to happen, or if the
> permissions are changed by userspace, or if you are in "lockdown mode",
> or if you want to attempt the crazy "confidential computing" model, or
> if you have a system which root is possible for some things by normal
> users (there are lots of different security models out there...)

This is all nice but please do realize that if you allow access to to
memory hotremove to any untrusted entity (be it a root in container or
by changing access permissions) then the machine is in a serious
resource management control trouble already and that is a security
threat already.

> Yes, I will argue that making the sysfs file writable by userspace is
> out of our control, but what is in our control is the fact that there is
> a out-of-bounds write that is fixed here, and we don't want those to be
> able to be triggered by anyone as that is a weakness in our codebase.

Yes, and that is why the fix is good and nobody disputes that. What I am
actually trying to drill down to is whether this is an actual security
threat worth assigning a CVE or it is just yet-anothing-pointless-CVE we
were so used to with the old process.

> That is what has caused the CVE to be created here, not the fact that
> root can remove memory as that's the normal expected operation to have
> happen here.
>
> However if the maintainer of the code here disputes this, we are more
> than willing to mark this invalid and reject the CVE.

Michael, do you see any real security risk being addressed by
bd68ffce69f6 ("powerpc/pseries/memhp: Fix access beyond end of drmem
array").

Thanks!
-- 
Michal Hocko
SUSE Labs

