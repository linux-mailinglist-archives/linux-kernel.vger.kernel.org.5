Return-Path: <linux-kernel+bounces-9717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9C81CA24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65722B21388
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEEF182BB;
	Fri, 22 Dec 2023 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHtSJWT7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A41199A1;
	Fri, 22 Dec 2023 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703249015; x=1734785015;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=P1X6gMeflE5Q6oi2eBhZQPWUJG5lhfXKzk+M36CKQbo=;
  b=bHtSJWT7KvCn4r5dLXMV1qs7Qs+vKSiZlu+eJ38RV/O9vmaXKjRj3lfa
   q1Vru/zn3nFF5N80nVSEsyT6WyDwUuiWXHTJbIcZVRNvMSVlDZBv1wAxb
   XcN1OUNx1c+Q5BnvBjXFmNugqMGJcRI7nOpWhclfalRB+W/jZB0XIvDHs
   JsvcrA563URXjBLt7Evwo4BODr92ETRx2UWf+pCW27IOibuUDWOYa+tjt
   I36Fm4y2ml8JqSGN8Apa1h+9HQf6PXgmD3cLxPmfd8guYvMUa9PBaEG9m
   KTv9JUykX3r0zyVIB74yiTgmPchN4Ln/0vhegI7URnhaOv+V7b+SNizPf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3367122"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3367122"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="25326182"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:43:35 -0800
Message-ID: <38313826939a468ff8c7eee24e2cf07e9eef6768.camel@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: Enable hid core report processing for
 all devices
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Yauhen Kharuzhy <jekhor@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Daniel Thompson
	 <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, Jiri Kosina
	 <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 22 Dec 2023 04:43:34 -0800
In-Reply-To: <CAKWEGV50duj-TcKdQp1BtN_QgnBZyG0WgAqo8Y5UtCinqOAh_g@mail.gmail.com>
References: <20231219231503.1506801-1-jekhor@gmail.com>
	 <20231220145229.020abe62@jic23-huawei>
	 <CAKWEGV50duj-TcKdQp1BtN_QgnBZyG0WgAqo8Y5UtCinqOAh_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 17:04 +0200, Yauhen Kharuzhy wrote:
> =D1=81=D1=80, 20 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 16:52, J=
onathan Cameron <jic23@kernel.org>:
> >=20
> > On Wed, 20 Dec 2023 01:15:03 +0200
> > Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> >=20
> > > After the commit 666cf30a589a ("HID: sensor-hub: Allow multi-
> > > function
> > > sensor devices") hub devices are claimed by hidraw driver in
> > > hid_connect().
> > > This causes stoppping of processing HID reports by hid core due
> > > to
> > > optimization.
> > >=20
> > > In such case, the hid-sensor-custom driver cannot match a known
> > > custom
> > > sensor in hid_sensor_custom_get_known() because it try to check
> > > custom
> > > properties which weren't filled from the report because hid core
> > > didn't
> > > parsed it.
> > >=20
> > > As result, custom sensors like hinge angle sensor and LISS
> > > sensors
> > > don't work.
> > >=20
> > > Mark the sensor hub devices claimed by some driver to avoid
> > > hidraw-related
> > > optimizations.
> > >=20
> > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > Fixes tag?
>=20
> Fixes: 666cf30a589a ("HID: sensor-hub: Allow multi-function sensor
> devices")
>=20
This flag causes
 		hdev->claimed |=3D HID_CLAIMED_DRIVER;
I don't see the flag is used anywhere after this assignment in hid
core. Only two other drivers are setting this flag. We need Jiri's help
here why this is a special case.

Thanks,
Srinivas

> >=20
> > > ---
> > > =C2=A0drivers/hid/hid-sensor-hub.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-
> > > sensor-hub.c
> > > index 2eba152e8b90..26e93a331a51 100644
> > > --- a/drivers/hid/hid-sensor-hub.c
> > > +++ b/drivers/hid/hid-sensor-hub.c
> > > @@ -632,7 +632,7 @@ static int sensor_hub_probe(struct hid_device
> > > *hdev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&hdev->inputs);
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hid_hw_start(hdev, HID_CONNECT_DEFA=
ULT);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hid_hw_start(hdev, HID_CONNECT_DEFA=
ULT |
> > > HID_CONNECT_DRIVER);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 hid_err(hdev, "hw start failed\n");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret;
> >=20
>=20
>=20


