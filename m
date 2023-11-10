Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856F7E8192
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbjKJSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjKJS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:06 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7A9EEA;
        Fri, 10 Nov 2023 00:33:37 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECCC7FF816;
        Fri, 10 Nov 2023 08:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699605215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gB43CUZmJbt1uK77TzguVku9sEfalDL3rG9/cdJIn2s=;
        b=mIP+a2PTDV/8iO84GywCAxWKSOAkV4Tz75EPrMTwnlyaXLCJYGq6wwTCzMfE0De3jpru4+
        SDdBoEdhZf0y3H5qhE55wxVmj7oT15D8MklPT8f9UQ38BFsbnaGPRxKPCEH23WKxIGZ6j7
        kAWx1QrpPFF6FUaJoSTTFYLSN/k8t9PIAKgaWdojBX4U16/csE2Qa3OiKPWjqa4G7eASbV
        QBaYcnJAnwNnruhSAuDzfiIdt/oB0Co4QCZyk0xCw7E5+ZLbilbNQ02liNpfVoFCCdw2xI
        BCVs6rvkT4viovqOK7Kcq6HS0wTYqpNCzWlXC44PBNL6VrfRfdZxgOsMy4JkqQ==
Date:   Fri, 10 Nov 2023 09:33:31 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/4] media: verisilicon: Hook the (TRY_)DECODER_CMD
 stateless ioctls
Message-ID: <ZU3q2y_QA6Pznvtf@aptenodytes>
References: <20231109201640.340556-1-paul.kocialkowski@bootlin.com>
 <20231109201640.340556-3-paul.kocialkowski@bootlin.com>
 <fd9ca918dcbc892169b9f0dae7d0de537f4035ed.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MXm4gGfTLjHj6aB"
Content-Disposition: inline
In-Reply-To: <fd9ca918dcbc892169b9f0dae7d0de537f4035ed.camel@collabora.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MXm4gGfTLjHj6aB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu 09 Nov 23, 16:38, Nicolas Dufresne wrote:
> Le jeudi 09 novembre 2023 =C3=A0 21:16 +0100, Paul Kocialkowski a =C3=A9c=
rit=C2=A0:
> > The (TRY_)DECODER_CMD ioctls are used to support flushing when holding =
capture
> > buffers is supported. This is the case of this driver but the ioctls we=
re never
> > hooked to the ioctl ops.
> >=20
> > Add them to correctly support flushing.
>=20
> While this CMD looks useful on paper, we have had no use for it in any
> open source user space. So with this in mind, shall we really enable it
> ? How can we be sure that its actually working as intended ?

Well I think it's part of the spec that it needs to be supportd.

I must admit I have never used it in a real use case either, but it can be =
fixed
later (without changing the uAPI) if the implementation turns out to be
malfunctioning.

Cheers,

Paul

> > Fixes: 340ce50f75a6 ("media: hantro: Enable HOLD_CAPTURE_BUF for H.264")
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/media/platform/verisilicon/hantro_drv.c  | 2 ++
> >  drivers/media/platform/verisilicon/hantro_v4l2.c | 3 +++
> >  2 files changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/=
media/platform/verisilicon/hantro_drv.c
> > index a9fa05ac56a9..3a2a0f28cbfe 100644
> > --- a/drivers/media/platform/verisilicon/hantro_drv.c
> > +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> > @@ -905,6 +905,8 @@ static int hantro_add_func(struct hantro_dev *vpu, =
unsigned int funcid)
> > =20
> >  	if (funcid =3D=3D MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
> >  		vpu->encoder =3D func;
> > +		v4l2_disable_ioctl(vfd, VIDIOC_TRY_DECODER_CMD);
> > +		v4l2_disable_ioctl(vfd, VIDIOC_DECODER_CMD);
> >  	} else {
> >  		vpu->decoder =3D func;
> >  		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
> > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers=
/media/platform/verisilicon/hantro_v4l2.c
> > index b3ae037a50f6..db145519fc5d 100644
> > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > @@ -785,6 +785,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops =3D {
> >  	.vidioc_g_selection =3D vidioc_g_selection,
> >  	.vidioc_s_selection =3D vidioc_s_selection,
> > =20
> > +	.vidioc_decoder_cmd =3D v4l2_m2m_ioctl_stateless_decoder_cmd,
> > +	.vidioc_try_decoder_cmd =3D v4l2_m2m_ioctl_stateless_try_decoder_cmd,
> > +
> >  	.vidioc_try_encoder_cmd =3D v4l2_m2m_ioctl_try_encoder_cmd,
> >  	.vidioc_encoder_cmd =3D vidioc_encoder_cmd,
> >  };
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--3MXm4gGfTLjHj6aB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVN6tsACgkQ3cLmz3+f
v9GVsgf8DMLAlPBim8kfNcpPsxElmqMySid66bm7l6rB8E0DGEkIhTw6taMy9Ymh
5auzxmmd70FN07tX+OIUj6Pmal3Cj89meSTs51d08lSFQYJfhoQYbEQW1dt1sV+F
T5CUni7z0F0oiWcCYDAwYcWoeB2FvUdzONn5eI++jJCwr4JQjnc1N1QoAFnhCjUe
sx0VbiGR0kzbzAkMzn58RsignlPo4ogTCdUhabzlsc89nKWHxKdQZFlRvgqWC2Zy
A1oHds2fjTEtUklvB9f8QwEaTTXqS1QtocDVXsCKe3Y6ye0atsjNCLpnPRNmP2ZP
qbC23m0lvg48Zm78iBtBZK5KTgZD2A==
=st8d
-----END PGP SIGNATURE-----

--3MXm4gGfTLjHj6aB--
