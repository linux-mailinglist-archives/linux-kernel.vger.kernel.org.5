Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2168A78C874
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbjH2PTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjH2PT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:19:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B281AA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:19:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40c72caec5cso340501cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693322364; x=1693927164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yok9zOHaaso3upHdgoBzUMlvLWZAGMbiAVLczgzy+QQ=;
        b=QbFAVpCsAsu+MxbLJWtN17rZOZufL/GRppX+k4sM4z4csUoUzbFh+yfL1aIouUvn2N
         hhNqNS4aWzVg8gvPAsKyLKnKccpKWgN5UDPh+F7QgZUMIFOhD4qq+GnLRFqyYUPkTLlL
         5JMDn1Je0/50QOOYSZ2W2r7iW4K8K6BtEB47NqoFKGiiFuhtcuE6o6oI+f/XyqK8ozuU
         /4cWFWMni0jGONDDy8L1Ztg7igGBJjlDCkr8fAVwNUuaXzQcRJSp3d1B/C09XO7oMX4i
         eEwXq+o5oTuKVzTFHGfP+YUkOATaSrK6QQjmmG6KVqUPqcpe1h4PR0KI5ny2jIw2OI43
         CW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693322364; x=1693927164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yok9zOHaaso3upHdgoBzUMlvLWZAGMbiAVLczgzy+QQ=;
        b=iiKTl8tMn8MVGYIfzP9hjKFaGNImB8Fmqkpg0YAcDprCmbfrvHEnwgupm/qYalOFkJ
         CAl1S1bKdGVE8C3cb5mQ/i8DFTWKxrUuwrRzXCohF4UHyEweFNS73kxlvYShEiNRF2CU
         aX0JVwA0D0nKCtVs5j9di+NAFS1RnVic62W9N+6ZjJ43EYj/1mIK3A418fFzS3fgJPbi
         Sd5S3cEHc9Bpps/bsQFgjULuylz0R3hUb8+iR3jx5pFJKivydBe7vmp1S2FH74tzH2xE
         cvtjY4/xWCcyOD9YlEO8GMY3rsQI0AMG6FRiY9VAqq4O+kcFbwlmn7MjXGyXD+lsWWl/
         ux/Q==
X-Gm-Message-State: AOJu0YwFvJRr8K6/hxIbnXtX7JkyVMOKbpK5R6N2jnn/gTaK46Xn40Vb
        7QYpPxRUSyM4Rl/gga3ffUqPtrVfaPG1sCV0KcBA8A==
X-Google-Smtp-Source: AGHT+IFf0VG5PTlQt+GAvPdfLw2R2NzuOjnqKj3f9VsvfQrxRoWYJrhpfTzuDfd9gXFAUymhyFN3untbNOoz6X5VAKI=
X-Received: by 2002:ac8:5b0f:0:b0:410:4845:8d37 with SMTP id
 m15-20020ac85b0f000000b0041048458d37mr161045qtw.29.1693322363932; Tue, 29 Aug
 2023 08:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010353a05fecceea0@google.com> <6144228a-799f-4de3-8483-b7add903df0c@collabora.com>
In-Reply-To: <6144228a-799f-4de3-8483-b7add903df0c@collabora.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 29 Aug 2023 17:19:13 +0200
Message-ID: <CANn89iJiBp9t69Y3htwGGb=pTWhjFQPxKPD1E6uSFks5NrgctA@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 2:44=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 6/23/23 7:36 PM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit: 45a3e24f65e9 Linux 6.4-rc7
> > git tree: upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D160cc82f280=
000
> > kernel config: https://syzkaller.appspot.com/x/.config?x=3D2cbd298d0aff=
1140
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dde6565462ab54=
0f50e47
> > compiler: gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils f=
or Debian) 2.35.2
> > syz repro: https://syzkaller.appspot.com/x/repro.syz?x=3D160aacb7280000
> > C reproducer: https://syzkaller.appspot.com/x/repro.c?x=3D17c115d328000=
0
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c09bcd4ec365/d=
isk-45a3e24f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/03549b639718/vmli=
nux-45a3e24f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/91f203e5f63e=
/bzImage-45a3e24f.xz
> >
> > The issue was bisected to:
> >
> > commit 565b4824c39fa335cba2028a09d7beb7112f3c9a
> > Author: Jiri Pirko <jiri@nvidia.com>
> > Date: Mon Feb 6 09:41:51 2023 +0000
> >
> > devlink: change port event netdev notifier from per-net to global
> >
> > bisection log: https://syzkaller.appspot.com/x/bisect.txt?x=3D110a1a5b2=
80000
> > final oops: https://syzkaller.appspot.com/x/report.txt?x=3D130a1a5b2800=
00
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D150a1a5b280=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com
> > Fixes: 565b4824c39f ("devlink: change port event netdev notifier from p=
er-net to global")
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5025 at net/ipv4/af_inet.c:154 inet_sock_destruct+=
0x6df/0x8a0 net/ipv4/af_inet.c:154
> This same warning has been spotted and reported:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217555
>
> Syzbot has found the same warning on 4.14, 5.15, 6.1, 6.5-rc and latest
> mainline (1c59d383390f9) kernels. The provided reproducers (such as
> https://syzkaller.appspot.com/text?tag=3DReproC&x=3D15a10e8aa80000) are
> reproducing the same warnings on multicore (at least 2 CPUs) qemu instanc=
e.

Can you test the following fix ?
Thanks.

diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 25816e790527dbd6ff55ffb94762b5974e8144aa..1085357b30c9a0d4bf7a578cebf=
3eeddec953632
100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -377,8 +377,13 @@ static int dccp_v6_conn_request(struct sock *sk,
struct sk_buff *skb)
        if (ipv6_opt_accepted(sk, skb, IP6CB(skb)) ||
            np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
            np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
+               /* Only initialize ireq->pktops once.
+                * We must take a refcount on skb because ireq->pktops
+                * could be consumed immediately.
+                */
                refcount_inc(&skb->users);
-               ireq->pktopts =3D skb;
+               if (cmpxchg(&ireq->pktopts, NULL, skb))
+                       refcount_dec(&skb->users);
        }
        ireq->ir_iif =3D READ_ONCE(sk->sk_bound_dev_if);

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6e86721e1cdbb8d47b754a2675f6ab1643c7342c..d45aa267473c4ab817cfda06966=
a536718b50a53
100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -798,8 +798,13 @@ static void tcp_v6_init_req(struct request_sock *req,
             np->rxopt.bits.rxinfo ||
             np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
             np->rxopt.bits.rxohlim || np->repflow)) {
+               /* Only initialize ireq->pktops once.
+                * We must take a refcount on skb because ireq->pktops
+                * could be consumed immediately.
+                */
                refcount_inc(&skb->users);
-               ireq->pktopts =3D skb;
+               if (cmpxchg(&ireq->pktopts, NULL, skb))
+                       refcount_dec(&skb->users);
        }
 }
