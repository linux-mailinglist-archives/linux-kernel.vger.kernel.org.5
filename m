Return-Path: <linux-kernel+bounces-9777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54381CB48
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808551C2254C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D541D52F;
	Fri, 22 Dec 2023 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDWZVVd4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E71C693;
	Fri, 22 Dec 2023 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703255087; x=1734791087;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5IQoWpfQ/5wHHHuIPnsgD6NLgOG/1QPwwdB95s66PEg=;
  b=GDWZVVd4ntpXsKcyCLnQjPMOCcQo1BuxnRkRADYDeRg2xOQ+THicfl/u
   aN+kPbX8TKnAumTAZFf9I+d3fncl79vZO/pO7mwktZblvRmTYldmP+U0D
   zMfB0q7jwgYKmXiVfyXyYj63RoMaGpLOHAKY0+iMWKntUyjAZ133xYE//
   Lc3S5MNm1j73Vd/GWD1ct0+UBlA/8GreiMK6OrHxCdvGq7bTbAO9XRp+n
   o+fLGk3e0kCE2aaMWRGKuMReOQeYRCMiouTUtd96aExkjmnOBtsFg87Lc
   TZQlwDqo/og9Q+B3F5QHz8aTUp0y/VoLoPVz74mBRjOd29QhEeEQr+jHA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462559382"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="462559382"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 06:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="11471189"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 06:24:46 -0800
Message-ID: <bfa921830db255b901b0bb586b090846466a8ab0.camel@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: Enable hid core report processing for
 all devices
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Yauhen Kharuzhy <jekhor@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
  linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Daniel Thompson
 <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>
Date: Fri, 22 Dec 2023 06:24:45 -0800
In-Reply-To: <CAO-hwJ+RDnukVhL1=PirK=hU7gm2t73xsg=aDss0M9hj_CSuHA@mail.gmail.com>
References: <20231219231503.1506801-1-jekhor@gmail.com>
	 <20231220145229.020abe62@jic23-huawei>
	 <CAKWEGV50duj-TcKdQp1BtN_QgnBZyG0WgAqo8Y5UtCinqOAh_g@mail.gmail.com>
	 <38313826939a468ff8c7eee24e2cf07e9eef6768.camel@linux.intel.com>
	 <CAO-hwJ+RDnukVhL1=PirK=hU7gm2t73xsg=aDss0M9hj_CSuHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-22 at 14:28 +0100, Benjamin Tissoires wrote:
> On Fri, Dec 22, 2023 at 1:44=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Wed, 2023-12-20 at 17:04 +0200, Yauhen Kharuzhy wrote:
> > > =D1=81=D1=80, 20 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 16:5=
2, Jonathan Cameron <jic23@kernel.org>:
> > > >=20
> > > > On Wed, 20 Dec 2023 01:15:03 +0200
> > > > Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> > > >=20
> > > > > After the commit 666cf30a589a ("HID: sensor-hub: Allow multi-
> > > > > function
> > > > > sensor devices") hub devices are claimed by hidraw driver in
> > > > > hid_connect().
> > > > > This causes stoppping of processing HID reports by hid core
> > > > > due
> > > > > to
> > > > > optimization.
> > > > >=20
> > > > > In such case, the hid-sensor-custom driver cannot match a
> > > > > known
> > > > > custom
> > > > > sensor in hid_sensor_custom_get_known() because it try to
> > > > > check
> > > > > custom
> > > > > properties which weren't filled from the report because hid
> > > > > core
> > > > > didn't
> > > > > parsed it.
> > > > >=20
> > > > > As result, custom sensors like hinge angle sensor and LISS
> > > > > sensors
> > > > > don't work.
> > > > >=20
> > > > > Mark the sensor hub devices claimed by some driver to avoid
> > > > > hidraw-related
> > > > > optimizations.
> > > > >=20
> > > > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > > > Fixes tag?
> > >=20
> > > Fixes: 666cf30a589a ("HID: sensor-hub: Allow multi-function
> > > sensor
> > > devices")
> > >=20
> > This flag causes
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdev->claimed |=3D HID_CLAIMED_DRIVER;
> > I don't see the flag is used anywhere after this assignment in hid
> > core. Only two other drivers are setting this flag. We need Jiri's
> > help
> > here why this is a special case.
>=20
> It's used in hid_report_raw_event()[0]:
> ```
> =C2=A0=C2=A0=C2=A0 if (hid->claimed !=3D HID_CLAIMED_HIDRAW && report->ma=
xfield) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hid_process_report(hid, report=
, cdata, interrupt);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdrv =3D hid->driver;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hdrv && hdrv->report)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdrv->=
report(hid, report);
> =C2=A0=C2=A0=C2=A0 }
> ```
>=20
> The whole point of setting HID_CLAIMED_DRIVER is to have hid->claimed
> not equal to HID_CLAIMED_HIDRAW, in case we need the hid core
> processing.
Thanks Benjamin for explaining.
Then this change looks fine as sensor hub driver will claim this device
and it needs hid core to process report.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

>=20
> Cheers,
> Benjamin
>=20
>=20
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/hid/hid-core.c#n2015
>=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> > > >=20
> > > > > ---
> > > > > =C2=A0drivers/hid/hid-sensor-hub.c | 2 +-
> > > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-
> > > > > sensor-hub.c
> > > > > index 2eba152e8b90..26e93a331a51 100644
> > > > > --- a/drivers/hid/hid-sensor-hub.c
> > > > > +++ b/drivers/hid/hid-sensor-hub.c
> > > > > @@ -632,7 +632,7 @@ static int sensor_hub_probe(struct
> > > > > hid_device
> > > > > *hdev,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&hdev->inputs);
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hid_hw_start(hdev, HID_CONNECT_=
DEFAULT);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hid_hw_start(hdev, HID_CONNECT_=
DEFAULT |
> > > > > HID_CONNECT_DRIVER);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 hid_err(hdev, "hw start failed\n");
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
> > > >=20
> > >=20
> > >=20
> >=20
>=20


