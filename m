Return-Path: <linux-kernel+bounces-1589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D5815098
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F0F1F2600F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0447F44;
	Fri, 15 Dec 2023 20:02:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FE45BE1;
	Fri, 15 Dec 2023 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 31fef6b089930a91; Fri, 15 Dec 2023 21:02:15 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1E9A3668B59;
	Fri, 15 Dec 2023 21:02:15 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 4/6] thermal: netlink: Drop thermal_notify_tz_trip_add/delete()
Date: Fri, 15 Dec 2023 20:59:08 +0100
Message-ID: <10409811.nUPlyArG6x@kreacher>
In-Reply-To: <4556052.LvFx2qVVIh@kreacher>
References: <4556052.LvFx2qVVIh@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
 phhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because thermal_notify_tz_trip_add/delete() are never used, drop them
entirely along with the related code.

The addition or removal of trip points is not supported by the thermal
core and is unlikely to be supported in the future, so it is also
unlikely that these functions will ever be needed.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_netlink.c |   33 +--------------------------------
 drivers/thermal/thermal_netlink.h |   14 --------------
 2 files changed, 1 insertion(+), 46 deletions(-)

Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -135,7 +135,7 @@ static int thermal_genl_event_tz_trip_up
 	return 0;
 }
 
-static int thermal_genl_event_tz_trip_add(struct param *p)
+static int thermal_genl_event_tz_trip_change(struct param *p)
 {
 	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
 	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
@@ -147,15 +147,6 @@ static int thermal_genl_event_tz_trip_ad
 	return 0;
 }
 
-static int thermal_genl_event_tz_trip_delete(struct param *p)
-{
-	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
-	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id))
-		return -EMSGSIZE;
-
-	return 0;
-}
-
 static int thermal_genl_event_cdev_add(struct param *p)
 {
 	if (nla_put_string(p->msg, THERMAL_GENL_ATTR_CDEV_NAME,
@@ -245,9 +236,6 @@ int thermal_genl_event_tz_disable(struct
 int thermal_genl_event_tz_trip_down(struct param *p)
 	__attribute__((alias("thermal_genl_event_tz_trip_up")));
 
-int thermal_genl_event_tz_trip_change(struct param *p)
-	__attribute__((alias("thermal_genl_event_tz_trip_add")));
-
 static cb_t event_cb[] = {
 	[THERMAL_GENL_EVENT_TZ_CREATE]		= thermal_genl_event_tz_create,
 	[THERMAL_GENL_EVENT_TZ_DELETE]		= thermal_genl_event_tz_delete,
@@ -256,8 +244,6 @@ static cb_t event_cb[] = {
 	[THERMAL_GENL_EVENT_TZ_TRIP_UP]		= thermal_genl_event_tz_trip_up,
 	[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]	= thermal_genl_event_tz_trip_down,
 	[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= thermal_genl_event_tz_trip_change,
-	[THERMAL_GENL_EVENT_TZ_TRIP_ADD]	= thermal_genl_event_tz_trip_add,
-	[THERMAL_GENL_EVENT_TZ_TRIP_DELETE]	= thermal_genl_event_tz_trip_delete,
 	[THERMAL_GENL_EVENT_CDEV_ADD]		= thermal_genl_event_cdev_add,
 	[THERMAL_GENL_EVENT_CDEV_DELETE]	= thermal_genl_event_cdev_delete,
 	[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]	= thermal_genl_event_cdev_state_update,
@@ -350,23 +336,6 @@ int thermal_notify_tz_trip_up(const stru
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
 }
 
-int thermal_notify_tz_trip_add(int tz_id, int trip_id, int trip_type,
-			       int trip_temp, int trip_hyst)
-{
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id,
-			   .trip_type = trip_type, .trip_temp = trip_temp,
-			   .trip_hyst = trip_hyst };
-
-	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_ADD, &p);
-}
-
-int thermal_notify_tz_trip_delete(int tz_id, int trip_id)
-{
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id };
-
-	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DELETE, &p);
-}
-
 int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
 				  const struct thermal_trip *trip)
 {
Index: linux-pm/drivers/thermal/thermal_netlink.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.h
+++ linux-pm/drivers/thermal/thermal_netlink.h
@@ -22,9 +22,6 @@ int thermal_notify_tz_trip_down(const st
 				const struct thermal_trip *trip);
 int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
 			      const struct thermal_trip *trip);
-int thermal_notify_tz_trip_delete(int tz_id, int id);
-int thermal_notify_tz_trip_add(int tz_id, int id, int type,
-			       int temp, int hyst);
 int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
 				  const struct thermal_trip *trip);
 int thermal_notify_cdev_state_update(int cdev_id, int state);
@@ -71,17 +68,6 @@ static inline int thermal_notify_tz_trip
 {
 	return 0;
 }
-
-static inline int thermal_notify_tz_trip_delete(int tz_id, int id)
-{
-	return 0;
-}
-
-static inline int thermal_notify_tz_trip_add(int tz_id, int id, int type,
-					     int temp, int hyst)
-{
-	return 0;
-}
 
 static inline int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
 						const struct thermal_trip *trip)




