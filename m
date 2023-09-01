Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF277903CA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351096AbjIAWxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjIAWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:53:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78485138;
        Fri,  1 Sep 2023 15:52:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6beff322a97so1987578a34.3;
        Fri, 01 Sep 2023 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693608778; x=1694213578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5+sW4mqGW8LxuwW7ALWEfQkhUWpZcqcc3uSM7JKnmU=;
        b=hcDJnOeUyTMaEbNAjzf7Ke+aCOxykR+eR44E6CKXaOshZvZ3YtDOy8IPSb7NO6NcFt
         z/ewvpctnsOsArEFJxShtI2vzE2HX53cCqDKonMrNobMRMzFrYMTpOweUkfUyS3iF11S
         ZjPP/lLl0Dg43zDmVHYOZgx0fGL+hY/ZKAHmq5BN7dI9Bvn0x+Y2I72I5Au86gCcs568
         xk1WLVD/gPZ/aAClGIzohwGAbOsU7Ya0HsKNbpb+72MYVV+V9JIF0RIDQdtlPwK4higq
         /XOHz20DQUfi1725mpZMqVT1tZYei/X+QVyFuInzFvVc9rBSNCx+W/hd4yeJtheT16/m
         xyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693608778; x=1694213578;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5+sW4mqGW8LxuwW7ALWEfQkhUWpZcqcc3uSM7JKnmU=;
        b=XxzQzkjkUV1z6bmUfDZt5N8y/UHz1GXiR0SGDK8gJJejUsZenx5E33Z6UDqYuGXSG7
         Fa78JXq3JGI1MCdJ3jk7gBo4HWrUpMsoZwvrOw2ZqTpdI1gv98xdZOitvqaX3RL8fQdA
         2fdNy/2cocjUX84kAKB7kJ+01yaVL55MfYp9EhN9wBl5maHMBofFc9WIkiJce/gB2x7X
         +UYTBoICFGAbKMpK+3GL3In+VyA/X2M7zh2Tu4Vb76c7h3iG3/+XvrnLGqvOKTRstn1Q
         XhkCEuMCDYTe3DGqMyLc4W2I0LlGtOcA7DfLyQ+SRAaiOf23mixDtkpNOOcWXNdpUeIo
         x5Gg==
X-Gm-Message-State: AOJu0YyNrtMx3cD9usluJrUYOtySnSgpiyrWhJrnf1mUDuJ1gjdcNabX
        O+qh6LTFsmQt3BUB2pahjo/Maz8bvyUG/09z9b7+vT54Mdk=
X-Google-Smtp-Source: AGHT+IFBIIy7lYXGAeciBBAefu2viHmqKMYhtBngNepWE6COHhxykxZY/5i5hOrrjp5zDVPpXiNdxO46qfzaDZ87W0Y=
X-Received: by 2002:a05:6870:a924:b0:1bf:74cc:c815 with SMTP id
 eq36-20020a056870a92400b001bf74ccc815mr4059571oab.19.1693608778493; Fri, 01
 Sep 2023 15:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Fri, 1 Sep 2023
 15:52:57 -0700 (PDT)
In-Reply-To: <20230815183759.1821357-1-mjguzik@gmail.com>
References: <20230815183759.1821357-1-mjguzik@gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 2 Sep 2023 00:52:57 +0200
Message-ID: <CAGudoHEgwMwbRr-CpgYFAkEKdcsoV320cicn-wPYr-_wiT0mXQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: add get_cred_many and put_cred_many
To:     linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

can I get some flames on this?

It there are no responses I'm dropping the patch, it is not worth
significant hassle.

On 8/15/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> Shaves back-to-back atomics in a few places.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  include/linux/cred.h | 27 +++++++++++++++++++++------
>  kernel/cred.c        | 29 +++++++++++++++++------------
>  2 files changed, 38 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 9ed9232af934..b2b570ba204a 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -226,12 +226,17 @@ static inline bool cap_ambient_invariant_ok(const
> struct cred *cred)
>   * Get a reference on the specified set of new credentials.  The caller
> must
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
> +
>  /**
>   * get_cred - Get a reference on a set of credentials
>   * @cred: The credentials to reference
> @@ -245,14 +250,19 @@ static inline struct cred *get_new_cred(struct cred
> *cred)
>   * accidental alteration of a set of credentials that should be considered
>   * immutable.
>   */
> -static inline const struct cred *get_cred(const struct cred *cred)
> +static inline const struct cred *get_cred_many(const struct cred *cred, int
> nr)
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
>
>  static inline const struct cred *get_cred_rcu(const struct cred *cred)
> @@ -278,17 +288,22 @@ static inline const struct cred *get_cred_rcu(const
> struct cred *cred)
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
> +
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
>  	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred,
> tsk->cred,
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
> @@ -352,8 +359,7 @@ int copy_creds(struct task_struct *p, unsigned long
> clone_flags)
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
>
>


-- 
Mateusz Guzik <mjguzik gmail.com>
