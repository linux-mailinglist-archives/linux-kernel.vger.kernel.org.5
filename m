Return-Path: <linux-kernel+bounces-63334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4476B852DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CEACB22D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89B22611;
	Tue, 13 Feb 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Iu070Ng";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jY2mDelz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Iu070Ng";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jY2mDelz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A211C687
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819703; cv=none; b=kwJWfpRYFq9w/9fw+31M5BVwy7vfuyhkc0xriTYs4ZTZ1PNjcITM5j8UhUjfZ9+7rnscAPMi4OM11S8YkFR4tAFPUBohBDxmjxFfd2jaVdokKn7tACnQAR0D+x3kjc75qQTgVvWTbsHFL3DSgH+sZxEMDt9D7WSgAnE67f+hGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819703; c=relaxed/simple;
	bh=yrkZFP3WpHNZBu/aZMP122MxWKi0gmDYH7JNg76nhsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4SPTcjVgU9uoKfyfkDQm5lJpNphqkn6XZTnc3RDdY8aULoUt0FIyoyRRtRsvnL8ljjkK22NdPRsMFzmwpX9FCZmZdifBhFCGgPiDsGbnjl9Nn3lvmOU9/gnWzOzqvliR4xAP52KNFYBD1H5+wpHmMk1FzpNUUNnWEFhpL6ns3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Iu070Ng; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jY2mDelz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Iu070Ng; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jY2mDelz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60D9B1FC85;
	Tue, 13 Feb 2024 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707819700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d904vDzjZZGghzwLazg4bY2SmZjBYPoNaByuYf/AuFU=;
	b=3Iu070NgktDu1qFqpaURuLaZz7E+v6RKbIcQGE1lTasnbrBCQAsICiWaloTog5EGbQ5ndA
	F+550BERD5ZKH/e0EinGW0SuekvfskAIrRMYshXNZbmzk+MeOtcGtkoTEdW2lEsAU9CjFP
	eIUG79EZvgijsRQssovfsSkvkI7d1Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707819700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d904vDzjZZGghzwLazg4bY2SmZjBYPoNaByuYf/AuFU=;
	b=jY2mDelz9xhVj0KZ/UbSX0StMIQwUdIry0onQvXSnKV5BsYd4aCIrgnQgl2Yt8HmsByk8Y
	X7RLlbSUoiThRzCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707819700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d904vDzjZZGghzwLazg4bY2SmZjBYPoNaByuYf/AuFU=;
	b=3Iu070NgktDu1qFqpaURuLaZz7E+v6RKbIcQGE1lTasnbrBCQAsICiWaloTog5EGbQ5ndA
	F+550BERD5ZKH/e0EinGW0SuekvfskAIrRMYshXNZbmzk+MeOtcGtkoTEdW2lEsAU9CjFP
	eIUG79EZvgijsRQssovfsSkvkI7d1Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707819700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d904vDzjZZGghzwLazg4bY2SmZjBYPoNaByuYf/AuFU=;
	b=jY2mDelz9xhVj0KZ/UbSX0StMIQwUdIry0onQvXSnKV5BsYd4aCIrgnQgl2Yt8HmsByk8Y
	X7RLlbSUoiThRzCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 53C151329E;
	Tue, 13 Feb 2024 10:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id P6ovFLRCy2VwMAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 10:21:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EF03BA0809; Tue, 13 Feb 2024 11:21:39 +0100 (CET)
Date: Tue, 13 Feb 2024 11:21:39 +0100
From: Jan Kara <jack@suse.cz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: avoid printing an uninitialized blk number
Message-ID: <20240213102139.gnfh5sq24rwu7wnp@quack3>
References: <20240213101733.461544-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213101733.461544-1-arnd@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.28%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.34

On Tue 13-02-24 11:17:28, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The error path of find_tree_dqentry() now prints a variable that is
> never initialized:
> 
> fs/quota/quota_tree.c:674:8: error: variable 'blk' is uninitialized when used here [-Werror,-Wuninitialized]
>                             blk);
>                             ^~~
> include/linux/quotaops.h:34:41: note: expanded from macro 'quota_error'
>         __quota_error((sb), __func__, fmt , ## args)
>                                                ^~~~
> 
> Move the calculation of the block number slightly up to make it
> show a sensible number.
> 
> Fixes: 223bfb57631b ("quota: Detect loops in quota tree")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Arnd, this should be fixed in my tree as of yesterday and I can see that
you've even based your patch on a fixed kernel :)

								Honza

> ---
>  fs/quota/quota_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
> index afceef3ddfaa..05ae39f9b1ac 100644
> --- a/fs/quota/quota_tree.c
> +++ b/fs/quota/quota_tree.c
> @@ -669,13 +669,13 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
>  	if (!buf)
>  		return -ENOMEM;
>  	ret = read_blk(info, blks[depth], buf);
> +	blk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
>  	if (ret < 0) {
>  		quota_error(dquot->dq_sb, "Can't read quota tree block %u",
>  			    blks[depth]);
>  		goto out_buf;
>  	}
>  	ret = 0;
> -	blk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
>  	if (!blk)	/* No reference? */
>  		goto out_buf;
>  	ret = do_check_range(dquot->dq_sb, "block", blk, QT_TREEOFF,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

