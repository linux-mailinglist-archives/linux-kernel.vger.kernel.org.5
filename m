Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F2799218
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbjIHWSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244760AbjIHWSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:18:09 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D592E1FCA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:18:01 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4935f87ca26so968123e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694211481; x=1694816281; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSRvHYm8s43TE4XVO2qA12F06WNT4dmrU+ghW6YhLOk=;
        b=bdS9DMN8F0N4W+0fTMt66eFFYKTm58fQsyXSU4BUksE674XbrMz4eWpo32mHLDgQBs
         NftVkUOZfuu0AsZQtlEoKp+01rQze87ZABomB+Js+5RPhOhElAfEEsbnCOaGflc7O07i
         BioHyJw1Ft3Xzb3HCfh0EGAaL28y1Jl8nAPVu70EeXQwjSKlh50U3i0etTbPYWFGn+gJ
         HdQFRhpWj0mESm/gdIMdqCKjg+JEeEK//g9ho1tJ+IoED/BI9J32SKWiL8IqwbMO+fvo
         1TpbzmKxianQINCh2KUVXno+FnU5OwHhNq6mXl8Y3UDnt6b4fZuYnKiTL29+3/2Ruo1S
         Js6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694211481; x=1694816281;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSRvHYm8s43TE4XVO2qA12F06WNT4dmrU+ghW6YhLOk=;
        b=AaA3qLwIqK36qjena+el288yww40v8Hw6O5wUMBzmYn/i7/1R8hCFMSanTCI18fvUN
         7dBoUOKGidIPSZJiXWK+/FQVDEtClOBe6Nlcs0rDP5crocOSq5ifU7JM5mQBgQq5EM5z
         Klu+BDtRmPRSfHk6gz8yXBwbmB0pGvO+6ZCA+jsxBdjVnpFT5xSTtS7qYyOxiaEnW3/v
         DMZE5tG81Vo3g8Zu6zfGyu+HOu6+GG7urqycr0g8uKDxcLYS/FHyjxqWUHnlUT1FKgIZ
         aab/0HMJOIrsAmJYl5bjaI+UaaNjsj3ccLeEjjRZZx+4H0ZNc3ndLNIk/k6cGyQriv3g
         WrDQ==
X-Gm-Message-State: AOJu0Yz+WRZB30ZuA4RaXJnl+ptbdwrWB6V9CVf96N1bdR2M27JLTv5S
        jfbyW9gUdz1zgjo7omVeivtnIqf1avceUhOWVA==
X-Google-Smtp-Source: AGHT+IFCKXrZh2SIoevgtALR7ev1UXuYlWloay+x+eo1txWIY5uYUbTTN5e0YDBRhlfSP+cjm5EI6g==
X-Received: by 2002:a1f:ea04:0:b0:48d:3434:fe1a with SMTP id i4-20020a1fea04000000b0048d3434fe1amr3767674vkh.3.1694211480842;
        Fri, 08 Sep 2023 15:18:00 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id k13-20020ac8604d000000b00403b44bc230sm911197qtm.95.2023.09.08.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 15:18:00 -0700 (PDT)
Date:   Fri, 08 Sep 2023 18:17:59 -0400
Message-ID: <c16eadecb8d8c66e5ea98b52710d301c.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Mateusz Guzik <mjguzik@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] cred: add get_cred_many and put_cred_many
References: <20230815183759.1821357-1-mjguzik@gmail.com>
In-Reply-To: <20230815183759.1821357-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2023 Mateusz Guzik <mjguzik@gmail.com> wrote:
> 
> Shaves back-to-back atomics in a few places.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  include/linux/cred.h | 27 +++++++++++++++++++++------
>  kernel/cred.c        | 29 +++++++++++++++++------------
>  2 files changed, 38 insertions(+), 18 deletions(-)

Since there doesn't appear to be a dedicated maintainer for the
credential code I can volunteer to pick this up via the LSM tree.
Perhaps I should volunteer to maintain the credential code.

Regardless, I think this patch needs some additional work, starting
with the commit description.  I understand this isn't a very large
patch, but a quick discussion of how you are adding two new functions
to reduce the number of atomic operations that happen in a select
number of code paths where the caller takes multiple references ...
or something along those lines.

More comments below.

> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 9ed9232af934..b2b570ba204a 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -226,12 +226,17 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
>   * Get a reference on the specified set of new credentials.  The caller must
>   * release the reference.
>   */
> -static inline struct cred *get_new_cred(struct cred *cred)
> +static inline struct cred *get_new_cred_many(struct cred *cred, int nr)
>  {
> -	atomic_inc(&cred->usage);
> +	atomic_add(nr, &cred->usage);
>  	return cred;
>  }
>  
> +static inline struct cred *get_new_cred(struct cred *cred)
> +{
> +	return get_new_cred_many(cred, 1);
> +}

You need to add a kdoc comment header for get_new_cred_many() and
move the get_new_cred() comment down to match up with the function.

>  /**
>   * get_cred - Get a reference on a set of credentials
>   * @cred: The credentials to reference
> @@ -245,14 +250,19 @@ static inline struct cred *get_new_cred(struct cred *cred)
>   * accidental alteration of a set of credentials that should be considered
>   * immutable.
>   */
> -static inline const struct cred *get_cred(const struct cred *cred)
> +static inline const struct cred *get_cred_many(const struct cred *cred, int nr)
>  {
>  	struct cred *nonconst_cred = (struct cred *) cred;
>  	if (!cred)
>  		return cred;
>  	validate_creds(cred);
>  	nonconst_cred->non_rcu = 0;
> -	return get_new_cred(nonconst_cred);
> +	return get_new_cred_many(nonconst_cred, nr);
> +}
> +
> +static inline const struct cred *get_cred(const struct cred *cred)
> +{
> +	return get_cred_many(cred, 1);
>  }

Same issue with the kdoc comment headers.

>  static inline const struct cred *get_cred_rcu(const struct cred *cred)
> @@ -278,17 +288,22 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
>   * on task_struct are attached by const pointers to prevent accidental
>   * alteration of otherwise immutable credential sets.
>   */
> -static inline void put_cred(const struct cred *_cred)
> +static inline void put_cred_many(const struct cred *_cred, int nr)
>  {
>  	struct cred *cred = (struct cred *) _cred;
>  
>  	if (cred) {
>  		validate_creds(cred);
> -		if (atomic_dec_and_test(&(cred)->usage))
> +		if (atomic_sub_and_test(nr, &cred->usage))
>  			__put_cred(cred);
>  	}
>  }
>  
> +static inline void put_cred(const struct cred *cred)
> +{
> +	put_cred_many(cred, 1);
> +}

Same issue with the kdoc comment headers.

>  /**
>   * current_cred - Access the current task's subjective credentials
>   *
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 811ad654abd1..8a506bc7c1b8 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -159,23 +159,30 @@ EXPORT_SYMBOL(__put_cred);
>   */
>  void exit_creds(struct task_struct *tsk)
>  {
> -	struct cred *cred;
> +	struct cred *real_cred, *cred;
>  
>  	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
>  	       atomic_read(&tsk->cred->usage),
>  	       read_cred_subscribers(tsk->cred));
>  
> -	cred = (struct cred *) tsk->real_cred;
> +	real_cred = (struct cred *) tsk->real_cred;
>  	tsk->real_cred = NULL;
> -	validate_creds(cred);
> -	alter_cred_subscribers(cred, -1);
> -	put_cred(cred);
>  
>  	cred = (struct cred *) tsk->cred;
>  	tsk->cred = NULL;
> -	validate_creds(cred);

Since both branches of the if-statement below end up validating @cred
you might as well still do the validation check here.

> -	alter_cred_subscribers(cred, -1);
> -	put_cred(cred);
> +
> +	if (real_cred == cred) {
> +		validate_creds(cred);
> +		alter_cred_subscribers(cred, -2);
> +		put_cred_many(cred, 2);
> +	} else {
> +		validate_creds(real_cred);
> +		validate_creds(cred);
> +		alter_cred_subscribers(real_cred, -1);
> +		put_cred(real_cred);
> +		alter_cred_subscribers(cred, -1);
> +		put_cred(cred);
> +	}
>  
>  #ifdef CONFIG_KEYS_REQUEST_CACHE
>  	key_put(tsk->cached_requested_key);
> @@ -352,8 +359,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>  #endif
>  		clone_flags & CLONE_THREAD
>  	    ) {
> -		p->real_cred = get_cred(p->cred);
> -		get_cred(p->cred);
> +		p->real_cred = get_cred_many(p->cred, 2);
>  		alter_cred_subscribers(p->cred, 2);
>  		kdebug("share_creds(%p{%d,%d})",
>  		       p->cred, atomic_read(&p->cred->usage),
> @@ -517,8 +523,7 @@ int commit_creds(struct cred *new)
>  		proc_id_connector(task, PROC_EVENT_GID);
>  
>  	/* release the old obj and subj refs both */
> -	put_cred(old);
> -	put_cred(old);
> +	put_cred_many(old, 2);
>  	return 0;
>  }
>  EXPORT_SYMBOL(commit_creds);
> -- 
> 2.39.2

--
paul-moore.com
