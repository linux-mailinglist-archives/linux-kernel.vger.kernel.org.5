Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BE27FEB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjK3JGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:06:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E6AB9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:06:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso6740a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701335194; x=1701939994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji0TcYQnbQEbDh01WgrJTk7wL+caCmxVODK2KI2XUTs=;
        b=1Q3K7ilaKOumFPuY10P1rU/0/sDAXFgmQRNJZTFwCSxx2+jqebsg2rOwMNP6A6GxSh
         9KFbuMa7ng81l7C9Se9Vprqmg34U6E5OVEjPD9PZLkZooc0kljCZhSdjR6vvrbVMxIeU
         OmpxacxuBwrCMSV7IlnLsaQjKRfwDZhh5GmmAfSNulZVaUkW41GTpL4wPZchA6+Gj8jy
         IHu7eXI5oVfo2pzbTmPU7kA9OijE1NNCF6pwOXPWJyScOEYmLusk7ogvhu8CjtzNhzpK
         dbGB9JLP02JTP0uceycE1E/TXx2oJI0wllmS4GCwEvXdtv5ztPT6YZQIzEgVgWrt50Ou
         FTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335194; x=1701939994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji0TcYQnbQEbDh01WgrJTk7wL+caCmxVODK2KI2XUTs=;
        b=uWrNJKmfZLZhAk697IRI29NikhlSARPaYzKKto5e2yDjZN01n9qKlQxl23LWMoJLL/
         RMie0mK/NfOgl4gDj4eqTrEjMlOpIO1fgR0dCFpUACjCo5jXG0DoCbZ7GxQI/qKMKZma
         XGiKv5wImWqi6VR+BBBSkp/UbpqO2moA3H8idjcG5z/mix0R4T2QX2hwDGdz5Q2Ns144
         ZyWAW8IpEEnHmM3i7BpEFOJA45mVCjuj/odmbDBc0RtPDpbHxsov3gxB7hqaDxapv8d/
         /d8ILEcgJHhs/9UuKDMhhi3/C+64lYMiCHxhSmlH6cJ/Lft+kU2/dNt3DVRreIPK/3mX
         GP1g==
X-Gm-Message-State: AOJu0Yz0eKZ5e9vPGYRHzZa1o69pVLaoHTTl9pBzmUz2tORQX9g7sFMx
        Snuk1cwGUXOLd+gYbRmuMdpfegYvGocTY2E+8uzJ0sU9Fw+xHmKpGg3fLQ==
X-Google-Smtp-Source: AGHT+IH1Pp3wiHdsDAnteFWdj5kVjIBa/ymgRlPikZYTN1ohVofW7QppOL2mSsJW3mzKg0X8sA586SgCJmVWbQI+TkI=
X-Received: by 2002:a50:9f82:0:b0:54b:221d:ee1c with SMTP id
 c2-20020a509f82000000b0054b221dee1cmr80711edf.5.1701335193804; Thu, 30 Nov
 2023 01:06:33 -0800 (PST)
MIME-Version: 1.0
References: <CANn89iJxtgkKLQwmi2ZZYQP0VnrWgarJZrSL2KgkSdkO615vcw@mail.gmail.com>
 <20231130085810.4014847-1-lizhi.xu@windriver.com>
In-Reply-To: <20231130085810.4014847-1-lizhi.xu@windriver.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 30 Nov 2023 10:06:20 +0100
Message-ID: <CANn89iJT_dkpK2+9pAE376om6gDem7VKtCuALwPLc3AUWL8M8w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: page_pool: fix null-ptr-deref in page_pool_unlist
To:     Lizhi Xu <lizhi.xu@windriver.com>
Cc:     almasrymina@google.com, davem@davemloft.net, hawk@kernel.org,
        ilias.apalodimas@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 9:58=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> On Thu, 30 Nov 2023 09:29:04 +0100, Eric Dumazet <edumazet@google.com> wr=
ote:
> > > [Syz report]
> > > Illegal XDP return value 4294946546 on prog  (id 2) dev N/A, expect p=
acket loss!
> > > general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] PREEMPT SMP KASAN
> > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> > > CPU: 0 PID: 5064 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkalle=
r-00533-ga379972973a8 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 11/10/2023
> > > RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
> > > RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
> > > RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
> > > Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 =
f0 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 0=
0 75 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
> > > RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
> > > RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
> > > RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
> > > R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
> > > R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
> > > FS:  000055555717a380(0000) GS:ffff8880b9800000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000002555398 CR3: 0000000025044000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  __page_pool_destroy net/core/page_pool.c:851 [inline]
> > >  page_pool_release+0x507/0x6b0 net/core/page_pool.c:891
> > >  page_pool_destroy+0x1ac/0x4c0 net/core/page_pool.c:956
> > >  xdp_test_run_teardown net/bpf/test_run.c:216 [inline]
> > >  bpf_test_run_xdp_live+0x1578/0x1af0 net/bpf/test_run.c:388
> > >  bpf_prog_test_run_xdp+0x827/0x1530 net/bpf/test_run.c:1254
> > >  bpf_prog_test_run kernel/bpf/syscall.c:4041 [inline]
> > >  __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5402
> > >  __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
> > >  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5486
> > >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > >
> > > [Analysis]
> > > If "user.list" is initialized, the corresponding slow.netdev device m=
ust exist,
> > > so before recycling "user.list", it is necessary to confirm that the =
"slow.netdev"
> > > device is valid.
> > >
> > > [Fix]
> > > Add slow.netdev !=3D NULL check before delete "user.list".
> > >
> > > Fixes: 083772c9f972 ("net: page_pool: record pools per netdev")
> > > Reported-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
> > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> >
> >
> >
> > I sent a fix already ?
> >
> > https://lore.kernel.org/netdev/CANn89i+6BuZA6AjocG_0zTkD1u=3DpNgZc_DpZM=
O=3DyUN=3DS1cHS3w@mail.gmail.com/
> >
> > Please do not attribute to yourself work done by others, let me submit
> > the fix formally, thanks.
> What exists may not necessarily be right, and how do you prove that I saw=
 your
> fix before fixing it?
>
> You have only tested on syzbot, that's all.
> This does not mean that others should refer to you for repairs, nor does =
it
> prove that you have made repairs, and others cannot fix them.

I am just saying I sent a fix already, and that it was sent a few
minutes after the syzbot report was available.

(You included syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com in
your report, meaning that you must have seen my patch)

It is not because I sleep during night time that you can decide to use
my work without any credits.
