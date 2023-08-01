Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3C76A594
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHAAdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHAAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:33:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3901716
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690850012; x=1691454812; i=efault@gmx.de;
 bh=dMguFfWy4OgxI+rYobUIzdQMCtuRososxvclBoLhH2I=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=LcOCvU4oHRlqwmbUTb9c9jeVZ8U2nj3+fwAFpjf8KHs/EE3cnsFOMXbjJMlta9Or1/6tCVv
 F5ufkKdVENq7L3l6oQAep0yJz9gn2PwhLE2xJkJvdKzQbPEL5v9w/nyiHp9ATnAG174lUBt3D
 pXranN6TxNzaWslmi4FzQa0EK1BUgA3GfM3lwuHM2dmAjT9DKcFk1n3dl7Dr/dKXFguh6DSat
 c1hY6uO2yzjw90JSuN5HeTyGsGBaqRoVqFFps7cVr/+2ettI/FfJCSzK0+ttVr5ln+KcpLeOm
 bbN4m4qDG+kCgAKlxkVz2+e08C0e94aYIqj2d3Hw+fl0wyYdfW3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer-2.fritz.box ([185.191.216.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1pfOKF3Zgq-00wXWB; Tue, 01
 Aug 2023 02:33:31 +0200
Message-ID: <5c9043d0bd8257c813435e35c2df2f943543d168.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Lorenzo Stoakes <lstoakes@gmail.com>, Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Date:   Tue, 01 Aug 2023 02:33:29 +0200
In-Reply-To: <21777dec0233b1bc65f51764ead9a03efa9baa64.camel@gmx.de>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
         <20230731104340.GA24767@willie-the-truck>
         <20230731115207.GB24767@willie-the-truck>
         <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
         <CAA5enKYaZ-daLeL3amr2QrQjtUdK=P8B+VbJdea7cB77QWY-eQ@mail.gmail.com>
         <42ad26cb6c98e028a331f5d73abf85bd965ff89d.camel@gmx.de>
         <21777dec0233b1bc65f51764ead9a03efa9baa64.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FsL5yHG7TZxPCzIMVHyDzorV4pGnO7X2FAj0BFCjquvjiGYHqyU
 Tlh+U81XdbHRiKunZkH8uj7IewIjCHsrXCv5P85M9Z/7ktsgk51VUYyVL9R5Rk6nyVuDldt
 E61JHrTb/KNvUlxr0+G+40FBN7Nc52WBQidjfQTbV49FokOUs4bzzxmPrUsXQogvefk8t6P
 EurQWxEWCGMVy/Dp8FBgA==
UI-OutboundReport: notjunk:1;M01:P0:s1lZVRlXDiQ=;cels49oIWoDo+VSaFbCDYxICKgY
 2sDz/Y82CcyQ9rw0rwwYNZijYkblSplZjnkNYn59yTx4u6XCqE12EgLz4zK+aGkq48sAMZjlD
 EGz3mUofuozjM4DW2cgVlu6rypvP4OqKquRE17lUGn36NxIxPgmq+c0Fz5iYVLntiE4u0kNlz
 6NjM3QZdwkWH2NhQ7SRvBawcaHDUh8nI8/mJjCHbwHjYlBLiOhtnAF40GguhQad9prw5v+AhV
 bEVijMswGrDiV/WofEWaRuhkyEulj6SvWFpt2ASaiRyMvy7D6YohvO+/QF+ZMI8k5Gnlmzv9b
 Ci8l4QwGGFCOxO6AvmdiFQTHBDtWhZbM4Y6byPsJcydxq2RCB9L4veoZkXxSGaFxY3GlKPmDA
 70+O8dIrRXiZcirkulGtFk6D+mLMNwamutvxz5G1Jk1wgzpI2rE6w7poiAjFUmFIWop7DT9yi
 HcbBXVnJmj6GrGQnFi8eyJWVDpitToLo+n1qRrMxBc4K6RZHG4GOBP1jH/VIVl7Pcqz21M2Up
 /zn6v5gRTax/mZ651eZ6ZYqf1p1mUropoo4bTfdiIW6xyULKTP++FMX83O6iRsUbpwsHXWhRl
 eCHJi9BGp9DYvNCEac4Cpe/vYNsRPicPm+ILyXw2f9NI9EGSzygB5indc5yljaodEKdXtRRZm
 l4B77YAemUzhoTRMgpWuX5jYShGu07BjOxbbsbBj9KLQt+h7gLYMprJ/OBpfHhHILahnNI4h+
 QhLZK1MhIP9A4jN9r7+0k/sW1qV/T5nBAEwimeGiDyuWR2hxoUlKvbUqaHbKAofB5JfjN/Ujc
 zT2eh3tixcozaTeaSKR8gaVC5jyrrCBYDTucjTwhsD3F5+OYYkKw4lu058t/axsCZP7BVqCkZ
 nTcRIBO2W0l6BYpAR0g4QrSulNzZV/6OBtnTJrGMlW2fwUs6w8orI3KSpfbgZpaZZ9bGNk2RS
 fnQHRUC0uYjaZpLrp5ag2OhGA4I=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-01 at 01:48 +0200, Mike Galbraith wrote:
> On Tue, 2023-08-01 at 01:27 +0200, Mike Galbraith wrote:
> > On Mon, 2023-07-31 at 22:54 +0100, Lorenzo Stoakes wrote:
> > >
> > > Posted a fix at:-
> > >
> > > https://lore.kernel.org/all/20230731215021.70911-1-lstoakes@gmail.co=
m/
> > >
> > > Please give that a go and indicate whether that resolves the issue.
> >
> > Yup, that fixed the oops issue.
>
> Heh, using Jiri's pick a spot from /proc/kallsyms test...
>
> root@rpi4:~# cat /proc/kallsyms | grep ksys_read
> ffffffe950baf7f8 T ksys_readahead
> ffffffe950c38708 T ksys_read
> root@rpi4:~# objdump -d --start-address=3D0xffffffe950c38708 --stop-addr=
ess=3D0xffffffe950c3870a /proc/kcore
>
> /proc/kcore:=C2=A0=C2=A0=C2=A0=C2=A0 file format elf64-littleaarch64
>
>
> Disassembly of section load1:
>
> ffffffe950c38708 <load1+0x238708>:
> ffffffe950c38708:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Address 0xffffffe9=
50c38708 is out of bounds.
>
> objdump: error: /proc/kcore(load2) is too large (0x3de8000000 bytes)
> objdump: Reading section load2 failed because: memory exhausted
> root@rpi4:~# dmesg|tail -2
> [=C2=A0 979.003019] __vm_enough_memory: pid: 12439, comm: objdump, not e=
nough memory for the allocation
> [=C2=A0 979.003080] __vm_enough_memory: pid: 12439, comm: objdump, not e=
nough memory for the allocation

crash> p ksys_read
ksys_read =3D $2 =3D
 {ssize_t (unsigned int, char *, size_t)} 0xffffffe950c38710 <ksys_read>
crash> dis 0xffffffe950c38710 10
0xffffffe950c38710 <ksys_read+8>:       paciasp
0xffffffe950c38714 <ksys_read+12>:      stp     x29, x30, [sp, #-64]!
0xffffffe950c38718 <ksys_read+16>:      mrs     x3, sp_el0
0xffffffe950c3871c <ksys_read+20>:      mov     x29, sp
0xffffffe950c38720 <ksys_read+24>:      stp     x21, x22, [sp, #32]
0xffffffe950c38724 <ksys_read+28>:      mov     x21, x1
0xffffffe950c38728 <ksys_read+32>:      mov     x22, x2
0xffffffe950c3872c <ksys_read+36>:      ldr     x1, [x3, #1320]
0xffffffe950c38730 <ksys_read+40>:      str     x1, [sp, #56]
0xffffffe950c38734 <ksys_read+44>:      mov     x1, #0x0                  =
      // #0
crash>

Ah, so arm64 kallsyms fibs a little.. x64_64 doesn't.

root@rpi4:~# objdump -d --start-address=3D0xffffffe950c38710 --stop-addres=
s=3D0xffffffe950c38734 /proc/kcore

/proc/kcore:     file format elf64-littleaarch64


Disassembly of section load1:

ffffffe950c38710 <load1+0x238710>:
ffffffe950c38710:       d503233f        paciasp
ffffffe950c38714:       a9bc7bfd        stp     x29, x30, [sp, #-64]!
ffffffe950c38718:       d5384103        mrs     x3, sp_el0
ffffffe950c3871c:       910003fd        mov     x29, sp
ffffffe950c38720:       a9025bf5        stp     x21, x22, [sp, #32]
ffffffe950c38724:       aa0103f5        mov     x21, x1
ffffffe950c38728:       aa0203f6        mov     x22, x2
ffffffe950c3872c:       f9429461        ldr     x1, [x3, #1320]
ffffffe950c38730:       f9001fe1        str     x1, [sp, #56]
objdump: error: /proc/kcore(load2) is too large (0x3de8000000 bytes)
objdump: Reading section load2 failed because: memory exhausted
root@rpi4:~#

