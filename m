Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFAC7E2B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjKFR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjKFR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:58:59 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D231FD47;
        Mon,  6 Nov 2023 09:58:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81CDA20003;
        Mon,  6 Nov 2023 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699293532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghK2kxsjca6u59VkbLnWStX76G5XSjL+RnTMtyq6xsk=;
        b=aWF7NFZGmGlV2OGNuo6DWXwKWAKwyn1teyXFIvU68LTUamCExtuHmUY7xWGR+smJxW6LZi
        P7bB0G/AzRvhQSj7HDFFhOZDBlj3OCIyVn6EBL/bmDC6AMiWPqdWhjZWbii7FJQ+8EVLf0
        jsDMGiNEO6YQFXuyCS9z0xOOzUtGdW9BE7WAOa67YXOt4r8G98KglPlJYhsnYVGwUJT45F
        DuaMouncyrxWQLer6xhFlu0Ehh4MnI0T2tV5n+8R19uZJKwiY/zYEQ7LLxT5SlquWNmoU/
        npaR/i32JeUTPH0bs7du4pVI6bUpPg5Pj31TqLKd21EH2q99+pO8ybCybQshtQ==
Date:   Mon, 6 Nov 2023 18:58:51 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v7 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Message-ID: <ZUkpWzw_5SdqqL2X@aptenodytes>
References: <cover.1697463708.git.mehdi.djait@bootlin.com>
 <c3cd9002b2db69a6fb155722adc8410cd6e1f9ab.1697463708.git.mehdi.djait@bootlin.com>
 <ZUNz_h1fn9RH9Uc5@aptenodytes>
 <ZUj/FQTyajQJrxoU@pc-70.home>
 <ZUkFXl7vBS36y4Qi@aptenodytes>
 <ZUkLHDH2Budi+zgc@pc-70.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5gPrNW+ynBXLwBH9"
Content-Disposition: inline
In-Reply-To: <ZUkLHDH2Budi+zgc@pc-70.home>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5gPrNW+ynBXLwBH9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon 06 Nov 23, 16:49, Mehdi Djait wrote:
> Hi Paul,
>=20
> On Mon, Nov 06, 2023 at 04:25:18PM +0100, Paul Kocialkowski wrote:
> > > > > +static void tw9900_fill_fmt(const struct tw9900_mode *mode,
> > > > > +			    struct v4l2_mbus_framefmt *fmt)
> > > > > +{
> > > > > +	fmt->code =3D MEDIA_BUS_FMT_UYVY8_2X8;
> > > > > +	fmt->width =3D mode->width;
> > > > > +	fmt->height =3D mode->height;
> > > > > +	fmt->field =3D V4L2_FIELD_NONE;
> > > > > +	fmt->quantization =3D V4L2_QUANTIZATION_DEFAULT;
> > > > > +	fmt->colorspace =3D V4L2_COLORSPACE_SMPTE170M;
> > > > > +	fmt->xfer_func =3D V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_S=
MPTE170M);
> > > > > +	fmt->ycbcr_enc =3D V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_S=
MPTE170M);
> > > > > +}
> > > > > +
> > > > > +static int tw9900_cfg_fmt(struct v4l2_subdev *sd,
> > > >=20
> > > > You might have to differentiate between set_fmt/get_fmt to return -=
EBUSY
> > > > if streaming is on in set_fmt. However I understand it will just co=
py the
> > > > current mode in both cases, but this might still be required to fol=
low v4l2
> > > > semantics (please double-check).
> > > >=20
> > >=20
> > > This should be done in the driver calling the pad subdev_call set_fmt,
> > > right ?
> >=20
> > Well the two things are distinct, even though it's not obvious to think=
 about
> > a case where you wouldn't have a video device to grab the frames.
> >=20
> > For instance you can see this being done here:
> > https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov5648=
=2Ec#L2259
> >=20
> > I'm just not sure about what the V4L2 subdev API mandates. It would be =
useful
> > to find some piece of documentation that clarifies the requirement.
>=20
> Ok, I will split the functions then.

I was more interested in finding out the right answer rather than having you
follow an example from another driver. You can see the docs at:
https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/vidioc-subde=
v-g-fmt.html#return-value

So I think it's a good measure to return -EBUSY here. You can just have set=
_fmt
call into get_fmt with an extra check before.

Also see the part about the which field. I'm not sure it should have
implications in your case but better double-check that too.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--5gPrNW+ynBXLwBH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVJKVsACgkQ3cLmz3+f
v9EozAf+I00QqYcdUt8VF0JbQM85Fr2jjcK8jqzkaoPKyO+IQ9JDQprTRzr00mlG
9ak7DQSV40QQs3OTTRk5GYEf9ujs6GA34Yn+HjECqYEs9aabQYnGq7Xqc8vM1+5q
DPPk0jPcQtdi04lZGmDhAi0XhrLLt2kPvofX1mU4CbX1qQALMRalsuZDF2PTv20p
b3+T/Fx67uzJ+OgeP+mUIskgg7lE4l5/FiYeBmOB292OUZF5wB5yeYJLVOcDFue0
BuoXk65TQXToVPZhk8AIjgRRthXDt2ztvzFaVh7v+MGmZa1DXULac0WIY8E5dUxV
e0pL3Vr7WomhFpx70zYT3p0gMUDXKg==
=wFvV
-----END PGP SIGNATURE-----

--5gPrNW+ynBXLwBH9--
