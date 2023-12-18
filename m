Return-Path: <linux-kernel+bounces-4147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A8A817870
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB3B23497
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D145BFAC;
	Mon, 18 Dec 2023 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2NO1UY1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3C5A852
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso34245375e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702919989; x=1703524789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BORX4OHLb6tkKvWU5S4VJ6LuhVOHlvLhrDQp3xoQzU=;
        b=F2NO1UY1seHRNxotuf4XX2ACV2YF8w7grwkdTDtFgZFCzDrgyZODsFgU8lpotunN9z
         Ze++/OFXL9Jl+elUf7ajxYcm7YXpn6w3LI6VfTkHvHyM5hPTyoRs30L8xHt1R9TjULS9
         EkjWTXJXyVSH651OLY4cDGKu4bLPWa858pJy26y4hVb4XNsCllQ8cgjl/+R78AznnrWB
         FqDOEuFxP3AFu5rMO1gAy06bQjriZrErzwSemgBRymy9MbvF51jsp6DF5CtqWD/cSSzc
         DFRyJxOqQ+nX5xlAfbYMEryCB9z1i/y48oIuOVl/bXx0AXtqvlF7pRMwJBdBNc50GUa+
         8Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919989; x=1703524789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BORX4OHLb6tkKvWU5S4VJ6LuhVOHlvLhrDQp3xoQzU=;
        b=pGiu3DtKuNrLJGPZemv7xeKUDHjTOVKVW0qswS8TTUQTTbmfLA+Uf9OlB0m+AYNUEX
         zRGDB6AliFXX6jcBFuxhWNg1nE3rjIXEGJPKDb8rqgGyB3AIPgEHZrC5carzSUtjm8gP
         UNtptLZzbVJnsBU+Pi5/1nnj6yqxcts7+5OKxkMsE7Qu2ocLQv4w2Eqk96RAX86+9tzK
         Ci79BVLyimZYMQCUjSwmhhq+5Yq0E9EWEOKZaO8LUGv9zluEhbjymPxs7Uq7eqE+Ws5D
         csMOFnDOcBcm16IOKdOlP3haWIj2VmXiT3AI4848KpjoXp3NrMYRDoDSXia1ug6zMHcv
         dAGQ==
X-Gm-Message-State: AOJu0Yy4WGvIyrGSEkJNvmRyCcj+BQDcUMd3B5F0LIWm0n4FdYVO8M67
	PsPsWomTQxX570Sjmvpjtl+6nQ==
X-Google-Smtp-Source: AGHT+IGvLq4VaOmJIwsrt7gkR8pJNpB/JiJprnJdALGPZxCEZquPgg25h7DQCJIwxKo+3z8NV5Y7rw==
X-Received: by 2002:a05:600c:5409:b0:40c:713a:723d with SMTP id he9-20020a05600c540900b0040c713a723dmr2332919wmb.157.1702919989470;
        Mon, 18 Dec 2023 09:19:49 -0800 (PST)
Received: from mai.box.freepro.com ([37.170.230.132])
        by smtp.gmail.com with ESMTPSA id je22-20020a05600c1f9600b0040c5177a479sm28733803wmb.20.2023.12.18.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:19:49 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rjw@rjwysocki.net,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 2/2] thermal/debugfs: Add thermal debugfs information for mitigation episodes
Date: Mon, 18 Dec 2023 18:19:41 +0100
Message-Id: <20231218171942.3048095-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218171942.3048095-1-daniel.lezcano@linaro.org>
References: <20231218171942.3048095-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mitigation episodes are recorded. A mitigation episode happens
when the first trip point is crossed the way up and then the way
down. During this episode other trip points can be crossed also and
are accounted for this mitigation episode. The interesting information
is the average temperature at the trip point, the undershot and the
overshot. The standard deviation of the mitigated temperature will be
added later.

The thermal debugfs directory structure tries to stay consistent with
the sysfs one but in a very simplified way:

thermal/
 `-- thermal_zones
     |-- 0
     |   `-- mitigations
     `-- 1
         `-- mitigations

The content of the mitigations file has the following format:

,-Mitigation at 349988258us, duration=130136ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |     130136 |     68227 |     62500 |     75625 |
|    1 |  passive |     75000 |      2000 |     104209 |     74857 |     71666 |     77500 |
,-Mitigation at 272451637us, duration=75000ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |      75000 |     68561 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      60714 |     74820 |     70555 |     77500 |
,-Mitigation at 238184119us, duration=27316ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |      27316 |     73377 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      19468 |     75284 |     69444 |     77500 |
,-Mitigation at 39863713us, duration=136196ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |     136196 |     73922 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      91721 |     74386 |     69444 |     78125 |

More information for a better understanding of the thermal behavior
will be added after. The idea is to give detailed statistics
information about the undershots and overshots, the temperature speed,
etc... As all the information in a single file is too much, the idea
would be to create a directory named with the mitigation timestamp
where all data could be added.

Please note this code is immune against trip ordering.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changelog:
  - v2
    - Applied changes based on comments from patch 1/2
    - Constified structure in function parameters
  - v1 (from RFC):
    - Replaced exported function name s/debugfs/debug/
    - Used "struct thermal_trip" parameter instead of "trip_id"
    - Renamed handle_way_[up|down] by tz_trip_[up|down]
    - Replaced thermal_debug_tz_[unregister|register] by [add|remove]
---
 drivers/thermal/thermal_core.c    |   7 +
 drivers/thermal/thermal_debugfs.c | 367 +++++++++++++++++++++++++++++-
 drivers/thermal/thermal_debugfs.h |  14 ++
 3 files changed, 387 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 33332d401b13..a0cbe8d7b945 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -367,6 +367,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 			thermal_notify_tz_trip_up(tz->id,
 						  thermal_zone_trip_id(tz, trip),
 						  tz->temperature);
+			thermal_debug_tz_trip_up(tz, trip);
 			trip->threshold = trip->temperature - trip->hysteresis;
 		} else {
 			trip->threshold = trip->temperature;
@@ -386,6 +387,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 			thermal_notify_tz_trip_down(tz->id,
 						    thermal_zone_trip_id(tz, trip),
 						    tz->temperature);
+			thermal_debug_tz_trip_down(tz, trip);
 			trip->threshold = trip->temperature;
 		} else {
 			trip->threshold = trip->temperature - trip->hysteresis;
@@ -417,6 +419,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 
 	thermal_genl_sampling_temp(tz->id, temp);
+	thermal_debug_update_temp(tz);
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
@@ -1396,6 +1399,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	thermal_notify_tz_create(tz->id, tz->type);
 
+	thermal_debug_tz_add(tz);
+
 	return tz;
 
 unregister:
@@ -1461,6 +1466,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
+	thermal_debug_tz_remove(tz);
+
 	tz_id = tz->id;
 
 	mutex_lock(&thermal_list_lock);
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index 6465d84a0905..b5c14b7db3b2 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -13,8 +13,11 @@
 #include <linux/mutex.h>
 #include <linux/thermal.h>
 
+#include "thermal_core.h"
+
 static struct dentry *d_root;
 static struct dentry *d_cdev;
+static struct dentry *d_tz;
 
 /*
  * Length of the string containing the thermal zone id or the cooling
@@ -76,23 +79,85 @@ struct cdev_value {
 	u64 value;
 };
 
+/**
+ * struct trip_stats - Thermal trip statistics
+ *
+ * The trip_stats structure has the relevant information to show the
+ * statistics related to a trip point violation during a mitigation
+ * episode.
+ *
+ * @timestamp: the trip crossing timestamp
+ * @duration: the total duration of trip point violation
+ * @count: the number of occurrences of the trip point violation
+ * @max: maximum temperature during the trip point violation
+ * @min: min temperature during the trip point violation
+ * @avg: average temperature during the trip point violation
+ */
+struct trip_stats {
+	ktime_t timestamp;
+	ktime_t duration;
+	int count;
+	int max;
+	int min;
+	int avg;
+};
+
+/**
+ * struct tz_events - Store all events related to a mitigation episode
+ *
+ * The tz_events structure describes a mitigation episode. A
+ * mitigation episode is when the mitigation begins and ends. During
+ * this episode we can have multiple trip points crossed the way up
+ * and down if there are multiple trip describes in the firmware.
+ *
+ * @node: a list element to be added to the list of tz events
+ * @trip_stats: per trip point statistics
+ * @timestamp: First trip point crossed the way up
+ * @duration: total duration of the mitigation episode
+ */
+struct tz_events {
+	struct list_head node;
+	struct trip_stats *trip_stats;
+	ktime_t timestamp;
+	ktime_t duration;
+};
+
+/**
+ * struct tz_debugfs - Store all mitigations episodes for a thermal zone
+ *
+ * The tz_debugfs structure contains the list of the mitigation
+ * episodes and has to track which trip point has been crossed in
+ * order to handle correctly nested trip point mitigation episodes.
+ *
+ * @tz_events: a list of thermal mitigation episodes
+ * @trip_crossed: an array of trip point crossed by id
+ * @trip_index: the current trip point crossed
+ */
+struct tz_debugfs {
+	struct list_head tz_events;
+	int *trips_crossed;
+	int trip_index;
+};
+
 /**
  * thermal_debugfs - High level structure for a thermal object in
  * debugfs
  *
  * The thermal_debugfs structure is the common structure used by the
- * cooling device to compute the statistics.
+ * cooling device and the thermal zone to store the statistics.
  *
  * @d_top: top directory of the thermal object directory
  * @lock: per object lock to protect the internals
  *
  * @cdev: a cooling device debug structure
+ * @tz: a thermal zone debug structure
  */
 struct thermal_debugfs {
 	struct dentry *d_top;
 	struct mutex lock;
 	union {
 		struct cdev_debugfs cdev;
+		struct tz_debugfs tz;
 	};
 };
 
@@ -103,6 +168,10 @@ void thermal_debug_init(void)
 		return;
 
 	d_cdev = debugfs_create_dir("cooling_devices", d_root);
+	if (!d_cdev)
+		return;
+
+	d_tz = debugfs_create_dir("thermal_zones", d_root);
 }
 
 static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
@@ -423,3 +492,299 @@ void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&dfs->lock);
 }
+
+static struct tz_events *thermal_debugfs_tz_event_alloc(struct thermal_zone_device *tz,
+							ktime_t now)
+{
+	struct tz_events *tze;
+	struct trip_stats *trip_stats;
+	int i;
+
+	tze = kzalloc(sizeof(*tze), GFP_KERNEL);
+	if (!tze)
+		return NULL;
+
+	INIT_LIST_HEAD(&tze->node);
+	tze->timestamp = now;
+
+	trip_stats = kzalloc(sizeof(struct trip_stats) * tz->num_trips, GFP_KERNEL);
+	if (!trip_stats) {
+		kfree(tze);
+		return NULL;
+	}
+
+	for (i = 0; i < tz->num_trips; i++) {
+		trip_stats[i].min = INT_MAX;
+		trip_stats[i].max = INT_MIN;
+	}
+	
+	tze->trip_stats = trip_stats;
+
+	return tze;
+}
+
+void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip)
+{
+	struct tz_events *tze;
+	struct thermal_debugfs *dfs = tz->debugfs;
+	int temperature = tz->temperature;
+	int trip_id = thermal_zone_trip_id(tz, trip);
+	ktime_t now = ktime_get();
+
+	if (!dfs)
+		return;
+
+	mutex_lock(&dfs->lock);
+
+	/*
+	 * The mitigation is starting. A mitigation can contain
+	 * several episodes where each of them is related to a
+	 * temperature crossing a trip point. The episodes are
+	 * nested. That means when the temperature is crossing the
+	 * first trip point, the duration begins to be measured. If
+	 * the temperature continues to increase and reaches the
+	 * second trip point, the duration of the first trip must be
+	 * also accumulated.
+	 *
+	 * eg.
+	 *
+	 * temp
+	 *   ^
+	 *   |             --------
+	 * trip 2         /        \         ------
+	 *   |           /|        |\      /|      |\
+	 * trip 1       / |        | `----  |      | \
+	 *   |         /| |        |        |      | |\
+	 * trip 0     / | |        |        |      | | \
+	 *   |       /| | |        |        |      | | |\
+	 *   |      / | | |        |        |      | | | `--
+	 *   |     /  | | |        |        |      | | |     
+	 *   |-----   | | |        |        |      | | |      
+	 *   |        | | |        |        |      | | |
+	 *    --------|-|-|--------|--------|------|-|-|------------------> time
+	 *            | | |<--t2-->|        |<-t2'>| | |
+	 *            | |                            | |
+	 *            | |<------------t1------------>| |
+	 *            |                                |
+	 *            |<-------------t0--------------->|
+	 *
+	 */
+	if (dfs->tz.trip_index < 0) {
+		tze = thermal_debugfs_tz_event_alloc(tz, now);
+		if (!tze)
+			return;
+
+		list_add(&tze->node, &dfs->tz.tz_events);
+	}
+
+	dfs->tz.trip_index++;
+	dfs->tz.trips_crossed[dfs->tz.trip_index] = trip_id;
+
+	tze = list_first_entry(&dfs->tz.tz_events, struct tz_events, node);
+	tze->trip_stats[trip_id].timestamp = now;
+        tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
+	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
+	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
+		(temperature - tze->trip_stats[trip_id].avg) /
+		tze->trip_stats[trip_id].count;
+
+	mutex_unlock(&dfs->lock);
+}
+
+void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
+				const struct thermal_trip *trip)
+{
+	struct thermal_debugfs *dfs = tz->debugfs;
+	struct tz_events *tze;
+	int trip_id = thermal_zone_trip_id(tz, trip);
+	ktime_t delta, now = ktime_get();
+
+	if (!dfs)
+		return;
+
+	/*
+	 * The temperature crosses the way down but there was not
+	 * mitigation detected before. That may happen when the
+	 * temperature is greater than a trip point when registering a
+	 * thermal zone, which is a common use case as the kernel has
+	 * no mitigation mechanism yet at boot time.
+	 */
+	if (dfs->tz.trip_index < 0)
+		return;
+	
+	mutex_lock(&dfs->lock);
+	
+	tze = list_first_entry(&dfs->tz.tz_events, struct tz_events, node);
+
+	delta = ktime_sub(now, tze->trip_stats[trip_id].timestamp);
+	tze->trip_stats[trip_id].duration = ktime_add(delta,
+						      tze->trip_stats[trip_id].duration);
+
+	dfs->tz.trip_index--;
+
+	/*
+	 * This event closes the mitigation as we are crossing the
+	 * last trip point the way down.
+	 */
+	if (dfs->tz.trip_index < 0)
+		tze->duration = ktime_sub(now, tze->timestamp);
+
+	mutex_unlock(&dfs->lock);
+}
+
+void thermal_debug_update_temp(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *dfs = tz->debugfs;
+	struct tz_events *tze;
+	int trip;
+
+	if (!dfs)
+		return;
+
+	mutex_lock(&dfs->lock);
+
+	if (dfs->tz.trip_index >= 0) {
+		trip = dfs->tz.trip_index;
+		tze = list_first_entry(&dfs->tz.tz_events, struct tz_events, node);
+		tze->trip_stats[trip].count++;
+		tze->trip_stats[trip].max = max(tze->trip_stats[trip].max, tz->temperature);
+		tze->trip_stats[trip].min = min(tze->trip_stats[trip].min, tz->temperature);
+		tze->trip_stats[trip].avg = tze->trip_stats[trip].avg +
+			(tz->temperature - tze->trip_stats[trip].avg) /
+			tze->trip_stats[trip].count;
+	}
+
+	mutex_unlock(&dfs->lock);
+}
+
+static void *tze_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *dfs = tz->debugfs;
+	struct tz_debugfs *tzd = &dfs->tz;
+
+	mutex_lock(&dfs->lock);
+
+	return seq_list_start(&tzd->tz_events, *pos);
+}
+
+static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *dfs = tz->debugfs;
+        struct tz_debugfs *tzd = &dfs->tz;
+
+	return seq_list_next(v, &tzd->tz_events, pos);
+}
+
+static void tze_seq_stop(struct seq_file *s, void *v)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *dfs = tz->debugfs;
+
+	mutex_unlock(&dfs->lock);
+}
+
+static int tze_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct tz_events *tze;
+	int i;
+
+	tze = list_entry((struct list_head *)v, struct tz_events, node);
+
+	seq_printf(s, ",-Mitigation at %lluus, duration=%llums\n",
+		   ktime_to_us(tze->timestamp),
+		   ktime_to_ms(tze->duration));
+
+	seq_printf(s, "| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |\n");
+	
+	for (i = 0; i < tz->num_trips; i++) {
+
+		struct thermal_trip trip;
+		const char *type;
+		
+		if (__thermal_zone_get_trip(tz, i, &trip))
+			continue;
+
+		/*
+		 * There is no possible mitigation happening at the
+		 * critical trip point, so the stats will be always
+		 * zero, skip this trip point
+		 */
+		if (trip.type == THERMAL_TRIP_CRITICAL)
+			continue;
+
+		if (trip.type == THERMAL_TRIP_PASSIVE)
+			type = "passive";
+		else if (trip.type == THERMAL_TRIP_ACTIVE)
+			type = "active";
+		else
+			type = "hot";
+
+		seq_printf(s, "| %*d | %*s | %*d | %*d | %*lld | %*d | %*d | %*d |\n",
+			   4 , i,
+			   8, type,
+			   9, trip.temperature,
+			   9, trip.hysteresis,
+			   10, ktime_to_ms(tze->trip_stats[i].duration),
+			   9, tze->trip_stats[i].avg,
+			   9, tze->trip_stats[i].min,
+			   9, tze->trip_stats[i].max);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations tze_sops = {
+	.start = tze_seq_start,
+	.next = tze_seq_next,
+	.stop = tze_seq_stop,
+	.show = tze_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(tze);
+
+void thermal_debug_tz_add(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *dfs;
+	struct tz_debugfs *tzd;
+
+	dfs = thermal_debugfs_add_id(d_tz, tz->id);
+	if (!dfs)
+		return;
+
+	tzd = &dfs->tz;
+
+	tzd->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
+	if (!tzd->trips_crossed) {
+		thermal_debugfs_remove_id(dfs);
+		return;
+	}
+
+	/*
+	 * Trip index '-1' means no mitigation
+	 */
+	tzd->trip_index = -1;
+	INIT_LIST_HEAD(&tzd->tz_events);
+
+	debugfs_create_file("mitigations", 0400, dfs->d_top, tz, &tze_fops);
+	
+	tz->debugfs = dfs;
+}
+
+void thermal_debug_tz_remove(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *dfs = tz->debugfs;
+
+	if (!dfs)
+		return;
+
+	mutex_lock(&dfs->lock);
+
+	tz->debugfs = NULL;
+	thermal_debugfs_remove_id(dfs);
+
+	mutex_unlock(&dfs->lock);
+}
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
index 341499388448..155b9af5fe87 100644
--- a/drivers/thermal/thermal_debugfs.h
+++ b/drivers/thermal/thermal_debugfs.h
@@ -5,10 +5,24 @@ void thermal_debug_init(void);
 void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
+void thermal_debug_tz_add(struct thermal_zone_device *tz);
+void thermal_debug_tz_remove(struct thermal_zone_device *tz);
+void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip);
+void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
+				const struct thermal_trip *trip);
+void thermal_debug_update_temp(struct thermal_zone_device *tz);
 #else
 static inline void thermal_debug_init(void) {}
 static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
 static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev) {}
 static inline void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
 						   int state) {}
+static inline void thermal_debug_tz_add(struct thermal_zone_device *tz) {}
+static inline void thermal_debug_tz_remove(struct thermal_zone_device *tz) {}
+static inline void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
+					    const struct thermal_trip *trip) {};
+static inline void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
+					      const struct thermal_trip *trip) {}
+static inline void thermal_debug_update_temp(struct thermal_zone_device *tz) {}
 #endif /* CONFIG_THERMAL_DEBUGFS */
-- 
2.34.1


