Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9927B41F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjI3QG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjI3QGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:06:51 -0400
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE8BB7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 09:06:44 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3d80:0:640:1395:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id 974DF5F61C;
        Sat, 30 Sep 2023 19:06:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id c6WKmaHDZmI0-ZKN8t4xB;
        Sat, 30 Sep 2023 19:06:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
        t=1696090000; bh=0X+xhIxQK2nfnDE2MvbyZPPjWZRB8e8qLboAslRCHh4=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=I7i3tJkdMGOBQ7tCuLN7nL8w8sJhe0alf0/KjLauC7Oni/1RnLOqGImfgy1d9f/qj
         FAxASfIysLBv5giUGjFfsbYIEFOjJEWhl2jJZQRLGjnUQ7cTpYucddk+mbi/R6rMc6
         9Ji2YuYQO3HrbJF1BG8h5ttgezH6hFKznlsM6vog=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <8bbe66a23eb5c8a2404b72d754b1bcb6f4d23867.camel@maquefel.me>
Subject: Re: [RFC PATCH] mtd: nand: add support for ts72xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Johan Jonker <jbx6244@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Date:   Sat, 30 Sep 2023 19:06:42 +0300
In-Reply-To: <20230927172947.33106fe2@xps-13>
References: <20230927141532.25525-1-nikita.shubin@maquefel.me>
         <20230927172947.33106fe2@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miqu=C3=A8l!

On Wed, 2023-09-27 at 17:29 +0200, Miquel Raynal wrote:
> Hi Nikita,
>=20
> nikita.shubin@maquefel.me=C2=A0wrote on Wed, 27 Sep 2023 17:15:25 +0300:
>=20
> > Technologic Systems has it's own nand controller implementation in
> > CPLD.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > Hello Miqu=C3=A8l.
> >=20
> > Can you please take a look on it as RFC, so no need for the whole
> > series spinning ?
> >=20
> > I've got rid of all legacy stuff i think, however:
>=20
> I am glad you did, thanks a lot!
>=20
> > - look's like i me ts7250 is missing READCACHE and i couldn't find
> > any docs=20
> > =C2=A0 for this controller, so as legacy had no READCACHE, i mark it as
> > non-supported
>=20
> What NAND device do you use?
>=20
> The controller clearly supports it, as it just forwards whatever
> addrs/cmd/data cycle you input. However we are trying to fix the
> cache
> reads support which is unstable. If you use a NAND that is non-JEDEC
> and non-ONFI then please apply this and you will no longer be
> bothered
> by it:
> https://lore.kernel.org/linux-mtd/20230926132725.5d570e1b@xps-13/T/#md7e5=
e944a6a08e24f4f1e20068a49f94794ab945
>=20

You are totally right - controller and chip are different entities, i
somehow forgot about it:

```
# modprobe technologic-nand-controller
nand: device found, Manufacturer ID: 0xec, Chip ID: 0xf1
nand: Samsung NAND 128MiB 3,3V 8-bit
nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
Scanning device for bad blocks
Bad eraseblock 137 at 0x000001120000
Bad eraseblock 310 at 0x0000026c0000
3 fixed-partitions partitions found on MTD device 60000000.nand-
controller
Creating 3 MTD partitions on "60000000.nand-controller":
0x000000000000-0x000000020000 : "TS-BOOTROM"
0x000000020000-0x000007d20000 : "Linux"
0x000007d20000-0x000008000000 : "RedBoot"
```

This looks like Samsung K9F1G08U0D or K9F1G08U0B.

And the patch above totally solves my issues with READCACHE - thank
you!

> If you are using a Micron chip that specifies not supporting ECC
> correction together with sequential cache reads, then it's a problem
> that we will solve soon (you can hardcode
> chip->controller->supported_op.cont_read to 0);
>=20
> Otherwise we can discuss it.
>=20
> > - legacy wait implementation had no delays - only timeout and if i
> > set=20
> > =C2=A0 readb_poll_timeout() to something reasonable i experience speed
> > degradation=20
> > =C2=A0 on mtd_speedtest, can it be left as 0 ?
>=20
> Looks like the legacy implementation used cond_resched(). The delay
> needs to be observed before first checking for the status, it's a
> delay
> that is described in the spec, if you get the status before you might
> just not see a consistent value. I believe that is worth taking into
> account in your implementation below (don't wait then delay, it's
> not relevant). Can you share the values you've tried and the
> performances you've got?

The numbers are pretty stable, so indeed legacy is a bit faster,
followed up by new one with zero interval.

Legacy speedtest (old version of nand controller):

```
# insmod mtd_speedtest.ko dev=3D1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mtd_speedtest: MTD device: 1
mtd_speedtest: MTD device size 131072000, eraseblock size 131072, page
size 2048, count of eraseblocks 1000, pages per eraseblock 64, OOB size
64
mtd_test: scanning for bad eraseblocks
mtd_test: block 136 is bad
mtd_test: block 309 is bad
mtd_test: scanned 1000 eraseblocks, 2 are bad
mtd_speedtest: testing eraseblock write speed
mtd_speedtest: eraseblock write speed is 3793 KiB/s
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 3567 KiB/s
mtd_speedtest: testing page write speed
mtd_speedtest: page write speed is 3682 KiB/s
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 3488 KiB/s
mtd_speedtest: testing 2 page write speed
mtd_speedtest: 2 page write speed is 3724 KiB/s
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 3521 KiB/s
mtd_speedtest: Testing erase speed
mtd_speedtest: erase speed is 198709 KiB/s
mtd_speedtest: Testing 2x multi-block erase speed
mtd_speedtest: 2x multi-block erase speed is 200638 KiB/s
mtd_speedtest: Testing 4x multi-block erase speed
mtd_speedtest: 4x multi-block erase speed is 201545 KiB/s
mtd_speedtest: Testing 8x multi-block erase speed
mtd_speedtest: 8x multi-block erase speed is 202341 KiB/s
mtd_speedtest: Testing 16x multi-block erase speed
mtd_speedtest: 16x multi-block erase speed is 202909 KiB/s
mtd_speedtest: Testing 32x multi-block erase speed
mtd_speedtest: 32x multi-block erase speed is 203095 KiB/s
mtd_speedtest: Testing 64x multi-block erase speed
mtd_speedtest: 64x multi-block erase speed is 203482 KiB/s
mtd_speedtest: finished
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```

New version with interval zero:

```
# insmod mtd_speedtest.ko dev=3D1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mtd_speedtest: MTD device: 1
mtd_speedtest: MTD device size 131072000, eraseblock size 131072, page
size 2048, count of eraseblocks 1000, pages per eraseblock 64, OOB size
64
mtd_test: scanning for bad eraseblocks
mtd_test: block 136 is bad
mtd_test: block 309 is bad
mtd_test: scanned 1000 eraseblocks, 2 are bad
mtd_speedtest: testing eraseblock write speed
mtd_speedtest: eraseblock write speed is 3685 KiB/s
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 3517 KiB/s
mtd_speedtest: testing page write speed
mtd_speedtest: page write speed is 3592 KiB/s
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 3444 KiB/s
mtd_speedtest: testing 2 page write speed
mtd_speedtest: 2 page write speed is 3608 KiB/s
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 3475 KiB/s
mtd_speedtest: Testing erase speed
mtd_speedtest: erase speed is 194499 KiB/s
mtd_speedtest: Testing 2x multi-block erase speed
mtd_speedtest: 2x multi-block erase speed is 196316 KiB/s
mtd_speedtest: Testing 4x multi-block erase speed
mtd_speedtest: 4x multi-block erase speed is 198305 KiB/s
mtd_speedtest: Testing 8x multi-block erase speed
mtd_speedtest: 8x multi-block erase speed is 199263 KiB/s
mtd_speedtest: Testing 16x multi-block erase speed
mtd_speedtest: 16x multi-block erase speed is 199548 KiB/s
mtd_speedtest: Testing 32x multi-block erase speed
mtd_speedtest: 32x multi-block erase speed is 200221 KiB/s
mtd_speedtest: Testing 64x multi-block erase speed
mtd_speedtest: 64x multi-block erase speed is 200579 KiB/s
mtd_speedtest: finished
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```

New version with interval 100:

```
# insmod mtd_speedtest.ko dev=3D1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mtd_speedtest: MTD device: 1
mtd_speedtest: MTD device size 131072000, eraseblock size 131072, page
size 2048, count of eraseblocks 1000, pages per eraseblock 64, OOB size
64
mtd_test: scanning for bad eraseblocks
mtd_test: block 136 is bad
mtd_test: block 309 is bad
mtd_test: scanned 1000 eraseblocks, 2 are bad
mtd_speedtest: testing eraseblock write speed
mtd_speedtest: eraseblock write speed is 2722 KiB/s
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 2175 KiB/s
mtd_speedtest: testing page write speed
mtd_speedtest: page write speed is 2598 KiB/s
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 2070 KiB/s
mtd_speedtest: testing 2 page write speed
mtd_speedtest: 2 page write speed is 2627 KiB/s
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 2106 KiB/s
mtd_speedtest: Testing erase speed
mtd_speedtest: erase speed is 175851 KiB/s
mtd_speedtest: Testing 2x multi-block erase speed
mtd_speedtest: 2x multi-block erase speed is 181582 KiB/s
mtd_speedtest: Testing 4x multi-block erase speed
mtd_speedtest: 4x multi-block erase speed is 181579 KiB/s
mtd_speedtest: Testing 8x multi-block erase speed
mtd_speedtest: 8x multi-block erase speed is 182735 KiB/s
mtd_speedtest: Testing 16x multi-block erase speed
mtd_speedtest: 16x multi-block erase speed is 183589 KiB/s
mtd_speedtest: Testing 32x multi-block erase speed
mtd_speedtest: 32x multi-block erase speed is 183003 KiB/s
mtd_speedtest: Testing 64x multi-block erase speed
mtd_speedtest: 64x multi-block erase speed is 183460 KiB/s
mtd_speedtest: finished
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```

Also providing version with zero interval and "if (instr->delay_ns)"
dropped - it's optional as far i understood:

```
# insmod mtd_speedtest.ko dev=3D1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mtd_speedtest: MTD device: 1
mtd_speedtest: MTD device size 131072000, eraseblock size 131072, page
size 2048, count of eraseblocks 1000, pages per eraseblock 64, OOB size
64
mtd_test: scanning for bad eraseblocks
mtd_test: block 136 is bad
mtd_test: block 309 is bad
mtd_test: scanned 1000 eraseblocks, 2 are bad
mtd_speedtest: testing eraseblock write speed
mtd_speedtest: eraseblock write speed is 3695 KiB/s
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 3532 KiB/s
mtd_speedtest: testing page write speed
mtd_speedtest: page write speed is 3593 KiB/s
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 3457 KiB/s
mtd_speedtest: testing 2 page write speed
mtd_speedtest: 2 page write speed is 3640 KiB/s
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 3488 KiB/s
mtd_speedtest: Testing erase speed
mtd_speedtest: erase speed is 195451 KiB/s
mtd_speedtest: Testing 2x multi-block erase speed
mtd_speedtest: 2x multi-block erase speed is 198538 KiB/s
mtd_speedtest: Testing 4x multi-block erase speed
mtd_speedtest: 4x multi-block erase speed is 199509 KiB/s
mtd_speedtest: Testing 8x multi-block erase speed
mtd_speedtest: 8x multi-block erase speed is 199871 KiB/s
mtd_speedtest: Testing 16x multi-block erase speed
mtd_speedtest: 16x multi-block erase speed is 200075 KiB/s
mtd_speedtest: Testing 32x multi-block erase speed
mtd_speedtest: 32x multi-block erase speed is 200683 KiB/s
mtd_speedtest: Testing 64x multi-block erase speed
mtd_speedtest: 64x multi-block erase speed is 200850 KiB/s
mtd_speedtest: finished
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

```


>=20
> Thanks,
> Miqu=C3=A8l
>=20

