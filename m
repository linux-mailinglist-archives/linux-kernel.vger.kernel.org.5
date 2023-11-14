Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F17EAE27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjKNKgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:36:36 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE69D184
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:36:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2qmC-000319-AS; Tue, 14 Nov 2023 11:36:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2qmB-008yF9-4C; Tue, 14 Nov 2023 11:36:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2qmA-001JJi-R6; Tue, 14 Nov 2023 11:36:10 +0100
Date:   Tue, 14 Nov 2023 11:36:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] dt-bindings: pwm: ti,pwm-omap-dmtimer: Update
 binding for yaml
Message-ID: <20231114103610.sbiicumbh2xju6lj@pengutronix.de>
References: <20231114082709.54138-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7b6i2lxusyiit2rg"
Content-Disposition: inline
In-Reply-To: <20231114082709.54138-1-tony@atomide.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7b6i2lxusyiit2rg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 14, 2023 at 10:27:06AM +0200, Tony Lindgren wrote:
> +  ti,timers:
> +    description: Timer instance phandle for the PWM
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,prescaler:
> +    description: |
> +      Legacy clock prescaler for timer. The timer counter is prescaled
> +      with 2^n where n is the prescaler.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> +    deprecated: true
> +
> +  ti,clock-source:
> +    description: |
> +      Legacy clock for timer, please use assigned-clocks instead.
> +      0x00 - high-frequency system clock (timer_sys_ck)
> +      0x01 - 32-kHz always-on clock (timer_32k_ck)
> +      0x02 - external clock (timer_ext_ck, OMAP2 only)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2 ]
> +    deprecated: true

Someone could collect some bonus points by converting these:

	$ git grep ti,clock-source arch/arm/boot
	arch/arm/boot/dts/ti/omap/am335x-guardian.dts:          ti,clock-source =
=3D <0x01>;
	arch/arm/boot/dts/ti/omap/am3517-evm.dts:               ti,clock-source =
=3D <0x01>;
	arch/arm/boot/dts/ti/omap/logicpd-torpedo-baseboard.dtsi:               ti=
,clock-source =3D <0x01>;
	arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi:                ti=
,clock-source =3D <0x01>;
	arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi:                ti=
,clock-source =3D <0x01>;
	arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi:             ti,clock-source =
=3D <0x01>;
	arch/arm/boot/dts/ti/omap/omap3-n900.dts:               ti,clock-source =
=3D <0x00>; /* timer_sys_ck */

(I verified, this are all about this binding.)

otherwise LGTM:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Should this go via the pwm tree or via some arm or omap or dt tree?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7b6i2lxusyiit2rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVTTZkACgkQj4D7WH0S
/k7ERgf+IaYSSEKLl5KVBFqv40539YINuhNaIstLunhrxIN+o899MuLjyLl/DM13
DCXIGigv9OBuBnflHhUy3DCsMEiF400x469OXwNhtHjjmEXbo2XlxODea/hkrIGw
+tbrf8c7wc4Tca/R0ZN411wCtaE7o2zPsKM5/fL6evW9dB9qhonCX+KeAlE1IKAo
8HS5J/NT8ZonhYPtGHLUt7Uee+b8VzZVPkGVjxb+eZ/ZWbX5NZq2XyOh0yCfPvVm
fpTc40h0wUGIjQu5TO06ZyF0zC218hJOdpO6YvrJAmpTeUKTgPwjfNeZBRjtpIjl
WRxfbSvCKi0L7StGP6Bgcqsd++tWvg==
=TLmH
-----END PGP SIGNATURE-----

--7b6i2lxusyiit2rg--
