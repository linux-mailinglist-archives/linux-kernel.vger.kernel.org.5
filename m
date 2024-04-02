Return-Path: <linux-kernel+bounces-128038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7362E895545
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC47EB24FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D383CAE;
	Tue,  2 Apr 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wpYbP2fo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vx2/6CT+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB579B8A;
	Tue,  2 Apr 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064268; cv=none; b=HbA/EtkMSeo/mLhYxS/9Mcsxc9Ed7DyW5KOtgecJL0bSJBrqDp3R/xEizkCNkIM+IbJdN0nnsSp5oOp2fIOw/iUDwQcHVIxKui+w+5bsg5HRMNM2AaGjHAfqf7Db/KvJ3ue+hc1OyvyN+q6JG0tSqqH5v8tsjBAn2h+eeEJwEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064268; c=relaxed/simple;
	bh=UO4Yb9K+WHem662Te0gbQHrrV/ItyTh5+Qd8mo2HYyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHgt0el1bL3b+qNJfDErG2F6C83z0wKEESlwflFmGD729vNfg9OYDVH2g+dO74/yxL6bP8NN8UhRa8qrZMivj6E2xV7ay5g6/sJkCpT3mXEYEK8OulBvQj8TYp7xPIVA7FsxevhU2eRpf0apM3stg9Sp7c+Gf/kDfXdccpLHMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wpYbP2fo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vx2/6CT+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9F3F5BD95;
	Tue,  2 Apr 2024 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712064264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqQrv6p2RHX9SoLgiAL2BNS+D1Lo/BrgmUFz9f4akNI=;
	b=wpYbP2fojUCriw+8NYvT1Ok486w3JXJLfmIuvgdV0C11fqZrt8yvykw3Wo+98C12XOe1bP
	wYVbqd0yPaqz8d6sFf0VGaMHxJxyH0cmEse8V2PJzTxb81EFTOBNDD5CUktCAfgFgnjtKy
	J5IOnzVT3oLZQHVSxWNvW3e0PXdUISQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712064264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqQrv6p2RHX9SoLgiAL2BNS+D1Lo/BrgmUFz9f4akNI=;
	b=vx2/6CT+3ciz4j9z6pm3HjxW1JUtQL3bUpYiNw1Vn8qkoQtjxByU2uOw/v7gnpHDvccmhu
	KNks6au704AgIdBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B5A5813357;
	Tue,  2 Apr 2024 13:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CFZWLAgHDGaUUwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 02 Apr 2024 13:24:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3663DA0813; Tue,  2 Apr 2024 15:24:20 +0200 (CEST)
Date: Tue, 2 Apr 2024 15:24:20 +0200
From: Jan Kara <jack@suse.cz>
To: Justin Stitt <justinstitt@google.com>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] udf: replace deprecated strncpy/strcpy with strscpy
Message-ID: <20240402132420.aalwgi6gdnmrj3ep@quack3>
References: <20240401-strncpy-fs-udf-super-c-v1-1-80cddab7a281@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-udf-super-c-v1-1-80cddab7a281@google.com>
X-Spam-Score: -1.61
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.61 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[99.99%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: C9F3F5BD95

On Mon 01-04-24 20:01:51, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces. Also replace an instance of strcpy() which is also
> deprecated.
> 
> s_volume_ident is a NUL-terminated string which is evident from its
> usage in udf_debug:
> |	udf_debug("volIdent[] = '%s'\n", UDF_SB(sb)->s_volume_ident);
> 
> s_volume_ident should also be NUL-padded as it is copied out to
> userspace:
> |	if (copy_to_user((char __user *)arg,
> |				UDF_SB(inode->i_sb)->s_volume_ident, 32))
> |		return -EFAULT;
> 
> Considering the above, a suitable replacement is `strscpy_pad` [2] due
> to the fact that it guarantees both NUL-termination and NUL-padding on
> the destination buffer.
> 
> To simplify the code, let's use the new 2-argument version of
> strscpy_pad() introduced in Commit e6584c3964f2f ("string: Allow
> 2-argument strscpy()"). Also zero-allocate @outstr so we can safely use
> a non-@ret length argument. This is just in case udf_dstrCS0toChar()
> doesn't include the NUL-byte in its return length, we won't truncate
> @outstr or write garbage bytes either.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks! Added to my tree.

								Honza

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/udf/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 2217f7ed7a49..77d32fe14434 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -895,7 +895,7 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
>  	int ret;
>  	struct timestamp *ts;
>  
> -	outstr = kmalloc(128, GFP_KERNEL);
> +	outstr = kzalloc(128, GFP_KERNEL);
>  	if (!outstr)
>  		return -ENOMEM;
>  
> @@ -921,11 +921,11 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
>  
>  	ret = udf_dstrCS0toChar(sb, outstr, 31, pvoldesc->volIdent, 32);
>  	if (ret < 0) {
> -		strcpy(UDF_SB(sb)->s_volume_ident, "InvalidName");
> +		strscpy_pad(UDF_SB(sb)->s_volume_ident, "InvalidName");
>  		pr_warn("incorrect volume identification, setting to "
>  			"'InvalidName'\n");
>  	} else {
> -		strncpy(UDF_SB(sb)->s_volume_ident, outstr, ret);
> +		strscpy_pad(UDF_SB(sb)->s_volume_ident, outstr);
>  	}
>  	udf_debug("volIdent[] = '%s'\n", UDF_SB(sb)->s_volume_ident);
>  
> 
> ---
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> change-id: 20240401-strncpy-fs-udf-super-c-983457eb4ac3
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

