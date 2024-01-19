Return-Path: <linux-kernel+bounces-31321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64194832C78
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7AE284FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667254BDB;
	Fri, 19 Jan 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jk2YMo1P";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jk2YMo1P"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A054BE0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679172; cv=none; b=Ko2rWn5WgiS3KFTDwMxuitAFFKL+l0yea9LbFQFVmGpDTrnQGEofpllk5Fd+038t66eSv+cSOIyNmBpnOtxXPIwCkHKbyfR44hA6JywQTYW5jg8fnCxiVTTcVuFHSxAkyElgDqm3zVBEoh981tFHH0wSFJh1jf5fZoNZR1hlkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679172; c=relaxed/simple;
	bh=w8OrW7FhL4oRB0Y2bDVTNkpxCQm8IU8DfUxDQwC6jLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Teq9LZ3GKVuTBOqwPcWLtcin60zjr8ZZ3fRyTC79EmkK7uMdx6ZaodmbloZtGJqvfeNqhbsv+guIv3Auf/1M4snkw0c4pmbGlndWMtydi8WQxwQ7WPXoAkHWE+y9s+JOi0gb0dVDp2UMeate4A2aaYZzZhwbhIIX1b+d+1Hcl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jk2YMo1P; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jk2YMo1P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BC0721F6A;
	Fri, 19 Jan 2024 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705679168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/IkvwqWM3HNNg1/Uy/USTNPgBNZMsOoOsiNX+V4qTA=;
	b=Jk2YMo1PILNRnK/XmsvxK6a3fjwq9hnkYALMaPIQX5lVSlPZEbs+9XXCUEQhFgR99iuhop
	eaRKLtTNFM5tt4TxuX/JyqxszSweMfJ7SRlfWn6u0fLGI79jui4M3iDBw5kIakjE3IDjjU
	c3HphCMmA12v22HJCKVHjGCjQyohEis=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705679168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/IkvwqWM3HNNg1/Uy/USTNPgBNZMsOoOsiNX+V4qTA=;
	b=Jk2YMo1PILNRnK/XmsvxK6a3fjwq9hnkYALMaPIQX5lVSlPZEbs+9XXCUEQhFgR99iuhop
	eaRKLtTNFM5tt4TxuX/JyqxszSweMfJ7SRlfWn6u0fLGI79jui4M3iDBw5kIakjE3IDjjU
	c3HphCMmA12v22HJCKVHjGCjQyohEis=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C8A1388C;
	Fri, 19 Jan 2024 15:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6vyaFUCZqmWzSwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 19 Jan 2024 15:46:08 +0000
Date: Fri, 19 Jan 2024 16:46:07 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Message-ID: <ZaqZPxDUOuxRWB5l@tiehlicka>
References: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
 <ZalK3suIskEyaR7m@tiehlicka>
 <c7b1cc8e-c434-4c86-972e-4a105524646c@huawei.com>
 <ZaosK59cRa27K9zW@tiehlicka>
 <14ae628d-a9ef-42f3-9201-e90c5c88c133@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ae628d-a9ef-42f3-9201-e90c5c88c133@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Jk2YMo1P
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[32.81%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: 7BC0721F6A
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Fri 19-01-24 20:59:22, Kefeng Wang wrote:
> > > > GFP_TRANSHUGE_LIGHT is more interesting though because those do not dive
> > > > into the direct reclaim at all. With the current code they will reclaim
> > > > charges to free up the space for the allocated THP page and that defeats
> > > > the light mode. I have a vague recollection of preparing a patch to
> > > 
> > > We are interesting to GFP_TRANSHUGE_LIGHT and _GFP_NORETRY as mentioned
> > > above.
> > 
> > if mTHP can be smaller than COSTLY_ORDER then you are correct and
> > NORETRY makes a difference. Please mention that in the changelog as
> > well.
> > 
> 
> For memory cgroup charge, _GFP_NORETRY checked to make us directly skip
> mem_cgroup_oom(), it has no concern with folio order or COSTLY_ORDER when
> check _GFP_NORETRY in try_charge_memcg(), so I think NORETRY should
> always make difference for all large order folio.

we do not OOM on COSTLY_ORDER (see mem_cgroup_oom). So NORETRY really
makes a difference for small orders.
-- 
Michal Hocko
SUSE Labs

