Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114179D906
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbjILSro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbjILSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:41 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CB10D3;
        Tue, 12 Sep 2023 11:47:37 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id e4066c49c5a5a305; Tue, 12 Sep 2023 20:47:35 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D70DE663BE5;
        Tue, 12 Sep 2023 20:47:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 8/9] ACPI: thermal: Drop redundant trip point flags
Date:   Tue, 12 Sep 2023 20:46:02 +0200
Message-ID: <3760530.kQq0lBPeGt@kreacher>
In-Reply-To: <5708760.DvuYhMxLoT@kreacher>
References: <5708760.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehs
 rhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Trip point flags previously used by the driver need not be used any more
after the preceding changes, so drop them and adjust the code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -43,14 +43,6 @@
 #define ACPI_THERMAL_MAX_ACTIVE		10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN	65
 
-#define ACPI_TRIPS_PASSIVE	BIT(0)
-#define ACPI_TRIPS_ACTIVE	BIT(1)
-#define ACPI_TRIPS_DEVICES	BIT(2)
-
-#define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
-
-#define ACPI_TRIPS_INIT		(ACPI_TRIPS_THRESHOLDS | ACPI_TRIPS_DEVICES)
-
 /*
  * This exception is thrown out in two cases:
  * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
@@ -58,12 +50,11 @@
  * 2.TODO: Devices listed in _PSL, _ALx, _TZD may change.
  *   We need to re-bind the cooling devices of a thermal zone when this occurs.
  */
-#define ACPI_THERMAL_TRIPS_EXCEPTION(flags, tz, str) \
+#define ACPI_THERMAL_TRIPS_EXCEPTION(tz, str) \
 do { \
-	if (flags != ACPI_TRIPS_INIT) \
-		acpi_handle_info(tz->device->handle, \
-			"ACPI thermal trip point %s changed\n" \
-			"Please report to linux-acpi@vger.kernel.org\n", str); \
+	acpi_handle_info(tz->device->handle, \
+			 "ACPI thermal trip point %s changed\n" \
+			 "Please report to linux-acpi@vger.kernel.org\n", str); \
 } while (0)
 
 static int act;
@@ -212,7 +203,7 @@ static void acpi_thermal_update_passive_
 
 	update_acpi_thermal_trip_temp(acpi_trip, get_passive_temp(tz));
 	if (!acpi_trip->valid)
-		ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_PASSIVE, tz, "state");
+		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
 static bool update_passive_devices(struct acpi_thermal *tz, bool compare)
@@ -230,7 +221,7 @@ static bool update_passive_devices(struc
 	}
 
 	if (compare && memcmp(&tz->trips.passive.devices, &devices, sizeof(devices)))
-		ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_PASSIVE, tz, "device");
+		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "device");
 
 	memcpy(&tz->trips.passive.devices, &devices, sizeof(devices));
 	return true;
@@ -247,7 +238,7 @@ static void acpi_thermal_update_passive_
 		return;
 
 	update_acpi_thermal_trip_temp(acpi_trip, THERMAL_TEMP_INVALID);
-	ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_PASSIVE, tz, "state");
+	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
 static long get_active_temp(struct acpi_thermal *tz, int index)
@@ -282,7 +273,7 @@ static void acpi_thermal_update_active_t
 
 	update_acpi_thermal_trip_temp(acpi_trip, get_active_temp(tz, index));
 	if (!acpi_trip->valid)
-		ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "state");
+		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
 static bool update_active_devices(struct acpi_thermal *tz, int index, bool compare)
@@ -302,7 +293,7 @@ static bool update_active_devices(struct
 	}
 
 	if (compare && memcmp(&tz->trips.active[index].devices, &devices, sizeof(devices)))
-		ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "device");
+		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "device");
 
 	memcpy(&tz->trips.active[index].devices, &devices, sizeof(devices));
 	return true;
@@ -319,7 +310,7 @@ static void acpi_thermal_update_active_d
 		return;
 
 	update_acpi_thermal_trip_temp(acpi_trip, THERMAL_TEMP_INVALID);
-	ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "state");
+	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
 static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)



