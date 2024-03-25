Return-Path: <linux-kernel+bounces-116717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33A88A2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3508D2CA978
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152F130AF9;
	Mon, 25 Mar 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XfwZd6ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AyQURhGX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XfwZd6ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AyQURhGX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7C131E4E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356669; cv=none; b=to7Ky1teOPv96w7OQVQ/i6OnheJLbyx7e8MY6Zl4tlhzDccwZCf4XztngM4JdYLIBI024kBGpA8+KKfBz5LxOSrk8H2tNNVtXuA6cw1rT+++hp5uwBnIcVR83o1BBEhdpKRrjxVCUFX8Fd7qljI526DzdjX0XtAgP8lmjSVR5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356669; c=relaxed/simple;
	bh=QJW0SCNPKaC1Rh0SylbldNlW4PUZWKkzqcy7KYQ0WEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxRR5SfAZiZIVTW0K+dU6H1w7K6m7W2fcY6kHCqh4EO2VQl2ApTSp6H7u/beHVLdkZ+rPB7MX2FFOFQQjlKPQye8P8yH6ct5o8DyCYqoeWXfBK0pzlb3b5VZLPpUEs1gSFdymMMjS2TUvbIe/OAmZr/vPmHt7MvCXxoXzdgIb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XfwZd6ES; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AyQURhGX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XfwZd6ES; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AyQURhGX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EDF05C448;
	Mon, 25 Mar 2024 08:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711356665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65tAr47dWAJ3vDg3RDQQXn3Wlhxz3JMVH3FznVwyuS0=;
	b=XfwZd6ESRlzz8rn2k7LpZFxVOZYoymS2+Sw0/ywCCj2CLpcpj9Ja8dBAE5pwVnsaf6FNkO
	/QZskaDbxzGbZyUlGenuK/XlXb06Vmki5v8dSd7A4RI7T6qZIG6pVxI+igVyCpgoMWomcG
	TkQpLlFLYT+rIbCflsSMukhpJEJ+EaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711356665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65tAr47dWAJ3vDg3RDQQXn3Wlhxz3JMVH3FznVwyuS0=;
	b=AyQURhGXMQnXHcFKu3ysJ9uI11JaQ2d3DnqWF2PG7GDn0GaSGmAtCjFMeJOqTkIryW3S+m
	rrdyp7Ni/BWq3yAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711356665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65tAr47dWAJ3vDg3RDQQXn3Wlhxz3JMVH3FznVwyuS0=;
	b=XfwZd6ESRlzz8rn2k7LpZFxVOZYoymS2+Sw0/ywCCj2CLpcpj9Ja8dBAE5pwVnsaf6FNkO
	/QZskaDbxzGbZyUlGenuK/XlXb06Vmki5v8dSd7A4RI7T6qZIG6pVxI+igVyCpgoMWomcG
	TkQpLlFLYT+rIbCflsSMukhpJEJ+EaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711356665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65tAr47dWAJ3vDg3RDQQXn3Wlhxz3JMVH3FznVwyuS0=;
	b=AyQURhGXMQnXHcFKu3ysJ9uI11JaQ2d3DnqWF2PG7GDn0GaSGmAtCjFMeJOqTkIryW3S+m
	rrdyp7Ni/BWq3yAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 052E513503;
	Mon, 25 Mar 2024 08:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g//rAPk6AWb3JQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Mar 2024 08:51:05 +0000
Message-ID: <e523193d-c4f5-488b-955c-366a0bf15b9f@suse.cz>
Date: Mon, 25 Mar 2024 09:51:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: mark racy accesses on slab->slabs
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>, linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <tencent_909E215498A54E4E100E456A92A7F13DAD06@qq.com>
 <8b146695-4ff5-4f9a-ab64-6cbed4168f98@suse.cz>
 <a5141311-38bf-421e-9058-6c278840fb97@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <a5141311-38bf-421e-9058-6c278840fb97@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.05
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.05 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[linux.dev,qq.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-2.05)[95.32%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XfwZd6ES;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AyQURhGX
X-Rspamd-Queue-Id: 1EDF05C448

On 3/25/24 9:49 AM, Chengming Zhou wrote:
> On 2024/3/25 16:48, Vlastimil Babka wrote:
>> On 3/21/24 4:48 AM, linke li wrote:
>>> The reads of slab->slabs are racy because it may be changed by
>>> put_cpu_partial concurrently. In slabs_cpu_partial_show() and 
>>> show_slab_objects(), slab->slabs is only used for showing information.
>>>
>>> Data-racy reads from shared variables that are used only for diagnostic
>>> purposes should typically use data_race(), since it is normally not a
>>> problem if the values are off by a little.
>>>
>>> This patch is aimed at reducing the number of benign races reported by
>>> KCSAN in order to focus future debugging effort on harmful races.
>>>
>>> Signed-off-by: linke li <lilinke99@qq.com>
>>> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>> 
>> Chengming provided feedback to v1 but not offered a Reviewed-by: AFAICS? Or
>> maybe will offer it now? :)
> 
> Ah, right.
> 
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks, added to slab/for-6.10/cleanup


