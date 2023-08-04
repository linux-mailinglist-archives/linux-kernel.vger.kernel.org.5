Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D936770ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjHDV0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjHDV0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:26:08 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07769E43;
        Fri,  4 Aug 2023 14:26:06 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 1a94c3a7d9aba577; Fri, 4 Aug 2023 23:26:05 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CC1F1661680;
        Fri,  4 Aug 2023 23:26:04 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 09/10] ACPI: thermal: Drop unnecessary thermal zone callbacks
Date:   Fri, 04 Aug 2023 23:24:49 +0200
Message-ID: <4314197.ejJDZkT8p0@kreacher>
In-Reply-To: <4878513.31r3eYUQgx@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdduheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the .get_trip_type(), .get_trip_temp() and .get_crit_temp() thermal
zone callbacks that are not necessary any more from the ACPI thermal
driver along with the corresponding callback functions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4: No changes.

v2 -> v3: Rebase on top of the v2 of the previous patch.

v1 -> v2: No changes.

---
 drivers/acpi/thermal.c |  115 -------------------------------------------------
 1 file changed, 115 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -503,118 +503,6 @@ static int thermal_get_temp(struct therm
 	return 0;
 }
 
-static int thermal_get_trip_type(struct thermal_zone_device *thermal,
-				 int trip, enum thermal_trip_type *type)
-{
-	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	int i;
-
-	if (!tz || trip < 0)
-		return -EINVAL;
-
-	if (tz->trips.critical.valid) {
-		if (!trip) {
-			*type = THERMAL_TRIP_CRITICAL;
-			return 0;
-		}
-		trip--;
-	}
-
-	if (tz->trips.hot.valid) {
-		if (!trip) {
-			*type = THERMAL_TRIP_HOT;
-			return 0;
-		}
-		trip--;
-	}
-
-	if (tz->trips.passive.valid) {
-		if (!trip) {
-			*type = THERMAL_TRIP_PASSIVE;
-			return 0;
-		}
-		trip--;
-	}
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++) {
-		if (!trip) {
-			*type = THERMAL_TRIP_ACTIVE;
-			return 0;
-		}
-		trip--;
-	}
-
-	return -EINVAL;
-}
-
-static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
-				 int trip, int *temp)
-{
-	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	int i;
-
-	if (!tz || trip < 0)
-		return -EINVAL;
-
-	if (tz->trips.critical.valid) {
-		if (!trip) {
-			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.critical.temperature,
-					tz->kelvin_offset);
-			return 0;
-		}
-		trip--;
-	}
-
-	if (tz->trips.hot.valid) {
-		if (!trip) {
-			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.hot.temperature,
-					tz->kelvin_offset);
-			return 0;
-		}
-		trip--;
-	}
-
-	if (tz->trips.passive.valid) {
-		if (!trip) {
-			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.passive.temperature,
-					tz->kelvin_offset);
-			return 0;
-		}
-		trip--;
-	}
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->trips.active[i].valid; i++) {
-		if (!trip) {
-			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.active[i].temperature,
-					tz->kelvin_offset);
-			return 0;
-		}
-		trip--;
-	}
-
-	return -EINVAL;
-}
-
-static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
-				int *temperature)
-{
-	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-
-	if (tz->trips.critical.valid) {
-		*temperature = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.critical.temperature,
-					tz->kelvin_offset);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static int thermal_get_trend(struct thermal_zone_device *thermal,
 			     int trip_index, enum thermal_trend *trend)
 {
@@ -777,9 +665,6 @@ static struct thermal_zone_device_ops ac
 	.bind = acpi_thermal_bind_cooling_device,
 	.unbind	= acpi_thermal_unbind_cooling_device,
 	.get_temp = thermal_get_temp,
-	.get_trip_type = thermal_get_trip_type,
-	.get_trip_temp = thermal_get_trip_temp,
-	.get_crit_temp = thermal_get_crit_temp,
 	.get_trend = thermal_get_trend,
 	.hot = acpi_thermal_zone_device_hot,
 	.critical = acpi_thermal_zone_device_critical,



