Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216287BD7FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbjJIKGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346047AbjJIKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:06:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159EDED
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:06:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpn9W-0007Yw-BU; Mon, 09 Oct 2023 12:06:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpn9V-000OEu-UH; Mon, 09 Oct 2023 12:06:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpn9V-00C7Dk-Kz; Mon, 09 Oct 2023 12:06:17 +0200
Date:   Mon, 9 Oct 2023 12:06:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, Angus Clark <angus.clark@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: bcm2835: Add support for suspend/resume
Message-ID: <20231009100617.lzxyg4mm56yoazla@pengutronix.de>
References: <20231005171516.2908961-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4x4pndddec4qowb"
Content-Disposition: inline
In-Reply-To: <20231005171516.2908961-1-florian.fainelli@broadcom.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4x4pndddec4qowb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Florian,

On Thu, Oct 05, 2023 at 10:15:15AM -0700, Florian Fainelli wrote:
> +static SIMPLE_DEV_PM_OPS(bcm2835_pwm_pm_ops, bcm2835_pwm_suspend,
> +			 bcm2835_pwm_resume);

The definition of SIMPLE_DEV_PM_OPS has a comment saying:

	Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead.

Can you please rework your patch accordingly?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z4x4pndddec4qowb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUj0JgACgkQj4D7WH0S
/k76IAf/Rfdj60t96flf+/L/M4w21DvlOcX+c3dDuAu4TBB62jFdMDba2TbmFhAq
wqR+hXN1AbdGKgrtHXGQpRobK5W4Yj4pU7vM6GHAbryu9k7aFUtSsrKAfWotKV7E
vSEI+tDhsMuiQH8m7lBES5ejX5bV+GeqB2XHrFizqrS/1VoaktYoUXY0M+GB3lTR
7E8VkG4JCPshIetW1ibwO+GyKMZDzNXXHtPStwDz5nggawIReLfwo9jpfixdPwwB
vGTd5xC9bymgPfmQ2IgeLqnkVx20VYlwYH+/AKxazyaquCEb2aYvQYd31eZWdJA+
t00/P6lfHL8PiVsh0hg4PIGTStKM1Q==
=N91w
-----END PGP SIGNATURE-----

--z4x4pndddec4qowb--
