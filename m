Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379E3784233
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjHVNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjHVNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:38:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9F6CEB;
        Tue, 22 Aug 2023 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692711460; x=1693316260; i=aloisio@gmx.com;
 bh=vZFe/YhVzCzHLRdN+xZuTY/bWnwviEA2Erl9M4goUb8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OzgRvSZxWKZp90FIuHh5nMh6MbyTU53dV5VZcZyStuzQKYnbkzvsY7hOKUBZoy2bbUXBG+e
 f65tA5amKzk1xO5F9iHEotMY8A4M/DkkMemblrh3zctllPaFaaJwMcxKWxjH4YBev5YmlFJcr
 GSLCc3C5FlSikvEwDiq6GQXHL/Knkm0XCIiACJUz8gYfmjXJOpTPkZWMMfQfak2YbS2k8nQda
 k24Y1Qb6+9k6rv6hPR+f8l4WDWsKW4XlWPkstCasYzc48dXFPBVU2BNhDYOVXTlWxZD15WZMu
 ESUAnVe5iStWeHwWKWL8J8dpgNleB7FeHX0cZdiM75USf8xtQ/QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [95.252.97.2] ([95.252.97.2]) by web-mail.gmx.net
 (3c-app-mailcom-bs04.server.lan [172.19.170.170]) (via HTTP); Tue, 22 Aug
 2023 15:37:40 +0200
MIME-Version: 1.0
Message-ID: <trinity-fe969962-25e4-478a-a24f-e9ee3e9ee796-1692711460591@3c-app-mailcom-bs04>
From:   Luigi Baldoni <aloisio@gmx.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: Video glitch with Hanftek Astrometa
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 15:37:40 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ZONDguFpqRTHf_UV@debian.me>
References: <trinity-4a9cf567-5613-4ace-8e63-fa27d4450df6-1692446595564@3c-app-mailcom-bs14>
 <ZONDguFpqRTHf_UV@debian.me>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:0e8BvXOtvE1iuEHjPVjTT5ytd5rrtN3LxyUFk2drF/b5CoU9BCGtkkQ5vzN5U/lssMQm7
 8yWXqoXsXK/Bk+XKjmz6Scowb1mNUzYtuW+PbB78xWo1Kx3WvDspk3Kvi9TBFaCs0s17fV35XPaZ
 Wz444BZSlAaSwumX1u7QAA3ts0hTibg3+LOBZeWe2lTsIoLuXSW6p2n1vG8XcIm5C0OppQV+NduT
 bcl3y1ce0DzS796hMGxEHBgePCONMO925dk1sAXFtPvsdybeZIssqeOJNqMdYOLlsTLyz0hFz14+
 uU=
UI-OutboundReport: notjunk:1;M01:P0:T4otYL9uvG4=;HvfJYXOnLSM5wsCDGHnlHpAAvCh
 feVBz/NGpnkGMyL2Jju93enLcD+PqXAqJA05s60kbvuaeXGKX2Ewgz+iU7n6Bf/CM0BAHUpyq
 M47y2mRpj0TQ6Qekxl7XciJq18iDaYV6RaC0Jmg+zt5zXJPzCqocrkPWXc7nqAjfOs4ThhcmX
 QEUaXJPMOTXUzcuJ5vPpcciMmlu9tuYbJ4/vQm4XS25jJfeCOu40s525vIW9/fxPtnXiJawiO
 eqe+DnimDtYdDasXjCUJEbDP+TvdBR1h/bVqRS7RYYGbftiJ/fbptAk2n57qSBm3JtcmItLe+
 Sjwh2n+ybBUF2SDvy3Zk7Ef5mkW8b/iJCqrxJih75Du300BWA6qj/B3DBviMgKKOnoJ2p8cXt
 yBc8FQEoLGpm1UjO5lbzpvv9pStABigNr8TAxq3uVvWoV8/NKjkevYqAgYOAEH5lFHyJEpb28
 W0SkvqHaodO9UeaRSB6VamyZy+N8SkUMu6itWpm6p8QH2PxQR5nHXckAKSs8Z4d1iJWW5dM0Z
 tn3AREGOsf8vEYi/VRYhMjjXEqo+pH78f//up5FrXhzVXTmwKpp/NEVMs2iRMcVImtIvUppOU
 /60TYz4rsHH2Ezp+Nblxk2v6MmvVH6/PQ8ZcWFPO/LH+RZYFEnHQrWu4zurUw45xE02OMvzRa
 sMbGhQak1vECZyN+6EG3O4vxqYFq0yIwW5veo/nT4rpz9tgxxW0cfCIvnXuYPjZ6YGcBXtdh6
 it20vb7RwHcKPzL227vtbtA4abaVnoecuQEg/hc/Ydrqa5GDtSs0NZqMR9B7QQ8lWLWOyjrT+
 ac2B1v90E3p9pinKJ5ucho2waxyVcK015hRJVnAOpHql8=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sent: Monday, August 21, 2023 at 12:59 PM
> From: "Bagas Sanjaya" <bagasdotme@gmail.com>
>
> On Sat, Aug 19, 2023 at 02:03:15PM +0200, Luigi Baldoni wrote:
> >    Hello everyone,
> > last year I replaced my old RTL2832U/R820T DVB-T dongle (which worked
> > perfectly) and replaced it with a Hanftek Astrometa (RTL2832/CXD2837ER=
)
> > DVB-T2 one and my troubles started.
> > Every channel I tune to shows a periodic glitch, as per included sampl=
e.
> >
> > I tried the following things:
> >  * connected a regular TV set to the same antenna cable and the pictur=
e looks
> >    fine
> >  * replaced the usb cable
> >  * switched distros (from debian to arch)
> >  * installed a current kernel snapshot
> >  * replaced the minipc on which it's installed
> >  * used usbip to access the hardware from my desktop machine and teste=
d
> >    it directly with vlc, mpv and kaffeine: at best the stream was glit=
chy
> >    and at worst the app crashed
> >  * toggled every parameter available for each involved module
> >  * ran tzap directly
> >
> > None of the above made the slightest difference, therefore I'm asking =
you
> > if there's something I might have overlooked or if this is truly a bug=
.
> >
> > Video sample here, captured with tzap:
> > https://www.mediafire.com/file/qantvq916uy7o4k/rai1hd.ts/file
> > https://www.4shared.com/s/folTulDcljq
> >
>
> (also Cc: RTL2832 and media subsystem maintainers)
>
> What kernel version are you running?

6.1.38-4 on Debian stable.

> Also, can you try with different dongle (ideally with different chipset)=
?

Alas no. By the way, I noticed the Sony front end is not exactly the same =
one mentioned
in the linuxtv wiki.

And I should add, I filed a ticket on bugzilla (https://bugzilla.kernel.or=
g/show_bug.cgi?id=3D217808)
if you think that might be a better avenue to continue the discussion.

Regards

