Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594617A0A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjINQSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:18:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEC41FC0;
        Thu, 14 Sep 2023 09:18:44 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73CD5660734C;
        Thu, 14 Sep 2023 17:18:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694708323;
        bh=BLm09vQcjjmO2omYXit39dcSh8oDsxgFsPspyM2A5+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYEEh3Nyv/rd0700Q4Chu9ABx/oSMqfk+fWgNI2WmSnh+PBAvYDgl0PHab0ji0QP+
         HWUoQ1Pc9ojgm5s6DkvN/9iWdINurfVJ2DFBZGX4Z6P2uo5/wZXv69msPZK3yme92i
         QcwksnSPJT6/V1zviRXtjhAyq8+flGs1F/isJjWNYjqKx0AzyBq58b7Ns4D0yK1R0D
         QCIeb+OECSYRDPYQQp4yt0verJWAA+u+4e1km58lnIK/YL88kIqv4XkAk6LlJxXv8H
         bAwjkGVgpGJ9+Wgsu6r/wLS7eJPHO1Albx90FXcVf/JJ0zYJnr2nLZfnaCypWUKRy1
         4mz/lBDu/XtUQ==
Received: by mercury (Postfix, from userid 1000)
        id 2FFA8106098B; Thu, 14 Sep 2023 18:18:41 +0200 (CEST)
Date:   Thu, 14 Sep 2023 18:18:41 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cros_pchg: Sync port status on resume
Message-ID: <20230914161841.gyjjkarid27r4nw7@mercury.elektranox.org>
References: <20230417221610.1507341-1-dnojiri@chromium.org>
 <20230508123228.pduxcrwylbq73iuj@mercury.elektranox.org>
 <CAC0y+Ah1kLAGzftR8=afm3+uF5U5eH1_E89FwX0--NkZJNVYQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tfqnw5fnudvt3nws"
Content-Disposition: inline
In-Reply-To: <CAC0y+Ah1kLAGzftR8=afm3+uF5U5eH1_E89FwX0--NkZJNVYQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfqnw5fnudvt3nws
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 29, 2023 at 10:46:19AM -0700, Daisuke Nojiri wrote:
> Hi Sebastian. Friendly ping. Any progress on this? Thanks,

Please don't top-post on kernel mailing lists. Also I queued this On
2023-05-08, as you quoted. The patch landed in 6.4-rc1.

-- Sebastian

> On Mon, May 8, 2023 at 9:37=E2=80=AFAM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > On Mon, Apr 17, 2023 at 03:16:10PM -0700, Daisuke Nojiri wrote:
> > > When a stylus is removed (or attached) during suspend, the device det=
ach
> > > (or attach) events can be lost. This patch makes the peripheral device
> > > charge driver retrieve the latest status from the EC on resume.
> > >
> > > BUG=3Db:276414488
> > > TEST=3DRedrix
> > >
> > > Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> > > ---
> >
> > Thanks, queued.
> >
> > -- Sebastian
> >
> > >  .../power/supply/cros_peripheral_charger.c    | 25 ++++++++++++++++-=
--
> > >  1 file changed, 22 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers=
/power/supply/cros_peripheral_charger.c
> > > index 1379afd9698d..a204f2355be4 100644
> > > --- a/drivers/power/supply/cros_peripheral_charger.c
> > > +++ b/drivers/power/supply/cros_peripheral_charger.c
> > > @@ -227,8 +227,7 @@ static int cros_pchg_get_prop(struct power_supply=
 *psy,
> > >       return 0;
> > >  }
> > >
> > > -static int cros_pchg_event(const struct charger_data *charger,
> > > -                        unsigned long host_event)
> > > +static int cros_pchg_event(const struct charger_data *charger)
> > >  {
> > >       int i;
> > >
> > > @@ -256,7 +255,7 @@ static int cros_ec_notify(struct notifier_block *=
nb,
> > >       if (!(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
> > >               return NOTIFY_DONE;
> > >
> > > -     return cros_pchg_event(charger, host_event);
> > > +     return cros_pchg_event(charger);
> > >  }
> > >
> > >  static int cros_pchg_probe(struct platform_device *pdev)
> > > @@ -281,6 +280,8 @@ static int cros_pchg_probe(struct platform_device=
 *pdev)
> > >       charger->ec_dev =3D ec_dev;
> > >       charger->ec_device =3D ec_device;
> > >
> > > +     platform_set_drvdata(pdev, charger);
> > > +
> > >       ret =3D cros_pchg_port_count(charger);
> > >       if (ret <=3D 0) {
> > >               /*
> > > @@ -349,9 +350,27 @@ static int cros_pchg_probe(struct platform_devic=
e *pdev)
> > >       return 0;
> > >  }
> > >
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int __maybe_unused cros_pchg_resume(struct device *dev)
> > > +{
> > > +     struct charger_data *charger =3D dev_get_drvdata(dev);
> > > +
> > > +     /*
> > > +      * Sync all ports on resume in case reports from EC are lost du=
ring
> > > +      * the last suspend.
> > > +      */
> > > +     cros_pchg_event(charger);
> > > +
> > > +     return 0;
> > > +}
> > > +#endif
> > > +
> > > +static SIMPLE_DEV_PM_OPS(cros_pchg_pm_ops, NULL, cros_pchg_resume);
> > > +
> > >  static struct platform_driver cros_pchg_driver =3D {
> > >       .driver =3D {
> > >               .name =3D DRV_NAME,
> > > +             .pm =3D &cros_pchg_pm_ops,
> > >       },
> > >       .probe =3D cros_pchg_probe
> > >  };
> > > --
> > > 2.39.2
> > >

--tfqnw5fnudvt3nws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUDMlwACgkQ2O7X88g7
+pqybhAAg1Ti6H/qCCYpCtCO8eN6GmnNnFEo7RMBb+11YJwt5LGPRzLvIDCs3uIN
IJrrt190+sazFe7OUqzCLdbrB+9PdOlQpUwh8TlfO7VaFSUPGHGcKQmgDBPXrDTk
aN349WyqFSTyQ3/y7rEG5jxFEKIc6OqF6Mg3EX66xR7J6wfLkXpaN+6qB8XKEt/F
Hrha2OpxH0OxWvc5biphj+ltQ3l/g0guSao1l3ZIQTjkJj+iv9QSoRrQrw6jQX8m
U6rgU3Dxz0jOZhpS7XuN2AIwslYxz3iieZh21Z1+6Ib3ha+Y0NCjII96gNOQvH0Q
V/LFED3Ow64+JnIQLprsmruddWcZAigC61TglIzFf9SEk5duZFoNQV764n6F4Nqk
Kg0BENIZxaPq7IuWyCjXGvhflH2aYAVeMBJWojNVdJUf5SrjoWv5B8hrHVWo1TE8
t7JDTnx0HO0Agml2l0N06SmzWOFoVUab3WYLsO6FxjBS/n0gzqSYhJfrn4uFBwKg
9+s1g6uZrI96l5WuEZl93Va2b4q85b6h3kAhRsmsvot2n/H6ahCh8CB6TMjulGXN
LPYruo/tZ5QvZtYBtM6VzkPsU2YYaiWbHfbuLNtcvHRSxL9esKYOnUNi8Jj+Yry7
7wzmjacsyDGQstVh2IpmImVDZ1DLGcCJRqQw6Z3Jg682JokSyKQ=
=x+sG
-----END PGP SIGNATURE-----

--tfqnw5fnudvt3nws--
