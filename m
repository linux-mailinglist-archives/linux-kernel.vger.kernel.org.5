Return-Path: <linux-kernel+bounces-66744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EA68560F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED6C1F2158B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097E127B6E;
	Thu, 15 Feb 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rvNwiP/3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RhmoHrCn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gb53DiWN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ofZsuqi3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2631756B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995339; cv=none; b=VDeXrnc0Eo7mf3P7QZ+TCRT/3IgCddvX/JbCvJFz1Ty3NLeXqlY1gPnhh83x3Lr0sJWiWzOMRX8LxMfvcr2MZMIpw/fFYd565O27RdE+SLPoKY1980mVXCSF9mB9Hgo/Pubotsw2hcPKry8cBkq6l/fQ7H3C/i0DRfoMQT/q4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995339; c=relaxed/simple;
	bh=iER6v7Usa2T+q1ikk7l6+8+K4Mj6aNJY46+g9WMWgHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf7ipqBzIutbpWbnl0Zxt3SYm5dpge0EQnPTPkveILterbF/lUFYS3rZ9l2qy5RQTJ4m2KB6hKjXENATO/d6htq9kbwoKi5+m6zMKvB+ip3+llA9Rl7lm/gtVerXNp+cuvNpsS0hkBt0iWNNhdGVgvsI7aAoAUgC4IcPo9bznTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rvNwiP/3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RhmoHrCn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gb53DiWN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ofZsuqi3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 378611F88D;
	Thu, 15 Feb 2024 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707995335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNzMHxBAyFcxiK8NqE8U/zOdXTEKzWGtfCbELGmErPE=;
	b=rvNwiP/3LB1RrhJNrx1a4oKWumL4uDujW25MnBYW3yw5pRzB7KOhy9bDQ5Ayf80ISEWsnI
	X7hMwthYYBTqUS7wJzxPs7a7yN8wplzGS70pBsf362TKOD0pKbtlhtG0sqk6MPcGkj1OiG
	CrCNf6VuJhUdzwuwu+80ZxJEBVRl6MY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707995335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNzMHxBAyFcxiK8NqE8U/zOdXTEKzWGtfCbELGmErPE=;
	b=RhmoHrCnWucj8m84cXpJLpXnMserY0FjZrDgWpihgW7aP9XEsCxEUsOGTx8GS3TiiCqn5p
	rcJK6koeadnywYDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707995334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNzMHxBAyFcxiK8NqE8U/zOdXTEKzWGtfCbELGmErPE=;
	b=gb53DiWNqlhnu3FyDZHtDS4ITXSpTKBoMa7ZK8IhcSjJw/rIEi68UVlPvle3cq8DW4pzcN
	Vh+203T75hHvcl3Rh86iHA2B0aUoSO2esCADErwd+sOtOnRc0eGn7Rb7AJqN8TYzLqgnYK
	ytK6qwCrla2HYaRxBwcmwLgNkgFIWj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707995334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNzMHxBAyFcxiK8NqE8U/zOdXTEKzWGtfCbELGmErPE=;
	b=ofZsuqi3y+wGTUHGvD4QofQ/HUQfQeNsNfnsYgMzPJeKQCiEwmJNc5sNzI6nnWXWC2OnFx
	2/mge8GBHL9J8aAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22AC213A53;
	Thu, 15 Feb 2024 11:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gNIGCMbwzWV1NAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 11:08:54 +0000
Message-ID: <9fc95f61-827f-40ee-a823-576cdcad7939@suse.cz>
Date: Thu, 15 Feb 2024 12:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] mm,page_owner: Implement the tracking of the
 stacks count
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-5-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214170157.17530-5-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.01
X-Spamd-Result: default: False [-7.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-1.72)[93.30%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/14/24 18:01, Oscar Salvador wrote:
> Implement {inc,dec}_stack_record_count() which increments or
> decrements on respective allocation and free operations, via
> __reset_page_owner() (free operation) and __set_page_owner() (alloc
> operation).
> Newly allocated stack_record structs will be added to the list stack_list
> via add_stack_record_to_list().
> Modifications on the list are protected via a spinlock with irqs
> disabled, since this code can also be reached from IRQ context.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Marco Elver <elver@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Note:

> +static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
> +{
> +	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
> +
> +	if (!stack_record)
> +		return;
> +
> +	/*
> +	 * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
> +	 * with REFCOUNT_SATURATED to catch spurious increments of their
> +	 * refcount.
> +	 * Since we do not use STACK_DEPOT_FLAG_GET API, let us
> +	 * set a refcount of 1 ourselves.
> +	 */
> +	if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
> +		int old = REFCOUNT_SATURATED;
> +
> +		if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1))
> +			/* Add the new stack_record to our list */
> +			add_stack_record_to_list(stack_record, gfp_mask);
			
			Not returning here...

> +	}
> +	refcount_inc(&stack_record->count);

.. means we'll increase the count to 2 on the first store, so there's a
bias. Which would be consistent with the failure and dummy stacks that also
start with a refcount of 1. But then the stack count reporting should
decrement by 1 to prevent confusion? (in the following patch). Imagine
somebody debugging an allocation stack where there are not so many of them,
but the allocation is large, and being sidetracked by an off-by-one error.


