Return-Path: <linux-kernel+bounces-142177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323748A287B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DF31F21D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C74F5FA;
	Fri, 12 Apr 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M9AoY0dx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="30Go7L5u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ghBzotRh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gm+Uc32c"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D404E1B3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908125; cv=none; b=gnbcIf3l6OY/DP5XZp1kC8fvLA2DDcbHAbZEZpMjDgpaG1TKTtnczBYXYjr4eT6PNCZasqftRdz3msc3c65Ml/RkkxwOQDWnqENmaHMuBddjd9nB5+SZNCXtRfoA2uQy3+rAbz9JpeAsXDmFhmRRg/7LEIEUpBR/S6HGEgC5X9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908125; c=relaxed/simple;
	bh=jXsU6Kb2cNja2z4fiHkIKLrZZXwEhKgL9qc3t3d41Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+07HDcqsksaymcQKa+kr8hTopV9Z/vKimLc/rs3QnXM++TB+nkzj5ILed/cEvgJA+9hKMzjI2ftXgaVPBTtONioOMrfMJKU1Tze2HdODIf9tKdAb6WtNejDdZcGEOS8JpUQed9MLxKjKiqwcqSjwgx3bfsgaxWzRuoIRMk1GJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M9AoY0dx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=30Go7L5u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ghBzotRh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gm+Uc32c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B96F5F9B4;
	Fri, 12 Apr 2024 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712908122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SaSfckjXYUnyk8FJwdqdTVvSoVpi0vbEbtm9bShPV2s=;
	b=M9AoY0dxSpBfnpJ2/tB87Ij/80PYIt6iPK0vyHNcYWop0IFktYwnRuEwG6qN/2LXJtT4eU
	jJSYLzcoYnrj7Yd7pGSXibeXAuLREE5LEBEfiaXSG3s6VqVN8jFHWCIf4V4BDQicwXRyqG
	9IsVsqnx9LD332Ob30UQAEuwr50zSpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712908122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SaSfckjXYUnyk8FJwdqdTVvSoVpi0vbEbtm9bShPV2s=;
	b=30Go7L5u81p3+LHSucwgzyHFnAFum03+wSfGwOfxiMbpeOiMIf0YlLQ0KX7kK1bKumxdgg
	WJdKi5ZOJw6m3ADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712908121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SaSfckjXYUnyk8FJwdqdTVvSoVpi0vbEbtm9bShPV2s=;
	b=ghBzotRhErprVdX3R1SZmG6dKvt5Z3JQiDyfBq5IQqnWJKjTSebtT/yl36RA/NHmYI1X73
	e+VzGzIv1vx/1XI8aJ4G7J9nsap2ztThQyFoGsakE+g0X8sW/YrNVage74nmG6TSzXSWAk
	i86HHVCRfkkJF21V2S4whzlBbcYof1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712908121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SaSfckjXYUnyk8FJwdqdTVvSoVpi0vbEbtm9bShPV2s=;
	b=Gm+Uc32cbVPLO62Y8Ymxk5mZ3LwqOXdRlDYZ7nVehMr5amWjtpWNi7qvzXjUvAWLGBCG3T
	qp0xNK0J7OOzJaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D6FD13942;
	Fri, 12 Apr 2024 07:48:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FQ30AlnnGGZicAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 12 Apr 2024 07:48:41 +0000
Message-ID: <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
Date: Fri, 12 Apr 2024 09:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@linux.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 junxiao.bi@oracle.com
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
 <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On 4/11/24 7:02 PM, Christoph Lameter (Ampere) wrote:
> On Thu, 11 Apr 2024, Jianfeng Wang wrote:
> 
>> So, the fix is to limit the number of slabs to scan in
>> count_partial(), and output an approximated result if the list is too
>> long. Default to 10000 which should be enough for most sane cases.
> 
> 
> That is a creative approach. The problem though is that objects on the 
> partial lists are kind of sorted. The partial slabs with only a few 
> objects available are at the start of the list so that allocations cause 
> them to be removed from the partial list fast. Full slabs do not need to 
> be tracked on any list.
> 
> The partial slabs with few objects are put at the end of the partial list 
> in the hope that the few objects remaining will also be freed which would 
> allow the freeing of the slab folio.
> 
> So the object density may be higher at the beginning of the list.
> 
> kmem_cache_shrink() will explicitly sort the partial lists to put the 
> partial pages in that order.
> 
> Can you run some tests showing the difference between the estimation and 
> the real count?

Maybe we could also get a more accurate picture by counting N slabs from the
head and N from the tail and approximating from both. Also not perfect, but
could be able to answer the question if the kmem_cache is significantly
fragmented. Which is probably the only information we can get from the
slabinfo <active_objs> vs <num_objs>. IIRC the latter is always accurate,
the former never because of cpu slabs, so we never know how many objects are
exactly in use. By comparing both we can get an idea of the fragmentation,
and if this change won't make that estimate significantly worse, it should
be acceptable.

