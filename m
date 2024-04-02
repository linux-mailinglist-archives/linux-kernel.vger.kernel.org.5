Return-Path: <linux-kernel+bounces-128126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A629189567A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61248285719
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9848A86256;
	Tue,  2 Apr 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PER0F0US";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MH4+MQVp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297868615E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067566; cv=none; b=RsernJvrb5km6oDRV9CB7CqZWUIgN2neAor0tLLXlP220X/3DzcGgcQZ45yNEhgotwpCeQrXyTypvwWtjUQ85hNtBdHTfu25tk2qTijUvH51tWnvUcxpKuDjC+jVDW6lU4E5efK/EwKGYIqQrCB/93jX31kG2T2s99GfVClg9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067566; c=relaxed/simple;
	bh=PJQEXVJ8G/K1ZRsYn71cjVAj2tHSq/IM9D6DAD9fm+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnC6ZLS69MU2X0fMPIXpCOR/e6WkILSE+/xQWfN6pdpTW8dJHtmQsaCRUqgg3dAmeL8SPJoSwR7BtO50sLyW+YRGBb0pd1Waaidpv0lz7RUfcgg1VvW2lGAq0ch3YdKzMiLDwn3krFA0LARvykmS4yKC/ayAcpWzFtoBQJozkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PER0F0US; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MH4+MQVp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EB835BE38;
	Tue,  2 Apr 2024 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712067563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86Ie7b1mOyPW1vf+XjyvhSuH5HfH2o6++oCNKqvwcv0=;
	b=PER0F0USFzsok97vL02qrGksKjWZO7Dmxa8ZYp4xfrvJIvBncIselL81dsKOVPkGaAmbEh
	V3B/yoLNtpbgmBYsYddIqWdwDb9SnJky3rXZILRevHmQ4H4NLE0cilQhJU1mNDWfkgenmd
	5sEUJ9wBX1JRmsV2LAFheylvif8f9po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712067563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86Ie7b1mOyPW1vf+XjyvhSuH5HfH2o6++oCNKqvwcv0=;
	b=MH4+MQVpNDvJn9VHZJOFuaGBJJpY3Z8UWupE5RTuY+z2KS3CGtHUmOOujKyQ6oBMMaoCZx
	6pYfp/WxeN5pVzAg==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E365513A90;
	Tue,  2 Apr 2024 14:19:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gG7HNOoTDGakZQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 02 Apr 2024 14:19:22 +0000
Date: Tue, 2 Apr 2024 16:20:47 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v3 0/3] page_owner: Fix refcount imbalance
Message-ID: <ZgwUP17giMgGksXc@localhost.localdomain>
References: <20240326063036.6242-1-osalvador@suse.de>
 <74b147b0-718d-4d50-be75-d6afc801cd24@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b147b0-718d-4d50-be75-d6afc801cd24@huawei.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[33.96%];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -0.30
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Mar 29, 2024 at 12:54:30PM +0800, Kefeng Wang wrote:
> I still see the following memory leak, could you check it?
> 
> /mnt/arm64 # cat /sys//kernel/debug/kmemleak
> unreferenced object 0xffff000200d91000 (size 16):
>   comm "kworker/4:0", pid 42, jiffies 4294892753
>   hex dump (first 16 bytes):
>     60 37 57 c1 00 00 ff ff 00 00 00 00 00 00 00 00  `7W.............
>   backtrace (crc 4458f477):
>     [<(____ptrval____)>] kmemleak_alloc+0x3c/0x50
>     [<(____ptrval____)>] kmalloc_trace+0x20c/0x2e0
>     [<(____ptrval____)>] __set_page_owner+0x1d0/0x2a0
>     [<(____ptrval____)>] prep_new_page+0x108/0x138
>     [<(____ptrval____)>] get_page_from_freelist+0x79c/0x16b8
>     [<(____ptrval____)>] __alloc_pages+0x1bc/0x440
>     [<(____ptrval____)>] new_slab+0x104/0x3c8
>     [<(____ptrval____)>] ___slab_alloc+0x368/0xb20
>     [<(____ptrval____)>] __slab_alloc.isra.0+0x3c/0x88
>     [<(____ptrval____)>] kmalloc_trace+0x280/0x2e0
>     [<(____ptrval____)>] __set_page_owner+0x1d0/0x2a0
>     [<(____ptrval____)>] prep_new_page+0x108/0x138
>     [<(____ptrval____)>] get_page_from_freelist+0x79c/0x16b8
>     [<(____ptrval____)>] __alloc_pages+0x1bc/0x440
>     [<(____ptrval____)>] new_slab+0x104/0x3c8
>     [<(____ptrval____)>] ___slab_alloc+0x368/0xb20

Hi Kefeng Wang

You seem to be missing [1]

Could you try with that patch applied?

[1] https://lore.kernel.org/linux-mm/20240315222610.6870-1-osalvador@suse.de/

Thanks

-- 
Oscar Salvador
SUSE Labs

