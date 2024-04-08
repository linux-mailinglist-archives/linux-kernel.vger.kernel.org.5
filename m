Return-Path: <linux-kernel+bounces-135591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F1689C80F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C041C23DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65E114037F;
	Mon,  8 Apr 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CI2SvqdP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0013FD82
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589651; cv=none; b=cY2QRHJlgiw2yI3X8ShQDqYb9IbYViGHszFPQ/Mqsz9ia0PADxlgUvvr12/d1e8okiGM18sSkz1GI85EMY/1qqr5YkLldXE5ZsP0Na3c4V/0+FIrhnQzfG5cyjoAIlI/HeHc6iK1PoZwQEi6w7qmgs7Mn9vP+Jmf7PjtuPTbf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589651; c=relaxed/simple;
	bh=EG+aMzZWPqXZP7pzqVNCG494GIdBKoJ8HRXzj3U/2Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2jd1lleysNxpvoEZwWcK0oBDwWNBEbXh41kTP4voQWItpd4Lh8DlW18gVxc4Lw/jyVXVyfRD24Y04JvNs8jNgIuK/i+JtSmR1c1R4qLJzjjKmhUxMEEUYl+pdRsIYqf6q60qyISNcbu3TGT0FatJUjB1j7c/oJLA0V4eouXKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CI2SvqdP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4168a0d113cso4071155e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712589647; x=1713194447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlOCHrfesqm1a/UwNqzCRqzi7tcuVj6qUjpVgZMf4pQ=;
        b=CI2SvqdPoXYRJVtOTGy+nJI8kVpO4LtyVgJF7a8atV98zjtQ7qtMROy/2la4lw9Mnq
         8iv/bAh1uQh/CkjAEAMYDgj6PkyDTBpau0zcstj30xufD0LlWgAVx+F+KejqpAGdF+KD
         NW1yycYeODfJeTm+0+mEr3XofICeJiQbzpbSNsNyzry7mpVkORqljgsiY8OgjdFZPOT6
         QdOYmtiteza+SqHWqeXxwOpoJEgWgnomYLIFvSw6IZWSCCzUnPbpJyXjvkJZ/kmYUt2Z
         8+i6zNdMFSNoka+enf+wu6cISp1+8L2tbd1U/UQFncgl8FMyHJD7FXyfhGIgZhrBPJzZ
         nKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589647; x=1713194447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlOCHrfesqm1a/UwNqzCRqzi7tcuVj6qUjpVgZMf4pQ=;
        b=YneRl2WWirTeaAn6jLrWNXDVF6znGNspylKwbJY5qLiL7wOHe7jH6nnkiyCkz9AkCB
         tv0PD79bR08vewAI+BecQckyFDcwlk3Lx+c8baXSwKVjBEHRwmmzX5ldA26dXZCTeHKE
         TQ/sKR4aquWsm5w39vhR34A1BcSmOUkLhF7gA4rm5IDSqoVkv8PcN/ohs/ARuhtvw1+I
         z/3eNh+36B5/nleOp7f5u76D0ByzJyeOpM6s7uMkB5RDoFJijrmEdYRAowDXBEbFkt92
         DOu91zCKatP8mqGTy3uwIz1bYTehA7Dk5rJhBnBG6eqkiTP2mKWBu2CS3UV8QtmC1ufP
         66ow==
X-Forwarded-Encrypted: i=1; AJvYcCWF7Cgb1489ORg6E/tKwqLKFhlQVqS5aP/WFa3hI7P/qWXl4TshuWQQEbMPQqO4TXT8Yh3xovPv/NtJX85o7nmYJHXK8vjz8b5DILc9
X-Gm-Message-State: AOJu0YxGuzM/pWWhma22JEvEv+Q+2QxirNHEKnLoV8TilpysajETpwiE
	Ykcz09mzNBVinpzwYJi3zqixTZOIEftF+40Tm8ogwvhN4Il39IZqWKLYxgM55ZGB/Z/A8Y5l7sP
	B
X-Google-Smtp-Source: AGHT+IGAQbEMWzyEkxGRWbLPrmdCENpYufKXYHYCKztk7Thbx6l1DgCJTGo7NH/kY1OWvxn6gcarUQ==
X-Received: by 2002:a05:600c:4ece:b0:416:3365:b9c7 with SMTP id g14-20020a05600c4ece00b004163365b9c7mr5491546wmq.13.1712589646805;
        Mon, 08 Apr 2024 08:20:46 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id fl14-20020a05600c0b8e00b004166d303d6fsm4352595wmb.25.2024.04.08.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:20:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 17:20:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 05/27] printk: nbcon: Add detailed doc for
 write_atomic()
Message-ID: <ZhQLTet7he6B3ChF@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-6-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:07, John Ogness wrote:
> The write_atomic() callback has special requirements and is
> allowed to use special helper functions. Provide detailed
> documentation of the callback so that a developer has a
> chance of implementing it correctly.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

I have re-read the text and found a mistake.

---
>  include/linux/console.h | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 54b98e4f0544..e4028d4079e1 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -285,7 +285,7 @@ struct nbcon_write_context {
>  /**
>   * struct console - The console descriptor structure
>   * @name:		The name of the console driver
> - * @write:		Write callback to output messages (Optional)
> + * @write:		Legacy write callback to output messages (Optional)
>   * @read:		Read callback for console input (Optional)
>   * @device:		The underlying TTY device driver (Optional)
>   * @unblank:		Callback to unblank the console (Optional)
> @@ -302,7 +302,6 @@ struct nbcon_write_context {
>   * @data:		Driver private data
>   * @node:		hlist node for the console list
>   *
> - * @write_atomic:	Write callback for atomic context
>   * @nbcon_state:	State for nbcon consoles
>   * @nbcon_seq:		Sequence number of the next record for nbcon to print
>   * @pbufs:		Pointer to nbcon private buffer
> @@ -327,8 +326,32 @@ struct console {
>  	struct hlist_node	node;
>  
>  	/* nbcon console specific members */
> -	void			(*write_atomic)(struct console *con,
> -						struct nbcon_write_context *wctxt);
> +
> +	/**
> +	 * @write_atomic:
> +	 *
> +	 * NBCON callback to write out text in any context.
> +	 *
> +	 * This callback is called with the console already acquired. The
> +	 * callback can use nbcon_can_proceed() at any time to verify that
> +	 * it is still the owner of the console. In the case that it has
> +	 * lost ownership, it is no longer allowed to go forward. In this
> +	 * case it must back out immediately and carefully. The buffer
> +	 * content is also no longer trusted since it no longer belongs to
> +	 * the context.
> +	 *
> +	 * If the callback needs to perform actions where ownership is not
> +	 * allowed to be taken over, nbcon_enter_unsafe() and
> +	 * nbcon_exit_unsafe() can be used to mark such sections.

IMHO, the word 'can' is wrong. The callback has to enter unsafe state
when the ownership is not allowed to be taken over.

We should probably be more clear what this exactly means.

Thinking more about this. We should also be more clear about when
to use nbcon_can_proceed() and what it guarantees. Is it actually
useful to call it directly in practice?


> +	 * functions are also points of possible ownership transfer. If
> +	 * either function returns false, ownership has been lost.
> +	 *
> +	 * This callback can be called from any context (including NMI).
> +	 * Therefore it must avoid usage of any locking and instead rely
> +	 * on the console ownership for synchronization.
> +	 */

My proposal:

	/**
	 * @write_atomic:
	 *
	 * NBCON callback to write out text in any context.
	 *
	 * This callback is called with the nbcon context acquired. But
	 * a higher priority context is allowed to take over it by default.
	 *
	 * The callback has to call nbcon_enter_unsafe() and nbcon_exit_unsafe()
	 * around any code where the takeover is not safe, for example, when
	 * manipulating the serial port registers.
	 *
	 * nbcon_enter_unsafe() might fail when the context has lost
	 * the console ownership in the meantime. In this case, the callback
	 * is no longer allowed to go forward. It must back out immediately and
	 * carefully. The buffer content is also no longer trusted since it
	 * no longer belongs to the context.
	 *
	 * The callback should allow the takeover whenever it is safe.
	 * It increases the chance to see messages when the system is
	 * in troubles.
	 *
	 * The callback is called from any context (including NMI).
	 * Therefore it must avoid usage of any locking and instead rely
	 * on the console ownership for synchronization.
	 */

> +	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
> +
>  	atomic_t		__private nbcon_state;
>  	atomic_long_t		__private nbcon_seq;
>  	struct printk_buffers	*pbufs;


Best Regards,
Petr

