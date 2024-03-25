Return-Path: <linux-kernel+bounces-117773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B70388B5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37E5B26EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A671094E;
	Mon, 25 Mar 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DJ1e771R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZvRYvOM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="se1IqUQd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQTu0/aC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AFDF55
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393791; cv=none; b=Y1xzg4wVm1BTxl9YTXbaSoqLFXfhCDyA81KYfEOLh4/90woaKMMGr1QU+/lxDeDdBPxAgXQ7+vce9dzt620ZKtnyUbWGuPcoZDMYXLxmFnEZQFjFhGLESwRg8iyeYbo7yCEHd5rOFqv/VFD97+dFx52hSIl87QHoVl2rW/gohgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393791; c=relaxed/simple;
	bh=+iF7RhZ2/9Fke2dtW7mTj5eRdoVxC9oifdiPwnIz0R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9yCiPeuyvJcNpE+O14sPtRDDfXOpFadfcyxMzo9DDej07v8UoqgEu5QtJ5WHB6Mm7PkkMh175s9JQHf9uNTnVfwnjDY/a6+wIYX+LNkRhwDggTjTWJZDDC+sm5JAij7zFoKlz/rjoasD6PFbX12t8Kpz8esImEUDXCsldqTv48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DJ1e771R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZvRYvOM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=se1IqUQd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQTu0/aC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE7225CAAB;
	Mon, 25 Mar 2024 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711393787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sudVb9mARoSqseIaPEhFIL6LrZXJUwIdE56RRwfcQ0M=;
	b=DJ1e771R0YX/qyQzd4uRLvjJzI+31qZr836lD2OwHiXzI9IkZDd1l6xD4i6JQ6CMrV67HG
	p9sMADvSXyRPtiCRdrXKls8P225k4ywEUiNnXfdcOeH5GNEG+/VewJOqa3YM2XUhckV45K
	YrIhomwO5loGa6beQ/4tKAJ/GSYuxpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711393787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sudVb9mARoSqseIaPEhFIL6LrZXJUwIdE56RRwfcQ0M=;
	b=JZvRYvOMgk+zrDBifX8E0Sek+qz0ryRWbeb6sa9uVo2ezQuMsFSqrkIcmwRHEIdRPOc0FI
	ISZB4XtfjX7orwBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711393786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sudVb9mARoSqseIaPEhFIL6LrZXJUwIdE56RRwfcQ0M=;
	b=se1IqUQdnwccpQTFK/9T4baldLLtairVp8Ff3erE/2ztNwSm6T8eBKxkOs9+c8snG3MS7T
	kkxpauficZIr9nohzIse4QPsNl9azjucSaLAbpPWHTmzGqyf5qSVBsqJW7T8FCOHZeaOxz
	VZ0ltcG+b+pVKTKmiyslKKIzFiuYu68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711393786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sudVb9mARoSqseIaPEhFIL6LrZXJUwIdE56RRwfcQ0M=;
	b=IQTu0/aCWZrhgEzvc5rfTDuzpGibs7DjoD5A3VZgqnKO1dIJIiUIj3JR5zkMNnjTc6HJmJ
	PCRqwHTESGkbzmBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A064513A2E;
	Mon, 25 Mar 2024 19:09:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4czbJvrLAWYXZgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 25 Mar 2024 19:09:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A830A0812; Mon, 25 Mar 2024 20:09:42 +0100 (CET)
Date: Mon, 25 Mar 2024 20:09:42 +0100
From: Jan Kara <jack@suse.cz>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Jan Kara <jack@suse.com>, Dennis Zhou <dennis@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: quota: use group allocation of per-cpu counters API
Message-ID: <20240325190942.6a5eoktohdabtmmn@quack3>
References: <20240325041240.53537-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325041240.53537-1-wangkefeng.wang@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.01%]
X-Spam-Flag: NO

On Mon 25-03-24 12:12:40, Kefeng Wang wrote:
> Use group allocation of per-cpu counters api to accelerate
> dquot_init() and simplify code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Looks good. I've merged the patch to my tree. Thanks!

								Honza

> ---
>  fs/quota/dquot.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index dacbee455c03..808544f74e5e 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -3016,11 +3016,10 @@ static int __init dquot_init(void)
>  	if (!dquot_hash)
>  		panic("Cannot create dquot hash table");
>  
> -	for (i = 0; i < _DQST_DQSTAT_LAST; i++) {
> -		ret = percpu_counter_init(&dqstats.counter[i], 0, GFP_KERNEL);
> -		if (ret)
> -			panic("Cannot create dquot stat counters");
> -	}
> +	ret = percpu_counter_init_many(dqstats.counter, 0, GFP_KERNEL,
> +				       _DQST_DQSTAT_LAST);
> +	if (ret)
> +		panic("Cannot create dquot stat counters");
>  
>  	/* Find power-of-two hlist_heads which can fit into allocation */
>  	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

