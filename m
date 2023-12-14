Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5440812FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572996AbjLNMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572978AbjLNMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:25:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95392BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:25:27 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50c222a022dso8860709e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702556726; x=1703161526; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj6YVUPTH/2Q1f0gUHdUambTFOQaLSKPqyz6G+vAYTU=;
        b=I39u0/82GolLKeg/F4X5SzfE0ZpW+J5ZUPOSz/wQ8U2UwyCLYP/IlGDgqZuTMgPeEt
         P3s4J6gVnrY581iuqyMjGgV0mrusEN4LF9UP4QHd9XvMmtirFY2xkcfDYLTixVCI2Kcc
         X5g0r9/lK8zoMsIsLF0lmqJcJYoStqziSTCS5tIBH2gm2cbFhoKS1RDKi3yS9X9QkFim
         zv/lEfN4ddiILiq4/+1OS17CQz4dgFbnuYjz0IhmY9jON6yYt3V7jKMTojseSaPJDpiD
         C18zE/fmWf9nvPGEYZL6u6CBOHVPx1yO/PlV/AbMdHgQ76b/qMkSQNyM7C7RhxBxxVgd
         gZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556726; x=1703161526;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uj6YVUPTH/2Q1f0gUHdUambTFOQaLSKPqyz6G+vAYTU=;
        b=IOSjvhz1eq8Y9T87h7X1YQxZJ7QpGciEbIhtq7XgWKo9JmqwvRL0ufEy2OCEKSlyWQ
         4Sw4QatgNQXybp3Ohh9zVH7yRUJ959myuR3ilYUZOvqgbySs5ydIHBTmN6xfPF/UbWS+
         dBz2vFZ1nwdXkm0wUCVU3oV8p9YBIJhuizRwGCNBc4iGdFJ+jkdpmP30qomfcSkSEzcI
         NzOMsIxsPLJVRFh3pRxxiVDwCD+hbGX99uzs+WzpUUIfeGxW5TFeqkuCqXE/BhFC73Hu
         jokZGwrivZ1UB/zyrQAxNbmuoIQhMflkRseaWKDmHNHwwXV4wJqwAqE8xdzXf8xFa0Kf
         HyDw==
X-Gm-Message-State: AOJu0Yyo+IablGW3nGRotcdybEICdBIKQyZk5NrbsiRjXi3V1ijyZdWZ
        P5J2wkeVs8xlXjtSCxusH+TClw==
X-Google-Smtp-Source: AGHT+IGbfuxv9qy9Tbrq3dni3LQn0gIUuYY1WH3U9fnnT64Vx2dRwvI1I5S+dA9MXANpLnOPfutIAg==
X-Received: by 2002:a05:6512:3f22:b0:50b:f152:f3e7 with SMTP id y34-20020a0565123f2200b0050bf152f3e7mr4928354lfa.71.1702556725531;
        Thu, 14 Dec 2023 04:25:25 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w23-20020ac254b7000000b0050bf5188390sm1850785lfk.167.2023.12.14.04.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:25:25 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 14 Dec 2023 13:25:15 +0100
Subject: [PATCH] Revert "soc: qcom: stats: Add DDR sleep stats"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-undo_ddr_stats-v1-1-1fe32c258e56@linaro.org>
X-B4-Tracking: v=1; b=H4sIACr0emUC/x3MTQqAIBBA4avErBPSfqCuEiGSY81GY8YiiO6et
 PwW7z0gyIQCU/UA40VCKRbouoJ1d3FDRb4YTGNabXSncjpoVWf0yXrPVrLLorDFoLt+GE0YoKQ
 HY6D7387L+37j1G5nZgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After recent reports ([1], [2]) of older platforms (particularly 8150 and
7180) breaking after DDR sleep stats introduction, revert the following:

Commit 73380e2573c3 ("soc: qcom: stats: fix 64-bit division")
Commit e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")

The feature itself is rather useful for debugging DRAM power management,
however it looks like the shared RPMh stats data structures differ on
previous SoCs.

Revert its addition for now to un-break booting on these earlier SoCs,
while I try to come up with a better way to enable it conditionally.

[1] https://lore.kernel.org/linux-arm-msm/20231209215601.3543895-2-dmitry.baryshkov@linaro.org/
[2] https://lore.kernel.org/linux-arm-msm/CAD=FV=XX4wLg1NNVL15RK4D4tLvuSzZyUv=k_tS4bSb3=7QJzQ@mail.gmail.com/

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/qcom_stats.c | 187 +-----------------------------------------
 1 file changed, 1 insertion(+), 186 deletions(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 5ec8a754b22b..0216fc24f2ca 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011-2021, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -12,7 +11,6 @@
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 
-#include <linux/soc/qcom/qcom_aoss.h>
 #include <linux/soc/qcom/smem.h>
 #include <clocksource/arm_arch_timer.h>
 
@@ -24,20 +22,8 @@
 #define LAST_ENTERED_AT_OFFSET	0x8
 #define LAST_EXITED_AT_OFFSET	0x10
 #define ACCUMULATED_OFFSET	0x18
-#define DDR_DYNAMIC_OFFSET	0x1c
- #define DDR_OFFSET_MASK	GENMASK(9, 0)
 #define CLIENT_VOTES_OFFSET	0x20
 
-#define ARCH_TIMER_FREQ		19200000
-#define DDR_MAGIC_KEY1		0xA1157A75 /* leetspeak "ALLSTATS" */
-#define DDR_MAX_NUM_ENTRIES	20
-
-#define DDR_VOTE_DRV_MAX	18
-#define DDR_VOTE_DRV_ABSENT	0xdeaddead
-#define DDR_VOTE_DRV_INVALID	0xffffdead
-#define DDR_VOTE_X		GENMASK(27, 14)
-#define DDR_VOTE_Y		GENMASK(13, 0)
-
 struct subsystem_data {
 	const char *name;
 	u32 smem_item;
@@ -62,7 +48,6 @@ struct stats_config {
 	bool appended_stats_avail;
 	bool dynamic_offset;
 	bool subsystem_stats_in_smem;
-	bool ddr_stats;
 };
 
 struct stats_data {
@@ -83,25 +68,6 @@ struct appended_stats {
 	u32 reserved[3];
 };
 
-struct ddr_stats_entry {
-	u32 name;
-	u32 count;
-	u64 dur;
-} __packed;
-
-struct ddr_stats {
-	u32 key;
-	u32 entry_count;
-#define MAX_DDR_STAT_ENTRIES	20
-	struct ddr_stats_entry entry[MAX_DDR_STAT_ENTRIES];
-} __packed;
-
-struct ddr_stats_data {
-	struct device *dev;
-	void __iomem *base;
-	struct qmp *qmp;
-};
-
 static void qcom_print_stats(struct seq_file *s, const struct sleep_stats *stat)
 {
 	u64 accumulated = stat->accumulated;
@@ -152,108 +118,6 @@ static int qcom_soc_sleep_stats_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-#define DDR_NAME_TYPE		GENMASK(15, 8)
- #define DDR_NAME_TYPE_LPM	0
- #define DDR_NAME_TYPE_FREQ	1
-
-#define DDR_NAME_LPM_NAME	GENMASK(7, 0)
-
-#define DDR_NAME_FREQ_MHZ	GENMASK(31, 16)
-#define DDR_NAME_FREQ_CP_IDX	GENMASK(4, 0)
-static void qcom_ddr_stats_print(struct seq_file *s, struct ddr_stats_entry *entry)
-{
-	u32 cp_idx, name;
-	u8 type;
-
-	type = FIELD_GET(DDR_NAME_TYPE, entry->name);
-
-	switch (type) {
-	case DDR_NAME_TYPE_LPM:
-		name = FIELD_GET(DDR_NAME_LPM_NAME, entry->name);
-
-		seq_printf(s, "LPM  | Type 0x%2x\tcount: %u\ttime: %llums\n",
-			   name, entry->count, entry->dur);
-		break;
-	case DDR_NAME_TYPE_FREQ:
-		cp_idx = FIELD_GET(DDR_NAME_FREQ_CP_IDX, entry->name);
-		name = FIELD_GET(DDR_NAME_FREQ_MHZ, entry->name);
-
-		/* Neither 0Mhz nor 0 votes is very interesting */
-		if (!name || !entry->count)
-			return;
-
-		seq_printf(s, "Freq | %dMHz (idx %u)\tcount: %u\ttime: %llums\n",
-			   name, cp_idx, entry->count, entry->dur);
-		break;
-	default:
-		seq_printf(s, "Unknown data chunk (type = 0x%x count = 0x%x dur = 0x%llx)\n",
-			   type, entry->count, entry->dur);
-	}
-}
-
-static int qcom_ddr_stats_show(struct seq_file *s, void *unused)
-{
-	struct ddr_stats_data *ddrd = s->private;
-	struct ddr_stats ddr;
-	struct ddr_stats_entry *entry = ddr.entry;
-	u32 entry_count, stats_size;
-	u32 votes[DDR_VOTE_DRV_MAX];
-	int i, ret;
-
-	/* Request a stats sync, it may take some time to update though.. */
-	ret = qmp_send(ddrd->qmp, "{class: ddr, action: freqsync}");
-	if (ret) {
-		dev_err(ddrd->dev, "failed to send QMP message\n");
-		return ret;
-	}
-
-	entry_count = readl(ddrd->base + offsetof(struct ddr_stats, entry_count));
-	if (entry_count > DDR_MAX_NUM_ENTRIES)
-		return -EINVAL;
-
-	/* We're not guaranteed to have DDR_MAX_NUM_ENTRIES */
-	stats_size = sizeof(ddr);
-	stats_size -= DDR_MAX_NUM_ENTRIES * sizeof(*entry);
-	stats_size += entry_count * sizeof(*entry);
-
-	/* Copy and process the stats */
-	memcpy_fromio(&ddr, ddrd->base, stats_size);
-
-	for (i = 0; i < ddr.entry_count; i++) {
-		/* Convert the period to ms */
-		entry[i].dur = div_u64(entry[i].dur, ARCH_TIMER_FREQ / MSEC_PER_SEC);
-	}
-
-	for (i = 0; i < ddr.entry_count; i++)
-		qcom_ddr_stats_print(s, &entry[i]);
-
-	/* Ask AOSS to dump DDR votes */
-	ret = qmp_send(ddrd->qmp, "{class: ddr, res: drvs_ddr_votes}");
-	if (ret) {
-		dev_err(ddrd->dev, "failed to send QMP message\n");
-		return ret;
-	}
-
-	/* Subsystem votes */
-	memcpy_fromio(votes, ddrd->base + stats_size, sizeof(u32) * DDR_VOTE_DRV_MAX);
-
-	for (i = 0; i < DDR_VOTE_DRV_MAX; i++) {
-		u32 ab, ib;
-
-		if (votes[i] == DDR_VOTE_DRV_ABSENT || votes[i] == DDR_VOTE_DRV_INVALID)
-			ab = ib = votes[i];
-		else {
-			ab = FIELD_GET(DDR_VOTE_X, votes[i]);
-			ib = FIELD_GET(DDR_VOTE_Y, votes[i]);
-		}
-
-		seq_printf(s, "Vote | AB = %5u\tIB = %5u\n", ab, ib);
-	}
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(qcom_ddr_stats);
 DEFINE_SHOW_ATTRIBUTE(qcom_soc_sleep_stats);
 DEFINE_SHOW_ATTRIBUTE(qcom_subsystem_sleep_stats);
 
@@ -316,56 +180,13 @@ static void qcom_create_subsystem_stat_files(struct dentry *root,
 				    &qcom_subsystem_sleep_stats_fops);
 }
 
-static int qcom_create_ddr_stats_files(struct device *dev,
-				       struct dentry *root,
-				       void __iomem *reg,
-				       const struct stats_config *config)
-{
-	struct ddr_stats_data *ddrd;
-	u32 key, stats_offset;
-	struct dentry *dent;
-
-	/* Nothing to do */
-	if (!config->ddr_stats)
-		return 0;
-
-	ddrd = devm_kzalloc(dev, sizeof(*ddrd), GFP_KERNEL);
-	if (!ddrd)
-		return dev_err_probe(dev, -ENOMEM, "Couldn't allocate DDR stats data\n");
-
-	ddrd->dev = dev;
-
-	/* Get the offset of DDR stats */
-	stats_offset = readl(reg + DDR_DYNAMIC_OFFSET) & DDR_OFFSET_MASK;
-	ddrd->base = reg + stats_offset;
-
-	/* Check if DDR stats are present */
-	key = readl(ddrd->base);
-	if (key != DDR_MAGIC_KEY1)
-		return 0;
-
-	dent = debugfs_create_file("ddr_sleep_stats", 0400, root, ddrd, &qcom_ddr_stats_fops);
-	if (IS_ERR(dent))
-		return PTR_ERR(dent);
-
-	/* QMP is only necessary for DDR votes */
-	ddrd->qmp = qmp_get(dev);
-	if (IS_ERR(ddrd->qmp)) {
-		dev_err(dev, "Couldn't get QMP mailbox: %ld. DDR votes won't be available.\n",
-			PTR_ERR(ddrd->qmp));
-		debugfs_remove(dent);
-	}
-
-	return 0;
-}
-
 static int qcom_stats_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
 	struct dentry *root;
 	const struct stats_config *config;
 	struct stats_data *d;
-	int i, ret;
+	int i;
 
 	config = device_get_match_data(&pdev->dev);
 	if (!config)
@@ -387,11 +208,6 @@ static int qcom_stats_probe(struct platform_device *pdev)
 
 	qcom_create_subsystem_stat_files(root, config);
 	qcom_create_soc_sleep_stat_files(root, reg, d, config);
-	ret = qcom_create_ddr_stats_files(&pdev->dev, root, reg, config);
-	if (ret) {
-		debugfs_remove_recursive(root);
-		return ret;
-	};
 
 	platform_set_drvdata(pdev, root);
 
@@ -438,7 +254,6 @@ static const struct stats_config rpmh_data = {
 	.appended_stats_avail = false,
 	.dynamic_offset = false,
 	.subsystem_stats_in_smem = true,
-	.ddr_stats = true,
 };
 
 static const struct of_device_id qcom_stats_table[] = {

---
base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
change-id: 20231214-topic-undo_ddr_stats-e3ef145692f6

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

