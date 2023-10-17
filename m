Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDBE7CC961
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbjJQRCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjJQRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:02:49 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE4AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:02:47 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7b652e785dbso1537117241.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697562166; x=1698166966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meOLKnGF8WJL8QjeAU5Bsneou80HA3ukuD4wiDVJQNM=;
        b=NfzfYyVm0NffAoJJqAMEjtT8MRCRd9nBcYX602Zgo7bIurVgSuPMKcxunkl8vBnE8h
         2mplbFNWx+7++gE7+gskZzjyfS0j4T8x5msriXKdfzGP0XCezBTtfQS2MGEe2SP02Wi/
         na7ekbqLO/N3AZK8eQSAhb//XfwUDrN3LofGU4+VD2IMaWGhH59JpWWH2dHIZCqlhxIV
         9DtpRKv8b/C47iNoMpleCeFBtwXrknwadi9O5zDp7ENFvWey8ul0C2g1T2SaqG4+6WYq
         3x0o52KOJicNqtyWvhAvjIH38S/qPwJg5a9pxD4OaqWX159AOSJTWIOG7gmXUzoXFSQY
         JE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562166; x=1698166966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meOLKnGF8WJL8QjeAU5Bsneou80HA3ukuD4wiDVJQNM=;
        b=CGQXx3POVxY37hYabVTLDl8k95+wsycYMuBJlbXMmQjremIvKlc+5Ui/1Zx7y1IW83
         pbr/RwwPECR1cS7YEORHaqc7tvyonL0K5LVm8yjYgLAqX47QNprDE5HtX/Nlzc+Zj2q7
         /lz/gKEk47H2BL4cA9VPc2BZDzEY9zpPkgXMQRmALQvKREd9AiBq4d69ktZGZspFf/u0
         adDwWo4TmhHrN4egBV044Ph3ADrU+dFgSHW9C2Qo4nAWd29HrzFjoAQSAWjpkBrS/wSM
         JAx+FnPFmo/OlFuFWMkP6BO7JA+5PHvJuC842K1aFXQEdJzFPSlYQVqKuIjm7mdYUWmN
         dPVA==
X-Gm-Message-State: AOJu0YxxcdlPUS5qIH/jk/Bb3Xy4DEAUIIRGTJj0JnbnGObMNViTJiIG
        D8ahSIhV1gKZieQ9ZJIzbl5EomH7Bz0cPgYG65s9hw==
X-Google-Smtp-Source: AGHT+IFKxW3fp61cEvFV4zIZHRMcfUgLA1DOw8xeH9LPsaW1WrBi9O5xa5z7KvkDVSnAv+yp6cbFNhvK7yasiSnwVGs=
X-Received: by 2002:a1f:27c6:0:b0:4a1:58e0:a0db with SMTP id
 n189-20020a1f27c6000000b004a158e0a0dbmr2632544vkn.11.1697562166128; Tue, 17
 Oct 2023 10:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
 <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
 <20230903005334.5356-1-hdanton@sina.com> <CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com>
 <20230905111059.5618-1-hdanton@sina.com> <CANn89iKvoLUy=TMxW124tiixhOBL+SsV2jcmYhH8MFh3O75mow@mail.gmail.com>
In-Reply-To: <CANn89iKvoLUy=TMxW124tiixhOBL+SsV2jcmYhH8MFh3O75mow@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Oct 2023 22:32:34 +0530
Message-ID: <CA+G9fYvskJfx3=h4oCTAyxDWO1-aG7S0hAxSk4Jm+xSx=P1dhA@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To:     Eric Dumazet <edumazet@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Netdev <netdev@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 17:55, Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Sep 5, 2023 at 1:52=E2=80=AFPM Hillf Danton <hdanton@sina.com> wr=
ote:
> >
> > On Mon, 4 Sep 2023 13:29:57 +0200 Eric Dumazet <edumazet@google.com>
> > > On Sun, Sep 3, 2023 at 5:57=3DE2=3D80=3DAFAM Hillf Danton <hdanton@si=
na.com>
> > > > On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@google.co=
m>
> > > > > --- a/net/core/dst.c
> > > > > +++ b/net/core/dst.c
> > > > > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> > > > >
> > > > >  void dst_release(struct dst_entry *dst)
> > > > >  {
> > > > > -       if (dst && rcuref_put(&dst->__rcuref))
> > > > > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > > > > +               if (!(dst->flags & DST_NOCOUNT)) {
> > > > > +                       dst->flags |=3D DST_NOCOUNT;
> > > > > +                       dst_entries_add(dst->ops, -1);
> > > >
> > > > Could this add happen after the rcu sync above?
> > > >
> > > I do not think so. All dst_release() should happen before netns remov=
al.
> >
> >         cpu2                    cpu3
> >         =3D=3D=3D=3D                    =3D=3D=3D=3D
> >         cleanup_net()           __sys_sendto
> >                                 sock_sendmsg()
> >                                 udpv6_sendmsg()
> >         synchronize_rcu();
> >                                 dst_release()
> >
> > Could this one be an exception?
>
> No idea what you are trying to say.
>
> Please give exact locations, instead of being rather vague.
>
> Note that an UDP socket can not send a packet while its netns is dismantl=
ed,
> because alive sockets keep a reference on the netns.

Gentle reminder.
This is still an open issue.

# selftests: net: pmtu.sh
# TEST: ipv4: PMTU exceptions                                         [ OK =
]
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK =
]
# TEST: ipv6: PMTU exceptions                                         [ OK =
]
# TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK =
]
# TEST: ICMPv4 with DSCP and ECN: PMTU exceptions                     [ OK =
]
# TEST: ICMPv4 with DSCP and ECN: PMTU exceptions - nexthop objects   [ OK =
]
# TEST: UDPv4 with DSCP and ECN: PMTU exceptions                      [ OK =
]
# TEST: UDPv4 with DSCP and ECN: PMTU exceptions - nexthop objects    [ OK =
]
# TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK =
]
# TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK =
]
# TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK =
]
# TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [ OK =
]
# TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK =
]
<1>[  155.820793] Unable to handle kernel paging request at virtual
address ffff247020442000
<1>[  155.821495] Mem abort info:
<1>[  155.821719]   ESR =3D 0x0000000097b58004
<1>[  155.822046]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
<1>[  155.822412]   SET =3D 0, FnV =3D 0
<1>[  155.822648]   EA =3D 0, S1PTW =3D 0
<1>[  155.822925]   FSC =3D 0x04: level 0 translation fault
<1>[  155.823317] Data abort info:
<1>[  155.823590]   Access size =3D 4 byte(s)
<1>[  155.823886]   SSE =3D 1, SRT =3D 21
<1>[  155.824167]   SF =3D 1, AR =3D 0
<1>[  155.824450]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
<1>[  155.824847]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
<1>[  155.825345] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000041d=
84000
<1>[  155.827244] [ffff247020442000] pgd=3D0000000000000000, p4d=3D00000000=
00000000
<0>[  155.828511] Internal error: Oops: 0000000097b58004 [#1] PREEMPT SMP
<4>[  155.829155] Modules linked in: vxlan ip6_udp_tunnel udp_tunnel
act_csum libcrc32c act_pedit cls_flower sch_prio veth vrf macvtap
macvlan tap crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64
fuse drm backlight dm_mod ip_tables x_tables [last unloaded:
test_blackhole_dev]
<4>[  155.832289] CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.6.0-rc6 #1
<4>[  155.832896] Hardware name: linux,dummy-virt (DT)
<4>[  155.833927] pstate: 824000c9 (Nzcv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=3D--)
<4>[  155.834496] pc : percpu_counter_add_batch+0x24/0xcc
<4>[  155.835735] lr : dst_destroy+0x44/0x1e4

Links:
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.6-rc6/t=
estrun/20613439/suite/log-parser-test/test/check-kernel-oops/log
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.6-rc6/t=
estrun/20613439/suite/log-parser-test/tests/

- Naresh
