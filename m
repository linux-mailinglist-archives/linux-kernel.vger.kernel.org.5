Return-Path: <linux-kernel+bounces-42990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4288409C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2414B1F241C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D044153BCB;
	Mon, 29 Jan 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmA/JxQ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="79asHS5e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xd4VoyPF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lA4JvDbm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A60153500;
	Mon, 29 Jan 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541726; cv=none; b=Yjmq5U3H076NXrapl3G+eeXC0ldnszktJNh4Pv2BGjuroGOj3sts/3i3OHg7fRt17VSwaMOF3SHhfJHBfx/npi6YU6VrRKcqN0kLqBrQcYB73XcQL3D0wqkvmFCbwT3okj5Ssxk/doPvfyzv1iXugbuKQffD/cI7ElO+5RiX9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541726; c=relaxed/simple;
	bh=/u7yXK6pKxgNrbYc1C4sFX/A8nwLrqK9V9ngyk83kTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHjwwKPRYZ+aJo1bhNLLo/YALOboxXugUBh+BnnNETGCektn20DBUiKV8/Q3CCS3laEGDFmmI2AGIckrG/nQ3+bu5trdkiqTqiVprUWpEDdQtKAF/GUE8Ed8ur1mKBJiY+2svIppzB/SJ9wby5b/iGPD7/S1s1FJzpU26zr2fY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmA/JxQ2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=79asHS5e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xd4VoyPF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lA4JvDbm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1AD94216ED;
	Mon, 29 Jan 2024 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706541722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03pj/0PXBIlRKMN1CP7MRdO6/XgIj2+x8GVXnnQRLBA=;
	b=HmA/JxQ2VOeOnvHtU0oM+c6PK2w9s2EPq63d74NtPLLX4aButnX0tqnhV2+iBSmYrPymC2
	M/h8HAV333kNKuE1rNOUMxzoI6ODNjZnzoLv7wggc4GVDXLwY70pcWA9jO/EBnPaEOlftH
	cilNX7kdGLN9avqkiOW0YUTGc9odMhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706541722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03pj/0PXBIlRKMN1CP7MRdO6/XgIj2+x8GVXnnQRLBA=;
	b=79asHS5evxqzUqmpEKgB4UK4ZsSF9ccbORalo5Qar0zxHGflEYXIWWC3YtuLKEB3QX36tu
	0jI1LeN7PIgfdoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706541720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03pj/0PXBIlRKMN1CP7MRdO6/XgIj2+x8GVXnnQRLBA=;
	b=Xd4VoyPFMlxZmP19+nUERbBkuBekYr58PiNqYE3alYswRp0yO3uPJOnrBxd4hUeSdGWUCJ
	RIYeA2THp7B8884zCm9LyQUU6lJjmXLV3pyV27OHb2/navr2+dskypy55f9xxpC2lvcBz7
	WKJo/ZywGpsUS9BgtrIxUXF+f3lt8sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706541720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03pj/0PXBIlRKMN1CP7MRdO6/XgIj2+x8GVXnnQRLBA=;
	b=lA4JvDbmIusZESsX+JFu9UrLB+3Br8WXWn+rAEeD6HA4EQaxne1Y513Q2RsoTiy9I9cX2w
	bAEXXFXyo8d5vjDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D4C713911;
	Mon, 29 Jan 2024 15:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7047A5jCt2UPGQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 15:22:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87346A0807; Mon, 29 Jan 2024 16:21:59 +0100 (CET)
Date: Mon, 29 Jan 2024 16:21:59 +0100
From: Jan Kara <jack@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vgerkernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/4] fs/pipe: Convert to lockdep_cmp_fn
Message-ID: <20240129152159.ija7oppzsw7nf4oi@quack3>
References: <20240127020111.487218-1-kent.overstreet@linux.dev>
 <20240127020111.487218-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127020111.487218-2-kent.overstreet@linux.dev>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Xd4VoyPF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lA4JvDbm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,colorfullife.com:email,linux.dev:email,linux.org.uk:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,vgerkernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 1AD94216ED
X-Spam-Flag: NO

On Fri 26-01-24 21:01:05, Kent Overstreet wrote:
> *_lock_nested() is fundamentally broken; lockdep needs to check lock
> ordering, but we cannot device a total ordering on an unbounded number
> of elements with only a few subclasses.
> 
> the replacement is to define lock ordering with a proper comparison
> function.
> 
> fs/pipe.c was already doing everything correctly otherwise, nothing
> much changes here.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/pipe.c | 81 +++++++++++++++++++++++++------------------------------
>  1 file changed, 36 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index f1adbfe743d4..50c8a8596b52 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -76,18 +76,20 @@ static unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
>   * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
>   */
>  
> -static void pipe_lock_nested(struct pipe_inode_info *pipe, int subclass)
> +#define cmp_int(l, r)		((l > r) - (l < r))
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +static int pipe_lock_cmp_fn(const struct lockdep_map *a,
> +			    const struct lockdep_map *b)
>  {
> -	if (pipe->files)
> -		mutex_lock_nested(&pipe->mutex, subclass);
> +	return cmp_int((unsigned long) a, (unsigned long) b);
>  }
> +#endif
>  
>  void pipe_lock(struct pipe_inode_info *pipe)
>  {
> -	/*
> -	 * pipe_lock() nests non-pipe inode locks (for writing to a file)
> -	 */
> -	pipe_lock_nested(pipe, I_MUTEX_PARENT);
> +	if (pipe->files)
> +		mutex_lock(&pipe->mutex);
>  }
>  EXPORT_SYMBOL(pipe_lock);
>  
> @@ -98,28 +100,16 @@ void pipe_unlock(struct pipe_inode_info *pipe)
>  }
>  EXPORT_SYMBOL(pipe_unlock);
>  
> -static inline void __pipe_lock(struct pipe_inode_info *pipe)
> -{
> -	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
> -}
> -
> -static inline void __pipe_unlock(struct pipe_inode_info *pipe)
> -{
> -	mutex_unlock(&pipe->mutex);
> -}
> -
>  void pipe_double_lock(struct pipe_inode_info *pipe1,
>  		      struct pipe_inode_info *pipe2)
>  {
>  	BUG_ON(pipe1 == pipe2);
>  
> -	if (pipe1 < pipe2) {
> -		pipe_lock_nested(pipe1, I_MUTEX_PARENT);
> -		pipe_lock_nested(pipe2, I_MUTEX_CHILD);
> -	} else {
> -		pipe_lock_nested(pipe2, I_MUTEX_PARENT);
> -		pipe_lock_nested(pipe1, I_MUTEX_CHILD);
> -	}
> +	if (pipe1 > pipe2)
> +		swap(pipe1, pipe2);
> +
> +	pipe_lock(pipe1);
> +	pipe_lock(pipe2);
>  }
>  
>  static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
> @@ -271,7 +261,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		return 0;
>  
>  	ret = 0;
> -	__pipe_lock(pipe);
> +	mutex_lock(&pipe->mutex);
>  
>  	/*
>  	 * We only wake up writers if the pipe was full when we started
> @@ -368,7 +358,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  			ret = -EAGAIN;
>  			break;
>  		}
> -		__pipe_unlock(pipe);
> +		mutex_unlock(&pipe->mutex);
>  
>  		/*
>  		 * We only get here if we didn't actually read anything.
> @@ -400,13 +390,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>  			return -ERESTARTSYS;
>  
> -		__pipe_lock(pipe);
> +		mutex_lock(&pipe->mutex);
>  		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
>  		wake_next_reader = true;
>  	}
>  	if (pipe_empty(pipe->head, pipe->tail))
>  		wake_next_reader = false;
> -	__pipe_unlock(pipe);
> +	mutex_unlock(&pipe->mutex);
>  
>  	if (was_full)
>  		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> @@ -462,7 +452,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  	if (unlikely(total_len == 0))
>  		return 0;
>  
> -	__pipe_lock(pipe);
> +	mutex_lock(&pipe->mutex);
>  
>  	if (!pipe->readers) {
>  		send_sig(SIGPIPE, current, 0);
> @@ -582,19 +572,19 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  		 * after waiting we need to re-check whether the pipe
>  		 * become empty while we dropped the lock.
>  		 */
> -		__pipe_unlock(pipe);
> +		mutex_unlock(&pipe->mutex);
>  		if (was_empty)
>  			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>  		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
> -		__pipe_lock(pipe);
> +		mutex_lock(&pipe->mutex);
>  		was_empty = pipe_empty(pipe->head, pipe->tail);
>  		wake_next_writer = true;
>  	}
>  out:
>  	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
>  		wake_next_writer = false;
> -	__pipe_unlock(pipe);
> +	mutex_unlock(&pipe->mutex);
>  
>  	/*
>  	 * If we do do a wakeup event, we do a 'sync' wakeup, because we
> @@ -629,7 +619,7 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  
>  	switch (cmd) {
>  	case FIONREAD:
> -		__pipe_lock(pipe);
> +		mutex_lock(&pipe->mutex);
>  		count = 0;
>  		head = pipe->head;
>  		tail = pipe->tail;
> @@ -639,16 +629,16 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			count += pipe->bufs[tail & mask].len;
>  			tail++;
>  		}
> -		__pipe_unlock(pipe);
> +		mutex_unlock(&pipe->mutex);
>  
>  		return put_user(count, (int __user *)arg);
>  
>  #ifdef CONFIG_WATCH_QUEUE
>  	case IOC_WATCH_QUEUE_SET_SIZE: {
>  		int ret;
> -		__pipe_lock(pipe);
> +		mutex_lock(&pipe->mutex);
>  		ret = watch_queue_set_size(pipe, arg);
> -		__pipe_unlock(pipe);
> +		mutex_unlock(&pipe->mutex);
>  		return ret;
>  	}
>  
> @@ -734,7 +724,7 @@ pipe_release(struct inode *inode, struct file *file)
>  {
>  	struct pipe_inode_info *pipe = file->private_data;
>  
> -	__pipe_lock(pipe);
> +	mutex_lock(&pipe->mutex);
>  	if (file->f_mode & FMODE_READ)
>  		pipe->readers--;
>  	if (file->f_mode & FMODE_WRITE)
> @@ -747,7 +737,7 @@ pipe_release(struct inode *inode, struct file *file)
>  		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>  	}
> -	__pipe_unlock(pipe);
> +	mutex_unlock(&pipe->mutex);
>  
>  	put_pipe_info(inode, pipe);
>  	return 0;
> @@ -759,7 +749,7 @@ pipe_fasync(int fd, struct file *filp, int on)
>  	struct pipe_inode_info *pipe = filp->private_data;
>  	int retval = 0;
>  
> -	__pipe_lock(pipe);
> +	mutex_lock(&pipe->mutex);
>  	if (filp->f_mode & FMODE_READ)
>  		retval = fasync_helper(fd, filp, on, &pipe->fasync_readers);
>  	if ((filp->f_mode & FMODE_WRITE) && retval >= 0) {
> @@ -768,7 +758,7 @@ pipe_fasync(int fd, struct file *filp, int on)
>  			/* this can happen only if on == T */
>  			fasync_helper(-1, filp, 0, &pipe->fasync_readers);
>  	}
> -	__pipe_unlock(pipe);
> +	mutex_unlock(&pipe->mutex);
>  	return retval;
>  }
>  
> @@ -834,6 +824,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
>  		pipe->nr_accounted = pipe_bufs;
>  		pipe->user = user;
>  		mutex_init(&pipe->mutex);
> +		lock_set_cmp_fn(&pipe->mutex, pipe_lock_cmp_fn, NULL);
>  		return pipe;
>  	}
>  
> @@ -1144,7 +1135,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
>  	filp->private_data = pipe;
>  	/* OK, we have a pipe and it's pinned down */
>  
> -	__pipe_lock(pipe);
> +	mutex_lock(&pipe->mutex);
>  
>  	/* We can only do regular read/write on fifos */
>  	stream_open(inode, filp);
> @@ -1214,7 +1205,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
>  	}
>  
>  	/* Ok! */
> -	__pipe_unlock(pipe);
> +	mutex_unlock(&pipe->mutex);
>  	return 0;
>  
>  err_rd:
> @@ -1230,7 +1221,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
>  	goto err;
>  
>  err:
> -	__pipe_unlock(pipe);
> +	mutex_unlock(&pipe->mutex);
>  
>  	put_pipe_info(inode, pipe);
>  	return ret;
> @@ -1411,7 +1402,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
>  	if (!pipe)
>  		return -EBADF;
>  
> -	__pipe_lock(pipe);
> +	mutex_lock(&pipe->mutex);
>  
>  	switch (cmd) {
>  	case F_SETPIPE_SZ:
> @@ -1425,7 +1416,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
>  		break;
>  	}
>  
> -	__pipe_unlock(pipe);
> +	mutex_unlock(&pipe->mutex);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

