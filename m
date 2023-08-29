Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D978CA38
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbjH2RHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbjH2RGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:06:55 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B41B1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:06:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso9791cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693328810; x=1693933610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs1JZELCM9fYlqqavqI6elwNwn892gP7ieGSvyrVxDg=;
        b=ZE5SF2Sshr6slyRAEXOCNAB7PhKobzGhuPwz9xxup8rmVzlOnaGWSEnZ8VZomC8q9E
         mw/UCw8Pku5/BjLYFfvpuk0OB1/ohw2yjDEOZkaK/HUM3u0AckJ/W5XW7v1ldcVAWmKt
         QD6Itno4YHs1Go2XaJMKFMMvy/HfUa+hTMo16cLsVx56JniKq3BdHxL/26WVUJP18jdK
         BkAgOtPrNfWsdeq2kyjN7kPn5/8PiIPGU4FTJh5/VVbMnpMiedXbmZzi/kh8B5YzSg/f
         9D+pbd8waRZ190Dry2fDWZlejifuz3Q1ZGG6a4kcf5jo2yhh1qEarsAjLFzwjH3SdFov
         HZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328810; x=1693933610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs1JZELCM9fYlqqavqI6elwNwn892gP7ieGSvyrVxDg=;
        b=cqEq5ASMbP63Bbwzym/QTmDDI68mfCj2gfSIxBpUyxfDjLtvnbRj7NHjUkI5CgPepw
         oRLcFEVO0W+6ET3wZVYrejC1Fn4+NXXjTeEKNl//m28VcIx6mXKoLEn0YreSlYGAIZmm
         6xd7W0N7taRpYk8E5VzmjVg880n+Jjkkf/Bs5C9l1tQZl/WRS7jI5x2FFlxFaR69CYO0
         z88kcLVw9ZxEOHrRA3o9Svl0/AOLz1H6V519wAHMkMsqKDfxpvS+fEway+674TiPbwQ8
         iC8VbchheCEV9GnKjrGjpVBCX8H4iDEdgdTlDRb1kqCGuKKi3lJ8063OF9OMu/67MfrS
         QYXg==
X-Gm-Message-State: AOJu0YxpJZF64R1NAiq+c7LQMmw/9Aqi6lk7AGwzwVMNK+Kpmf/VtlP/
        gsly4ogSKu45vDPKnXk8qjeBt1QWydU0URdQs1gc3Q==
X-Google-Smtp-Source: AGHT+IGlGigV0+6V6yqnja2f6lcbZGfKUuxFs2FpgNDJ+/vW51XQQ7zwsqtI61NdMUlujJ+vR97AHdRG1KtBqIriJzI=
X-Received: by 2002:a05:622a:289:b0:410:8ba3:21c7 with SMTP id
 z9-20020a05622a028900b004108ba321c7mr327789qtw.18.1693328809588; Tue, 29 Aug
 2023 10:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010353a05fecceea0@google.com> <6144228a-799f-4de3-8483-b7add903df0c@collabora.com>
 <CANn89iJiBp9t69Y3htwGGb=pTWhjFQPxKPD1E6uSFks5NrgctA@mail.gmail.com> <ef489936-9413-4a01-a3f0-eebadfb64ff9@collabora.com>
In-Reply-To: <ef489936-9413-4a01-a3f0-eebadfb64ff9@collabora.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 29 Aug 2023 19:06:38 +0200
Message-ID: <CANn89i+dA0MfoED0zd-N_VQpnmsneNK=E=GgpsSFv=JHu7UrbQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in inet_sock_destruct (4)
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     syzbot <syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        jacob.e.keller@intel.com, jiri@nvidia.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        fishgylk@gmail.com, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 6:22=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Eric,
>
> On 8/29/23 8:19 PM, Eric Dumazet wrote:
> > On Tue, Aug 29, 2023 at 2:44=E2=80=AFPM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> On 6/23/23 7:36 PM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit: 45a3e24f65e9 Linux 6.4-rc7
> >>> git tree: upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D160cc82f2=
80000
> >>> kernel config: https://syzkaller.appspot.com/x/.config?x=3D2cbd298d0a=
ff1140
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dde6565462ab=
540f50e47
> >>> compiler: gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils=
 for Debian) 2.35.2
> >>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=3D160aacb72800=
00
> >>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=3D17c115d3280=
000
> >>>
> >>> Downloadable assets:
> >>> disk image: https://storage.googleapis.com/syzbot-assets/c09bcd4ec365=
/disk-45a3e24f.raw.xz
> >>> vmlinux: https://storage.googleapis.com/syzbot-assets/03549b639718/vm=
linux-45a3e24f.xz
> >>> kernel image: https://storage.googleapis.com/syzbot-assets/91f203e5f6=
3e/bzImage-45a3e24f.xz
> >>>
> >>> The issue was bisected to:
> >>>
> >>> commit 565b4824c39fa335cba2028a09d7beb7112f3c9a
> >>> Author: Jiri Pirko <jiri@nvidia.com>
> >>> Date: Mon Feb 6 09:41:51 2023 +0000
> >>>
> >>> devlink: change port event netdev notifier from per-net to global
> >>>
> >>> bisection log: https://syzkaller.appspot.com/x/bisect.txt?x=3D110a1a5=
b280000
> >>> final oops: https://syzkaller.appspot.com/x/report.txt?x=3D130a1a5b28=
0000
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D150a1a5b2=
80000
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> >>> Reported-by: syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com
> >>> Fixes: 565b4824c39f ("devlink: change port event netdev notifier from=
 per-net to global")
> >>>
> >>> ------------[ cut here ]------------
> >>> WARNING: CPU: 0 PID: 5025 at net/ipv4/af_inet.c:154 inet_sock_destruc=
t+0x6df/0x8a0 net/ipv4/af_inet.c:154
> >> This same warning has been spotted and reported:
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D217555
> >>
> >> Syzbot has found the same warning on 4.14, 5.15, 6.1, 6.5-rc and lates=
t
> >> mainline (1c59d383390f9) kernels. The provided reproducers (such as
> >> https://syzkaller.appspot.com/text?tag=3DReproC&x=3D15a10e8aa80000) ar=
e
> >> reproducing the same warnings on multicore (at least 2 CPUs) qemu inst=
ance.
> >
> > Can you test the following fix ?
> Just tested the fix on 1c59d383390f9, it didn't fix the warning.
>
> Please let me know if you need help in testing more.

Hmm, no more ideas from my side, thanks.

>
> > Thanks.
> >
> > diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> > index 25816e790527dbd6ff55ffb94762b5974e8144aa..1085357b30c9a0d4bf7a578=
cebf3eeddec953632
> > 100644
> > --- a/net/dccp/ipv6.c
> > +++ b/net/dccp/ipv6.c
> > @@ -377,8 +377,13 @@ static int dccp_v6_conn_request(struct sock *sk,
> > struct sk_buff *skb)
> >         if (ipv6_opt_accepted(sk, skb, IP6CB(skb)) ||
> >             np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
> >             np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
> > +               /* Only initialize ireq->pktops once.
> > +                * We must take a refcount on skb because ireq->pktops
> > +                * could be consumed immediately.
> > +                */
> >                 refcount_inc(&skb->users);
> > -               ireq->pktopts =3D skb;
> > +               if (cmpxchg(&ireq->pktopts, NULL, skb))
> > +                       refcount_dec(&skb->users);
> >         }
> >         ireq->ir_iif =3D READ_ONCE(sk->sk_bound_dev_if);
> >
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 6e86721e1cdbb8d47b754a2675f6ab1643c7342c..d45aa267473c4ab817cfda0=
6966a536718b50a53
> > 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -798,8 +798,13 @@ static void tcp_v6_init_req(struct request_sock *r=
eq,
> >              np->rxopt.bits.rxinfo ||
> >              np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
> >              np->rxopt.bits.rxohlim || np->repflow)) {
> > +               /* Only initialize ireq->pktops once.
> > +                * We must take a refcount on skb because ireq->pktops
> > +                * could be consumed immediately.
> > +                */
> >                 refcount_inc(&skb->users);
> > -               ireq->pktopts =3D skb;
> > +               if (cmpxchg(&ireq->pktopts, NULL, skb))
> > +                       refcount_dec(&skb->users);
> >         }
> >  }
>
> --
> BR,
> Muhammad Usama Anjum
