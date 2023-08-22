Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB638783C16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjHVIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjHVIqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:46:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59016E76;
        Tue, 22 Aug 2023 01:46:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a3de5f231so1372279b3a.0;
        Tue, 22 Aug 2023 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692693986; x=1693298786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnWJf+GXaxvqv1z6JBg0znbnaOYf5HGu0MeBIEYtwE0=;
        b=ra/EMpe0u3vp7SvOZkqVuLxdIGXpL6KyDm8YTqFQYNrXVnxzMVEgmQuiE9IggG/ybf
         W8FEVJyArvhbSma6xTYmRUDLCXmGdu5aXnbYfbhfxkHCMxulCelVPNTvj2itAmUcH7eU
         ieK6qSKbsLKJrnZpR/4McBm30qMJpK0oaMCPQ77kMJ/4GO3AgkBLa6yhy7B1ewUWKwvd
         aSzmihRSiaJFspqHPO3XAkTLnRhaiW1BsswTdIbsV+ZPa56TgK+wFX/r93I0wOk0qd+l
         HOqHa424lDgt24sLvTuhmZpHKRB45wfaRGRFIZTF1Cgz9hPW5inzIoWjMOgkxkynnhBZ
         zxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693986; x=1693298786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnWJf+GXaxvqv1z6JBg0znbnaOYf5HGu0MeBIEYtwE0=;
        b=P1pgsREC9/xKt+PEjYDU/fWRaBN2VRMZsepVRVV+bZL5vPSNCr60JAa9zDIwKbq9rr
         YKEtU6jFQc9vS/yM3wqLhAr/fIXccIxVVGLkBxduA0pTzyaNu3WQ4xdajP5lDAoX1nJe
         rk7Y9xd1oxcZVzXiiTdZWPaZMoW2eESRU3pcEW0iAE4VDgsAUWgKbMCEi86rFsBrxNi+
         97W01zR2nIEBK9ftUNN5q4tYcr6NV5nDrhKPJeM60qkkw/+uGPS8MQTiawubIKEMQ3ca
         1+KAzBGlcDKljz6Z+5H7NOa5FiA/pEihKeGGOonp1Wj6rZpKe43eR+eBd4lgtJHsiz+P
         3PVQ==
X-Gm-Message-State: AOJu0Yynoq8eBdyrQXzSXY1Vx65UICiAwakzsiT80IfRndD+xu59tica
        dz8i+rCNRsQceJnjdtRv7nY=
X-Google-Smtp-Source: AGHT+IE7PWdR7g/uISkvip2PwFaD/gg53MrNN/UQ7ogvRORaTrRL9jeYv6poMc0wd7H4NS/3wXF6zQ==
X-Received: by 2002:a05:6a20:ce9a:b0:138:1980:1e59 with SMTP id if26-20020a056a20ce9a00b0013819801e59mr5233510pzb.28.1692693986476;
        Tue, 22 Aug 2023 01:46:26 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001b54d064a4bsm8472272plz.259.2023.08.22.01.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:46:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5F6DE8BEEF4E; Tue, 22 Aug 2023 15:46:22 +0700 (WIB)
Date:   Tue, 22 Aug 2023 15:46:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     mengkanglai <mengkanglai2@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "Hideaki YOSHIFUJI" <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: Re: [BUGREPORT] slab-out-of-bounds in do_csum
Message-ID: <ZOR13ezPVcuVHh_H@debian.me>
References: <bfb7e812fb9043e78e88bbe65334b9ef@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="61ir1cIYaaJTPS/8"
Content-Disposition: inline
In-Reply-To: <bfb7e812fb9043e78e88bbe65334b9ef@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--61ir1cIYaaJTPS/8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 01:57:53AM +0000, mengkanglai wrote:
> Hello:
>   I am doing some fuzz test for kernel, the following bug was triggered.
>   My kernel version is 5.10.0.Have you encountered similar problems?
>   If there is a fix, please let me know.=20
>   Thank you very much.

What fuzz test?

>=20
> ----------------------------------------------
> BUG: KASAN: slab-out-of-bounds in do_csum+0x3e9/0x400 usr/src/kernels/lin=
ux-5.10.0-136.12.0.86/arch/x86/lib/csum-partial_64.c:103
> Read of size 4 at addr ffff88801f183aa0 by task syz-executor.2/19784
>=20
> CPU: 0 PID: 19784 Comm: syz-executor.2 Tainted: G        W  OE     5.10.0=
-136.12.0.86.x86_64 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubunt=
u1.1 04/01/2014
> Call Trace:
>  __dump_stack usr/src/kernels/linux-5.10.0-136.12.0.86/lib/dump_stack.c:7=
7 [inline]
>  dump_stack+0xbe/0xfd usr/src/kernels/linux-5.10.0-136.12.0.86/lib/dump_s=
tack.c:118
>  print_address_description.constprop.0+0x19/0x170 usr/src/kernels/linux-5=
=2E10.0-136.12.0.86/mm/kasan/report.c:382
>  __kasan_report.cold+0x6c/0x84 usr/src/kernels/linux-5.10.0-136.12.0.86/m=
m/kasan/report.c:542
>  kasan_report+0x3a/0x50 usr/src/kernels/linux-5.10.0-136.12.0.86/mm/kasan=
/report.c:559
>  do_csum+0x3e9/0x400 usr/src/kernels/linux-5.10.0-136.12.0.86/arch/x86/li=
b/csum-partial_64.c:103
>  csum_partial+0x21/0x30 usr/src/kernels/linux-5.10.0-136.12.0.86/arch/x86=
/lib/csum-partial_64.c:136
>  gso_make_checksum usr/src/kernels/linux-5.10.0-136.12.0.86/./include/lin=
ux/skbuff.h:4527 [inline]
>  __skb_udp_tunnel_segment+0xcd9/0x1710 usr/src/kernels/linux-5.10.0-136.1=
2.0.86/net/ipv4/udp_offload.c:135
>  skb_udp_tunnel_segment+0x192/0x240 usr/src/kernels/linux-5.10.0-136.12.0=
=2E86/net/ipv4/udp_offload.c:177
>  udp6_ufo_fragment+0x9a5/0xd20 usr/src/kernels/linux-5.10.0-136.12.0.86/n=
et/ipv6/udp_offload.c:37
>  ipv6_gso_segment+0x485/0xfc0 usr/src/kernels/linux-5.10.0-136.12.0.86/ne=
t/ipv6/ip6_offload.c:115
>  skb_mac_gso_segment+0x22e/0x400 usr/src/kernels/linux-5.10.0-136.12.0.86=
/net/core/dev.c:3348
>  __skb_gso_segment+0x331/0x6f0 usr/src/kernels/linux-5.10.0-136.12.0.86/n=
et/core/dev.c:3445
>  skb_gso_segment usr/src/kernels/linux-5.10.0-136.12.0.86/./include/linux=
/netdevice.h:4799 [inline]
>  ip6_finish_output_gso_slowpath_drop.constprop.0+0x3f/0x170 usr/src/kerne=
ls/linux-5.10.0-136.12.0.86/net/ipv6/ip6_output.c:169
>  __ip6_finish_output.part.0+0x6a5/0x7c0 usr/src/kernels/linux-5.10.0-136.=
12.0.86/net/ipv6/ip6_output.c:203
>  __ip6_finish_output usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/ip=
6_output.c:225 [inline]
>  ip6_finish_output+0x25c/0x310 usr/src/kernels/linux-5.10.0-136.12.0.86/n=
et/ipv6/ip6_output.c:220
>  NF_HOOK_COND usr/src/kernels/linux-5.10.0-136.12.0.86/./include/linux/ne=
tfilter.h:293 [inline]
>  ip6_output+0x1f3/0x3f0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6=
/ip6_output.c:243
>  dst_output usr/src/kernels/linux-5.10.0-136.12.0.86/./include/net/dst.h:=
453 [inline]
>  ip6_local_out+0x94/0xc0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv=
6/output_core.c:161
>  ip6tunnel_xmit usr/src/kernels/linux-5.10.0-136.12.0.86/./include/net/ip=
6_tunnel.h:160 [inline]
>  udp_tunnel6_xmit_skb+0x695/0xa90 usr/src/kernels/linux-5.10.0-136.12.0.8=
6/net/ipv6/ip6_udp_tunnel.c:109
>  geneve6_xmit_skb+0xaf8/0x1b50 usr/src/kernels/linux-5.10.0-136.12.0.86/d=
rivers/net/geneve.c:1051
>  geneve_xmit+0x2f5/0x4f0 usr/src/kernels/linux-5.10.0-136.12.0.86/drivers=
/net/geneve.c:1080
>  __netdev_start_xmit usr/src/kernels/linux-5.10.0-136.12.0.86/./include/l=
inux/netdevice.h:4849 [inline]
>  netdev_start_xmit usr/src/kernels/linux-5.10.0-136.12.0.86/./include/lin=
ux/netdevice.h:4863 [inline]
>  xmit_one.constprop.0+0x142/0x490 usr/src/kernels/linux-5.10.0-136.12.0.8=
6/net/core/dev.c:3615
>  dev_hard_start_xmit+0x8e/0x1b0 usr/src/kernels/linux-5.10.0-136.12.0.86/=
net/core/dev.c:3631
>  __dev_queue_xmit+0x1935/0x2100 usr/src/kernels/linux-5.10.0-136.12.0.86/=
net/core/dev.c:4198
>  packet_snd+0x1992/0x2a40 usr/src/kernels/linux-5.10.0-136.12.0.86/net/pa=
cket/af_packet.c:3031
>  packet_sendmsg+0x9f/0xd0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/pa=
cket/af_packet.c:3063
>  sock_sendmsg_nosec usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c=
:658 [inline]
>  sock_sendmsg usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:678 [=
inline]
>  sock_sendmsg+0x165/0x1a0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/so=
cket.c:673
>  __sys_sendto+0x21b/0x320 usr/src/kernels/linux-5.10.0-136.12.0.86/net/so=
cket.c:1993
>  __do_sys_sendto usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:20=
05 [inline]
>  __se_sys_sendto usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:20=
01 [inline]
>  __x64_sys_sendto+0xe2/0x1c0 usr/src/kernels/linux-5.10.0-136.12.0.86/net=
/socket.c:2001
>  do_syscall_64+0x33/0x40 usr/src/kernels/linux-5.10.0-136.12.0.86/arch/x8=
6/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> RIP: 0033:0x7f6bf67ac74d
> Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6bf4d19bf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f6bf68e7f80 RCX: 00007f6bf67ac74d
> RDX: 0000000000002378 RSI: 0000000020000080 RDI: 0000000000000003
> RBP: 00007f6bf681ad95 R08: 0000000000000000 R09: 00000000000002ff
> R10: 0000000004000002 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe99543bff R14: 00007ffe99543da0 R15: 00007f6bf4d19d80

Can you reproduce above on latest mainline (currently v6.5-rc7)? Also,
it seems like you have external modules installed, hence your kernel is
tainted. Please try vanilla (untainted) kernel instead, preferably by
building kernel from kernel.org sources.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--61ir1cIYaaJTPS/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOR12gAKCRD2uYlJVVFO
oxBbAQCYcNniZoIAqtdPhOgQPgceRF5pgmDQe1dVXLPcro5BugEAiN8SUUBEUZF6
KmgFAQuKZXplvjpdL4XOGRqbaxTzOgQ=
=fhYR
-----END PGP SIGNATURE-----

--61ir1cIYaaJTPS/8--
