Return-Path: <linux-kernel+bounces-111567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D6B886DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C14A1C2095B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E445BFC;
	Fri, 22 Mar 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vr6aV579";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bB6Ml0sq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vr6aV579";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bB6Ml0sq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234B2770C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115339; cv=none; b=mNRo8HbR/qxUPC+B+5Tqtix6Kq3jiJteAS1YgDjauQS2ROo6P9hMb0KM+ZUyHuLNWmNFD+yVLXGPaJfBogn4I+ET4Z/5AQSO/+xp6tUqRo3K5LY/s3FbygpAdayMkCw+REKJtz6l8jmdncgfpInHjIxTbZV/LPzRI0TaT4tqxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115339; c=relaxed/simple;
	bh=KmWbmP2TvwHLwYxWeKmKtpn0ICKMK2xz5SBZE2FSF2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eW639bTBO/tzDXp9dtXWJhxbfZLZxKx0Q7YAzsCZhKik8VJWMAMk/G2hMF/TjMO2s6tieeXOAsJwdoO6NAmfawN3KRpWmA7mTkcGCWWvDt+bE5hUz+4fKM0H3zV0OmBJuvl+BD6hGXL6eT+0DdrX6ZfGeSraw1PZr0QCHgu+V+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vr6aV579; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bB6Ml0sq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vr6aV579; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bB6Ml0sq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0B8A33CC7;
	Fri, 22 Mar 2024 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711115335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjWNqh0BkyOCCMNPmezPMFuAxfGBQAC8pqGatNt+amw=;
	b=Vr6aV579OgabDCFlYUVYuEFCT3+NiCAA6M/D5t23xfbidStNQRkHKy9QNcG0nSrXP86nUD
	+atkpKNOJjWvjhQ875+kTQ/d6pU/h+x/z3q2P9l8R2wNU01a5hmrraK+sVzvVczHd3puLQ
	f90wbgT2ewo97/YDZZiqVkyHFaver/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711115335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjWNqh0BkyOCCMNPmezPMFuAxfGBQAC8pqGatNt+amw=;
	b=bB6Ml0sqzHP/YMSDJlJ1/S+iixI8lLcOGwPNwCwrv7F4nrWKHPf/Af3Qss0Xu+XWOzyGhp
	5N5JeqdK7dO+5GDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711115335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjWNqh0BkyOCCMNPmezPMFuAxfGBQAC8pqGatNt+amw=;
	b=Vr6aV579OgabDCFlYUVYuEFCT3+NiCAA6M/D5t23xfbidStNQRkHKy9QNcG0nSrXP86nUD
	+atkpKNOJjWvjhQ875+kTQ/d6pU/h+x/z3q2P9l8R2wNU01a5hmrraK+sVzvVczHd3puLQ
	f90wbgT2ewo97/YDZZiqVkyHFaver/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711115335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjWNqh0BkyOCCMNPmezPMFuAxfGBQAC8pqGatNt+amw=;
	b=bB6Ml0sqzHP/YMSDJlJ1/S+iixI8lLcOGwPNwCwrv7F4nrWKHPf/Af3Qss0Xu+XWOzyGhp
	5N5JeqdK7dO+5GDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95D2F136AD;
	Fri, 22 Mar 2024 13:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qSuOJEeM/WX+IwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Mar 2024 13:48:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B884A0806; Fri, 22 Mar 2024 14:48:55 +0100 (CET)
Date: Fri, 22 Mar 2024 14:48:55 +0100
From: Jan Kara <jack@suse.cz>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH] udf: udftime: prevent overflow in
 udf_disk_stamp_to_time()
Message-ID: <20240322134855.qm2pzjvvagufgrbk@quack3>
References: <20240322090145.11175-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322090145.11175-1-r.smirnov@omp.ru>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Vr6aV579;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bB6Ml0sq
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.05 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.04)[58.21%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.05
X-Rspamd-Queue-Id: A0B8A33CC7
X-Spam-Flag: NO

On Fri 22-03-24 12:01:45, Roman Smirnov wrote:
> An overflow can occur in a situation where src.centiseconds
> takes the value of 255. This situation is unlikely, but there
> is no validation check anywere in the code. It is necessary
> to convert the type of expression to 64-bit.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Thanks for the fix but I think this is not the right way to solve the
problem. Mainly because the 64-bit division is unnecessarily costly. I'd
rather first make sure that src.centiseconds < 100,
src.hundredsOfMicroseconds < 100, src.microseconds < 100 (just ignore the
values if any is bogus) and then do the multiplication without worrying it
might overflow the int type...

								Honza

> @@ -46,13 +47,13 @@ udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
>  	dest->tv_sec = mktime64(year, src.month, src.day, src.hour, src.minute,
>  			src.second);
>  	dest->tv_sec -= offset * 60;
> -	dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
> +	nsec = 1000LL * (src.centiseconds * 10000 +
>  			src.hundredsOfMicroseconds * 100 + src.microseconds);
>  	/*
>  	 * Sanitize nanosecond field since reportedly some filesystems are
>  	 * recorded with bogus sub-second values.
>  	 */
> -	dest->tv_nsec %= NSEC_PER_SEC;
> +	dest->tv_nsec = do_div(nsec, NSEC_PER_SEC);
>  }
>  
>  void
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

