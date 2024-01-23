Return-Path: <linux-kernel+bounces-34772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA2838757
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FB91C22C09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE52524C9;
	Tue, 23 Jan 2024 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipek+Zm7"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE751C56;
	Tue, 23 Jan 2024 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991325; cv=none; b=UE66hylhEmKEjoTdxIeAzcOLLoGNXqc7Ni6+ANLWHuZsGHhesbUL9pjJ5FUJmE76/PrESNiAdiej/8FTlSbDewG+XKej0vcBYAGNx/sL+QohLGWC3N3pgRjdGI+ngUYjdDJZxg1JZxkUiDhA1Ue21Omru08vi9lMmwSVO3yQli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991325; c=relaxed/simple;
	bh=II1DtDsd6DfHZs1/X9fjEyOWgFn30tOPs5c/6ptwS7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAC4FSC7xp5cFJrUXWRsKsWBt/YmtZPCncH5/otLTS2UrlcdXYxBFsHX2U/IBtA9NJhrFJKedlmvkcWpkkNOnblK+sCFC9sNULcs26BjKAiNEPvfrpB0uOT+CqGx8YEETmO69I/H191mi5LhKVm9jQudnX924Gmsb0V5fbHaixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipek+Zm7; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5986cb7bb61so2220380eaf.2;
        Mon, 22 Jan 2024 22:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991322; x=1706596122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lagCJlMyFDWm8lQ0VRJpFDVF/Hfo3QFmjobIOJMOJd8=;
        b=ipek+Zm7JVC9am3hZaBi9xk8nJUGlTfYX4dySDmA4XgejamQC7fJjgNwSiIOZeKNeY
         jFB7XoB5IWxejIl238MBsntBoF2UTNhDAVlWaUXiBVBwD/OAm0hIlXHWw+bvw9SJ+b1J
         RUilR9olRyzuHoooi3vDc3RuJmWCTE4Dossn+fXdZXX/ng5WzV1bew7EhQ6y4Q651IyT
         Ao5gkKTk5LG/Zfl7DQjPNHaHDlbxvPDbfPKRNO1J/GPYitpTOrAnksUWXhKxvCdQqJv1
         XmWbx2wzgaPyzak9QH38HwAHbEXwEj5MoGf3s4VLQtp4R7sBncP8m5KuSRS3RhotQZB/
         9njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991322; x=1706596122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lagCJlMyFDWm8lQ0VRJpFDVF/Hfo3QFmjobIOJMOJd8=;
        b=XKukWf+GI6+QT6965qIWvq1Gl67NiXDcZuJP5zxzpuVL+Hua3EGHr+Vb8EWpv+mR9y
         Ne+ms7M059kDKwN5/Q6PihQw7nOjPC3mU6g3837Q4Bh3RHOnqaL6Lfz6dn83/Q+ZxasJ
         9KOynatv0XY8bTmVD3ID8Do8MJC3ng4eX2BJF+smtermhfwU1blKQ8Q5yqCeInwzanar
         B4ndQ+Bi/DW2J39kLMbaiihkgtI6oom1sh24Y7fsxSpbFcIMZH/KkX/Dy6FwdMEfUbza
         oFH2VYNoez8k8+wg0VHrp/4KiANewTI3j1NvyQqbGv7+AvNZflFPJjo3phAreJ7N3U31
         JCEQ==
X-Gm-Message-State: AOJu0YysGdwcRTKMhlKKzRmlei5rvFyjR6nXImFsRzyQdYhV+2kMG5Wn
	4ROPdcx5GNkduWS2FBI9HHK/bfde3fPl+BuKx3CegfD/QkhDLp/Y
X-Google-Smtp-Source: AGHT+IHXfLIVkRfsBSPAei5ubeF+phG+PiQAE5MoKIfl88hKX2R1xwFqnEL6lIV3I+6ZVbo/qO3BAg==
X-Received: by 2002:a05:6358:1804:b0:176:5d73:3778 with SMTP id u4-20020a056358180400b001765d733778mr2084268rwm.36.1705991322303;
        Mon, 22 Jan 2024 22:28:42 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:28:42 -0800 (PST)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V14 02/21] mmc: core: Prepare to support SD UHS-II cards
Date: Tue, 23 Jan 2024 14:28:08 +0800
Message-Id: <20240123062827.8525-3-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ulf Hansson <ulf.hansson@linaro.org>

The SD UHS-II interface was introduced to the SD spec v4.00 several years
ago. The interface is fundamentally different from an electrical and a
protocol point of view, comparing to the legacy SD interface.

However, the legacy SD protocol is supported through a specific transport
layer (SD-TRAN) defined in the UHS-II addendum of the spec. This allows the
SD card to be managed in a very similar way as a legacy SD card, hence a
lot of code can be re-used to support these new types of cards through the
mmc subsystem.

Moreover, an SD card that supports the UHS-II interface shall also be
backwards compatible with the legacy SD interface, which allows a UHS-II
card to be inserted into a legacy slot. As a matter of fact, this is
already supported by mmc subsystem as of today.

To prepare to add support for UHS-II, this change puts the basic foundation
in the mmc core in place, allowing it to be more easily reviewed before
subsequent changes implements the actual support.

Basically, the approach here adds a new UHS-II bus_ops type and adds a
separate initialization path for the UHS-II card. The intent is to avoid us
from sprinkling the legacy initialization path, but also to simplify
implementation of the UHS-II specific bits.

At this point, there is only one new host ops added to manage the various
ios settings needed for UHS-II. Additional host ops that are needed, are
being added from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updates in V10:
 - Drop unnecessary definitions and code.

Updates in V9:
 - move sd_uhs2_operation definition of PatchV8[05/23] to
   PatchV9[02/23] for avoid compilation errors.
 - move uhs2_control definition of PatchV8[05/23] to
   PatchV9[02/23] for avoid compilation errors.
 - move mmc_host flags definition of PatchV8[05/23] to
   PatchV9[02/23] for avoid compilation errors.
 - move mmc_host flags MMC_UHS2_SUPPORT definition of PatchV8[05/23] to
   PatchV9[02/23] for avoid compilation errors.
 - move mmc_host flags MMC_UHS2_SD_TRAN definition of PatchV8[05/23] to
   PatchV9[02/23] for avoid compilation errors.

Updates in V7:
 - Drop sd_uhs2_set_ios function.
 - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_up().
 - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_off().
 - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
 - Modify sd_uhs2_legacy_init to avoid sd_uhs2_reinit cycle issue.

Updates in V4:
 - Re-based, updated a comment and removed white-space.
 - Moved MMC_VQMMC2_VOLTAGE_180 into a later patch in the series.
 
---

 drivers/mmc/core/Makefile  |   2 +-
 drivers/mmc/core/core.c    |  17 ++-
 drivers/mmc/core/core.h    |   1 +
 drivers/mmc/core/sd_uhs2.c | 292 +++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h   |   7 +
 include/linux/mmc/host.h   |  23 +++
 6 files changed, 340 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 6a907736cd7a..15b067e8b0d1 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_MMC)		+= mmc_core.o
 mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
-				   sdio_cis.o sdio_io.o sdio_irq.o \
+				   sdio_cis.o sdio_io.o sdio_irq.o sd_uhs2.o\
 				   slot-gpio.o regulator.o
 mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a8c17b4cd737..2edf31492a5d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2249,6 +2249,18 @@ void mmc_rescan(struct work_struct *work)
 		goto out;
 	}
 
+	/*
+	 * Ideally we should favor initialization of legacy SD cards and defer
+	 * UHS-II enumeration. However, it seems like cards doesn't reliably
+	 * announce their support for UHS-II in the response to the ACMD41,
+	 * while initializing the legacy SD interface. Therefore, let's start
+	 * with UHS-II for now.
+	 */
+	if (!mmc_attach_sd_uhs2(host)) {
+		mmc_release_host(host);
+		goto out;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
 		unsigned int freq = freqs[i];
 		if (freq > host->f_max) {
@@ -2281,10 +2293,13 @@ void mmc_rescan(struct work_struct *work)
 
 void mmc_start_host(struct mmc_host *host)
 {
+	bool power_up = !(host->caps2 &
+			 (MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_SD_UHS2));
+
 	host->f_init = max(min(freqs[0], host->f_max), host->f_min);
 	host->rescan_disable = 0;
 
-	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
+	if (power_up) {
 		mmc_claim_host(host);
 		mmc_power_up(host, host->ocr_avail);
 		mmc_release_host(host);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 37091a6589ed..920323faa834 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -81,6 +81,7 @@ int mmc_detect_card_removed(struct mmc_host *host);
 int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
+int mmc_attach_sd_uhs2(struct mmc_host *host);
 
 /* Module parameters */
 extern bool use_spi_crc;
diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
new file mode 100644
index 000000000000..beb2541338ff
--- /dev/null
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * Support for SD UHS-II cards
+ */
+#include <linux/err.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+
+#include "core.h"
+#include "bus.h"
+#include "sd.h"
+#include "mmc_ops.h"
+
+static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
+
+static int sd_uhs2_power_up(struct mmc_host *host)
+{
+	int err;
+
+	if (host->ios.power_mode == MMC_POWER_ON)
+		return 0;
+
+	host->ios.vdd = fls(host->ocr_avail) - 1;
+	host->ios.clock = host->f_init;
+	host->ios.timing = MMC_TIMING_UHS2_SPEED_A;
+	host->ios.power_mode = MMC_POWER_ON;
+
+	err = host->ops->uhs2_control(host, UHS2_SET_IOS);
+
+	return err;
+}
+
+static int sd_uhs2_power_off(struct mmc_host *host)
+{
+	if (host->ios.power_mode == MMC_POWER_OFF)
+		return 0;
+
+	host->ios.vdd = 0;
+	host->ios.clock = 0;
+	host->ios.timing = MMC_TIMING_LEGACY;
+	host->ios.power_mode = MMC_POWER_OFF;
+
+	return host->ops->uhs2_control(host, UHS2_SET_IOS);
+}
+
+/*
+ * Run the phy initialization sequence, which mainly relies on the UHS-II host
+ * to check that we reach the expected electrical state, between the host and
+ * the card.
+ */
+static int sd_uhs2_phy_init(struct mmc_host *host)
+{
+	return 0;
+}
+
+/*
+ * Do the early initialization of the card, by sending the device init broadcast
+ * command and wait for the process to be completed.
+ */
+static int sd_uhs2_dev_init(struct mmc_host *host)
+{
+	return 0;
+}
+
+/*
+ * Run the enumeration process by sending the enumerate command to the card.
+ * Note that, we currently support only the point to point connection, which
+ * means only one card can be attached per host/slot.
+ */
+static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
+{
+	return 0;
+}
+
+/*
+ * Read the UHS-II configuration registers (CFG_REG) of the card, by sending it
+ * commands and by parsing the responses. Store a copy of the relevant data in
+ * card->uhs2_config.
+ */
+static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
+{
+	return 0;
+}
+
+/*
+ * Based on the card's and host's UHS-II capabilities, let's update the
+ * configuration of the card and the host. This may also include to move to a
+ * greater speed range/mode. Depending on the updated configuration, we may need
+ * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
+ *
+ * In the final step, let's check if the card signals "config completion", which
+ * indicates that the card has moved from config state into active state.
+ */
+static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
+{
+	return 0;
+}
+
+/*
+ * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
+ * commands/requests to be backwards compatible through the legacy SD protocol.
+ * UHS-II cards has a specific power limit specified for VDD1/VDD2, that should
+ * be set through a legacy CMD6. Note that, the power limit that becomes set,
+ * survives a soft reset through the GO_DORMANT_STATE command.
+ */
+static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
+{
+	return 0;
+}
+
+/*
+ * Allocate the data structure for the mmc_card and run the UHS-II specific
+ * initialization sequence.
+ */
+static int sd_uhs2_init_card(struct mmc_host *host)
+{
+	struct mmc_card *card;
+	u32 node_id;
+	int err;
+
+	err = sd_uhs2_dev_init(host);
+	if (err)
+		return err;
+
+	err = sd_uhs2_enum(host, &node_id);
+	if (err)
+		return err;
+
+	card = mmc_alloc_card(host, &sd_type);
+	if (IS_ERR(card))
+		return PTR_ERR(card);
+
+	card->uhs2_config.node_id = node_id;
+	card->type = MMC_TYPE_SD;
+
+	err = sd_uhs2_config_read(host, card);
+	if (err)
+		goto err;
+
+	err = sd_uhs2_config_write(host, card);
+	if (err)
+		goto err;
+
+	host->card = card;
+	return 0;
+
+err:
+	mmc_remove_card(card);
+	return err;
+}
+
+static void sd_uhs2_remove(struct mmc_host *host)
+{
+	mmc_remove_card(host->card);
+	host->card = NULL;
+}
+
+static int sd_uhs2_alive(struct mmc_host *host)
+{
+	return mmc_send_status(host->card, NULL);
+}
+
+static void sd_uhs2_detect(struct mmc_host *host)
+{
+	int err;
+
+	mmc_get_card(host->card, NULL);
+	err = _mmc_detect_card_removed(host);
+	mmc_put_card(host->card, NULL);
+
+	if (err) {
+		sd_uhs2_remove(host);
+
+		mmc_claim_host(host);
+		mmc_detach_bus(host);
+		sd_uhs2_power_off(host);
+		mmc_release_host(host);
+	}
+}
+
+static int sd_uhs2_suspend(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_resume(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_runtime_suspend(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_runtime_resume(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_shutdown(struct mmc_host *host)
+{
+	return 0;
+}
+
+static int sd_uhs2_hw_reset(struct mmc_host *host)
+{
+	return 0;
+}
+
+static const struct mmc_bus_ops sd_uhs2_ops = {
+	.remove = sd_uhs2_remove,
+	.alive = sd_uhs2_alive,
+	.detect = sd_uhs2_detect,
+	.suspend = sd_uhs2_suspend,
+	.resume = sd_uhs2_resume,
+	.runtime_suspend = sd_uhs2_runtime_suspend,
+	.runtime_resume = sd_uhs2_runtime_resume,
+	.shutdown = sd_uhs2_shutdown,
+	.hw_reset = sd_uhs2_hw_reset,
+};
+
+static int sd_uhs2_attach(struct mmc_host *host)
+{
+	int err;
+
+	err = sd_uhs2_power_up(host);
+	if (err)
+		goto err;
+
+	err = sd_uhs2_phy_init(host);
+	if (err)
+		goto err;
+
+	err = sd_uhs2_init_card(host);
+	if (err)
+		goto err;
+
+	err = sd_uhs2_legacy_init(host, host->card);
+	if (err)
+		goto err;
+
+	mmc_attach_bus(host, &sd_uhs2_ops);
+
+	mmc_release_host(host);
+
+	err = mmc_add_card(host->card);
+	if (err)
+		goto remove_card;
+
+	mmc_claim_host(host);
+	return 0;
+
+remove_card:
+	mmc_remove_card(host->card);
+	host->card = NULL;
+	mmc_claim_host(host);
+	mmc_detach_bus(host);
+err:
+	sd_uhs2_power_off(host);
+	return err;
+}
+
+int mmc_attach_sd_uhs2(struct mmc_host *host)
+{
+	int i, err = 0;
+
+	if (!(host->caps2 & MMC_CAP2_SD_UHS2))
+		return -EOPNOTSUPP;
+
+	/* Turn off the legacy SD interface before trying with UHS-II. */
+	mmc_power_off(host);
+
+	/*
+	 * Start UHS-II initialization at 52MHz and possibly make a retry at
+	 * 26MHz according to the spec. It's required that the host driver
+	 * validates ios->clock, to set a rate within the correct range.
+	 */
+	for (i = 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
+		host->f_init = sd_uhs2_freqs[i];
+		err = sd_uhs2_attach(host);
+		if (!err)
+			break;
+	}
+
+	return err;
+}
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f34407cc2788..e256b1e70c6e 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -209,6 +209,11 @@ struct sd_ext_reg {
 #define SD_EXT_PERF_CMD_QUEUE	(1<<4)
 };
 
+struct sd_uhs2_config {
+	u32			node_id;
+	/* TODO: Extend with more register configs. */
+};
+
 struct sdio_cccr {
 	unsigned int		sdio_vsn;
 	unsigned int		sd_vsn;
@@ -319,6 +324,8 @@ struct mmc_card {
 	struct sd_ext_reg	ext_power;	/* SD extension reg for PM */
 	struct sd_ext_reg	ext_perf;	/* SD extension reg for PERF */
 
+	struct sd_uhs2_config	uhs2_config;	/* SD UHS-II config */
+
 	unsigned int		sdio_funcs;	/* number of SDIO functions */
 	atomic_t		sdio_funcs_probed; /* number of probed SDIO funcs */
 	struct sdio_cccr	cccr;		/* common card info */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2f445c651742..9d7c6b575303 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -63,6 +63,10 @@ struct mmc_ios {
 #define MMC_TIMING_MMC_HS400	10
 #define MMC_TIMING_SD_EXP	11
 #define MMC_TIMING_SD_EXP_1_2V	12
+#define MMC_TIMING_UHS2_SPEED_A    13
+#define MMC_TIMING_UHS2_SPEED_A_HD 14
+#define MMC_TIMING_UHS2_SPEED_B    15
+#define MMC_TIMING_UHS2_SPEED_B_HD 16
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -91,6 +95,14 @@ struct mmc_clk_phase_map {
 	struct mmc_clk_phase phase[MMC_NUM_CLK_PHASES];
 };
 
+struct sd_uhs2_caps {
+	/* TODO: Add UHS-II capabilities for the host. */
+};
+
+enum sd_uhs2_operation {
+	UHS2_SET_IOS,
+};
+
 struct mmc_host;
 
 enum mmc_err_stat {
@@ -218,6 +230,14 @@ struct mmc_host_ops {
 
 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+	/*
+	 * The uhs2_control callback is used to execute SD UHS-II specific
+	 * operations. It's mandatory to implement for hosts that supports the
+	 * SD UHS-II interface (MMC_CAP2_SD_UHS2). Expected return values are a
+	 * negative errno in case of a failure or zero for success.
+	 */
+	int	(*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
 };
 
 struct mmc_cqe_ops {
@@ -402,6 +422,7 @@ struct mmc_host {
 				 MMC_CAP2_HS200_1_2V_SDR)
 #define MMC_CAP2_SD_EXP		(1 << 7)	/* SD express via PCIe */
 #define MMC_CAP2_SD_EXP_1_2V	(1 << 8)	/* SD express 1.2V */
+#define MMC_CAP2_SD_UHS2	(1 << 9)	/* SD UHS-II support */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
@@ -428,6 +449,8 @@ struct mmc_host {
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
 
+	struct sd_uhs2_caps	uhs2_caps;	/* Host UHS-II capabilities */
+
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
-- 
2.25.1


