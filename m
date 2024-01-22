Return-Path: <linux-kernel+bounces-33112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0DB8364C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8841C21359
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A96B3D0BE;
	Mon, 22 Jan 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZGmPYeut";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZGmPYeut"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3C3CF50
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931458; cv=none; b=IhARGOgw+lCKheAMyukPALO51NwbXOzKps5fyghfJcG5VimwTiiVUPzgHWVJZQSY5qKaJcoYZFemutCe3vvcBaOADp2KeynT5/RUR7iL5J25v9p1zEZwMl/dz160MmvGWyoxwvA/h3MDT5hvsGggYR6cyeoPBX9K89hB4L4NfMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931458; c=relaxed/simple;
	bh=e8szEWsc+dJhLGhEFaoR3PFGjnmG5tJECaeKSzJ0LJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV+ymmkWIORm2TO0ump89cmebdv73ulozjlVXAbILEiz+ESX82xZd4JKVHjKmCFn45XgaSASG/4w4Axa9d8z0KqOfRJcHUx7p+sKEuBE+fk6cP9XE8RZskLxy/WGzcpyO8RuuYdlJsdIxZuR0nELz8ogjPb6gi1Bn0BlN+pVu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZGmPYeut; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZGmPYeut; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37ADB21DE4;
	Mon, 22 Jan 2024 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705931455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJUVDk8RMleasp0nmDcW1YGOWvYqxPQuw9VSvws+tuU=;
	b=ZGmPYeutI1+Lm2slp2P6QkzY7igGN2LeXmJ8jnoqpgwAJsAdiI6i2qzjTEzSGn1l0maGyM
	GwWP+8p2LFj2ALmOy+v+vEEKvkgDMceU6ij4B12u9E3JQo3/bIoao0Qwukrzic2bCqacQL
	VAiFFY0aAf/bIZxsInnazudy22OFEiw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705931455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJUVDk8RMleasp0nmDcW1YGOWvYqxPQuw9VSvws+tuU=;
	b=ZGmPYeutI1+Lm2slp2P6QkzY7igGN2LeXmJ8jnoqpgwAJsAdiI6i2qzjTEzSGn1l0maGyM
	GwWP+8p2LFj2ALmOy+v+vEEKvkgDMceU6ij4B12u9E3JQo3/bIoao0Qwukrzic2bCqacQL
	VAiFFY0aAf/bIZxsInnazudy22OFEiw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18D2213995;
	Mon, 22 Jan 2024 13:50:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7x4XA79yrmVOSQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 22 Jan 2024 13:50:55 +0000
Date: Mon, 22 Jan 2024 14:50:54 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to
 process_madvise()
Message-ID: <Za5yvjZWVyYjgyfh@tiehlicka>
References: <20240118120347.61817-1-ioworker0@gmail.com>
 <ZakqQyL9t2ffNUIf@tiehlicka>
 <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com>
 <ZapwWuVTIDeI3W8A@tiehlicka>
 <CAK1f24m9oxciHsAht4-cCWo_NT7x+bkoXUO2HOwgMCr0OnwpcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1f24m9oxciHsAht4-cCWo_NT7x+bkoXUO2HOwgMCr0OnwpcA@mail.gmail.com>
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
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[32.84%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Sat 20-01-24 10:09:32, Lance Yang wrote:
[...]
> Hey Michal,
> 
> Thanks for your suggestion!
> 
> It seems that the implementation should try but not too hard aligns well
> with my desired behavior.

The problem I have with this semantic is that it is really hard to
define and then stick with. Our implementation might change over time
and what somebody considers good ATM might turn int "trying harder than
I wanted" later on.

> Non-blocking in general is also a great idea.
> Perhaps in the future, we can add a MADV_F_COLLAPSE_NOBLOCK
> flag for scenarios where latency is extremely critical.

Non blocking semantic is much easier to define and maintain. The actual
allocation/compaction implementation might change as well over time but
the userspace at least knows that the request will not block waiting for
any required resources.

-- 
Michal Hocko
SUSE Labs

