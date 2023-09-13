Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48AF79F0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjIMRw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIMRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:52:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6750B19AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:52:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB27BC433C7;
        Wed, 13 Sep 2023 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694627573;
        bh=b1AmbBkOQZtNPVrxWEpMwdwlbIc78MbgdnHQVD4Kw7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojF0T9gCzQUwiaKR4KQaFy5qfyvO71Rl0aZskv0uRZ8IiNMbOhwsASfpEMpP77NCW
         kBiguZx0JsWT030J93HyCFMLlVBJiKyT4aF+AEypRGUkg060f5xjcQbwt8E01XTLjh
         tA6NuSfxROwFLPe8rmEtqyci+GqhIMy/v7M+Xu1dasKG/XaWV7oBlKnQf7iz6MgAV8
         K6ZoGzHFXi3vWk7GqVxPRJQmsl19VDAlsOYsClPD9dDP8ZXKDwU838wL2E6KG9lT3c
         4dnJBmve4pawL5sLNGyCsXmfyFv9zje72eilVQCv6/lGviwBXD69L5jebFPjZi5QN4
         mmbUnxlm4l32g==
Date:   Wed, 13 Sep 2023 18:52:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Myunguk Kim <mwkim@gaonchips.com>
Cc:     alsa-devel@alsa-project.org, fido_max@inbox.ru,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        u.kleine-koenig@pengutronix.de, xingyu.wu@starfivetech.com
Subject: Re: [PATCH] [v2] ASoC: dwc: fix typo in comment
Message-ID: <64683b6c-1e31-4037-a47d-b8a19ea77c72@sirena.org.uk>
References: <20230913024103.1454354-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9eUilMpxS1kv3IO2"
Content-Disposition: inline
In-Reply-To: <20230913024103.1454354-1-mwkim@gaonchips.com>
X-Cookie: Use extra care when cleaning on stairs.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9eUilMpxS1kv3IO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:41:04AM +0900, Myunguk Kim wrote:
> ISR_RXFO means "Status of Data Overrun interrupt for the RX channel"
> according to the datasheet.
>=20
> So, the comment should be RX, not TX

This patch still doesn't apply:

> =20
> -		/* Error Handling: TX */
> +		/* Error Handling: RX */
>  		if (isr[i] & ISR_RXFO)=20
> { 			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=3D%d)\n", i);

The patch is obviously corrupted, the { there should be on the prior
line and even fixing that by hand there appear to be some other issues.

--9eUilMpxS1kv3IO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUB9u8ACgkQJNaLcl1U
h9AXFwf+IJcl0QeR/u0zwMxJdNm7pnY84e90fqyx2T1cPDWa5jz/umlEoBcsdOkU
HC4VUl36XEYT++cfL4mCcpjurJMs23rVWXu9You1YK799zpQhXXxDyqhYV4pOC7f
+jngsR1ucOc6SlLyUN9tzz35xsOi0o63p63S4h7smA3s1qtMkPJkrsc/+wD8iRcq
YnYYZYoy5IBi3l8kfBcsuaEeuV8nDZG6KAXAlRcOSb7CPrq533psIJiVaz/mGy/I
5SudVorJAiW0q1Uu0i9wyji1dRZ8qc7Vp2rqfGw2oUCt3PT7SHTwiCV6Mot8a3op
44Kbp0uZ8AKBOpoJDgFBgAYkJ6vlnQ==
=zaKM
-----END PGP SIGNATURE-----

--9eUilMpxS1kv3IO2--
