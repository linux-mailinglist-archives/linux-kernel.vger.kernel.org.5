Return-Path: <linux-kernel+bounces-52226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A78495AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E73FB24203
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6207B12B69;
	Mon,  5 Feb 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xF4gQyrw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z8R/GA5i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xF4gQyrw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z8R/GA5i"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0D125BC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123024; cv=none; b=uuRHnkMpdmQqcNHP7kmhd+bK15K8/aGe6S8BwTUNQ9gh0q6n/T2S9DBrpkvnJlJi2A7Wr8Rq+pLt2xAsI7eUYKEN9qdAEj142sND3y7DPtcbyBemZ2sAyTQKdcVyqRFba1905PstHmR92/SOrJ/sY4pYZAcTnmURjkjH1bGLKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123024; c=relaxed/simple;
	bh=FkeIZJ/P4gf12zQMrXDZ8jnIvD/S9rD2jSxgSa7f+NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tr4sRKiO8WLa0nAucMIsKBlJCREfBeH5KaQgh5xrXMCbpsBnqm8NLrGmsZAwdpiAOMzxrMSgqQGtCUalpKzlGj8TAZfyfaolJAzKhaYO3x038kDJGD8PosrEEgY70x+dZUumhhlPy6LCNwR/l9dZpdrI2g9wz1QsZ/nrEq1Wxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xF4gQyrw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z8R/GA5i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xF4gQyrw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z8R/GA5i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABAEB21EDD;
	Mon,  5 Feb 2024 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707123014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbOEFuT/dTTVapiIHVyuFegCJTnoM+Zym9Xi3X/VbGk=;
	b=xF4gQyrwPHafwPeA3wY/Bu4EfoeLqqQbQZLkrdhNORLs4h2xHU5EDSdSU3Iu8fmcVlFAjO
	vo3+mEW3e7SGGRV71s+Me3j7sR6HNN0O/47Vd2W74/za1LRteMpaLYQNEMHo/ct0x5/XDJ
	MpZs/qsmNIFEnrA5m0plxe003foPDNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707123014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbOEFuT/dTTVapiIHVyuFegCJTnoM+Zym9Xi3X/VbGk=;
	b=z8R/GA5i8WF/RM7nEe79Aw7dSLz4Ew8/AkJBNR5zuAzBtr3uwb9Jav8TGrp1ZwhkczvVcD
	7YGBmPxvCr4TZlDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707123014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbOEFuT/dTTVapiIHVyuFegCJTnoM+Zym9Xi3X/VbGk=;
	b=xF4gQyrwPHafwPeA3wY/Bu4EfoeLqqQbQZLkrdhNORLs4h2xHU5EDSdSU3Iu8fmcVlFAjO
	vo3+mEW3e7SGGRV71s+Me3j7sR6HNN0O/47Vd2W74/za1LRteMpaLYQNEMHo/ct0x5/XDJ
	MpZs/qsmNIFEnrA5m0plxe003foPDNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707123014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbOEFuT/dTTVapiIHVyuFegCJTnoM+Zym9Xi3X/VbGk=;
	b=z8R/GA5i8WF/RM7nEe79Aw7dSLz4Ew8/AkJBNR5zuAzBtr3uwb9Jav8TGrp1ZwhkczvVcD
	7YGBmPxvCr4TZlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B461132DD;
	Mon,  5 Feb 2024 08:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HOukIUahwGXWEwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 05 Feb 2024 08:50:14 +0000
Message-ID: <2f43774a-16cf-412e-b4b7-840889bb796b@suse.cz>
Date: Mon, 5 Feb 2024 09:50:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: Add slabreclaim flag to slabinfo
To: Greg KH <gregkh@linuxfoundation.org>,
 Fangzheng Zhang <fangzheng.zhang@unisoc.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Fangzheng Zhang
 <fangzheng.zhang1003@gmail.com>, Yuming Han <yuming.han@unisoc.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240131094442.28834-1-fangzheng.zhang@unisoc.com>
 <2024020441-version-chihuahua-1067@gregkh>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2024020441-version-chihuahua-1067@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.21
X-Spamd-Result: default: False [0.21 / 50.00];
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
	 R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,unisoc.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/4/24 14:09, Greg KH wrote:
> On Wed, Jan 31, 2024 at 05:44:42PM +0800, Fangzheng Zhang wrote:
>> In order to enhance slab debugging, we add slabreclaim flag to
>> slabinfo. Slab type is also an important analysis point in slabinfo
>> for per slab, when various problems such as memory leaks or memory
>> statistics occur.
>> 
>> Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
>> ---
>>  mm/slab_common.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 238293b1dbe1..aeeb2bfe6dda 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1038,7 +1038,7 @@ static void print_slabinfo_header(struct seq_file *m)
>>  	seq_puts(m, "slabinfo - version: 2.1\n");
>>  	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
>>  	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
>> -	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
>> +	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail> <slabreclaim>");
> 
> Doesn't this change the slabinfo version number above?  Where is this
> change documented so that userspace knows about it?

Yeah I was vary about this. Do the other longer-time-than-me slab
maintainers recall how we handled this in the past?
Also the information is already available, even if harder to gather, in the
file /sys/kernel/slab/$cache/reclaim_account

> thanks,
> 
> greg k-h


