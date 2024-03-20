Return-Path: <linux-kernel+bounces-108791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76571881001
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFB9B24FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21452D78A;
	Wed, 20 Mar 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3MjtqRG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E+TEKYlL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3MjtqRG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E+TEKYlL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3525740
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930969; cv=none; b=Z/qsEbPrUAKzb7lsPYeip/Vs7kNgl1iE7gXo4zJNJWHmaxdxQmnRbaTrTmSA3EuAg6HmZ2sWiDQbg+Ebqg2F42chA7emd/ND5JphYOzsFDUHLWFxqW5feF2E3cMrq4VJcEOQM3peGxNq9dWs9vuL1UVWx4H8ggn5myyNPrDZxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930969; c=relaxed/simple;
	bh=ny0HBFPV+ZJ5AHgVVMJJTquhsUdlKtJ5BSUIVnIQgMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+CZt8x6jvb1fPwSVISeqqmHYIm5hDYZ7cqXn4LqyH/iN/t5d88uNIifA6T+AaVm/8X9Yt0ohxAECZv3CoCeRvp/A96/ah/54Vl9XQ2yNnKnm+xY336aO20FAnmAu1FoJKBKsYz+JMGDtwRiDWUHNKEcP8fpUj9/XkuiLU57FUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3MjtqRG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E+TEKYlL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3MjtqRG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E+TEKYlL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 815CE341F0;
	Wed, 20 Mar 2024 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710930963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z2ILPVgNiO8LB9zQ5hh2M+8G/r9fgx618Pwk8og4Tc=;
	b=p3MjtqRGuU+fhjB/D8AVPZRKVpH97A5I0TqWfOlNg5KWGH+5zC2fRqxLPjBovXu/37sKeD
	qbOhDO7GwJdOZcQ6dRPpEca5OFi+NOfiehDoSYEfuF/vq9nz5GiCHNuDl/ioCD6aB5X/8m
	CU5+iuCjinxB4acylUIQ6/aM8Risskw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710930963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z2ILPVgNiO8LB9zQ5hh2M+8G/r9fgx618Pwk8og4Tc=;
	b=E+TEKYlLUHXZiorSNAkGMbJwhOEDCoVdygmllffcoU8ukcA8dsZ+cQIMWp2UXbeNI3PuCW
	mBVB914H+/Vbp0AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710930963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z2ILPVgNiO8LB9zQ5hh2M+8G/r9fgx618Pwk8og4Tc=;
	b=p3MjtqRGuU+fhjB/D8AVPZRKVpH97A5I0TqWfOlNg5KWGH+5zC2fRqxLPjBovXu/37sKeD
	qbOhDO7GwJdOZcQ6dRPpEca5OFi+NOfiehDoSYEfuF/vq9nz5GiCHNuDl/ioCD6aB5X/8m
	CU5+iuCjinxB4acylUIQ6/aM8Risskw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710930963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z2ILPVgNiO8LB9zQ5hh2M+8G/r9fgx618Pwk8og4Tc=;
	b=E+TEKYlLUHXZiorSNAkGMbJwhOEDCoVdygmllffcoU8ukcA8dsZ+cQIMWp2UXbeNI3PuCW
	mBVB914H+/Vbp0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75D49136D6;
	Wed, 20 Mar 2024 10:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Ru8HBO8+mV+bQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Mar 2024 10:36:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 21248A07D6; Wed, 20 Mar 2024 11:36:03 +0100 (CET)
Date: Wed, 20 Mar 2024 11:36:03 +0100
From: Jan Kara <jack@suse.cz>
To: wenyang.linux@foxmail.com
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	Dave Young <dyoung@redhat.com>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 8/9] fs: inotify: delete these unnecessary
 static variables it_zero and it_int_max
Message-ID: <20240320103603.u6uqhk6viu4qkaht@quack3>
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
 <tencent_3066A7AB308FF9F53E3B5639514306914D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3066A7AB308FF9F53E3B5639514306914D0A@qq.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p3MjtqRG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=E+TEKYlL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[foxmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,chromium.org:email];
	 FREEMAIL_TO(0.00)[foxmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.74)[93.42%]
X-Spam-Score: -2.75
X-Rspamd-Queue-Id: 815CE341F0
X-Spam-Flag: NO

On Tue 19-03-24 23:57:49, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> Delete unnecessary static variables (it_zero and it_int_max)
> and encode them directly in the table entry.
> 
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: linux-kernel@vger.kernel.org

This looks as a sensible cleanup but I don't see the first patch in the
series (and neither it is archived at lore.kernel.org) so I cannot really
verify whether your conversion is correct...

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 49 +++++++++++++-------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 85d8fdd55329..b346d61179ea 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -55,36 +55,27 @@ struct kmem_cache *inotify_inode_mark_cachep __ro_after_init;
>  
>  #include <linux/sysctl.h>
>  
> -static long it_zero = 0;
> -static long it_int_max = INT_MAX;
> -
>  static struct ctl_table inotify_table[] = {
> -	{
> -		.procname	= "max_user_instances",
> -		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
> -		.maxlen		= sizeof(long),
> -		.mode		= 0644,
> -		.proc_handler	= proc_doulongvec_minmax,
> -		.extra1		= &it_zero,
> -		.extra2		= &it_int_max,
> -	},
> -	{
> -		.procname	= "max_user_watches",
> -		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
> -		.maxlen		= sizeof(long),
> -		.mode		= 0644,
> -		.proc_handler	= proc_doulongvec_minmax,
> -		.extra1		= &it_zero,
> -		.extra2		= &it_int_max,
> -	},
> -	{
> -		.procname	= "max_queued_events",
> -		.data		= &inotify_max_queued_events,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO
> -	},
> +	CTL_TABLE_ENTRY_MINMAX("max_user_instances",
> +			       &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
> +			       sizeof(long),
> +			       0644,
> +			       proc_doulongvec_minmax,
> +			       SYSCTL_NUMERIC_ZERO,
> +			       SYSCTL_NUMERIC_INT_MAX),
> +	CTL_TABLE_ENTRY_MINMAX("max_user_watches",
> +			       &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
> +			       sizeof(long),
> +			       0644,
> +			       proc_doulongvec_minmax,
> +			       SYSCTL_NUMERIC_ZERO,
> +			       SYSCTL_NUMERIC_INT_MAX),
> +	CTL_TABLE_ENTRY_MIN("max_queued_events",
> +			    &inotify_max_queued_events,
> +			    sizeof(int),
> +			    0644,
> +			    proc_dointvec_minmax,
> +			    SYSCTL_NUMERIC_ZERO),
>  };
>  
>  static void __init inotify_sysctls_init(void)
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

