Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0312A759DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGSSmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGSSmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:42:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4021FC8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:42:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso72678485e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689792127; x=1692384127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKnRhR7SITJIXe1vnVFks13dyzhvxpmyGiR6BjT9xJM=;
        b=NmNkf+DRDYzm5b1OTfm96Wl1eiAht1ady4xiYxiNSgU8CB9ZR+xngnXbhZqVatugDU
         8I0BWNcR8fyfxW+Z2izS/RO1kXH/RkhTSjO0NH9jUXMTVrMF3voUFAUNoGra/unRKffF
         PUOtHxztCR4WiWOo3nCp+sVGwXxvaUFIcrFXPkpY3u2xQd05pOxK0UWUsEumCkIvx/uE
         sRhK0lWG0NdyfzRuEgcrKQpoXzLCC8Zfsw+zwKUPdZCUdwZ/sWlFQUX7YelWfMpTnEdQ
         f56lnd3mGoreGO3ENq0bWUN2yKcoGwSJSwMR3jX0HWayZ/Ib09DXK93mjRiZsXXDyYQW
         WoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792127; x=1692384127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKnRhR7SITJIXe1vnVFks13dyzhvxpmyGiR6BjT9xJM=;
        b=G77E0RzuNwQDVbUhrwQzSHvpi52twiR5DAOYZu8UeihdqL7Rza0NryNRiwYGTKTkrS
         PylqjagFX9syE7C89ecujRvvuYxpInLRZITx8Jp7sGCT3pw5I50UegrND9HWB8nT0Myu
         /fUAs+gyFJ6br3zb7t8LAKJ10vKLWLoukL12QEOFOVmYVxIb+uWxCTDjzcWwqBap2wmG
         msSXf3beuXv1+D7TnWvsX/yeYudk26IwT7T0cbqfFjO+6Zxt5yUP/N1i0cMd8Oa/R0W8
         vnDHgxg11zf/fNouzv4ZpGzYaam8njSxUsLx5jBTrfkkFU+OD4h2lig77F/FfYd/wG3n
         TwSQ==
X-Gm-Message-State: ABy/qLZAyTUp4N5dwWQm9Bh79x5kaRo9OEHHH1J2b+Xjeh/gTYut3Rfl
        XxmsuoHdOLlfMZu5zwvsTR/nzzpuu3VTqFU2S2sDeQnI
X-Google-Smtp-Source: APBJJlF5XQQ83QnSlsJ/G3DODSNDYpBEW7lGEoRF0OGmD0iZLAH2sT5nlf+kshDVz02Czb9io0/XKg==
X-Received: by 2002:a05:6000:10d2:b0:314:350a:6912 with SMTP id b18-20020a05600010d200b00314350a6912mr547850wrx.36.1689792127211;
        Wed, 19 Jul 2023 11:42:07 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b003143be36d99sm5948877wrr.58.2023.07.19.11.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:42:06 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 3/3] hwmon: (peci/dimmtemp) Add Sapphire Rapids support
Date:   Wed, 19 Jul 2023 20:41:54 +0200
Message-ID: <20230719184155.59375-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719184155.59375-1-Naresh.Solanki@9elements.com>
References: <20230719184155.59375-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch extends the functionality of the hwmon (peci/dimmtemp) to
include support for Sapphire Rapids platform.

Sapphire Rapids can accommodate up to 8 CPUs, each with 16 DIMMs. To
accommodate this configuration, the maximum supported DIMM count is
increased, and the corresponding Sapphire Rapids ID and threshold code
are added.

The patch has been tested on a 4S system with 64 DIMMs installed.
Default thresholds are utilized for Sapphire Rapids, as accessing the
threshold requires accessing the UBOX device on Uncore bus 0, which can
only be achieved using MSR access. The non-PCI-compliant MMIO BARs are
not available for this purpose.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in V3:
- Update Acked-by in commit message.
Changes in V2:
- Update subject.
---
 drivers/hwmon/peci/dimmtemp.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index ed968401f93c..edafbfd66fef 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -30,8 +30,10 @@
 #define DIMM_IDX_MAX_ON_ICX	2
 #define CHAN_RANK_MAX_ON_ICXD	4
 #define DIMM_IDX_MAX_ON_ICXD	2
+#define CHAN_RANK_MAX_ON_SPR	128
+#define DIMM_IDX_MAX_ON_SPR	2
 
-#define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_HSX
+#define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_SPR
 #define DIMM_IDX_MAX		DIMM_IDX_MAX_ON_HSX
 #define DIMM_NUMS_MAX		(CHAN_RANK_MAX * DIMM_IDX_MAX)
 
@@ -530,6 +532,15 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 	return 0;
 }
 
+static int
+read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u32 *data)
+{
+	/* Use defaults */
+	*data = (95 << 16) | (90 << 8);
+
+	return 0;
+}
+
 static const struct dimm_info dimm_hsx = {
 	.chan_rank_max	= CHAN_RANK_MAX_ON_HSX,
 	.dimm_idx_max	= DIMM_IDX_MAX_ON_HSX,
@@ -572,6 +583,13 @@ static const struct dimm_info dimm_icxd = {
 	.read_thresholds = &read_thresholds_icx,
 };
 
+static const struct dimm_info dimm_spr = {
+	.chan_rank_max	= CHAN_RANK_MAX_ON_SPR,
+	.dimm_idx_max	= DIMM_IDX_MAX_ON_SPR,
+	.min_peci_revision = 0x40,
+	.read_thresholds = &read_thresholds_spr,
+};
+
 static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
 	{
 		.name = "peci_cpu.dimmtemp.hsx",
@@ -597,6 +615,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
 		.name = "peci_cpu.dimmtemp.icxd",
 		.driver_data = (kernel_ulong_t)&dimm_icxd,
 	},
+	{
+		.name = "peci_cpu.dimmtemp.spr",
+		.driver_data = (kernel_ulong_t)&dimm_spr,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, peci_dimmtemp_ids);
-- 
2.41.0

