Return-Path: <linux-kernel+bounces-4146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2681786E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2DF9B22C63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5D5A860;
	Mon, 18 Dec 2023 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azlIfw2x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE21E4A4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c31f18274so43425305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702919988; x=1703524788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bmgywbtarTYE/R5OGLtpCxTw2KT4/npP3w8WRUy57o=;
        b=azlIfw2xi6gcIQlxyZkKjrqSZBfs73Z49hJuxFCRwKPA07BjZ/eJRm1cHJcjltSu+r
         Yw5U9p4ztPYX384i2uCNOIwWvsU4jG6TAkbhGtH1WK4xxBUYKneBjwjpvOfg49Wt9gDN
         n12+R+MmMtYRxsM7iQXAO6LjkA4OJ+1OB09En6swEprBy78PHbeglKcd0qkP06OvawRB
         6z5Jw156WH7pn1+6vPesYvJZGMqel7T5bk9sdIp+7AYx8OfUxkCiX0fZvfDGDxOVpWIp
         x3Yd1NWMNO0WxSda8A+TFnK5GuIjBwaUFWcHVAF7FOmKM+8EGyGiHd32/1e6HT6tQv9D
         HEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919988; x=1703524788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bmgywbtarTYE/R5OGLtpCxTw2KT4/npP3w8WRUy57o=;
        b=d/hWAOX79Mza2Pz8lWyh3i39IZy1TsUkpiJKwrPTdIK5deoP+apmiC4Jqv003j7H3q
         lVEXVK089s5rkxRC74jH7mhq2DfNW+CqkYvNYrthtwnxZ7gk7X8ZorkirzaqDKX+RSnU
         Q+TRZw/H2P/KUZvL3l16ObX6yRfccKqmDZBaH9r88u9biOXL7zeumlmWysBMkCYgPMA6
         xlEogTmXGtWRoatv5OBk6QJnEoRa9089KBFwC47o6Nt8rcrPdV7a6Pwchu/cH5N4QP38
         LNRg+HDKjGTOyRZTNseZ8Urg98PcG341JGRhRq81zUderP/MKwtQvuTt4kszCDG3S4RD
         zP3A==
X-Gm-Message-State: AOJu0YyqhNZj2YwdkDGfjAIAY5h7Vfipz+JH19IIlXSL6Z7xuWNzIoQN
	52A6vTZOrFfhP4N87wbfY1ftMg==
X-Google-Smtp-Source: AGHT+IEXGDmN92fsWmm2au+QbIUrJ8enuMnWzjtIcqrvwznMz9olxpnH3ekXojKIOMZE4YBk7uU1nA==
X-Received: by 2002:a1c:6a0c:0:b0:40c:2cc2:ea74 with SMTP id f12-20020a1c6a0c000000b0040c2cc2ea74mr7390981wmc.8.1702919987823;
        Mon, 18 Dec 2023 09:19:47 -0800 (PST)
Received: from mai.box.freepro.com ([37.170.230.132])
        by smtp.gmail.com with ESMTPSA id je22-20020a05600c1f9600b0040c5177a479sm28733803wmb.20.2023.12.18.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:19:47 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rjw@rjwysocki.net,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/2] thermal/debugfs: Add thermal cooling device debugfs information
Date: Mon, 18 Dec 2023 18:19:40 +0100
Message-Id: <20231218171942.3048095-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal framework does not have any debug information except a
sysfs stat which is a bit controversial. This one allocates big chunks
of memory for every cooling devices with a high number of states and
could represent on some systems in production several megabytes of
memory for just a portion of it. As the sysfs is limited to a page
size, the output is not exploitable with large data array and gets
truncated.

The patch provides the same information than sysfs except the
transitions are dynamically allocated, thus they won't show more
events than the ones which actually occurred. There is no longer a
size limitation and it opens the field for more debugging information
where the debugfs is designed for, not sysfs.

The thermal debugfs directory structure tries to stay consistent with
the sysfs one but in a very simplified way:

thermal/
 -- cooling_devices
    |-- 0
    |   |-- clear
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 1
    |   |-- clear
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 2
    |   |-- clear
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 3
    |   |-- clear
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    `-- 4
        |-- clear
        |-- time_in_state_ms
        |-- total_trans
        `-- trans_table

The content of the files in the cooling devices directory is the same
as the sysfs one except for the trans_table which has the following
format:

Transition	Hits
1->0      	246
0->1      	246
2->1      	632
1->2      	632
3->2      	98
2->3      	98

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changelog:
  - v2
    - Added parameter names to fix kbuild report
    - Renamed 'reset' to 'clear' to avoid confusion (Rafael)
    - Fixed several typos and rephrased some sentences (Rafael)
    - Renamed structure field name s/list/node/ (Rafael)
    - Documented structures and exported functions (Rafael)
    - s/trans_list/transitions/ (Rafael)
    - s/duration_list/durations/ (Rafael)
    - Folded 'alloc' and 'insert' into a single function (Rafael)
    - s/list/lists/ as it is an array of lists (Rafael)
    - s/pos/entry/ (Rafael)
    - Introduced a locking in the 'clear' callback function (Rafael)
    - s/to/new_state/ and s/from/old_state/ (Rafael)
    - Added some comments in thermal_debug_cdev_transition() (Rafael)
    - Explained why char[11] (Rafael)
    - s/Hits/Occurrences/ (Rafael)
    - s/Time/Residency/ (Rafael)
    - Constified structure pointer passed to thermal_debug_cdev_transition()
    - s/thermal_debug_cdev_transition()/thermal_debug_cdev_state_update()/
  - v1 (from RFC):
    - Fixed typo "occurred"
    - Changed Kconfig option name and description
    - Removed comment in the Makefile
    - Renamed exported function name s/debugfs/debug/
    - Replaced thermal_debug_cdev_[unregister|register] by [add|remove]
---
 drivers/thermal/Kconfig           |   7 +
 drivers/thermal/Makefile          |   2 +
 drivers/thermal/thermal_core.c    |   6 +
 drivers/thermal/thermal_core.h    |   1 +
 drivers/thermal/thermal_debugfs.c | 425 ++++++++++++++++++++++++++++++
 drivers/thermal/thermal_debugfs.h |  14 +
 drivers/thermal/thermal_helpers.c |  27 +-
 include/linux/thermal.h           |   7 +
 8 files changed, 483 insertions(+), 6 deletions(-)
 create mode 100644 drivers/thermal/thermal_debugfs.c
 create mode 100644 drivers/thermal/thermal_debugfs.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c81a00fbca7d..3ff7add3fb7c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -33,6 +33,13 @@ config THERMAL_STATISTICS
 
 	  If in doubt, say N.
 
+config THERMAL_DEBUGFS
+	bool "Thermal subsystem debug support"
+	depends on DEBUG_FS
+	help
+	  Say Y to allow the thermal subsystem to collect diagnostic
+	  information that can be accessed via debugfs.
+
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
 	default 0
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index c934cab309ae..0f65ae86a9c6 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -10,6 +10,8 @@ thermal_sys-y			+= thermal_trip.o thermal_helpers.o
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 
+thermal_sys-$(CONFIG_THERMAL_DEBUGFS)	+= thermal_debugfs.o
+
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 625ba07cbe2f..33332d401b13 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -945,6 +945,8 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_unlock(&thermal_list_lock);
 
+	thermal_debug_cdev_add(cdev);
+	
 	return cdev;
 
 out_cooling_dev:
@@ -1151,6 +1153,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	if (!cdev)
 		return;
 
+	thermal_debug_cdev_remove(cdev);
+
 	mutex_lock(&thermal_list_lock);
 
 	if (!thermal_cooling_device_present(cdev)) {
@@ -1570,6 +1574,8 @@ static int __init thermal_init(void)
 {
 	int result;
 
+	thermal_debug_init();
+
 	result = thermal_netlink_init();
 	if (result)
 		goto error;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7dfe6c8deb8e..4b3452a65a2f 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_netlink.h"
+#include "thermal_debugfs.h"
 
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
new file mode 100644
index 000000000000..6465d84a0905
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * Thermal subsystem debug support
+ */
+#include <linux/debugfs.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/thermal.h>
+
+static struct dentry *d_root;
+static struct dentry *d_cdev;
+
+/*
+ * Length of the string containing the thermal zone id or the cooling
+ * device id, including the ending nul character. We can reasonably
+ * assume there won't be more than 256 thermal zones as the maximum
+ * observed today is around 32.
+ */
+#define IDSLENGTH 4
+
+/*
+ * The cooling device transition list is stored in a hash table where
+ * the size is CDEVSTATS_HASH_SIZE. The majority of cooling devices
+ * have dozen of states but some can have much more, so a hash table
+ * is more adequate in this case, because the cost of browsing the entire
+ * list when storing the transitions may not be negligible.
+ */
+#define CDEVSTATS_HASH_SIZE 16
+
+/**
+ * struct cdev_debugfs - per cooling device statistics structure
+ * A cooling device can have a high number of states. Showing the
+ * transitions on a matrix based representation can be overkill given
+ * most of the transitions won't happen and we end up with a matrix
+ * filled with zero. Instead, we show the transitions which actually
+ * happened.
+ *
+ * Every transition updates the current_state and the timestamp. The
+ * transitions and the durations are stored in lists.
+ *
+ * @total: the number of transitions for this cooling device
+ * @current_state: the current cooling device state
+ * @timestamp: the state change timestamp
+ * @durations: an array of lists containing the residencies of each state
+ * @transitions: an array of lists containing the state transitions
+ */
+struct cdev_debugfs {
+	u32 total;
+	int current_state;
+	ktime_t timestamp;
+	struct list_head transitions[CDEVSTATS_HASH_SIZE];
+	struct list_head durations[CDEVSTATS_HASH_SIZE];
+};
+
+/**
+ * cdev_value - Common structure for cooling device entry
+ *
+ * The following common structure allows to store the information
+ * related to the transitions and to the state residencies. They are
+ * identified with a id which is associated to a value. It is used as
+ * nodes for the "transitions" and "durations" above.
+ *
+ * @node: node to insert the structure in a list
+ * @id: identifier of the value which can be a state or a transition
+ * @value: the id associated value which can be a duration or an occurrence
+ */
+struct cdev_value {
+	struct list_head node;
+	int id;
+	u64 value;
+};
+
+/**
+ * thermal_debugfs - High level structure for a thermal object in
+ * debugfs
+ *
+ * The thermal_debugfs structure is the common structure used by the
+ * cooling device to compute the statistics.
+ *
+ * @d_top: top directory of the thermal object directory
+ * @lock: per object lock to protect the internals
+ *
+ * @cdev: a cooling device debug structure
+ */
+struct thermal_debugfs {
+	struct dentry *d_top;
+	struct mutex lock;
+	union {
+		struct cdev_debugfs cdev;
+	};
+};
+
+void thermal_debug_init(void)
+{
+	d_root = debugfs_create_dir("thermal", NULL);
+	if (!d_root)
+		return;
+
+	d_cdev = debugfs_create_dir("cooling_devices", d_root);
+}
+
+static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
+{
+	struct thermal_debugfs *dfs;
+	char ids[IDSLENGTH];
+
+	dfs = kzalloc(sizeof(*dfs), GFP_KERNEL);
+	if (!dfs)
+		return NULL;
+
+	mutex_init(&dfs->lock);
+	
+	snprintf(ids, IDSLENGTH, "%d", id);
+
+	dfs->d_top = debugfs_create_dir(ids, d);
+	if (!dfs->d_top) {
+		kfree(dfs);
+		return NULL;
+	}
+
+	return dfs;
+}
+
+static void thermal_debugfs_remove_id(struct thermal_debugfs *dfs)
+{
+	if (!dfs)
+		return;
+
+	debugfs_remove(dfs->d_top);
+
+	kfree(dfs);
+}
+
+static struct cdev_value *thermal_debugfs_cdev_value_alloc(struct thermal_debugfs *dfs,
+							   struct list_head *list, int id)
+{
+	struct cdev_value *cdev_value;
+
+	cdev_value = kzalloc(sizeof(*cdev_value), GFP_KERNEL);
+	if (cdev_value) {
+		cdev_value->id = id;
+		INIT_LIST_HEAD(&cdev_value->node);
+		list_add_tail(&cdev_value->node, &list[cdev_value->id % CDEVSTATS_HASH_SIZE]);
+	}
+
+	return cdev_value;
+}
+
+static struct cdev_value *thermal_debugfs_cdev_value_find(struct thermal_debugfs *dfs,
+							  struct list_head *lists, int id)
+{
+	struct cdev_value *entry;
+
+	list_for_each_entry(entry, &lists[id % CDEVSTATS_HASH_SIZE], node)
+		if (entry->id == id)
+			return entry;
+
+	return NULL;
+}
+
+struct cdev_value *thermal_debugfs_cdev_value_get(struct thermal_debugfs *dfs,
+						  struct list_head *list, int id)
+{
+	struct cdev_value *cdev_value;
+
+	cdev_value = thermal_debugfs_cdev_value_find(dfs, list, id);
+	if (cdev_value)
+		return cdev_value;
+
+	return thermal_debugfs_cdev_value_alloc(dfs, list, id);
+}
+
+static void thermal_debugfs_cdev_clear(struct cdev_debugfs *cfs)
+{
+	int i;
+	struct cdev_value *entry, *tmp;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+
+		list_for_each_entry_safe(entry, tmp, &cfs->transitions[i], node) {
+			list_del(&entry->node);
+			kfree(entry);
+		}
+
+		list_for_each_entry_safe(entry, tmp, &cfs->durations[i], node) {
+			list_del(&entry->node);
+			kfree(entry);
+		}
+	}
+
+	cfs->total = 0;
+}
+
+static void *cdev_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct thermal_debugfs *dfs = s->private;
+
+	mutex_lock(&dfs->lock);
+
+	return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
+}
+
+static void *cdev_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
+}
+
+static void cdev_seq_stop(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *dfs = s->private;
+
+	mutex_unlock(&dfs->lock);
+}
+
+static int cdev_tt_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *dfs = s->private;	
+	struct cdev_debugfs *cfs = &dfs->cdev;
+	struct list_head *transitions = cfs->transitions;
+	struct cdev_value *entry;
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "Transition\tOccurences\n");
+
+	list_for_each_entry(entry, &transitions[i], node) {
+		/*
+		 * Assuming maximum cdev states is 1024, the longer
+		 * string for a transition would be "1024->1024\0"
+		 */
+		char buffer[11];
+		
+		snprintf(buffer, ARRAY_SIZE(buffer), "%d->%d",
+			 entry->id >> 16, entry->id & 0xFFFF);
+
+		seq_printf(s, "%-10s\t%-10llu\n", buffer, entry->value);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations tt_sops = {
+	.start = cdev_seq_start,
+	.next = cdev_seq_next,
+	.stop = cdev_seq_stop,
+	.show = cdev_tt_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(tt);
+
+static int cdev_dt_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *dfs = s->private;
+	struct cdev_debugfs *cfs = &dfs->cdev;
+	struct list_head *durations = cfs->durations;
+	struct cdev_value *entry;
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "State\tResidency\n");
+
+	list_for_each_entry(entry, &durations[i], node) {
+		s64 duration = entry->value;
+
+		if (entry->id == cfs->current_state)
+			duration += ktime_ms_delta(ktime_get(), cfs->timestamp);
+
+		seq_printf(s, "%-5d\t%-10llu\n", entry->id, duration);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations dt_sops = {
+	.start = cdev_seq_start,
+	.next = cdev_seq_next,
+	.stop = cdev_seq_stop,
+	.show = cdev_dt_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(dt);
+
+static int cdev_clear_set(void *data, u64 val)
+{
+	struct thermal_debugfs *dfs = data;
+
+	if (!val)
+		return -EINVAL;
+
+	mutex_lock(&dfs->lock);
+	
+	thermal_debugfs_cdev_clear(&dfs->cdev);
+
+	mutex_unlock(&dfs->lock);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cdev_clear_fops, NULL, cdev_clear_set, "%llu\n");
+
+/**
+ * thermal_debug_cdev_state_update - Update a cooling device state change
+ *
+ * Computes a transition and the duration of the previous state residency.
+ *
+ * @cdev : a pointer to a cooling device
+ * @new_state: an integer corresponding to the new cooling device state
+ */
+void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
+				     int new_state)
+{
+	struct thermal_debugfs *dfs = cdev->debugfs;
+	struct cdev_debugfs *cfs;
+	struct cdev_value *cdev_value;
+	ktime_t now = ktime_get();
+	int transition, old_state;
+
+	if (!dfs || (dfs->cdev.current_state == new_state))
+		return;
+
+	mutex_lock(&dfs->lock);
+
+	cfs = &dfs->cdev;
+
+	old_state = cfs->current_state;
+	cfs->current_state = new_state;
+	transition = (old_state << 16) | new_state;
+
+	/*
+	 * Get the old state information in the durations list. If
+	 * this one does not exist, a new allocated one will be
+	 * returned. Recompute the total duration in the old state and
+	 * get a new timestamp for the new state.
+	 */
+	cdev_value = thermal_debugfs_cdev_value_get(dfs, cfs->durations, old_state);
+	if (cdev_value) {
+		cdev_value->value += ktime_ms_delta(now, cfs->timestamp);
+		cfs->timestamp = now;
+	}
+
+	/*
+	 * Get the transition in the transitions list. If this one
+	 * does not exist, a new allocated one will be returned.
+	 * Increment the occurrence of this transition which is stored
+	 * in the value field.
+	 */
+	cdev_value = thermal_debugfs_cdev_value_get(dfs, cfs->transitions,
+						    transition);
+	if (cdev_value)
+		cdev_value->value++;
+
+	cfs->total++;
+
+	mutex_unlock(&dfs->lock);
+}
+
+/**
+ * thermal_debug_cdev_add - Add a cooling device debugfs entry
+ *
+ * Allocates a cooling device object for debug, initializes the
+ * statistics and create the entries in sysfs.
+
+ * @cdev: a pointer to a cooling device
+ */
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *dfs;
+	struct cdev_debugfs *cfs;
+	int i;
+
+	dfs = thermal_debugfs_add_id(d_cdev, cdev->id);
+	if (!dfs)
+		return;
+
+	cfs = &dfs->cdev;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&cfs->transitions[i]);
+		INIT_LIST_HEAD(&cfs->durations[i]);
+	}
+
+	cfs->current_state = 0;
+	cfs->timestamp = ktime_get();
+
+	debugfs_create_file("trans_table", 0400, dfs->d_top, dfs, &tt_fops);
+
+	debugfs_create_file("time_in_state_ms", 0400, dfs->d_top, dfs, &dt_fops);
+
+	debugfs_create_file("clear", 0200, dfs->d_top, dfs, &cdev_clear_fops);
+
+	debugfs_create_u32("total_trans", 0400, dfs->d_top, &cfs->total);
+
+	cdev->debugfs = dfs;
+}
+
+/**
+ * thermal_debug_cdev_remove - Remove a cooling device debugfs entry
+ *
+ * Frees the statistics memory data and remove the debugfs entry
+ *
+ * @cdev: a pointer to a cooling device
+ */
+void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *dfs = cdev->debugfs;
+
+	if (!dfs)
+		return;
+
+	mutex_lock(&dfs->lock);
+	
+	thermal_debugfs_cdev_clear(&dfs->cdev);
+	cdev->debugfs = NULL;
+	thermal_debugfs_remove_id(dfs);
+
+	mutex_unlock(&dfs->lock);
+}
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
new file mode 100644
index 000000000000..341499388448
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_THERMAL_DEBUGFS
+void thermal_debug_init(void);
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
+#else
+static inline void thermal_debug_init(void) {}
+static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
+						   int state) {}
+#endif /* CONFIG_THERMAL_DEBUGFS */
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 69e8ea4aa908..435c123b721b 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -151,14 +151,29 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
-static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
-				       int target)
+void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
 {
-	if (cdev->ops->set_cur_state(cdev, target))
-		return;
+	*delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		*delay_jiffies = round_jiffies(*delay_jiffies);
+}
+
+static int thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int state)
+{
+	int ret;
 
-	thermal_notify_cdev_state_update(cdev->id, target);
-	thermal_cooling_device_stats_update(cdev, target);
+	/*
+	 * No check is needed for the ops->set_cur_state as the
+	 * registering function checked the ops are correctly set
+	 */
+	ret = cdev->ops->set_cur_state(cdev, state);
+	if (!ret) {
+		thermal_notify_cdev_state_update(cdev->id, state);
+		thermal_cooling_device_stats_update(cdev, state);
+		thermal_debug_cdev_state_update(cdev, state);
+	}
+
+	return ret;
 }
 
 void __thermal_cdev_update(struct thermal_cooling_device *cdev)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0ea99f50d57c..8461f008c3de 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -32,6 +32,7 @@
 struct thermal_zone_device;
 struct thermal_cooling_device;
 struct thermal_instance;
+struct thermal_debugfs;
 struct thermal_attr;
 
 enum thermal_trend {
@@ -110,6 +111,9 @@ struct thermal_cooling_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
 };
 
 /**
@@ -183,6 +187,9 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
 };
 
 /**
-- 
2.34.1


