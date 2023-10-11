Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D87C4B43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbjJKHJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344306AbjJKHJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:09:12 -0400
Received: from smtpcmd11128.aruba.it (smtpcmd11128.aruba.it [62.149.156.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C69C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:09:07 -0700 (PDT)
Received: from smtpclient.apple ([178.197.207.108])
        by Aruba Outgoing Smtp  with ESMTPA
        id qTL5qhUPwT2S6qTL5qdYwG; Wed, 11 Oct 2023 09:09:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1697008145; bh=OFZaDkGYXLAqctRIWUHK2zLsfn3fVaLLoVZLlGB7ECs=;
        h=Content-Type:Mime-Version:Subject:From:Date:To;
        b=gSITyVIPmvPqIY+TI/ONWy67LBXZJoWfIYTOxHdmsrkexV5uF3oHAFAJWUwRfNUex
         j73xgyR6znKwSVHy1RAp9pRRozrw88QIOVSnCx0pnZ308W3zN7bQKPTIpFDOUKF/yU
         wy/ycug6rFPjx4esbpCrQuR8jY1CtwpoeH++e96ag2voR6rjA+ImmPhaOMdbGarIuu
         /8HtmJ8YEXI4okreyZ1nlUj40sCcw+IyLVSEhygfb8IUnK+Cri7sBnyzXdB0cgYD3f
         YF44wNUfGmNBsyl/LWOIegybCxd43Kb4G3qYzngFfYyBtApVWgJUahjCQSTgDuN2ry
         n+AXx1jYXy87A==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
From:   Rodolfo Zitellini <rwz@xhero.org>
In-Reply-To: <2d325867-95c9-4bff-8f24-9083c730d7ba@app.fastmail.com>
Date:   Wed, 11 Oct 2023 09:09:02 +0200
Cc:     Arnd Bergmann <arnd@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4934680-DFB5-471F-893F-32FEA9A6C26C@xhero.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org>
 <3cb4bb96-1651-4179-9c32-507937282d7d@app.fastmail.com>
 <DE61EEA5-D560-40B6-8F4D-22F299AC61ED@xhero.org>
 <2d325867-95c9-4bff-8f24-9083c730d7ba@app.fastmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
X-CMAE-Envelope: MS4xfJ+NY3qkgFTiuA0L32HFj+5woru5XqLJ2Z2A2TqBSyNMJjn9LTpk+PwA/TopQdGSgZemVGvpmWUkrlezKQaaSorGUs9nrzbOLTMBAdAjKxcCKnQ07IS3
 MjQ6AI+8VVwJBvQpEn3Xv82MRQiQmMkCGgXJ19Y7pPt0j21usz3a1MYa4c7pNjY0/woBJG3IAUohLs0BK1DVJo+2DDCNWeZhjrqBgXEzJeKtiuXAEusogHqk
 Kv/XrrLNv82hS8KstVy59xpwj+1mUKhMvH4JdRDUFsxdVUFBcvqcL0WRsGhtnfzcCdyA/TygYOtuOVrl6o5UlSbzo0ebTHp3Y8W0PaKbEdOsGLlpnixo4bm7
 KgcsyGX1T/poBUvWCUxFJPJ1fPYcC0GUM2BgGPYOuH7rm4lf6GntqES+VwZNZbwhoyq74t4PC/Pz1vtF1pC9eTeJm1utj9fotl8OGUQhd3CLuHGAGnMNwOIe
 xBDzmq8bC0rDCVKWXr26+qe3YPQHq1JbDi2yYPEerMcJigv+JZLrzidZ51bE2WiqMsfJG8guomcqd2+GcBgf6rxC/SYB7kx5sM1LnUAl8lhu4h0bEIs+zk4N
 xaQHjZItQCeMyU264BiSV9NbEwikOv9u7uR7tnhC9x80EA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 10 ott 2023, alle ore 10:15, Arnd Bergmann <arnd@arndb.de> =
ha scritto:
>=20
> On Tue, Oct 10, 2023, at 09:10, Rodolfo Zitellini wrote:
>>> Il giorno 9 ott 2023, alle ore 19:29, Arnd Bergmann <arnd@arndb.de> =
ha scritto:
>>> On Mon, Oct 9, 2023, at 18:49, Rodolfo Zitellini wrote:
>>> I can see a few ways this could work out:
>>>=20
>>> - add a custom callback pointer to struct atalk_iface to
>>> get and set the address for phase1 probing instead of going
>>> through the ioctl
>>=20
>> This was my initial thought, at least for the moment, mostly to keep=20=

>> netatalk happy and make sure I don=E2=80=99t break other stuff that =
makes=20
>> assumptions on how the address probing worked. There are other bits I=20=

>> would like to improve, for example tcpdump (which parses correctly=20
>> appetalk packets!) is broken in the current implementation.
>>=20
>>> - rewrite the probing logic in aarp.c more widely, and improve
>>> the userspace interface in the process by introducing a netlink
>>> interface
>>=20
>> This is sorta the =E2=80=9Csecond step=E2=80=9D I was planning, I =
think the logic for=20
>> probing could be redesigned and simplified (it also does not work =
100%=20
>> correctly), and it could be a good chance to improve the interface =
with=20
>> netatalk too.
>=20
> Ok, I've adapted my patch now to not actually drop the
> localtalk code for now, and sent that out, I hope that works
> for you. Even if we go with the v1 patch that removes it all,
> you could just as well start with a revert of my patch when
> you add your driver, so in the end it shouldn't make much
> of a difference.

Thank you very much! I will try to make my patch ready to be submitted =
soon, and I will add the proper reverts if needed.

>>> - Move your entire driver into userspace and go to the kernel
>>> using tun/tap. This has the added benefit of avoiding a lot
>>> of the complexity of the tty line discipline code you have.
>>=20
>> We had some discussion too if to just make the lt an userspace stack, =
I=20
>> personally like how it is currently implemented because existing code=20=

>> can run basically without modification.
>>=20
>> I would propose at this stage to change the TashTalk driver to remove=20=

>> ndo_do_ioctl and to use a custom callback, if this ok.
>=20
> It looks like you still need a custom userspace tool to set up
> the uart for your new driver, so my feeling would be that having a
> userspace bridge to implement the localtalk/uart to ethertalk/tap
> driver would actually be nicer for both usability and maintenance.
>=20
> It's not something we need to decide now though, and is up to
> you in the end.

I will experiment with this too, as it will require a bit of work to =
morph localtalk packets to ethertalk/aarp ones, and the code in the =
kernel has some specialized bits for localtalk here and there.

In any case, many thanks!
Rodolfo

