Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC449787B23
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbjHXWDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbjHXWDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A91BEB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10E466080
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25491C433C7;
        Thu, 24 Aug 2023 22:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692914607;
        bh=/7c5tUwMUP6QvVRac5TTUQ1rC40hmoPQGQoGNvaIz44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KruKRFdlEgc38ixJSne/0tF5W9oTscxnkoVQxCcXqWGZJ+lh1De6bYthxBrMbM9gJ
         yb0ynE5ZepZUIrixvDBhH4HXr8JVDGOld0tR2szR9JYtW+IDZcWNheLeNjzkMb1+Hl
         wAa6/zVqInR8md8jLX3bKQh950b/M4N9JcruXvsDtEN1lPVUwwQs4S7Ep6XlAqvBjX
         oDuR17jZUUiaPvpMxhwDZAuk6SGOR2NsFy8+sDTg4VZOyeCJbRtLHJ8ne9lFE5Qf4f
         M/vLQUfyjoiaJYR+HDFr9oHppG+LinFZW6u+SzvX/AfhJ9LlYskVg5zqFkWG82THSU
         HZncp1N/K0Ikw==
Date:   Thu, 24 Aug 2023 23:03:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <ZOfToAkO6JmB2VjC@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-5-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AAVu3c/qF8fiOZyC"
Content-Disposition: inline
In-Reply-To: <20230824210135.19303-5-posteuca@mutex.one>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AAVu3c/qF8fiOZyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 12:01:35AM +0300, Marian Postevca wrote:

> +static int acp_asoc_suspend_pre(struct snd_soc_card *card)
> +{
> +	int ret;
> +
> +	ret =3D acp_ops_suspend_pre(card);
> +	if (ret =3D=3D 1)
> +		return 0;
> +	else
> +		return ret;
> +}
> +
> +static int acp_asoc_resume_post(struct snd_soc_card *card)
> +{
> +	int ret;
> +
> +	ret =3D acp_ops_resume_post(card);
> +	if (ret =3D=3D 1)
> +		return 0;
> +	else
> +		return ret;
> +}

This feels like it should've been part of the prior commit adding
support for more complex cards?

> +	card->drvdata =3D (struct acp_card_drvdata *)pdev->id_entry->driver_dat=
a;
> +	acp_card_drvdata =3D card->drvdata;
> +	acp_card_drvdata->acpi_mach =3D (struct snd_soc_acpi_mach *)pdev->dev.p=
latform_data;

Similarly these changes in probe() -=20

> +	{
> +		.name =3D "acp3x-es83xx",
> +		.driver_data =3D (kernel_ulong_t)&es83xx_rn_data,
> +	},

The main thing I'd expect to see in the generic code in a patch adding a
specific driver is table entries like this and the ones you had earlier.

> +		if (drv_data->hs_codec_id =3D=3D ES83XX) {
> +			rc =3D acp_ops_configure_link(card, &links[i]);
> +			if (rc !=3D 0) {
> +				dev_err(dev, "Failed to configure link for ES83XX: %d\n", rc);
> +				return rc;
> +			}
> +		}

This function should ideally have been using switch statemnts but that's
not an issue your patch introduced.

> +#define ES83XX_ENABLE_DMIC	BIT(4)
> +#define ES83XX_48_MHZ_MCLK	BIT(5)

> +static void acp3x_es83xx_set_gpios_values(struct acp3x_es83xx_private *p=
riv,
> +					  bool speaker, bool headphone)
> +{
> +	gpiod_set_value_cansleep(priv->gpio_speakers, speaker);
> +	gpiod_set_value_cansleep(priv->gpio_headphone, headphone);
> +}

I'm not clear what this function buys us other than just calling gpiolib
directly in the DAPM events?

Otherewise the actual machine driver looks good.

--AAVu3c/qF8fiOZyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTn058ACgkQJNaLcl1U
h9C+6Qf/buPkvnVgpC2no/pdB8zhHyLMv07+iXkXTZAMyQgegTlySn+QOGI4+Z1N
DRm00mkx6rC9aiQlG2zEWeOQQloZBfSSUUnhVMmC5WAYaZc+6u2UtyrEsCczrYBl
9FGkqkzyPhOYkdKT6qsreKEZMfxkcFJZJ4hmW03EEfcPAA+bVmT5so/s4Mq45uBc
/B4oeaQBNriHY+AeifFBzP3MxAgF7fze/Ok23F4rK4pXlP5CW4+8cckb8lSCk6Ji
kZCiJBokbfHGWeYfvOZedsPjZTkkUd207sm/zXx9WH/imY3j6+UtNX2dT6KHpdtg
jiL0gW9bfFPN5HVQcQjQeRF8RzYK2w==
=aqSS
-----END PGP SIGNATURE-----

--AAVu3c/qF8fiOZyC--
