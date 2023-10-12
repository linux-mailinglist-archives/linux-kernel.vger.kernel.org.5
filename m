Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4A7C6638
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377465AbjJLHJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjJLHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:09:02 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4A9D;
        Thu, 12 Oct 2023 00:09:00 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5045cb9c091so934615e87.3;
        Thu, 12 Oct 2023 00:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094539; x=1697699339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpSfoJwDtnAsoTPya6J4WKkXULjEB6HnzhqPzwoz4os=;
        b=KhYpNwrSN9qG88SjqCplJa9WOav8/ZsRBEQ6s13uEWxWB5usom/87pBHRImc6YjXFf
         yqhjt8HEd+xROBKBYmS/ddE8ndhKMuTYCPD274N+C6aLcpKcA0trbzHB0y0d9Gqx93Br
         7BYbYrYZXJF9HnEi4VUZbz9HYUqnPArNT5bydSxcMt9qRRpff0OaoQjpnK3D8Rmu2z8L
         IFiTpsylo/Xq76H05LM70iMQGSCvhHjaAIq/C2xS8UE1aONB00RCDKTrXUo9tCBFm4Ur
         2MeYg/ROv1egJSNr/iJxV4TtYYbd9/4rzVv6xne1B91af3Z3uySk8PSIFQXzmN1AvEa9
         dgSw==
X-Gm-Message-State: AOJu0Ywuf27eVTara/etf+Ttf9L8PC+6qhRidLgIlf7LSGVM5Xdr93pW
        TZk9R35cccFbRS27tjtL26o=
X-Google-Smtp-Source: AGHT+IGkWgEz1bua7UOe8c93Xd+zUIbbCX+AXuqOrArTKHM5MbSYMr2Oc+70mEn2xzFeFATL4gjEIw==
X-Received: by 2002:a05:6512:280d:b0:503:a9c:af83 with SMTP id cf13-20020a056512280d00b005030a9caf83mr23404209lfb.41.1697094538523;
        Thu, 12 Oct 2023 00:08:58 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id v23-20020ac25597000000b0050306259d8asm2646893lfg.215.2023.10.12.00.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:08:57 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:08:40 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        zev@bewilderbeest.net, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] regulator: fixed: forward under-voltage events
Message-ID: <ZSebeJKa0sEzNzP4@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
 <20231010085906.3440452-3-o.rempel@pengutronix.de>
 <5e51792a-cc93-4364-a51b-c2b116d89369@sirena.org.uk>
 <20231010125531.GA3268051@pengutronix.de>
 <c2ee404d-d07f-42c6-b5ba-41659773e8eb@sirena.org.uk>
 <20231011075931.GA3305420@pengutronix.de>
 <2d14fd22-c37b-4c15-a2ea-a2fd2c201adb@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zTBIn7qXME7IwVru"
Content-Disposition: inline
In-Reply-To: <2d14fd22-c37b-4c15-a2ea-a2fd2c201adb@sirena.org.uk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zTBIn7qXME7IwVru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 12:38:19PM +0100, Mark Brown wrote:
> On Wed, Oct 11, 2023 at 09:59:31AM +0200, Oleksij Rempel wrote:
>=20
> > Configuration through the device tree and kernel defaults is preferable.
> > For instance, having a default kernel governor that doesn=E2=80=99t req=
uire user
> > space configuration aligns with the project=E2=80=99s objectives.
>=20
> That's policy though...
>=20
> >=20
> > > For the regulator itself we probably want a way to identify regulators
> > > as being system critical so they start notifying.  It would be tempti=
ng

Can the "criticality" could be determined by the severity (ERROR vs WARNING=
)?

> > > to just do that by default but that would likely cause some issues for
> > > example with regulators for things like SD cards which are more likely
> > > to get hardware problems that don't comprimise the entire system.  We

"comprimise the entire system" sounds (to my ears) exactly the
difference between WARNING and ERROR notifications.

> > > could do that with DT, either a property or some sort of runtime
> > > consumer, but it might be better to have a control in sysfs that
> > > userspace can turn on?  OTOH the ability do something about this depe=
nds
> > > on specific hardware design...
> > >=20
> > > I've copied in Sebastian since this sounds like the sort of thing that
> > > power supplies might have some kind of handling for, or at least if we
> > > need to add something we should make it so that the power supplies can
> > > be joined up to it.  I do see temperature and capacity alerts in the
> > > sysfs ABI for power supplies, but nothing for voltage.
> >=20
> > Thank you for pointing towards the power supply framework. Given the ha=
rdware
> > design of my project, I can envision mapping the following states and
> > properties within this framework:
>=20
> There's also hw_failure_emergency_poweroff() which looks like exactly
> what you're trying to trigger here.

There is already a path from regulator notification handling to the
hw_failure_emergency_poweroff() - although only when handling the IRQs
fail and this failure is marked as fatal.

> > Considering the above mapping, my initial step would be to create a sim=
ple
> > regulator coupled (if regulator is still needed in this casr) with a De=
vice
> > Tree (DT) based power supply driver.  This setup would align with the e=
xisting
> > power supply framework, with a notable extension being the system-wide
> > notification for emergency shutdown upon under-voltage detection.
>=20
> It sounds like this is actually a regulator regardless of if it also
> appears via some other API.

I wonder if it would make sense to add a 'protector' in regulator core.
The 'protector' could register to listen the notifications from those
regulators which have some
'regulator-fatal-notifications =3D <list of notifications>;' -property
defined in device-tree.

In my eyes the device-tree is correct place for this information
because whether an "anomaly" in regulator output compromises the system
is a property of hardware.

Yours,
	-- Matti

--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--zTBIn7qXME7IwVru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUnm20ACgkQeFA3/03a
ocWoBAgAvt694sDu7d/r9CyhNbd/uDFnCTQ6LVK2CakUfO4JsjW/x+Pe1YrvRlQc
EZkpcaH0TKhQEc1jS+E8pYuX9YVjmAmmRJKQVe3PhK3lRc8WwqX2iWgALbHI0A/b
GudY8ngHDk1ShNLZfwMFLRghRSc+kBIEs/ZnsWG0dJDr2l/Tr6n6uAtgkWZC3i6X
vuAoq7g9NQRXBD0kBctmmWJfWcUSc0tFPN+fAqvQuUERms8opu95YFpIpBuFx8Hi
yw2JiMPrwVOrHeIb5ZhJuVho41BcmnFcU2bCKYXdrXfS1QX5b3mbUHdC3nrBfI0V
HtUJ12Ohl3YkW1euY/4rfDrL7lYHTw==
=JFJH
-----END PGP SIGNATURE-----

--zTBIn7qXME7IwVru--
