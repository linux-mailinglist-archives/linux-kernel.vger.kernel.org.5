Return-Path: <linux-kernel+bounces-74991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698685E0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3CA1C2137E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D680616;
	Wed, 21 Feb 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbWstRBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jzh+VVl9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbWstRBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jzh+VVl9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF708005D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529028; cv=none; b=HNWqUpvvwuuDMgvTuHgTmOqlongUU+s8PjqXQPPYb87UopOCRFsTkLCiaDqjZra9ttK8Fm5atTN/sq7mCtZwr5kd2Ea8i0EpiZxr+7EN0FXDDujRAybGezvuuv4QNBkC99pBBt5eoysN0Ri/wdI79Ly1Sm1WdlV9MGVL+Jbq/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529028; c=relaxed/simple;
	bh=7HdpLE4zlA19XMBlfJ008MrVhtqNeziWzHJKjOQ5KIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X72H0Wq8bMhagPS+khhIRTOQw9Eihaq5pR3Uv+izMQK06VQS+Tkj87bV5rfm87/P/R4VjuSAbU4IRSnd2nXwtRpAilRj+pdVs65BbOlbhfKBReo3aKQSZ8xVWUDjALOzZ6r/B/lNPm0jX+PlirNF7HEWL93kEZ68rU2ujdQ46Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbWstRBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jzh+VVl9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbWstRBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jzh+VVl9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE88422163;
	Wed, 21 Feb 2024 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708529024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d/yROKMdf9XfN6Ye5SUdQjzKdIEbWXHJFKPSeQOXa4=;
	b=sbWstRBjonUPvBAM72NQLCkKY2URoer8R2LZ5N1M9HFXP9dkGD8tqh07AzyMGDotm27y58
	voe9D8Ljv8jVhezUZICT3GZ0Z8C/mOJJhjOUfkKWwNOv2sYkbE8wfk0MKmDgMAZQ5qoCQH
	x4IdiMstesm+H3vMN3796HB/IzL3qdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708529024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d/yROKMdf9XfN6Ye5SUdQjzKdIEbWXHJFKPSeQOXa4=;
	b=jzh+VVl9FaRx3oKH224igBHJ7Iq7nyGYIeOzcqimtsoBVcuCFunKddehZ56KKQ++BunyJW
	NwbaqYRbMH1260BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708529024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d/yROKMdf9XfN6Ye5SUdQjzKdIEbWXHJFKPSeQOXa4=;
	b=sbWstRBjonUPvBAM72NQLCkKY2URoer8R2LZ5N1M9HFXP9dkGD8tqh07AzyMGDotm27y58
	voe9D8Ljv8jVhezUZICT3GZ0Z8C/mOJJhjOUfkKWwNOv2sYkbE8wfk0MKmDgMAZQ5qoCQH
	x4IdiMstesm+H3vMN3796HB/IzL3qdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708529024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d/yROKMdf9XfN6Ye5SUdQjzKdIEbWXHJFKPSeQOXa4=;
	b=jzh+VVl9FaRx3oKH224igBHJ7Iq7nyGYIeOzcqimtsoBVcuCFunKddehZ56KKQ++BunyJW
	NwbaqYRbMH1260BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B5EE139D0;
	Wed, 21 Feb 2024 15:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pHqtIYAV1mUgEAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Feb 2024 15:23:44 +0000
Message-ID: <8b2f876a-306c-49f3-8acb-6ac816fa0611@suse.cz>
Date: Wed, 21 Feb 2024 16:23:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm, slab: two minor cleanups
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240221-slab-cleanup-v1-0-63382f41d699@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221-slab-cleanup-v1-0-63382f41d699@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sbWstRBj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jzh+VVl9
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[44.09%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FREEMAIL_TO(0.00)[linux.dev,kernel.org,lge.com,linux-foundation.org,google.com,linux.com,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: AE88422163
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/21/24 13:12, Chengming Zhou wrote:
> Just two minor cleanups when reviewing the code.

Merged for 6.9, thanks.

> Thanks!
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
> Chengming Zhou (2):
>       mm, slab: remove unused object_size parameter in kmem_cache_flags()
>       mm, slab: fix the comment

	made this subject more specific:
mm, slab: fix the comment of cpu partial list

> 
>  mm/slab.h        |  3 +--
>  mm/slab_common.c |  2 +-
>  mm/slub.c        | 11 ++++-------
>  3 files changed, 6 insertions(+), 10 deletions(-)
> ---
> base-commit: c09a8e005eff6c064e2e9f11549966c36a724fbf
> change-id: 20240221-slab-cleanup-df9652186012
> 
> Best regards,


