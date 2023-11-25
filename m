Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B47F8BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjKYOrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:47:20 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C888C6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:47:26 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso2600102276.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700923645; x=1701528445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbBDsUYFRBbpaPGcvLn4ZOnFdI0AYXZ3B/wevF5TUtg=;
        b=C7fevQaKpfPHGnPqXI6umr9h8FIA2PwoLCLMhZ0keu6Zd9i1n+Pmw1gz9F9QB8Nu1S
         S2ozkK3ozg1Wlv2yqslIOCPPYu+JZaL7O0gNmJ9bZErzJmwQFHy3fbEZi999H4Cwn9+0
         z/Bdz2KveDUeVtLEV8yXqQgeq+b8YROpjStqpQGy5h+0MfX38M8hqh8vKto4afKXAFxl
         8wKVpNFTAUViVGb4t2lRUhl8OsWv9PNIJ3DkCjfByYQgiWNQwzYaXqMPAmcNvSEljNWk
         nTz5HI5LcumNFtPgU3OTs0m2bKUiuItSHrgcPZLOg5TN/lF5ayaKAonocL5aaBWdVwil
         Aiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700923645; x=1701528445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbBDsUYFRBbpaPGcvLn4ZOnFdI0AYXZ3B/wevF5TUtg=;
        b=r36YLbGMEV0LhUf/a0OYuVnzMDVV0xnmHXuPlN9fYrQnp8ifLUngEDvECqXJ+xmC2R
         pkjfvw6nCtBLdQ8s7RPiAJfuK2PcopYXFQDxPjjTd7YTI0ZLRuPZFpy1urkrk8eazy4z
         /BThMwWcLDR2V7PqyXpwnzFOH3kTAYyY6eAYvJVSRoGohcmKz+ziiSrcnLRt9+TJo1tj
         SqZaWkiiHYnXwr/56fnFLB+i7x8fx4is5Q9rAQ/rf3m0M+e46TMMfW7liZx53XDbaqiS
         Sm4xliGF/SCI1I3Gz63opes62DIVe7GHddlWhad2p6Wr1gWVaFIYlYzj0M/Mz2bsNlbg
         Z+rA==
X-Gm-Message-State: AOJu0YwJ5z3kNh4lWNDznP6ZhKlmu7GBB8xxaiMSVO8jZTHpM6M9ek46
        q10A+vWikAiyVmFZ04xmAcaiK72Zf2JrEZjWHbSd
X-Google-Smtp-Source: AGHT+IEdYo7torc3WD8zzpy2vPVUODcvVvdvOHPOf8VVQ1q+Lx6kGrInycI6vKwkUYmT5ZwmLxh62dX5f0eEi7ztDnA=
X-Received: by 2002:a25:bf8b:0:b0:daf:76da:fe2b with SMTP id
 l11-20020a25bf8b000000b00daf76dafe2bmr5842914ybk.10.1700923645597; Sat, 25
 Nov 2023 06:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 25 Nov 2023 09:47:14 -0500
Message-ID: <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: Fix memory leak in netlbl_calipso_add_pass()
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Huw Davies <huw@codeweavers.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 4:25=E2=80=AFAM Gavrilov Ilia <Ilia.Gavrilov@infote=
cs.ru> wrote:
>
> If IPv6 support is disabled at boot (ipv6.disable=3D1),
> the calipso_init() -> netlbl_calipso_ops_register() function isn't called=
,
> and the netlbl_calipso_ops_get() function always returns NULL.
> In this case, the netlbl_calipso_add_pass() function allocates memory
> for the doi_def variable but doesn't free it with the calipso_doi_free().
>
> BUG: memory leak
> unreferenced object 0xffff888011d68180 (size 64):
>   comm "syz-executor.1", pid 10746, jiffies 4295410986 (age 17.928s)
>   hex dump (first 32 bytes):
>     00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000730d8770>] kmalloc include/linux/slab.h:552 [inline]
>     [<00000000730d8770>] netlbl_calipso_add_pass net/netlabel/netlabel_ca=
lipso.c:76 [inline]
>     [<00000000730d8770>] netlbl_calipso_add+0x22e/0x4f0 net/netlabel/netl=
abel_calipso.c:111
>     [<0000000002e662c0>] genl_family_rcv_msg_doit+0x22f/0x330 net/netlink=
/genetlink.c:739
>     [<00000000a08d6d74>] genl_family_rcv_msg net/netlink/genetlink.c:783 =
[inline]
>     [<00000000a08d6d74>] genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c=
:800
>     [<0000000098399a97>] netlink_rcv_skb+0x14d/0x440 net/netlink/af_netli=
nk.c:2515
>     [<00000000ff7db83b>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
>     [<000000000cf53b8c>] netlink_unicast_kernel net/netlink/af_netlink.c:=
1313 [inline]
>     [<000000000cf53b8c>] netlink_unicast+0x54b/0x800 net/netlink/af_netli=
nk.c:1339
>     [<00000000d78cd38b>] netlink_sendmsg+0x90a/0xdf0 net/netlink/af_netli=
nk.c:1934
>     [<000000008328a57f>] sock_sendmsg_nosec net/socket.c:651 [inline]
>     [<000000008328a57f>] sock_sendmsg+0x157/0x190 net/socket.c:671
>     [<000000007b65a1b5>] ____sys_sendmsg+0x712/0x870 net/socket.c:2342
>     [<0000000083da800e>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2396
>     [<000000004a9b827f>] __sys_sendmsg+0xea/0x1b0 net/socket.c:2429
>     [<0000000061b64d3a>] do_syscall_64+0x30/0x40 arch/x86/entry/common.c:=
46
>     [<00000000a1265347>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with Syzkaller
>
> Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink p=
rotocol.")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
> v2:
>   - return the error code in netlbl_calipso_add() if the variable calipso=
_hops is NULL
> v1: https://lore.kernel.org/all/20231122135242.2779058-1-Ilia.Gavrilov@in=
fotecs.ru/
>
>  net/netlabel/netlabel_calipso.c | 49 +++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 23 deletions(-)

This looks good to me, thanks!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
