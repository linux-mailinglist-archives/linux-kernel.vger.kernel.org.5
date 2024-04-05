Return-Path: <linux-kernel+bounces-133174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC9899FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9952BB21C91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D53A16F290;
	Fri,  5 Apr 2024 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mKb0fGzG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kd1/pDbS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMQsDqGJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dISl3Y91"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6E16D318
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327937; cv=none; b=poeg5ERFeGYRFa+l3Rw7k8McrIQQmYM2LnzK+xEVw4VmXGmgqxPcmDoKU7lGun4OoKaIggBzbIqTEXGlqt1GRMhs/QKnLqCrFO3nlLbuTaktX4OtsjtPH9Bg178awRAdpKL+EzQNboS88HffnODwRsO5YOqbUyQkZalvUkqeft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327937; c=relaxed/simple;
	bh=e1ZWve/u38y433TcN0iVPl3v8m0TQBQahVcmrDvvY1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aveznr9O/X+OMD0w6uEGDtX2CtLP/AQSX+C/YehieGKb5X5l3ZsKZgKCDAvpGZFJyqlPiC+E8s67Bjfx7rER5rL8iF+P7rqFMx/HHrTg81A66INuhRDgMLWuu4CefZHeKqowcAadIN0Fpure3fBa75zZ1rf9xlNuMQMu4XLBbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mKb0fGzG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kd1/pDbS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMQsDqGJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dISl3Y91; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECC7E1F7DB;
	Fri,  5 Apr 2024 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712327933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tGjNxyWRAfeS20qfIYZIZwqLpRavo/s9K7D+ViuGA7o=;
	b=mKb0fGzG3NzHBDxkZIjLETm1nSZ2I6toSushitGm/VsrAMxpylpbeZmDLsX+cWJhA1PJxI
	2q6VFDjP9WR8/IZL8w48ce50LIxO91Bu70zx8fDYWuTPPJwfv6ZLkRpssVuOVvZxYDXI9C
	55TwPobPJ9B4V/on9HJ83Ix7s4soH9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712327933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tGjNxyWRAfeS20qfIYZIZwqLpRavo/s9K7D+ViuGA7o=;
	b=kd1/pDbSXaqi6uy2n97yp+COkQGiCUcskkbzTD3q24lF9CRMAeoaMXB23YvPhz4eBXa/jk
	xOywdEMc3jc9vUDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sMQsDqGJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dISl3Y91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712327932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tGjNxyWRAfeS20qfIYZIZwqLpRavo/s9K7D+ViuGA7o=;
	b=sMQsDqGJdpz52Z9Ar3IobvA0m1fgLFv7xxiBKaE96W8UZ8xiLIycni5fccmioYFtLIXTDG
	cdzEQxcX3oxT1zYCK/y/a5O7zgfKyzJFp2ZDDIwcGV0kp2bvIv1sp5oiTMGi1W4GDr//q7
	0p5/Lp1tfBkInuN8hKWsryYOe4Sem7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712327932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tGjNxyWRAfeS20qfIYZIZwqLpRavo/s9K7D+ViuGA7o=;
	b=dISl3Y919VVMZbnhhPl/pMyTDs1W9kN8HS1jebNkg4Y3B1C1Qpczq6KQ1ifCijiIaV3CWL
	dermd1yAoj9HpEBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C97C0139E8;
	Fri,  5 Apr 2024 14:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ts4IMPwMEGZwSAAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Fri, 05 Apr 2024 14:38:52 +0000
Message-ID: <eaafb10a-cbe5-4303-8264-7c802c1fd94d@suse.cz>
Date: Fri, 5 Apr 2024 16:38:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: set pageblock_order to HPAGE_PMD_ORDER in case with
 !CONFIG_HUGETLB_PAGE but THP enabled
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: mgorman@techsingularity.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <3d57d253070035bdc0f6d6e5681ce1ed0e1934f7.1712286863.git.baolin.wang@linux.alibaba.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <3d57d253070035bdc0f6d6e5681ce1ed0e1934f7.1712286863.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -1.88
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ECC7E1F7DB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.88 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.38)[77.24%];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]

On 4/5/24 2:24 PM, Baolin Wang wrote:
> As Vlastimil suggested in previous discussion[1], it doesn't make sense to set
> pageblock_order as MAX_PAGE_ORDER when hugetlbfs is not enabled and THP is enabled.
> Instead, it should be set to HPAGE_PMD_ORDER.
> 
> [1] https://lore.kernel.org/all/76457ec5-d789-449b-b8ca-dcb6ceb12445@suse.cz/
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> ---
>  include/linux/pageblock-flags.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index 3f2409b968ec..547e82cdc89a 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -28,7 +28,7 @@ enum pageblock_bits {
>  	NR_PAGEBLOCK_BITS
>  };
>  
> -#ifdef CONFIG_HUGETLB_PAGE
> +#if defined(CONFIG_HUGETLB_PAGE)
>  
>  #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
>  
> @@ -45,7 +45,11 @@ extern unsigned int pageblock_order;
>  
>  #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
>  
> -#else /* CONFIG_HUGETLB_PAGE */
> +#elif defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +
> +#define pageblock_order		min_t(unsigned int, HPAGE_PMD_ORDER, MAX_PAGE_ORDER)
> +
> +#else /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  /* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
>  #define pageblock_order		MAX_PAGE_ORDER


