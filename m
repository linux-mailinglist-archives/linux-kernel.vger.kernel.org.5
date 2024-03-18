Return-Path: <linux-kernel+bounces-106295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B5487EC13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EF41F21CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286964F201;
	Mon, 18 Mar 2024 15:24:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9484F1E3;
	Mon, 18 Mar 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775494; cv=none; b=gli7FOGOVQrRaXgHeZmaprCD4otMo4Ev3MQdG2ISooikYazkFCAuGsJjYFCJcFrgY7z9eF8M5WQ8VWIDFG8Np58tSUPlfvsE6Fp0lUFsbWUBw//kIlfJ683tfplHyaNHX0TQ7/8grIXkKDApsiRE/J+N6jnBL173l9Y0eWDtZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775494; c=relaxed/simple;
	bh=TW2sVKXmKodNGaQrOPxiyaWbuxEcgOd4Z5b5YRJ1Vrk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3utBA7WVyMa7m2XSdfMmt69hyuAqGh8krFfMo4EztcT7D113zB0OyPNW0m+X7u4H64rhxayDVxvZBoQ5/3MtttT9uHGn9YqT1epE94SkfYt9zqqroCW/ai7eT6laYMDnjhvfi4LFS37PKW0uG0hqemlHcndAUSDpb8X9Wp06no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TyzD607c6z6K6Pl;
	Mon, 18 Mar 2024 23:24:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E2E1140A30;
	Mon, 18 Mar 2024 23:24:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 15:24:47 +0000
Date: Mon, 18 Mar 2024 15:24:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sean Anderson <sean.anderson@linux.dev>
CC: Jonathan Cameron <jic23@kernel.org>, "O'Griofa, Conall"
	<conall.ogriofa@amd.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Message-ID: <20240318152446.00001345@Huawei.com>
In-Reply-To: <7ee83f15-88fc-4530-84b7-b8ee31663dbc@linux.dev>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
	<20240314154824.37150a54@jic23-huawei>
	<a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
	<DM6PR12MB4217EAA1049F815F234EE6D18B282@DM6PR12MB4217.namprd12.prod.outlook.com>
	<3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
	<20240316133627.5d2bf585@jic23-huawei>
	<7ee83f15-88fc-4530-84b7-b8ee31663dbc@linux.dev>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Mar 2024 11:18:43 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 3/16/24 09:36, Jonathan Cameron wrote:
> > On Fri, 15 Mar 2024 13:47:40 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >  =20
> >> Hi Conall,
> >>=20
> >> On 3/15/24 09:18, O'Griofa, Conall wrote: =20
> >> > [AMD Official Use Only - General]
> >> >=20
> >> > Hi,
> >> >=20
> >> > I think there was a fix for this issue applied to the version that w=
as running on 5.15 that didn't seem to make it into the upstream driver.
> >> > Please see link for reference https://github.com/Xilinx/linux-xlnx/c=
ommit/608426961f16ab149b1b699f1c35f7ad244c0720
> >> >=20
> >> > I think a similar fix to the above patch is may be beneficial?   =20
> >>=20
> >> These patches look functionally identical to me. =20
> >=20
> > Because there are no channels with scan index between
> > 22 * 2 + 16 (that patch) and 22 * 3 (your patch) that is
> > the effect is indeed the same. But given the issues is the
> > 64 limit on maximum scan index, 22 * 3 =3D 66 is an ugly value
> > to compare with.
> >=20
> > I'm still very against the use of scan_index for anything other
> > than scan indices (which is why partly how this bug wasn't noticed
> > in the first palce). So the check should be scan_index !=3D -1
> > and uses of those values elsewhere in the driver should be fixed
> > (which looks simple to do from a quick glance at the code). =20
>=20
> OK, so how do the sysfs files get named then?

Using channel and channel2 as appropriate (+ index and modified
which change the meaning of channel2) - scan_index never had
anything to do with sysfs file names - just the value in
bufferX/in_xyz_scan_index

>=20
> --Sean
>=20
> >>=20
> >> --Sean
> >>  =20
> >> >> -----Original Message-----
> >> >> From: Sean Anderson <sean.anderson@linux.dev>
> >> >> Sent: Thursday, March 14, 2024 5:30 PM
> >> >> To: Jonathan Cameron <jic23@kernel.org>
> >> >> Cc: linux-iio@vger.kernel.org; O'Griofa, Conall <conall.ogriofa@amd=
com>;
> >> >> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;=
 Lars-Peter
> >> >> Clausen <lars@metafoo.de>
> >> >> Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channe=
ls in
> >> >> scan_mask
> >> >>
> >> >> Caution: This message originated from an External Source. Use prope=
r caution
> >> >> when opening attachments, clicking links, or responding.
> >> >>
> >> >>
> >> >> On 3/14/24 11:48, Jonathan Cameron wrote:   =20
> >> >> > On Mon, 11 Mar 2024 12:28:00 -0400
> >> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >> >   =20
> >> >> >> ams_enable_channel_sequence constructs a "scan_mask" for all the=
 PS
> >> >> >> and PL channels. This works out fine, since scan_index for these
> >> >> >> channels is less than 64. However, it also includes the
> >> >> >> ams_ctrl_channels, where scan_index is greater than 64, triggeri=
ng
> >> >> >> undefined behavior. Since we don't need these channels anyway, j=
ust   =20
> >> >> exclude them.   =20
> >> >> >>
> >> >> >> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> >> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>   =20
> >> >> >
> >> >> > Hi Sean,
> >> >> >
> >> >> > I'd ideally like to understand why we have channels with such lar=
ge
> >> >> > scan indexes.  Those values should only be used for buffered capt=
ure.
> >> >> > It feels like they are being abused here.  Can we set them to -1
> >> >> > instead and check based on that?
> >> >> > For a channel, a scan index of -1 means it can't be captured via =
the
> >> >> > buffered interfaces but only accessed via sysfs reads.
> >> >> > I think that's what we have here?   =20
> >> >>
> >> >> From what I can tell, none of the channels support buffered reads. =
And we can't
> >> >> nai=CC=88vely convert the scan_index to -1, since that causes sysfs=
 naming conflicts
> >> >> (not to mention the compatibility break).
> >> >>   =20
> >> >> >
> >> >> > I just feel like if we leave these as things stand, we will get b=
itten
> >> >> > by similar bugs in the future.  At least with -1 it should be obv=
ious why!   =20
> >> >>
> >> >> There are just as likely to be bugs confusing the PL/PS subdevices.=
.
> >> >>
> >> >> FWIW I had no trouble identifying the channels involved with this b=
ug.
> >> >>
> >> >> --Sean
> >> >>   =20
> >> >> > Jonathan
> >> >> >
> >> >> >   =20
> >> >> >> ---
> >> >> >>
> >> >> >>  drivers/iio/adc/xilinx-ams.c | 8 ++++++--
> >> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> >> >>
> >> >> >> diff --git a/drivers/iio/adc/xilinx-ams.c
> >> >> >> b/drivers/iio/adc/xilinx-ams.c index a55396c1f8b2..4de7ce598e4d
> >> >> >> 100644
> >> >> >> --- a/drivers/iio/adc/xilinx-ams.c
> >> >> >> +++ b/drivers/iio/adc/xilinx-ams.c
> >> >> >> @@ -414,8 +414,12 @@ static void ams_enable_channel_sequence(str=
uct
> >> >> >> iio_dev *indio_dev)
> >> >> >>
> >> >> >>      /* Run calibration of PS & PL as part of the sequence */
> >> >> >>      scan_mask =3D BIT(0) | BIT(AMS_PS_SEQ_MAX);
> >> >> >> -    for (i =3D 0; i < indio_dev->num_channels; i++)
> >> >> >> -            scan_mask |=3D BIT_ULL(indio_dev->channels[i].scan_=
index);
> >> >> >> +    for (i =3D 0; i < indio_dev->num_channels; i++) {
> >> >> >> +            const struct iio_chan_spec *chan =3D
> >> >> >> + &indio_dev->channels[i];
> >> >> >> +
> >> >> >> +            if (chan->scan_index < AMS_CTRL_SEQ_BASE)
> >> >> >> +                    scan_mask |=3D BIT_ULL(chan->scan_index);
> >> >> >> +    }
> >> >> >>
> >> >> >>      if (ams->ps_base) {
> >> >> >>              /* put sysmon in a soft reset to change the sequenc=
e */   =20
> >> >> >   =20
> >>  =20
> >  =20
>=20
>=20


