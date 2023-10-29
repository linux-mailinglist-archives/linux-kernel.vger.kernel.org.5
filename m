Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1217DADFE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 20:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjJ2Tq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjJ2TqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 15:46:17 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3207EC2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 12:46:13 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Dxg_CEtj5lvps1AA--.39559S3;
        Mon, 30 Oct 2023 03:46:12 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxXNx+tj5lKq02AA--.51878S6;
        Mon, 30 Oct 2023 03:46:11 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] drm/loongson: Started to attach display bridge driver for LS7A1000
Date:   Mon, 30 Oct 2023 03:46:03 +0800
Message-Id: <20231029194607.379459-5-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029194607.379459-1-suijingfeng@loongson.cn>
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxXNx+tj5lKq02AA--.51878S6
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gry5trW8Ar4fZFy8JF17XFc_yoWxArWUpF
        s8t393tr48XF1rWr4vyr1DWw15ArWqkFyUtrs7uw1S9as3Krn0qF4xtr1DW3WDXa95ur1U
        twsFqw43CF18CwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
        6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8XyCJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson ML5B_MA board using ITE IT66121 HDMI transmitter to support HDMI
display output, with the vbios provided the necessary information, we are
able to create a minimal drm bridge driver for it. After apply this patch
we are able to change mode freely.

Tested on LS3A5000+LS7A1000 ML5B_MA board.

$ dmesg | grep drm

 [drm] dc: 264MHz, gmc: 529MHz, gpu: 529MHz
 [drm] Dedicated vram start: 0xe0030000000, size: 64MiB
 [drm] Loongson VBIOS version: 0.3
 [drm] Loongson VBIOS: has 8 DCBs
 [drm] VRAM: 4096 pages ready
 [drm] GTT: 32768 pages ready
 [drm] lsdc-i2c0(sda pin mask=1, scl pin mask=2) created
 [drm] lsdc-i2c1(sda pin mask=4, scl pin mask=8) created
 [drm] DisplayPipe-0 has DVO-0
 [drm] device address(0x4d) is not correct
 [drm] i2c client IT66121@0x4c created
 [drm] IT66121 attached, Vendor ID: 0x4954, Device ID: 0x612
 [drm] Total 2 outputs
 [drm] registered irq: 40
 [drm] Initialized loongson 1.0.0 20220701 for 0000:00:06.1 on minor 0
 loongson 0000:00:06.1: [drm] fb0: loongsondrmfb frame buffer device

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c | 144 +++++++-----------
 1 file changed, 55 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a1000.c b/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
index 6fc8dd1c7d9a..e12f9a0157d0 100644
--- a/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
+++ b/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
@@ -10,6 +10,7 @@
 #include "lsdc_drv.h"
 #include "lsdc_output.h"
 
+#include "ite_it66121.h"
 /*
  * The display controller in the LS7A1000 exports two DVO interfaces, thus
  * external encoder is required, except connected to the DPI panel directly.
@@ -38,68 +39,6 @@
  *  TODO: Add support for non-transparent encoders
  */
 
-static int ls7a1000_dpi_connector_get_modes(struct drm_connector *conn)
-{
-	unsigned int num = 0;
-	struct edid *edid;
-
-	if (conn->ddc) {
-		edid = drm_get_edid(conn, conn->ddc);
-		if (edid) {
-			drm_connector_update_edid_property(conn, edid);
-			num = drm_add_edid_modes(conn, edid);
-			kfree(edid);
-		}
-
-		return num;
-	}
-
-	num = drm_add_modes_noedid(conn, 1920, 1200);
-
-	drm_set_preferred_mode(conn, 1024, 768);
-
-	return num;
-}
-
-static struct drm_encoder *
-ls7a1000_dpi_connector_get_best_encoder(struct drm_connector *connector,
-					struct drm_atomic_state *state)
-{
-	struct lsdc_output *output = connector_to_lsdc_output(connector);
-
-	return &output->encoder;
-}
-
-static const struct drm_connector_helper_funcs
-ls7a1000_dpi_connector_helpers = {
-	.atomic_best_encoder = ls7a1000_dpi_connector_get_best_encoder,
-	.get_modes = ls7a1000_dpi_connector_get_modes,
-};
-
-static enum drm_connector_status
-ls7a1000_dpi_connector_detect(struct drm_connector *connector, bool force)
-{
-	struct i2c_adapter *ddc = connector->ddc;
-
-	if (ddc) {
-		if (drm_probe_ddc(ddc))
-			return connector_status_connected;
-
-		return connector_status_disconnected;
-	}
-
-	return connector_status_unknown;
-}
-
-static const struct drm_connector_funcs ls7a1000_dpi_connector_funcs = {
-	.detect = ls7a1000_dpi_connector_detect,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state
-};
-
 static void ls7a1000_pipe0_encoder_reset(struct drm_encoder *encoder)
 {
 	struct drm_device *ddev = encoder->dev;
@@ -139,40 +78,67 @@ static const struct drm_encoder_funcs ls7a1000_encoder_funcs[2] = {
 	},
 };
 
+/*
+ * This is a default output description for LS7A1000/LS2K1000, this is always
+ * true from the hardware perspective. It is just that when there are external
+ * display bridge connected, this description no longer complete. As it cannot
+ * describe the topology about the external encoders.
+ */
+static const struct lsdc_output_desc ls7a1000_output_desc[2] = {
+	{
+		.pipe = 0,
+		.encoder_type = DRM_MODE_ENCODER_DPI,
+		.connector_type = DRM_MODE_CONNECTOR_DPI,
+		.encoder_funcs = &ls7a1000_encoder_funcs[0],
+		.encoder_helper_funcs = &lsdc_encoder_helper_funcs,
+		.connector_funcs = &lsdc_connector_funcs,
+		.connector_helper_funcs = &lsdc_connector_helper_funcs,
+		.name = "DVO-0",
+	},
+	{
+		.pipe = 1,
+		.encoder_type = DRM_MODE_ENCODER_DPI,
+		.connector_type = DRM_MODE_CONNECTOR_DPI,
+		.encoder_funcs = &ls7a1000_encoder_funcs[1],
+		.encoder_helper_funcs = &lsdc_encoder_helper_funcs,
+		.connector_funcs = &lsdc_connector_funcs,
+		.connector_helper_funcs = &lsdc_connector_helper_funcs,
+		.name = "DVO-1",
+	},
+};
+
 int ls7a1000_output_init(struct drm_device *ddev,
 			 struct lsdc_display_pipe *dispipe,
 			 struct i2c_adapter *ddc,
 			 unsigned int index)
 {
 	struct lsdc_output *output = &dispipe->output;
-	struct drm_encoder *encoder = &output->encoder;
-	struct drm_connector *connector = &output->connector;
-	int ret;
-
-	ret = drm_encoder_init(ddev, encoder, &ls7a1000_encoder_funcs[index],
-			       DRM_MODE_ENCODER_TMDS, "encoder-%u", index);
-	if (ret)
-		return ret;
-
-	encoder->possible_crtcs = BIT(index);
-
-	ret = drm_connector_init_with_ddc(ddev, connector,
-					  &ls7a1000_dpi_connector_funcs,
-					  DRM_MODE_CONNECTOR_DPI, ddc);
-	if (ret)
-		return ret;
-
-	drm_info(ddev, "display pipe-%u has a DVO\n", index);
-
-	drm_connector_helper_add(connector, &ls7a1000_dpi_connector_helpers);
-
-	drm_connector_attach_encoder(connector, encoder);
+	enum loongson_vbios_encoder_name encoder_name = 0;
+	struct drm_bridge *bridge = NULL;
+	u8 slave_addr;
+	bool ret;
+
+	output->descp = &ls7a1000_output_desc[index];
+
+	ret = loongson_vbios_query_encoder_info(ddev, index, NULL,
+						&encoder_name, &slave_addr);
+	if (!ret)
+		goto skip;
+
+	switch (encoder_name) {
+	case ENCODER_CHIP_IT66121:
+		bridge = it66121_bridge_create(ddev, ddc, slave_addr, false,
+					       0, index);
+		break;
+	default:
+		break;
+	}
 
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
-			    DRM_CONNECTOR_POLL_DISCONNECT;
+	if (IS_ERR(bridge))
+		goto skip;
 
-	connector->interlace_allowed = 0;
-	connector->doublescan_allowed = 0;
+	output->bridge = bridge;
 
-	return 0;
+skip:
+	return lsdc_output_init(ddev, dispipe, ddc, index);
 }
-- 
2.34.1

