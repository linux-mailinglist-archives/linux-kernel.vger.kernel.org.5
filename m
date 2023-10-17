Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEA77CBE38
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjJQIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:55:10 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A168E;
        Tue, 17 Oct 2023 01:55:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59F8C60012;
        Tue, 17 Oct 2023 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697532905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7iqwM5opDjnD+ixELUSySOVNyUQv89SINtLl3/UxmFE=;
        b=YLPmSv2BCtXDB0ajUoTbluwBFmwofXadtU+GsY+4Sr2bStC/+57qJWEqHQxugCysJoJknP
        /xES24Lgh/2iCrJ6gc7yDMdmhyFcxsPClA+nGs1zBJbYjmdnMazWn/GFZ5Ij1hd1/iYEOE
        rnGM6Lou0DwZIc0pn6ZJD1neN06P0aE0s9hFnJ2NWCTv4jEGZeXwQLDI8oLcKrCQmu51Es
        7Jaiw6FtcmzGD+tpz84+I5MJUp7c7og8dHm3VZNJP0PnF+sH4k76GF8Z+2YN+Oz/ROwvGD
        z2Tzp5Q1gVXIAkN0JI1fQPn1a/bIY4ituL/pt69IiaEMm5cR9NQcbCEJEEXjLA==
Date:   Tue, 17 Oct 2023 10:54:58 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v11 41/56] media: cedrus: Stop direct calls to queue
 num_buffers field
Message-ID: <ZS5L4l2PzQgpJXua@aptenodytes>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <20231012114642.19040-42-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5XMse7FBKsXwfxlj"
Content-Disposition: inline
In-Reply-To: <20231012114642.19040-42-benjamin.gaignard@collabora.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5XMse7FBKsXwfxlj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Thu 12 Oct 23, 13:46, Benjamin Gaignard wrote:
> Use vb2_get_num_buffers() and queue max_num_buffers field
> to avoid using queue num_buffer field directly.

Thanks for the patch, this is indeed a nice cleanup and safer usage.
Maybe the commit message needs to reflect why this change is welcome,
not just what is being changed.

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 8 ++++++--
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 9 +++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
> index dfb401df138a..95e490532a87 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -653,8 +653,12 @@ static void cedrus_h264_stop(struct cedrus_ctx *ctx)
> =20
>  	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> =20
> -	for (i =3D 0; i < vq->num_buffers; i++) {
> -		buf =3D vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
> +	for (i =3D 0; i < vb2_get_num_buffers(vq); i++) {
> +		struct vb2_buffer *vb =3D vb2_get_buffer(vq, i);
> +
> +		if (!vb)
> +			continue;

Please add a newline here to be consistent with the other block being chang=
ed.

With this change and the commit log reworked, you can consider this:
Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Thanks!

Paul

> +		buf =3D vb2_to_cedrus_buffer(vb);
> =20
>  		if (buf->codec.h264.mv_col_buf_size > 0) {
>  			dma_free_attrs(dev->dev,
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h265.c
> index fc9297232456..52e94c8f2f01 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -869,8 +869,13 @@ static void cedrus_h265_stop(struct cedrus_ctx *ctx)
> =20
>  	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
> =20
> -	for (i =3D 0; i < vq->num_buffers; i++) {
> -		buf =3D vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
> +	for (i =3D 0; i < vb2_get_num_buffers(vq); i++) {
> +		struct vb2_buffer *vb =3D vb2_get_buffer(vq, i);
> +
> +		if (!vb)
> +			continue;
> +
> +		buf =3D vb2_to_cedrus_buffer(vb);
> =20
>  		if (buf->codec.h265.mv_col_buf_size > 0) {
>  			dma_free_attrs(dev->dev,
> --=20
> 2.39.2
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--5XMse7FBKsXwfxlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmUuS+IACgkQ3cLmz3+f
v9GV5wf/TYcN6gfAAjC5SFlkLJBI/nxR5YwIXXCHBgPuQD+SDdeQNLb/OK6/EjCw
N8zdNrQdsMqz+Hm6oO5qJqU/MLD8+HLPgnFNSA/+tK7uynPhFwNaJ29bDaONj9KA
kPiJruAS/e5SXFfEdhWnHxSz+OQWvqrOBAZj/WV/OVvm/Azl9oXg67oLddms1HV7
5Gv7y0H2u60hmsjfTptTA1MwOKjZfKDpyuSr2iENNAiJTP1H6zjnY3f7aB5JjlP5
kWrZG+P/x6WrrX62qyWdHVq366vg9bNyLrkDyxMxz/tcjShPcfyQQ7cU/15IKpGi
uLOnI40+m0H1qMX4rElL2jp59ZfMLQ==
=Xf+i
-----END PGP SIGNATURE-----

--5XMse7FBKsXwfxlj--
