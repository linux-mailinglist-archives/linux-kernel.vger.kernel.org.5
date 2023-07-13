Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4BE752DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjGMXKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjGMXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:10:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18BBAA;
        Thu, 13 Jul 2023 16:10:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso19238281fa.3;
        Thu, 13 Jul 2023 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689289815; x=1691881815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GmlXdgctY//6EFLp5mb4ooQ/uW3kyekwB8T9pUoHMQ=;
        b=svVT9V6DInVTbCtZ3X0AR636Qs8t7S9qRV0Z61EvjvxF9Xl5YpYClQSWPiTPcasKGa
         NluXDLpndLX7LJJ3Z6xoAEhbAu9abkbJrRFthQJvJWi26ip1t1yNkSkP3WKveoD2Zl69
         CkV55WR2VxhT40EA9WU9Of6x4///LQl5YrwgKbNkmW9wLBQcbUzmxhg+W53iobHIC0TG
         bRM/oHG+kUAKI+SHm7YUYnxINYRBeZzRg8tmzZYZiDVjO2HWZvV3LnH+sJzJzL5vIh9O
         Bcgupng+exdVeNgQ0xoHlTeIHLooQyKHWa1ZQWEcPIlL+mvG3fgMzA9Stml0lb9UNEJt
         OvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689289815; x=1691881815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GmlXdgctY//6EFLp5mb4ooQ/uW3kyekwB8T9pUoHMQ=;
        b=f3zlds0EevRJNBR4h/KrFP0nYxHW50zeJPOAAn2NyZN/dELxFBnm5dk8bdvuB8ga9O
         negxNK+72eqi4iqSKD5Ym9kVXJyIHJOr4NFU9eRH4aYOMaFFTSs2QW4bknAhkWNqZb1y
         PkafXE0DRm9KEn+ucCTyBtHhZ1HnOJ72sF9XGA+wjbtZCWyX/3BZXGgmc0ALDhXeebOQ
         Wk71ijeaMD5QGFb5SRLf27Qi0O2HGkWShbXp0hiUjy6B0LwWWby6owIN6nJJTyJmk8tB
         0Vr2XndEnoBdJhtGxLIXtScABwnKPII02c7SzWq8osqqQkYgvKIL1Y4iOGQ5nv019fNp
         ZQyA==
X-Gm-Message-State: ABy/qLbwigOhDhANlp60EGDD+Oa9BAD2mJ7T65xrN+wz23k0PLziSump
        eZTXnXvS9EWN2dAWR+3ofkECZDrglBnk5j1WkNM=
X-Google-Smtp-Source: APBJJlHuGM2oO0vfKzNECyrU+Ex5pNwnmpqCr7IRXNShvMCCT3G2RAOCJZRzYGgbLlXB8Zlx0th3YvTGgNtT5yoXtog=
X-Received: by 2002:a2e:94c7:0:b0:2b6:e2aa:8fc2 with SMTP id
 r7-20020a2e94c7000000b002b6e2aa8fc2mr2201041ljh.46.1689289814589; Thu, 13 Jul
 2023 16:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689203090.git.dxu@dxuuu.xyz> <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
 <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com>
 <kwiwaeaijj6sxwz5fhtxyoquhz2kpujbsbeajysufgmdjgyx5c@f6lqrd23xr5f>
 <CAADnVQLcAoN5z+HD_44UKgJJc6t5TPW8+Ai9We0qJpau4NtEzA@mail.gmail.com> <wltfmammaf5g4gumsbna4kmwo6dtd24g472o7kgkug42dhwcy2@32fmd7q6kvg4>
In-Reply-To: <wltfmammaf5g4gumsbna4kmwo6dtd24g472o7kgkug42dhwcy2@32fmd7q6kvg4>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 Jul 2023 16:10:03 -0700
Message-ID: <CAADnVQJQZ2jQSWByVvi3N2ZOoL0XDSJzx5biSVvq=inS7OSW7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 9:33=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Wed, Jul 12, 2023 at 06:26:13PM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 12, 2023 at 6:22=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> > >
> > > Hi Alexei,
> > >
> > > On Wed, Jul 12, 2023 at 05:43:49PM -0700, Alexei Starovoitov wrote:
> > > > On Wed, Jul 12, 2023 at 4:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> w=
rote:
> > > > > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> > > > > +       case NFPROTO_IPV6:
> > > > > +               rcu_read_lock();
> > > > > +               v6_hook =3D rcu_dereference(nf_defrag_v6_hook);
> > > > > +               if (!v6_hook) {
> > > > > +                       rcu_read_unlock();
> > > > > +                       err =3D request_module("nf_defrag_ipv6");
> > > > > +                       if (err)
> > > > > +                               return err < 0 ? err : -EINVAL;
> > > > > +
> > > > > +                       rcu_read_lock();
> > > > > +                       v6_hook =3D rcu_dereference(nf_defrag_v6_=
hook);
> > > > > +                       if (!v6_hook) {
> > > > > +                               WARN_ONCE(1, "nf_defrag_ipv6_hook=
s bad registration");
> > > > > +                               err =3D -ENOENT;
> > > > > +                               goto out_v6;
> > > > > +                       }
> > > > > +               }
> > > > > +
> > > > > +               err =3D v6_hook->enable(link->net);
> > > >
> > > > I was about to apply, but luckily caught this issue in my local tes=
t:
> > > >
> > > > [   18.462448] BUG: sleeping function called from invalid context a=
t
> > > > kernel/locking/mutex.c:283
> > > > [   18.463238] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pi=
d:
> > > > 2042, name: test_progs
> > > > [   18.463927] preempt_count: 0, expected: 0
> > > > [   18.464249] RCU nest depth: 1, expected: 0
> > > > [   18.464631] CPU: 15 PID: 2042 Comm: test_progs Tainted: G
> > > > O       6.4.0-04319-g6f6ec4fa00dc #4896
> > > > [   18.465480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
),
> > > > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > > [   18.466531] Call Trace:
> > > > [   18.466767]  <TASK>
> > > > [   18.466975]  dump_stack_lvl+0x32/0x40
> > > > [   18.467325]  __might_resched+0x129/0x180
> > > > [   18.467691]  mutex_lock+0x1a/0x40
> > > > [   18.468057]  nf_defrag_ipv4_enable+0x16/0x70
> > > > [   18.468467]  bpf_nf_link_attach+0x141/0x300
> > > > [   18.468856]  __sys_bpf+0x133e/0x26d0
> > > >
> > > > You cannot call mutex under rcu_read_lock.
> > >
> > > Whoops, my bad. I think this patch should fix it:
> > >
> > > ```
> > > From 7e8927c44452db07ddd7cf0e30bb49215fc044ed Mon Sep 17 00:00:00 200=
1
> > > Message-ID: <7e8927c44452db07ddd7cf0e30bb49215fc044ed.1689211250.git.=
dxu@dxuuu.xyz>
> > > From: Daniel Xu <dxu@dxuuu.xyz>
> > > Date: Wed, 12 Jul 2023 19:17:35 -0600
> > > Subject: [PATCH] netfilter: bpf: Don't hold rcu_read_lock during
> > >  enable/disable
> > >
> > > ->enable()/->disable() takes a mutex which can sleep. You can't sleep
> > > during RCU read side critical section.
> > >
> > > Our refcnt on the module will protect us from ->enable()/->disable()
> > > from going away while we call it.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  net/netfilter/nf_bpf_link.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.=
c
> > > index 77ffbf26ba3d..79704cc596aa 100644
> > > --- a/net/netfilter/nf_bpf_link.c
> > > +++ b/net/netfilter/nf_bpf_link.c
> > > @@ -60,9 +60,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link=
 *link)
> > >                         goto out_v4;
> > >                 }
> > >
> > > +               rcu_read_unlock();
> > >                 err =3D v4_hook->enable(link->net);
> > >                 if (err)
> > >                         module_put(v4_hook->owner);
> > > +
> > > +               return err;
> > >  out_v4:
> > >                 rcu_read_unlock();
> > >                 return err;
> > > @@ -92,9 +95,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link=
 *link)
> > >                         goto out_v6;
> > >                 }
> > >
> > > +               rcu_read_unlock();
> > >                 err =3D v6_hook->enable(link->net);
> > >                 if (err)
> > >                         module_put(v6_hook->owner);
> > > +
> > > +               return err;
> > >  out_v6:
> > >                 rcu_read_unlock();
> > >                 return err;
> > > @@ -114,11 +120,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf=
_link *link)
> > >         case NFPROTO_IPV4:
> > >                 rcu_read_lock();
> > >                 v4_hook =3D rcu_dereference(nf_defrag_v4_hook);
> > > +               rcu_read_unlock();
> > >                 if (v4_hook) {
> > >                         v4_hook->disable(link->net);
> > >                         module_put(v4_hook->owner);
> > >                 }
> > > -               rcu_read_unlock();
> > >
> > >                 break;
> > >  #endif
> > > @@ -126,11 +132,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf=
_link *link)
> > >         case NFPROTO_IPV6:
> > >                 rcu_read_lock();
> > >                 v6_hook =3D rcu_dereference(nf_defrag_v6_hook);
> > > +               rcu_read_unlock();
> >
> > No. v6_hook is gone as soon as you unlock it.
>
> I think we're protected here by the try_module_get() on the enable path.
> And we only disable defrag if enabling succeeds. The module shouldn't
> be able to deregister its hooks until we call the module_put() later.
>
> I think READ_ONCE() would've been more appropriate but I wasn't sure if
> that was ok given nf_defrag_v(4|6)_hook is written to by
> rcu_assign_pointer() and I was assuming symmetry is necessary.

Why is rcu_assign_pointer() used?
If it's not RCU protected, what is the point of rcu_*() accessors
and rcu_read_lock() ?

In general, the pattern:
rcu_read_lock();
ptr =3D rcu_dereference(...);
rcu_read_unlock();
ptr->..
is a bug. 100%.
