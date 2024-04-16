Return-Path: <linux-kernel+bounces-146272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C48A630F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9157282F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E823A1C9;
	Tue, 16 Apr 2024 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b4ZYNccz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXCJm+gt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hxeDuFm6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LRDP7kHo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A2629
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245829; cv=none; b=iQ5Hvym/b78oS6FpLFNkAWWMMEnEkVaJmUiJhBdAS/JBYEvTRMn2WcIX3YYI63UYmoD1GOZaXHuwGCZHW3q+wk/zEnwrW6GLLw/WOWogbBuQHgo1a/4wCJKkvX6mIz6UkTgxGWSLKQcK/YcaoMEo8vqOmmzVHTHmpSOwE8d470g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245829; c=relaxed/simple;
	bh=EfG9cFtllF9gqFm7hY3Rf2DORnZMz5q2bf9UJwLncUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9uwW6ynvCkvegqsHEQcm66qYXe87swuW1vnnMFbzAdImosxtqhN6sA6FJ8U3IHDS69ER7ByNDVrgp8YU0lJnAzpYAz9UfXzXZr8feBMZK9WOmawnn7ZFIYeP8tjI+axV8NZtrSrBOQi6rZp5bAM/6YXInBW0bYryjzaawgHVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b4ZYNccz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXCJm+gt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hxeDuFm6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LRDP7kHo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 660123785C;
	Tue, 16 Apr 2024 05:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713245825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7yI8GNAbc77sTAygJZU2zvbo6TVZ+TPVDnIN7EkyX4=;
	b=b4ZYNcczdMR/WEfgbZ3cMfYr/vtZXiR6nhn0RK1OdgPh/3GmTHwroyFtWU3dG0hJHUklqE
	KLqjaBZAxaptkCpepf3NfzfeI1NI8EWDxwWPd0Dbhkt4Cgj7cDrPybH6r173xZu9A59ibt
	0QG8IPDE3rtOjfKR+D11vBA5RsqdRcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713245825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7yI8GNAbc77sTAygJZU2zvbo6TVZ+TPVDnIN7EkyX4=;
	b=pXCJm+gtEsG6qRXFp0/JqZ9xXU11xzbXYbMN1S4DHevQ2XmAhFQLVJ/SpN/JCt7BZSiomL
	YJ2ajry7FLo/qwCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713245824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7yI8GNAbc77sTAygJZU2zvbo6TVZ+TPVDnIN7EkyX4=;
	b=hxeDuFm6vZO4YateVf4M9TOuMYLOKqH0FboC+zyp35Ha1V2PLB0uelHP6Jttmy+cMdu+JN
	itoD1bceOp8ExlzhF/GEyejiOulFBf6NErGecjVricetRjlo4RyEb9zNhMdFoijIbkCOqQ
	mCTqTzX3YIrqgxji0W17PR2axR5b/Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713245824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7yI8GNAbc77sTAygJZU2zvbo6TVZ+TPVDnIN7EkyX4=;
	b=LRDP7kHo8Crbn2tPoCLxKxwN8QQB8IaRoS0fqUDlLInYASBMOHqQooYWC7nDuCgjw9COaB
	g2hPdxKrHq6HKzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4584138A7;
	Tue, 16 Apr 2024 05:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60sFNX8OHmbNMQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 16 Apr 2024 05:37:03 +0000
Date: Tue, 16 Apr 2024 07:36:58 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vishal Moola <vishal.moola@gmail.com>,
	syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 __vma_reservation_common
Message-ID: <Zh4OemsI1Ant9rfg@localhost.localdomain>
References: <000000000000daf1e10615e64dcb@google.com>
 <000000000000ae5d410615fea3bf@google.com>
 <Zh2kuFX9BWOGN1Mo@fedora>
 <Zh2m5_MfZ45Uk-vD@casper.infradead.org>
 <CAOzc2pzFSkwo21Uba3ys5u8=okYbtA2ptyc5bQJwHoS=H_UMtA@mail.gmail.com>
 <Zh4AJiHFQBkD1J_F@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh4AJiHFQBkD1J_F@casper.infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.23 / 50.00];
	BAYES_HAM(-2.43)[97.39%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[ad1b592fc4483655438b];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,linux-foundation.org,vger.kernel.org,kvack.org,linux.dev,googlegroups.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ul.ie:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ul.ie:email];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -2.23
X-Spam-Flag: NO

On Tue, Apr 16, 2024 at 05:35:50AM +0100, Matthew Wilcox wrote:
> Why does hugetlbfs use VM_MAYSHARE while regular faults use VM_SHARED?

It goes back to:

commit f83a275dbc5ca1721143698e844243fcadfabf6a
Author: Mel Gorman <mel@csn.ul.ie>
Date:   Thu May 28 14:34:40 2009 -0700

    mm: account for MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs


"hugetlbfs currently checks if a VMA is MAP_SHARED with the VM_SHARED flag
 and not VM_MAYSHARE.  For file-backed mappings, such as hugetlbfs,
 VM_SHARED is set only if the mapping is MAP_SHARED and the file was opened
 read-write.  If a shared memory mapping was mapped shared-read-write for
 populating of data and mapped shared-read-only by other processes, then
 hugetlbfs would account for the mapping as if it was MAP_PRIVATE.  This
 causes processes to fail to map the file MAP_SHARED even though it should
 succeed as the reservation is there."

-- 
Oscar Salvador
SUSE Labs

