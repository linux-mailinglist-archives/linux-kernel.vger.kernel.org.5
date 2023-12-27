Return-Path: <linux-kernel+bounces-11968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603F281EE50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1605F283B34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A34439A;
	Wed, 27 Dec 2023 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4QlTTPn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE0A44374
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336c9acec03so1507366f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703673951; x=1704278751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pg6XiFOzjT3bgag//+MTHDLXZWXP1BzRE73I0Dy4cLk=;
        b=e4QlTTPnl7uz9w8ImfgRJtVrLQ9gCwtZ6aeMLiuGOUtGl9kO5aeQfycXR9rSa5hKDZ
         Kqt1HQvWsA6o7CVLJcO86nPgHq8YekN9YloUcXVh24L9lSoV3Y+znolNELvLl1UIu4s4
         rpSigSigdTH6/w/w5gnPAVJfcx7njaPG0ni838rdnVed330EDt8AQF+wOF3mHRH4QEPx
         +JACvBgcMS6Wp96ozwgUWYXMmhMOuygXWnKPYZga7As4LjA43J2PHBwZmS8Xsyqf2gID
         45Kv57FQ4NWCBSfZOYsiS2x0yfp1OPhfXk8CKzcN6t0p07J4g0R7SiWeNKAO2Ut2wv5V
         C/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703673951; x=1704278751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg6XiFOzjT3bgag//+MTHDLXZWXP1BzRE73I0Dy4cLk=;
        b=MVB3vz3sLYIcImJvgzg+W6BBus3+WhhcAEXpokxOCDNnrowl93ezysDYc3ir/wBU2F
         /pBOA9W2CiG5tHfsKDEAzzVkNeN0H7pzFDQXd/07YDVZ+UhZBzDkh200nXgMK3J+6ppn
         iOqHAfqMB64e0W8ca9ncb2vMyBL5NhfDKI5YWMxTf47eBNfcXgTy43pYKB2kbU0/nT4y
         J396b//fP65KLmot6Nn8nGp0EhXNC4WDYi566GFoAB2XXq2MYDpwA7Kdu0Pxli31uwo7
         ZKysEXa2ODijoSUS+gZaVoy+8gh0i0nhaOHngYb57GJGmH0k6IQ1zhsU0bZWmT299l98
         uooA==
X-Gm-Message-State: AOJu0Yx7qiOVv33LW8TczNj6slBu+iDxJc7UYqPaXj7CBIkZrKHFNcyB
	GvxPlt7zGJfdDPb2/TAMmDliDgtaBqkkOg==
X-Google-Smtp-Source: AGHT+IFf7ga6Rmf5APlQdXCMZZb9lLPZhnycI+qCX2F66exdZMIM3JkCCCbR4rA2SKFiuXYzw5JnGA==
X-Received: by 2002:a5d:6dad:0:b0:336:e64c:f539 with SMTP id u13-20020a5d6dad000000b00336e64cf539mr1077311wrs.59.1703673951212;
        Wed, 27 Dec 2023 02:45:51 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b00336644c400bsm14509421wro.64.2023.12.27.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:45:50 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rjw@rjwysocki.net,
	lukasz.luba@arm.com
Cc: rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 2/2] thermal/debugfs: Add thermal debugfs information for mitigation episodes
Date: Wed, 27 Dec 2023 11:45:32 +0100
Message-Id: <20231227104532.2671761-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227104532.2671761-1-daniel.lezcano@linaro.org>
References: <20231227104532.2671761-1-daniel.lezcano@linaro.org>
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

Please note this code is immune against trip ordering but not against
a trip temperature change while a mitigation is happening. However,
this situation should be extremely rare, perhaps not happening and we
might question ourselves if something should be done in the core
framework for other components first.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changelog:
  - v5
    - No changes
  - v4
    - Reworded "trip violation" (Rafael)
    - Reworded some comments and clarified other ones (Rafael)
    - Renamed s/tz/tz_dbg/ for clarity (Rafael)
    - Used flexible array and struct_size for allocation (Rafael)
    - Renamed s/dfs/thermal_dbg/ for clarity (Rafael)
    - Used intermediate variable to prevent dereferencing multiple times a structure (Rafael)
    - Renamed variable s/trip/trip_id/ (Rafael)
    - Clarified trip_index usage in the comment (Rafael)
  - v3
    - Fixed kerneldoc (kbuild)
    - Fixed wrong indentation s/<space>/<tab>/
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
 drivers/thermal/thermal_debugfs.c | 383 +++++++++++++++++++++++++++++-
 drivers/thermal/thermal_debugfs.h |  14 ++
 3 files changed, 403 insertions(+), 1 deletion(-)

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
index 84e5ef3dc16c..0f0f0e603428 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -14,8 +14,11 @@
 #include <linux/mutex.h>
 #include <linux/thermal.h>
 
+#include "thermal_core.h"
+
 static struct dentry *d_root;
 static struct dentry *d_cdev;
+static struct dentry *d_tz;
 
 /*
  * Length of the string containing the thermal zone id or the cooling
@@ -81,22 +84,87 @@ struct cdev_record {
         };
 };
 
+/**
+ * struct trip_stats - Thermal trip statistics
+ *
+ * The trip_stats structure has the relevant information to show the
+ * statistics related to temperature going above a trip point.
+ *
+ * @timestamp: the trip crossing timestamp
+ * @duration: total time when the zone temperature was above the trip point
+ * @count: the number of times the zone temperature was above the trip point
+ * @max: maximum recorded temperature above the trip point
+ * @min: minimum recorded temperature above the trip point
+ * @avg: average temperature above the trip point
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
+ * struct tz_events - Collection of all mitigation episodes for a thermal zone
+ *
+ * The tz_events structure describes a mitigation episode. A
+ * mitigation episode is when the mitigation begins and ends. During
+ * this episode we can have multiple trip points crossed the way up
+ * and down if there are multiple trip describes in the firmware.
+ *
+ * @timestamp: First trip point crossed the way up
+ * @duration: total duration of the mitigation episode
+ * @node: a list element to be added to the list of tz events
+ * @trip_stats: per trip point statistics, flexible array
+ */
+struct tz_events {
+	ktime_t timestamp;
+	ktime_t duration;
+	struct list_head node;
+	struct trip_stats trip_stats[];
+};
+
+/**
+ * struct tz_debugfs - Store all mitigations episodes for a thermal zone
+ *
+ * The tz_debugfs structure contains the list of the mitigation
+ * episodes and has to track which trip point has been crossed in
+ * order to handle correctly nested trip point mitigation episodes.
+ *
+ * We keep the history of the trip point crossed in an array and as we
+ * can go back and forth inside this history, eg. trip 0,1,2,1,2,1,0,
+ * we keep track of the current position in the history array.
+ *
+ * @tz_events: a list of thermal mitigation episodes
+ * @trips_crossed: an array of trip points crossed by id
+ * @trip_index: the current trip point index in the trip points history
+ */
+struct tz_debugfs {
+	struct list_head tz_events;
+	int *trips_crossed;
+	int trip_index;
+};
+
 /**
  * struct thermal_debugfs - High level structure for a thermal object in debugfs
  *
  * The thermal_debugfs structure is the common structure used by the
- * cooling device to compute the statistics.
+ * cooling device or the thermal zone to store the statistics.
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
 		struct cdev_debugfs cdev_dbg;
+		struct tz_debugfs tz_dbg;
 	};
 };
 
@@ -107,6 +175,10 @@ void thermal_debug_init(void)
 		return;
 
 	d_cdev = debugfs_create_dir("cooling_devices", d_root);
+	if (!d_cdev)
+		return;
+
+	d_tz = debugfs_create_dir("thermal_zones", d_root);
 }
 
 static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
@@ -443,3 +515,312 @@ void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_dbg->lock);
 }
+
+static struct tz_events *thermal_debugfs_tz_event_alloc(struct thermal_zone_device *tz,
+							ktime_t now)
+{
+	struct tz_events *tze;
+	int i;
+
+	tze = kzalloc(struct_size(tze, trip_stats, tz->num_trips), GFP_KERNEL);
+	if (!tze)
+		return NULL;
+
+	INIT_LIST_HEAD(&tze->node);
+	tze->timestamp = now;
+
+	for (i = 0; i < tz->num_trips; i++) {
+		tze->trip_stats[i].min = INT_MAX;
+		tze->trip_stats[i].max = INT_MIN;
+	}
+	
+	return tze;
+}
+
+void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip)
+{
+	struct tz_events *tze;
+	struct tz_debugfs *tz_dbg;
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	int temperature = tz->temperature;
+	int trip_id = thermal_zone_trip_id(tz, trip);
+	ktime_t now = ktime_get();
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz_dbg = &thermal_dbg->tz_dbg;
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
+	if (tz_dbg->trip_index < 0) {
+		tze = thermal_debugfs_tz_event_alloc(tz, now);
+		if (!tze)
+			return;
+
+		list_add(&tze->node, &tz_dbg->tz_events);
+	}
+
+	/*
+	 * The trip_index points to the current position in the
+	 * trip_crossed[] array. Each time a trip point is crossed the
+	 * way up, the trip_id is stored in the array and the
+	 * trip_index is incremented. A negative trip_index means we
+	 * are entering a mitigation episode.
+	 *
+	 * The trip ids may not be in the ascending order but the
+	 * result in the array trips_crossed will be in the ascending
+	 * temperature order.
+	 */
+	tz_dbg->trip_index++;
+	tz_dbg->trips_crossed[tz_dbg->trip_index] = trip_id;
+
+	tze = list_first_entry(&tz_dbg->tz_events, struct tz_events, node);
+	tze->trip_stats[trip_id].timestamp = now;
+	tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
+	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
+	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
+		(temperature - tze->trip_stats[trip_id].avg) /
+		tze->trip_stats[trip_id].count;
+
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
+				const struct thermal_trip *trip)
+{
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_events *tze;
+	struct tz_debugfs *tz_dbg;
+
+	int trip_id = thermal_zone_trip_id(tz, trip);
+	ktime_t delta, now = ktime_get();
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz_dbg = &thermal_dbg->tz_dbg;
+	
+	/*
+	 * The temperature crosses the way down but there was not
+	 * mitigation detected before. That may happen when the
+	 * temperature is greater than a trip point when registering a
+	 * thermal zone, which is a common use case as the kernel has
+	 * no mitigation mechanism yet at boot time.
+	 */
+	if (tz_dbg->trip_index < 0)
+		goto out;
+	
+	tze = list_first_entry(&tz_dbg->tz_events, struct tz_events, node);
+
+	delta = ktime_sub(now, tze->trip_stats[trip_id].timestamp);
+	tze->trip_stats[trip_id].duration = ktime_add(delta,
+						      tze->trip_stats[trip_id].duration);
+
+	tz_dbg->trip_index--;
+
+	/*
+	 * This event closes the mitigation as we are crossing the
+	 * last trip point the way down.
+	 */
+	if (tz_dbg->trip_index < 0)
+		tze->duration = ktime_sub(now, tze->timestamp);
+
+out:
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+void thermal_debug_update_temp(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_events *tze;
+	struct tz_debugfs *tz_dbg;
+	int trip_id;
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz_dbg = &thermal_dbg->tz_dbg;
+	
+	if (tz_dbg->trip_index >= 0) {
+		trip_id = tz_dbg->trip_index;
+		tze = list_first_entry(&tz_dbg->tz_events, struct tz_events, node);
+		tze->trip_stats[trip_id].count++;
+		tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, tz->temperature);
+		tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, tz->temperature);
+		tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
+			(tz->temperature - tze->trip_stats[trip_id].avg) /
+			tze->trip_stats[trip_id].count;
+	}
+
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+static void *tze_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	return seq_list_start(&tz_dbg->tz_events, *pos);
+}
+
+static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	struct tz_debugfs *tz_dbg = &thermal_dbg->tz_dbg;
+
+	return seq_list_next(v, &tz_dbg->tz_events, pos);
+}
+
+static void tze_seq_stop(struct seq_file *s, void *v)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+
+	mutex_unlock(&thermal_dbg->lock);
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
+	struct thermal_debugfs *thermal_dbg;
+	struct tz_debugfs *tz_dbg;
+
+	thermal_dbg = thermal_debugfs_add_id(d_tz, tz->id);
+	if (!thermal_dbg)
+		return;
+
+	tz_dbg = &thermal_dbg->tz_dbg;
+
+	tz_dbg->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
+	if (!tz_dbg->trips_crossed) {
+		thermal_debugfs_remove_id(thermal_dbg);
+		return;
+	}
+
+	/*
+	 * Trip index '-1' means no mitigation
+	 */
+	tz_dbg->trip_index = -1;
+	INIT_LIST_HEAD(&tz_dbg->tz_events);
+
+	debugfs_create_file("mitigations", 0400, thermal_dbg->d_top, tz, &tze_fops);
+	
+	tz->debugfs = thermal_dbg;
+}
+
+void thermal_debug_tz_remove(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz->debugfs = NULL;
+	thermal_debugfs_remove_id(thermal_dbg);
+
+	mutex_unlock(&thermal_dbg->lock);
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


