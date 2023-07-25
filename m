Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B350A761120
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjGYKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjGYKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:44:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAFC10D4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:44:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31297125334so3449474f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690281840; x=1690886640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT1M70QmPWlyzzTGWLB186I5SL8oEeXWy/zvh7U5jHs=;
        b=L87nMl2y4zHHvKG2Q/04w0rgX8wiQVuIlX1wAVjnD/6D7rHkMbT3w1U1NhRm5guLUa
         BQuKqSr1f0PicazKlUci5tzrYQ7sPCFfkFqLnN8WYgNsXvS3HX3z7hqCC1EbLpux3n8C
         SuhXu1hSpzKVP91FpSg7VMB14+my8uIISA9x6jrB4rX3+/7NJDp9+vVVIjPVgAi0Pbvb
         RNARHoLnAoc6Y5n1Y6aeAcjqKwunWAcduAvrFsOYc9APD3Kdm5/kypIUBRdJovFo3RBi
         89cM0f2k+yJisuaiAu/tw4s/d0oLwqHACUh/E/cZgCgXlJbp9qK42EoueWccBZiS5FIh
         FpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690281840; x=1690886640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT1M70QmPWlyzzTGWLB186I5SL8oEeXWy/zvh7U5jHs=;
        b=IjUYM3xXISqp6EKiJQPzQmPAgD2BFbFMCW+mfSaGufcXT3bmCKsh2o8pEXzyMHrf17
         IjLCaAUsiqyV2JtdcIxc/SztFO+MU/zMRgtlKNaBDzBGRDIB3DeNcR8+YmtkPcZ9YvcO
         PG31bmBU6Iic/y7tURD6mVUfkYHTH8krVDYHAJFNLkJJzXWkKrPcNsCIhnLIx/Ybtc11
         9A1ttjM0K7/Xd9LWa+w2705zg8XnXPbirvg5tspktMVPnYO0TJ6YIznXyPIpSXvgj7mR
         ZRy2m+7enL2bUabG+9Bqz26bXzSK1QNd9h9uU5vhL1vd7VKBqdwZ1XwlQXtPcPMHWoNu
         7dHw==
X-Gm-Message-State: ABy/qLaFkBrFDBTaXK5bV+GCwt18dhpxkDYu6kVuxw7Wpu/KTAD3JNMC
        DvjxFCN/jZebhfA0tup840oglJWxFIs7ns2nrjLgNBFh
X-Google-Smtp-Source: APBJJlGYrXsJBuwSkiRKpG5r9PXBP687z9chJuTDG3nvnLpp3zgOEBxhHUTkRfNKUDSicbyR6/z5fA==
X-Received: by 2002:a5d:660d:0:b0:317:6734:c2ae with SMTP id n13-20020a5d660d000000b003176734c2aemr1704572wru.11.1690281840081;
        Tue, 25 Jul 2023 03:44:00 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b003143c6e09ccsm15793723wrx.16.2023.07.25.03.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:43:59 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 3/3] hwmon: (peci/dimmtemp) Add Sapphire Rapids support
Date:   Tue, 25 Jul 2023 12:43:53 +0200
Message-ID: <20230725104354.33920-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104354.33920-1-Naresh.Solanki@9elements.com>
References: <20230725104354.33920-1-Naresh.Solanki@9elements.com>
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

Extend the functionality of hwmon (peci/dimmtemp) for Sapphire Rapids
platform.

Add the corresponding Sapphire Rapids ID and threshold code.

The patch has been tested on a 4S system with 64 DIMMs installed.
Verified read of DIMM temperature thresholds & temperature.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in V4:
- Instead of using hard coded dimm temperature threshold, read from mmio
  offset.
- Change CHAN_RANK_MAX_ON_SPR to 8
- Restore #define CHAN_RANK_MAX to previous assignment.
- Update commit message.
Changes in V3:
- Update Acked-by in commit message.
Changes in V2:
- Update subject.
---
 drivers/hwmon/peci/dimmtemp.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index ce89da3937a0..5ca4d04e4b14 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -30,6 +30,8 @@
 #define DIMM_IDX_MAX_ON_ICX	2
 #define CHAN_RANK_MAX_ON_ICXD	4
 #define DIMM_IDX_MAX_ON_ICXD	2
+#define CHAN_RANK_MAX_ON_SPR	8
+#define DIMM_IDX_MAX_ON_SPR	2
 
 #define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_HSX
 #define DIMM_IDX_MAX		DIMM_IDX_MAX_ON_HSX
@@ -534,6 +536,43 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 	return 0;
 }
 
+static int
+read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u32 *data)
+{
+	u32 reg_val;
+	u64 offset;
+	int ret;
+	u8 dev;
+
+	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd4, &reg_val);
+	if (ret || !(reg_val & BIT(31)))
+		return -ENODATA; /* Use default or previous value */
+
+	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd0, &reg_val);
+	if (ret)
+		return -ENODATA; /* Use default or previous value */
+
+	/*
+	 * Device 26, Offset 219a8: IMC 0 channel 0 -> rank 0
+	 * Device 26, Offset 299a8: IMC 0 channel 1 -> rank 1
+	 * Device 27, Offset 219a8: IMC 1 channel 0 -> rank 2
+	 * Device 27, Offset 299a8: IMC 1 channel 1 -> rank 3
+	 * Device 28, Offset 219a8: IMC 2 channel 0 -> rank 4
+	 * Device 28, Offset 299a8: IMC 2 channel 1 -> rank 5
+	 * Device 29, Offset 219a8: IMC 3 channel 0 -> rank 6
+	 * Device 29, Offset 299a8: IMC 3 channel 1 -> rank 7
+	 */
+	dev = 26 + chan_rank / 2;
+	offset = 0x219a8 + dimm_order * 4 + (chan_rank % 2) * 0x8000;
+
+	ret = peci_mmio_read(priv->peci_dev, 0, GET_CPU_SEG(reg_val), GET_CPU_BUS(reg_val),
+			     dev, 0, offset, data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct dimm_info dimm_hsx = {
 	.chan_rank_max	= CHAN_RANK_MAX_ON_HSX,
 	.dimm_idx_max	= DIMM_IDX_MAX_ON_HSX,
@@ -576,6 +615,13 @@ static const struct dimm_info dimm_icxd = {
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
@@ -601,6 +647,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
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

