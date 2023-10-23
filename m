Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62DB7D4328
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJWXWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:22:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8511C0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:22:48 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so51400531fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698103367; x=1698708167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRqLVtJ4+w6Q7VE/TH5E+yurITf2hF65g/YIWSM61UI=;
        b=NrGgcT1rZp9qMmxAnyHVNstXUYv6rt2UGqQiFTIt9ir6JX0xKKueSdQs7Wu0LLL2Ac
         Tgag75fIkZRG/fElY8geqyDJJvVnbYHF9Gya4nWbvB1f3YgZ0xHlK9UsKrKPX1jYZPD5
         PKTfQ6/3x7DrL1Odk4GrSnpY6heb74XhClsjXoEF4xO5g6Frgh34o7wza1NOPIQ0ykO1
         9K89tmR1s8QHONUTQBYImaJcSM05a4ZmGjYLa3+8+pSjkn1B2q51uK7V0azaHS43H/gR
         szbxuxGSIIbHwE1bVnBR8ipuhGh878O0cX1tSSEFCNmtLYI4bMz6odP9bWuiEPtYxKOw
         wEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698103367; x=1698708167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRqLVtJ4+w6Q7VE/TH5E+yurITf2hF65g/YIWSM61UI=;
        b=JJzCA/Jnr1dYqLgpixYr1de2vTuK1WFwaa8lq+3OB/oF19g8L8lQvOinZD/mfCpHsf
         tG2u8YpzQ5ThiXuvd6+Li1Hs0aeR4Ddts02AuVW971ap7wnwy5KbDDJ10Ic9BH/Wo9Ns
         ifTiKzX+vtZHDnt9lFI46edE6XtyWPR45Yz4ZWi+IBJTi9+OOlW18ycsej8EzYUBWDNK
         k8ef5CSk6Nky5knl6nRZpATNQ4/2WkM00FK+7H0FnaxsPE8IzGj0ZfzZc9T2yzQfQDJU
         IM+ycePYgGeg44ZwGXJ68xsWuJgZ0fDUWPBRbCcW4J+qvsbvOxXMzNhmpEz/N6MRvfnF
         +ldQ==
X-Gm-Message-State: AOJu0Yw6E9BGHFUIAp5tUIpQ468C7LsPkutydxzHXDifYuO3Q2iWZRhX
        to3YmXEQ2CYRlcjRokGBj0wM/XvjSex+YHevGC3aZQ==
X-Google-Smtp-Source: AGHT+IGrfm5czbpRabF9/H2HucnSiA1Nms8R7DXTnfVVdNdF09Z9p2OOZlW7bFdTwCxsfO3w3b8p8sdYkkW250uGLeE=
X-Received: by 2002:a2e:9691:0:b0:2bf:f32a:1f64 with SMTP id
 q17-20020a2e9691000000b002bff32a1f64mr7583173lji.18.1698103366961; Mon, 23
 Oct 2023 16:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com>
 <20231020104728.2060-1-hdanton@sina.com> <CABWYdi0N7uvDex5CdKD60hNQ6UFuqoB=Ss52yQu6UoMJm0MFPw@mail.gmail.com>
 <20231021012322.1799-1-hdanton@sina.com>
In-Reply-To: <20231021012322.1799-1-hdanton@sina.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 23 Oct 2023 16:22:35 -0700
Message-ID: <CABWYdi0j4yXWV6-Pr=2q7S6SQSZR7O6F61BLRdU=gDxvuQ3e1w@mail.gmail.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
To:     Hillf Danton <hdanton@sina.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 6:23=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Fri, 20 Oct 2023 10:25:25 -0700 Ivan Babrou <ivan@cloudflare.com>
> >
> > This could solve wait_for_unix_gc spinning, but it wouldn't affect
> > unix_gc itself, from what I understand. There would always be one
> > socket writer or destroyer punished by running the gc still.
>
> See what you want. The innocents are rescued by kicking a worker off.
> Only for thoughts.
>
> --- x/net/unix/garbage.c
> +++ y/net/unix/garbage.c
> @@ -86,7 +86,6 @@
>  /* Internal data structures and random procedures: */
>
>  static LIST_HEAD(gc_candidates);
> -static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
>
>  static void scan_inflight(struct sock *x, void (*func)(struct unix_sock =
*),
>                           struct sk_buff_head *hitlist)
> @@ -185,24 +184,25 @@ static void inc_inflight_move_tail(struc
>                 list_move_tail(&u->link, &gc_candidates);
>  }
>
> -static bool gc_in_progress;
> +static void __unix_gc(struct work_struct *w);
> +static DECLARE_WORK(unix_gc_work, __unix_gc);
> +
>  #define UNIX_INFLIGHT_TRIGGER_GC 16000
>
>  void wait_for_unix_gc(void)
>  {
>         /* If number of inflight sockets is insane,
> -        * force a garbage collect right now.
> -        * Paired with the WRITE_ONCE() in unix_inflight(),
> -        * unix_notinflight() and gc_in_progress().
> -        */
> -       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
> -           !READ_ONCE(gc_in_progress))
> -               unix_gc();
> -       wait_event(unix_gc_wait, gc_in_progress =3D=3D false);
> +        * kick a garbage collect right now.
> +        *
> +        * todo s/wait_for_unix_gc/kick_unix_gc/
> +        */
> +       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC /2)
> +               queue_work(system_unbound_wq, &unix_gc_work);
>  }
>
> -/* The external entry point: unix_gc() */
> -void unix_gc(void)
> +static DEFINE_MUTEX(unix_gc_mutex);
> +
> +static void __unix_gc(struct work_struct *w)
>  {
>         struct sk_buff *next_skb, *skb;
>         struct unix_sock *u;
> @@ -211,15 +211,10 @@ void unix_gc(void)
>         struct list_head cursor;
>         LIST_HEAD(not_cycle_list);
>
> +       if (!mutex_trylock(&unix_gc_mutex))
> +               return;
>         spin_lock(&unix_gc_lock);
>
> -       /* Avoid a recursive GC. */
> -       if (gc_in_progress)
> -               goto out;
> -
> -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> -       WRITE_ONCE(gc_in_progress, true);
> -
>         /* First, select candidates for garbage collection.  Only
>          * in-flight sockets are considered, and from those only ones
>          * which don't have any external reference.
> @@ -325,11 +320,12 @@ void unix_gc(void)
>         /* All candidates should have been detached by now. */
>         BUG_ON(!list_empty(&gc_candidates));
>
> -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> -       WRITE_ONCE(gc_in_progress, false);
> -
> -       wake_up(&unix_gc_wait);
> -
> - out:
>         spin_unlock(&unix_gc_lock);
> +       mutex_unlock(&unix_gc_mutex);
> +}
> +
> +/* The external entry point: unix_gc() */
> +void unix_gc(void)
> +{
> +       __unix_gc(NULL);
>  }
> --

This one results in less overall load than Kuniyuki's proposed patch
with my repro:

* https://lore.kernel.org/netdev/20231020220511.45854-1-kuniyu@amazon.com/

My guess is that's because my repro is the one that is getting penalized th=
ere.

There's still a lot work done in unix_release_sock here, where GC runs
as long as you have any fds inflight:

* https://elixir.bootlin.com/linux/v6.1/source/net/unix/af_unix.c#L670

Perhaps it can be improved.
