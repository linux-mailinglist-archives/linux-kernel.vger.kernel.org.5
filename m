Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7419276A4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGaXsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGaXsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:48:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7210C7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690847301; x=1691452101; i=efault@gmx.de;
 bh=B/X8u+IvcXQCQFqb6ztmRQY2dgDvpXQ+tI4bmy1v2A0=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=czOqkV4cMKzYAGPnuRbhJL78S5mBQpCsZXJSpktq+N5kJhktImPLEAdxemPsDFq/3v4DymO
 9SJZjzC6HOTED4m+W1x3oteywk5zK/YhKatCxogqW9ytXdaaQMJZP6qyj6iv5PeK4WYRtdSkG
 bBgroZxajbKZK80kmRBQtKFxudx/7vjuBAL88z9TlOdMaND40GO64dQzGNlhWbVJdgG+tferM
 S090OMRzAoc+S9X+QqNfAoRzztR0RHWW2L+QH4axt8ocDtYteYpxy8FP2N3OocWKdFdarEMHJ
 7lNXL8UYk07e3MWkOKUa+KVgzHb4XqBIEqa0fAesFaHOXwr2UtGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer-2.fritz.box ([185.191.216.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1pvQXj1o3a-00hcrs; Tue, 01
 Aug 2023 01:48:21 +0200
Message-ID: <21777dec0233b1bc65f51764ead9a03efa9baa64.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Lorenzo Stoakes <lstoakes@gmail.com>, Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Date:   Tue, 01 Aug 2023 01:48:19 +0200
In-Reply-To: <42ad26cb6c98e028a331f5d73abf85bd965ff89d.camel@gmx.de>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
         <20230731104340.GA24767@willie-the-truck>
         <20230731115207.GB24767@willie-the-truck>
         <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
         <CAA5enKYaZ-daLeL3amr2QrQjtUdK=P8B+VbJdea7cB77QWY-eQ@mail.gmail.com>
         <42ad26cb6c98e028a331f5d73abf85bd965ff89d.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7TGgatOEl/bDAtoD6Ki+7+3VXA4x57/R55JmwMkjhNrVSROwakZ
 m/EurCu7+3gULuhsEo0uP9XxI0cEtcM/N6TUsQ7Rb0Au8v5Ze92uOh792V7UXicfIstgl79
 TRCNhWmbpaP5trNxOrlkZHLHQdrN8DJ/rtYJIatvUa+wo757v86ZN6lU4GJaIJ6eOVfIBhm
 fsvS3wYH2FoikGuAzDdkQ==
UI-OutboundReport: notjunk:1;M01:P0:UHn+NivpSFU=;7fGqFmcvYSw9ooYWYqublqxCVhE
 211DCdG7am/7WilvzwN6szAnZa2FsYClpCekU7mAL4hkKiPxV/4OMp5TGHGRniqJszmynHdoP
 mXJTWT3am1FCetJTIv7dtBEqLCT4YY+SbfU4zf4++yXY3sv/ONZPUhKDvYeksH+3yC0UHuXyP
 iSryD9o8M9AqQLodUhGiEg8W73iJQhw9zNQWaj+LlXOSmJJuSTo/kk4Xkl8lan77tJlbS01xo
 D3prdrKMrlTV8CPd1KrWX4Fu83QD97UD9CVBXDYbzdJeVOcNMp3UldHDvY4VjH910797aKeYB
 sle5nHUU5eZ2KLiVg3S3moiwqhBv+v+vodVQ1TAdzIYBH2bLfFQNTKuklVOZVuo64v+0TsTv3
 PAT93Rfq7sRFCPNyZQzAG3VE78SakjWEglqF2ShBZtpSy36MweqaBRVRNw+cCMQAuuWOX0PK3
 x+sdZKsS1g4gjYWg9KS03b823OLuwjw3F4q/33YxSAviXh5hEsu/MyHRstQubFwqiHhfOthXf
 zwCwEpgwgby9sfeQgdPoKgniuG9JcjwGByBoVEyyCTlTLeW4RBlI8OZwrXbJBN0pK+WogIJ9s
 GT815MIfk41hRPpv6Qt5I1oMx128Kirbdy3BkPkDWxIXzkNBDoCnjz5x82Fu+rO0XIKhm4Z6N
 x3wPk0VZEMJSRF0EAmYt9aE2N7Bi2mjhVOdOu+X/4C1dJ547bZTQ/XxOV1P1vkTE/g0lnJWcS
 A0rvxbhgfxZylAMa86RsJ1mMpgT3jAmQp60zHLq/0kahJ7kEpP1hgX4bGkCBz0bdwYb7s5mtN
 kmdnPY21eoNmLd0qHr04zecoM3zqvs+EIbpgpHojoKXUsy4pXtF45Osv9/FwwZ3YgDgiQAt45
 nUU+MCA1M5Y5U+eo25fLm7gTDt/lbzE5S/466zlAytKDXU14OE24OCK8PA5e5HpK1NQvtCQsz
 ayi+ZIcIgAAt5u63dZnPVLns/GU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-01 at 01:27 +0200, Mike Galbraith wrote:
> On Mon, 2023-07-31 at 22:54 +0100, Lorenzo Stoakes wrote:
> >
> > Posted a fix at:-
> >
> > https://lore.kernel.org/all/20230731215021.70911-1-lstoakes@gmail.com/
> >
> > Please give that a go and indicate whether that resolves the issue.
>
> Yup, that fixed the oops issue.

Heh, using Jiri's pick a spot from /proc/kallsyms test...

root@rpi4:~# cat /proc/kallsyms | grep ksys_read
ffffffe950baf7f8 T ksys_readahead
ffffffe950c38708 T ksys_read
root@rpi4:~# objdump -d --start-address=3D0xffffffe950c38708 --stop-addres=
s=3D0xffffffe950c3870a /proc/kcore

/proc/kcore:     file format elf64-littleaarch64


Disassembly of section load1:

ffffffe950c38708 <load1+0x238708>:
ffffffe950c38708:       Address 0xffffffe950c38708 is out of bounds.

objdump: error: /proc/kcore(load2) is too large (0x3de8000000 bytes)
objdump: Reading section load2 failed because: memory exhausted
root@rpi4:~# dmesg|tail -2
[  979.003019] __vm_enough_memory: pid: 12439, comm: objdump, not enough m=
emory for the allocation
[  979.003080] __vm_enough_memory: pid: 12439, comm: objdump, not enough m=
emory for the allocation

