Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC177A21C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjHLUAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHLUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24001BD8;
        Sat, 12 Aug 2023 12:59:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1d03e124so383653066b.2;
        Sat, 12 Aug 2023 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691870328; x=1692475128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8deft9GhCjrCi3zrUeTNCRn20vtzxZ38zbwkbMnefc=;
        b=b10+PhSV3gqBnzmaMHOdepoom+EKbw87uP8YKkY/qthU1lZLZ4F3tu1Es8ljYCQnVI
         bwF1NSKKoKQMEKBRhDzCuX8mPim/73rI0bvBbp+QDDaiTIzMEauE5CVJw0vyZ6GhCHMW
         elDVxviJSrM+nR8oz5RmgChMigqS+a4CeafHW4kFBlvRk/kAhgaCnELL8IguO2gZnbHG
         1fqxcQCiEh5TRlI9wrpzBZfYnwCuVu/k8XcYfmBHbzqHoQtszwPzncKBr6ahK2gy7O3q
         6klVNO8Xuk/0ka6zfE/Qcf7vHFfWKtfC7P2RzNelRIKsO3FZelqzl39GwYjHOiJsTN9c
         mnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870328; x=1692475128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8deft9GhCjrCi3zrUeTNCRn20vtzxZ38zbwkbMnefc=;
        b=N1AlDXzfmEMVAKbaoDDp/Y8ErQmL484e1ecRyaqqFu+W+OA5WtXbx8omyWPTyd5jdb
         3sgh5xbM674grolD8VfONr2P5qu+gPijFGXgWyhQHMHwsqyTOcPm1tbQ9DXlY8j4Ovb2
         UyshhHexLdQGRFl0qv6atD/x6LAyH4ggekxs5a4V04Ly0frOsvWCHJ3YbKdwPXBm6nCg
         Mf0vM5NcO/Hvf0xW9fqpXCZ/2gkSzx0XWQzaQ2rc9GMKab6Hqmdt2abhXyJXJnZaGLNJ
         kIGg1qVWebVUf1c7J5S5Y4waSpgL4uSOgl/+X0BYDOPi1tbgB4AZENXDvLLTWuqaGtj0
         szpQ==
X-Gm-Message-State: AOJu0YwlScg2vkASmuT5oeGdalIpq3yl7dYAd5Cm9Quh9Cq2/ZlBL1pd
        Y8CD1QdfXnPWd2pkQzncJxI=
X-Google-Smtp-Source: AGHT+IGQ4tRbyLwho9xAc0X7J8Xhcds7jth183riY6cj6srLEp+zdupr64cj9e2EjxlcXk1xuohQag==
X-Received: by 2002:a17:906:314e:b0:99b:627f:9c0d with SMTP id e14-20020a170906314e00b0099b627f9c0dmr4038716eje.27.1691870327675;
        Sat, 12 Aug 2023 12:58:47 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b0098e34446464sm3793857ejb.25.2023.08.12.12.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:58:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8052C27C005B;
        Sat, 12 Aug 2023 15:58:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 12 Aug 2023 15:58:45 -0400
X-ME-Sender: <xms:dOTXZB_Vi9HDAq6Qg3SnYGjEcXxgkF0iEEuQQ3PT2Hbsy0TToSNtLg>
    <xme:dOTXZFu0jXwJMIfMv8misdMlVT9f7vyWfkI04bS6kxJLzSeXMcoHHXVO44uxtyKgJ
    KdsG79ij_5gVsWSlQ>
X-ME-Received: <xmr:dOTXZPDko33u6dTRvzP0M8MXhUXwOlGLEdRdeQ5QG-yMx5k_11OfYa3oLdNwsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:dOTXZFeGmzAa8Gdspm67QRm9Jl2dNEnlbvq0UkPohW7jIVUt9YIxkg>
    <xmx:dOTXZGMhYvMcxnpUouQ_m9-8hIS1Re2343bK4nCQ6x0dgXmfuTuefg>
    <xmx:dOTXZHnF8ewGb1Z5KC9AhsYNvlwbUhdUSgEoriH-H8oyQZjqhntaBA>
    <xmx:deTXZDoB9ksVbxfSZZ8a8aTM6Cdru95qnq6HIy0U0MWDYj-dbM0SeA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Aug 2023 15:58:44 -0400 (EDT)
Date:   Sat, 12 Aug 2023 12:58:34 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: six locks: Fix missing barrier on
 wait->lock_acquired
Message-ID: <ZNfkaqfGwM8fIG7q@boqun-archlinux>
References: <20230812192720.2703874-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812192720.2703874-1-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 03:27:20PM -0400, Kent Overstreet wrote:
> Six locks do lock handoff via the wakeup path: the thread doing the
> wakeup also takes the lock on behalf of the waiter, which means the
> waiter only has to look at its waitlist entry, and doesn't have to touch
> the lock cacheline while another thread is using it.
> 
> Linus noticed that this needs a real barrier, which this patch fixes.
> 
> Also add a comment for the should_sleep_fn() error path.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: linux-bcachefs@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/bcachefs/six.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/bcachefs/six.c b/fs/bcachefs/six.c
> index 581aee565e..b6ca53c852 100644
> --- a/fs/bcachefs/six.c
> +++ b/fs/bcachefs/six.c
> @@ -223,14 +223,16 @@ static void __six_lock_wakeup(struct six_lock *lock, enum six_lock_type lock_typ
>  		if (ret <= 0)
>  			goto unlock;
>  
> -		__list_del(w->list.prev, w->list.next);
>  		task = w->task;
> +		__list_del(w->list.prev, w->list.next);
>  		/*
> -		 * Do no writes to @w besides setting lock_acquired - otherwise
> -		 * we would need a memory barrier:
> +		 * The release barrier here ensures the ordering of the
> +		 * __list_del before setting w->lock_acquired; @w is on the
> +		 * stack of the thread doing the waiting and will be reused
> +		 * after it sees w->lock_acquired with no other locking:
> +		 * pairs with smp_load_acquire() in six_lock_slowpath()
>  		 */
> -		barrier();
> -		w->lock_acquired = true;
> +		smp_store_release(&w->lock_acquired, true);
>  		wake_up_process(task);
>  	}
>  
> @@ -502,17 +504,32 @@ static int six_lock_slowpath(struct six_lock *lock, enum six_lock_type type,
>  	while (1) {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
>  
> -		if (wait->lock_acquired)
> +		/*
> +		 * Ensures that writes to the waitlist entry happen after we see

Maybe my English, but "happen after" here is a little confusing: writes
happen after the read of ->lock_acquired? How about

		/*
		 * Ensures once we observe the write to
		 * wait->lock_acquired, we must observe the writes to
		 * the waitlist entry: pairs with smp_store_release in
		 * __six_lock_wakeup
		 */

?

I haven't finished my review on the SIX lock, but this patch looks good
to me, feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +		 * wait->lock_acquired: pairs with the smp_store_release in
> +		 * __six_lock_wakeup
> +		 */
> +		if (smp_load_acquire(&wait->lock_acquired))
>  			break;
>  
>  		ret = should_sleep_fn ? should_sleep_fn(lock, p) : 0;
>  		if (unlikely(ret)) {
> +			bool acquired;
> +
> +			/*
> +			 * If should_sleep_fn() returns an error, we are
> +			 * required to return that error even if we already
> +			 * acquired the lock - should_sleep_fn() might have
> +			 * modified external state (e.g. when the deadlock cycle
> +			 * detector in bcachefs issued a transaction restart)
> +			 */
>  			raw_spin_lock(&lock->wait_lock);
> -			if (!wait->lock_acquired)
> +			acquired = wait->lock_acquired;
> +			if (!acquired)
>  				list_del(&wait->list);
>  			raw_spin_unlock(&lock->wait_lock);
>  
> -			if (unlikely(wait->lock_acquired))
> +			if (unlikely(acquired))
>  				do_six_unlock_type(lock, type);
>  			break;
>  		}
> -- 
> 2.40.1
> 
