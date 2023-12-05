Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56338060DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbjLEVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjLEVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:32:14 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939AAD48
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:31:32 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db548da6e3bso232422276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701811891; x=1702416691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCWlUj7m/TUVBxbveuACbE3ZhjXxRgHmisPs0nAyjOE=;
        b=COJCdoI6jSTFYAszq36g6D2WpqboTfn5ALcUwpywY94chncEGF4Zhx8pf75MmxLPzo
         ZwCp7Z6/2G09OF+WeisyAseTTjKgb6rMMbNsXExQH2qH5BOBXDRrV+myWLK1CABNV4UC
         zb2804oXsAVU6bMac6FJ1q0ZTYodqdRm5j30uvzHFvYd3Oe5P0wOFMt2lYaPnCeDHgAi
         zRpb32eUWK+6FGukiXm1UTv7k0qooljNRjMizZRL41dgLZ69N764xB5Auh/PBMqpCNQj
         APZK3V3E899zYfZbl9pNMQbGUfdZDOz2ivTkzRWuhoc+MvyBkpUkv//AeLJ5JisCWEJJ
         u7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811891; x=1702416691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCWlUj7m/TUVBxbveuACbE3ZhjXxRgHmisPs0nAyjOE=;
        b=l7LtJj6qX9pdlojOjzWJcFRs/ZYWmbnvDNLQLjF/oROtTCRwIlQQ2VQbRIHAotKS8r
         iyplLl3nJv+pUtEol9KsD33dKOQpXOpEW1GvyDGWj5yLR7vuSKYbzQMq6LiXudNf7rRa
         7RunTieuGBoJpyvD55NrAsNHvd7//bSkZEtGPeMi4sCRW+Ml0Kts//UXsy4Cz88Dz1E4
         T6E2/6KJa8MHPyFlkng/mybuKKcrqyjB/SW5JkrUspmCOJ/h2TR87Lz8OWyYkoJg5kNj
         PIy+bZHc/fDENydDjPKh7pWZESb1N5Oe1OZDb8N3SYO8JjuqEdhDR+YsbbraTsb3y3/E
         i21Q==
X-Gm-Message-State: AOJu0YzFXH4ztD37KLFQBqdWALBh2QnkRW7JkzCSPG/ces7FKCPQ1QBD
        2i901EMVIWbEQWvv+6FVhn3sNdLFYuFvvlSYaeU1
X-Google-Smtp-Source: AGHT+IHwOBCUJ7VoDCxkP/0bmnjLbDc1iTH7bsrP/zrgAjrf91uJBTPKrWd6z8h4v3WgDEBA+xmeV8A5C/Hd1wf57zg=
X-Received: by 2002:a25:f445:0:b0:db7:dacf:6f4 with SMTP id
 p5-20020a25f445000000b00db7dacf06f4mr1296574ybe.56.1701811891206; Tue, 05 Dec
 2023 13:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru> <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Dec 2023 16:31:20 -0500
Message-ID: <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 9:47=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Nov 23, 2023 at 4:25=E2=80=AFAM Gavrilov Ilia <Ilia.Gavrilov@info=
tecs.ru> wrote:
> >
> > If IPv6 support is disabled at boot (ipv6.disable=3D1),
> > the calipso_init() -> netlbl_calipso_ops_register() function isn't call=
ed,
> > and the netlbl_calipso_ops_get() function always returns NULL.
> > In this case, the netlbl_calipso_add_pass() function allocates memory
> > for the doi_def variable but doesn't free it with the calipso_doi_free(=
).
> >
> > BUG: memory leak
> > unreferenced object 0xffff888011d68180 (size 64):
> >   comm "syz-executor.1", pid 10746, jiffies 4295410986 (age 17.928s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<00000000730d8770>] kmalloc include/linux/slab.h:552 [inline]
> >     [<00000000730d8770>] netlbl_calipso_add_pass net/netlabel/netlabel_=
calipso.c:76 [inline]
> >     [<00000000730d8770>] netlbl_calipso_add+0x22e/0x4f0 net/netlabel/ne=
tlabel_calipso.c:111
> >     [<0000000002e662c0>] genl_family_rcv_msg_doit+0x22f/0x330 net/netli=
nk/genetlink.c:739
> >     [<00000000a08d6d74>] genl_family_rcv_msg net/netlink/genetlink.c:78=
3 [inline]
> >     [<00000000a08d6d74>] genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink=
.c:800
> >     [<0000000098399a97>] netlink_rcv_skb+0x14d/0x440 net/netlink/af_net=
link.c:2515
> >     [<00000000ff7db83b>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
> >     [<000000000cf53b8c>] netlink_unicast_kernel net/netlink/af_netlink.=
c:1313 [inline]
> >     [<000000000cf53b8c>] netlink_unicast+0x54b/0x800 net/netlink/af_net=
link.c:1339
> >     [<00000000d78cd38b>] netlink_sendmsg+0x90a/0xdf0 net/netlink/af_net=
link.c:1934
> >     [<000000008328a57f>] sock_sendmsg_nosec net/socket.c:651 [inline]
> >     [<000000008328a57f>] sock_sendmsg+0x157/0x190 net/socket.c:671
> >     [<000000007b65a1b5>] ____sys_sendmsg+0x712/0x870 net/socket.c:2342
> >     [<0000000083da800e>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2396
> >     [<000000004a9b827f>] __sys_sendmsg+0xea/0x1b0 net/socket.c:2429
> >     [<0000000061b64d3a>] do_syscall_64+0x30/0x40 arch/x86/entry/common.=
c:46
> >     [<00000000a1265347>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > Found by InfoTeCS on behalf of Linux Verification Center
> > (linuxtesting.org) with Syzkaller
> >
> > Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink=
 protocol.")
> > Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> > ---
> > v2:
> >   - return the error code in netlbl_calipso_add() if the variable calip=
so_hops is NULL
> > v1: https://lore.kernel.org/all/20231122135242.2779058-1-Ilia.Gavrilov@=
infotecs.ru/
> >
> >  net/netlabel/netlabel_calipso.c | 49 +++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 23 deletions(-)
>
> This looks good to me, thanks!
>
> Acked-by: Paul Moore <paul@paul-moore.com>

A quick follow-up to see if this patch was picked up by the networking
folks?  I didn't get a patchwork notification, and I don't see it in
Linus' tree, but perhaps I missed something?

--=20
paul-moore.com
