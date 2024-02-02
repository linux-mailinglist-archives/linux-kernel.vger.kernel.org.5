Return-Path: <linux-kernel+bounces-49643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D6846D55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB2D1F22C9B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0177F3E;
	Fri,  2 Feb 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h5nEVG65";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pHj1cA59"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8877634
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868412; cv=none; b=mK1o7k/m6UIGeEa5e0oregxKFDkEVA5lkxVruYGuErJ8Er/kA2EG8DnjdX02HBADLdGVWSxP+7TYsDcC/dQqRAQmK2NMxWSzC2Z0s99tHqd1gFOka6cxOw/oumAIo8CX+smfCosi3nQotwDjDHELJWtYqra21259DT0rBsCT9Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868412; c=relaxed/simple;
	bh=fuKoY4mbxj5tV35tFZocFtR5lXefrrau5IR3m3GDVrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrRT97s2ifeeug1mh6pyqGGqlcFPX8uKHEQMM5wFDDJgXwrERfKHFLd/tHz92NJ3PjjTvSlExe245S1Omk7KcjMO0dsi0qCUYvQHZ3kal1BIw3w1TB7buuFxg/WxalDX+bq+xpR+ydIfXIl53wsV8cJP2iQ+SEzVY4eQDZNyNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h5nEVG65; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pHj1cA59; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4AB2221BE;
	Fri,  2 Feb 2024 10:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706868409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp39qw0vyC5qpStWLyPfn976MpebyO4rKbzn6LwaTRk=;
	b=h5nEVG650NBZwy9STqPacXwisn2rWSXL2wDfvdo8HrS1YKRIcdyZ9cSLRll6bnCTpkVQZR
	+yXRNRR8uZMrzv0nq5fpArBU+G40D7h+Jnjc+yENDqOlBV3BG3mNjaiEnJE6A104GYWs2z
	U9X5Sgo5qrKkck3IzeODEHmCjKa6mXk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706868408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp39qw0vyC5qpStWLyPfn976MpebyO4rKbzn6LwaTRk=;
	b=pHj1cA59U4F6WUt07t/FI9xkJmJRhAMg8D2ulzUNVaaTiGpFgHTVxETPBcZ6sund0I3JWR
	2eF0S/cUsHgayWfgH8tgtVEtwrgKmT3d4vauutZymMQF4z8xJnRGeGs00cx8oIKMt/hyeX
	dB9FqQqqDkXW6IYeWYowlQCs5aHszS8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C616213A58;
	Fri,  2 Feb 2024 10:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tgSPLri+vGXmWAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 02 Feb 2024 10:06:48 +0000
Date: Fri, 2 Feb 2024 11:06:40 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on
 collapse
Message-ID: <Zby-sHLDlmTRaUcd@tiehlicka>
References: <20240201125226.28372-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201125226.28372-1-ioworker0@gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pHj1cA59
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.03 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.02)[51.99%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.03
X-Rspamd-Queue-Id: E4AB2221BE
X-Spam-Flag: NO

On Thu 01-02-24 20:52:26, Lance Yang wrote:
> The collapsing behavior of khugepaged with pages
> marked using MADV_FREE might cause confusion
> among users.
> 
> For instance, allocate a 2MB chunk using mmap and
> later release it by MADV_FREE. Khugepaged will not
> collapse this chunk. From the user's perspective,
> it treats lazyfree pages as pte_none. However,
> for some pages marked as lazyfree with MADV_FREE,
> khugepaged might collapse this chunk and copy
> these pages to a new huge page. This inconsistency
> in behavior could be confusing for users.

Is that any more confusing than collapsing pte_none
pages?

TBH I do not really see why this is a problem. MADV_FREE
are correctly recognized same as pte_none so the user
defined trashold applies.
-- 
Michal Hocko
SUSE Labs

