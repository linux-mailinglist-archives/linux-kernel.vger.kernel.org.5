Return-Path: <linux-kernel+bounces-138378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C089F053
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CCD1F21FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B2915958A;
	Wed, 10 Apr 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oI5fT0Ki";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QrQwdHbq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oI5fT0Ki";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QrQwdHbq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC72BAEC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712747050; cv=none; b=i1e5xjx+zfD1xE0l7gnaUIKdFnf7kns6XwbiZ8n0HaK9zDQAnozdNRmYXaOpFPDkbZ3tXjCdxWMvI2qFDYLRxXr8LxVa5sofFFhOXBPgdawaCNr7gc5eVmnZp+ND/ABD8u4TJzyvZ9DV/lG+OUH1n2E4bVnznun/ftBtnMawsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712747050; c=relaxed/simple;
	bh=gAOZJS6zjno/CHx7NPL8N2ymCbZ8t/qkxY2Sv1xHojs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGx/2/ohe/FYjMeJL1uveDEJ5O/KRF5PmbgJ3iwMSScnKep8VN+b79jxL+U0TXBnSqItlBQa4srqUFQFWKXJO4O4O6fTnSWnpl4ynlEXbee9/SzKs8VAXZ/oSm4Cp4nDYsK0hcNNAclLEGE26F7HuzLXJ7PqQUom/uUiYqobpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oI5fT0Ki; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QrQwdHbq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oI5fT0Ki; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QrQwdHbq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A2F734F6E;
	Wed, 10 Apr 2024 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712747046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ytwgH6RibXKi7DC6vXSskvykkl9akErEDm8TP+gpUo=;
	b=oI5fT0Ki45gJFxazVCoW32Ge1oSVQQLLC5NIUYwyXePn0Z7EbJVIGeNr/YTLHEvNwtZ4Wz
	9MxhGQON/QKK3/lJ0fKG07ev+2/Yuzp+DyApsydD+YrwH/eC21fRSUXDL+h+eaZgtwLNJV
	e57KeayftS12dIFE8ugghBGV0A7/At8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712747046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ytwgH6RibXKi7DC6vXSskvykkl9akErEDm8TP+gpUo=;
	b=QrQwdHbqtjIcLKEvdF+BkyRq+toJCAZgheTl5k9D2CRe4XBfh6JaeKBURAgj71VtesHMbH
	BmMDaaIE2rf0PKBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712747046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ytwgH6RibXKi7DC6vXSskvykkl9akErEDm8TP+gpUo=;
	b=oI5fT0Ki45gJFxazVCoW32Ge1oSVQQLLC5NIUYwyXePn0Z7EbJVIGeNr/YTLHEvNwtZ4Wz
	9MxhGQON/QKK3/lJ0fKG07ev+2/Yuzp+DyApsydD+YrwH/eC21fRSUXDL+h+eaZgtwLNJV
	e57KeayftS12dIFE8ugghBGV0A7/At8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712747046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ytwgH6RibXKi7DC6vXSskvykkl9akErEDm8TP+gpUo=;
	b=QrQwdHbqtjIcLKEvdF+BkyRq+toJCAZgheTl5k9D2CRe4XBfh6JaeKBURAgj71VtesHMbH
	BmMDaaIE2rf0PKBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C4491390D;
	Wed, 10 Apr 2024 11:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pqbtGSZyFmY9dQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 10 Apr 2024 11:04:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10920A06D8; Wed, 10 Apr 2024 13:04:06 +0200 (CEST)
Date: Wed, 10 Apr 2024 13:04:06 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvc-project@linuxtesting.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] udf: udftime: prevent overflow in
 udf_disk_stamp_to_time()
Message-ID: <20240410110406.ax4mpguev7jiszyh@quack3>
References: <20240327132755.13945-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327132755.13945-1-r.smirnov@omp.ru>
X-Spam-Flag: NO
X-Spam-Score: -3.71
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-2.91)[99.63%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:email,suse.com:email]

On Wed 27-03-24 16:27:55, Roman Smirnov wrote:
> An overflow can occur in a situation where src.centiseconds
> takes the value of 255. This situation is unlikely, but there
> is no validation check anywere in the code.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/udf/udftime.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
> index 758163af39c2..3113785af3cf 100644
> --- a/fs/udf/udftime.c
> +++ b/fs/udf/udftime.c
> @@ -46,13 +46,18 @@ udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
>  	dest->tv_sec = mktime64(year, src.month, src.day, src.hour, src.minute,
>  			src.second);
>  	dest->tv_sec -= offset * 60;
> -	dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
> -			src.hundredsOfMicroseconds * 100 + src.microseconds);
> +
>  	/*
>  	 * Sanitize nanosecond field since reportedly some filesystems are
>  	 * recorded with bogus sub-second values.
>  	 */
> -	dest->tv_nsec %= NSEC_PER_SEC;
> +	if (src.centiseconds < 100 && src.hundredsOfMicroseconds < 100 &&
> +	    src.microseconds < 100) {
> +		dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
> +			src.hundredsOfMicroseconds * 100 + src.microseconds);
> +	} else {
> +		desk->tv_nsec = 0;
> +	}
>  }
>  
>  void
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

