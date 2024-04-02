Return-Path: <linux-kernel+bounces-128323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A817895951
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7997BB28B10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55314BFB6;
	Tue,  2 Apr 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="buNNX8TQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nzFbo92d"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0C14BF9A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074137; cv=none; b=GuIMF95zgUOayxNaQ+U8SinvrOs5OvC8SFZP9xHQIGVq3Ga8XaB8pFByMfrteV4NnIZRiB4Hvw8115YeHy1k+akDcTMbY5fLNZJtnBt63Ts25PefjqI8I8J8R0V3yEuUiZaFFdhiKb0caKQcPrpH//hNDeyfGXVs7ExZgwufG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074137; c=relaxed/simple;
	bh=Sm6E+ccWfLZgHdWoHUg9nfuNWDp7//DnMVG2zjoLB7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFLUyUWURV744MQcXLtjyhP5QSUDXoetZmKILFuzRRK6AwzvRI3gqy9RrWQMKiK3CjsrFYkQDHbq+9MGoKPYi3Mhd54oL2XR3r8tfjVJcw3YRuvZjSWcVrupzpp9r4KFkYoLiydAw4qDYAQFz+f7MAGgxPyg7e1HwzF6oDNGz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=buNNX8TQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nzFbo92d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A92BD5BF9F;
	Tue,  2 Apr 2024 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712074133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2sPx5HpnZNTDX/IqXS+Sby2LHGHtICErN/uS9PWSaU=;
	b=buNNX8TQQ/QOrvSCFnyeP/jL/LDdv66hn4D1aLLpoA8blKVI9imsfCfmq3h1C+PcU1FB+2
	OO4f9ZmqWALj0uB+Dt3Nn8F1gz1+jSfcH05teoDHezptcC/0D05W8koAN24UToBIQCdHdA
	1ikTnjTY0YKuoAlx0j5aZOp2EaWgP/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712074133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2sPx5HpnZNTDX/IqXS+Sby2LHGHtICErN/uS9PWSaU=;
	b=nzFbo92dDwq+Z/5d9yXTQ7y2/xqsPhagFlO8Tts56b4eV+dZ1yaqd2BiaCtV4+rRaaTNtp
	B9DVM/XR1AtM/CAw==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B1E013A90;
	Tue,  2 Apr 2024 16:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SQqlIZUtDGarDAAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 16:08:53 +0000
Message-ID: <906fcdfc-f2da-428d-af3d-e1eaf64d1c61@suse.cz>
Date: Tue, 2 Apr 2024 18:08:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: Reduce memory consumption in extreme
 scenarios
Content-Language: en-US
To: Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com
Cc: xuqiang36@huawei.com, wangkefeng.wang@huawei.com
References: <20240330082335.29710-1-chenjun102@huawei.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240330082335.29710-1-chenjun102@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 BAYES_HAM(-0.01)[46.64%];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email];
	 FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,kvack.org,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO

On 3/30/24 9:23 AM, Chen Jun wrote:
> When kmalloc_node() is called without __GFP_THISNODE and the target node
> lacks sufficient memory, SLUB allocates a folio from a different node
> other than the requested node, instead of taking a partial slab from it.
> 
> However, since the allocated folio does not belong to the requested
> node, it is deactivated and added to the partial slab list of the node
> it belongs to.
> 
> This behavior can result in excessive memory usage when the requested
> node has insufficient memory, as SLUB will repeatedly allocate folios
> from other nodes without reusing the previously allocated ones.
> 
> To prevent memory wastage,
> when (node != NUMA_NO_NODE) && !(gfpflags & __GFP_THISNODE) is,
> 1) try to get a partial slab from target node with GFP_NOWAIT |
>    __GFP_THISNODE opportunistically.
> 2) if 1) failed, try to allocate a new slab from target node with
>    GFP_NOWAIT | __GFP_THISNODE opportunistically too.
> 3) if 2) failed, retry 1) and 2) with orignal gfpflags.
> 
> when node != NUMA_NO_NODE || (gfpflags & __GFP_THISNODE), the behavior
> remains unchanged.
> 
> On qemu with 4 numa nodes and each numa has 1G memory. Write a test ko
> to call kmalloc_node(196, GFP_KERNEL, 3) for (4 * 1024 + 4) * 1024 times.
> 
> cat /proc/slabinfo shows:
> kmalloc-256       4200530 13519712    256   32    2 : tunables..
> 
> after this patch,
> cat /proc/slabinfo shows:
> kmalloc-256       4200558 4200768    256   32    2 : tunables..
> 
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Slightly reworded and added an unlikely() to one of the tests, and included
in slab/for-6.10:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.10/cleanup&id=9198ffbd2b494daae3a67cac1d59c3a2754e64cd

Thanks!


