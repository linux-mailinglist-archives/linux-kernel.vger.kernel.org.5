Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA487A9A26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjIUSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjIUSg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:36:27 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17704AF69C;
        Thu, 21 Sep 2023 11:07:22 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 2fecdf3dfb7fb0c9; Thu, 21 Sep 2023 20:07:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0973A664EBE;
        Thu, 21 Sep 2023 20:07:21 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 13/13] ACPI: thermal: Rename structure fields holding temperature in deci-Kelvin
Date:   Thu, 21 Sep 2023 20:06:58 +0200
Message-ID: <1968603.yKVeVyVuyW@kreacher>
In-Reply-To: <1957441.PYKUYFuaPT@kreacher>
References: <1957441.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] 

Rename structure fields holding temperature values in deci-Kelvin so as
to avoid temperature units confusion.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -82,7 +82,7 @@ MODULE_PARM_DESC(psv, "Disable or overri
 static struct workqueue_struct *acpi_thermal_pm_queue;
 
 struct acpi_thermal_trip {
-	unsigned long temperature;
+	unsigned long temp_dk;
 	struct acpi_handle_list devices;
 };
 
@@ -105,8 +105,8 @@ struct acpi_thermal_trips {
 struct acpi_thermal {
 	struct acpi_device *device;
 	acpi_bus_id name;
-	unsigned long temperature;
-	unsigned long last_temperature;
+	unsigned long temp_dk;
+	unsigned long last_temp_dk;
 	unsigned long polling_frequency;
 	volatile u8 zombie;
 	struct acpi_thermal_trips trips;
@@ -131,16 +131,16 @@ static int acpi_thermal_get_temperature(
 	if (!tz)
 		return -EINVAL;
 
-	tz->last_temperature = tz->temperature;
+	tz->last_temp_dk = tz->temp_dk;
 
 	status = acpi_evaluate_integer(tz->device->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	tz->temperature = tmp;
+	tz->temp_dk = tmp;
 
 	acpi_handle_debug(tz->device->handle, "Temperature is %lu dK\n",
-			  tz->temperature);
+			  tz->temp_dk);
 
 	return 0;
 }
@@ -175,7 +175,7 @@ static int acpi_thermal_temp(struct acpi
 
 static bool acpi_thermal_trip_valid(struct acpi_thermal_trip *acpi_trip)
 {
-	return acpi_trip->temperature != THERMAL_TEMP_INVALID;
+	return acpi_trip->temp_dk != THERMAL_TEMP_INVALID;
 }
 
 static long get_passive_temp(struct acpi_thermal *tz)
@@ -197,7 +197,7 @@ static void acpi_thermal_update_passive_
 	if (!acpi_thermal_trip_valid(acpi_trip) || psv > 0)
 		return;
 
-	acpi_trip->temperature = get_passive_temp(tz);
+	acpi_trip->temp_dk = get_passive_temp(tz);
 	if (!acpi_thermal_trip_valid(acpi_trip))
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
@@ -244,7 +244,7 @@ static void acpi_thermal_update_trip_dev
 		return;
 	}
 
-	acpi_trip->temperature = THERMAL_TEMP_INVALID;
+	acpi_trip->temp_dk = THERMAL_TEMP_INVALID;
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
@@ -278,7 +278,7 @@ static void acpi_thermal_update_active_t
 	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
-	acpi_trip->temperature = get_active_temp(tz, index);
+	acpi_trip->temp_dk = get_active_temp(tz, index);
 	if (!acpi_thermal_trip_valid(acpi_trip))
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
@@ -292,7 +292,7 @@ static int acpi_thermal_adjust_trip(stru
 		return 0;
 
 	if (acpi_thermal_trip_valid(acpi_trip))
-		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
+		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
 	else
 		trip->temperature = THERMAL_TEMP_INVALID;
 
@@ -447,11 +447,11 @@ static bool acpi_thermal_init_trip(struc
 	if (!update_trip_devices(tz, acpi_trip, index, false))
 		goto fail;
 
-	acpi_trip->temperature = temp;
+	acpi_trip->temp_dk = temp;
 	return true;
 
 fail:
-	acpi_trip->temperature = THERMAL_TEMP_INVALID;
+	acpi_trip->temp_dk = THERMAL_TEMP_INVALID;
 	return false;
 }
 
@@ -488,7 +488,7 @@ static int thermal_get_temp(struct therm
 	if (result)
 		return result;
 
-	*temp = deci_kelvin_to_millicelsius_with_offset(tz->temperature,
+	*temp = deci_kelvin_to_millicelsius_with_offset(tz->temp_dk,
 							tz->kelvin_offset);
 	return 0;
 }
@@ -510,10 +510,10 @@ static int thermal_get_trend(struct ther
 
 	switch (trip->type) {
 	case THERMAL_TRIP_PASSIVE:
-		t = tz->trips.passive.tc1 * (tz->temperature -
-						tz->last_temperature) +
-			tz->trips.passive.tc2 * (tz->temperature -
-						acpi_trip->temperature);
+		t = tz->trips.passive.tc1 * (tz->temp_dk -
+						tz->last_temp_dk) +
+			tz->trips.passive.tc2 * (tz->temp_dk -
+						acpi_trip->temp_dk);
 		if (t > 0)
 			*trend = THERMAL_TREND_RAISING;
 		else if (t < 0)
@@ -524,7 +524,7 @@ static int thermal_get_trend(struct ther
 		return 0;
 
 	case THERMAL_TRIP_ACTIVE:
-		t = acpi_thermal_temp(tz, tz->temperature);
+		t = acpi_thermal_temp(tz, tz->temp_dk);
 		if (t <= trip->temperature)
 			break;
 
@@ -894,7 +894,7 @@ static int acpi_thermal_add(struct acpi_
 		passive_delay = tz->trips.passive.tsp * 100;
 
 		trip->type = THERMAL_TRIP_PASSIVE;
-		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
+		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
 		trip->priv = acpi_trip;
 		trip++;
 	}
@@ -906,7 +906,7 @@ static int acpi_thermal_add(struct acpi_
 			break;
 
 		trip->type = THERMAL_TRIP_ACTIVE;
-		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
+		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
 		trip->priv = acpi_trip;
 		trip++;
 	}
@@ -920,7 +920,7 @@ static int acpi_thermal_add(struct acpi_
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
 	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
+		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temp_dk));
 
 	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
 						 acpi_thermal_notify);



