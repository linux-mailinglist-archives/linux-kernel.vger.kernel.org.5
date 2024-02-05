Return-Path: <linux-kernel+bounces-52372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E8849744
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BEDB29D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB413ADC;
	Mon,  5 Feb 2024 10:02:17 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E482134AD;
	Mon,  5 Feb 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127336; cv=none; b=oInmrGlfnkdCjOK/0Cr/hzVdd12t4mizyi+Bfd3uDuM6eH+2itBo2ccz7HtUHZXK1ayzhkChXGW+pqxhu5q4oNxGRSnQBJZN9KbSGxpOraFSGMyJopfq2ZzVkNxvl1wfWKSUxRKGDXJC/RE04y1tqzmJNkejpcRt3OqtBjHkkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127336; c=relaxed/simple;
	bh=4UlEdegse0xj/aiSfkUSBvGZQSCroJZBHG3ahKgJi3E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muK03NJVhVCbvRLXAvoSboj4gAoxF65DIZ27+/45SID9MBNVezbkiiQlSmoeEgEJFPGzlej5lVwcdo9X4KMZSv+QWaX3T1CQKuwHp6pFjnLVEJnPnu8SrJjuoMBifKBHI85TYgkr+tX8UiqhMVZ/Qk8d5/6S7oAnodsa2FaAZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT2015tGWz6G9LT;
	Mon,  5 Feb 2024 17:58:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E841A140D1A;
	Mon,  5 Feb 2024 18:02:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 10:02:09 +0000
Date: Mon, 5 Feb 2024 10:02:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jesus Miguel Gonzalez Herrero <jesusmgh@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow
 binding on some devices
Message-ID: <20240205100208.00007a50@Huawei.com>
In-Reply-To: <a449f603-8079-468c-9a28-be32ae96f83a@gmail.com>
References: <20240202173040.26806-2-jesusmgh@gmail.com>
	<20240204140010.7edaa782@jic23-huawei>
	<a449f603-8079-468c-9a28-be32ae96f83a@gmail.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 4 Feb 2024 18:53:42 +0100
Jesus Miguel Gonzalez Herrero <jesusmgh@gmail.com> wrote:

> Hello Mr. Cameron
>=20
> First of all thank you for reviewing the patch.
>=20
> And I most definitely agree with you and Mr. Shevchenko: this absolutely
> is a firmware bug that manufacturers should fix. For this reason some
> people started talks with affected manufacturers to change it. In my
> case it was with GPD, together with some others, including some which
> historically had a more direct line with them. This was finally dismissed
> as WONTFIX, since their main focus is Windows and their driver supports
> the ID, so the end result of those conversations is a lack of a fixed
> firmware, and a surplus of frustration.
>=20
> As far as I know people have been in talks with Aya too, and I do not
> know the status of conversations with Lenovo or other manufacturers. I
> do not know of any conversation with Realtek, besides what was mentioned
> in those emails you linked to from 2021.
>=20
> I will amend the patch to include a big disclaimer and the reason as
> a comment in the code, and send it again in reply to this message. I
> don't think I'd go as far as tainting the kernel, but I'm not opposed,
> happy anyway if the IMU finally becomes usable, and VERY far from any
> expertise whatsoever concerning kernel development!
>=20
> Here is the relevant extract from the DSDT of my GPD Win Max 2 (AMD
> 6800U model) with the latest firmware 1.05 installed.

Great - This is exactly the info that should support such a patch like this.

Include the blob below and a statement that GPD have refused to fix due
to the windows driver in the patch description and I'm fine with taking thi=
s.

I may see if I can dig out a Lenovo contact as they are big enough and
have been around long enough to know better... (big company mess however
I'm sure...)

Jonathan


>=20
>  =A0=A0=A0 Scope (_SB.I2CC) {
>  =A0=A0=A0=A0=A0=A0=A0 Device (BMA2) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (_ADR, Zero)=A0 // _ADR: Address =
Name (_HID, "10EC5280")
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // _HID: Hardware ID Name (_CID, "10EC=
5280")=A0 // _CID:
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Compatible ID Name (_DDN, "Acceleromet=
er")=A0 // _DDN: DOS
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Device Name Name (_UID, One)=A0 // _UI=
D: Unique ID Method
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (_CRS, 0, NotSerialized)=A0 // _CRS: C=
urrent Resource Settings {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (RBUF, ResourceTempla=
te () {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I2cSerialBusV2=
 (0x0069, ControllerInitiated,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00061A80,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Ad=
dressingMode7Bit, "\\_SB.I2CC", 0x00,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Re=
sourceConsumer, , Exclusive, )
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }) Return (RBUF) /* \_SB_.=
I2CC.BMA2._CRS.RBUF */
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 OperationRegion (CMS2, SystemIO, 0x72,=
 0x02) Field (CMS2,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ByteAcc, NoLock, Preserve) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IND2,=A0=A0 8, DAT2,=A0=A0=
 8
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IndexField (IND2, DAT2, ByteAcc, NoLoc=
k, Preserve) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Offset (0x74), BACS,=A0=A0=
 32
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Method (ROMS, 0, NotSerialized) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Name (RBUF, Package (0x03)=
 {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "0 -1 0", "-1 =
0 0", "0 0 1"
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }) Return (RBUF) /* \_SB_.=
I2CC.BMA2.ROMS.RBUF */
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Method (CALS, 1, NotSerialized) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Local0 =3D Arg0 If (((Loca=
l0 =3D=3D Zero) || (Local0 =3D=3D
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Ones))) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Return (Local0)
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } Else {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BACS =3D Local0
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Method (_STA, 0, NotSerialized)=A0 // =
_STA: Status {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Return (0x0F)
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0 }
>=20
> Thank you for taking this into consideration!
>=20
> Jesus Gonzalez
>=20
>=20
>=20
> On 04/02/2024 15:00, Jonathan Cameron wrote:
> > On Fri,  2 Feb 2024 18:30:41 +0100
> > Jesus Gonzalez <jesusmgh@gmail.com> wrote:
> > =20
> >> "10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (=
and
> >> probably others) in their ACPI table as the ID for the bmi160 IMU. This
> >> means the bmi160_i2c driver won't bind to it, and the IMU is unavailab=
le
> >> to the user. Manufacturers have been approached on several occasions to
> >> try getting a BIOS with a fixed ID, mostly without actual positive
> >> results, and since affected devices are already a few years old, this =
is
> >> not expected to change. This patch enables using the bmi160_i2c driver=
 for
> >> the bmi160 IMU on these devices. =20
> > Hi Jesus,
> >
> > https://lore.kernel.org/lkml/CAHp75Vct-AXnU7QQmdE7nyYZT-=3Dn=3Dp67COPLi=
iZTet7z7snL-g@mail.gmail.com/
> > Lays out what Andy (and for that matter I) consider necessary for such
> > a patch.
> >
> > In short, we want to see devices called out here - with a DSDT section.
> > + a clear comment in the code.
> >
> > The big problem here is this tramples on Realtech's ID space. It's not =
just
> > a made up code (incidentally the BMI0160 isn't valid either),
> > it's a valid code but for an entirely different (PCI) device.
> >
> > So we need as much info as possible in the patch description and the dr=
iver
> > itself to justify carrying this.   Tempting to add a firmware bug taint=
 on
> > it as well but that might scare people :)
> >
> > Jonathan
> >
> > =20
> >> Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
> >> ---
> >> A device-specific transformation matrix can then be provided in a seco=
nd
> >> step through udev hwdb.
> >>
> >> This has been discussed before in 2021, see here:
> >> https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=3D0tvenPzAcwwW1pTaR6a+A=
EWBF9Hqf_wXQ@mail.gmail.com/
> >>
> >> Lenovo, as an example of a big manufacturer, is also using this ID:
> >> https://www.reddit.com/r/linux/comments/r6f9de/comment/hr8bdfs/?contex=
t=3D3
> >>
> >> At least some discussions with GPD took place on the GPD server Discor=
d,
> >> for which I can provide proof on demand via screenshot (if not accessi=
ble
> >> directly).
> >>
> >> I have read the patch submission instructions and followed them to the
> >> best of my knowledge. Still, this is my first kernel patch submission,
> >> so I'd be glad if you could please point out any mistakes. Thank you!
> >>
> >>
> >>   drivers/iio/imu/bmi160/bmi160_spi.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi=
160/bmi160_spi.c
> >> index 8b573ea99af2..0874c37c6670 100644
> >> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> >> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> >> @@ -41,6 +41,7 @@ MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
> >>  =20
> >>   static const struct acpi_device_id bmi160_acpi_match[] =3D {
> >>   	{"BMI0160", 0},
> >> +	{"10EC5280", 0},
> >>   	{ },
> >>   };
> >>   MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match); =20
>=20


