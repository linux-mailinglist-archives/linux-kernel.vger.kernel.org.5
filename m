Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD617FB2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbjK1Het (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjK1Hep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:34:45 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E90D5A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:49 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cd8c3a9edaso1782164b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701156889; x=1701761689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8tC1vo962immBLHWFedYDSlvhqp+GdE0dvr3eRBBUwo=;
        b=ES4q3UevYiYeKtZA5iYXPjHUzePk45sQp0QCna3dZovBoNBi+W2MKtLvFRjSfuHy96
         yjvtbbBDoCdLdKquKeHfd62GQbP6mftmgnm7Q6pPTPPa49GmU3/jTYDJhuqWWoeTxo1R
         bI7HE/sFtxLZtZtwHveJR/6HENkOJzeWqmTpzMufQtDwJ7bZ4MZywB1kiiGtJILhlYLj
         gCep35R6KKqz0ccVSe1Fbf+onH6Uko+O29OqZCeCZfzjniB6BwqT0C4L0/SWP/2ivcJW
         u9LmUsUhM9QIA2TluiI/5F3bVaOwsCHNTFAtMrOWOH6MP6EXpzy70oJRogrRi9AE2xra
         u/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156889; x=1701761689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tC1vo962immBLHWFedYDSlvhqp+GdE0dvr3eRBBUwo=;
        b=D0myEWqFQgYbmifloo0mS7FG5EKxOiF5IcwSHd8CBbNsffmV1H4HdoNs9zXPgGUDPH
         tYW2aRqkqp0tGyWYA3wAXLMhZhHPTNl/LvfJcsK+r1HXOdohDSSqhxrVqtNfJP7eaIQZ
         MK2MB/jyYh3bCeDhXFVIwdi1opdYNxoH4tA2IYHqE8ZFDHs4tpKSHOenyPGUeiY7gW5w
         XXiHfUU1dfeXiVLV0NthfwIYWg1hJNGiVXp3D1FylGyOIBqpPw1jbSqJOi/kWggax+O8
         lqQ+VN2gzUoHWGZbUs0JT/XQDB1ss/+Ab8dXl0bORN0MxY4o5CPGPkR6/obeh+IKe18K
         ur4g==
X-Gm-Message-State: AOJu0Yy9q5nydXX8zQwF2CpqXJ1FOQV4Fwrnz9EUoSoSQd8EgPrYDJaK
        ajfpQUY1PlMDaK8f+1fSarU=
X-Google-Smtp-Source: AGHT+IEwSoEUaKAMjeNT/B4UJ5bMwZdWDAfLciF7L1mX1p1kKd8ibEh0049/OWwsh4tfQl6RWFuIfQ==
X-Received: by 2002:a05:6a00:21d2:b0:68e:3772:4e40 with SMTP id t18-20020a056a0021d200b0068e37724e40mr14373197pfj.3.1701156888736;
        Mon, 27 Nov 2023 23:34:48 -0800 (PST)
Received: from cuiyangpei.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cb4fa1174dsm8331333pfn.124.2023.11.27.23.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:34:48 -0800 (PST)
From:   cuiyangpei <cuiyangpei@gmail.com>
X-Google-Original-From: cuiyangpei <cuiyangpei@xiaomi.com>
To:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     cuiyangpei <cuiyangpei@xiaomi.com>
Subject: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date:   Tue, 28 Nov 2023 15:34:39 +0800
Message-ID: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user space users can control DAMON and get the monitoring results
via implements 'recording' feature in 'damon-sysfs'.  The feature
can be used via 'record' and 'state' file in the '<sysfs>/kernel/mm/
damon/admin/kdamonds/N/' directory.

The file allows users to record monitored access patterns in a text
file. Firstly, users set the size of the buffer and the path of the
result file by writing to the ``record`` file. Then the recorded
results are first written in an in-memory buffer and flushed the
recorded results to a file in batch by writing 'record' to the
``state`` file.

For example, below commands set the buffer to be 4 KiB and the result
to be saved in ``/damon.txt``. ::

    # cd <sysfs>/kernel/mm/damon/admin/kdamonds/N
    # echo "4096 /damon.txt" > record
    # echo "record" > state

Signed-off-by: cuiyangpei <cuiyangpei@xiaomi.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         |  20 +-
 include/linux/damon.h                         |  11 +
 mm/damon/sysfs.c                              | 282 ++++++++++++++++++
 3 files changed, 307 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b35649a46a2f..819534dcfb6c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -25,15 +25,23 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		stops, respectively.  Reading the file returns the keywords
 		based on the current status.  Writing 'commit' to this file
 		makes the kdamond reads the user inputs in the sysfs files
-		except 'state' again.  Writing 'update_schemes_stats' to the
-		file updates contents of schemes stats files of the kdamond.
-		Writing 'update_schemes_tried_regions' to the file updates
-		contents of 'tried_regions' directory of every scheme directory
-		of this kdamond.  Writing 'update_schemes_tried_bytes' to the
-		file updates only '.../tried_regions/total_bytes' files of this
+		except 'state' again.  Writing 'record' to this file makes the
+		kdamond saves the monitoring results to file specified by the
+		/record file. Writing 'update_schemes_stats'to the file updates
+		contents of schemes stats files of the kdamond. Writing
+		'update_schemes_tried_regions' to the file updates contents of
+		'tried_regions' directory of every scheme directory of this
+		kdamond.  Writing 'update_schemes_tried_bytes' to the file
+		updates only '.../tried_regions/total_bytes' files of this
 		kdamond.  Writing 'clear_schemes_tried_regions' to the file
 		removes contents of the 'tried_regions' directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/record
+Date:		Nov 2023
+Contact:	Ping Xiong <xiongping1@xiaomi.com>
+Description:	Writing a string '4096 /damon.txt' to this file makes the
+		user to record monitored access patterns in a text file.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
diff --git a/include/linux/damon.h b/include/linux/damon.h
index ab2f17d9926b..6495513cc6de 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -19,6 +19,17 @@
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
+#define MIN_RECORD_BUFFER_LEN	1024
+#define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
+#define MAX_RFILE_PATH_LEN	256
+
+struct sysfs_recorder {
+	unsigned char *rbuf;
+	unsigned int rbuf_len;
+	unsigned int rbuf_offset;
+	char *rfile_path;
+};
+
 /* Get a random number in [l, r) */
 static inline unsigned long damon_rand(unsigned long l, unsigned long r)
 {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e27846708b5a..7a7d41e609e3 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -994,6 +994,8 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_OFF,
 	/* @DAMON_SYSFS_CMD_COMMIT: Update kdamond inputs. */
 	DAMON_SYSFS_CMD_COMMIT,
+	/* @DAMON_SYSFS_CMD_RECORD: Save the monitoring results to file. */
+	DAMON_SYSFS_CMD_RECORD,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
 	 * files.
@@ -1025,6 +1027,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"on",
 	"off",
 	"commit",
+	"record",
 	"update_schemes_stats",
 	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
@@ -1349,6 +1352,160 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 			kdamond->contexts->contexts_arr[0]);
 }
 
+/*
+ * Flush the content in the result buffer to the result file
+ */
+static int sysfs_flush_rbuffer(struct sysfs_recorder *rec)
+{
+	ssize_t sz;
+	loff_t pos = 0;
+	struct file *rfile;
+
+	if (!rec->rbuf_offset)
+		return 0;
+
+	rfile = filp_open(rec->rfile_path,
+			O_CREAT | O_RDWR | O_APPEND | O_LARGEFILE, 0644);
+	if (IS_ERR(rfile)) {
+		pr_err("Cannot open the result file %s\n",
+				rec->rfile_path);
+		return PTR_ERR(rfile);
+	}
+
+	while (rec->rbuf_offset) {
+		sz = kernel_write(rfile, rec->rbuf, rec->rbuf_offset, &pos);
+		if (sz < 0) {
+			filp_close(rfile, NULL);
+			return sz;
+		}
+		rec->rbuf_offset -= sz;
+	}
+	filp_close(rfile, NULL);
+
+	return 0;
+}
+
+/*
+ * Write a data into the result buffer
+ */
+static void sysfs_write_rbuf(struct damon_ctx *ctx, char *data, int size)
+{
+	struct sysfs_recorder *rec = ctx->callback.private;
+
+	if (!rec->rbuf_len || !rec->rbuf || !rec->rfile_path)
+		return;
+	if (rec->rbuf_offset + size > rec->rbuf_len)
+		sysfs_flush_rbuffer(ctx->callback.private);
+	if (rec->rbuf_offset + size > rec->rbuf_len) {
+		pr_warn("%s: flush failed, or wrong size given(%u, %d)\n",
+				__func__, rec->rbuf_offset, size);
+		return;
+	}
+
+	memcpy(&rec->rbuf[rec->rbuf_offset], data, size);
+	rec->rbuf_offset += size;
+}
+
+static unsigned int nr_damon_targets(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	unsigned int nr_targets = 0;
+	int count = 0;
+
+	damon_for_each_target(t, ctx) {
+		count++;
+		nr_targets++;
+	}
+
+	return nr_targets;
+}
+
+/*
+ * Store the aggregated monitoring results to the result buffer
+ *
+ * The format for the result buffer is as below:
+ *
+ *   <time> <number of targets>
+ *
+ *   target info: <pid> <number of regions>
+ *   region info: <start address> <region size> <nr_accesses>
+ */
+static int damon_flush_aggregation(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct timespec64 now;
+	struct task_struct *tsk;
+	int tsk_pid = -1;
+	unsigned int nr = 0;
+	char buf[128];
+	int rc = 0;
+
+	memset(buf, 0, sizeof(buf));
+	ktime_get_coarse_ts64(&now);
+	nr = nr_damon_targets(c);
+	rc = scnprintf(buf, sizeof(buf), "time: %lld.%09ld, nr: %u\n",
+			(long long)now.tv_sec, now.tv_nsec, nr);
+	if (!rc)
+		return -ENOMEM;
+
+	sysfs_write_rbuf(c, buf, rc);
+	memset(buf, 0, sizeof(buf));
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+
+		tsk = get_pid_task(t->pid, PIDTYPE_PID);
+		tsk_pid = tsk->pid;
+		nr = damon_nr_regions(t);
+		rc = scnprintf(buf, sizeof(buf), "pid: %d, nr: %u\n", tsk_pid, nr);
+		if (!rc)
+			return -ENOMEM;
+
+		sysfs_write_rbuf(c, buf, rc);
+		memset(buf, 0, sizeof(buf));
+
+		damon_for_each_region(r, t) {
+
+			rc = scnprintf(buf, sizeof(buf), "%lu, %lu, %d\n",
+					r->ar.start, r->ar.end - r->ar.start, r->nr_accesses);
+			if (!rc)
+				return -ENOMEM;
+
+			sysfs_write_rbuf(c, buf, rc);
+			memset(buf, 0, sizeof(buf));
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * damon_sysfs_record() - Save the monitoring results to file.
+ * @kdamond:	The kobject wrapper for the associated kdamond.
+ *
+ * If the sysfs input is wrong, the kdamond will be terminated.
+ */
+static int damon_sysfs_record(struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+	struct sysfs_recorder *rec = ctx->callback.private;
+	int err = 0;
+
+	if (!damon_sysfs_kdamond_running(kdamond))
+		return -EINVAL;
+	/* TODO: Support multiple contexts per kdamond */
+	if (kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	err = damon_flush_aggregation(ctx);
+	if (!err) {
+		if (rec->rbuf_offset)
+			err = sysfs_flush_rbuffer(rec);
+	}
+
+	return err;
+}
+
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
  * @c:		The DAMON context of the callback.
@@ -1371,6 +1528,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 	if (!kdamond || kdamond->damon_ctx != c)
 		goto out;
 	switch (damon_sysfs_cmd_request.cmd) {
+	case DAMON_SYSFS_CMD_RECORD:
+		err = damon_sysfs_record(kdamond);
+		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
 		err = damon_sysfs_upd_schemes_stats(kdamond);
 		break;
@@ -1433,6 +1593,65 @@ static int damon_sysfs_after_aggregation(struct damon_ctx *c)
 	return damon_sysfs_cmd_request_callback(c, true);
 }
 
+/*
+ * sysfs_set_recording() - Set attributes for the recording.
+ * @ctx:	target kdamond context
+ * @rbuf_len:	length of the result buffer
+ * @rfile_path:	path to the monitor result files
+ *
+ * Setting 'rbuf_len' 0 disables recording.
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int sysfs_set_recording(struct damon_ctx *ctx,
+			unsigned int rbuf_len, char *rfile_path)
+{
+	struct sysfs_recorder *recorder;
+	size_t rfile_path_len;
+
+	if (rbuf_len && (rbuf_len > MAX_RECORD_BUFFER_LEN ||
+			rbuf_len < MIN_RECORD_BUFFER_LEN)) {
+		pr_err("result buffer size (%u) is out of [%d,%d]\n",
+				rbuf_len, MIN_RECORD_BUFFER_LEN,
+				MAX_RECORD_BUFFER_LEN);
+		return -EINVAL;
+	}
+	rfile_path_len = strnlen(rfile_path, MAX_RFILE_PATH_LEN);
+	if (rfile_path_len >= MAX_RFILE_PATH_LEN) {
+		pr_err("too long (>%d) result file path %s\n",
+				MAX_RFILE_PATH_LEN, rfile_path);
+		return -EINVAL;
+	}
+
+	recorder = ctx->callback.private;
+	if (!recorder) {
+		recorder = kzalloc(sizeof(*recorder), GFP_KERNEL);
+		if (!recorder)
+			return -ENOMEM;
+		ctx->callback.private = recorder;
+	}
+
+	recorder->rbuf_len = rbuf_len;
+	kfree(recorder->rbuf);
+	recorder->rbuf = NULL;
+	kfree(recorder->rfile_path);
+	recorder->rfile_path = NULL;
+
+	if (rbuf_len) {
+		recorder->rbuf = kvmalloc(rbuf_len, GFP_KERNEL);
+		if (!recorder->rbuf)
+			return -ENOMEM;
+	}
+	recorder->rfile_path = kmalloc(rfile_path_len + 1, GFP_KERNEL);
+	if (!recorder->rfile_path)
+		return -ENOMEM;
+	strscpy(recorder->rfile_path, rfile_path, rfile_path_len + 1);
+
+	return 0;
+}
+
 static struct damon_ctx *damon_sysfs_build_ctx(
 		struct damon_sysfs_context *sys_ctx)
 {
@@ -1442,6 +1661,12 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
+	err = sysfs_set_recording(ctx, 0, "none");
+	if (err) {
+		damon_destroy_ctx(ctx);
+		return ERR_PTR(err);
+	}
+
 	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
 	if (err) {
 		damon_destroy_ctx(ctx);
@@ -1599,6 +1824,59 @@ static ssize_t pid_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", pid);
 }
 
+static ssize_t record_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx;
+	struct sysfs_recorder *rec;
+	int len = 0;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	ctx = kdamond->damon_ctx;
+	if (!ctx)
+		goto out;
+	rec = ctx->callback.private;
+	len = sysfs_emit(buf, "%u %s\n", rec->rbuf_len, rec->rfile_path);
+
+out:
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
+}
+
+static ssize_t record_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	struct damon_ctx *ctx;
+	unsigned int rbuf_len;
+	char rfile_path[MAX_RFILE_PATH_LEN];
+	ssize_t ret = count;
+	int err;
+
+	if (sscanf(buf, "%10u %128s", &rbuf_len, rfile_path) != 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	ctx = kdamond->damon_ctx;
+	if (!ctx)
+		goto unlock_out;
+
+	err = sysfs_set_recording(ctx, rbuf_len, rfile_path);
+	if (err)
+		ret = err;
+unlock_out:
+	mutex_unlock(&damon_sysfs_lock);
+out:
+	return ret;
+}
+
 static void damon_sysfs_kdamond_release(struct kobject *kobj)
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
@@ -1615,9 +1893,13 @@ static struct kobj_attribute damon_sysfs_kdamond_state_attr =
 static struct kobj_attribute damon_sysfs_kdamond_pid_attr =
 		__ATTR_RO_MODE(pid, 0400);
 
+static struct kobj_attribute damon_sysfs_kdamond_record_attr =
+		__ATTR_RW_MODE(record, 0600);
+
 static struct attribute *damon_sysfs_kdamond_attrs[] = {
 	&damon_sysfs_kdamond_state_attr.attr,
 	&damon_sysfs_kdamond_pid_attr.attr,
+	&damon_sysfs_kdamond_record_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_kdamond);
-- 
2.43.0

