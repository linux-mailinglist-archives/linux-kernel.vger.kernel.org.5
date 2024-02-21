Return-Path: <linux-kernel+bounces-75600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8485EBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1100A284744
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B899B12882B;
	Wed, 21 Feb 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pvbuvSSr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DD8sSLUQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AwnxVk8l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B+ikTVhE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B769DE5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554168; cv=none; b=ou8LAAYnv6b2WZ+wzoZUKDRWSgUAcSEFa5jwmY9PjRM47eH5T7HutMAwSbkuI9XTlookWr4zZ/NSCAVci9Za0M2FsDmCXsdTsAADdyBO2+fnXxP9VrTJwXdHh0G9SjQF+rw6x5pq92nhVQ4R+qgvvkg6zFaC+d+ozqzgolczoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554168; c=relaxed/simple;
	bh=B/lFyQj1/pjZBC/Eh/zd/UkaFEKdDp5/btIUbUPn/mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+uQPP01o/pwB2SD/LyNAabKebOxA4paSvCr9YxfmHXX4sZpPCv6gtWvNqb15PWgMTNTCvl4tz568yz3T5D/oseLzVr6F7tmh3SxI887AO/ASufMOODQwwb+WrBuVUcl0jvsfsdS/YzSSZosqWku/LudHMTh5blac8u/qOE67hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pvbuvSSr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DD8sSLUQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AwnxVk8l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B+ikTVhE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0B1A22292;
	Wed, 21 Feb 2024 22:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708554164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4W0Vi1tnkL5nnSLhQ7VEbuCk3ygETijT2fu5M3Nrkw=;
	b=pvbuvSSrjEVBQPOHpf6oOdCqujTB/r6DwtcG/9GCWwT3+dTGnCehUE+NW4rBxIciONRz2n
	6ujcpGsX0BEf7LqLVMo+0YXV8l1/CQFyl3s4oBuorgOj9IWikadCShpZ2KgFdBxTSt1pUJ
	eVeWjhmUiYxuU5o3F8w0ELWXvDaD2mI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708554164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4W0Vi1tnkL5nnSLhQ7VEbuCk3ygETijT2fu5M3Nrkw=;
	b=DD8sSLUQsSzYW0aCWOG7nItZD/EZ+FM4c/RBlfldhidn0akW9pDsOgN+c3izXf2LvxrvnD
	A0ARzjb/VxsURPCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708554163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4W0Vi1tnkL5nnSLhQ7VEbuCk3ygETijT2fu5M3Nrkw=;
	b=AwnxVk8ly3jV0paZLFV3mrLvxLYd68nR0QGtJ0lWDoBaTITZO0A9TM4s0L9vlS4dfW1FLo
	t7g6tC5NbIjJuQyZGSBNHFz/5Sb6TN9I5+0U7O9bltdfPcFhJXur53HWP9I7qpdj314q1C
	rq6m3oypEekSU/E4gWs4IEcJb7zkdB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708554163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4W0Vi1tnkL5nnSLhQ7VEbuCk3ygETijT2fu5M3Nrkw=;
	b=B+ikTVhEkRuRu9lJMHT2DdDG0IjkHUgG6vDuJIGycgJldYwa1jquCuEkQ/lJuW+AuecGf5
	kgDwaKZMJIpEMTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD21513A69;
	Wed, 21 Feb 2024 22:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ja5FNbN31mWsbgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Feb 2024 22:22:43 +0000
Message-ID: <8ac57bb6-fe01-41aa-9e77-96be10595a26@suse.cz>
Date: Wed, 21 Feb 2024 23:22:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: compaction: limit the suitable target page order
 to be less than cc->order
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>, mgorman@techsingularity.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
 <20c8fa7c-62ae-4e48-aaec-8b512519cee9@suse.cz>
 <5277627F-6791-46A1-AFC2-54FBF0DABF1A@nvidia.com>
 <83bc1070-2eb4-4fac-aecf-9cc407003ca2@linux.alibaba.com>
 <20240221141504.3c3cec674553b4df4bd72ec1@linux-foundation.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221141504.3c3cec674553b4df4bd72ec1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AwnxVk8l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B+ikTVhE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.10)[88.18%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.991];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.10
X-Rspamd-Queue-Id: F0B1A22292
X-Spam-Flag: NO

On 2/21/24 23:15, Andrew Morton wrote:
> On Mon, 19 Feb 2024 10:55:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>> 
>> >>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> >>
>> >> I doubt this will make much difference, because if such a larger order free
>> >> page exists, we shouldn't have a reason to be compacting for a lower order
>> >> in the first place?
>> > 
>> > Unless kswapd gets us such a free block in the background right after
>> > get_page_from_freelist() and before compaction finishes in the allocation
>> > slow path.
>> > 
>> > If this happens often and cc->order is not -1, it might be better to stop
>> > compaction and get_page_from_freelist() to save cycles on unnecessary pfn
>> > scanning. For completeness, when cc->order == -1, the logic does not change.
>> 
>> Yes, this is one possible case. There are also some other concurrent 
>> scenarios, such as when compaction is running (after 
>> compaction_suitable()), at the same time, other applications release a 
>> large folio to the free list. In this case, the free large folio 
>> scanning should also be avoided.
> 
> This went quiet.
> 
> We have an ack from Mel.  Are people OK with sending this change
> upstream?

It's not wrong, so I'm OK.

