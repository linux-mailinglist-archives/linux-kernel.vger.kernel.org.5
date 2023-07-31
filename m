Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71CB769A17
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjGaOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjGaOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:50:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C0BE5D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:50:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbc06f830aso29450575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690815046; x=1691419846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i5V2PQZX+FAZnejywIWiHOfuBgtGQ7LZgzryZywvQA=;
        b=G7Of/Ie4KCR3EU3M8He/gwNVQWg73FrUgiMo/oLGXIry/PfwvWZid4/S2iok0aVKwi
         vy5jS9zUMG4YmR8ac777p9RDLtLyN1hhlae7gq/oH59h5r+2OQoil0vddJucuP/2NPsV
         ijlu8/6Jb3nwlbMWT3VzVUTewwvaxfORkEV1pIGVxwwVd/85BODPfXigX2HrMQKutipg
         155ARqyAl+Mnuo3YtJrusdec37Qgcpm9KFDU70i1c/UxgP3dZ+iEyUVRAR/6m7ClJh01
         q1+BN1jOPPIsyYqxoJy4m+3TJa1I2EBufl0/FJubVpaR4pjQ0QDwBBcoOIQyzHLYJQjU
         6ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690815046; x=1691419846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i5V2PQZX+FAZnejywIWiHOfuBgtGQ7LZgzryZywvQA=;
        b=MBTVP2Gl7PnaP9ha+5PNpCrk1s681k3xU7giheToevSuPLXyuOvu5Tzoddr1AwJXJd
         wFu3ii+PvqU+JN86hMgv4Te+Hz5XmclKksIJRGCMHnTV2GMemZQaFO3mqOjYvgbSKY/z
         3QLJqqx2HFl8vnKOlwE1z9/Zeq4sa0bG5ZxvJnaHPnY+ofI7I7oItEACAM6GtUUDBVsu
         +sgyq1FB0KEQyEjrCkXQ3yMhtNAFnSQspJnei3Eu8zpbIQTttnWBOUQbWXKffZ0g0n8s
         FUFpC4OXvf9N4IdyJ84IfVmJzlH4uiHBko0Qi0ZXYWQX7w1yClZleTsyJf9+uBlvi+QS
         EiHw==
X-Gm-Message-State: ABy/qLan5ciubCcXOe7u1Bz5JDdtxJw1YB6pkiofojQxxU/vaAZ3n34u
        dy+wuCGZ4iw/p3SYfw6d8oJ7
X-Google-Smtp-Source: APBJJlGsYxIgaAQIhI8dTFkTwfSogb2BZwcfZ9xoTgoSr91tggrVrxA3byuFuWPB+CuE81pDONXnYQ==
X-Received: by 2002:a17:903:18d:b0:1bb:c896:1d91 with SMTP id z13-20020a170903018d00b001bbc8961d91mr10831294plg.31.1690815045997;
        Mon, 31 Jul 2023 07:50:45 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.129])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b06c106844sm8730185plb.151.2023.07.31.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:50:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Brian Masney <bmasney@redhat.com>
Subject: [PATCH 2/2] scsi: ufs: qcom: Add support for scaling interconnects
Date:   Mon, 31 Jul 2023 20:20:20 +0530
Message-Id: <20230731145020.41262-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
References: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom SoCs require scaling the interconnect paths for proper working of the
peripherals connected through interconnects. Even for accessing the UFS
controller, someone should setup the interconnect paths. So far, the
bootloaders used to setup the interconnect paths before booting linux as
they need to access the UFS storage for things like fetching boot firmware.
But with the advent of multi boot options, bootloader nowadays like in
SA8540p SoC do not setup the interconnect paths at all.

So trying to configure UFS in the absence of the interconnect path
configuration, results in boot crash.

To fix this issue and also to dynamically scale the interconnects (UFS-DDR
and CPU-UFS), interconnect API support is added to the Qcom UFS driver.
With this support, the interconnect paths are scaled dynamically based on
the gear configuration.

During the early stage of ufs_qcom_init(), ufs_qcom_icc_init() will setup
the paths to max bandwidth to allow configuring the UFS registers. Touching
the registers without configuring the icc paths would result in a crash.
However, we don't really need to set max vote for the icc paths as any
minimal vote would suffice. But the max value would allow initialization to
be done faster. After init, the bandwidth will get updated using
ufs_qcom_icc_update_bw() based on the gear and lane configuration.

The bandwidth values defined in ufs_qcom_bw_table struct are taken from
Qcom downstream vendor devicetree source and are calculated as per the
UFS3.1 Spec, Section 6.4.1, HS Gear Rates. So it is fixed across platforms.

Cc: Brian Masney <bmasney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 131 +++++++++++++++++++++++++++++++++++-
 drivers/ufs/host/ufs-qcom.h |   3 +
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 5728e94b6527..75a1fd295f34 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -46,6 +47,49 @@ enum {
 	TSTBUS_MAX,
 };
 
+#define QCOM_UFS_MAX_GEAR 4
+#define QCOM_UFS_MAX_LANE 2
+
+enum {
+	MODE_MIN,
+	MODE_PWM,
+	MODE_HS_RA,
+	MODE_HS_RB,
+	MODE_MAX,
+};
+
+struct __ufs_qcom_bw_table {
+	u32 mem_bw;
+	u32 cfg_bw;
+} ufs_qcom_bw_table[MODE_MAX + 1][QCOM_UFS_MAX_GEAR + 1][QCOM_UFS_MAX_LANE + 1] = {
+	[MODE_MIN][0][0]		   = { 0,		0 }, /* Bandwidth values in KB/s */
+	[MODE_PWM][UFS_PWM_G1][UFS_LANE_1] = { 922,		1000 },
+	[MODE_PWM][UFS_PWM_G2][UFS_LANE_1] = { 1844,		1000 },
+	[MODE_PWM][UFS_PWM_G3][UFS_LANE_1] = { 3688,		1000 },
+	[MODE_PWM][UFS_PWM_G4][UFS_LANE_1] = { 7376,		1000 },
+	[MODE_PWM][UFS_PWM_G1][UFS_LANE_2] = { 1844,		1000 },
+	[MODE_PWM][UFS_PWM_G2][UFS_LANE_2] = { 3688,		1000 },
+	[MODE_PWM][UFS_PWM_G3][UFS_LANE_2] = { 7376,		1000 },
+	[MODE_PWM][UFS_PWM_G4][UFS_LANE_2] = { 14752,		1000 },
+	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_1] = { 127796,		1000 },
+	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_1] = { 255591,		1000 },
+	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
+	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
+	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_2] = { 255591,		1000 },
+	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_2] = { 511181,		1000 },
+	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
+	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
+	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_1] = { 149422,		1000 },
+	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_1] = { 298189,		1000 },
+	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
+	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
+	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_2] = { 298189,		1000 },
+	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_2] = { 596378,		1000 },
+	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
+	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
+	[MODE_MAX][0][0]		    = { 7643136,	307200 },
+};
+
 static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
 
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
@@ -789,6 +833,51 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_qcom_host *host, bool enable)
 	}
 }
 
+static int ufs_qcom_icc_set_bw(struct ufs_qcom_host *host, u32 mem_bw, u32 cfg_bw)
+{
+	struct device *dev = host->hba->dev;
+	int ret;
+
+	ret = icc_set_bw(host->icc_ddr, 0, mem_bw);
+	if (ret < 0) {
+		dev_err(dev, "failed to set bandwidth request: %d\n", ret);
+		return ret;
+	}
+
+	ret = icc_set_bw(host->icc_cpu, 0, cfg_bw);
+	if (ret < 0) {
+		dev_err(dev, "failed to set bandwidth request: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct __ufs_qcom_bw_table ufs_qcom_get_bw_table(struct ufs_qcom_host *host)
+{
+	struct ufs_pa_layer_attr *p = &host->dev_req_params;
+	int gear = max_t(u32, p->gear_rx, p->gear_tx);
+	int lane = max_t(u32, p->lane_rx, p->lane_tx);
+
+	if (ufshcd_is_hs_mode(p)) {
+		if (p->hs_rate == PA_HS_MODE_B)
+			return ufs_qcom_bw_table[MODE_HS_RB][gear][lane];
+		else
+			return ufs_qcom_bw_table[MODE_HS_RA][gear][lane];
+	} else {
+		return ufs_qcom_bw_table[MODE_PWM][gear][lane];
+	}
+}
+
+static int ufs_qcom_icc_update_bw(struct ufs_qcom_host *host)
+{
+	struct __ufs_qcom_bw_table bw_table;
+
+	bw_table = ufs_qcom_get_bw_table(host);
+
+	return ufs_qcom_icc_set_bw(host, bw_table.mem_bw, bw_table.cfg_bw);
+}
+
 static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 				enum ufs_notify_change_status status,
 				struct ufs_pa_layer_attr *dev_max_params,
@@ -852,6 +941,8 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		memcpy(&host->dev_req_params,
 				dev_req_params, sizeof(*dev_req_params));
 
+		ufs_qcom_icc_update_bw(host);
+
 		/* disable the device ref clock if entered PWM mode */
 		if (ufshcd_is_hs_mode(&hba->pwr_info) &&
 			!ufshcd_is_hs_mode(dev_req_params))
@@ -981,7 +1072,9 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 
 	switch (status) {
 	case PRE_CHANGE:
-		if (!on) {
+		if (on) {
+			ufs_qcom_icc_update_bw(host);
+		} else {
 			if (!ufs_qcom_is_link_active(hba)) {
 				/* disable device ref_clk */
 				ufs_qcom_dev_ref_clk_ctrl(host, false);
@@ -993,6 +1086,9 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 			/* enable the device ref clock for HS mode*/
 			if (ufshcd_is_hs_mode(&hba->pwr_info))
 				ufs_qcom_dev_ref_clk_ctrl(host, true);
+		} else {
+			ufs_qcom_icc_set_bw(host, ufs_qcom_bw_table[MODE_MIN][0][0].mem_bw,
+					    ufs_qcom_bw_table[MODE_MIN][0][0].cfg_bw);
 		}
 		break;
 	}
@@ -1031,6 +1127,34 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
 	.deassert = ufs_qcom_reset_deassert,
 };
 
+static int ufs_qcom_icc_init(struct ufs_qcom_host *host)
+{
+	struct device *dev = host->hba->dev;
+	int ret;
+
+	host->icc_ddr = devm_of_icc_get(dev, "ufs-ddr");
+	if (IS_ERR(host->icc_ddr))
+		return dev_err_probe(dev, PTR_ERR(host->icc_ddr),
+				    "failed to acquire interconnect path\n");
+
+	host->icc_cpu = devm_of_icc_get(dev, "cpu-ufs");
+	if (IS_ERR(host->icc_cpu))
+		return dev_err_probe(dev, PTR_ERR(host->icc_cpu),
+				    "failed to acquire interconnect path\n");
+
+	/*
+	 * Set Maximum bandwidth vote before initializing the UFS controller and
+	 * device. Ideally, a minimal interconnect vote would suffice for the
+	 * initialization, but a max vote would allow faster initialization.
+	 */
+	ret = ufs_qcom_icc_set_bw(host, ufs_qcom_bw_table[MODE_MAX][0][0].mem_bw,
+				  ufs_qcom_bw_table[MODE_MAX][0][0].cfg_bw);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to set bandwidth request\n");
+
+	return 0;
+}
+
 /**
  * ufs_qcom_init - bind phy with controller
  * @hba: host controller instance
@@ -1085,6 +1209,10 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		}
 	}
 
+	err = ufs_qcom_icc_init(host);
+	if (err)
+		goto out_variant_clear;
+
 	host->device_reset = devm_gpiod_get_optional(dev, "reset",
 						     GPIOD_OUT_HIGH);
 	if (IS_ERR(host->device_reset)) {
@@ -1282,6 +1410,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 				    dev_req_params->pwr_rx,
 				    dev_req_params->hs_rate,
 				    false);
+		ufs_qcom_icc_update_bw(host);
 		ufshcd_uic_hibern8_exit(hba);
 	}
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 729240367e70..d6f8e74bd538 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -206,6 +206,9 @@ struct ufs_qcom_host {
 	struct clk *tx_l1_sync_clk;
 	bool is_lane_clks_enabled;
 
+	struct icc_path *icc_ddr;
+	struct icc_path *icc_cpu;
+
 #ifdef CONFIG_SCSI_UFS_CRYPTO
 	struct qcom_ice *ice;
 #endif
-- 
2.25.1

