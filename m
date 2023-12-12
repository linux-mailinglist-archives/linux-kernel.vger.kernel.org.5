Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB280F096
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376788AbjLLP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376863AbjLLP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:27:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09429130
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:27:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6CDC433CB;
        Tue, 12 Dec 2023 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702394866;
        bh=DWg3sQ9qxo14q4VzdIjndy7b2Wyci4KHHq5fC3tFwHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZE/1j13EWy8z8pFkXqNRn6HYJzjFYN/10G8iu8cAoafoyKUIycSHgfsSyvCG2Teo
         WIYd8P+3bQWl5nIbbFYJJT9TxFvKa61BuG3l1DafVw0ekfJDR8qSKIxXKDzCInlZYV
         raUWL9oNnYA4SBKtgOH4ful8G+RZ+T/71QpgbHLJGeR0sVbnohOUMP3PCXgg3SfKK2
         I9ufZ93he66i2gRzet1ebLl1wH5amInfBW6CfiulcjcH7V2WDx4RmZaQ5GFC1P65zR
         XRdJhdv/ySQONhdGuJFe03izK1d+T/JtjpbEhiwAqjmZ4pejzLDtj95C/Gi2y5/LVG
         RVsC/UmRz27YA==
Date:   Tue, 12 Dec 2023 15:27:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sean Young <sean@mess.org>,
        Jean Delvare <jdelvare@suse.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-media@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v8 1/6] pwm: Rename pwm_apply_state() to
 pwm_apply_might_sleep()
Message-ID: <7594ea09-a6f3-4dac-acb3-d5f899f9cf84@sirena.org.uk>
References: <cover.1702369869.git.sean@mess.org>
 <9af7ba748fd2eb7e04208b6b183185f1daf78016.1702369869.git.sean@mess.org>
 <20231212114100.sn7nzntousql2ays@pengutronix.de>
 <f7be8d89-25ae-4d83-9577-12fcac41d0ab@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iRFgPhdLTHQFhazT"
Content-Disposition: inline
In-Reply-To: <f7be8d89-25ae-4d83-9577-12fcac41d0ab@roeck-us.net>
X-Cookie: If rash develops, discontinue use.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iRFgPhdLTHQFhazT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 07:22:18AM -0800, Guenter Roeck wrote:
> On 12/12/23 03:41, Uwe Kleine-K=F6nig wrote:

> > Several affected maintainers already acked, so I guess it's fine to take
> > this via the pwm tree. An Ack from the remaining maintainers would be
> > very welcome, an alternative would be to split the patch.

> > Missing Acks so far:

> >   - Jean Delvare / Guenter Roeck for drivers/hwmon/pwm-fan.c
> >   - Javier Martinez Canillas for drivers/gpu/drm/solomon/ssd130x.c
> >   - Liam Girdwood / Mark Brown for drivers/regulator/pwm-regulator.c
> >   - Helge Deller for drivers/video/fbdev/ssd1307fb.c

> Personally I find the change unnecessary and pointless, which is why I
> didn't ack it. Even if function names were deemed important enough, keepi=
ng
> pwm_apply_state() for the time being and just adding pwm_apply_might_slee=
p()
> as duplicate would have done it, all the changes could have gone in long
> ago, and per-subsystem cleanup could have been orthogonal.

> I refrained from commenting because it might be considered bike shedding,
> but I don't want to ack something I deem unnecessary and pointless without
> comment. But then don't want to keep arguing either, so

I haven't been reading this series because I couldn't tell why I was
copied on it, it's only chance that made me open Guenter's mail here...

Acked-by: Mark Brown <broonie@kernel.org>

--iRFgPhdLTHQFhazT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV4e+YACgkQJNaLcl1U
h9Aqewf/UALlUMgqzHC9oYZI+Kcf9eGgd7QO/+pxhbI5hMnT5tFRH9lkihV8NhkZ
moY0GH6PcO8YFj0y+Hs89vmJCd3MRAJ7tZ3eEg5/Q7BJejmk7kB24R5TlqUHUcg7
DcHugsUrGAmvt3afuF03VqA53HlJ6D43J0cIv5j5X8x18v9Z4s0/4z+/zuMEJ8qi
05gpioqCsqqPxlKMuWv9qPxn6PDVO3JMk7OUodLi1Tdzfio/b7/81nRQX6DgpHm4
odCEdmvJwIAukE1TlXxfpb7GZuHEe0z04rKSLfvDj6s90hRM9uHdJb3L7kp1Xf0n
nsm4Twh4PnRdMJRKACafo9HyC8RvJw==
=Wkx1
-----END PGP SIGNATURE-----

--iRFgPhdLTHQFhazT--
