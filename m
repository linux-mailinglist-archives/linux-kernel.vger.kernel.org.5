Return-Path: <linux-kernel+bounces-94470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C595A874048
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C282B22859
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53514039D;
	Wed,  6 Mar 2024 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sXKbCf2u"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6213E7FF;
	Wed,  6 Mar 2024 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752841; cv=none; b=OLkPsQMcT6Dl5jG3oJtsmkWOX5O/CqBKF5P+6J2asokoe9fnKXAK71h6R4sThEn4yeetXtVe9ZUWpj/cpJHURuNXHS4i6+65B9DHG8VoDdiY/gdXtiNOedaojTBwl5kVR9KeicQo9TOcZ6pIIApRONYOl0nB51h4TRgODVDSidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752841; c=relaxed/simple;
	bh=2JtyH6Sn6slPHl+9ds9llSonlvmGFUbtR20ZjojMPTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUHb3grrelSN4I6y0k+zztfGErYYj0RJEFNhg3w3RdHHMcyikgN8lP7Ry08MjXsj0BzxvhBWzJgD46Pl3/Ps40h/BqJOJP0E7GZngAcumDkH/ME4HvqIJcPMW1mF90lgmClmY1ASmsqeM48DwF/WrbF5766WbBkYsOmzGhfNi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sXKbCf2u reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id def5cfb7b1925bea; Wed, 6 Mar 2024 20:20:29 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 40E6B66AB8D;
	Wed,  6 Mar 2024 20:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1709752829;
	bh=2JtyH6Sn6slPHl+9ds9llSonlvmGFUbtR20ZjojMPTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sXKbCf2uuPxfZapZyGrw9hhss1WoLxjBwqsAT2zCmrzbTSSRGt+kCBPlLskLKVC3p
	 S+A39Lupxwln+PJH7emPzkdKwbnm20a1U0wKtO+zP3B+/glDeb3Z7aHOBURo5K5/HK
	 e5eFWeX40DQ/Uo06xx9ugF9wJf6LQbZ2jNC0Qy+jnx70n9qVOG/k73/RqG5QkEGD/o
	 qdhAEH8xVQjCUOqZX8nZJYS2jZSKP+bhiWxejzxLO1PEv8NAvYy+5RXUihs6grzYEn
	 3eFuRKH9n9ssfiOuDnXI4yTRwZ07J8x6PmI6WLPqAx+uEdDvpbtPrffPMRyPxllhFo
	 nkb+a1iD4Yt0A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v1 1/2] thermal: core: Move threshold out of struct thermal_trip
Date: Wed, 06 Mar 2024 20:18:25 +0100
Message-ID: <2183664.irdbgypaU6@kreacher>
In-Reply-To: <4558384.LvFx2qVVIh@kreacher>
References: <4558384.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledriedugdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptddvfeegledvfedvveevhedvteeffeehvdeuiedukeeiledttefgvdeihffgteetnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhtrghnihhslhgrfidrghhruhhsiihkrgeslhhi
 nhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The threshold field in struct thermal_trip is only used internally by
the thermal core and it is better to prevent drivers from misusing it.
It also takes some space unnecessarily in the trip tables passed by
drivers to the core during thermal zone registration.

=46or this reason, introduce struct thermal_trip_desc as a wrapper around
struct thermal_trip, move the threshold field directly into it and make
the thermal core store struct thermal_trip_desc objects in the internal
thermal zone trip tables.  Adjust all of the code using trip tables in
the thermal core accordingly.

No intentional function impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/thermal/gov_fair_share.c      |    7 +++--
 drivers/thermal/gov_power_allocator.c |    6 ++--
 drivers/thermal/thermal_core.c        |   46 +++++++++++++++++++----------=
=2D----
 drivers/thermal/thermal_core.h        |    7 +++--
 drivers/thermal/thermal_debugfs.c     |    6 ++--
 drivers/thermal/thermal_helpers.c     |    8 +++--
 drivers/thermal/thermal_netlink.c     |    6 ++--
 drivers/thermal/thermal_sysfs.c       |   20 +++++++-------
 drivers/thermal/thermal_trip.c        |   15 +++++------
 include/linux/thermal.h               |    9 ++++--
 10 files changed, 78 insertions(+), 52 deletions(-)

Index: linux-pm/include/linux/thermal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -61,7 +61,6 @@ enum thermal_notify_event {
  * struct thermal_trip - representation of a point in temperature domain
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
=2D * @threshold: trip crossing notification threshold miliCelsius
  * @type: trip point type
  * @priv: pointer to driver data associated with this trip
  * @flags: flags representing binary properties of the trip
@@ -69,12 +68,16 @@ enum thermal_notify_event {
 struct thermal_trip {
 	int temperature;
 	int hysteresis;
=2D	int threshold;
 	enum thermal_trip_type type;
 	u8 flags;
 	void *priv;
 };
=20
+struct thermal_trip_desc {
+	struct thermal_trip trip;
+	int threshold;
+};
+
 #define THERMAL_TRIP_FLAG_RW_TEMP	BIT(0)
 #define THERMAL_TRIP_FLAG_RW_HYST	BIT(1)
=20
@@ -203,7 +206,7 @@ struct thermal_zone_device {
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
=2D	struct thermal_trip trips[] __counted_by(num_trips);
+	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
=20
 /**
Index: linux-pm/drivers/thermal/thermal_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -361,17 +361,19 @@ static void handle_critical_trips(struct
 }
=20
 static void handle_thermal_trip(struct thermal_zone_device *tz,
=2D				struct thermal_trip *trip)
+				struct thermal_trip_desc *td)
 {
+	const struct thermal_trip *trip =3D &td->trip;
+
 	if (trip->temperature =3D=3D THERMAL_TEMP_INVALID)
 		return;
=20
 	if (tz->last_temperature =3D=3D THERMAL_TEMP_INVALID) {
 		/* Initialization. */
=2D		trip->threshold =3D trip->temperature;
=2D		if (tz->temperature >=3D trip->threshold)
=2D			trip->threshold -=3D trip->hysteresis;
=2D	} else if (tz->last_temperature < trip->threshold) {
+		td->threshold =3D trip->temperature;
+		if (tz->temperature >=3D td->threshold)
+			td->threshold -=3D trip->hysteresis;
+	} else if (tz->last_temperature < td->threshold) {
 		/*
 		 * The trip threshold is equal to the trip temperature, unless
 		 * the latter has changed in the meantime.  In either case,
@@ -382,9 +384,9 @@ static void handle_thermal_trip(struct t
 		if (tz->temperature >=3D trip->temperature) {
 			thermal_notify_tz_trip_up(tz, trip);
 			thermal_debug_tz_trip_up(tz, trip);
=2D			trip->threshold =3D trip->temperature - trip->hysteresis;
+			td->threshold =3D trip->temperature - trip->hysteresis;
 		} else {
=2D			trip->threshold =3D trip->temperature;
+			td->threshold =3D trip->temperature;
 		}
 	} else {
 		/*
@@ -400,9 +402,9 @@ static void handle_thermal_trip(struct t
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			thermal_notify_tz_trip_down(tz, trip);
 			thermal_debug_tz_trip_down(tz, trip);
=2D			trip->threshold =3D trip->temperature;
+			td->threshold =3D trip->temperature;
 		} else {
=2D			trip->threshold =3D trip->temperature - trip->hysteresis;
+			td->threshold =3D trip->temperature - trip->hysteresis;
 		}
 	}
=20
@@ -458,7 +460,7 @@ static void thermal_zone_device_init(str
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
=2D	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
=20
 	if (tz->suspended)
 		return;
@@ -472,8 +474,8 @@ void __thermal_zone_device_update(struct
=20
 	tz->notify_event =3D event;
=20
=2D	for_each_trip(tz, trip)
=2D		handle_thermal_trip(tz, trip);
+	for_each_trip_desc(tz, td)
+		handle_thermal_trip(tz, td);
=20
 	monitor_thermal_zone(tz);
 }
@@ -766,7 +768,7 @@ int thermal_zone_bind_cooling_device(str
 	if (trip_index < 0 || trip_index >=3D tz->num_trips)
 		return -EINVAL;
=20
=2D	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index], cdev,
+	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
 					 upper, lower, weight);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
@@ -825,7 +827,7 @@ int thermal_zone_unbind_cooling_device(s
 	if (trip_index < 0 || trip_index >=3D tz->num_trips)
 		return -EINVAL;
=20
=2D	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index], cdev);
+	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cde=
v);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
=20
@@ -1221,16 +1223,19 @@ static void thermal_set_delay_jiffies(un
=20
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
=2D	int i, ret =3D -EINVAL;
+	const struct thermal_trip_desc *td;
+	int ret =3D -EINVAL;
=20
 	if (tz->ops.get_crit_temp)
 		return tz->ops.get_crit_temp(tz, temp);
=20
 	mutex_lock(&tz->lock);
=20
=2D	for (i =3D 0; i < tz->num_trips; i++) {
=2D		if (tz->trips[i].type =3D=3D THERMAL_TRIP_CRITICAL) {
=2D			*temp =3D tz->trips[i].temperature;
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
+		if (trip->type =3D=3D THERMAL_TRIP_CRITICAL) {
+			*temp =3D trip->temperature;
 			ret =3D 0;
 			break;
 		}
@@ -1274,7 +1279,9 @@ thermal_zone_device_register_with_trips(
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay)
 {
+	const struct thermal_trip *trip =3D trips;
 	struct thermal_zone_device *tz;
+	struct thermal_trip_desc *td;
 	int id;
 	int result;
 	struct thermal_governor *governor;
@@ -1339,7 +1346,8 @@ thermal_zone_device_register_with_trips(
 	tz->device.class =3D thermal_class;
 	tz->devdata =3D devdata;
 	tz->num_trips =3D num_trips;
=2D	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
+	for_each_trip_desc(tz, td)
+		td->trip =3D *trip++;
=20
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
Index: linux-pm/drivers/thermal/thermal_core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -120,8 +120,11 @@ void thermal_governor_update_tz(struct t
 				enum thermal_notify_event reason);
=20
 /* Helpers */
=2D#define for_each_trip(__tz, __trip)	\
=2D	for (__trip =3D __tz->trips; __trip - __tz->trips < __tz->num_trips; __=
trip++)
+#define for_each_trip_desc(__tz, __td)	\
+	for (__td =3D __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
+
+#define trip_to_trip_desc(__trip)	\
+	container_of(__trip, struct thermal_trip_desc, trip)
=20
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
Index: linux-pm/drivers/thermal/thermal_sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -88,7 +88,7 @@ trip_point_type_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) !=3D 1)
 		return -EINVAL;
=20
=2D	switch (tz->trips[trip_id].type) {
+	switch (tz->trips[trip_id].trip.type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -120,7 +120,7 @@ trip_point_temp_store(struct device *dev
=20
 	mutex_lock(&tz->lock);
=20
=2D	trip =3D &tz->trips[trip_id];
+	trip =3D &tz->trips[trip_id].trip;
=20
 	if (temp !=3D trip->temperature) {
 		if (tz->ops.set_trip_temp) {
@@ -150,7 +150,7 @@ trip_point_temp_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) !=3D 1)
 		return -EINVAL;
=20
=2D	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.temperature);
 }
=20
 static ssize_t
@@ -171,7 +171,7 @@ trip_point_hyst_store(struct device *dev
=20
 	mutex_lock(&tz->lock);
=20
=2D	trip =3D &tz->trips[trip_id];
+	trip =3D &tz->trips[trip_id].trip;
=20
 	if (hyst !=3D trip->hysteresis) {
 		trip->hysteresis =3D hyst;
@@ -194,7 +194,7 @@ trip_point_hyst_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) !=3D 1)
 		return -EINVAL;
=20
=2D	return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.hysteresis);
 }
=20
 static ssize_t
@@ -393,7 +393,7 @@ static const struct attribute_group *the
  */
 static int create_trip_attrs(struct thermal_zone_device *tz)
 {
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	struct attribute **attrs;
=20
 	/* This function works only for zones with at least one trip */
@@ -429,8 +429,8 @@ static int create_trip_attrs(struct ther
 		return -ENOMEM;
 	}
=20
=2D	for_each_trip(tz, trip) {
=2D		int indx =3D thermal_zone_trip_id(tz, trip);
+	for_each_trip_desc(tz, td) {
+		int indx =3D thermal_zone_trip_id(tz, &td->trip);
=20
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
@@ -452,7 +452,7 @@ static int create_trip_attrs(struct ther
 						tz->trip_temp_attrs[indx].name;
 		tz->trip_temp_attrs[indx].attr.attr.mode =3D S_IRUGO;
 		tz->trip_temp_attrs[indx].attr.show =3D trip_point_temp_show;
=2D		if (trip->flags & THERMAL_TRIP_FLAG_RW_TEMP) {
+		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_TEMP) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |=3D S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =3D
 							trip_point_temp_store;
@@ -467,7 +467,7 @@ static int create_trip_attrs(struct ther
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode =3D S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show =3D trip_point_hyst_show;
=2D		if (trip->flags & THERMAL_TRIP_FLAG_RW_HYST) {
+		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_HYST) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |=3D S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =3D
 					trip_point_hyst_store;
Index: linux-pm/drivers/thermal/thermal_debugfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -744,7 +744,7 @@ static void tze_seq_stop(struct seq_file
 static int tze_seq_show(struct seq_file *s, void *v)
 {
 	struct thermal_zone_device *tz =3D s->private;
=2D	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
 	struct tz_episode *tze;
 	const char *type;
 	int trip_id;
@@ -757,7 +757,9 @@ static int tze_seq_show(struct seq_file
=20
 	seq_printf(s, "| trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  dur=
ation  |  avg(=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |\n");
=20
=2D	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		/*
 		 * There is no possible mitigation happening at the
 		 * critical trip point, so the stats will be always
Index: linux-pm/drivers/thermal/thermal_netlink.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -445,7 +445,7 @@ out_cancel_nest:
 static int thermal_genl_cmd_tz_get_trip(struct param *p)
 {
 	struct sk_buff *msg =3D p->msg;
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	struct thermal_zone_device *tz;
 	struct nlattr *start_trip;
 	int id;
@@ -465,7 +465,9 @@ static int thermal_genl_cmd_tz_get_trip(
=20
 	mutex_lock(&tz->lock);
=20
=2D	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID,
 				thermal_zone_trip_id(tz, trip)) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
Index: linux-pm/drivers/thermal/thermal_trip.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -13,11 +13,11 @@ int for_each_thermal_trip(struct thermal
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data)
 {
=2D	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
 	int ret;
=20
=2D	for_each_trip(tz, trip) {
=2D		ret =3D cb(trip, data);
+	for_each_trip_desc(tz, td) {
+		ret =3D cb(&td->trip, data);
 		if (ret)
 			return ret;
 	}
@@ -63,7 +63,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_t
  */
 void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	int low =3D -INT_MAX, high =3D INT_MAX;
 	bool same_trip =3D false;
 	int ret;
@@ -73,7 +73,8 @@ void __thermal_zone_set_trips(struct the
 	if (!tz->ops.set_trips)
 		return;
=20
=2D	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
 		bool low_set =3D false;
 		int trip_low;
=20
@@ -125,7 +126,7 @@ int __thermal_zone_get_trip(struct therm
 	if (!tz || trip_id < 0 || trip_id >=3D tz->num_trips || !trip)
 		return -EINVAL;
=20
=2D	*trip =3D tz->trips[trip_id];
+	*trip =3D tz->trips[trip_id].trip;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
@@ -150,7 +151,7 @@ int thermal_zone_trip_id(const struct th
 	 * Assume the trip to be located within the bounds of the thermal
 	 * zone's trips[] table.
 	 */
=2D	return trip - tz->trips;
+	return trip_to_trip_desc(trip) - tz->trips;
 }
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 			       const struct thermal_trip *trip)
Index: linux-pm/drivers/thermal/gov_fair_share.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -17,10 +17,13 @@
=20
 static int get_trip_level(struct thermal_zone_device *tz)
 {
=2D	const struct thermal_trip *trip, *level_trip =3D NULL;
+	const struct thermal_trip *level_trip =3D NULL;
+	const struct thermal_trip_desc *td;
 	int trip_level =3D -1;
=20
=2D	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		if (trip->temperature >=3D tz->temperature)
 			continue;
=20
Index: linux-pm/drivers/thermal/gov_power_allocator.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -496,9 +496,11 @@ static void get_governor_trips(struct th
 	const struct thermal_trip *first_passive =3D NULL;
 	const struct thermal_trip *last_passive =3D NULL;
 	const struct thermal_trip *last_active =3D NULL;
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
+
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
=20
=2D	for_each_trip(tz, trip) {
 		switch (trip->type) {
 		case THERMAL_TRIP_PASSIVE:
 			if (!first_passive) {
Index: linux-pm/drivers/thermal/thermal_helpers.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -50,7 +50,7 @@ get_thermal_instance(struct thermal_zone
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
=20
=2D	trip =3D &tz->trips[trip_index];
+	trip =3D &tz->trips[trip_index].trip;
=20
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
 		if (pos->tz =3D=3D tz && pos->trip =3D=3D trip && pos->cdev =3D=3D cdev)=
 {
@@ -82,7 +82,7 @@ EXPORT_SYMBOL(get_thermal_instance);
  */
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	int crit_temp =3D INT_MAX;
 	int ret =3D -EINVAL;
=20
@@ -91,7 +91,9 @@ int __thermal_zone_get_temp(struct therm
 	ret =3D tz->ops.get_temp(tz, temp);
=20
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
=2D		for_each_trip(tz, trip) {
+		for_each_trip_desc(tz, td) {
+			const struct thermal_trip *trip =3D &td->trip;
+
 			if (trip->type =3D=3D THERMAL_TRIP_CRITICAL) {
 				crit_temp =3D trip->temperature;
 				break;




