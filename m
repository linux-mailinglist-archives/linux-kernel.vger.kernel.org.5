Return-Path: <linux-kernel+bounces-149492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E93C8A91BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96756B228D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEA454BFA;
	Thu, 18 Apr 2024 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PsXgJRCl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lePxpKpb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PsXgJRCl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lePxpKpb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2954BC3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413126; cv=none; b=FA/va5C9RW6i/lQvvnfgqMcvb11N5fodiFanX75LLqKfzoWkrpY1/vDaSFvFAFGQH1m1yxuaEoi7A8g9j+iuhD2lDIRmcCsAPdqRwrfApAi1T8A1ol/qI0cuTeeJ6dyX3u66zfqGg6RjGlNYP50GF1D3g0iWYg3Vmev9chouX7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413126; c=relaxed/simple;
	bh=AIKrkgDgZc0U8yraOKSyiiypL/jLE/WKx7X56cv4TpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp8h3XGFbYuSvBdu7BWQa6C/cmL21mFjf9ZERpbESPl6dXZcLc+66RwWv2UzQNUI3sNQr5S0ritZsrGHJ7gC4maqZbYPJDjMtiFdIk1GHU9uagn3LuB4Bee2Nx+Xw/SyYvSUkfcji9NDD4lV8Tz6/1UMLbPXknuq5hXSJCrsKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PsXgJRCl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lePxpKpb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PsXgJRCl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lePxpKpb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 094253485A;
	Thu, 18 Apr 2024 04:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713413120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQh4ImWl/I1yBrXMSRwJoonZ4BB2QnYBFQWwBdSeffk=;
	b=PsXgJRClQkJ6a1EgF1RkNTpoKaHUQgVVFwx1YSRSNkLDYhpi6z1SXE3z728KsGJ0DJ0Gsy
	ZAk3iyGw9TVrivPmlO0Xi6rh9taLhkbtDL10CrY1MHel57YhJG3cU8FDkGPQbVEZwM6OhJ
	6a1At7N195X4vgZGyikzGYJPmw9TQvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713413120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQh4ImWl/I1yBrXMSRwJoonZ4BB2QnYBFQWwBdSeffk=;
	b=lePxpKpbSDpOmSUfB6zGsve4Q6pWaG4fKsavzPM+ickABBxxvc5l5OBtXzgUPC+0QKobjM
	aAWtxCMaA00MiyDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PsXgJRCl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lePxpKpb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713413120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQh4ImWl/I1yBrXMSRwJoonZ4BB2QnYBFQWwBdSeffk=;
	b=PsXgJRClQkJ6a1EgF1RkNTpoKaHUQgVVFwx1YSRSNkLDYhpi6z1SXE3z728KsGJ0DJ0Gsy
	ZAk3iyGw9TVrivPmlO0Xi6rh9taLhkbtDL10CrY1MHel57YhJG3cU8FDkGPQbVEZwM6OhJ
	6a1At7N195X4vgZGyikzGYJPmw9TQvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713413120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQh4ImWl/I1yBrXMSRwJoonZ4BB2QnYBFQWwBdSeffk=;
	b=lePxpKpbSDpOmSUfB6zGsve4Q6pWaG4fKsavzPM+ickABBxxvc5l5OBtXzgUPC+0QKobjM
	aAWtxCMaA00MiyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86795133A7;
	Thu, 18 Apr 2024 04:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U7gVHv+bIGbZSgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Apr 2024 04:05:19 +0000
Date: Thu, 18 Apr 2024 06:05:18 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	vbabka@suse.cz, willy@infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
Message-ID: <ZiCb_r8O24p8qHIz@localhost.localdomain>
References: <20240418022000.3524229-1-linmiaohe@huawei.com>
 <20240418022000.3524229-2-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418022000.3524229-2-linmiaohe@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -3.67
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 094253485A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.67 / 50.00];
	BAYES_HAM(-1.16)[88.84%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Thu, Apr 18, 2024 at 10:19:59AM +0800, Miaohe Lin wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 26ab9dfc7d63..1da9a14a5513 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1788,7 +1788,8 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>  		destroy_compound_gigantic_folio(folio, huge_page_order(h));
>  		free_gigantic_folio(folio, huge_page_order(h));
>  	} else {
> -		INIT_LIST_HEAD(&folio->_deferred_list);
> +		if (!folio_test_hugetlb(folio))
> +			INIT_LIST_HEAD(&folio->_deferred_list);

Ok, it took me a bit to figure this out.

So we basically init __deferred_list when we know that
folio_put will not end up calling free_huge_folio
because a previous call to remove_hugetlb_folio has already cleared the
bit.

Maybe Matthew thought that any folio ending here would not end up in
free_huge_folio (which is the one fiddling subpool).

I mean, fix looks good because if hugetlb flag is cleared,
destroy_large_folio will go straight to free_the_page, but the
whole thing is a bit subtle.

And if we decide to go with this, I think we are going to need a comment
in there explaining what is going on like "only init _deferred_list if
free_huge_folio cannot be call".


-- 
Oscar Salvador
SUSE Labs

