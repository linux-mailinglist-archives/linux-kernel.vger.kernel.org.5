Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB98A7BE6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377336AbjJIQvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377772AbjJIQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:50:52 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 09:50:49 PDT
Received: from smtpdh19-su.aruba.it (smtpdh19-su.aruba.it [62.149.155.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A732EA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:50:48 -0700 (PDT)
Received: from smtpclient.apple ([77.57.21.113])
        by Aruba Outgoing Smtp  with ESMTPA
        id ptRwqOnrzNaf2ptRwqgl68; Mon, 09 Oct 2023 18:49:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1696870185; bh=gmcCaRK3zDFXeLHvSaSXDPxPLsTm44LPT6qMmASM9QQ=;
        h=Content-Type:Mime-Version:Subject:From:Date:To;
        b=iAIWShWt4QASYU9NnYUWrqJ5HQc/MIbcxe5IRAPB/egNTBRXaJXVIH01aO3EEq40b
         GVQ65kc13GZGVyVsc89CzFerDWMOOWZTRVUjZw6LhbaqDiy79O28SVb0cVgsnbbFJ2
         DmOWr3hY0Mk0NIIgz2DSx48419qhUfJl5duznYAofDm/X9Wcd6FuUqE1Idbka2QriM
         DfigWBCT2u6BW41hz6mUzz6ZZcDPOlOk6yDdkNzu1CbgvVg2yWoVYoc34Y1QirpIae
         ZgPw/cTNmYOXsiZZ1MbL9Kjw7Omt4428jpHnNslJKp3a0oKiHxy7/+BnSS6jWPJ6NP
         7zur3nvs1Ww3A==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
From:   Rodolfo Zitellini <rwz@xhero.org>
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
Date:   Mon, 9 Oct 2023 18:49:43 +0200
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
X-CMAE-Envelope: MS4xfP3cw6wZrPwgQ30qHpmEsEsj4aHRoEDgqsT7xAtkoVvLa14Scx/RmfCls41lLYVVOrlQq3GGKzZp1O6ho5NhC428DACm/3N31Io5eYUM5y9NZgfv5W6U
 PM8IzaHFQOhlV5kMwOWLB0MPpXWChaAm3dDgBT2FB1ahfAiuKg76E1B6eDmDf3Z5OtBDQafhkOf7fxee5sQDUdeZmzrQL1F60cWQNAZvOcp+wSeISEMVXcTM
 z8F6yEH6rcfYxQ+WAoXV1Vu8gYCtseFg9II3cWNkOdzyaQ4+YXcRCgF3Y9bZO4yAFMl+MbErKqjnlZYqF79f7GOG4P5ZwcVqbNutAMZUkZoD5j5puMI126LQ
 AmcL6HI21sXY5LCEQmgCsYxWOj73Y2LQrPneA7WA8Z4L21Onk2MAMjqXbRytM7VC5uoIGoYmnslCSgsji8evzX6pSl3YJ35Qyd0ojapk49u/8vHqQ6IJtq9g
 4nPods51ya2y07z2HOQTPZPWa7pET1YoV+nyw8rfuhH3DBN+5r9J8Cfw0RYYGhGANyLlsDI5zaUsZLmoW2poH9/O4h3ISuaeSX5TriVpnZV93J3mJLoHMssH
 G9+e1sjF5+iLpakXDy+ik6atGWAMJ7CP9dEBBs4uWLbvKQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The last localtalk driver is gone now, and ppp support was never fully
> merged, so clean up the appletalk code by removing the obvious dead
> code paths.
>=20
> Notably, this removes one of the two callers of the old =
.ndo_do_ioctl()
> callback that was abused for getting device addresses and is now
> only used in the ieee802154 subsystem, which still uses the same =
trick.
>=20
> The include/uapi/linux/if_ltalk.h header might still be required
> for building userspace programs, but I made sure that debian code
> search and the netatalk upstream have no references it it, so it
> should be fine to remove.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi!
I=E2=80=99ve been working on a new LocalTalk interface driver for the =
last couple months, do you think it would be possible to at least =
postpone the removal of LT a bit?

It is a driver for an open source device called TashTalk =
(https://github.com/lampmerchant/tashtalk), which runs on a PIC micro =
that does all the LT interfacing, and communicates back via serial to =
the host system. My driver is relatively simple and works very well with =
netatalk 2.2 (which is still maintained and still has support for =
AppleTalk). The driver is basically complete and trsted and I was =
preparing to submit a patch.

Still having LocalTalk in my view has many advantages for us enthusiasts =
that still want to bridge old machines to the current world without =
modifications, for example for printing on modern printers, netbooting, =
sharing files and even tcp/ip. All this basically works out of the box =
via the driver, Linux and available userspace tools (netatalk, macipgw).

The old ISA cards supported by COPS were basically unobtanium even 20 =
years ago, but the solution of using a PIC and a serial port is very =
robust and much more furure-proof. We also already have a device that =
can interface a modern machine directly via USB to LocalTalk.

The development of the TashTalk has been also extensively discussed on =
thr 68KMLA forum =
(https://68kmla.org/bb/index.php?threads/modtashtalk-lt0-driver-for-linux.=
45031/)

I hope the decision to remove LocalTalk can be reconsidered at least for =
the time being so there is a chance to submit a new, modern device =
making use of this stack.

Many Thanks,
Rodolfo Zitellini=
