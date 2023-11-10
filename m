Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D212F7E81DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbjKJSht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjKJSfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:35:05 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6C39CCA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:47:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Smx-0007Pv-TJ; Fri, 10 Nov 2023 15:47:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Sms-0082mL-3F; Fri, 10 Nov 2023 15:47:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Smr-00GmoR-Q0; Fri, 10 Nov 2023 15:47:09 +0100
Date:   Fri, 10 Nov 2023 15:47:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        Richard.Gong@amd.com, posteuca@mutex.one,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: amd: acp: add pm ops support for renoir
 platform Add pm ops for renoir platform.
Message-ID: <20231110144709.33z7qdl3dvb6pjkj@pengutronix.de>
References: <20231110125214.2127139-1-Syed.SabaKareem@amd.com>
 <20231110125214.2127139-2-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z2bq2xkeirl6malp"
Content-Disposition: inline
In-Reply-To: <20231110125214.2127139-2-Syed.SabaKareem@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z2bq2xkeirl6malp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

the subject should be deduplicated.

On Fri, Nov 10, 2023 at 06:22:10PM +0530, Syed Saba Kareem wrote:
> +static int __maybe_unused rn_pcm_resume(struct device *dev)

If you use DEFINE_SIMPLE_DEV_PM_OPS below, you can drop the
__maybe_unused here.

> +{
> [...]
> +}
> +
> +static const struct dev_pm_ops rn_dma_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, rn_pcm_resume)
> +};
> +
>  static struct platform_driver renoir_driver =3D {
>  	.probe =3D renoir_audio_probe,
>  	.remove_new =3D renoir_audio_remove,
>  	.driver =3D {
>  		.name =3D "acp_asoc_renoir",
> +		.pm =3D &rn_dma_pm_ops,
>  	},
>  };

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z2bq2xkeirl6malp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVOQmwACgkQj4D7WH0S
/k4H3Af9F+zM48KYYJ2LhyGdAwCIXHLLHtID1xORRtoppL1DvdGdGIgLxMNGil1D
KKIElxqjCLkwI7z7pUpD3VrPIA3RVr8QkwUNebuNYCu/FeYVq/iq10xPCTyJ9XOB
LeX920bHa8cELvuyZmdwo5fvTxVZYTEos+/gl9uYs7ZWOszPEmUug2+UXoaW+Xr7
VIMVDIDX0+A9oPd/3LVzqMLerKQ+xTywlsJHKBn7jZ27Mty+EntVnwiJU3g1POXF
1E1bAD4H2jxfQIF9CVoy8LX/6FgegHNX3jb8yaGYNSHKxOUYH4PZcAZ6rZDHCyFm
5MW4QdZtuwxF8q5WxzTMUECjPP35FA==
=Gcu+
-----END PGP SIGNATURE-----

--z2bq2xkeirl6malp--
