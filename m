Return-Path: <linux-kernel+bounces-94482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B913187406D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE23B2208C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C214036A;
	Wed,  6 Mar 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RYtIIVdI"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D396133425;
	Wed,  6 Mar 2024 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753554; cv=none; b=tpnnXqr+4nwMGlTLawjodyQWdKbmikFLeOQIRr+tX1eD5ncDBZKwfkGQw2CjFuaKqrapZMKAOPXXpd5/xPP4U92IIr238O1Y5tZkgZh5bpHdjAHsFqZVqJ2f7vyYL/9fSnpnmLU7EUZEYDtTPCHv1za+Q5G6qa6MCtpNAEb6yyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753554; c=relaxed/simple;
	bh=J8LrJmXXin5ZmB2UdR8/rbJ2RaY0YRW3LuLK1SaEaGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdkS293XLzsmZpKBers6M5S++sZlfq/skTxa4+OCsjYVHGWwzKybKuKBqGKMC4h9YmZyevn7GxQYWqYcv5qNxM2i+wLHWTocgiAQg/JhQnZcHuMtV5/MNya6riWOlNLcgcxjqZmVkYgiE2hT9eHmAJm09ZbxKCzv7PXg/zhycPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RYtIIVdI reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 288d8298a4b950b2; Wed, 6 Mar 2024 20:32:30 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EB0D866AB79;
	Wed,  6 Mar 2024 20:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1709753550;
	bh=J8LrJmXXin5ZmB2UdR8/rbJ2RaY0YRW3LuLK1SaEaGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYtIIVdIfdVsRVTemnTv59TqL4JeT79IsynbOYgMKKidOiAtlk1k0IMOffJluYnnj
	 QxFOJQYL+04H4gJON1bSBjYzUVnAjlxbtZ5v97w8SawBKWnZs6Ka4vTp16XStCT0Zf
	 AWHUMSVAbQUiz8iHWKPgYYvQFSbNslt72rrog/pb7bTG2pN0JrHoKiMeTFWAH5bNov
	 drYggXEqcfne553aDHx4csdrk7cUrbVcIDb72wmCtg2aSGE88ZMdRSAs6kCv6YauMP
	 3V9ysIN7XZtiEKQBpV17ucquLMD7qM8Y5OxS3qrGkfdsfQmtevDnXqGyuxAoxtmi69
	 kOnuUJ1hGCzmQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] thermal/core: Fix trip point crossing events ordering
Date: Wed, 06 Mar 2024 20:32:29 +0100
Message-ID: <2266782.iZASKD2KPV@kreacher>
In-Reply-To: <3bb7c6cf-f7a8-4059-ad8e-02e09c2a44b1@linaro.org>
References:
 <20240306085428.88011-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gWhNqTGpoOH01scCdC51cEnt_8_T5ccqZC6yXPDv9QcA@mail.gmail.com>
 <3bb7c6cf-f7a8-4059-ad8e-02e09c2a44b1@linaro.org>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledriedugdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkeeileehffelfefggfdtjedvkeettdejfeevueegfedvhffgudeuteeigfeileetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtgho
 mhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

On Wednesday, March 6, 2024 4:55:51 PM CET Daniel Lezcano wrote:
> On 06/03/2024 16:41, Rafael J. Wysocki wrote:
> > On Wed, Mar 6, 2024 at 2:16=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> >>
> >> On 06/03/2024 13:53, Rafael J. Wysocki wrote:
> >>> On Wed, Mar 6, 2024 at 1:43=E2=80=AFPM Daniel Lezcano <daniel.lezcano=
@linaro.org> wrote:
> >>>>
> >>>> On 06/03/2024 13:02, Rafael J. Wysocki wrote:
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>>> +#define for_each_trip_reverse(__tz, __trip)    \
> >>>>>> +       for (__trip =3D &__tz->trips[__tz->num_trips - 1]; __trip =
>=3D __tz->trips ; __trip--)
> >>>>>> +
> >>>>>>     void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> >>>>>>     int thermal_zone_trip_id(const struct thermal_zone_device *tz,
> >>>>>>                             const struct thermal_trip *trip);
> >>>>>> --
> >>>>>
> >>>>> Generally speaking, this is a matter of getting alignment on the
> >>>>> expectations between the kernel and user space.
> >>>>>
> >>>>> It looks like user space expects to get the notifications in the or=
der
> >>>>> of either growing or falling temperatures, depending on the directi=
on
> >>>>> of the temperature change.  Ordering the trips in the kernel is not
> >>>>> practical, but the notifications can be ordered in principle.  Is t=
his
> >>>>> what you'd like to do?
> >>>>
> >>>> Yes
> >>>>
> >>>>> Or can user space be bothered with recognizing that it may get the
> >>>>> notifications for different trips out of order?
> >>>>
> >>>> IMO it is a bad information if the trip points events are coming
> >>>> unordered. The temperature signal is a time related measurements, the
> >>>> userspace should receive thermal information from this signal in the
> >>>> right order. It sounds strange to track the temperature signal in the
> >>>> kernel, then scramble the information, pass it to the userspace and
> >>>> except it to apply some kind of logic to unscramble it.
> >>>
> >>> So the notifications can be ordered before sending them out, as long
> >>> as they are produced by a single __thermal_zone_device_update() call.
> >>>
> >>> I guess you also would like the thermal_debug_tz_trip_up/down() calls
> >>> to be ordered, wouldn't you?
> >>
> >> Right
> >=20
> > I have an idea how to do this, but it is based on a couple of patches
> > that I've been working on in the meantime.
> >=20
> > Let me post these patches first and then I'll send a prototype patch
> > addressing this on top of them.
>=20
> That is awesome, thanks !

Anytime!

Now that I've posted this series:

https://lore.kernel.org/linux-pm/4558384.LvFx2qVVIh@kreacher/

I can append the patch below that is based on it.

The idea is really straightforward: Instead of sending the notifications
and recording the stats right away, create two lists of trips for which
they need to be send, sort them and then send the notifications etc in
the right order.  I want to avoid explicit memory allocations that can
fail in principle, which is why lists are used.

The reason why two lists are used is in case the trips are updated and
that's why they appear to be crossed (which may not depend on the actual
temperature change).

One caveat is that the lists are sorted by trip thresholds (because they
are the real values take into account in the code), but user space may
expect them to be sorted by trip temperatures instead.  That can be changed.

=2D--
 drivers/thermal/thermal_core.c |   39 +++++++++++++++++++++++++++++++++---=
=2D--
 drivers/thermal/thermal_core.h |    1 +
 2 files changed, 34 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
+#include <linux/list_sort.h>
 #include <linux/thermal.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -361,7 +362,9 @@ static void handle_critical_trips(struct
 }
=20
 static void handle_thermal_trip(struct thermal_zone_device *tz,
=2D				struct thermal_trip_desc *td)
+				struct thermal_trip_desc *td,
+				struct list_head *way_up_list,
+				struct list_head *way_down_list)
 {
 	const struct thermal_trip *trip =3D &td->trip;
=20
@@ -382,8 +385,7 @@ static void handle_thermal_trip(struct t
 		 * the threshold and the trip temperature will be equal.
 		 */
 		if (tz->temperature >=3D trip->temperature) {
=2D			thermal_notify_tz_trip_up(tz, trip);
=2D			thermal_debug_tz_trip_up(tz, trip);
+			list_add_tail(&td->notify_list_node, way_up_list);
 			td->threshold =3D trip->temperature - trip->hysteresis;
 		} else {
 			td->threshold =3D trip->temperature;
@@ -400,8 +402,7 @@ static void handle_thermal_trip(struct t
 		 * the trip.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
=2D			thermal_notify_tz_trip_down(tz, trip);
=2D			thermal_debug_tz_trip_down(tz, trip);
+			list_add(&td->notify_list_node, way_down_list);
 			td->threshold =3D trip->temperature;
 		} else {
 			td->threshold =3D trip->temperature - trip->hysteresis;
@@ -457,10 +458,24 @@ static void thermal_zone_device_init(str
 		pos->initialized =3D false;
 }
=20
+static int thermal_trip_notify_cmp(void *ascending, const struct list_head=
 *a,
+				   const struct list_head *b)
+{
+	struct thermal_trip_desc *tda =3D container_of(a, struct thermal_trip_des=
c,
+						     notify_list_node);
+	struct thermal_trip_desc *tdb =3D container_of(b, struct thermal_trip_des=
c,
+						     notify_list_node);
+	int ret =3D tdb->threshold - tda->threshold;
+
+	return ascending ? ret : -ret;
+}
+
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
 	struct thermal_trip_desc *td;
+	LIST_HEAD(way_down_list);
+	LIST_HEAD(way_up_list);
=20
 	if (tz->suspended)
 		return;
@@ -475,7 +490,19 @@ void __thermal_zone_device_update(struct
 	tz->notify_event =3D event;
=20
 	for_each_trip_desc(tz, td)
=2D		handle_thermal_trip(tz, td);
+		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
+
+	list_sort((void *)true, &way_up_list, thermal_trip_notify_cmp);
+	list_for_each_entry(td, &way_up_list, notify_list_node) {
+		thermal_notify_tz_trip_up(tz, &td->trip);
+		thermal_debug_tz_trip_up(tz, &td->trip);
+	}
+
+	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
+	list_for_each_entry(td, &way_down_list, notify_list_node) {
+		thermal_notify_tz_trip_down(tz, &td->trip);
+		thermal_debug_tz_trip_down(tz, &td->trip);
+	}
=20
 	monitor_thermal_zone(tz);
 }
Index: linux-pm/drivers/thermal/thermal_core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -17,6 +17,7 @@
=20
 struct thermal_trip_desc {
 	struct thermal_trip trip;
+	struct list_head notify_list_node;
 	int threshold;
 };
=20




