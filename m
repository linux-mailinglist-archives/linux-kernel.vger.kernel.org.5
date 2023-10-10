Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2907BF3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379429AbjJJHLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378097AbjJJHLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:11:36 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 00:11:33 PDT
Received: from smtpcmd0883.aruba.it (smtpcmd0883.aruba.it [62.149.156.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0D9A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:11:33 -0700 (PDT)
Received: from smtpclient.apple ([178.197.206.108])
        by Aruba Outgoing Smtp  with ESMTPA
        id q6suqxIxki9R4q6svqPMRa; Tue, 10 Oct 2023 09:10:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1696921830; bh=gEXjtagqpqyynIWjFMSuP5JkLJk6Z4DuAC3b0cTet3U=;
        h=Content-Type:Mime-Version:Subject:From:Date:To;
        b=NSm7/M5hQSK2qsd6hw9qO0u9abrJ+jSzYsPwirRGzfXewecsH08hOwKe1Oo8ucPsJ
         y0oyVkraU/Zrf/VeCtoDcL9S9WXWX42STnUqlYvaTcf41TsvqeX3YqjWRHLWc17Aoe
         PlfmuDZHldPdW4xa2mKOOoY1qD4Mkr7nM8qT/afm10d+PrKkY8zwNidg2ZbsWi4Sbk
         qknfrH/PRefhKd0Ym/TWrYiWlk2NKYvC34p8t3s8N0LYMRas+3ZzCHP3v5NlvdEGMr
         YWa8ncNxYRrJJWQBGyC7iwWjUgUpuDXPToPquMrGpRxU/LO7bweTAgsHQPKxJJDPMr
         D5ppYk9juahVQ==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
From:   Rodolfo Zitellini <rwz@xhero.org>
In-Reply-To: <3cb4bb96-1651-4179-9c32-507937282d7d@app.fastmail.com>
Date:   Tue, 10 Oct 2023 09:10:28 +0200
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
Message-Id: <DE61EEA5-D560-40B6-8F4D-22F299AC61ED@xhero.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org>
 <3cb4bb96-1651-4179-9c32-507937282d7d@app.fastmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
X-CMAE-Envelope: MS4xfHaXEfCIAhkSs0tsjb+YZNldBBGkq0Qz33d9TLc3sdp/647xEnlcFyPLsWPtHwDgl+ZnrBiZEU4PUgye4kZxtVDhPsFDW0vXeYf7+fioTb/Y1+YHM0+S
 4QYs2KC2ur50/kfdPt9XLm4Q9vF06uT32m3oGSwtJqzasFX4TOuiwQmiAdWTtr/rbSJWo/LnZDmzUYpucj/LRQDbXs2e2Cmuou2RB6tBCODnxN4FzycSM2+o
 j865lcv6ukBr3FB8mg9c7tqJ9vjnKNRsMwujPZR9gkVBKwm+1d4+L5v0NYHAbCTbgMyefVEPjekvnVbMR30K2GXjs/Pi5YAy898ye14B8Fw/cDqnTlcJPyM9
 CAGSRnWNDcfA/WI9tCF2011rhbEPvAZTiPscfjhS2HGj5+bQMjE/srGP/xoeN/196/4EKvnsvJjpg26zFXjYc7ps1AUQqtXalMlWgHWvrJXDpYNvWzcnm9oC
 1E5G26PirT+aduxDVnBQh1aGXGx7WcS28KPKy9bUPqVVMvm6GJ0Gcn3Ysr33ZmlyfgE6doYUoIrwYgmZwBEUWOQ3Imci6z9b3J1FqcdGogdYreeS95iYBVqS
 SMGBbDSxA4519nsLop0Wo3ppOIjDyODNtIX4eCLTyiXD9g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 9 ott 2023, alle ore 19:29, Arnd Bergmann <arnd@arndb.de> ha =
scritto:
>=20
> On Mon, Oct 9, 2023, at 18:49, Rodolfo Zitellini wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>=20
>>> The last localtalk driver is gone now, and ppp support was never =
fully
>>> merged, so clean up the appletalk code by removing the obvious dead
>>> code paths.
>>>=20
>>> Notably, this removes one of the two callers of the old =
.ndo_do_ioctl()
>>> callback that was abused for getting device addresses and is now
>>> only used in the ieee802154 subsystem, which still uses the same =
trick.
>>>=20
>>> The include/uapi/linux/if_ltalk.h header might still be required
>>> for building userspace programs, but I made sure that debian code
>>> search and the netatalk upstream have no references it it, so it
>>> should be fine to remove.
>>>=20
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>=20
>> Hi!
>> I=E2=80=99ve been working on a new LocalTalk interface driver for the =
last=20
>> couple months, do you think it would be possible to at least postpone=20=

>> the removal of LT a bit?
>>=20
>> It is a driver for an open source device called TashTalk=20
>> (https://github.com/lampmerchant/tashtalk), which runs on a PIC micro=20=

>> that does all the LT interfacing, and communicates back via serial to=20=

>> the host system. My driver is relatively simple and works very well=20=

>> with netatalk 2.2 (which is still maintained and still has support =
for=20
>> AppleTalk). The driver is basically complete and trsted and I was=20
>> preparing to submit a patch.
>>=20
>> Still having LocalTalk in my view has many advantages for us=20
>> enthusiasts that still want to bridge old machines to the current =
world=20
>> without modifications, for example for printing on modern printers,=20=

>> netbooting, sharing files and even tcp/ip. All this basically works =
out=20
>> of the box via the driver, Linux and available userspace tools=20
>> (netatalk, macipgw).
>>=20
>> The old ISA cards supported by COPS were basically unobtanium even 20=20=

>> years ago, but the solution of using a PIC and a serial port is very=20=

>> robust and much more furure-proof. We also already have a device that=20=

>> can interface a modern machine directly via USB to LocalTalk.
>>=20
>> The development of the TashTalk has been also extensively discussed =
on=20
>> thr 68KMLA forum=20
>> =
(https://68kmla.org/bb/index.php?threads/modtashtalk-lt0-driver-for-linux.=
45031/)
>>=20
>> I hope the decision to remove LocalTalk can be reconsidered at least=20=

>> for the time being so there is a chance to submit a new, modern =
device=20
>> making use of this stack.
>=20
> Nothing is decided, I'm just proposing my patch as a cleanup
> for now. It would be nice to still drop the ndo_do_ioctl function
> though, at least in some form. When your driver actually makes
> it into the kernel, you can find a different method of communicating
> the address between the socket interface and the device driver.

Yes I too think it is good to remove ndo_do_ioctl, I designed the =
TashTalk driver to be a drop-in replacement for COPS mostly for =
compatibility with netatalk 2.2. My plan was to propose it like this (so =
nothing else needed to be changed) and the propose some patches in the =
kernel part and userspace part (netatalk).

> I can see a few ways this could work out:
>=20
> - add a custom callback pointer to struct atalk_iface to
>  get and set the address for phase1 probing instead of going
>  through the ioctl

This was my initial thought, at least for the moment, mostly to keep =
netatalk happy and make sure I don=E2=80=99t break other stuff that =
makes assumptions on how the address probing worked. There are other =
bits I would like to improve, for example tcpdump (which parses =
correctly appetalk packets!) is broken in the current implementation.

> - rewrite the probing logic in aarp.c more widely, and improve
>  the userspace interface in the process by introducing a netlink
>  interface

This is sorta the =E2=80=9Csecond step=E2=80=9D I was planning, I think =
the logic for probing could be redesigned and simplified (it also does =
not work 100% correctly), and it could be a good chance to improve the =
interface with netatalk too.

> - Move your entire driver into userspace and go to the kernel
>  using tun/tap. This has the added benefit of avoiding a lot
>  of the complexity of the tty line discipline code you have.

We had some discussion too if to just make the lt an userspace stack, I =
personally like how it is currently implemented because existing code =
can run basically without modification.

I would propose at this stage to change the TashTalk driver to remove =
ndo_do_ioctl and to use a custom callback, if this ok.

Many thanks,
Rodolfo

