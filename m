Return-Path: <linux-kernel+bounces-46998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237DB8447B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4A41F22227
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9A37143;
	Wed, 31 Jan 2024 19:01:59 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E8CA7F;
	Wed, 31 Jan 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727718; cv=none; b=ONwJy5kYQaxYVEhedgglOoC62pgv/UFFsTkjB+uNRvuhqGsOzgSNxT5729rmPE+Zp6HPy5Cx3Bp41tyf6YOqh4hZSttpYmPhV/PquQUvD9ahsPFl7kXC19vlAyDoSB7e+6B3vUHKmiX0gPjHNR1nCLx6+uXxflInaWLveKU41fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727718; c=relaxed/simple;
	bh=eQZHF14Plim2/h/HfVCGI8KyzULHq0F0ksaKAy59jYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiSJskCz5pE050rv4/+fLA+7ZwJ4g0s1NS0EKv4t+Qih1qKBmNMjWDz64lZMKdZm3q6cDGJbWxUYrgzcZvDAE+QCt/wxBletD9nseQdnFeIp3le5swoC7j4CfLzH8AQM+jDyCCHiQbJF6tLC8mdf1mwXI0A9GBOukj5fO76l5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id b6d18a2c6112265a; Wed, 31 Jan 2024 20:01:53 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 59EC066982B;
	Wed, 31 Jan 2024 20:01:53 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject:
 Re: [PATCH v1] thermal: sysfs: Make trip hysteresis writable along with trip
 temperature
Date: Wed, 31 Jan 2024 20:01:53 +0100
Message-ID: <12386481.O9o76ZdvQC@kreacher>
In-Reply-To:
 <CAJZ5v0iZ0hyPYB3i6YdbiKueHGWoM3i6mPBnzGL9bB8wFxVSPw@mail.gmail.com>
References:
 <4565526.LvFx2qVVIh@kreacher>
 <7caf2f4d-d0d5-4622-b290-bb0396547f3c@linaro.org>
 <CAJZ5v0iZ0hyPYB3i6YdbiKueHGWoM3i6mPBnzGL9bB8wFxVSPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeekieelheffleefgffgtdejvdektedtjeefveeugeefvdfhgfduueetiefgieelteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
 nhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

On Wednesday, January 31, 2024 7:41:52 PM CET Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 7:18=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 29/01/2024 21:40, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Trip point temperature can be modified via sysfs if
> > > CONFIG_THERMAL_WRITABLE_TRIPS is enabled and the thermal
> > > zone creator requested that the given trip be writable
> > > in the writable trips mask passed to the registration
> > > function.
> > >
> > > However, trip point hysteresis is treated differently - it is only
> > > writable if the thermal zone has a .set_trip_hyst() operation defined
> > > and neither CONFIG_THERMAL_WRITABLE_TRIPS, nor the writable trips mask
> > > supplied by the zone creator has any bearing on this.  That is
> > > inconsistent and confusing, and it generally does not meet user
> > > expectations.
> > >
> > > For this reason, modify create_trip_attrs() to handle trip point
> > > hysteresis in the same way as trip point temperature, so they both
> > > are writable at the same time regardless of what trip point operations
> > > are defined for the thermal zone.
> > >
> > > Link: https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_ma=
nafm@quicinc.com
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > Notes:
> > >
> > >   * I don't think that CONFIG_THERMAL_WRITABLE_TRIPS is very useful.
> > >     The only thing controlled by it is whether or not the writable tr=
ip
> > >     mask used during registration will have any effect and this is qu=
ite
> > >     confusing.  Some drivers select it for this reason which seems a =
bit
> > >     odd to me.
> > >
> > >     Maybe it can be dropped after the patch below?
> >
> > Actually it is used from an userspace daemon to get threshold crossing
> > temperature which is then changed on the fly.
>=20
> I mean to drop CONFIG_THERMAL_WRITABLE_TRIPS and make the writable
> trip masks used during zone registration always work.  Sorry for the
> confusion.

So for the record, this (and note that the symbol is clearly not used as
intended, because drivers select it and one platform sets it in defconfig):

=2D--
 arch/arm/configs/imx_v6_v7_defconfig |    1 -
 drivers/thermal/Kconfig              |   11 -----------
 drivers/thermal/intel/Kconfig        |    2 --
 drivers/thermal/thermal_sysfs.c      |    8 +++-----
 4 files changed, 3 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/thermal/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/Kconfig
+++ linux-pm/drivers/thermal/Kconfig
@@ -83,17 +83,6 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
=20
=2Dconfig THERMAL_WRITABLE_TRIPS
=2D	bool "Enable writable trip points"
=2D	help
=2D	  This option allows the system integrator to choose whether
=2D	  trip temperatures can be changed from userspace. The
=2D	  writable trips need to be specified when setting up the
=2D	  thermal zone but the choice here takes precedence.
=2D
=2D	  Say 'Y' here if you would like to allow userspace tools to
=2D	  change trip temperatures.
=2D
 choice
 	prompt "Default Thermal governor"
 	default THERMAL_DEFAULT_GOV_STEP_WISE
Index: linux-pm/drivers/thermal/thermal_sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -458,8 +458,7 @@ static int create_trip_attrs(struct ther
 						tz->trip_temp_attrs[indx].name;
 		tz->trip_temp_attrs[indx].attr.attr.mode =3D S_IRUGO;
 		tz->trip_temp_attrs[indx].attr.show =3D trip_point_temp_show;
=2D		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
=2D		    mask & (1 << indx)) {
+		if (mask & (1 << indx)) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |=3D S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =3D
 							trip_point_temp_store;
@@ -474,8 +473,7 @@ static int create_trip_attrs(struct ther
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode =3D S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show =3D trip_point_hyst_show;
=2D		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
=2D		    mask & (1 << indx)) {
+		if (mask & (1 << indx)) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |=3D S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =3D
 					trip_point_hyst_store;
Index: linux-pm/drivers/thermal/intel/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/intel/Kconfig
+++ linux-pm/drivers/thermal/intel/Kconfig
@@ -23,7 +23,6 @@ config X86_PKG_TEMP_THERMAL
 	tristate "X86 package temperature thermal driver"
 	depends on X86_THERMAL_VECTOR
 	select THERMAL_GOV_USER_SPACE
=2D	select THERMAL_WRITABLE_TRIPS
 	select INTEL_TCC
 	default m
 	help
@@ -47,7 +46,6 @@ config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
 	depends on X86 && PCI && ACPI
 	select INTEL_SOC_DTS_IOSF_CORE
=2D	select THERMAL_WRITABLE_TRIPS
 	help
 	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
 	  temperature sensor (DTS). These SoCs have two additional DTSs in
Index: linux-pm/arch/arm/configs/imx_v6_v7_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/arch/arm/configs/imx_v6_v7_defconfig
+++ linux-pm/arch/arm/configs/imx_v6_v7_defconfig
@@ -228,7 +228,6 @@ CONFIG_SENSORS_IIO_HWMON=3Dy
 CONFIG_SENSORS_PWM_FAN=3Dy
 CONFIG_SENSORS_SY7636A=3Dy
 CONFIG_THERMAL_STATISTICS=3Dy
=2DCONFIG_THERMAL_WRITABLE_TRIPS=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_IMX_THERMAL=3Dy
 CONFIG_WATCHDOG=3Dy




