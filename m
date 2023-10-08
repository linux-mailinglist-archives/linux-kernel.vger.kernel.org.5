Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743537BCD60
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbjJHIyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbjJHIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:53:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CAE128
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:53:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso8192a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696755199; x=1697359999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3HAurHN8+gOZu2k1gt6qYEl5KYRR6FLliDA1VuqOt4=;
        b=ol0AZbARuL0jZqwp4K4OtB+6w5UCOjBEk6Im8OnH1JHlmtNP2gn7V8m7ks3Wvh1UuW
         s3GkKvA8+02c8TuACf7D/CRVF399zsq7jyZom0WbNjqZow3/+otJhdjbPTbWiQsKsl9P
         eosLMQg/Al7Y1EYXIdRCBwmqBbvZdYJ4yq2DX2YWyJ3FbQSTljuRpMUvf5M1Q/vRoXvC
         RCpwJnHJQvCBDCItrpesKbLLQuGULZP2eND1XT6YYBE9wMoDdmKpQpOejdcQyppFsxBR
         Ydq3v3xGZxrFFRj7iDwzuj0IOAPoDxAL+jhE9JSXpPSHR78mWDj3CpD3yJH5O1cmoIP9
         mr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696755199; x=1697359999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3HAurHN8+gOZu2k1gt6qYEl5KYRR6FLliDA1VuqOt4=;
        b=py6WUGVpIiNByy6W3qvryB8xwFAErUg3kW1rvqmgOzrhdPymRh6dWCkNf6Fo1v8SBZ
         rgwiBpY+2gl1jrLkID4pM+4bJYCSRI7HnpSQY1dv5b2hKd/g1smIUQYAAJIxUnbkCReI
         igwRR8gI15rDg6qKWIRXjmk46q7mXcHKVdfBdB9wTbOI34G3kz93SNqrB8xMdV4lqK7Z
         rqQrqqZYdtr6aysTmNgEEl/LtUKm6kTamQY/4aEo5hrfDMzBTDe6wS7HkrEaTN6JN2CG
         Wsu97aTbuvnXu6KCMsxLGl9tLMyL+WG9+hrFbZv7+5Ho7M2O3c+/1IFmoyEKDrEOAMud
         07ww==
X-Gm-Message-State: AOJu0YzXa87LHB9tK3USUXQzjMPenRG0o+tsSeiihrcIsETGssKuG2fv
        oUqWCkcOs4Sgeno/5SQxj9eVXb/EI9D0LcxXImq3Eg==
X-Google-Smtp-Source: AGHT+IH+hmRZeBGu0IUroxNbb/9IqfX5y5Uk+cqL6IgQk27bPxn+Wvo4BIJJpbE7qJNkzHpuxZscxUg6qC5nzRcxkI0=
X-Received: by 2002:a50:d0d7:0:b0:538:1d3b:172f with SMTP id
 g23-20020a50d0d7000000b005381d3b172fmr299192edf.3.1696755199254; Sun, 08 Oct
 2023 01:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev> <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev> <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
 <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev>
In-Reply-To: <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 8 Oct 2023 10:53:05 +0200
Message-ID: <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
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

On Sun, Oct 8, 2023 at 10:44=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
>
> On 2023/10/8 15:18, Eric Dumazet wrote:
> > On Sun, Oct 8, 2023 at 9:00=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev=
> wrote:
> >>
> >> On 2023/10/8 14:45, Eric Dumazet wrote:
> >>> On Sat, Oct 7, 2023 at 8:34=E2=80=AFAM Yajun Deng <yajun.deng@linux.d=
ev> wrote:
> >>>> On 2023/10/7 13:29, Eric Dumazet wrote:
> >>>>> On Sat, Oct 7, 2023 at 7:06=E2=80=AFAM Yajun Deng <yajun.deng@linux=
.dev> wrote:
> >>>>>> Although there is a kfree_skb_reason() helper function that can be=
 used to
> >>>>>> find the reason why this skb is dropped, but most callers didn't i=
ncrease
> >>>>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropp=
ed.
> >>>>>>
> >>>>> ...
> >>>>>
> >>>>>> +
> >>>>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >>>>>> +{
> >>>>>> +       /* This READ_ONCE() pairs with the write in netdev_core_st=
ats_alloc() */
> >>>>>> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev=
->core_stats);
> >>>>>> +       unsigned long *field;
> >>>>>> +
> >>>>>> +       if (unlikely(!p))
> >>>>>> +               p =3D netdev_core_stats_alloc(dev);
> >>>>>> +
> >>>>>> +       if (p) {
> >>>>>> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p=
) + offset);
> >>>>>> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
> >>>>> This is broken...
> >>>>>
> >>>>> As I explained earlier, dev_core_stats_xxxx(dev) can be called from
> >>>>> many different contexts:
> >>>>>
> >>>>> 1) process contexts, where preemption and migration are allowed.
> >>>>> 2) interrupt contexts.
> >>>>>
> >>>>> Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.
> >>>>>
> >>>>> I _think_ I already gave you how to deal with this ?
> >>>> Yes, I replied in v6.
> >>>>
> >>>> https://lore.kernel.org/all/e25b5f3c-bd97-56f0-de86-b93a3172870d@lin=
ux.dev/
> >>>>
> >>>>> Please try instead:
> >>>>>
> >>>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> >>>>> +{
> >>>>> +       /* This READ_ONCE() pairs with the write in netdev_core_sta=
ts_alloc() */
> >>>>> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev-=
>core_stats);
> >>>>> +       unsigned long __percpu *field;
> >>>>> +
> >>>>> +       if (unlikely(!p)) {
> >>>>> +               p =3D netdev_core_stats_alloc(dev);
> >>>>> +               if (!p)
> >>>>> +                       return;
> >>>>> +       }
> >>>>> +       field =3D (__force unsigned long __percpu *)((__force void =
*)p + offset);
> >>>>> +       this_cpu_inc(*field);
> >>>>> +}
> >>>> This wouldn't trace anything even the rx_dropped is in increasing. I=
t
> >>>> needs to add an extra operation, such as:
> >>> I honestly do not know what you are talking about.
> >>>
> >>> Have you even tried to change your patch to use
> >>>
> >>> field =3D (__force unsigned long __percpu *)((__force void *)p + offs=
et);
> >>> this_cpu_inc(*field);
> >>
> >> Yes, I tested this code. But the following couldn't show anything even
> >> if the rx_dropped is increasing.
> >>
> >> 'sudo python3 /usr/share/bcc/tools/trace netdev_core_stats_inc'
> > Well, I am not sure about this, "bpftrace" worked for me.
> >
> > Make sure your toolchain generates something that looks like what I got=
:
> >
> > 000000000000ef20 <netdev_core_stats_inc>:
> >      ef20: f3 0f 1e fa          endbr64
> >      ef24: e8 00 00 00 00        call   ef29 <netdev_core_stats_inc+0x9=
>
> > ef25: R_X86_64_PLT32 __fentry__-0x4
> >      ef29: 55                    push   %rbp
> >      ef2a: 48 89 e5              mov    %rsp,%rbp
> >      ef2d: 53                    push   %rbx
> >      ef2e: 89 f3                mov    %esi,%ebx
> >      ef30: 48 8b 87 f0 01 00 00 mov    0x1f0(%rdi),%rax
> >      ef37: 48 85 c0              test   %rax,%rax
> >      ef3a: 74 0b                je     ef47 <netdev_core_stats_inc+0x27=
>
> >      ef3c: 89 d9                mov    %ebx,%ecx
> >      ef3e: 65 48 ff 04 08        incq   %gs:(%rax,%rcx,1)
> >      ef43: 5b                    pop    %rbx
> >      ef44: 5d                    pop    %rbp
> >      ef45: c3                    ret
> >      ef46: cc                    int3
> >      ef47: e8 00 00 00 00        call   ef4c <netdev_core_stats_inc+0x2=
c>
> > ef48: R_X86_64_PLT32 .text.unlikely.+0x13c
> >      ef4c: 48 85 c0              test   %rax,%rax
> >      ef4f: 75 eb                jne    ef3c <netdev_core_stats_inc+0x1c=
>
> >      ef51: eb f0                jmp    ef43 <netdev_core_stats_inc+0x23=
>
> >      ef53: 66 66 66 66 2e 0f 1f data16 data16 data16 cs nopw 0x0(%rax,%=
rax,1)
> >      ef5a: 84 00 00 00 00 00
>
>
> I'll share some I can see it.
>
> 1.
>
> objdump -D vmlinux
>
> ffffffff81b2f170 <netdev_core_stats_inc>:
> ffffffff81b2f170:    e8 8b ea 55 ff           callq ffffffff8108dc00
> <__fentry__>
> ffffffff81b2f175:    55                       push   %rbp
> ffffffff81b2f176:    48 89 e5                 mov    %rsp,%rbp
> ffffffff81b2f179:    48 83 ec 08              sub    $0x8,%rsp
> ffffffff81b2f17d:    48 8b 87 e8 01 00 00     mov 0x1e8(%rdi),%rax
> ffffffff81b2f184:    48 85 c0                 test   %rax,%rax
> ffffffff81b2f187:    74 0d                    je ffffffff81b2f196
> <netdev_core_stats_inc+0x26>
> ffffffff81b2f189:    89 f6                    mov    %esi,%esi
> ffffffff81b2f18b:    65 48 ff 04 30           incq %gs:(%rax,%rsi,1)
> ffffffff81b2f190:    c9                       leaveq
> ffffffff81b2f191:    e9 aa 31 6d 00           jmpq ffffffff82202340
> <__x86_return_thunk>
> ffffffff81b2f196:    89 75 fc                 mov %esi,-0x4(%rbp)
> ffffffff81b2f199:    e8 82 ff ff ff           callq ffffffff81b2f120
> <netdev_core_stats_alloc>
> ffffffff81b2f19e:    8b 75 fc                 mov -0x4(%rbp),%esi
> ffffffff81b2f1a1:    48 85 c0                 test   %rax,%rax
> ffffffff81b2f1a4:    75 e3                    jne ffffffff81b2f189
> <netdev_core_stats_inc+0x19>
> ffffffff81b2f1a6:    c9                       leaveq
> ffffffff81b2f1a7:    e9 94 31 6d 00           jmpq ffffffff82202340
> <__x86_return_thunk>
> ffffffff81b2f1ac:    0f 1f 40 00              nopl   0x0(%rax)
>
>
> 2.
>
> sudo cat /proc/kallsyms | grep netdev_core_stats_inc
>
> ffffffff9c72f120 T netdev_core_stats_inc
> ffffffff9ca2676c t netdev_core_stats_inc.cold
> ffffffff9d5235e0 r __ksymtab_netdev_core_stats_inc
>
>
> 3.
>
> =E2=9E=9C  ~ ifconfig enp34s0f0
> enp34s0f0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>          inet 10.10.30.88  netmask 255.255.255.0  broadcast 10.10.30.255
>          inet6 fe80::6037:806c:14b6:f1ca  prefixlen 64  scopeid 0x20<link=
>
>          ether 04:d4:c4:5c:81:42  txqueuelen 1000  (Ethernet)
>          RX packets 29024  bytes 3118278 (3.1 MB)
>          RX errors 0  dropped 794  overruns 0  frame 0
>          TX packets 16961  bytes 2662290 (2.6 MB)
>          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>          device interrupt 29  memory 0x39fff4000000-39fff47fffff
>
> =E2=9E=9C  ~ ifconfig enp34s0f0
> enp34s0f0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>          inet 10.10.30.88  netmask 255.255.255.0  broadcast 10.10.30.255
>          inet6 fe80::6037:806c:14b6:f1ca  prefixlen 64  scopeid 0x20<link=
>
>          ether 04:d4:c4:5c:81:42  txqueuelen 1000  (Ethernet)
>          RX packets 29272  bytes 3148997 (3.1 MB)
>          RX errors 0  dropped 798  overruns 0  frame 0
>          TX packets 17098  bytes 2683547 (2.6 MB)
>          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>          device interrupt 29  memory 0x39fff4000000-39fff47fffff
>
>
> The rx_dropped is increasing.
>
>
> 4.
>
> sudo python3 /usr/share/bcc/tools/trace netdev_core_stats_inc
>
> TIME     PID     TID     COMM            FUNC
>
> (Empty, I didn't see anything.)
>
>
> 5.
>
> sudo trace-cmd record -p function -l netdev_core_stats_inc
>
> sudo trace-cmd report
>
> (Empty, I didn't see anything.)
>
>
> If I add a 'pr_info("\n");'   like:
>
> +      pr_info("\n");
>          field =3D (__force unsigned long __percpu *)((__force void *)p +
> offset);
>          this_cpu_inc(*field);
>
>
> Everything is OK. The 'pr_info("\n");' can be changed to anything else,
> but not
>
> without it.

This seems to be a bug that has nothing to do with the patch.

Try getting help from Steven maybe.
