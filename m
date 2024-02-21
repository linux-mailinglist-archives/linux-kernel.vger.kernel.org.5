Return-Path: <linux-kernel+bounces-74488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD95685D513
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BC21F28BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B214EB3A;
	Wed, 21 Feb 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eqoWccbd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHlzl5Mb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eqoWccbd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHlzl5Mb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FD3D964;
	Wed, 21 Feb 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509511; cv=none; b=R2hMk1I9IgePyaZ5pcLCqa+nf7cx84SHTOIAd9p02uFrd6Ki+TbqsvlbTYGCm74Ej4CvpWWIXHVjcy9fXYLSEMznx2sTEcEd/7H0WJsuQZoJg0nl5YFGxjp3IkxKZx3Yw3arOCYTBlHOppumO3W0QP+vv4Y9vEUKpDZq3xuxcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509511; c=relaxed/simple;
	bh=x+tAsEV3Ej8sASoFgkA+UV5jf5YbQU5Wt1y7ot4Nh/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgLamNvU5gtzFIUineb3zowi9T6fcP3PNz1NS9o6Ps7ilcbZu4x/k+77yFRe+EzN8jZjHHUXV96s63bv4n/BXi+D3Hq+NuFVFSwoYMJA4gx8g+qjmh3r4E4hdKUlY4TgXBJdoCYGmEpMzBR0OweAyPK7zD+HdhBbn/4sPvSf7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eqoWccbd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHlzl5Mb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eqoWccbd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHlzl5Mb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92DB01FB4C;
	Wed, 21 Feb 2024 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708509506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CZZLxaCjUniAqfUA8XuBol8bY7o8se1WYeJDD69kWY=;
	b=eqoWccbdoRy5sD7lxgF7mOoSFHp5C6lhXoEJoGUq9zlS3nrMaTLkHS7eJqywHowi9zOuWv
	uEvWpF1xEcPNduaRxQqwOzE/poPKvGc8galZRHs2kFwgaGNn0Ytp6kZXaW2ilJzGFkJAr2
	OcWkdhacveMY6FiUe3jkaM6laJ+yUlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708509506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CZZLxaCjUniAqfUA8XuBol8bY7o8se1WYeJDD69kWY=;
	b=uHlzl5MbBIGidM84g/sKNE+UkK+1QMttnvG9eoEGviWkKkZixshbakkWgnUmXJzluiFZwJ
	XUPLbrrhp99SyzDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708509506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CZZLxaCjUniAqfUA8XuBol8bY7o8se1WYeJDD69kWY=;
	b=eqoWccbdoRy5sD7lxgF7mOoSFHp5C6lhXoEJoGUq9zlS3nrMaTLkHS7eJqywHowi9zOuWv
	uEvWpF1xEcPNduaRxQqwOzE/poPKvGc8galZRHs2kFwgaGNn0Ytp6kZXaW2ilJzGFkJAr2
	OcWkdhacveMY6FiUe3jkaM6laJ+yUlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708509506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CZZLxaCjUniAqfUA8XuBol8bY7o8se1WYeJDD69kWY=;
	b=uHlzl5MbBIGidM84g/sKNE+UkK+1QMttnvG9eoEGviWkKkZixshbakkWgnUmXJzluiFZwJ
	XUPLbrrhp99SyzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7856213A69;
	Wed, 21 Feb 2024 09:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 23v5HELJ1WUYPgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Feb 2024 09:58:26 +0000
Message-ID: <ea61304a-81a4-402d-9d71-b13b9ac89ed2@suse.cz>
Date: Wed, 21 Feb 2024 10:58:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stall at page allocations with __GFP_RETRY_MAYFAIL (Re: [PATCH
 v1] ALSA: memalloc: Fix indefinite hang in non-iommu case)
Content-Language: en-US
To: Sven van Ashbrook <svenva@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>,
 Karthikeyan Ramasubramanian <kramasub@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>, Brian Geffon <bgeffon@google.com>,
 stable@vger.kernel.org, Curtis Malainey <cujomalainey@chromium.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-mm@kvack.org
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
 <87jzn0ofdb.wl-tiwai@suse.de> <235ab5aa-90a4-4dd7-b2c6-70469605bcfb@suse.cz>
 <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eqoWccbd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uHlzl5Mb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 92DB01FB4C
X-Spam-Flag: NO

On 2/20/24 16:52, Sven van Ashbrook wrote:
> Takaski, Vlastimil: thanks so much for the engagement! See below.
> 
>> On 2/19/24 12:36, Takashi Iwai wrote:
>> >
>> > Karthikeyan, Sven, and co: could you guys show the stack trace at the
>> > stall?  This may give us more clear light.
> Here are our notes of the indefinite stall we saw on v5.10 with iommu SoCs.
> We did not pursue debugging the stall at the time, in favour of a work-around
> with the gfp flags. Therefore we only have partial confidence in the notes
> below. Take them with a block of salt, but they may point in a useful direction.
> 
> 1. try to do a "costly" allocation (order > PAGE_ALLOC_COSTLY_ORDER) with
>     __GFP_RETRY_MAYFAIL set.
> 
> 2. page alloc's __alloc_pages_slowpath [1] tries to get a page from
> the freelist.
>     This fails because there is nothing free of that costly order.
> 
> 3. page alloc tries to reclaim by calling __alloc_pages_direct_reclaim, which
>     bails out [2] because a zone is ready to be compacted; it pretends
> to have made
>     a single page of progress.
> 
> 4. page alloc tries to compact, but this always bails out early [3]
> because __GFP_IO is not set
>     (it's not passed by the snd allocator, and even if it were, we are
> suspending so the
>     __GFP_IO flag would be cleared anyway).
> 
> 5. page alloc believes reclaim progress was made (because of the
> pretense in item 3) and
>     so it checks whether it should retry compaction. The compaction
> retry logic [4] thinks
>     it should try again, because:
>     a) reclaim is needed because of the early bail-out in item 4
>     b) a zonelist is suitable for compaction
> 
> 6. goto 2. indefinite stall.

Thanks a lot, seems this can indeed happen even in 6.8-rc5. We're
mishandling the case where compaction is skipped due to lack of __GFP_IO,
which is indeed cleared in suspend/resume. I'll create a fix. Please don't
hesitate to report such issues the next time, even if not fully debugged :)

>>
>> > Also, Vlastimil suggested that tracepoints would be helpful if that's
>> > really in the page allocator, too.
>> >
> 
> We might be able to generate traces by bailing out of the indefinite
> stall using a timer,
> which should hopefully give us a device that's "alive enough" to read
> the traces.
> 
> Can you advise which tracepoints you'd like to see? Is trace-cmd [5]
> suitable to capture
> this?
> 
> [1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/mm/page_alloc.c;l=4654;drc=a16293af64a1f558dab9a5dd7fb05fdbc2b7c5c0
> [2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/mm/vmscan.c;drc=44452e4236561f6e36ec587805a52b683e2804c9;l=6177
> [3] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/mm/compaction.c;l=2479;drc=d7b105aa1559e6c287f3f372044c21c7400b7784
> [4] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/mm/page_alloc.c;l=4171;drc=a16293af64a1f558dab9a5dd7fb05fdbc2b7c5c0
> [5] https://chromium.googlesource.com/chromiumos/docs/+/HEAD/kernel_development.md#ftrace-debugging


