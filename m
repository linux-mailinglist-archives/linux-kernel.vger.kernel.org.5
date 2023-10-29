Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931307DADFC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 20:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjJ2TqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJ2TqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 15:46:17 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 752D0C4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 12:46:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxtPCFtj5lwps1AA--.40172S3;
        Mon, 30 Oct 2023 03:46:13 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxXNx+tj5lKq02AA--.51878S7;
        Mon, 30 Oct 2023 03:46:12 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drm/loongson: Using vbios for the LS7A2000 output initialization
Date:   Mon, 30 Oct 2023 03:46:04 +0800
Message-Id: <20231029194607.379459-6-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029194607.379459-1-suijingfeng@loongson.cn>
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxXNx+tj5lKq02AA--.51878S7
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr4UAw4kGw45JF4DZw1rKrX_yoWxtw4Dpr
        sxtrZ3Jr1kZF1Fyr1kAr1kX34YyrWvkFySy3s29w1Sy34fJr90qF47tr1UW3WUJa9Y9r12
        vrsrXw4ak3WUC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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
        AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE
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

For LS7A2000, the built-in VGA encoder is transparent. Connect another
external transmitter with this internal VGA encoder is not sane, thus is
not allowed. Because there are two internal encoders hardware resource on
the first display pipe, call loongson_vbios_query_encoder_info() to know
what exatly the output configutaion is. Either VGA or HDMI display output
interface, but not both. And formal products should not export three
display connector interfaces. As the hardware has two-way I2Cs and two
CRTCs. So with this observation, we can untangle more.

If there a need to extend(transform) the output interface type, then the
internal HDMI phy MUST be enabled and initialized. External transmitters
must take the HDMI signal as input, this is the only choices. Such as
lt6711(HDMI to eDP), lt8619(HDMI to LVDS) etc.

Before apply this patch, ls7a2000_output_init() is simplified function
which assumed that there is no external display bridge attached. This
naive abstraction no longer suit the needs in the long run. Hence, switch
to call the newly implemented lsdc_output_init() function, which allow us
model the external encoder as a drm display bridge. The driver of this drm
display bridge should reside in the same kernel module with drm/loongson.
We will attach it by ourself, and rely on the VBIOS tell us which display
pipe has what display bridge connected.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c | 154 ++++++++++++++----
 1 file changed, 124 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
index ce3dabec887e..bf558b61802b 100644
--- a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
+++ b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
@@ -501,6 +501,126 @@ static const struct drm_encoder_helper_funcs ls7a2000_encoder_helper_funcs = {
 	.atomic_mode_set = ls7a2000_hdmi_atomic_mode_set,
 };
 
+/* The built-in tranparent VGA encoder is only available on display pipe 0 */
+static void ls7a2000_pipe0_vga_encoder_reset(struct drm_encoder *encoder)
+{
+	struct lsdc_device *ldev = to_lsdc(encoder->dev);
+	u32 val = PHY_CLOCK_POL | PHY_CLOCK_EN | PHY_DATA_EN;
+
+	lsdc_wreg32(ldev, LSDC_CRTC0_DVO_CONF_REG, val);
+
+	/*
+	 * The firmware set LSDC_HDMIx_CTRL_REG blindly to use hardware I2C,
+	 * which is may not works because of hardware bug. We using built-in
+	 * GPIO emulated I2C instead of the hardware I2C here.
+	 */
+	lsdc_ureg32_clr(ldev, LSDC_HDMI0_INTF_CTRL_REG, HW_I2C_EN);
+
+	mdelay(20);
+}
+
+static const struct drm_encoder_funcs ls7a2000_pipe0_vga_encoder_funcs = {
+	.reset = ls7a2000_pipe0_vga_encoder_reset,
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct lsdc_output_desc ls7a2000_vga_pipe0 = {
+	.pipe = 0,
+	.encoder_type = DRM_MODE_ENCODER_DAC,
+	.connector_type = DRM_MODE_CONNECTOR_VGA,
+	.encoder_funcs = &ls7a2000_pipe0_vga_encoder_funcs,
+	.encoder_helper_funcs = &lsdc_pipe0_hdmi_encoder_helper_funcs,
+	.connector_funcs = &lsdc_connector_funcs,
+	.connector_helper_funcs = &lsdc_connector_helper_funcs,
+	.name = "VGA-0",
+};
+
+static const struct lsdc_output_desc ls7a2000_hdmi_pipe0 = {
+	.pipe = 0,
+	.encoder_type = DRM_MODE_ENCODER_TMDS,
+	.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+	.encoder_funcs = &lsdc_pipe0_hdmi_encoder_funcs,
+	.encoder_helper_funcs = &lsdc_pipe0_hdmi_encoder_helper_funcs,
+	.connector_funcs = &lsdc_pipe0_hdmi_connector_funcs,
+	.connector_helper_funcs = &lsdc_connector_helper_funcs,
+	.name = "HDMI-0",
+};
+
+static const struct lsdc_output_desc ls7a2000_hdmi_pipe1 = {
+	.pipe = 1,
+	.encoder_type = DRM_MODE_ENCODER_TMDS,
+	.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+	.encoder_funcs = &lsdc_pipe1_hdmi_encoder_funcs,
+	.encoder_helper_funcs = &lsdc_pipe1_hdmi_encoder_helper_funcs,
+	.connector_funcs = &lsdc_pipe1_hdmi_connector_funcs,
+	.connector_helper_funcs = &lsdc_connector_helper_funcs,
+	.name = "HDMI-1",
+};
+
+/*
+ * For LS7A2000, the built-in VGA encoder is transparent. If there are
+ * external encoder exist, then the internal HDMI encoder MUST be enabled
+ * and initialized. As the internal HDMI encoder is always connected, so
+ * only the transmitters which take HDMI signal (such as HDMI to eDP, HDMI
+ * to LVDS, etc) are usable with.
+ */
+const struct lsdc_output_desc *
+ls7a2000_query_output_configuration(struct drm_device *ddev, unsigned int pipe)
+{
+	enum loongson_vbios_encoder_name encoder_name = 0;
+	bool ret;
+
+	ret = loongson_vbios_query_encoder_info(ddev, pipe, NULL,
+						&encoder_name, NULL);
+	if (!ret)
+		goto bailout;
+
+	if (pipe == 0) {
+		switch (encoder_name) {
+		case ENCODER_CHIP_INTERNAL_HDMI:
+			return &ls7a2000_hdmi_pipe0;
+
+		/*
+		 * For LS7A2000, the built-in VGA encoder is transparent.
+		 */
+		case ENCODER_CHIP_INTERNAL_VGA:
+			return &ls7a2000_vga_pipe0;
+
+		/*
+		 * External display bridge exists, the internal HDMI encoder
+		 * MUST be enabled and initialized. Please add a drm bridge
+		 * driver, and attach to this encoder.
+		 */
+		default:
+			return &ls7a2000_hdmi_pipe0;
+		}
+	}
+
+	if (pipe == 1) {
+		switch (encoder_name) {
+		case ENCODER_CHIP_INTERNAL_HDMI:
+			return &ls7a2000_hdmi_pipe1;
+
+		/*
+		 * External display bridge exists, the internal HDMI encoder
+		 * MUST be enabled and initialized. Please add a drm bridge
+		 * driver, and attach it to this encoder.
+		 */
+		default:
+			return &ls7a2000_hdmi_pipe1;
+		}
+	}
+
+bailout:
+	if (pipe == 0)
+		return &ls7a2000_vga_pipe0;
+
+	if (pipe == 1)
+		return &ls7a2000_hdmi_pipe1;
+
+	return NULL;
+}
+
 /*
  * For LS7A2000:
  *
@@ -517,36 +637,10 @@ int ls7a2000_output_init(struct drm_device *ddev,
 			 unsigned int pipe)
 {
 	struct lsdc_output *output = &dispipe->output;
-	struct drm_encoder *encoder = &output->encoder;
-	struct drm_connector *connector = &output->connector;
-	int ret;
-
-	ret = drm_encoder_init(ddev, encoder, &ls7a2000_encoder_funcs[pipe],
-			       DRM_MODE_ENCODER_TMDS, "encoder-%u", pipe);
-	if (ret)
-		return ret;
-
-	encoder->possible_crtcs = BIT(pipe);
-
-	drm_encoder_helper_add(encoder, &ls7a2000_encoder_helper_funcs);
-
-	ret = drm_connector_init_with_ddc(ddev, connector,
-					  &ls7a2000_hdmi_connector_funcs[pipe],
-					  DRM_MODE_CONNECTOR_HDMIA, ddc);
-	if (ret)
-		return ret;
 
-	drm_info(ddev, "display pipe-%u has HDMI %s\n", pipe, pipe ? "" : "and/or VGA");
+	output->descp = ls7a2000_query_output_configuration(ddev, pipe);
+	if (!output->descp)
+		return -EINVAL;
 
-	drm_connector_helper_add(connector, &ls7a2000_connector_helpers);
-
-	drm_connector_attach_encoder(connector, encoder);
-
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
-			    DRM_CONNECTOR_POLL_DISCONNECT;
-
-	connector->interlace_allowed = 0;
-	connector->doublescan_allowed = 0;
-
-	return 0;
+	return lsdc_output_init(ddev, dispipe, ddc, pipe);
 }
-- 
2.34.1

