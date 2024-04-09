Return-Path: <linux-kernel+bounces-136267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E974789D220
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE4F1F22AFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C16F53D;
	Tue,  9 Apr 2024 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yeK5ttk0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+fwt4ZT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yeK5ttk0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+fwt4ZT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC14C69;
	Tue,  9 Apr 2024 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643001; cv=none; b=fx0G8RqHy5IUfNN7HtHqZcEKNF5x1nY/mo+1VJYJqMh6ucPXeiARZlPggNJ3+Eya0lYxvdpwEo9ISyKSAbu90zXDL+rXDRAzcQcqr38STnesy3UdnuEXK6w73aPDXVzcG1+FAa3r2XD7mj+UTIsj1ayY0e7uWPHkvhjbzj4nZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643001; c=relaxed/simple;
	bh=Fco9MlyEHsy7mhFviXbafrMc879Fz3eOcdblRV4eUbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQx0NjgpdNTNe9IPJNzmDmDGkjohVIYGgA4L0koNOdbyATXJcBjLzKtRuVTSMfmW7eGBC8lCZ//wMCyAKFVwebC81qb5ZA44mb+DFcNyWCB/iOPG2TTmeN0b3sx40TZW/6iyqCTlBC/hfAAGVGc9T8zJsFAy/2xXUpUj56RkeeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yeK5ttk0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+fwt4ZT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yeK5ttk0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+fwt4ZT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 155353382A;
	Tue,  9 Apr 2024 06:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712642998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSCcPjYf9Lk4xq7iPI/rjdmipMmPujy9hX6WDaQQGh4=;
	b=yeK5ttk0JoBlkCZtpZJWXkddSspxkBC326yN+bBMObzYUoMZWKrM+KrKEG+rNi5kRhlcSH
	XA+S14fUpvxxcPIbq/mp8LVxP8KfbTwdYT3d18xYFk7c7XIhC4ZD5jyxlNvK1O3ffytqkq
	SpPy0x7wqccgdQprE3NqtOdpbMmTw/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712642998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSCcPjYf9Lk4xq7iPI/rjdmipMmPujy9hX6WDaQQGh4=;
	b=D+fwt4ZTMAh9jvd67LKVhj9vA8GKG1hXKAKzWB3VsKGaME3w45lNoi5yqS0XBTaZYofYMb
	pRoxqa/VsAJRxfBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712642998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSCcPjYf9Lk4xq7iPI/rjdmipMmPujy9hX6WDaQQGh4=;
	b=yeK5ttk0JoBlkCZtpZJWXkddSspxkBC326yN+bBMObzYUoMZWKrM+KrKEG+rNi5kRhlcSH
	XA+S14fUpvxxcPIbq/mp8LVxP8KfbTwdYT3d18xYFk7c7XIhC4ZD5jyxlNvK1O3ffytqkq
	SpPy0x7wqccgdQprE3NqtOdpbMmTw/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712642998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSCcPjYf9Lk4xq7iPI/rjdmipMmPujy9hX6WDaQQGh4=;
	b=D+fwt4ZTMAh9jvd67LKVhj9vA8GKG1hXKAKzWB3VsKGaME3w45lNoi5yqS0XBTaZYofYMb
	pRoxqa/VsAJRxfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8AD513313;
	Tue,  9 Apr 2024 06:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rJfbLrXbFGamKQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Apr 2024 06:09:57 +0000
Message-ID: <6ef177d7-a565-4ddb-8522-81ffbfb5380e@suse.de>
Date: Tue, 9 Apr 2024 08:09:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: API break, sysfs "capability" file
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.52 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.23)[72.47%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.52
X-Spam-Flag: NO

On 4/9/24 00:41, Keith Busch wrote:
> On Mon, Apr 08, 2024 at 10:23:49PM +0200, Lennart Poettering wrote:
>> Not sure how this is salvageable. This is just seriously fucked
>> up. What now?
>>
>> It has been proposed to use the "range_ext" sysfs attr instead as a
>> hint if partition scanning is available or not. But it's entirely
>> undocumented. Is this something that will remain stable? (I mean,
>> whether something is documented or not apparently has no effect on the
>> stability of an API anyway, so I guess it's equally shaky as the
>> capability sysattr? Is any of the block device sysfs interfaces
>> actually stable or can they change any time?)
> 
> The "ext_range" attribute does look like an appropriate proxy for the
> attribute, but indeed, it's not well documented.
> 
> Looking at the history of the documentation you had been relying on, it
> appears that was submitted with good intentions (9243c6f3e012a92d), but
> it itself changed values, acknowledging the instability of this
> interface.
> 
> So what to do? If documentation is all that's preventing "ext_range"
> from replacing you're previous usage, then let's add it in the
> Documentation/ABI/stable/sysfs-block. It's been there since 2008, so
> that seems like a reliable attribute to put there.
> 
I'll side with Keith. Our management tools use 'ext_range' to find
if a device is partitionable, and we've done that since the very
beginning of sysfs.

Cheers,

Hannes


