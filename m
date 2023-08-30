Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE078DF37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbjH3TIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbjH3QRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:17:01 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F62A6;
        Wed, 30 Aug 2023 09:16:54 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 4cc119add8adde6f; Wed, 30 Aug 2023 18:16:53 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CE60766316E;
        Wed, 30 Aug 2023 18:16:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v1 4/4] thermal: core: Drop thermal_zone_device_register()
Date:   Wed, 30 Aug 2023 18:16:29 +0200
Message-ID: <2245654.iZASKD2KPV@kreacher>
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

There are no more users of thermal_zone_device_register(), so drop it
from the core.

Note that thermal_zone_device_register_with_trips() may be renamed to
thermal_zone_device_register() in the future, but only after a grace
period allowing all of the possible work in progress that may be using
the latter to adjust.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   11 -----------
 include/linux/thermal.h        |   17 -----------------
 2 files changed, 28 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1389,17 +1389,6 @@ free_tz:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 
-struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
-							 void *devdata, struct thermal_zone_device_ops *ops,
-							 const struct thermal_zone_params *tzp, int passive_delay,
-							 int polling_delay)
-{
-	return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
-						       devdata, ops, tzp,
-						       passive_delay, polling_delay);
-}
-EXPORT_SYMBOL_GPL(thermal_zone_device_register);
-
 struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const char *type,
 					void *devdata,
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -300,14 +300,6 @@ int thermal_acpi_critical_trip_temp(stru
 #endif
 
 #ifdef CONFIG_THERMAL
-struct thermal_zone_device *thermal_zone_device_register(
-					const char *type,
-					int num_trips, int mask,
-					void *devdata,
-					struct thermal_zone_device_ops *ops,
-					const struct thermal_zone_params *tzp,
-					int passive_delay, int polling_delay);
-
 struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
 					struct thermal_trip *trips,
@@ -364,15 +356,6 @@ int thermal_zone_device_enable(struct th
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
 #else
-static inline struct thermal_zone_device *thermal_zone_device_register(
-					const char *type,
-					int num_trips, int mask,
-					void *devdata,
-					struct thermal_zone_device_ops *ops,
-					const struct thermal_zone_params *tzp,
-					int passive_delay, int polling_delay)
-{ return ERR_PTR(-ENODEV); }
-
 static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
 					struct thermal_trip *trips,



