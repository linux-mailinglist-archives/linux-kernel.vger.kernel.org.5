Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220877F2067
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjKTWbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:31:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C3D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:31:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00ac0101d9so103712366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700519463; x=1701124263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg3KYTOpaHUPxoe0mAh59rcd06Dnxc8kFcQ0VbmJou8=;
        b=NLAhYOL9VRDrDJUJkgMBxc9kqpPvHLsYvRxnKqC0homPBZe3GsjNopKg0qBOyVFKlM
         TpPAvSivNhh6wHXxDWznJlLozHs0ig8RI6ZdPT4Wa20TUXEhBfarJy2c2usmiiz03FZc
         hbIs+RR3NN6hFeuFXQqK7wO0KiNHihtscwIirPtgsKONOkftqIIJyUOAsBKsV7eht82V
         M6+8pNqnn6v3ecfWwOAfQvLo5Sf8lIL35eGi7EYKADYmM4GhyHoocyOJdttvKrnSvjye
         SUFZThkUiA9o4ZPvAPCLaTBQv+e4YSzoUvE/hqzB8z05P0oD34TRQ6w6JIYFBHYs4Vf6
         qb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700519463; x=1701124263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xg3KYTOpaHUPxoe0mAh59rcd06Dnxc8kFcQ0VbmJou8=;
        b=LLfcBsH6Y0s4W+lfpBFKYselWH5q+/CXK+49pmnNHCy3287yQiA3db34aUsaj0l4Wo
         kzchQCBkmyyKaOhXxOt6ZE6MH48YXsUvxezwt755aT1Q9ceW5oY9NGkoi4U01k33zcRv
         fnYuvd9ksKGzJ3QJxE6CR7KyY4Ikvuvdi1VeduScM28kPGFHBvz/v7FXTFe4PZ66NXmR
         tS8kpVCHKIx9Is9QTO7CiDvnQnoXHdwm1DosU2+qubRtrxbo5k5mtbrw92gvksEP9+MF
         pyXEQ06BSUb/Bsf9hnO98UfX0hvygG0zM8X1G0+eIIt6MkliUK4sS0CgnvLOgGTFnmCR
         yfgA==
X-Gm-Message-State: AOJu0Yw8x4+jgXL4nRqbo07U9Hhcj7uQqGZpkdaVTbLpJboZD4SMOUL5
        jucbYFS3tUC6RIQiUSffBoc5AZ24UzY4BmCHAyUTyxT40Z4bX4DGopE=
X-Google-Smtp-Source: AGHT+IE3Ovz+frJ9dXJymoRCMr429yTI0Z0DSZ+I2cvlEb4YQCn/4L/YlBzxib/xVjsTQTnkYd5750/khF4ByFUoVlQ=
X-Received: by 2002:a17:907:a705:b0:9da:f391:409a with SMTP id
 vw5-20020a170907a70500b009daf391409amr7669748ejc.26.1700519463417; Mon, 20
 Nov 2023 14:31:03 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi2JmfMBK43KrkAGsz+MN8KyFSjg0QZv5G_cuA1k1c0f7w@mail.gmail.com>
 <20231120192913.28629-1-kuniyu@amazon.com>
In-Reply-To: <20231120192913.28629-1-kuniyu@amazon.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 20 Nov 2023 14:30:52 -0800
Message-ID: <CABWYdi31mJmLhKUnCmFpJoEfO8F03tQhDoLxCuu6sJn3Tytbng@mail.gmail.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     edumazet@google.com, hdanton@sina.com, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:29=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ivan Babrou <ivan@cloudflare.com>
> Date: Fri, 17 Nov 2023 15:38:42 -0800
> > On Mon, Oct 23, 2023 at 4:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > From: Ivan Babrou <ivan@cloudflare.com>
> > > Date: Mon, 23 Oct 2023 16:22:35 -0700
> > > > On Fri, Oct 20, 2023 at 6:23=E2=80=AFPM Hillf Danton <hdanton@sina.=
com> wrote:
> > > > >
> > > > > On Fri, 20 Oct 2023 10:25:25 -0700 Ivan Babrou <ivan@cloudflare.c=
om>
> > > > > >
> > > > > > This could solve wait_for_unix_gc spinning, but it wouldn't aff=
ect
> > > > > > unix_gc itself, from what I understand. There would always be o=
ne
> > > > > > socket writer or destroyer punished by running the gc still.
> > > > >
> > > > > See what you want. The innocents are rescued by kicking a worker =
off.
> > > > > Only for thoughts.
> > > > >
> > > > > --- x/net/unix/garbage.c
> > > > > +++ y/net/unix/garbage.c
> > > > > @@ -86,7 +86,6 @@
> > > > >  /* Internal data structures and random procedures: */
> > > > >
> > > > >  static LIST_HEAD(gc_candidates);
> > > > > -static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
> > > > >
> > > > >  static void scan_inflight(struct sock *x, void (*func)(struct un=
ix_sock *),
> > > > >                           struct sk_buff_head *hitlist)
> > > > > @@ -185,24 +184,25 @@ static void inc_inflight_move_tail(struc
> > > > >                 list_move_tail(&u->link, &gc_candidates);
> > > > >  }
> > > > >
> > > > > -static bool gc_in_progress;
> > > > > +static void __unix_gc(struct work_struct *w);
> > > > > +static DECLARE_WORK(unix_gc_work, __unix_gc);
> > > > > +
> > > > >  #define UNIX_INFLIGHT_TRIGGER_GC 16000
> > > > >
> > > > >  void wait_for_unix_gc(void)
> > > > >  {
> > > > >         /* If number of inflight sockets is insane,
> > > > > -        * force a garbage collect right now.
> > > > > -        * Paired with the WRITE_ONCE() in unix_inflight(),
> > > > > -        * unix_notinflight() and gc_in_progress().
> > > > > -        */
> > > > > -       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_=
GC &&
> > > > > -           !READ_ONCE(gc_in_progress))
> > > > > -               unix_gc();
> > > > > -       wait_event(unix_gc_wait, gc_in_progress =3D=3D false);
> > > > > +        * kick a garbage collect right now.
> > > > > +        *
> > > > > +        * todo s/wait_for_unix_gc/kick_unix_gc/
> > > > > +        */
> > > > > +       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_=
GC /2)
> > > > > +               queue_work(system_unbound_wq, &unix_gc_work);
> > > > >  }
> > > > >
> > > > > -/* The external entry point: unix_gc() */
> > > > > -void unix_gc(void)
> > > > > +static DEFINE_MUTEX(unix_gc_mutex);
> > > > > +
> > > > > +static void __unix_gc(struct work_struct *w)
> > > > >  {
> > > > >         struct sk_buff *next_skb, *skb;
> > > > >         struct unix_sock *u;
> > > > > @@ -211,15 +211,10 @@ void unix_gc(void)
> > > > >         struct list_head cursor;
> > > > >         LIST_HEAD(not_cycle_list);
> > > > >
> > > > > +       if (!mutex_trylock(&unix_gc_mutex))
> > > > > +               return;
> > > > >         spin_lock(&unix_gc_lock);
> > > > >
> > > > > -       /* Avoid a recursive GC. */
> > > > > -       if (gc_in_progress)
> > > > > -               goto out;
> > > > > -
> > > > > -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> > > > > -       WRITE_ONCE(gc_in_progress, true);
> > > > > -
> > > > >         /* First, select candidates for garbage collection.  Only
> > > > >          * in-flight sockets are considered, and from those only =
ones
> > > > >          * which don't have any external reference.
> > > > > @@ -325,11 +320,12 @@ void unix_gc(void)
> > > > >         /* All candidates should have been detached by now. */
> > > > >         BUG_ON(!list_empty(&gc_candidates));
> > > > >
> > > > > -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> > > > > -       WRITE_ONCE(gc_in_progress, false);
> > > > > -
> > > > > -       wake_up(&unix_gc_wait);
> > > > > -
> > > > > - out:
> > > > >         spin_unlock(&unix_gc_lock);
> > > > > +       mutex_unlock(&unix_gc_mutex);
> > > > > +}
> > > > > +
> > > > > +/* The external entry point: unix_gc() */
> > > > > +void unix_gc(void)
> > > > > +{
> > > > > +       __unix_gc(NULL);
> > > > >  }
> > > > > --
> > > >
> > > > This one results in less overall load than Kuniyuki's proposed patc=
h
> > > > with my repro:
> > > >
> > > > * https://lore.kernel.org/netdev/20231020220511.45854-1-kuniyu@amaz=
on.com/
> > > >
> > > > My guess is that's because my repro is the one that is getting pena=
lized there.
> > >
> > > Thanks for testing, and yes.
> > >
> > > It would be good to split the repro to one offender and one normal
> > > process, run them on different users, and measure load on the normal
> > > process.
> > >
> > >
> > > > There's still a lot work done in unix_release_sock here, where GC r=
uns
> > > > as long as you have any fds inflight:
> > > >
> > > > * https://elixir.bootlin.com/linux/v6.1/source/net/unix/af_unix.c#L=
670
> > > >
> > > > Perhaps it can be improved.
> > >
> > > Yes, it also can be done async by worker as done in my first patch.
> > > I replaced schedule_work() with queue_work() to avoid using system_wq
> > > as gc could take long.
> > >
> > > Could you try this ?
> >
> > Apologies for the long wait, I was OOO.
> >
> > A bit of a problem here is that unix_gc is called unconditionally in
> > unix_release_sock.
>
> unix_release_sock() calls gc only when there is a inflight socket.
>
>
> > It's done asynchronously now and it can only
> > consume a single CPU with your changes, which is a lot better than
> > before. I am wondering if we can still do better to only trigger gc
> > when it touches unix sockets that have inflight fds.
> >
> > Commit 3c32da19a858 ("unix: Show number of pending scm files of
> > receive queue in fdinfo") added "struct scm_stat" to "struct
> > unix_sock", which can be used to check for the number of inflight fds
> > in the unix socket. Can we use that to drive the GC?
>
> I don't think the stat is useful to trigger gc.  Unless the receiver
> is accessible via sendmsg(), it's not a gc candidate and we need not
> care about its stats about valid FDs that are ready to be processed
> and never cleaned up by gc until close().

I'm not quite following why it's not useful, could you elaborate? The
GC call today is conditioned by 16k system-wide inflight unix fds:

* https://github.com/torvalds/linux/blob/v6.7-rc2/net/unix/af_unix.c#L2204
* https://github.com/torvalds/linux/blob/master/net/unix/garbage.c#L191

The only way checking for inflight fds is worse is if there non-unix
fds inflight. This can be easily alleviated by checking for non-zero
inflight fds on the socket + system-wide unix fds check, making it
better than just checking the system-wide gauge. What am I missing?

> > I think we can:
> >
> > * Trigger unix_gc from unix_release_sock if there's a non-zero number
> > of inflight fds in the socket being destroyed.
>
> This is the case of now.

It's not, unless I'm misunderstanding something. The check today is
for any inflight fds _system-wide_:

* https://github.com/torvalds/linux/blob/v6.7-rc2/net/unix/af_unix.c#L684-L=
685

My suggestion is to check this _per socket_, making sockets that do
not pass any fds (likely an overwhelming majority) unaffected.

> > * Trigger wait_for_unix_gc from the write path only if the write
> > contains fds or if the socket contains inflight fds. Alternatively, we
> > can run gc at the end of the write path and only check for inflight
> > fds on the socket there, which is probably simpler.
>
> I don't think it's better to call gc at the end of sendmsg() as there
> would be small chance to consume memory compared to running gc in the
> beginning of sendmsg().

There is no guarantee that GC frees any memory either way.

> > GC only applies to unix sockets inflight of other unix sockets, so GC
> > can still affect sockets passing regular fds around, but it wouldn't
> > affect non-fd-passing unix sockets, which are usually in the data
> > path.
>
> I think we can run gc only when scm contains AF_UNIX sockets by tweaking
> a little bit scm processing.

That's even better than what I'm proposing (all inflight fds -> just
unix inflight fds being the difference), but probably requires a bit
more code changes. I'm happy to test a patch when you have it.

> > This way we don't have to check for per-user inflight fds, which means
> > that services running as "nobody" wouldn't be punished for other
> > services running as "nobody" screwing up.
>
> If we do not check user, a user could send 16000 AF_UNIX fds and
> other innocent users sending fds must wait gc.

In my proposal we check for infight fds per socket and if there are
none, there is no GC at all.

> I think isolating users would make more sense so you can sandbox
> a suspicious process.

Sure, but that's somewhat beside the point. Ideally things should work
well outside the box.

> Probably we can move flush_work() in the preceding if.  Then, the
> number of gc invocation in the "nobody" case is the same as before.

Just to make sure I get my point across: I want to have no GC if a
socket does not possibly contribute any garbage to be collected. If my
program just passes bytes back and forth and churns through unix
sockets, it shouldn't be penalized with GC and it shouldn't try to
schedule GC, no matter what else is going on in the system

Hope this makes sense.

> ---8<---
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 51f30f89bacb..74fc208c8858 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -198,12 +198,13 @@ void wait_for_unix_gc(void)
>          * Paired with the WRITE_ONCE() in unix_inflight(),
>          * unix_notinflight().
>          */
> -       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
> +       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC) {
>                 queue_work(system_unbound_wq, &unix_gc_work);
>
> -       /* Penalise senders of not-yet-received-fd */
> -       if (READ_ONCE(user->unix_inflight))
> -               flush_work(&unix_gc_work);
> +               /* Penalise senders of not-yet-received-fd */
> +               if (READ_ONCE(user->unix_inflight))
> +                       flush_work(&unix_gc_work);
> +       }
>  }
>
>  static void __unix_gc(struct work_struct *work)
> ---8<---
>
>
> >
> > Does this sound like a reasonable approach?
> >
> [...]
> > > -static bool gc_in_progress;
> > > -#define UNIX_INFLIGHT_TRIGGER_GC 16000
> > > +#define UNIX_INFLIGHT_TRIGGER_GC 16
> >
> > It's probably best to keep it at 16k.
>
> Oops, this is just for testing on my local machine easily :p
>
> Anyway, I'll post a formal patch this week.
>
> Thanks!
