Return-Path: <linux-kernel+bounces-73488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B752485C355
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C93C1F2501E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941F78665;
	Tue, 20 Feb 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cApLI3Vd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gCM5cWYl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f3iT9O7i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5EMPdQE7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44814779F2;
	Tue, 20 Feb 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452395; cv=none; b=HDzIzJkZ0ZqqRGYXEwLp4+TG5tjhJ7W95WbcZn7JvCBY4MT0+ujhad3aYLAH4PSXF+uvGNfd7TCPwt1L3+fdOcK5AOaiJCvssX1BpHYBa7O2ZOnrwBhaa8/w/xatkvVkxZMWMlZRLykb2R29pHfUNm4w5vEAzNmLhWZQCCvosdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452395; c=relaxed/simple;
	bh=HTRjPgc3Z93+9+vnRup3H//l9q0/RpaJYD0XmG63Y+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgHuVNb2mpAqsx+SSTLvraoKcC4jKfsfKb5m0FTGtedb/FPBg/hool1kUkOFReYvyBePE21ZIikDLfLPxDUs6aovWxICfIKl/kYNQl7NKkiZl/YkpDXyY4yreScdwpXl3BppjnA5b0gYROX0WRE/2gZLk7ZsSecMyxRslvmxSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cApLI3Vd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gCM5cWYl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f3iT9O7i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5EMPdQE7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1B661F8BD;
	Tue, 20 Feb 2024 18:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708452387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdNVBUnk8GlUwBol8CUxIWy0oFcd/4EAWmIfbejS74g=;
	b=cApLI3Vd53N9iWV4D4ue8aW8yLUeZFs0TAKfgK8xOsLUY+K2ABrblF87rEz/VtP52H899z
	b6kVryas/eaoxIRdpmhWN4yYVOMoW4sPcIOKdM4Oj0vQ8HiSMkqHpT7//O/n6rorjO9KH7
	qurZBMQ+G2LFRVd5LTzahnPAOzVeWZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708452387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdNVBUnk8GlUwBol8CUxIWy0oFcd/4EAWmIfbejS74g=;
	b=gCM5cWYl5Rfvk51fIJTQEB9E8lv4vVXMcntr9izWnSANUzazeEQsZDido6rVDI7lw+7vOi
	08xbQYi75Ex9I+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708452386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdNVBUnk8GlUwBol8CUxIWy0oFcd/4EAWmIfbejS74g=;
	b=f3iT9O7iVtQTwb3EourgM2uTR02pJhWn8GaYv/zDzXwCH1DA53VB8TMwmOnLzTgbo5elvy
	wBDQTk9+r3b8X0f87m+EYm2PKvP40poM8lnXgDqehXRyKDkE8kCEYOQ8gQnXay8MIGAfF0
	hUEbgjxCG7m3674P0wn/xFvJY650nNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708452386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdNVBUnk8GlUwBol8CUxIWy0oFcd/4EAWmIfbejS74g=;
	b=5EMPdQE7hqDjKj9wMIqeEdMdIVkXVAYF5NCZ2lMCgDwbpHK0YfhUenXPEF5KjW6oxkCDDL
	s5l4y3eVq98zuqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA79E134E4;
	Tue, 20 Feb 2024 18:06:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +12wMCLq1GWKbQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Feb 2024 18:06:26 +0000
Message-ID: <48318c98-2a14-46c8-b6d5-8f8584b6a789@suse.cz>
Date: Tue, 20 Feb 2024 19:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add memory mapping entry with reviewers
Content-Language: en-US
To: Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "=Liam R . Howlett" <Liam.Howlett@oracle.com>, workflows@vger.kernel.org
References: <20240220064410.4639-1-lstoakes@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240220064410.4639-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-0.00)[13.75%];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux-foundation.org:email,oracle.com:email];
	 FREEMAIL_TO(0.00)[gmail.com,kvack.org,vger.kernel.org,linux-foundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/20/24 07:44, Lorenzo Stoakes wrote:
> Recently there have been a number of patches which have affected various
> aspects of the memory mapping logic as implemented in mm/mmap.c where it
> would have been useful for regular contributors to have been notified.
> 
> Add an entry for this part of mm in particular with regular contributors
> tagged as reviewers.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Would be nice if this targetted sub-reviewing could be managed in a simpler
way as part of the MM section instead of having to define a new one which
duplicates half of if, but until we have such support...

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b6c5c92e49db..129a237b7880 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14121,6 +14121,17 @@ F:	tools/mm/
>  F:	tools/testing/selftests/mm/
>  N:	include/linux/page[-_]*
>  
> +MEMORY MAPPING
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Lorenzo Stoakes <lstoakes@gmail.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	mm/mmap.c
> +
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>


