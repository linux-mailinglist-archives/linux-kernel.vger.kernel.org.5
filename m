Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193D7C5E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376394AbjJKUX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjJKUXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:23:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31EC91;
        Wed, 11 Oct 2023 13:23:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E5CC85C01E9;
        Wed, 11 Oct 2023 16:23:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 16:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697055829; x=1697142229; bh=V4
        0Dm0ERM/8BGJO0YKNSpWXn7zZJAk8XtXCkCcVqzY0=; b=hRGi7XOVwKS8e7rsjX
        NZ6/5yOeiyC76EKt+OkAt5JSsR8lKu0cKPnWEwviGzRpAPg9vz9zjTwo/Aw7F4ad
        0u2k0+hJcJXv99oh5fHhE7yDXK9r4vuJPz+sl5vfSwM1u+rgjhQ/JfvtmYcmOmaT
        HAGeRW240ha9dPeYqjSeao8CBZDiHocAgOZfmkOTnkw0M+Ep8Z5iM8fifK2NFSfX
        f9ZWw964PHSlp1+XfZLYV/n/S89Fv25t0GWjU4WuYB7oikxuQPCoqOVaYd6YyxON
        hkKilbsWjingOG1O4HZ2BzdUva4896xiuRoOYrHv/wMEWrIPVmJJAZfj+T6vSHYH
        3hPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697055829; x=1697142229; bh=V40Dm0ERM/8BG
        JO0YKNSpWXn7zZJAk8XtXCkCcVqzY0=; b=ToQqibCWxH2crMF6jSlJoeGHkiwFh
        5aWhkEs/wTrIa0c+UMlXxmhJTB/DBv+R51hpiTDknZghHzF//SdEQ6Sw+wXbaRQG
        UzfXIzvwgbwWlq0a7/vKJ+bUPGCkz1arJ6QpfaXrL36hB9kWznLt+kHNU4C88bAr
        ij1ckQ8ZpbHUrWerSJJnXg64qfAZ8UokaMvXalHD4dQ3C4R7nfoMUh086XF3J91/
        itkhbQjT7AvuIE7w8It9M8knuO6I7E+c/L/VbBCNT3mAeFverH9InB8YCd9+wQkn
        1DgWdFY68aLZwkALqM9THAa9R3ayOe5aBCGJrQR4xT1DAPzvrSEeQD1dQ==
X-ME-Sender: <xms:VAQnZVz-uRX71Rud-fLOB6wYIQ0lEsuThZELWmOfmQM0SkkUJZY9aw>
    <xme:VAQnZVQRfuexdbc7Zh6RqapMppPiii2ABngpFOZ-BYyUqgJ_4AA6gU3fjhrMehmCi
    KD0PV5GhS--mPDPC1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VQQnZfUwD51L3NCq0ZMTAZcAaGiKGjQQPBq3deOJ8SH9XCYrm0Heeg>
    <xmx:VQQnZXhiM2KBuOkakp-pI0uI9zq7b2-cTxKjbEcNuMh-pEQ5pOSQtA>
    <xmx:VQQnZXCBPA3e8nZOW1RUDZ5B2Xed3zWTIf0moJcUQdLM6FvfGFKx6A>
    <xmx:VQQnZb7bOtyKcfR8jX-Rb83RjdSHleoh8AvL-xr7hpK-066QMqUBzw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CCF0EB60089; Wed, 11 Oct 2023 16:23:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <db98d9ac-7650-4a72-8eb9-4def1f17ea0d@app.fastmail.com>
In-Reply-To: <da777a72-55d1-4ee3-91c8-30afe7659f54@gmail.com>
References: <20231010155444.858483-1-arnd@kernel.org>
 <da777a72-55d1-4ee3-91c8-30afe7659f54@gmail.com>
Date:   Wed, 11 Oct 2023 22:22:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Hortmann" <philipp.g.hortmann@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>, "Kalle Valo" <kvalo@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Jakub Kicinski" <kuba@kernel.org>, "Pavel Machek" <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023, at 20:13, Philipp Hortmann wrote:
> On 10/10/23 17:27, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de> While looking at the old drivers 
>> using the obsolete .ndo_do_ioctl() callback, I found a number of network 
>> drivers that are especially obsolete, in particular for 802.11b 
>> (11Mbit/s) or even older wireless networks, using non-busmaster 
>> ISA/PCMCIA style bus interfaces, and using the legacy wireless extension 
>> ioctls rather than the netlink interfaces that were meant to replace 
>> them in 2007. All of these drivers are obsolete or orphaned. We had 
>> previously discussed this topic, but nobody ever moved the files, so I 
>> now went through the list to my best knowledge. These are the drivers 
>> that I would classify as "probably unused" by now:
>
> I found a USB WLAN Stick with a rtl8192u. I got it last Saturday and 
> found out that the firmware is missing in my ubuntu 20.04. I found it on 
> the web and fixed it. When I started the driver my computer crashed. The 
> missing part was: priv->priv_wq = alloc_workqueue("priv_wq", 0, 0); 
> Fixing this the next error was a network = kzalloc(sizeof(*network), 
> GFP_KERNEL); in wrong context with leads to a crash of my computer. 
> Fixing this leads to another issue which lets my computer crash.
>
> For me the firmware of rtl8192u was intentionally missing because of the 
> issues with the driver.
>
> What this has to do with your question?
> Can we check for missing firmware in main distributions to know which 
> drivers are considered to be old and unused?

Nice, thanks so much for testing.

I see the two bugs were introduced in 2016 by commit 1761a85c3bed3
("staging: rtl8192u: Remove create_workqueue()") and in 2021 by
commit 061e390b7c87f ("staging: rtl8192u: ieee80211_softmac: Move a
large data struct onto the heap"), so it's been broken for a while.

I also checked rtl8192e for the same bugs, but that driver
managed to avoid this even though it had the same code
originally.

Regarding the firmware files, I found:

- rtl8192e, rtl7812 and rtl8723bs are all in the linux-firmware
  package, unlike rtl8192u

- atmel firmware is not in upstream linux-firmware, but Debian
  has an atmel-firmware package for it

- I could not find a Debian package for ks7010sd.rom

- vt6656/vntwusb.fw is in firmware-misc-nonfree

- orinoco has multiple firmware files, but only agere_sta_fw.bin
  and agere_ap_fw.bin are in Debian and linux-firmware.

     Arnd
