Return-Path: <linux-kernel+bounces-148377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627738A81B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D7B285572
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758A13C8E5;
	Wed, 17 Apr 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Em8TZBwG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Swm0bX9A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Em8TZBwG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Swm0bX9A"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE113C68E;
	Wed, 17 Apr 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352205; cv=none; b=AjJKpu31JKE6R4nOXm5UYxUIH/mouzXFW4YRcuzd4Fqw3NxBcBSfIkwDWpcB6SwLGJyXpTuJ3bEsHxJ+psqaZIUHK2G76UqFxtQLa2ziE54tTW0RNCrLmtFhBdJ4AEfK0SnflwRfoptgZXThWi8+xDgmT5Mp7wKbMGoBXlnKMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352205; c=relaxed/simple;
	bh=+/Y1TqpJnFBRwRqnv1AMakhZION2OOFVGxAQI9xnZtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJUd4a3DKwmUNWgAlDRv/D7b5QGSOzO8gZroM50B5ZZhcXBdNpVBQPWHOS1VG+Uet7Iag0uWB5opIZ8FDApbWe1G7A2iv/+h+7LBZ7Dd5d+0dV1Y1Lq7PvrNkCzgVJEn/fp0nWIoQN7yUuJ68PVo415rq5V7WzbW0MoQLEiC6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Em8TZBwG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Swm0bX9A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Em8TZBwG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Swm0bX9A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2A8433B67;
	Wed, 17 Apr 2024 11:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713352201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qaQbAuymIyWXl7clH/m9soo1SrBAkUCeIKbNu703u8=;
	b=Em8TZBwGsY3v2ac1dac2wkMo6/bVVz1QGJnCr/wV9+xkbk4ee7vqW8WAbuVvioDPZVH3IL
	p7+vmfE9vRncjj5l3tHv4FYm/p0gDFLJ9s85BbUGThSE9kRgfEqEEpBgu44qhXuWaotQrJ
	+MfwWf7RXK+KUbtGTUrVJ4OhUIjJMIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713352201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qaQbAuymIyWXl7clH/m9soo1SrBAkUCeIKbNu703u8=;
	b=Swm0bX9AnQEPsCqCQVNr3NmWbcAYZ93kf67JeTeWR+wrnSK1hLH3moDJuw6je9vqkjosHA
	AHX9F4HufK9+egAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713352201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qaQbAuymIyWXl7clH/m9soo1SrBAkUCeIKbNu703u8=;
	b=Em8TZBwGsY3v2ac1dac2wkMo6/bVVz1QGJnCr/wV9+xkbk4ee7vqW8WAbuVvioDPZVH3IL
	p7+vmfE9vRncjj5l3tHv4FYm/p0gDFLJ9s85BbUGThSE9kRgfEqEEpBgu44qhXuWaotQrJ
	+MfwWf7RXK+KUbtGTUrVJ4OhUIjJMIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713352201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qaQbAuymIyWXl7clH/m9soo1SrBAkUCeIKbNu703u8=;
	b=Swm0bX9AnQEPsCqCQVNr3NmWbcAYZ93kf67JeTeWR+wrnSK1hLH3moDJuw6je9vqkjosHA
	AHX9F4HufK9+egAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5C1C1384C;
	Wed, 17 Apr 2024 11:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 45JdLAmuH2bAfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Apr 2024 11:10:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5911AA082E; Wed, 17 Apr 2024 13:10:01 +0200 (CEST)
Date: Wed, 17 Apr 2024 13:10:01 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Zach O'Keefe <zokeefe@google.com>,
	linux-kernel@vger.kernel.org,
	Maxim Patlasov <MPatlasov@parallels.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again
Message-ID: <20240417111001.fa2eg5gp6t2wiwco@quack3>
References: <20240118181954.1415197-1-zokeefe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118181954.1415197-1-zokeefe@google.com>
X-Spam-Level: ****
X-Spamd-Result: default: False [4.30 / 50.00];
	BAYES_SPAM(5.10)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: 4.30
X-Spam-Flag: NO

On Thu 18-01-24 10:19:53, Zach O'Keefe wrote:
> (struct dirty_throttle_control *)->thresh is an unsigned long, but is
> passed as the u32 divisor argument to div_u64().  On architectures where
> unsigned long is 64 bytes, the argument will be implicitly truncated.
> 
> Use div64_u64() instead of div_u64() so that the value used in the "is
> this a safe division" check is the same as the divisor.
> 
> Also, remove redundant cast of the numerator to u64, as that should
> happen implicitly.
> 
> This would be difficult to exploit in memcg domain, given the
> ratio-based arithmetic domain_drity_limits() uses, but is much easier in
> global writeback domain with a BDI_CAP_STRICTLIMIT-backing device, using
> e.g. vm.dirty_bytes=(1<<32)*PAGE_SIZE so that dtc->thresh == (1<<32)
> 
> Fixes: f6789593d5ce ("mm/page-writeback.c: fix divide by zero in bdi_dirty_limits()")
> Cc: Maxim Patlasov <MPatlasov@parallels.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>

I've come across this change today and it is broken in several ways:

> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index cd4e4ae77c40a..02147b61712bc 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1638,7 +1638,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
>  	 */
>  	dtc->wb_thresh = __wb_calc_thresh(dtc);
>  	dtc->wb_bg_thresh = dtc->thresh ?
> -		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
> +		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;

Firstly, the removed (u64) cast from the multiplication will introduce a
multiplication overflow on 32-bit archs if wb_thresh * bg_thresh >= 1<<32
(which is actually common - the default settings with 4GB of RAM will
trigger this). Secondly, the div64_u64() is unnecessarily expensive on
32-bit archs. We have div64_ul() in case we want to be safe & cheap.
Thirdly, if thresholds are larger than 1<<32 pages, then dirty balancing is
going to blow up in many other spectacular ways - consider only the
multiplication on this line - it will not necessarily fit into u64 anymore.
The whole dirty limiting code is interspersed with assumptions that limits
are actually within u32 and we do our calculations in unsigned longs to
avoid worrying about overflows (with occasional typing to u64 to make it
more interesting because people expected those entities to overflow 32 bits
even on 32-bit archs). Which is lame I agree but so far people don't seem
to be setting limits to 16TB or more. And I'm not really worried about
security here since this is global-root-only tunable and that has much
better ways to DoS the system.

So overall I'm all for cleaning up this code but in a sensible way please.
E.g. for these overflow issues at least do it one function at a time so
that we can sensibly review it.

Andrew, can you please revert this patch until we have a better fix? So far
it does more harm than good... Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

