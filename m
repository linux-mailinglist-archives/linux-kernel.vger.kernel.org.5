Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3250776A251
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGaVB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGaVBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:01:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28052198C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFBA3612A3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA64C433C7;
        Mon, 31 Jul 2023 21:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690837314;
        bh=/af1zZWiqQuG4msuSwgVX59BL7GYrvPjiebALYQpKZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTRR7Kw46bEZDMtqcpQgGbYMB8EfuN8THtT8NlVr9Ue/2efQBJDUsQScuY2cx6CkD
         xK+xN8zJOMwuZHTwybOnZ/CKK0ls0gfIaVIotMaXd39ARAnySmhAV6HFv11R0D8W0D
         stdUK9WlCH6fjv74jwwiXhKsOXK+mA//bm5ckF5Cc1znJsGhOS+nS74UX8BSw+eteB
         TpIWAsmwRqp5E1qj3oyKDDFkVxIGZsRlPRSvSAa0nUNBI8v6Uspoub4YOiFApr2D/P
         eN8yTHcyUnUdQrejdU6Jj2vNQdT7oFanCuCxeJEPEjRZxSezF0UYrsTOZojUD0IvUE
         5KQv9jpIGj5Qg==
Received: by mercury (Postfix, from userid 1000)
        id 612111066A9E; Mon, 31 Jul 2023 23:01:51 +0200 (CEST)
Date:   Mon, 31 Jul 2023 23:01:51 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] hsi: controllers: Remove error checking for
 debugfs_create_dir()
Message-ID: <20230731210151.jc3yxdc5wddvqzld@mercury.elektranox.org>
References: <20230726123059.7196-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gi3v7s7lqozhel3u"
Content-Disposition: inline
In-Reply-To: <20230726123059.7196-1-machel@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gi3v7s7lqozhel3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 26, 2023 at 08:30:46PM +0800, Wang Ming wrote:
> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in bond_debug_reregister().

bond_debug_reregister()?

> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/hsi/controllers/omap_ssi_core.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index 84ba8b875..57c63053f 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -115,8 +115,6 @@ static int ssi_debug_add_ctrl(struct hsi_controller *=
ssi)

function can become void, if errors are ignored.

> =20
>  	/* SSI controller */
>  	omap_ssi->dir =3D debugfs_create_dir(dev_name(&ssi->device), NULL);
> -	if (!omap_ssi->dir)
> -		return -ENOMEM;

What about the second debugfs_create_dir() call in the same function?

> =20
>  	debugfs_create_file("regs", S_IRUGO, omap_ssi->dir, ssi,
>  								&ssi_regs_fops);

-- Sebastian

--gi3v7s7lqozhel3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTIITwACgkQ2O7X88g7
+pr4Bg/+KHZjmIdMwsIrXpHE5OAhX3SnikqJRQe5hagCdDbLu/BXE0TvlohwW5nb
NtvL0KX48L5wn/qctUve4xM0hbh0NEMg03k0szZr/xCgPsQ9sz6FAtFOfLdEVjbo
GpM/7N7h+P+3dk27hdwOiwwX84o0E5wIgfl9e8YEITsNNd93LwYaPFp67D8v5L6a
XPaoJWhg0ijXLrSPfNuOzyfIME7O0jTOVbckpXweSIfP2g0KtDAic/H+Qmh6hyTu
YHXQ48WDM/JO9fkZ6drgJaDWtAjbkgsq0RxlMv/3ygmFWPHMLf77V5Xo437o39dH
d2+spQaQIBKYXSw2Zcze5OWhoTs3y/eOWTYpq1DQrfZYyN6JzpHsPrGBxCcCGrm6
lrZphDhN7yeGeOEKaLuO7j5g3BEaH+VoOl1gQcIKf2y2b1xvL8QDtgU+M1pruWwn
OVgxCj9tATUz21QbGb+tKRjPVGPXRsA74jppQHXRi+iw2pG6ia7fijQ0T+7kaByM
/fjgi85FhN9xEx7N/JA2g/tdK/gDkgf+AK7rq+gpza5HfeTZ94M3WTSKVX7gLAg+
hhTelU9oK6MFC92+FM0Z5wLU4IidDCilQZYXb2YUIfYrj7DVaiMvH+gxiY1zLqJu
c2RASN5IiIhs4zR45BaUUFRX/aqOBXtL5cLdmoym4OQGCmWZbHE=
=kN2r
-----END PGP SIGNATURE-----

--gi3v7s7lqozhel3u--
