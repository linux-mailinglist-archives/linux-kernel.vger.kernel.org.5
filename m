Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E167BCD01
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344482AbjJHHSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJHHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:18:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F65B9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 00:18:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso5336a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 00:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696749508; x=1697354308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYg30R2T1VOGDusTNGMsBpmfFwzenHW5dl09bgjsszk=;
        b=29hZzSSubqYxfVxyYjz8SV9QpKeLFN0bgr4Ya+sZXnTTSgPrtDzjbASki3g5XF9Ey7
         TioHQSpiUmVhQhkB95GeakPkt87CaYqrPeZ7hSUYq0m6u+YAP1MmeaVSLufptRyv5Maj
         60faYT4IE8r4oG/MFMQQrbjbnxdZ2A+e1KMzkDQOwvptAeSZrF1skVNIgRzm9bSEz1x6
         j39hGiIMB7AXOHz+nUgrk/sGEwkrwHD3Co0Zbf5xOhzIRkFSBXEt8BSTsrXhhXBp6D5Y
         V0g6SRrL4VZNRWyM68P5oZ3PN6KiolhdYV5kpfH/mLhATg5J7XVEnUsCcuEILkfc6Wgx
         /LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696749508; x=1697354308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYg30R2T1VOGDusTNGMsBpmfFwzenHW5dl09bgjsszk=;
        b=kW5lF+LX/+U9APeRnM7vNRqW0dJuaNzCnudZpBTMSMq2n3Adogr4mMTf1jy5Do1cyZ
         WY2Uq7jgxhT+okCOLAlTJC1n1Ell39RDfDvHfl+JTOSTWVDsZBhghJC0Hd6AJsnsCLeX
         rhZSPbnxLRlodrbTOH2u51O5VWvJgL6F3BMduV5i7sZaH67HskvWu6gHTwII75UHoYrA
         mReb4hB7VFuhTUeK3vMrw22ML4A9+EkM5QiPwmZjfLGmCGz9PxmV8L2twaajGqpY6UdQ
         6O6t6p6uyvMXVwK8Ylz/x/20Gpo2Be1YJ2AAiefQ4ARUTlDps1ZrzlkSvjFDUTNtn93t
         FT7g==
X-Gm-Message-State: AOJu0YxvVFjQ/3tyAvTkEEUdrbzWaP2kXZYnnZbbXm723niF2rRWJrIn
        wLx4pLZc04p/5LniIoqWOxgxKv+p/PEkEbgHJfg+6w==
X-Google-Smtp-Source: AGHT+IHbZTMKXE7Dkug2Nken3wKczcQ3I7l+F3H5smWKKa0rZz+hAaWx3/rtNodp5PHY/k0m8NGr/pZXZiwWYyfPezc=
X-Received: by 2002:a50:9b1d:0:b0:525:573c:643b with SMTP id
 o29-20020a509b1d000000b00525573c643bmr293344edi.7.1696749508479; Sun, 08 Oct
 2023 00:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev> <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev>
In-Reply-To: <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 8 Oct 2023 09:18:17 +0200
Message-ID: <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 9:00=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> wr=
ote:
>
>
> On 2023/10/8 14:45, Eric Dumazet wrote:
> > On Sat, Oct 7, 2023 at 8:34=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev=
> wrote:
> >>
> >> On 2023/10/7 13:29, Eric Dumazet wrote:
> >>> On Sat, Oct 7, 2023 at 7:06=E2=80=AFAM Yajun Deng <yajun.deng@linux.d=
ev> wrote:
> >>>> Although there is a kfree_skb_reason() helper function that can be u=
sed to
> >>>> find the reason why this skb is dropped, but most callers didn't inc=
rease
> >>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped=
.
> >>>>
> >>> ...
> >>>
> >>>> +
> >>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >>>> +{
> >>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stat=
s_alloc() */
> >>>> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->=
core_stats);
> >>>> +       unsigned long *field;
> >>>> +
> >>>> +       if (unlikely(!p))
> >>>> +               p =3D netdev_core_stats_alloc(dev);
> >>>> +
> >>>> +       if (p) {
> >>>> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p) =
+ offset);
> >>>> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
> >>> This is broken...
> >>>
> >>> As I explained earlier, dev_core_stats_xxxx(dev) can be called from
> >>> many different contexts:
> >>>
> >>> 1) process contexts, where preemption and migration are allowed.
> >>> 2) interrupt contexts.
> >>>
> >>> Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.
> >>>
> >>> I _think_ I already gave you how to deal with this ?
> >>
> >> Yes, I replied in v6.
> >>
> >> https://lore.kernel.org/all/e25b5f3c-bd97-56f0-de86-b93a3172870d@linux=
.dev/
> >>
> >>> Please try instead:
> >>>
> >>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >>> +{
> >>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats=
_alloc() */
> >>> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->c=
ore_stats);
> >>> +       unsigned long __percpu *field;
> >>> +
> >>> +       if (unlikely(!p)) {
> >>> +               p =3D netdev_core_stats_alloc(dev);
> >>> +               if (!p)
> >>> +                       return;
> >>> +       }
> >>> +       field =3D (__force unsigned long __percpu *)((__force void *)=
p + offset);
> >>> +       this_cpu_inc(*field);
> >>> +}
> >>
> >> This wouldn't trace anything even the rx_dropped is in increasing. It
> >> needs to add an extra operation, such as:
> > I honestly do not know what you are talking about.
> >
> > Have you even tried to change your patch to use
> >
> > field =3D (__force unsigned long __percpu *)((__force void *)p + offset=
);
> > this_cpu_inc(*field);
>
>
> Yes, I tested this code. But the following couldn't show anything even
> if the rx_dropped is increasing.
>
> 'sudo python3 /usr/share/bcc/tools/trace netdev_core_stats_inc'

Well, I am not sure about this, "bpftrace" worked for me.

Make sure your toolchain generates something that looks like what I got:

000000000000ef20 <netdev_core_stats_inc>:
    ef20: f3 0f 1e fa          endbr64
    ef24: e8 00 00 00 00        call   ef29 <netdev_core_stats_inc+0x9>
ef25: R_X86_64_PLT32 __fentry__-0x4
    ef29: 55                    push   %rbp
    ef2a: 48 89 e5              mov    %rsp,%rbp
    ef2d: 53                    push   %rbx
    ef2e: 89 f3                mov    %esi,%ebx
    ef30: 48 8b 87 f0 01 00 00 mov    0x1f0(%rdi),%rax
    ef37: 48 85 c0              test   %rax,%rax
    ef3a: 74 0b                je     ef47 <netdev_core_stats_inc+0x27>
    ef3c: 89 d9                mov    %ebx,%ecx
    ef3e: 65 48 ff 04 08        incq   %gs:(%rax,%rcx,1)
    ef43: 5b                    pop    %rbx
    ef44: 5d                    pop    %rbp
    ef45: c3                    ret
    ef46: cc                    int3
    ef47: e8 00 00 00 00        call   ef4c <netdev_core_stats_inc+0x2c>
ef48: R_X86_64_PLT32 .text.unlikely.+0x13c
    ef4c: 48 85 c0              test   %rax,%rax
    ef4f: 75 eb                jne    ef3c <netdev_core_stats_inc+0x1c>
    ef51: eb f0                jmp    ef43 <netdev_core_stats_inc+0x23>
    ef53: 66 66 66 66 2e 0f 1f data16 data16 data16 cs nopw 0x0(%rax,%rax,1=
)
    ef5a: 84 00 00 00 00 00
