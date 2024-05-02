Return-Path: <linux-kernel+bounces-166437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5EA8B9AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37AFB2398B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8A877F13;
	Thu,  2 May 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="veqotFvG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9jFWxyHb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="veqotFvG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9jFWxyHb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE0D26A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652585; cv=none; b=C4OeeZY72QokYLnkk2LCcfbk/QjIYIsmUwtHzxRUrXN6EOKKEorUKG+EdXvE2QJbx6eUItUh89vtZCSa52VyjyYlS9tSpxgJEVxWN1+M+SVij+yMgbPtvN0eNZ1+v2Y1E3ROiZtEn8sS5K9cOsDcmghNJ+YdJP+8y8oBXAkXtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652585; c=relaxed/simple;
	bh=J5Gbb28PWVRjoM6ofQuKxcdt2Y+r4kfgcHxs+9oOS58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx9ezi0Fbl79W0pUNmLPUPr3Fhm0EOty/r8k/d3sTZQOc/og0A8AP0CMuD6NBoJK7nELm7kiKMKZjIX2j1Z1GtBHJ1i1mcCxLSzlYbkd7aUThBe/dcLSCDTlBa0LcOGpAeRol2KyZn++QTp+EgKaZQJWwDPL30S7CNabGH8tQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=veqotFvG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9jFWxyHb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=veqotFvG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9jFWxyHb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41581352F6;
	Thu,  2 May 2024 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714652581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJmYOWiytFqZ/McyZKWdmo+2f9lysX01+48DFAf0K7Y=;
	b=veqotFvG5QEbFCJ6IZBrEZfD0A/J2Tiv/02KDEz+Fj88vgaSEXE6TRceyhuMNybfGD/H69
	+mIKUHCXlVkw3MDCwO6tyFXOHzG5Mc6xBzpfHKi0MQpLVmi00sY8KWOUy5lbvs5nkjzSbM
	8K6VPmt4fiuJrCOSs3UHl27ik81eWPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714652581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJmYOWiytFqZ/McyZKWdmo+2f9lysX01+48DFAf0K7Y=;
	b=9jFWxyHbi1VRs16oyaHveaSUg/OHviPqh1jGWTy+xraGitWBsHcd+jBwC/u0mQqLQcKest
	WPpNHSrPVv4turBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714652581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJmYOWiytFqZ/McyZKWdmo+2f9lysX01+48DFAf0K7Y=;
	b=veqotFvG5QEbFCJ6IZBrEZfD0A/J2Tiv/02KDEz+Fj88vgaSEXE6TRceyhuMNybfGD/H69
	+mIKUHCXlVkw3MDCwO6tyFXOHzG5Mc6xBzpfHKi0MQpLVmi00sY8KWOUy5lbvs5nkjzSbM
	8K6VPmt4fiuJrCOSs3UHl27ik81eWPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714652581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJmYOWiytFqZ/McyZKWdmo+2f9lysX01+48DFAf0K7Y=;
	b=9jFWxyHbi1VRs16oyaHveaSUg/OHviPqh1jGWTy+xraGitWBsHcd+jBwC/u0mQqLQcKest
	WPpNHSrPVv4turBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 332871386E;
	Thu,  2 May 2024 12:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zW9QDKWFM2aDOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 02 May 2024 12:23:01 +0000
Message-ID: <203b39b1-fd83-4fc6-9d55-004d998494f2@suse.cz>
Date: Thu, 2 May 2024 14:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slub: mark racy access on slab->freelist
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <tencent_579220610AF1240FE3735A3443DBB01F9D07@qq.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <tencent_579220610AF1240FE3735A3443DBB01F9D07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.83 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.04)[87.55%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com]
X-Spam-Score: -0.83
X-Spam-Flag: NO

On 4/27/24 10:51, linke li wrote:
> In deactivate_slab(), slab->freelist can be changed concurrently. Mark
> data race on slab->freelist as benign using READ_ONCE.
> 
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.
> 
> Signed-off-by: linke li <lilinke99@qq.com>

Added to slab/for-6.10, thanks

> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 0d700f6ca547..bb0e05a321e9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2813,7 +2813,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	struct slab new;
>  	struct slab old;
>  
> -	if (slab->freelist) {
> +	if (READ_ONCE(slab->freelist)) {
>  		stat(s, DEACTIVATE_REMOTE_FREES);
>  		tail = DEACTIVATE_TO_TAIL;
>  	}

