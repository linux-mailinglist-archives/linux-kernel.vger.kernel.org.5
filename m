Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2778B68A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjH1Re3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjH1Rdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251911A;
        Mon, 28 Aug 2023 10:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4475E630EC;
        Mon, 28 Aug 2023 17:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB94AC433C9;
        Mon, 28 Aug 2023 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693244029;
        bh=KInp4zOqJ0MZH/kkJeuYTn3BkEi3fw9HxcUrey2AjMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gzwYkafSSkZEcvP0NkSjRDv2Cc+rOQsG4mT4G237OxPH/JW++GibV0gOx20EJ6jo8
         44d1Eztanc4pf2J8UF1UzsvNKqGhmOvHUKXyASYErXRN9pFY6glGrq0Xf20WeROZbr
         IPJWAJfjyLXAAI2HpnUjcu7rxScBk21Pbm+M2xaZh0M5mDOYxBLQRHPKrByyPi9HAQ
         M1TyfW1g0jaYDAvqIoHtaWwa0iHbLc/c9gx0tFdQ/9ywsfCx0B4zzKYbALMNYx4YO8
         UOQIAWgetretDqgZGBqow8y9rMOH3x35kHeqrR5eFEPAqk7k67hDlAhbo/eHQWo66h
         47dcG92qgVV/Q==
Date:   Mon, 28 Aug 2023 18:34:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
Message-ID: <20230828183402.785b6ede@jic23-huawei>
In-Reply-To: <ZNUEBDsMg6UfeOtl@smile.fi.intel.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
        <20230810093322.593259-2-mitrutzceclan@gmail.com>
        <34f5e2118a4714048231e6ee9a8f244248616bd0.camel@gmail.com>
        <ZNUEBDsMg6UfeOtl@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 18:36:36 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Aug 10, 2023 at 01:57:02PM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2023-08-10 at 12:33 +0300, Dumitru Ceclan wrote: =20
>=20
> ...
>=20
> > Is ad717x_gpio_cleanup() being used anywhere? Moreover I would maybe ju=
st get rid of
> > the #ifdef wrapper and just select GPIOLIB. How often will it be disabl=
ed anyways? =20
>=20
> The agreement is that users are depend on and not selecting GPIOLIB.
> Any news in these agreement terms?
>=20
> ...
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0id &=3D AD717X_ID_MASK;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id !=3D st->info->id)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_warn(&st->sd.spi->dev, "Unexpected device id: %=
x, expected:
> > > %x\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id, st->info->id);
> > > + =20
> >=20
> > Shouldn't we error out? =20
>=20
> It seems a new way of thinking about unsupported CHIP ID. Dunno if hw ven=
dors
> won't ever do a dirty trick that new ID must be programmed differently and
> otherwise burn hardware to a smoke...
>=20
> I'm with you here, unknown chips mustn't be supported.

Some discussions with DT maintainers on this led me to change my mind...
They are very strongly of the view that if a DT firmware claims a device is=
 compatible
then a device ID register that has an unknown value should be ignored. It g=
ets
more tricky if we have a known wrong value (in which case we assume that it
is the value the hardware is claiming whatever DT says).

Argument is that lots of new versions of devices that are fully compatible =
with
exception of ID registers are released and if you have an old kernel but a =
new
device tree (typically running a distro that hasn't caught up yet) then the
fallback compatible is there to make things work.

I changed the way we handle this case in IIO to follow this policy - with
the slight tweak that we print a message whenever such a mismatch occurs.

Jonathan

