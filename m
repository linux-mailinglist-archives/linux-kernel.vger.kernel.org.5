Return-Path: <linux-kernel+bounces-77454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D4186057C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE4228948F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508B137903;
	Thu, 22 Feb 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S+AOktY+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/wOuXm+Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S+AOktY+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/wOuXm+Z"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD373F10
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640076; cv=none; b=AVWxWewg9FdUMJCDQc1Im7z8XHFS21WmIl+/ozQFmM9WG0UImkYfKYLMUeOlL9eTK1+0zyJxXm5Uqp+Q2VEq6S2HwsBVIjRznd686To5W+BRoITLdKk3K0u+s4o7+l8xI/hkEhxhrUfwHRTyQB81HxeaaQSdViqVaebumDM8RF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640076; c=relaxed/simple;
	bh=CCWvmYyAAfCjtNJbIiOfHLAVoscoYeZZ2nmAaa5xvjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTK7qb8ofAzY7STKbPkMlJ7H/oMQM0wG4OelgJQNvyvTznUc+0U8YuA+skp1VCclolxhXoofocMPj/kWOecHpwLrgzAAB8ZARS7PAH9M4QPUaTgwh3dpDXd1+ZtR9GozLbE+4W4zOB0dc5pQJdvsvjs+Nec3Iwldg/tdzbW5Lv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S+AOktY+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/wOuXm+Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S+AOktY+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/wOuXm+Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A9AB1F799;
	Thu, 22 Feb 2024 22:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708640072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3x1kXri66JyHJOjJiePnNdMjnDBmEbBOnkticzR0VQ=;
	b=S+AOktY+cQNOIwM2Du5uSUZhxwzrPjB1rlMQoamhOh4z18lJYbtQXVkN3jzxUA+igqzIC5
	vap7UwdO0tEiomvKHCuyIln14POsKalV86LWQZt5Ut7dJeOyBI9zOogE43ZRQSZaTz0b57
	qvMZXY9Vw77O/EYQ+vXNettiumsvOcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708640072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3x1kXri66JyHJOjJiePnNdMjnDBmEbBOnkticzR0VQ=;
	b=/wOuXm+ZPVGVBWhE923F8HxmuuKJeAvFCntErDyRom5JpHFxn75bYH+8LmpKz40lzjRcjZ
	sE16Fb/Bx5OFAhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708640072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3x1kXri66JyHJOjJiePnNdMjnDBmEbBOnkticzR0VQ=;
	b=S+AOktY+cQNOIwM2Du5uSUZhxwzrPjB1rlMQoamhOh4z18lJYbtQXVkN3jzxUA+igqzIC5
	vap7UwdO0tEiomvKHCuyIln14POsKalV86LWQZt5Ut7dJeOyBI9zOogE43ZRQSZaTz0b57
	qvMZXY9Vw77O/EYQ+vXNettiumsvOcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708640072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3x1kXri66JyHJOjJiePnNdMjnDBmEbBOnkticzR0VQ=;
	b=/wOuXm+ZPVGVBWhE923F8HxmuuKJeAvFCntErDyRom5JpHFxn75bYH+8LmpKz40lzjRcjZ
	sE16Fb/Bx5OFAhAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1608113A6B;
	Thu, 22 Feb 2024 22:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id liI/AkjH12XxQQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 22 Feb 2024 22:14:32 +0000
Date: Thu, 22 Feb 2024 23:15:39 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
Message-ID: <ZdfHi142dvQuN7B-@localhost.localdomain>
References: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
 <0514e5139b17ecf3cd9e09d86c93e586c56688dc.1708507022.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0514e5139b17ecf3cd9e09d86c93e586c56688dc.1708507022.git.baolin.wang@linux.alibaba.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S+AOktY+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/wOuXm+Z"
X-Spamd-Result: default: False [-2.96 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.65)[98.45%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A9AB1F799
X-Spam-Level: 
X-Spam-Score: -2.96
X-Spam-Flag: NO

On Wed, Feb 21, 2024 at 05:27:54PM +0800, Baolin Wang wrote:
> Based on the analysis of the various scenarios above, determine whether fallback is
> permitted according to the migration reason in alloc_hugetlb_folio_nodemask().

Hi Baolin,

The high level reasoning makes sense to me, taking a step back and
thinking about all cases and possible outcomes makes sense to me.

I plan to look closer, but I something that caught my eye:


>  	}
>  	spin_unlock_irq(&hugetlb_lock);
>  
> +	if (gfp_mask & __GFP_THISNODE)
> +		goto alloc_new;
> +
> +	/*
> +	 * Note: the memory offline, memory failure and migration syscalls can break
> +	 * the per-node hugetlb pool. Other cases can not allocate new hugetlb on
> +	 * other nodes.
> +	 */
> +	switch (reason) {
> +	case MR_MEMORY_HOTPLUG:
> +	case MR_MEMORY_FAILURE:
> +	case MR_SYSCALL:
> +	case MR_MEMPOLICY_MBIND:
> +		allowed_fallback = true;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!allowed_fallback)
> +		gfp_mask |= __GFP_THISNODE;

I think it would be better if instead of fiddling with gfp here,
have htlb_alloc_mask() have a second argument with the MR_reason,
do the switch there and enable GFP_THISNODE.
Then alloc_hugetlb_folio_nodemask() would already get the right mask.

I think that that might be more clear as it gets encapsulated in the
function that directly gives us the gfp.

Does that makes sense?


-- 
Oscar Salvador
SUSE Labs

