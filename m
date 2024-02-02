Return-Path: <linux-kernel+bounces-49962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B185984721D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE228C745
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C04B14460C;
	Fri,  2 Feb 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hnBgdeAN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hnBgdeAN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28197E102
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884974; cv=none; b=c8ufLpyTHKDF6yL0CnS4Q7669lBZa6dDmSnlmUhy2TvTA8qA8Y9CP18s1WUHh8xbDSsPg0kaJWQPVN7J1wULtxqhQCGmZx20e+Azc5vexkHLmuUzAI9eHcTen32kHbChYtyhNM286ye6jnhDKFWB43eP9oj65X5DyQr0N6Zb+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884974; c=relaxed/simple;
	bh=4EuOS7HjvkjBd7dhKGHIkKfCN/F4kE+P83+hydfofB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql2mvlixkyzUDNItk4puntRk2ehNRKwnGAIo7zt9cprvRTpw6CfYR24ANJvUPD+GjlMNfavky7Hc5we1XLlQ1KJNrsfGzUKrPVSr7CknZYQqFxXrrdzUdb2alJQIqLova4wcgg5fYaEGA+73sJkFfGd8DcrGkC7ybkeNTKt+Hpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hnBgdeAN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hnBgdeAN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06BF521F49;
	Fri,  2 Feb 2024 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706884971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f554nqusfs3KKOhoXmxK7o26/eSoxN9BndOK5ZeGsS4=;
	b=hnBgdeANdIxNb1X51SAKmhkMb0K5lkClFm4R9QOPalUdXwDyk0J39g3V2U9MeNua3S2cdf
	Qofd8rD3OD451w0Hei43bYg/af3GWthu05sAWcZbRcCroa/WRMaUqE/z3MLuhtuQ00H1/H
	ThrENSp6kes4A8McVgL1mAQj+Fc3jiA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706884971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f554nqusfs3KKOhoXmxK7o26/eSoxN9BndOK5ZeGsS4=;
	b=hnBgdeANdIxNb1X51SAKmhkMb0K5lkClFm4R9QOPalUdXwDyk0J39g3V2U9MeNua3S2cdf
	Qofd8rD3OD451w0Hei43bYg/af3GWthu05sAWcZbRcCroa/WRMaUqE/z3MLuhtuQ00H1/H
	ThrENSp6kes4A8McVgL1mAQj+Fc3jiA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E357213A58;
	Fri,  2 Feb 2024 14:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P2K3NWr/vGWsJAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 02 Feb 2024 14:42:50 +0000
Date: Fri, 2 Feb 2024 15:42:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on
 collapse
Message-ID: <Zbz_ao0uBKabzKB1@tiehlicka>
References: <20240201125226.28372-1-ioworker0@gmail.com>
 <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka>
 <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka>
 <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[34.75%]
X-Spam-Flag: NO

On Fri 02-02-24 21:46:45, Lance Yang wrote:
> Here is a part from the man page explaining
> the MADV_FREE semantics:
> 
> The kernel can thus free thesepages, but the
> freeing could be delayed until memory pressure
> occurs. For each of the pages that has been
> marked to be freed but has not yet been freed,
> the free operation will be canceled if the caller
> writes into the page. If there is no subsequent
> write, the kernel can free the pages at any time.
> 
> IIUC, if there is no subsequent write, lazyfree
> pages will eventually be reclaimed.

If there is no memory pressure then this might not
ever happen. User cannot make any assumption about
their content once madvise call has been done. The
content has to be considered lost. Sure the userspace
might have means to tell those pages from zero pages
and recheck after the write but that is about it.

> khugepaged
> treats lazyfree pages the same as pte_none,
> avoiding copying them to the new huge page
> during collapse. It seems that lazyfree pages
> are reclaimed before khugepaged collapses them.
> This aligns with user expectations.
> 
> However, IMO, if the content of MADV_FREE pages
> remains valid during collapse, then khugepaged
> treating lazyfree pages the same as pte_none
> might not be suitable.

Why?

Unless I am missing something (which is possible of
course) I do not really see why dropping the content
of those pages and replacing them with a THP is any
difference from reclaiming those pages and then faulting
in a non-THP zero page.

Now, if khugepaged reused the original content of MADV_FREE
pages that would be a slightly different story. I can
see why users would expect zero pages to back madvised
area.
-- 
Michal Hocko
SUSE Labs

