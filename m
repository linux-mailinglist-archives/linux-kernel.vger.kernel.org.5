Return-Path: <linux-kernel+bounces-35761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDD839622
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC807B26673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439C811E2;
	Tue, 23 Jan 2024 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cG7Bw6pa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="REhpOrrQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cG7Bw6pa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="REhpOrrQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3C80044;
	Tue, 23 Jan 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030081; cv=none; b=aX6GUHuaJUnkjdNFch5xugUPRm0NNBBARuAGEGzW3aGEaqe2MWTxpDOxxbunaXJScURMdaww75P+vD5Hzc9upVGmXnWvmwDClaHyM72LPZNeqf05sCtDWrP+x7Mt68IMV4JEuZxv+hMd/Ap13HcDTUeAIkXzLjAMRYubO6Nklfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030081; c=relaxed/simple;
	bh=WX+Uh1lswzVda9hS0C5Y3z/FKafSC0KdivThygTtkJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhNRXxpYvBY71/VNBnLmhDyAUb0ej8zIu15vb25FVyFdE9NSrUAc93mlQIe683/nwATQHAJvZ0qtE6bP2CCG5GTMSO1PMhlPBjum8IXU8HW+cpVSAzwFS02BMTdiUVJZV8lICvplcIerzbwY7lcx+acnVXr7nGETiNs5bHwbDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cG7Bw6pa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=REhpOrrQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cG7Bw6pa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=REhpOrrQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B058B1F796;
	Tue, 23 Jan 2024 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706030077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2RgmZOtSuZt9fbN67EhcMUCwy5FaHBbmcGPterXlLI=;
	b=cG7Bw6paa8i61ILwnEheFXsdCJSJm0xAo9ybbr1hs3ID6p2h6I7wiQaPnbtIClJ26lAuMa
	HF06b5YdIXxVltoK2kNUMu7ElMEhMNbR+3NAAd8B5MKv9YlIXHHKO73TRleH/NdHo0Xh9n
	m8Neo2GbDTlaB42FG9i1J+phFyB8EgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706030077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2RgmZOtSuZt9fbN67EhcMUCwy5FaHBbmcGPterXlLI=;
	b=REhpOrrQ3wFD8ewnH8VSOfg3d6C4OBvcJ6o7YBbncSOtCAra32N8y/kA6/k3Awf0XrX0br
	dFHYT35fGUQV2dCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706030077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2RgmZOtSuZt9fbN67EhcMUCwy5FaHBbmcGPterXlLI=;
	b=cG7Bw6paa8i61ILwnEheFXsdCJSJm0xAo9ybbr1hs3ID6p2h6I7wiQaPnbtIClJ26lAuMa
	HF06b5YdIXxVltoK2kNUMu7ElMEhMNbR+3NAAd8B5MKv9YlIXHHKO73TRleH/NdHo0Xh9n
	m8Neo2GbDTlaB42FG9i1J+phFyB8EgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706030077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2RgmZOtSuZt9fbN67EhcMUCwy5FaHBbmcGPterXlLI=;
	b=REhpOrrQ3wFD8ewnH8VSOfg3d6C4OBvcJ6o7YBbncSOtCAra32N8y/kA6/k3Awf0XrX0br
	dFHYT35fGUQV2dCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 938E613786;
	Tue, 23 Jan 2024 17:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+/9I/3zr2XyGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 17:14:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08F3FA0803; Tue, 23 Jan 2024 18:14:37 +0100 (CET)
Date: Tue, 23 Jan 2024 18:14:36 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Jan Kara <jack@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 76/82] udf: Refactor intentional wrap-around test
Message-ID: <20240123171436.voqt74ekz3nhnlk5@quack3>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-76-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-76-keescook@chromium.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cG7Bw6pa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=REhpOrrQ
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B058B1F796
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Mon 22-01-24 16:27:51, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Jan Kara <jack@suse.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/balloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index ab3ffc355949..5c88300c3de7 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -139,7 +139,7 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
>  
>  	mutex_lock(&sbi->s_alloc_mutex);
>  	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
> -	if (bloc->logicalBlockNum + count < count ||
> +	if (add_would_overflow(count, bloc->logicalBlockNum) ||
>  	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
>  		udf_debug("%u < %d || %u + %u > %u\n",
>  			  bloc->logicalBlockNum, 0,
> @@ -390,7 +390,7 @@ static void udf_table_free_blocks(struct super_block *sb,
>  
>  	mutex_lock(&sbi->s_alloc_mutex);
>  	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
> -	if (bloc->logicalBlockNum + count < count ||
> +	if (add_would_overflow(count, bloc->logicalBlockNum) ||
>  	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
>  		udf_debug("%u < %d || %u + %u > %u\n",
>  			  bloc->logicalBlockNum, 0,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

