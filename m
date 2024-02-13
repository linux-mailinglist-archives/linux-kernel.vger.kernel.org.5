Return-Path: <linux-kernel+bounces-63670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CDD853309
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3CCB231AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCD58124;
	Tue, 13 Feb 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="peaY5gJu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ve7YYNp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="peaY5gJu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ve7YYNp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28B58119
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834330; cv=none; b=pFfrSnXvxPntzU9swZJ9aYM0MuBTdb++Mt3qKoLi5Ph3+LRhnXUBrRc4WCJxKrKbqNpv93kHtIgGPRq8qY3DB9Cc/c7dx2Mpgff5O7vnXOYxOyQ/nCPYFX7wakNwAyJxGNwpNLPLfrbe/9yoIvbJP2fP0VVPH6Jxzdms4J4eGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834330; c=relaxed/simple;
	bh=47GLH3r8Ecss8GdXJNiRzcux3kAUlP7QKTP2wmpdSxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7Amqpfjh7V6qWP9h4Hog3ysgsl5ZDjzMxSQZHQ6cZTaMv6juUsbef111626wK+g1kEF7Gt9nFxyF2QKhQo2x3Ui5Qd8aV+wQOQ3PQR+A4I/O+oHj67yIH0sqprFqS+radPQ5OcUAuexClC6RMTuzHaL88C+UFDt8IEfmuJ5H4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=peaY5gJu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ve7YYNp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=peaY5gJu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ve7YYNp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B95B01FCDB;
	Tue, 13 Feb 2024 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707834326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkBvOLVHi2de+ERnUxon6wSh8Yr7kE+kebwjXh01sD0=;
	b=peaY5gJuPxc4TrCtINsGhmTcHGex6SOS5vhB9gGhZEWPhfKGFlg/JxrgvNZMx4b6iDhd4V
	TzlToyjyxXV5H4WHxg/xpMa7greVATkwSezqoYuqoTdyzWUyvvRmYddWN3cV6W3O0ZBGfA
	wT1una36u+FGKfZZAMB8qQrsvqm6dkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707834326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkBvOLVHi2de+ERnUxon6wSh8Yr7kE+kebwjXh01sD0=;
	b=3ve7YYNpOHvJkXrspWvQI4ZuMd781BYzdNLdn7LDHxk/4kk5fnEkAS9wdbVZMKQy1fSwn2
	fR/cdqqcOZ5L/rDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707834326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkBvOLVHi2de+ERnUxon6wSh8Yr7kE+kebwjXh01sD0=;
	b=peaY5gJuPxc4TrCtINsGhmTcHGex6SOS5vhB9gGhZEWPhfKGFlg/JxrgvNZMx4b6iDhd4V
	TzlToyjyxXV5H4WHxg/xpMa7greVATkwSezqoYuqoTdyzWUyvvRmYddWN3cV6W3O0ZBGfA
	wT1una36u+FGKfZZAMB8qQrsvqm6dkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707834326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkBvOLVHi2de+ERnUxon6wSh8Yr7kE+kebwjXh01sD0=;
	b=3ve7YYNpOHvJkXrspWvQI4ZuMd781BYzdNLdn7LDHxk/4kk5fnEkAS9wdbVZMKQy1fSwn2
	fR/cdqqcOZ5L/rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A498F1370C;
	Tue, 13 Feb 2024 14:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FDaJ9Z7y2UsKQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Feb 2024 14:25:26 +0000
Message-ID: <b706176a-c60a-4960-ba4a-2755c612d9c8@suse.cz>
Date: Tue, 13 Feb 2024 15:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] mm,page_owner: Display all stacks and their count
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-4-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212223029.30769-4-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.83
X-Spamd-Result: default: False [-7.83 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.986];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-2.55)[97.96%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On 2/12/24 23:30, Oscar Salvador wrote:
> This patch adds a new directory called 'page_owner_stacks' under
> /sys/kernel/debug/, with a file called 'show_stacks' in it.
> Reading from that file will show all stacks that were added by page_owner
> followed by their counting, giving us a clear overview of stack <-> count
> relationship.
> 
> E.g:
> 
>   prep_new_page+0xa9/0x120
>   get_page_from_freelist+0x801/0x2210
>   __alloc_pages+0x18b/0x350
>   alloc_pages_mpol+0x91/0x1f0
>   folio_alloc+0x14/0x50
>   filemap_alloc_folio+0xb2/0x100
>   __filemap_get_folio+0x14a/0x490
>   ext4_write_begin+0xbd/0x4b0 [ext4]
>   generic_perform_write+0xc1/0x1e0
>   ext4_buffered_write_iter+0x68/0xe0 [ext4]
>   ext4_file_write_iter+0x70/0x740 [ext4]
>   vfs_write+0x33d/0x420
>   ksys_write+0xa5/0xe0
>   do_syscall_64+0x80/0x160
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  stack_count: 4578
> 
> The seq stack_{start,next} functions will iterate through the list
> stack_list in order to print all stacks.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

..

> +static int stack_print(struct seq_file *m, void *v)
> +{
> +	char *buf;
> +	int ret = 0;
> +	struct stack *stack = v;
> +	struct stack_record *stack_record = stack->stack_record;
> +
> +	if (!stack_record->size || stack_record->size < 0 ||
> +	    refcount_read(&stack_record->count) < 2)
> +		return 0;
> +
> +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +
> +	ret += stack_trace_snprint(buf, PAGE_SIZE, stack_record->entries,
> +				   stack_record->size, 0);
> +	if (!ret)
> +		goto out;
> +
> +	scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
> +		  refcount_read(&stack_record->count));
> +
> +	seq_printf(m, buf);
> +	seq_puts(m, "\n\n");
> +out:
> +	kfree(buf);

Seems rather wasteful to do kzalloc/kfree so you can print into that buffer
first and then print/copy it again using seq_printf. If you give up on using
stack_trace_snprintf() it's not much harder to print the stack directly with
a loop of seq_printf. See e.g. slab_debugfs_show().

> +
> +	return 0;
> +}
> +


