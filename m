Return-Path: <linux-kernel+bounces-163355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642F8B69C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB577B210FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB901759E;
	Tue, 30 Apr 2024 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YD9iG33F"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DB2F43;
	Tue, 30 Apr 2024 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454117; cv=none; b=nAR7imOfNMpnThG6hceShYbqmUN0I5TTMIRGRJDUvJTfzVvh+bs+cl08J7ZNKbSDps4w3nns9FLY/vJfHyFxzUSVZYthwIprz8+Iq6ua87mj7KDjeGRb302lBrdWq9/tABaKh77Y1uiafLvRd+nCWz3UT+phBh23vSypTHWTCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454117; c=relaxed/simple;
	bh=yFM2lX+Fko6THHEVGLRv2pdxRWq16pt18ov3gqJGfus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mKxXI1eqKTKyOxkfCmaojjTLRQrN7JS8Z4NJNUdSeuowif0ZnD18uNNz94jyPy873m2xkn9AekcaGblmKqJn0XiQcN+T7YTDvalTUpmY/pOPzUBAWZWrVv50A4tYaeKcQW/1mv1E4z7WqdqDOZ1SDdJl1075ODvnOcRR3JD8YkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YD9iG33F; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714454111;
	bh=SyLZnE161INd7TxlG7IGN3cfNQAjNdhBiUY91nhJtpE=;
	h=Date:From:To:Cc:Subject:From;
	b=YD9iG33FHfIL/cnyZ2IsVulaPrvNglE5PvbWa6BldCab+YiHPP+OJbenIZFMAjVkb
	 X/akmLEvj7ZEmGNT+zDgnhQM3HcLMNKzqb+qt8YpPLiLgckyAGMlzSlQdzw3hVVG9N
	 TlLENerqr5BD6QsYiok+7M3D04YoZ6bc0rrSW+/3s/FMPIDNZAGEko++xskSIoD/Am
	 pc+OS+8VW9GHyF/rQHfYbe7SXujclJXP/ED1D99ZDvMo3p8FIcKW+dQlmHmniXrnDp
	 +wE8qULHaQnEnv4OVYDe2c+TrSx41qDOrpCamVqCnbIuznOCRjIpjGCwD5PPXA/Neh
	 XG3L239QLsurw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT7gM0xdLz4wby;
	Tue, 30 Apr 2024 15:15:10 +1000 (AEST)
Date: Tue, 30 Apr 2024 15:15:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the iio tree with the iio-fixes tree
Message-ID: <20240430151510.0f49b40e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.9qz=rzYQ0tG4Q4QASCXUNi";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.9qz=rzYQ0tG4Q4QASCXUNi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iio tree got a conflict in:

  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c

between commit:

  d7230b995246 ("iio: invensense: fix timestamp glitches when switching fre=
quency")

from the iio-fixes tree and commit:

  a1432b5b4f4c ("iio: imu: inv_icm42600: add support of ICM-42686-P")

from the iio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 9cde9a9337ad,cfb4a41ab7c1..000000000000
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@@ -509,20 -512,20 +512,20 @@@ int inv_icm42600_buffer_fifo_parse(stru
  		return 0;
 =20
  	/* handle gyroscope timestamp and FIFO data parsing */
 -	ts =3D &gyro_st->ts;
 -	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
 -					st->fifo.nb.gyro, st->timestamp.gyro);
  	if (st->fifo.nb.gyro > 0) {
- 		ts =3D iio_priv(st->indio_gyro);
++		ts =3D &gyro_st->ts;
 +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
 +						st->timestamp.gyro);
  		ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);
  		if (ret)
  			return ret;
  	}
 =20
  	/* handle accelerometer timestamp and FIFO data parsing */
 -	ts =3D &accel_st->ts;
 -	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
 -					st->fifo.nb.accel, st->timestamp.accel);
  	if (st->fifo.nb.accel > 0) {
- 		ts =3D iio_priv(st->indio_accel);
++		ts =3D &accel_st->ts;
 +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
 +						st->timestamp.accel);
  		ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);
  		if (ret)
  			return ret;
@@@ -549,16 -554,20 +554,16 @@@ int inv_icm42600_buffer_hwfifo_flush(st
  		return 0;
 =20
  	if (st->fifo.nb.gyro > 0) {
- 		ts =3D iio_priv(st->indio_gyro);
+ 		ts =3D &gyro_st->ts;
 -		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
 -						st->fifo.nb.total, st->fifo.nb.gyro,
 -						gyro_ts);
 +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
  		ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);
  		if (ret)
  			return ret;
  	}
 =20
  	if (st->fifo.nb.accel > 0) {
- 		ts =3D iio_priv(st->indio_accel);
+ 		ts =3D &accel_st->ts;
 -		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
 -						st->fifo.nb.total, st->fifo.nb.accel,
 -						accel_ts);
 +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
  		ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);
  		if (ret)
  			return ret;

--Sig_/.9qz=rzYQ0tG4Q4QASCXUNi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYwfl4ACgkQAVBC80lX
0GxF/Af/bS1heTqPtajMFr5YRwV0Pu5rFKzkPL8BxetX1YY/uXJX5yKXAoCc7r/1
2lS74WwxA8bAAnMTuILlsx8V+UVFkOxZJBoNpPBWVUsbZeSadgXExip/FR6ENalW
LxwkdGqwtEh3tG91BHHIaaTMatWJJ0MxwAzpYJNX6zOKdEHS+KV7J1DRRGQpTw/I
ZPmaJ+k5YLI8PBH/HiWe/1r2S274jv52cs+YdZvbsOIaPke0Lq4Qbn9giLdYXYnO
uTg+MKj/oClCg4RMimbyhhgFovCk6borju1Ch5pHqI/5GpM3TA5IS7cwT99jDLLP
JnhpHxniUAawvx1ka78j0glI5g0B8g==
=V3xp
-----END PGP SIGNATURE-----

--Sig_/.9qz=rzYQ0tG4Q4QASCXUNi--

