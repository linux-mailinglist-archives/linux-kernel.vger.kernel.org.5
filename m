Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6B7B6A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjJCN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjJCN0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:26:55 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD09BD;
        Tue,  3 Oct 2023 06:26:50 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id fee7940ee958ee86; Tue, 3 Oct 2023 15:26:49 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C63456659AF;
        Tue,  3 Oct 2023 15:26:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 2/6] ACPI: thermal: Move get_active_temp()
Date:   Tue, 03 Oct 2023 15:18:31 +0200
Message-ID: <2913298.e9J7NaK4W3@kreacher>
In-Reply-To: <4846448.GXAFRqVoOG@kreacher>
References: <4846448.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
 thhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
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

Put the get_active_temp() function next to the analogous
get_passive_temp() one to allow subsequent changes to be easier to
follow.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -189,6 +189,29 @@ static long get_passive_temp(struct acpi
 	return tmp;
 }
 
+static long get_active_temp(struct acpi_thermal *tz, int index)
+{
+	char method[] = { '_', 'A', 'C', '0' + index, '\0' };
+	unsigned long long tmp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(tz->device->handle, method, NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		return THERMAL_TEMP_INVALID;
+
+	/*
+	 * If an override has been provided, apply it so there are no active
+	 * trips with thresholds greater than the override.
+	 */
+	if (act > 0) {
+		unsigned long long override = celsius_to_deci_kelvin(act);
+
+		if (tmp > override)
+			tmp = override;
+	}
+	return tmp;
+}
+
 static void acpi_thermal_update_passive_trip(struct acpi_thermal *tz)
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
@@ -250,29 +273,6 @@ static void acpi_thermal_update_trip_dev
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
-static long get_active_temp(struct acpi_thermal *tz, int index)
-{
-	char method[] = { '_', 'A', 'C', '0' + index, '\0' };
-	unsigned long long tmp;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(tz->device->handle, method, NULL, &tmp);
-	if (ACPI_FAILURE(status))
-		return THERMAL_TEMP_INVALID;
-
-	/*
-	 * If an override has been provided, apply it so there are no active
-	 * trips with thresholds greater than the override.
-	 */
-	if (act > 0) {
-		unsigned long long override = celsius_to_deci_kelvin(act);
-
-		if (tmp > override)
-			tmp = override;
-	}
-	return tmp;
-}
-
 static void acpi_thermal_update_active_trip(struct acpi_thermal *tz, int index)
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;



