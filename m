Return-Path: <linux-kernel+bounces-92504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D5872152
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AA91C21AAB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810186640;
	Tue,  5 Mar 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vSjH3vx/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5fpi1JNZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vSjH3vx/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5fpi1JNZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FF85C62
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648208; cv=none; b=Q95cbnD9EJygq5qhETkZV42w8V6BdrveeAV+pmThBq6FQq1ibIwXsM7mB/1VNQE38M5GAf7GG+B3JBbcPFPmnVLtgEkqHyUw77NBSU0c1wNWLNf9TOLPtASadl1uHXl3PDnLXdRdenqP2OwWxrZXKnTNtXOknGY4vh2q4hdMR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648208; c=relaxed/simple;
	bh=+881SusyKlKQ22cE14d+MD569E0jZ5HPeOdy0f2+i7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLQL5q7WL6C5gD9tuZ2AFJGvOLPilY1It39YnE9h9tWTINkLIGIjiUZmx9UYH7S3mvUKZnGuIeYsvEG5aI87lK7+XFOb8/0ZmBLeJ4Cqjp4xWraJ34mjXdHyBvzgik1ZhXKWb5iLRf+UIe9UnPEHDgjJFS1hnYe8FJCi4CxYlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vSjH3vx/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5fpi1JNZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vSjH3vx/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5fpi1JNZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A089C6B38F;
	Tue,  5 Mar 2024 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709648204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AORBpGBhz3QcwNeYCMl9/FJUG/47S7+S3dFm+6RMBM8=;
	b=vSjH3vx/jK74fihbENd9Y0y820lf5QEwXTEya0cmvDWu41Y58Qhlik9/0yk2splpxdDCPl
	Qv3Zw4/mcrih65GIgYCbrvcbY+/edMLpgh9HyWeQEm1sxlb9OiPRqmjYuUf6e33m4vrHbo
	/59vOm7Ah5c85h3Xai5w9Wn1AxWbLRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709648204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AORBpGBhz3QcwNeYCMl9/FJUG/47S7+S3dFm+6RMBM8=;
	b=5fpi1JNZe5SOYMsvK4dsqjwBpAlt5dAdzxUQHf/5wFyI9IsuPsZyVlAglCI1748HctRupb
	rDU81MvPZ3I2ONBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709648204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AORBpGBhz3QcwNeYCMl9/FJUG/47S7+S3dFm+6RMBM8=;
	b=vSjH3vx/jK74fihbENd9Y0y820lf5QEwXTEya0cmvDWu41Y58Qhlik9/0yk2splpxdDCPl
	Qv3Zw4/mcrih65GIgYCbrvcbY+/edMLpgh9HyWeQEm1sxlb9OiPRqmjYuUf6e33m4vrHbo
	/59vOm7Ah5c85h3Xai5w9Wn1AxWbLRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709648204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AORBpGBhz3QcwNeYCMl9/FJUG/47S7+S3dFm+6RMBM8=;
	b=5fpi1JNZe5SOYMsvK4dsqjwBpAlt5dAdzxUQHf/5wFyI9IsuPsZyVlAglCI1748HctRupb
	rDU81MvPZ3I2ONBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 958D213A5D;
	Tue,  5 Mar 2024 14:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KwN+JEwp52W2RAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 05 Mar 2024 14:16:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4DE4EA0650; Tue,  5 Mar 2024 15:16:40 +0100 (CET)
Date: Tue, 5 Mar 2024 15:16:40 +0100
From: Jan Kara <jack@suse.cz>
To: chengming.zhou@linux.dev
Cc: jack@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] udf: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240305141640.bf3eytp4m6xpyxv2@quack3>
References: <20240224135229.830356-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224135229.830356-1-chengming.zhou@linux.dev>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="vSjH3vx/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5fpi1JNZ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.54 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.53)[97.87%]
X-Spam-Score: -3.54
X-Rspamd-Queue-Id: A089C6B38F
X-Spam-Flag: NO

On Sat 24-02-24 13:52:29, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/udf/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index adb39e08b2f2..2217f7ed7a49 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -188,7 +188,6 @@ static int __init init_inodecache(void)
>  	udf_inode_cachep = kmem_cache_create("udf_inode_cache",
>  					     sizeof(struct udf_inode_info),
>  					     0, (SLAB_RECLAIM_ACCOUNT |
> -						 SLAB_MEM_SPREAD |
>  						 SLAB_ACCOUNT),
>  					     init_once);
>  	if (!udf_inode_cachep)
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

