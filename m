Return-Path: <linux-kernel+bounces-66719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C7185609D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D841C23BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5BF130AD4;
	Thu, 15 Feb 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Med1oLNB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Q6pc7gW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Med1oLNB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Q6pc7gW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67F1EF1D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994524; cv=none; b=Ww9oq2caOQIoHCfkk70C1Tjg8iArMFRKRWp2BNUIZCffZmbTFWA7CLxog6OXY9DSXTS0qYiPxArVqu+HmDIdoFY+vC02xZoHpoCcuRaDjNrsxXtufY38IiHwkXacicNkDDbrPP+wKH6NcVSa6bN0ZG5gib0B+tBfMtylRyzgi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994524; c=relaxed/simple;
	bh=yXKEXe+jJogGmhKlWXxl4a3x7CycnAlkIpxDarAvsrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EK2HqhJiX6VC8/v+98Q5xeSubF3TzQBbtnHc4ZSK4aW+Ie8bHcsadzIP5XDojfULNttMU7HgtGJQgjb292fEPYMbDWrnSyGDhBtyyXcOUWWyBR6wf/MqbWiCTpOys1I011zUb7U6ns9DJBXiKzrau7812mqlbpG0O0Pbv5qia1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Med1oLNB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Q6pc7gW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Med1oLNB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Q6pc7gW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7620121EAD;
	Thu, 15 Feb 2024 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707994520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGovcSwKtSq7xWvCafXr0+DJqD0DGxnDBwIFF2je9d8=;
	b=Med1oLNBn8ZxJaQi8g8abR9bH07zjIDiqfHz5vVXZO+L7FZdhzXlUP8oSLf9mf9Nyq23gY
	KEZEEzbm66IGnQ5dlpl3PAo+dqQauhiczaI8OckRQZdXBTf4nMuaPnxlOfBMs5Sfs8zclj
	tiwZc2dN5rtc0Smzl9i9Mht9OS7ODGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707994520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGovcSwKtSq7xWvCafXr0+DJqD0DGxnDBwIFF2je9d8=;
	b=1Q6pc7gWYUiEcvWs+VGr5UkOJAPDG3idD38iOFbVW6Tx09REjnsWsYt6zh/xmFY49gJlsb
	EuzM+ZdnXD1mAVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707994520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGovcSwKtSq7xWvCafXr0+DJqD0DGxnDBwIFF2je9d8=;
	b=Med1oLNBn8ZxJaQi8g8abR9bH07zjIDiqfHz5vVXZO+L7FZdhzXlUP8oSLf9mf9Nyq23gY
	KEZEEzbm66IGnQ5dlpl3PAo+dqQauhiczaI8OckRQZdXBTf4nMuaPnxlOfBMs5Sfs8zclj
	tiwZc2dN5rtc0Smzl9i9Mht9OS7ODGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707994520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGovcSwKtSq7xWvCafXr0+DJqD0DGxnDBwIFF2je9d8=;
	b=1Q6pc7gWYUiEcvWs+VGr5UkOJAPDG3idD38iOFbVW6Tx09REjnsWsYt6zh/xmFY49gJlsb
	EuzM+ZdnXD1mAVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6162813A53;
	Thu, 15 Feb 2024 10:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1/hrF5jtzWXAMAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 10:55:20 +0000
Message-ID: <08a08ea2-6764-48af-8883-84639c732ce5@suse.cz>
Date: Thu, 15 Feb 2024 11:55:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] mm,page_owner: Maintain own list of stack_records
 structs
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-4-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214170157.17530-4-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.46
X-Spamd-Result: default: False [-1.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.17)[69.92%];
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
> page_owner needs to increment a stack_record refcount when a new allocation
> occurs, and decrement it on a free operation.
> In order to do that, we need to have a way to get a stack_record from a
> handle.
> Implement __stack_depot_get_stack_record() which just does that, and make
> it public so page_owner can use it.
> 
> Also, traversing all stackdepot buckets comes with its own complexity,
> plus we would have to implement a way to mark only those stack_records
> that were originated from page_owner, as those are the ones we are
> interested in.
> For that reason, page_owner maintains its own list of stack_records,
> because traversing that list is faster than traversing all buckets
> while keeping at the same time a low complexity.
> 
> For now, add to stack_list only the stack_records of dummy_handle and
> failure_handle, and set their refcount of 1.
> 
> Further patches will add code to increment or decrement stack_records
> count on allocation and free operation.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


