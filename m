Return-Path: <linux-kernel+bounces-47269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D3844B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0F71C243D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B933A1CB;
	Wed, 31 Jan 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i420XTnl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y5QR2MaL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i420XTnl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y5QR2MaL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D25364CA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740824; cv=none; b=XfNWtE3/PlsXD6S/5GcA/QljuLKQcUmhTFg2ETBkCk1rm/KW1/llWl/iTIkjivciU0A3TxLw/otZuyXzOVTP+bwcuqoFuTNhM9QfOnLqnYOpeYbuq86HDW8P6pzHX/bNU2hooewYC+on58TjMhCW55ML2fAXcViFTWW0ua1qd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740824; c=relaxed/simple;
	bh=95PZOHP7KJrBYCpumpY2TKMLiPdM+HynlXgfUdgoQ+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQvI48qlpV0ruZSHrfLmXuT/1Xbvc/YJZYuYIy9SsEW2uaijFRFcacIm587rLy7rjGKJa7L7/lH+uz+5CMtjOkp7ggM2YLiAxpJe89O0osWmqHAAKbGzWnY5+K2E0i8agKTzcm9hB3kz1rafUxkvj0neIoKIAIBmOJ5YNbsosCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i420XTnl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y5QR2MaL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i420XTnl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y5QR2MaL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC70F1FBA1;
	Wed, 31 Jan 2024 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706740820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU/MHt4bpSUIbf9vJbcMZdqGZh6pUP/ciy9veOcetGc=;
	b=i420XTnlbuZtt9B5dAeuuepUIfLiZqfoxcD1o80ecfHN0NOUOlw6lgWYm8E7pcxZI/y4eb
	lZbc8hRLbRXu3kWj/Jvkk2yad24zAHxZC/tWatJzBNJVJlrbvs2wGQaDLyQDWex3qeIGze
	lEnhX2Ukckk9mZHz+TteccR/xu+crAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706740820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU/MHt4bpSUIbf9vJbcMZdqGZh6pUP/ciy9veOcetGc=;
	b=Y5QR2MaLRvDDuIh/v6EX/X4jnkFJQJlW6/E7/A/w6qgtZ3d0vBAqC7CYNgA5083PhYtXBE
	rWV2/OK9DZRizBAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706740820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU/MHt4bpSUIbf9vJbcMZdqGZh6pUP/ciy9veOcetGc=;
	b=i420XTnlbuZtt9B5dAeuuepUIfLiZqfoxcD1o80ecfHN0NOUOlw6lgWYm8E7pcxZI/y4eb
	lZbc8hRLbRXu3kWj/Jvkk2yad24zAHxZC/tWatJzBNJVJlrbvs2wGQaDLyQDWex3qeIGze
	lEnhX2Ukckk9mZHz+TteccR/xu+crAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706740820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU/MHt4bpSUIbf9vJbcMZdqGZh6pUP/ciy9veOcetGc=;
	b=Y5QR2MaLRvDDuIh/v6EX/X4jnkFJQJlW6/E7/A/w6qgtZ3d0vBAqC7CYNgA5083PhYtXBE
	rWV2/OK9DZRizBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7886E139B1;
	Wed, 31 Jan 2024 22:40:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /4zpHFTMumXLfAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 31 Jan 2024 22:40:20 +0000
Message-ID: <61af19ca-5f9a-40da-a04d-b04ed27b8754@suse.cz>
Date: Wed, 31 Jan 2024 23:40:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Do we still need SLAB_MEM_SPREAD (and possibly others)?
To: Yosry Ahmed <yosryahmed@google.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Xiongwei Song <xiongwei.song@windriver.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Zheng Yejian <zhengyejian1@huawei.com>
References: <20240131172027.10f64405@gandalf.local.home>
 <CAJD7tkYCrFAXLey-WK8k1Nkt4SoUQ00GWNjU43HJgaLqycBm7Q@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJD7tkYCrFAXLey-WK8k1Nkt4SoUQ00GWNjU43HJgaLqycBm7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i420XTnl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y5QR2MaL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RL5xoxxzj8zs4k3ay3guatdoxo)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[25.83%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,chromium.org,linux.com,google.com,gmail.com,windriver.com,bytedance.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.00
X-Rspamd-Queue-Id: AC70F1FBA1
X-Spam-Flag: NO

On 1/31/24 23:25, Yosry Ahmed wrote:
> On Wed, Jan 31, 2024 at 2:20 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> I was looking into moving eventfs_inode into a slab, and after cutting and
>> pasting the tracefs allocator:
>>
>>         tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
>>                                                  sizeof(struct tracefs_inode),
>>                                                  0, (SLAB_RECLAIM_ACCOUNT|
>>                                                      SLAB_MEM_SPREAD|
>>                                                      SLAB_ACCOUNT),
>>                                                  init_once);
>>
>> I figured I should know what those slab flags mean. I also looked at what
>> others in fs use for their slabs. The above is rather common (which I
>> probably just copied from another file system), but I wanted to know what
>> they are for.
>>
>> When I got to SLAB_MEM_SPREAD, I found that it's a common flag and there's
>> a lot of caches that just set that and nothing else.
>>
>> But I couldn't find how it was used.
>>
>> Then I found this commit:
>>
>>  16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h")
>>
>> Which I think removed the only use case of SLAB_MEM_SPREAD.
>>
>>  $ git grep SLAB_MEM_SPREAD mm
>> mm/slab.h:                            SLAB_MEM_SPREAD | \
>>
>> That's all I find in the mm directory.
>>
>> Is it obsolete now? Can we delete it? Maybe there's other SLAB_* flags that
>> are no longer used. I don't know, I haven't audited them.
> 
> Perhaps cpuset_do_slab_mem_spread() as well.

Yep, good find. Show how obscure mm/slab.c was in the end :)

CCing a few more new people who did slab changes recently, who'd like some
low hanging fruit of negative diffcount? :)

Thanks,
Vlastimil

