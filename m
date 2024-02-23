Return-Path: <linux-kernel+bounces-78078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC76E860EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3331C24D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65F5C615;
	Fri, 23 Feb 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M4YSa6IF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="On2E3knU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M4YSa6IF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="On2E3knU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAF5C8E3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681879; cv=none; b=qC+uaBZhLy6oQ7BY7jMLhGkg3KlVmTVYrhbQK/A50TIwruHrMvY3Dj5N6bsK1qki2WLFLF7gyZnK+trppettvwVkWIV3k228kN5VX1HwvM9KprujHmVbE5WwjobjfktuoHCuGWLuARdtORzL69/R5dM3d5bfVVIp/b/IPRcX9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681879; c=relaxed/simple;
	bh=WKb5/5/cfiI6H479bfOqIxxDAbeo4KJ+fCMmALsJW70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYh/S3LfF/zRbrjgb1otPXLRrE6DELg7Yx/n7WY3tt+ByWY1ZFpw0HmCRX8/9RWYP2sOKEODgPS5JTdb4+dB9PGUFNhTKUf2MQIDmZmbIAYTbx50TWAkvI/bNIJVUo5yq9mcsWwcJ6LLIW9lwAePlLKrFph9Fs+NHkvxjl7ihbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M4YSa6IF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=On2E3knU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M4YSa6IF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=On2E3knU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FA3A1F802;
	Fri, 23 Feb 2024 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708681875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95aaKSSaRKxtwQ2IqSIC0VcCKbYQQb5o0zeaoyiloIk=;
	b=M4YSa6IFlafLMA0CSyenyVoqMnxVqIhLIWZZCvwtnj6AdsGgfRwv6kDBiEXWaFpUsWvkUh
	sCo52u6Sp3VixSYe7vhBBMpqxPa6B0vBrC9+WYlT1WbaG02okpkj44wK9viBmojJEiNa6j
	2KKGDsldaWNU5DwKJ7pqz5L1GQdqu54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708681875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95aaKSSaRKxtwQ2IqSIC0VcCKbYQQb5o0zeaoyiloIk=;
	b=On2E3knU5hMg2UlFl1AuQigcKsbC8k0LMT6ZD7HJjJFwlUasKCbyVGAGCt0yW/yXqFp2Ri
	5WFcZSeedJZW9DAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708681875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95aaKSSaRKxtwQ2IqSIC0VcCKbYQQb5o0zeaoyiloIk=;
	b=M4YSa6IFlafLMA0CSyenyVoqMnxVqIhLIWZZCvwtnj6AdsGgfRwv6kDBiEXWaFpUsWvkUh
	sCo52u6Sp3VixSYe7vhBBMpqxPa6B0vBrC9+WYlT1WbaG02okpkj44wK9viBmojJEiNa6j
	2KKGDsldaWNU5DwKJ7pqz5L1GQdqu54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708681875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95aaKSSaRKxtwQ2IqSIC0VcCKbYQQb5o0zeaoyiloIk=;
	b=On2E3knU5hMg2UlFl1AuQigcKsbC8k0LMT6ZD7HJjJFwlUasKCbyVGAGCt0yW/yXqFp2Ri
	5WFcZSeedJZW9DAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D44132C7;
	Fri, 23 Feb 2024 09:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vpp8GJNq2GWhTAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 09:51:15 +0000
Message-ID: <2744dd57-e76e-4d80-851a-02898f87f9be@suse.cz>
Date: Fri, 23 Feb 2024 10:51:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
To: Chengming Zhou <chengming.zhou@linux.dev>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
 <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
 <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev>
 <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com>
 <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev>
 <1a952209-fa22-4439-af27-bf102c7d742b@suse.cz>
 <cce26aef-ab3e-447b-8b33-5ecd78bf747d@linux.dev>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <cce26aef-ab3e-447b-8b33-5ecd78bf747d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.41 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.00)[36.42%];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,oracle.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.41
X-Spam-Flag: NO

On 2/23/24 10:37, Chengming Zhou wrote:
> On 2024/2/23 17:24, Vlastimil Babka wrote:
>> 
>>>>
>>>
>>> I think this is a better direction! We can use RCU list if slab can be freed by RCU.
>> 
>> Often we remove slab from the partial list for other purposes than freeing -
>> i.e. to become a cpu (partial) slab, and that can't be handled by a rcu
>> callback nor can we wait a grace period in such situations.
> 
> IMHO, only free_slab() need to use call_rcu() to delay free the slab,
> other paths like taking partial slabs from node partial list don't need
> to wait for RCU grace period.
> 
> All we want is safely lockless iterate over the node partial list, right?

Yes, and for that there's the "list_head slab_list", which is in union with
"struct slab *next" and "int slabs" for the cpu partial list. So if we
remove a slab from the partial list and rewrite the list_head for the
partial list purposes, it will break the lockless iterators, right? We would
have to wait a grace period between unlinking the slab from partial list (so
no new iterators can reach it), and reusing the list_head (so we are sure
the existing iterators stopped looking at our slab).

Maybe there's more advanced rcu tricks but this is my basic understanding
how this works.

> Thanks.


