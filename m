Return-Path: <linux-kernel+bounces-104313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAAA87CC12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DC1281219
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7391B7FB;
	Fri, 15 Mar 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dMLbha13";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Eh2KuoW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dMLbha13";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Eh2KuoW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2C1C280
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501196; cv=none; b=d/h4GMuEtF7aiovgmRUxvaZL4/UUEi5x73PHQqoPXxd3qQQUAEMF9d6DGLlAnir7UIIp3Xd3QBMS/CKDOahfJLdRmXYG83T3LFZoTJhVw9Nuuq5+0gXnq5CycmAsmCAPJQLy34uUqUHqJjORBPaRAPR58zhfnA4JYO/CgazZt5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501196; c=relaxed/simple;
	bh=QbNyKl2+UNc3CtzWMSyqX7208qlKY58J7aRuKqEjrEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPWoG/iTXmaqfrCqLi6zTIsJHWLd7lW5mF1WgcHQpQ+QDVePGbQ540haVKmJenMyvrKUtCVO4yrJQ0NWXFmt4rGqO74fCFpQQJU98jc/PvgzFfzCP/vh45MUmlhJGB9aRDczdteMYKdEV23nKt4t96VnCPvEqONDYa69SQp7XIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dMLbha13; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Eh2KuoW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dMLbha13; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Eh2KuoW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B3611FB58;
	Fri, 15 Mar 2024 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710501193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68obMeZP9GkgE+BaJ/q7IbPrJxRaYAC1bA2WaPLQkyk=;
	b=dMLbha13ROIJpvpe3teSaEg6sQbyzUsn3nJ7iTg/NI7zHefAG+SepVd8dcieG2AjpO0qRt
	5Z/veNI6frMsJpas+ZrICnIlmkzu4eBMLgIh2b2wAB85AfN32ziieU/iqE88CFh/tke5WI
	u+mHtnRGL4UuBMKBtDDRrRjSDjvL6LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710501193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68obMeZP9GkgE+BaJ/q7IbPrJxRaYAC1bA2WaPLQkyk=;
	b=9Eh2KuoWjZ9HSFeLDVgV2S3Fyr4hZhkscbzHeva3IXDu+MalTjb31F4FK2OHPQeq5V2dqB
	8Iob6aNC73+W7ACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710501193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68obMeZP9GkgE+BaJ/q7IbPrJxRaYAC1bA2WaPLQkyk=;
	b=dMLbha13ROIJpvpe3teSaEg6sQbyzUsn3nJ7iTg/NI7zHefAG+SepVd8dcieG2AjpO0qRt
	5Z/veNI6frMsJpas+ZrICnIlmkzu4eBMLgIh2b2wAB85AfN32ziieU/iqE88CFh/tke5WI
	u+mHtnRGL4UuBMKBtDDRrRjSDjvL6LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710501193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68obMeZP9GkgE+BaJ/q7IbPrJxRaYAC1bA2WaPLQkyk=;
	b=9Eh2KuoWjZ9HSFeLDVgV2S3Fyr4hZhkscbzHeva3IXDu+MalTjb31F4FK2OHPQeq5V2dqB
	8Iob6aNC73+W7ACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28417137E8;
	Fri, 15 Mar 2024 11:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c1x/CUkt9GX0ewAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Mar 2024 11:13:13 +0000
Message-ID: <74675841-efdf-4af1-8505-3ad548a34b77@suse.cz>
Date: Fri, 15 Mar 2024 12:13:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/vmstat: simplfy extfrag_show_print with
 fragmentation_index()
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
 jhubbard@nvidia.com, mgorman@suse.de, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
 da.gomez@samsung.com
References: <20240314005436.2962962-1-mcgrof@kernel.org>
 <20240314005436.2962962-4-mcgrof@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240314005436.2962962-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.59
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.59 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.09)[64.26%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dMLbha13;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Eh2KuoW
X-Rspamd-Queue-Id: 3B3611FB58

On 3/14/24 01:54, Luis Chamberlain wrote:
> fragmentation_index() already uses the stack for the struct contig_page_info,
> so just use that and enhance the documentation for fragmentation_index().
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmstat.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index db79935e4a54..582f89b37ccf 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1129,7 +1129,10 @@ unsigned int extfrag_for_order(struct zone *zone, unsigned int order)
>  			info.free_pages);
>  }
>  
> -/* Same as __fragmentation index but allocs contig_page_info on stack */
> +/*
> + * Same as __fragmentation index but allocs contig_page_info on stack,
> + * useful when walking a zone as interrupts are disabled.
> + */
>  int fragmentation_index(struct zone *zone, unsigned int order)
>  {
>  	struct contig_page_info info;
> @@ -2227,15 +2230,11 @@ static void extfrag_show_print(struct seq_file *m,
>  	unsigned int order;
>  	int index;
>  
> -	/* Alloc on stack as interrupts are disabled for zone walk */
> -	struct contig_page_info info;
> -
>  	seq_printf(m, "Node %d, zone %8s ",
>  				pgdat->node_id,
>  				zone->name);
>  	for (order = 0; order < NR_PAGE_ORDERS; ++order) {
> -		fill_contig_page_info(zone, order, &info);
> -		index = __fragmentation_index(order, &info);
> +		index = fragmentation_index(zone, order);
>  		seq_printf(m, "%2d.%03d ", index / 1000, index % 1000);
>  	}
>  


