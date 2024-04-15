Return-Path: <linux-kernel+bounces-144679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32798A491E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AAA1C21203
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157F02421A;
	Mon, 15 Apr 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxGPv+8I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSnJn7ST";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxGPv+8I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSnJn7ST"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B365234
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166524; cv=none; b=le2TjBjAFiKC4gLd6VlfrlSQTAsJZNLu6uRS1OrjIDxfyQEqNWUsBUf9s+6sMv4WCTaIPlIrkYEyjM0SE8NxmFndh9tJaTrxuQGeojcgCOqKrlDlSfKMrYDqH9rWQ+G7GWv0TmoKPhmcOBRojWa/AcyQHF0JTVNmGWINvqhs7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166524; c=relaxed/simple;
	bh=FgSQ3A7Lgj4N7dWyEuX18BosscS5A1EuXC+S3+aUmVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONviSiiGo2O7AmDsOxJSMyLeoRYnRWTMa4T6oJZakRujnFoSiDOPdttR7uIqtrV5d9hesoMQd0H3NrPxp9WZEYof/Gx4WSGbAOMiOEzRR9tkmX/NzMSaOhoLOClFiuoci3RNv/KEYKnuzUM4HrAKtP07NShY4yFxlcoIfAsnH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxGPv+8I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sSnJn7ST; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxGPv+8I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sSnJn7ST; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1595D35157;
	Mon, 15 Apr 2024 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713166519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bwcirFf+KqcGw4z4Ax26JeSmGD4J+Vre8tX2+IYcr38=;
	b=vxGPv+8IOBmYFsSdWdxXBvAB6JIJDMHRalPbWU9pPOUeZL5EZsTr3QyNMh8KM0GQJyBUZD
	u2K+5JxVw+p/4/OsprbdVz0TGRvgqlKVIPZHdECV3XcPLexnDUDbRti/M59v3DZ96vs3Us
	R5Be1ACrAkRUWfAfyZaTyfWRAnetw08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713166519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bwcirFf+KqcGw4z4Ax26JeSmGD4J+Vre8tX2+IYcr38=;
	b=sSnJn7STjRFGJ78PW3PB2+X2YRjX8urZNonnJOkD8rJiWEZbyHad7w7GbtPvY7p460zFfL
	t1w/LjdOBCWLVQAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vxGPv+8I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sSnJn7ST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713166519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bwcirFf+KqcGw4z4Ax26JeSmGD4J+Vre8tX2+IYcr38=;
	b=vxGPv+8IOBmYFsSdWdxXBvAB6JIJDMHRalPbWU9pPOUeZL5EZsTr3QyNMh8KM0GQJyBUZD
	u2K+5JxVw+p/4/OsprbdVz0TGRvgqlKVIPZHdECV3XcPLexnDUDbRti/M59v3DZ96vs3Us
	R5Be1ACrAkRUWfAfyZaTyfWRAnetw08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713166519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bwcirFf+KqcGw4z4Ax26JeSmGD4J+Vre8tX2+IYcr38=;
	b=sSnJn7STjRFGJ78PW3PB2+X2YRjX8urZNonnJOkD8rJiWEZbyHad7w7GbtPvY7p460zFfL
	t1w/LjdOBCWLVQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 002DA1368B;
	Mon, 15 Apr 2024 07:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xupMO7bYHGb4EwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Apr 2024 07:35:18 +0000
Message-ID: <567ed01c-f0f5-45ee-9711-cc5719ee7666@suse.cz>
Date: Mon, 15 Apr 2024 09:35:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
Content-Language: en-US
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "penberg@kernel.org" <penberg@kernel.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Junxiao Bi <junxiao.bi@oracle.com>
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
 <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
 <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
 <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
 <1207c5d7-8bb7-4574-b811-0cd5f7eaf33d@suse.cz>
 <e348dfcd-6944-4500-bf84-c58b8c2e657f@oracle.com>
 <5552D041-8549-4E76-B3EC-03C76C117077@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <5552D041-8549-4E76-B3EC-03C76C117077@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1595D35157
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 4/13/24 3:17 AM, Jianfeng Wang wrote:
> 
>> On Apr 12, 2024, at 1:44 PM, Jianfeng Wang <jianfeng.w.wang@oracle.com> wrote:
>> 
>> On 4/12/24 1:20 PM, Vlastimil Babka wrote:
>>> On 4/12/24 7:29 PM, Jianfeng Wang wrote:
>>>> 
>>>> On 4/12/24 12:48 AM, Vlastimil Babka wrote:
>>>>> On 4/11/24 7:02 PM, Christoph Lameter (Ampere) wrote:
>>>>>> On Thu, 11 Apr 2024, Jianfeng Wang wrote:
>>>>>> 
>>>>>>> So, the fix is to limit the number of slabs to scan in
>>>>>>> count_partial(), and output an approximated result if the list is too
>>>>>>> long. Default to 10000 which should be enough for most sane cases.
>>>>>> 
>>>>>> 
>>>>>> That is a creative approach. The problem though is that objects on the 
>>>>>> partial lists are kind of sorted. The partial slabs with only a few 
>>>>>> objects available are at the start of the list so that allocations cause 
>>>>>> them to be removed from the partial list fast. Full slabs do not need to 
>>>>>> be tracked on any list.
>>>>>> 
>>>>>> The partial slabs with few objects are put at the end of the partial list 
>>>>>> in the hope that the few objects remaining will also be freed which would 
>>>>>> allow the freeing of the slab folio.
>>>>>> 
>>>>>> So the object density may be higher at the beginning of the list.
>>>>>> 
>>>>>> kmem_cache_shrink() will explicitly sort the partial lists to put the 
>>>>>> partial pages in that order.
>>>>>> 
> 
> Realized that I’d do "echo 1 > /sys/kernel/slab/dentry/shrink” to sort the list explicitly.
> After that, the numbers become:
> N = 10000 -> diff = 7.1 %
> N = 20000 -> diff = 5.7 %
> N = 25000 -> diff = 5.4 %
> So, expecting ~5-7% difference after shrinking.
> 
>>>>>> Can you run some tests showing the difference between the estimation and 
>>>>>> the real count?
>>>> 
>>>> Yes.
>>>> On a server with one NUMA node, I create a case that uses many dentry objects.
>>> 
>>> Could you describe in more detail how do you make dentry cache to grow such
>>> a large partial slabs list? Thanks.
>>> 
>> 
>> I utilized the fact that creating a folder will create a new dentry object;
>> deleting a folder will delete all its sub-folder's dentry objects.
>> 
>> Then, I started to create N folders, while each folder has M empty sub-folders.
>> Assuming that these operations would consume a large number of dentry
>> objects in the sequential order. Their slabs were very likely to be full slabs.
>> After all folders were created, I deleted a subset of the N folders (i.e.,
>> one out of every two folders). This would create many holes, which turned a
>> subset of full slabs into partial slabs.

Thanks, right, so that's quite a deterministic way to achieve the long
partial lists with very close to uniform ratio of free/used, so no wonder
the resulting accuracy is good and the diff is very small. But in practice
the workloads that may lead to long lists will not be so uniform. The result
after shrinking shows what happens if there's bias in which slabs we inspect
due to the sorting. But still most of the slabs will have the near-uniform
free/used ratio so the sorting will not do so much difference. But another
workload might do that.

So what happens if you inspect X slabs from the head and X from the tail as
I suggested? That should help your test case even after you sort, and also
should in theory be more accurate even for less uniform workloads.

