Return-Path: <linux-kernel+bounces-72577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8616485B571
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E2D1F21BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2345C611;
	Tue, 20 Feb 2024 08:38:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4915DF31
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418283; cv=none; b=TtnTC1bTrF5Ar6nPa+iKCRgnp1oEiC0QvdG+9Wg07aoM+I4rq09MR0Ucj3u8DHqFLoKGgfvziRitZkIChsXZjA4KrnpLmZ34x3IeTeRhrqGeTKpVBOahg0SGvn26g5qG03FD/3+HssBNxaJSyQ03kk+4zSFMWBGv1l1pV8C/P8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418283; c=relaxed/simple;
	bh=NUciA/1lTB1+Cosdgukk0rXblvpwTvsdBUdByBkfkeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2R5WgSr8RAdklmQY7C6J3S6VJX+wK5thGSqgI+Fyg7C+lpXXYMHlIgtF+/fRZCFIm4eeq7VNtyc+NeyjMN6Z3mAacOkF/E8LPJrHdyoq0AYmofHIEcWKmiSj5S2LJndx2tQUGANclJkAt4msP3B47ghscV+lctL9OrVJXioHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLdM-0007fA-JR; Tue, 20 Feb 2024 09:37:48 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLdL-001oAB-Ai; Tue, 20 Feb 2024 09:37:47 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 005FC292EAA;
	Tue, 20 Feb 2024 08:37:46 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:37:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] can: raw: raw_getsockopt(): reduce scope of err
Message-ID: <20240220-twig-dean-11e4f07f52b6-mkl@pengutronix.de>
References: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
 <CANn89iL7N-1zvBBLoz0qhCApVJRF1LKu=jSyC0yz-wHa3JLGNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stun4zbvotcra547"
Content-Disposition: inline
In-Reply-To: <CANn89iL7N-1zvBBLoz0qhCApVJRF1LKu=jSyC0yz-wHa3JLGNg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--stun4zbvotcra547
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.02.2024 09:25:58, Eric Dumazet wrote:
> On Tue, Feb 20, 2024 at 9:16=E2=80=AFAM Marc Kleine-Budde <mkl@pengutroni=
x.de> wrote:
> >
> > Reduce the scope of the variable "err" to the individual cases. This
> > is to avoid the mistake of setting "err" in the mistaken belief that
> > it will be evaluated later.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  net/can/raw.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/can/raw.c b/net/can/raw.c
> > index 897ffc17d850..2bb3eab98af0 100644
> > --- a/net/can/raw.c
> > +++ b/net/can/raw.c
> > @@ -756,7 +756,6 @@ static int raw_getsockopt(struct socket *sock, int =
level, int optname,
> >         struct raw_sock *ro =3D raw_sk(sk);
> >         int len;
> >         void *val;
> > -       int err =3D 0;
> >
> >         if (level !=3D SOL_CAN_RAW)
> >                 return -EINVAL;
> > @@ -766,7 +765,9 @@ static int raw_getsockopt(struct socket *sock, int =
level, int optname,
> >                 return -EINVAL;
> >
> >         switch (optname) {
> > -       case CAN_RAW_FILTER:
> > +       case CAN_RAW_FILTER: {
> > +               int err =3D 0;
> > +
> >                 lock_sock(sk);
> >                 if (ro->count > 0) {
> >                         int fsize =3D ro->count * sizeof(struct can_fil=
ter);
> > @@ -791,7 +792,7 @@ static int raw_getsockopt(struct socket *sock, int =
level, int optname,
> >                 if (!err)
> >                         err =3D put_user(len, optlen);
> >                 return err;
> > -
> > +       }
> >         case CAN_RAW_ERR_FILTER:
> >                 if (len > sizeof(can_err_mask_t))
> >                         len =3D sizeof(can_err_mask_t);
> > @@ -822,7 +823,9 @@ static int raw_getsockopt(struct socket *sock, int =
level, int optname,
> >                 val =3D &ro->xl_frames;
> >                 break;
> >
> > -       case CAN_RAW_XL_VCID_OPTS:
> > +       case CAN_RAW_XL_VCID_OPTS: {
> > +               int err =3D 0;
> > +
> >                 /* user space buffer to small for VCID opts? */
> >                 if (len < sizeof(ro->raw_vcid_opts)) {
> >                         /* return -ERANGE and needed space in optlen */
> > @@ -839,6 +842,7 @@ static int raw_getsockopt(struct socket *sock, int =
level, int optname,
> >                         err =3D put_user(len, optlen);
> >                 return err;
> >
> > +       }
> >         case CAN_RAW_JOIN_FILTERS:
> >                 if (len > sizeof(int))
> >                         len =3D sizeof(int);
> >
> > ---
> > base-commit: c8fba5d6df5e476aa791db4f1f014dad2bb5e904
> > change-id: 20240220-raw-setsockopt-f6e173cdbbbb
>=20
> What is the target tree ?

Sorry I have to fine tune my b4 setup, this targets net-next. And
depends on https://lore.kernel.org/all/20240219200021.12113-1-socketcan@har=
tkopp.net/

> In net-next tree, syzbot complained about a bug added in
>=20
> commit c83c22ec1493c0b7cc77327bedbd387e295872b6
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> Date:   Mon Feb 12 22:35:50 2024 +0100
>=20
>     can: canxl: add virtual CAN network identifier support
>=20
> Patch to fix the issue has not been sent yet ?
>=20
> diff --git a/net/can/raw.c b/net/can/raw.c
> index cb8e6f788af84ac65830399baac6d1cf3d093e08..897ffc17d850670003e5cf340=
2477e8fc201f61e
> 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -835,7 +835,9 @@ static int raw_getsockopt(struct socket *sock, int
> level, int optname,
>                         if (copy_to_user(optval, &ro->raw_vcid_opts, len))
>                                 err =3D -EFAULT;
>                 }
> -               break;
> +               if (!err)
> +                       err =3D put_user(len, optlen);
> +               return err;
>=20
>         case CAN_RAW_JOIN_FILTERS:
>                 if (len > sizeof(int))
>

The above mentioned patch fixes the issue introduced in c83c22ec1493
("can: canxl: add virtual CAN network identifier support").

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--stun4zbvotcra547
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXUZNcACgkQKDiiPnot
vG89EAf/SUME5QqEm+81Zh004IMgC8KZ4Nhv0diZXK1WVCy7XzQ/1dDkmS4A35Gp
o0zsuz/+tu35EPSt7/XoqaLlV5zwcxSNk+pmq9EdVq7hcX8dz4VujINdLQ+qlDv+
Fy+4V7vG3A9J0js5fS8bei1AjlByT34X+YPQ/CkVrzcU6DyxqdO2OVPJg+ZvP023
YiCrSjlvZpUkhNTd34Npqrk7lec14eEmStRa8Zo5Z01v3iZJxVGLnbVpRknZbujp
cES/ejGfhxjnC159oaijrhAKYd/mTB9OM5vxKWJO67SQTOGqmkWp9GfSHobSY+E2
4QyUFbHMiTh695ynSGk7qqT2cr/bzQ==
=Vdbz
-----END PGP SIGNATURE-----

--stun4zbvotcra547--

