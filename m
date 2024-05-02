Return-Path: <linux-kernel+bounces-166188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253AA8B9756
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935471F2108B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3055337A;
	Thu,  2 May 2024 09:14:01 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4017591;
	Thu,  2 May 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641240; cv=none; b=j1PpyYciq532X9Anr9z4Qqkh/bRBecHMN8BzyRCNFaVrYR1jcMtO/T/b5AbFSbIQJZEubmV0dmbn9XnLTtmZuj7hNsi9xa8/N/0OlXEP/wGtHuZBW+8Sl/p3jc+2yXqX4jjLhEgD7u5BAUyhdLOxHEXwxwRKOaMPd0bZXGb/8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641240; c=relaxed/simple;
	bh=SXEJU1F2gJzibggxU6WUh0B+WRELoNDshkPVumVraHE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daxjKsnT3tdSbm5cRdbf13ArERrABVXWn9mGEHg+WKdxaRXJAdunFXblOe0YQvZVE3xW6TWflQfzri+I5Z7c2iqtzX0ncHu8FHINKr78YTqw8DBIT4LZ+PtSQqz77i++JGbfe27ovsCOBq3Es0eogKlRkUABfL/BjkYI0tyG6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VVST13Lmbz67ZRh;
	Thu,  2 May 2024 16:55:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E30181408F9;
	Thu,  2 May 2024 16:58:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 May
 2024 09:58:35 +0100
Date: Thu, 2 May 2024 09:58:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iio tree with the iio-fixes
 tree
Message-ID: <20240502095834.00000e7c@Huawei.com>
In-Reply-To: <FR3P281MB1757A0D3F821CF506D79634ECE182@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240430151510.0f49b40e@canb.auug.org.au>
	<FR3P281MB1757A0D3F821CF506D79634ECE182@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

=20

On Thu, 2 May 2024 08:36:21 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Stephen and Jonathan,
>=20
> sorry for the mess, I should have warned Jonathan about it.
>=20
> The manual fix is obviously correct, no problem.
>=20
> Thanks and sorry for the inconvenience,
> JB

This should be sorted today.
Given timing (and busy week as ever!) I decided I didn't have enough fixes
to do a separate pull and the merge window is close.  So I dragged
the fixes across to the branch targeting the merge window and dealt with
the merge there.  The togreg-fixes branch should no longer have
thse fixes on it.

Jonathan


>=20
>=20
> ________________________________________
> From:=A0Stephen Rothwell
> Sent:=A0Tuesday, April 30, 2024 07:15
> To:=A0Jonathan Cameron
> Cc:=A0Jean-Baptiste Maneyrol; Linux Kernel Mailing List; Linux Next Maili=
ng List
> Subject:=A0linux-next: manual merge of the iio tree with the iio-fixes tr=
ee
>=20
>=20
> Hi all,
>=20
>=20
>=20
> Today's linux-next merge of the iio tree got a conflict in:
>=20
>=20
>=20
> =A0 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
>=20
>=20
>=20
> between commit:
>=20
>=20
>=20
> =A0 d7230b995246 ("iio: invensense: fix timestamp glitches when switching=
 frequency")
>=20
>=20
>=20
> from the iio-fixes tree and commit:
>=20
>=20
>=20
> =A0 a1432b5b4f4c ("iio: imu: inv_icm42600: add support of ICM-42686-P")
>=20
>=20
>=20
> from the iio tree.
>=20
>=20
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
>=20
> is now fixed as far as linux-next is concerned, but any non trivial
>=20
> conflicts should be mentioned to your upstream maintainer when your tree
>=20
> is submitted for merging.=A0 You may also want to consider cooperating
>=20
> with the maintainer of the conflicting tree to minimise any particularly
>=20
> complex conflicts.
>=20
>=20
>=20
> --
>=20
> Cheers,
>=20
> Stephen Rothwell
>=20
>=20
>=20
> diff --cc drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
>=20
> index 9cde9a9337ad,cfb4a41ab7c1..000000000000
>=20
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
>=20
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
>=20
> @@@ -509,20 -512,20 +512,20 @@@ int inv_icm42600_buffer_fifo_parse(stru
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>=20
> =A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 /* handle gyroscope timestamp and FIFO data pars=
ing */
>=20
> =A0-=A0=A0=A0=A0=A0=A0 ts =3D &gyro_st->ts;
>=20
> =A0-=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interrupt(ts, st->fifo.perio=
d, st->fifo.nb.total,
>=20
> =A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.gyro, st->timesta=
mp.gyro);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.gyro > 0) {
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_=
gyro);
>=20
> ++=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &gyro_st->ts;
>=20
> =A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_inte=
rrupt(ts, st->fifo.nb.gyro,
>=20
> =A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->t=
imestamp.gyro);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyr=
o_parse_fifo(st->indio_gyro);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
return ret;
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> =A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 /* handle accelerometer timestamp and FIFO data =
parsing */
>=20
> =A0-=A0=A0=A0=A0=A0=A0 ts =3D &accel_st->ts;
>=20
> =A0-=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interrupt(ts, st->fifo.perio=
d, st->fifo.nb.total,
>=20
> =A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.accel, st->timest=
amp.accel);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.accel > 0) {
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_=
accel);
>=20
> ++=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &accel_st->ts;
>=20
> =A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_inte=
rrupt(ts, st->fifo.nb.accel,
>=20
> =A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->t=
imestamp.accel);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_acc=
el_parse_fifo(st->indio_accel);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
return ret;
>=20
> @@@ -549,16 -554,20 +554,16 @@@ int inv_icm42600_buffer_hwfifo_flush(st
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>=20
> =A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.gyro > 0) {
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_=
gyro);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &gyro_st->ts;
>=20
> =A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_inte=
rrupt(ts, st->fifo.period,
>=20
> =A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->f=
ifo.nb.total, st->fifo.nb.gyro,
>=20
> =A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gyro_=
ts);
>=20
> =A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_inte=
rrupt(ts, st->fifo.nb.gyro, gyro_ts);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyr=
o_parse_fifo(st->indio_gyro);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
return ret;
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> =A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 if (st->fifo.nb.accel > 0) {
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_=
accel);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D &accel_st->ts;
>=20
> =A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_inte=
rrupt(ts, st->fifo.period,
>=20
> =A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->f=
ifo.nb.total, st->fifo.nb.accel,
>=20
> =A0-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 accel=
_ts);
>=20
> =A0+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_inte=
rrupt(ts, st->fifo.nb.accel, accel_ts);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_acc=
el_parse_fifo(st->indio_accel);
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
return ret;
>=20


