Return-Path: <linux-kernel+bounces-61317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E88510EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E33E1C215C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7012BAE3;
	Mon, 12 Feb 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rvSUIlG3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gS0xYZ8n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bJ3WSxTo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aitiJqMK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC428385
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733956; cv=none; b=okvA/jovW/fP2Z3bE/EqeXNQa/lz9aY4oKxwWOiYWP3280A+E7ulHLuhJfVCzFt3CqRWljQz2IRQa3Szaa8syNCniv+X2HheAtHRk5rHGgszSif32LdXD5E0hjF58PA+NB/ehc+wELbzN/tDpjVQnuxQ3sC9CcUTPk6VY7yzHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733956; c=relaxed/simple;
	bh=ZL+iZTXbTE8pKIVyLeWG5D9ZrvCfW397REGv/VFxjtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4MYEQOldsRFVT3sMhBlLRSYOLbZ1UI4zmuq4hUuPrg5bSH4s571RI/Ws7OPWnA99FjxKEXLvf+9gKtR3GMSJpairxDt7QCNsZfuFpwgpub/+UUHNEG/kRTDGw3pLgn9zpiiNXOYCXwL4k1qw75eA9NSn2Kn0WxZxlbYcsRUab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rvSUIlG3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gS0xYZ8n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bJ3WSxTo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aitiJqMK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A3FF21F97;
	Mon, 12 Feb 2024 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707733952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEvukcfEXo+TJxamA0z62txjQmubKA5pKuuaq+G1gcE=;
	b=rvSUIlG3wHZ+3COtOGbqO+23go+XO6w3yhMJ+n/zeDPjJ3a8GPQMa9ORv4flGn5Y3443R+
	9E6dQJ5nqR/Tsyg6sKgnyw/WwEAszA/8wwq6eAlxFVSL+UoF/Amp+hHTZh8ahxdSS6NnDN
	yC6ndCQwTzNvDUuGTFGbs+uhtMMuEoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707733952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEvukcfEXo+TJxamA0z62txjQmubKA5pKuuaq+G1gcE=;
	b=gS0xYZ8nu4NnxKX23LSMEGS2YDbj9G+uPTKOzFEbShSEG21zAzGvD0mb39uLCxuzTPokZd
	Ps4VF5HExUHizHBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707733950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEvukcfEXo+TJxamA0z62txjQmubKA5pKuuaq+G1gcE=;
	b=bJ3WSxTopjt6ssb4s+nb9jduq3Q+G2+W5DsPGN0cJFVf9m05dNVEvpZnZ6Sxjao6OnLf1c
	prcZzHw63KNYrngSDx7gphq22FDLy+ZqMZY9Rr6zNNurKcwXJV0D8xbwNLxATYOL94pw8R
	Ei6M/nb54mE6iskJYmy3wY/4/F0g32E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707733950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEvukcfEXo+TJxamA0z62txjQmubKA5pKuuaq+G1gcE=;
	b=aitiJqMKKUrsvrkiDNzHvKT/QvhYUkSD7pXYx984PPeBi7fwYMS9rOR4o1aw7/V6GiPMy5
	U2vPcQ4wTrmfNXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8838412FF7;
	Mon, 12 Feb 2024 10:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EN7vIL7zyWU0FQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Feb 2024 10:32:30 +0000
Message-ID: <7f34e789-e01f-4929-a618-b73c04ebf4d2@suse.cz>
Date: Mon, 12 Feb 2024 11:32:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: compaction: update the cc->nr_migratepages when
 allocating or freeing the freepages
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 Zi Yan <ziy@nvidia.com>
Cc: mgorman@techsingularity.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
 <0773058df022fa701b78f9a6dfe3c501a1a77351.1705928395.git.baolin.wang@linux.alibaba.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <0773058df022fa701b78f9a6dfe3c501a1a77351.1705928395.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.09

On 1/22/24 14:01, Baolin Wang wrote:
> Currently we will use 'cc->nr_freepages >= cc->nr_migratepages' comparison
> to ensure that enough freepages are isolated in isolate_freepages(), however
> it just decreases the cc->nr_freepages without updating cc->nr_migratepages
> in compaction_alloc(), which will waste more CPU cycles and cause too many
> freepages to be isolated.

Hm yeah I guess this can happen with fast_isolate_freepages() if it returns
with something but not all the freepages that are expected to be needed, and
then we get to isolate_freepages() again.

> So we should also update the cc->nr_migratepages when allocating or freeing
> the freepages to avoid isolating excess freepages. And I can see fewer free
> pages are scanned and isolated when running thpcompact on my Arm64 server:
>                                        k6.7         k6.7_patched
> Ops Compaction pages isolated      120692036.00   118160797.00
> Ops Compaction migrate scanned     131210329.00   154093268.00
> Ops Compaction free scanned       1090587971.00  1080632536.00
> Ops Compact scan efficiency               12.03          14.26
> 
> Moreover, I did not see an obvious latency improvements, this is likely because
> isolating freepages is not the bottleneck in the thpcompact test case.
>                               k6.7                  k6.7_patched
> Amean     fault-both-1      1089.76 (   0.00%)     1080.16 *   0.88%*
> Amean     fault-both-3      1616.48 (   0.00%)     1636.65 *  -1.25%*
> Amean     fault-both-5      2266.66 (   0.00%)     2219.20 *   2.09%*
> Amean     fault-both-7      2909.84 (   0.00%)     2801.90 *   3.71%*
> Amean     fault-both-12     4861.26 (   0.00%)     4733.25 *   2.63%*
> Amean     fault-both-18     7351.11 (   0.00%)     6950.51 *   5.45%*
> Amean     fault-both-24     9059.30 (   0.00%)     9159.99 *  -1.11%*
> Amean     fault-both-30    10685.68 (   0.00%)    11399.02 *  -6.68%*
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/compaction.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 066b72b3471a..6c84e3a5b32b 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1779,6 +1779,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  	dst = list_entry(cc->freepages.next, struct folio, lru);
>  	list_del(&dst->lru);
>  	cc->nr_freepages--;
> +	cc->nr_migratepages--;

This is breaking the tracepoint TRACE_EVENT(mm_compaction_migratepages)
which does

__entry->nr_failed = cc->nr_migratepages - nr_succeeded;

and is called after migrate_pages() finishes, so now this will underflow.

Probably need to get a snapshot of cc->nr_migratepages before calling
migrate_pages() and then feed that to the tracepoint instead of cc.

>  
>  	return dst;
>  }
> @@ -1794,6 +1795,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
>  
>  	list_add(&dst->lru, &cc->freepages);
>  	cc->nr_freepages++;
> +	cc->nr_migratepages++;
>  }
>  
>  /* possible outcome of isolate_migratepages */


