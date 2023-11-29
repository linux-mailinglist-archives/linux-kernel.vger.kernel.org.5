Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3107D7FDD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjK2QrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2QrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:47:19 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90190;
        Wed, 29 Nov 2023 08:47:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F84BFF813;
        Wed, 29 Nov 2023 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701276444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkefkReIWzyqiZJSPhEnTXAmzyUb/Ar5C+Xf+28fWzA=;
        b=WLP04NEXoF/EPNmxNPgwLICEHOen2oXanUWKsWRA1iZ/LZ+Qlo2awceFETEXMG1y8IfaUy
        3tTEMg09JL03ejZwL+eEGrpRQ1gyuQzVpW/ZUmxXeIaIKfdLQu/iYafXA0x9a1muGB2ALN
        h/9O6HydnjVKJS9HwOX/87S7q9ZBkgj08miJRdUhTqNiTiIaDoRjOWjCDgJXhKrY/l4x3s
        v8OZKcQP66DmMgpFcaH53QUTu8q3+Ilso0ECJ2fgkKANdrAbIBc0uExmedh6m8fwDfVX9l
        DIzGskzZEn5oMiHPHwEoadfjGwTHhNqey+gjV0KATl+6GmOvQXATEBcw4UWeZg==
Date:   Wed, 29 Nov 2023 17:47:22 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, richard@nod.at,
        vigneshr@ti.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH] mtd: devices: add AT24 eeprom support
Message-ID: <20231129174722.7d4e768c@xps-13>
In-Reply-To: <CAMRc=MdsEWxJLHL__zYXGEMYvvLSH99GsTRv_NTaVXt2fGtNvg@mail.gmail.com>
References: <20231127164623.1008176-1-m.felsch@pengutronix.de>
        <CAMRc=MdsEWxJLHL__zYXGEMYvvLSH99GsTRv_NTaVXt2fGtNvg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

brgl@bgdev.pl wrote on Wed, 29 Nov 2023 10:10:28 +0100:

> On Mon, Nov 27, 2023 at 5:46=E2=80=AFPM Marco Felsch <m.felsch@pengutroni=
x.de> wrote:
> > =20
>=20
> [snip]
>=20
> >
> > I dropped the backward compatibility since this is a new driver not
> > having to deal with it. The old and the new driver can not be used by
> > the same kernel config. So it is either using the MTD eeprom driver
> > supporting partitioning and NVMEM or the older one which does not
> > support partitioning but keeps the backward compatibility.
> >
> > Comments and suggestions are very welcome :) =20
>=20
> I skimmed through the code. Nothing obviously wrong. What I would
> suggest - if we're going to have two at24 drivers - is a lot more code
> reuse. I dislike the idea of having basically the same code in two
> places in the kernel and having to fix bugs in both.

Agreed.

> Though if I'm being honest - I would prefer a single driver with
> backwards compatibility. Have you estimated the effort it would take
> to abstract both nvmem and mtd?

Also agreed :-)

Thanks,
Miqu=C3=A8l
