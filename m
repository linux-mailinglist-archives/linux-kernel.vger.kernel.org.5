Return-Path: <linux-kernel+bounces-148739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272B8A86CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFE22888C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931E13F44A;
	Wed, 17 Apr 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WIPv4Bys";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lmq+Imed";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WIPv4Bys";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lmq+Imed"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5B38DD3;
	Wed, 17 Apr 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365696; cv=none; b=taalmFUiWrs3uCvCwvBbvnTL6IXvgFV7EOWhTwkwOe8mJ8Z4RcpzLy5Narn3Lu+JSAqP9DhDuk8NiL2BrBIYQGmpjnPq/P1imMixW0VLQdo7fjzL+l2W5q6EBM+9XjKH+m5DmFucjpEZ5uvZK0N+ic2rbwxzqLXw1543Ga1HXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365696; c=relaxed/simple;
	bh=j/kkXCLbaet7tQenZZV3BauQw9//W4LV4+M6WNx0+QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rcz8eMkPyDY0nlPvZljw21PeK18oBObtSA/7wERSkJ1etFZdO4reUyQycqT01WLpPbxMka12+EcAMioamOcQuy7oTw5PsORZTYwPm+hhf1fnFxnPcXpxvjOjBdQ8WXUuk6g3JSvmbdK1VCMVIWQchFAUxc01URI7PKi08tfvjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WIPv4Bys; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lmq+Imed; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WIPv4Bys; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lmq+Imed; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F39C820AB1;
	Wed, 17 Apr 2024 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713365687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgoG+0xCL/8Y6q4Ug28gi7RT5OUpQ9e3zhnkL2fsCAI=;
	b=WIPv4Byskan7NgsSrXhdP/jtNGrXCWeJ7c/v1HcDwsHpjWUJuJ9glc5yF6iPgB7Oz3tz4D
	fB1UVS7yTNKabxvzvhclLZARUIXTuLmPmO55Yyq7uco4x3jGpJfgqG1d7OQxmPcUYwqfOo
	DAqbYLSHJj1U2YYaKXmygv2D8UitTGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713365687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgoG+0xCL/8Y6q4Ug28gi7RT5OUpQ9e3zhnkL2fsCAI=;
	b=Lmq+ImedM/LooXtq0zteHXx7bs80Dis4dglHoOHZJ44bjwsuazpH06T84eOK/VD5QxWaUs
	i3F3e/IrtihUfoCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713365687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgoG+0xCL/8Y6q4Ug28gi7RT5OUpQ9e3zhnkL2fsCAI=;
	b=WIPv4Byskan7NgsSrXhdP/jtNGrXCWeJ7c/v1HcDwsHpjWUJuJ9glc5yF6iPgB7Oz3tz4D
	fB1UVS7yTNKabxvzvhclLZARUIXTuLmPmO55Yyq7uco4x3jGpJfgqG1d7OQxmPcUYwqfOo
	DAqbYLSHJj1U2YYaKXmygv2D8UitTGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713365687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgoG+0xCL/8Y6q4Ug28gi7RT5OUpQ9e3zhnkL2fsCAI=;
	b=Lmq+ImedM/LooXtq0zteHXx7bs80Dis4dglHoOHZJ44bjwsuazpH06T84eOK/VD5QxWaUs
	i3F3e/IrtihUfoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9C811384C;
	Wed, 17 Apr 2024 14:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VIsOObbiH2afVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Apr 2024 14:54:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C030A082E; Wed, 17 Apr 2024 16:54:46 +0200 (CEST)
Date: Wed, 17 Apr 2024 16:54:46 +0200
From: Jan Kara <jack@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jan Kara <jack@suse.cz>, cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26774: ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Message-ID: <20240417145446.uh2rqcbxlebnkbfm@quack3>
References: <2024040308-CVE-2024-26774-52d9@gregkh>
 <20240417114324.c77wuw5hvjbm6ok5@quack3>
 <2024041711-chapter-uninstall-b1d3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041711-chapter-uninstall-b1d3@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.978];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 17-04-24 15:30:03, Greg Kroah-Hartman wrote:
> On Wed, Apr 17, 2024 at 01:43:24PM +0200, Jan Kara wrote:
> > Hello!
> > 
> > On Wed 03-04-24 19:31:41, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
> > > 
> > > Determine if bb_fragments is 0 instead of determining bb_free to eliminate
> > > the risk of dividing by zero when the block bitmap is corrupted.
> > > 
> > > The Linux kernel CVE team has assigned CVE-2024-26774 to this issue.
> > 
> > I'd like to understand what is the imagined security threat fixed by this
> > patch (as multiple patches of similar nature got assigned a CVE). The patch
> > fixes a bug that if a corrupted filesystem is read-write mounted, we can do
> > division-by-zero. Now if you can make the system mount a corrupted
> > filesystem, you can do many interesting things to the system other than
> > create a division by zero... So what is the presumed threat model here?
> 
> Exactly what you said, "if you mount a corrupted file system, you will
> get a divide by zero fault."
> 
> Many systems auto-mount any filesystem plugged into it.  If yours do
> not, then yours does not need to worry about this type of CVE.

OK, understood. But let me state that with the current state of affairs in
the filesystem land, it will not take a determined attacker long to get
arbitrary code execution out of "maliciously corrupted fs mounted". The
code of most filesystems has simply never been written with the assumption
that it can be presented with malicious data and we have hundreds of
thousands lines of code like that. We have fixed the most glaring problems
but by far not all (partly because of performance and maintenance costs,
partly because they are baked into on-disk formats).

So if we should honestly state the situation (and filesystem folks are
trying to get this message across for a few years already), we should issue
a CVE for "mounting untrusted fs image can crash your kernel or install
rootkit to your system". And yes, I know most distros will happily mount
whatever is plugged into the USB port because that is what users expect and
it is convenient. So if anybody wants a practical solution to this security
problem, I'd suggest working on FUSE drivers for filesystems you care about
and make distros use that when mounting removable media... That is actually
pretty secure and robust solution if you don't care about performance
*that* much.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

