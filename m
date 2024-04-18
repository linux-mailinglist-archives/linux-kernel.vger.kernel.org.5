Return-Path: <linux-kernel+bounces-150074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE98A99FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23531C219F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5D22F19;
	Thu, 18 Apr 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Do9eUX88";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wwjPwJkL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Do9eUX88";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wwjPwJkL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B6182C5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444088; cv=none; b=ovgbfqZGi9w/Eq350DSjBYBUfJTruMnaBF09WwhgUbogg2ZZ9qq6zL3SYaKTaAsd1ARzDsSUJyoBleD0EEzAZcYbsgPjQPbrc46KALmBokuvKEWjZqn+hztGtsKR3IMHwO763VFaJPIZ2KLAHuT11PS6OOG8Na0oAJyUZbzPKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444088; c=relaxed/simple;
	bh=Dot82zyMxUe9JpcgnocyYwO3KhCnP0t07rc/4gubA+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZWTMvGLZqcXAajYfa4IFiRChE4nYwyRJTvV9wcW0+SWsd8Lqz4ytcxHoRrmyPSIrHp3Xwo7VK+f+Joscf77KyqsD3lm1KMEPPx5xlT2w9tnxtmuZzboA3tRjMgb+cGBtfWnq4DgU4ZHZKcmnnrpJtUe10MN0SwMHCHV/X6dQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Do9eUX88; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wwjPwJkL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Do9eUX88; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wwjPwJkL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18E975CA7F;
	Thu, 18 Apr 2024 12:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713444085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7DjYF/kzJVRyzAMWLo9U8Tt/CvqZCHiGjMu2GCpIDI=;
	b=Do9eUX882YqcS8xoSEeXDPg4XTx6cgiXlVX/YK6G17yn00bKmKkiYuLOAe0RxGtTEEYuGA
	gjYJClaNGYxtypuUrOW2JQww2tA0GEK0YBVpov1RyoBP4hDwsZDjCuOtKkoAaZQb8XWx7i
	98euAmb9sM35tluf2Xs6z7Yd1vktniI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713444085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7DjYF/kzJVRyzAMWLo9U8Tt/CvqZCHiGjMu2GCpIDI=;
	b=wwjPwJkLn9NuL2V4IfPdQnaU2WxlBfx1gurlLfpMq0IUkNcXpZ0viQmf67/jerGBufzDzO
	88l9eMsO8Gbuv1DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Do9eUX88;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wwjPwJkL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713444085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7DjYF/kzJVRyzAMWLo9U8Tt/CvqZCHiGjMu2GCpIDI=;
	b=Do9eUX882YqcS8xoSEeXDPg4XTx6cgiXlVX/YK6G17yn00bKmKkiYuLOAe0RxGtTEEYuGA
	gjYJClaNGYxtypuUrOW2JQww2tA0GEK0YBVpov1RyoBP4hDwsZDjCuOtKkoAaZQb8XWx7i
	98euAmb9sM35tluf2Xs6z7Yd1vktniI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713444085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7DjYF/kzJVRyzAMWLo9U8Tt/CvqZCHiGjMu2GCpIDI=;
	b=wwjPwJkLn9NuL2V4IfPdQnaU2WxlBfx1gurlLfpMq0IUkNcXpZ0viQmf67/jerGBufzDzO
	88l9eMsO8Gbuv1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96F5E13687;
	Thu, 18 Apr 2024 12:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iKYuIvQUIWYyfQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Apr 2024 12:41:24 +0000
Date: Thu, 18 Apr 2024 14:41:23 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	vbabka@suse.cz, willy@infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
Message-ID: <ZiEU83kaHP7AG25z@localhost.localdomain>
References: <20240418022000.3524229-1-linmiaohe@huawei.com>
 <20240418022000.3524229-2-linmiaohe@huawei.com>
 <ZiCb_r8O24p8qHIz@localhost.localdomain>
 <a852eb0c-f64e-f1d7-d685-a4e81a6416c6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a852eb0c-f64e-f1d7-d685-a4e81a6416c6@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 18E975CA7F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Thu, Apr 18, 2024 at 04:00:42PM +0800, Miaohe Lin wrote:
> On 2024/4/18 12:05, Oscar Salvador wrote:
> > On Thu, Apr 18, 2024 at 10:19:59AM +0800, Miaohe Lin wrote:
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 26ab9dfc7d63..1da9a14a5513 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -1788,7 +1788,8 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
> >>  		destroy_compound_gigantic_folio(folio, huge_page_order(h));
> >>  		free_gigantic_folio(folio, huge_page_order(h));
> >>  	} else {
> >> -		INIT_LIST_HEAD(&folio->_deferred_list);
> >> +		if (!folio_test_hugetlb(folio))
> >> +			INIT_LIST_HEAD(&folio->_deferred_list);
> > 
> > Ok, it took me a bit to figure this out.
> > 
> > So we basically init __deferred_list when we know that
> > folio_put will not end up calling free_huge_folio
> > because a previous call to remove_hugetlb_folio has already cleared the
> > bit.
> > 
> > Maybe Matthew thought that any folio ending here would not end up in
> > free_huge_folio (which is the one fiddling subpool).
> > 
> > I mean, fix looks good because if hugetlb flag is cleared,
> > destroy_large_folio will go straight to free_the_page, but the
> > whole thing is a bit subtle.
> 
> AFAICS, this is the most straightforward way to fix the issue. Do you have any suggestions
> on how to fix this in a more graceful way?

Not from the top of my head.
Anyway, I have been thinking for a while that this code needs some love,
so I will check how this can be untangled.


-- 
Oscar Salvador
SUSE Labs

