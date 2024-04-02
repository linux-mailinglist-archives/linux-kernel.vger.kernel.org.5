Return-Path: <linux-kernel+bounces-128539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A65895C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269DD1C23134
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B415DBA5;
	Tue,  2 Apr 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="w+fVfbyT"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FFF15B99A;
	Tue,  2 Apr 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084695; cv=none; b=ZyzTuBw9ys8gCwW3s2MFXo7c05dIe03E2Qii1xwPzT/7SimoEOx98Tx+ar7j4Pmh/zVc5sYFKiqy5ce4iFj6n8o4x8PIBYfchS+8QFiFN8YgUG1+uXkUsz1TjVgVKRWZE/UvnBNdvb6ZI6fSllKW4T0/hIJ3RYlKKb1TTCAYu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084695; c=relaxed/simple;
	bh=wzIsy3VQDlBGw+7uW7g3iVZulK0Nu3N12kfqV3jCw8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1wtw7R51n7wxsOySVa/JEB4EmP6VMQXMxaiwzFK4pPYY1Fmaxrc49hzVYUEHDGQprF8NQikG2I8Y66SOrhax7OTdCGMLNemxW6wJexinEqfYrOAq24TW/6hm8iZFl4dhiQmzXRTgOULq0tL3wcUWjkhv/cgSqkeCvPd0Oo6Jco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=w+fVfbyT reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id f4ddfa00e9c9d763; Tue, 2 Apr 2024 21:04:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 26B8166C5C5;
	Tue,  2 Apr 2024 21:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712084684;
	bh=wzIsy3VQDlBGw+7uW7g3iVZulK0Nu3N12kfqV3jCw8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w+fVfbyTxkgRk+xS9a61K46CWTpB3y04BmozmEuJysA75l8Zcpu3UV8ZWcS4uPT8u
	 q5D9J/kReRV74B0oP3pyNMMyoZhYCqYVn9wEw163rI3ZkZ/SYaqM1go7og2qIwtGO/
	 anjMjiL0qAZLFQ38p3ezbyphg3TdOAe/age9hwRgf0nXxMLTYt51PmWokl6UvSLaXY
	 pGOmKTypGdJxANeprGJ2bqoulkOtslvXmFgAApgNTki1Yx3RRr7wAXvDZKD9aYt4pk
	 3UBqCTRfTnmXpPy1bOjkaEzWiedmpCz+J7NP35rqzY/MmvK5PV3Uk+5BpS5gcUl75O
	 Nxr6Tgx8jzT6g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v3 2/6] thermal: core: Make struct thermal_zone_device definition
 internal
Date: Tue, 02 Apr 2024 20:57:57 +0200
Message-ID: <13485814.uLZWGnKmhe@kreacher>
In-Reply-To: <4558251.LvFx2qVVIh@kreacher>
References: <4558251.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgr
 rhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the definitions of struct thermal_trip_desc and struct
thermal_zone_device to an internal header file in the thermal core,
as they don't need to be accessible to any code other than the thermal
core and so they don't need to be present in a global header.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Minor changelog update

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.h  |   85 +++++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_trace.h |    2 
 include/linux/thermal.h         |   87 ----------------------------------------
 3 files changed, 89 insertions(+), 85 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -15,6 +15,91 @@
 #include "thermal_netlink.h"
 #include "thermal_debugfs.h"
 
+struct thermal_trip_desc {
+	struct thermal_trip trip;
+	int threshold;
+};
+
+/**
+ * struct thermal_zone_device - structure for a thermal zone
+ * @id:		unique id number for each thermal zone
+ * @type:	the thermal zone device type
+ * @device:	&struct device for this thermal zone
+ * @removal:	removal completion
+ * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
+ * @trip_type_attrs:	attributes for trip points for sysfs: trip type
+ * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
+ * @mode:		current mode of this thermal zone
+ * @devdata:	private pointer for device private data
+ * @num_trips:	number of trip points the thermal zone supports
+ * @passive_delay_jiffies: number of jiffies to wait between polls when
+ *			performing passive cooling.
+ * @polling_delay_jiffies: number of jiffies to wait between polls when
+ *			checking whether trip points have been crossed (0 for
+ *			interrupt driven systems)
+ * @temperature:	current temperature.  This is only for core code,
+ *			drivers should use thermal_zone_get_temp() to get the
+ *			current temperature
+ * @last_temperature:	previous temperature read
+ * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
+ * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
+ * @prev_low_trip:	the low current temperature if you've crossed a passive
+			trip point.
+ * @prev_high_trip:	the above current temperature if you've crossed a
+			passive trip point.
+ * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
+ * @ops:	operations this &thermal_zone_device supports
+ * @tzp:	thermal zone parameters
+ * @governor:	pointer to the governor for this thermal zone
+ * @governor_data:	private pointer for governor data
+ * @thermal_instances:	list of &struct thermal_instance of this thermal zone
+ * @ida:	&struct ida to generate unique id for this zone's cooling
+ *		devices
+ * @lock:	lock to protect thermal_instances list
+ * @node:	node in thermal_tz_list (in thermal_core.c)
+ * @poll_queue:	delayed work for polling
+ * @notify_event: Last notification event
+ * @suspended: thermal zone suspend indicator
+ * @trips:	array of struct thermal_trip objects
+ */
+struct thermal_zone_device {
+	int id;
+	char type[THERMAL_NAME_LENGTH];
+	struct device device;
+	struct completion removal;
+	struct attribute_group trips_attribute_group;
+	struct thermal_attr *trip_temp_attrs;
+	struct thermal_attr *trip_type_attrs;
+	struct thermal_attr *trip_hyst_attrs;
+	enum thermal_device_mode mode;
+	void *devdata;
+	int num_trips;
+	unsigned long passive_delay_jiffies;
+	unsigned long polling_delay_jiffies;
+	int temperature;
+	int last_temperature;
+	int emul_temperature;
+	int passive;
+	int prev_low_trip;
+	int prev_high_trip;
+	atomic_t need_update;
+	struct thermal_zone_device_ops ops;
+	struct thermal_zone_params *tzp;
+	struct thermal_governor *governor;
+	void *governor_data;
+	struct list_head thermal_instances;
+	struct ida ida;
+	struct mutex lock;
+	struct list_head node;
+	struct delayed_work poll_queue;
+	enum thermal_notify_event notify_event;
+	bool suspended;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
+	struct thermal_trip_desc trips[] __counted_by(num_trips);
+};
+
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -73,17 +73,14 @@ struct thermal_trip {
 	void *priv;
 };
 
-struct thermal_trip_desc {
-	struct thermal_trip trip;
-	int threshold;
-};
-
 #define THERMAL_TRIP_FLAG_RW_TEMP	BIT(0)
 #define THERMAL_TRIP_FLAG_RW_HYST	BIT(1)
 
 #define THERMAL_TRIP_FLAG_RW	(THERMAL_TRIP_FLAG_RW_TEMP | \
 				 THERMAL_TRIP_FLAG_RW_HYST)
 
+struct thermal_zone_device;
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -130,86 +127,6 @@ struct thermal_cooling_device {
 };
 
 /**
- * struct thermal_zone_device - structure for a thermal zone
- * @id:		unique id number for each thermal zone
- * @type:	the thermal zone device type
- * @device:	&struct device for this thermal zone
- * @removal:	removal completion
- * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
- * @trip_type_attrs:	attributes for trip points for sysfs: trip type
- * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
- * @mode:		current mode of this thermal zone
- * @devdata:	private pointer for device private data
- * @num_trips:	number of trip points the thermal zone supports
- * @passive_delay_jiffies: number of jiffies to wait between polls when
- *			performing passive cooling.
- * @polling_delay_jiffies: number of jiffies to wait between polls when
- *			checking whether trip points have been crossed (0 for
- *			interrupt driven systems)
- * @temperature:	current temperature.  This is only for core code,
- *			drivers should use thermal_zone_get_temp() to get the
- *			current temperature
- * @last_temperature:	previous temperature read
- * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
- * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
- * @prev_low_trip:	the low current temperature if you've crossed a passive
-			trip point.
- * @prev_high_trip:	the above current temperature if you've crossed a
-			passive trip point.
- * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
- * @ops:	operations this &thermal_zone_device supports
- * @tzp:	thermal zone parameters
- * @governor:	pointer to the governor for this thermal zone
- * @governor_data:	private pointer for governor data
- * @thermal_instances:	list of &struct thermal_instance of this thermal zone
- * @ida:	&struct ida to generate unique id for this zone's cooling
- *		devices
- * @lock:	lock to protect thermal_instances list
- * @node:	node in thermal_tz_list (in thermal_core.c)
- * @poll_queue:	delayed work for polling
- * @notify_event: Last notification event
- * @suspended: thermal zone suspend indicator
- * @trips:	array of struct thermal_trip objects
- */
-struct thermal_zone_device {
-	int id;
-	char type[THERMAL_NAME_LENGTH];
-	struct device device;
-	struct completion removal;
-	struct attribute_group trips_attribute_group;
-	struct thermal_attr *trip_temp_attrs;
-	struct thermal_attr *trip_type_attrs;
-	struct thermal_attr *trip_hyst_attrs;
-	enum thermal_device_mode mode;
-	void *devdata;
-	int num_trips;
-	unsigned long passive_delay_jiffies;
-	unsigned long polling_delay_jiffies;
-	int temperature;
-	int last_temperature;
-	int emul_temperature;
-	int passive;
-	int prev_low_trip;
-	int prev_high_trip;
-	atomic_t need_update;
-	struct thermal_zone_device_ops ops;
-	struct thermal_zone_params *tzp;
-	struct thermal_governor *governor;
-	void *governor_data;
-	struct list_head thermal_instances;
-	struct ida ida;
-	struct mutex lock;
-	struct list_head node;
-	struct delayed_work poll_queue;
-	enum thermal_notify_event notify_event;
-	bool suspended;
-#ifdef CONFIG_THERMAL_DEBUGFS
-	struct thermal_debugfs *debugfs;
-#endif
-	struct thermal_trip_desc trips[] __counted_by(num_trips);
-};
-
-/**
  * struct thermal_governor - structure that holds thermal governor information
  * @name:	name of the governor
  * @bind_to_tz: callback called when binding to a thermal zone.  If it
Index: linux-pm/drivers/thermal/thermal_trace.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trace.h
+++ linux-pm/drivers/thermal/thermal_trace.h
@@ -9,6 +9,8 @@
 #include <linux/thermal.h>
 #include <linux/tracepoint.h>
 
+#include "thermal_core.h"
+
 TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);




