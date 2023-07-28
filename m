Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E977669A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjG1KCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjG1KBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:01:37 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ACF3AB3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:01:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 283B75EE4B;
        Fri, 28 Jul 2023 13:01:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id B1KbDDADTiE0-I1EYIKQu;
        Fri, 28 Jul 2023 13:01:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1690538472;
        bh=ESZY1sGhR3Y+dvnLoW0+tPGYGkgt+oQmDxblpO85+qU=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=BFcJyDOE6LowbyQxaLJEg/JbE3I+Z3KY1eTcSk/GId2dfLBRQmUa9ueSoWGewLEr4
         jkDoRfTFD+blSe2X2nsFWrUxvMQkFhoGU1+LW1HW1n9JN66TIbnG/I/yo81wCEfuqa
         YH9gZfQd5p3pxd+uRA5gqYaQLuKNrAGk+eO0siTc=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <cbc0c2d68b950bf984b5cb16ce7fa6d2348940ad.camel@maquefel.me>
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jul 2023 13:01:11 +0300
In-Reply-To: <CAHp75VdSaxzU_7A7b=Htph29XA=ZbqUPJ6RJu+HtrSA2EbcXig@mail.gmail.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
         <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
         <ZLqSo6B5cJXVRJS/@smile.fi.intel.com>
         <79619e92b70fdb4b324758ddb34f84b3b8963256.camel@maquefel.me>
         <CAHp75VdSaxzU_7A7b=Htph29XA=ZbqUPJ6RJu+HtrSA2EbcXig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-28 at 12:46 +0300, Andy Shevchenko wrote:
> On Fri, Jul 28, 2023 at 12:28=E2=80=AFPM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> >=20
> > Hello Andy!
> >=20
> > On Fri, 2023-07-21 at 17:13 +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 20, 2023 at 02:29:07PM +0300, Nikita Shubin via B4
> > > Relay
> > > wrote:
> > > > From: Nikita Shubin <nikita.shubin@maquefel.me>
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&ep93xx_swl=
ock, flags);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_read(map, EP93XX_SYSCO=
N_DEVCFG, &val);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val &=3D ~clear_bits;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val |=3D set_bits;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_write(map, EP93XX_SYSC=
ON_SWLOCK,
> > > > EP93XX_SWLOCK_MAGICK);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_write(map, EP93XX_SYSC=
ON_DEVCFG, val);
> > >=20
> > > Is this sequence a must?
> > > I.o.w. can you first supply magic and then update devcfg?
> > >=20
> >=20
> > Unfortunately it is a must to write EP93XX_SYSCON_SWLOCK and only
> > then
> > the next write to swlocked registers will succeed.
>=20
> This doesn't answer my question. Can you first write a magic and then
> _update_ the other register (update means RMW op)?
>=20

I see your point now - citing docs:

"Logic safeguards are included to condition the control signals for
power connection to the matrix to prevent part damage. In addition, a
software lock register is included that must be written with 0xAA
before each register write to change the values of the four switch
matrix control registers."

So reading SHOULDN'T affect the lock.

But as we checked reading also breaks the lock, that's why this looks
so odd, it was done for purpose - i'll check it once again anyway.

