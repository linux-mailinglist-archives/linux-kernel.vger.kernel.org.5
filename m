Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C6A78DDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbjH3SyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbjH3QRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:17:02 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E821A4;
        Wed, 30 Aug 2023 09:16:57 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id c6d608aedefc88a6; Wed, 30 Aug 2023 18:16:55 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4D08866316E;
        Wed, 30 Aug 2023 18:16:55 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v1 1/4] thermal: core: Clean up headers of thermal zone registration functions
Date:   Wed, 30 Aug 2023 18:11:38 +0200
Message-ID: <13345552.uLZWGnKmhe@kreacher>
In-Reply-To: <1870450.tdWV9SEqCh@kreacher>
References: <1870450.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhht
 vghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegrmhhithhksehkvghrnhgvlhdrohhrgh
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

For consistency, add a missing thermal_zone_device_register_with_trips()
stub for the CONFIG_THERMAL unset case, specify argument names in all of
the thermal zone registration and unregistration function headers and
make all of them use white space consistently.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/thermal.h |   53 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 16 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -300,16 +300,24 @@ int thermal_acpi_critical_trip_temp(stru
 #endif
 
 #ifdef CONFIG_THERMAL
-struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
-		void *, struct thermal_zone_device_ops *,
-		const struct thermal_zone_params *, int, int);
-
-void thermal_zone_device_unregister(struct thermal_zone_device *);
-
-struct thermal_zone_device *
-thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
-					void *, struct thermal_zone_device_ops *,
-					const struct thermal_zone_params *, int, int);
+struct thermal_zone_device *thermal_zone_device_register(
+					const char *type,
+					int num_trips, int mask,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp,
+					int passive_delay, int polling_delay);
+
+struct thermal_zone_device *thermal_zone_device_register_with_trips(
+					const char *type,
+					struct thermal_trip *trips,
+					int num_trips, int mask,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp,
+					int passive_delay, int polling_delay);
+
+void thermal_zone_device_unregister(struct thermal_zone_device *tz);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
@@ -351,14 +359,27 @@ int thermal_zone_device_disable(struct t
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register(
-	const char *type, int trips, int mask, void *devdata,
-	struct thermal_zone_device_ops *ops,
-	const struct thermal_zone_params *tzp,
-	int passive_delay, int polling_delay)
+					const char *type,
+					int num_trips, int mask,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp,
+					int passive_delay, int polling_delay)
+{ return ERR_PTR(-ENODEV); }
+
+static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
+					const char *type,
+					struct thermal_trip *trips,
+					int num_trips, int mask,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp,
+					int passive_delay, int polling_delay);
 { return ERR_PTR(-ENODEV); }
-static inline void thermal_zone_device_unregister(
-	struct thermal_zone_device *tz)
+
+static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 { }
+
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)



