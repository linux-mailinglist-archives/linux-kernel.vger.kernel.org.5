Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A063C7BE7F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377917AbjJIR3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376865AbjJIR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:29:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2CAB7;
        Mon,  9 Oct 2023 10:29:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3FF023200ABF;
        Mon,  9 Oct 2023 13:29:45 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 13:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696872584; x=1696958984; bh=mejXcwGQfT0tpAi1CMxM8a6dSz769zVrDpR
        e3Zv3jeE=; b=D1qWebS2k2U0evCYpdOgzBxFJcBKj9MfLvAJApIs9ldsFhjik2i
        vCBJIdon8Eqs3+n+PgdL+vqoj6lTAslaHVkX3iw28Kd1TwcU3K4uQSPZy9NLA4Ob
        bhQONNm98J79XmvvzKtZOMRzGsPrv1+PIEAWgBwvGWcq6M4oBb8XhaRdc89hJ5+7
        5c6LCFYBMwvsMU6w7xCE4uvrLl0+Z3pjW2dqjgdD+Wnen5unkF+K/KOYm1vBkwSj
        +kpbWNW5qeA5rsuRm1+ArQxZy0ambewEHHJurLPzxRXL2wQLusN8CBF5OWOdWO8v
        J/i1vmRhoLc6mfa7dGPpTM341FYs7ZbpxCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696872584; x=1696958984; bh=mejXcwGQfT0tpAi1CMxM8a6dSz769zVrDpR
        e3Zv3jeE=; b=W2zg/we/GTtRla9/22r+oZdLK3P6WruYsuSir3Ov2b2Ksug34mC
        5tcc1k+n1N1ATSRKqZiQr1qjS3hcg0p8S+giTt/xIOAUaApGh3UixMnD7ZiQpOSI
        3CO150X2VrCq0ndXVCUAXBS9AY+KXakjRFV+3otjy+TwiCdgcuaeoy22suq0R9VZ
        Q4TNLEfAYaRKBt4BerPe4RYCTaTrXeGvYmkZkapTd/Fguuh254eLY/RD3U/vF8d8
        1iTGd50Zh0mR2MMrT/JnoiDeQQZAg7p5qTOQSwNVJTpB6Xd7l4cb0XeGH1oxrNr/
        nlnaES6AtNpR8RtJ0McNY+8LrLwFDsNnb7Q==
X-ME-Sender: <xms:iDgkZaPNZSHDLM8_134cNEVQ-Z3Fog3zfTvt6FSh3Ur8OnCMlkYWNw>
    <xme:iDgkZY8cU-MalAbmr5EbwPiqdrZLtldVW78CL7cG_I7U2W9HyKViCLnn2o7AJVGwG
    lP_bkjScwwpXc6nFWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpedtffdvueffffehudekgfdvveegvedvhffgffdviefggffhveeihffhveeu
    ueetueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdeikehkmhhlrgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:iDgkZRT7P8PRwXrYNv9245jXyb3bBpGxq9KRaREWPSqnfvq3-iw22g>
    <xmx:iDgkZatLJbH4cDh2e3uarsZoxAtlC8eBqkcP2JR7hPUlWcyAX9F2tQ>
    <xmx:iDgkZSeexDbwHmwwVz22vNfzbtJl7WOvnJ9XSvh8Ppg7NVjowcdj6w>
    <xmx:iDgkZe0k3MzSqMIt-_8ayCnVR4kmDkcEtlVOjAh3DD0Av4lM6frBUg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E15C1700089; Mon,  9 Oct 2023 13:29:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <3cb4bb96-1651-4179-9c32-507937282d7d@app.fastmail.com>
In-Reply-To: <790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org>
Date:   Mon, 09 Oct 2023 19:29:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rodolfo Zitellini" <rwz@xhero.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Jakub Kicinski" <kuba@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        "Johannes Berg" <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, "Doug Brown" <doug@schmorgal.com>
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023, at 18:49, Rodolfo Zitellini wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> The last localtalk driver is gone now, and ppp support was never fully
>> merged, so clean up the appletalk code by removing the obvious dead
>> code paths.
>>=20
>> Notably, this removes one of the two callers of the old .ndo_do_ioctl=
()
>> callback that was abused for getting device addresses and is now
>> only used in the ieee802154 subsystem, which still uses the same tric=
k.
>>=20
>> The include/uapi/linux/if_ltalk.h header might still be required
>> for building userspace programs, but I made sure that debian code
>> search and the netatalk upstream have no references it it, so it
>> should be fine to remove.
>>=20
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hi!
> I=E2=80=99ve been working on a new LocalTalk interface driver for the =
last=20
> couple months, do you think it would be possible to at least postpone=20
> the removal of LT a bit?
>
> It is a driver for an open source device called TashTalk=20
> (https://github.com/lampmerchant/tashtalk), which runs on a PIC micro=20
> that does all the LT interfacing, and communicates back via serial to=20
> the host system. My driver is relatively simple and works very well=20
> with netatalk 2.2 (which is still maintained and still has support for=20
> AppleTalk). The driver is basically complete and trsted and I was=20
> preparing to submit a patch.
>
> Still having LocalTalk in my view has many advantages for us=20
> enthusiasts that still want to bridge old machines to the current worl=
d=20
> without modifications, for example for printing on modern printers,=20
> netbooting, sharing files and even tcp/ip. All this basically works ou=
t=20
> of the box via the driver, Linux and available userspace tools=20
> (netatalk, macipgw).
>
> The old ISA cards supported by COPS were basically unobtanium even 20=20
> years ago, but the solution of using a PIC and a serial port is very=20
> robust and much more furure-proof. We also already have a device that=20
> can interface a modern machine directly via USB to LocalTalk.
>
> The development of the TashTalk has been also extensively discussed on=20
> thr 68KMLA forum=20
> (https://68kmla.org/bb/index.php?threads/modtashtalk-lt0-driver-for-li=
nux.45031/)
>
> I hope the decision to remove LocalTalk can be reconsidered at least=20
> for the time being so there is a chance to submit a new, modern device=20
> making use of this stack.

Nothing is decided, I'm just proposing my patch as a cleanup
for now. It would be nice to still drop the ndo_do_ioctl function
though, at least in some form. When your driver actually makes
it into the kernel, you can find a different method of communicating
the address between the socket interface and the device driver.

I can see a few ways this could work out:

- add a custom callback pointer to struct atalk_iface to
  get and set the address for phase1 probing instead of going
  through the ioctl

- rewrite the probing logic in aarp.c more widely, and improve
  the userspace interface in the process by introducing a netlink
  interface

- Move your entire driver into userspace and go to the kernel
  using tun/tap. This has the added benefit of avoiding a lot
  of the complexity of the tty line discipline code you have.

      Arnd
