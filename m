Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F43760BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjGYHew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGYHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:34:05 -0400
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34C81BC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:32:27 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3c99:0:640:7c39:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id 08C965E670;
        Tue, 25 Jul 2023 10:32:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NWE9BhbDa4Y0-nKfkZC0h;
        Tue, 25 Jul 2023 10:32:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1690270344;
        bh=uQwkHdbNNqXad2F9E68Qz3kTtrm40Hwf9bDHsmDIzGU=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=gH3MiEljctPMwRDvn0PoJEtN8IWa/VMfHZMBR94hbskFRVrA2slGcJicsShI95DCL
         LU/1jKiI1CMXbMVJYJ/QXLmiIThORV/096PWjqVh8xUZ5udtmvRTv9cwjthz1SOdud
         RZ51WlWFKITE70HkM2GpwfrgLxVGMnv2wXRF1pDk=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <ba321a6912bc4230b5dc482b4781b0f5115c83c0.camel@maquefel.me>
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 25 Jul 2023 10:32:23 +0300
In-Reply-To: <9b51bd0a-271a-4830-9422-89ad853a67b6@app.fastmail.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
         <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
         <0ec81b89-4d4c-4e13-5ea0-697f5c0af835@linaro.org>
         <4073daf401a820c0f64e6fa813b5253bd0427bcd.camel@maquefel.me>
         <886e29ec-a290-993a-d99a-d5fd90662e99@linaro.org>
         <9b51bd0a-271a-4830-9422-89ad853a67b6@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd, Krzysztof !

On Mon, 2023-07-24 at 20:04 +0200, Arnd Bergmann wrote:
> On Mon, Jul 24, 2023, at 18:31, Krzysztof Kozlowski wrote:
> > On 24/07/2023 17:02, Nikita Shubin wrote:
> > > >=20
> > > > There is no even need for this, because this code does not use
> > > > it!
> > >=20
> > > It's a little emotional, so i can hardly understand the exact
> > > reason of
> > > dissatisfaction.
> > >=20
> > > Are you against usage of EXPORT_SYMBOL_NS_GPL ? - then indeed my
> > > fault
> > > it's not needed as both PINCTRL and CLK (the only users of this
> > > code)
> > > can't be built as modules.
> >=20
> > I am against any exported symbols and most of functions visible
> > outside
> > of this driver.
>=20
> I think it's a reasonable compromise here, this all ancient code
> and we don't need to rewrite all of it as part of the DT conversion,
> even if we would do it differently for a new platform.
>=20
> I really just want to merge the series before Nikita runs out
> of motivation to finish the work, after having done almost all
> of it.

Thank you for your kind words, i think i have steam for at least for a
couple more versions.

I agree with Krzysztof, through i don't see any good options to dial
with "swlocked" registers (these means we have to write a magic value
to some register just before writing to "swlocked" register) without
exposing some functions - the only variants i can think of:

- introduce a "fake" hwlock, so the drivers will provide magic
themselves while holding the lock
- convert SYSCON, CLK, PINCTRL into "Auxiliary" (suggested by Stephen)
but this introduces more problems:
  - as AFAIK CLK can use SYSCON node - but i am not sure about PINCTRL
  - it still will have a common header for CLK and PINCTRL (no
functions - just structs however)

>=20
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("EP93xx SoC re=
vision %s\n", attrs->revision);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > +}
> > > > > +core_initcall(ep93xx_soc_init);
> > > >=20
> > > > That's not the way to add soc driver. You need a proper driver
> > > > for it
> > >=20
> > > What is a proper driver for these ?=C2=A0
> >=20
> > Usually platform_driver, e.g. exynos-chipid.
>=20
> Using a platform driver sounds like the right thing to do here,
> it's cleaner and should not be hard to do if the driver just matches
> the cirrus,ep9301-syscon node. I would have just merged
> the v3 version, but this is something that makes sense changing
> in v4.

Indeed.

>=20
> > > Even the latest additions in drivers/soc/* go with *_initcall.
> >=20
> > Which one? Ones which call platform_driver_register()? That's quite
> > different story, isn't it? I don't see other recent cases, except
> > regulator couplers. They might be, some people send and accept poor
> > code, so what do you expect from us? Crappy code got in once, so
> > more of
> > it can go?
>=20
> That's not what is happening here, this is all part of an incremental
> improvement of the existing code. If the DT bindings make sense, I'm
> happy to take some shortcuts with the implementation that keep it
> closer to the existing implementation and either clean them up over
> time or just throw out the platform in five or ten years when the
> last
> machines are dead.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd

