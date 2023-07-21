Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8675C34F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGUJnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjGUJm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:42:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12B530ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:42:37 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED3C52F5E;
        Fri, 21 Jul 2023 11:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689932481;
        bh=cNkl06QQHpvODOS+NcyjyJrtUpAGoum7uDoGdQ4v5oM=;
        h=From:Date:Subject:To:Cc:From;
        b=oG+GCAZvk/7E4PKI49WAqK0Txl/XPwdEHjLiMWDlLIc1YWJeQWPFnj8d3/MhRPywj
         EqIIl8oc23WpAsnpNeO8IU3T7tJJAN9WU/bT2QB8z4JwgOrxlrTRUXrbYmVoi5f+EI
         H+5gSOzbbrdPC9jw6DsPOY+O4X67pgRR0UqNGok0=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 21 Jul 2023 12:41:49 +0300
Subject: [PATCH] drm/bridge: Add debugfs print for bridge chains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-drm-bridge-chain-debugfs-v1-1-8614ff7e890d@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIANxSumQC/x2MQQqAMAwEvyI5G2gjIvgV8WBtqjlYJUURxL8bP
 A47Ow8UVuECffWA8iVF9mzg6wrmdcoLo0RjIEeN68hj1A2DSrTFBMkYOZxLKuhCmH1LlNpuArs
 fyknuPz2M7/sB66l4eWoAAAA=
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4407;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=cNkl06QQHpvODOS+NcyjyJrtUpAGoum7uDoGdQ4v5oM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkulL3/1oxZDXSy2KXI3/n4Ihjp95Gkuy5lrimi
 SLm6s6nQmSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLpS9wAKCRD6PaqMvJYe
 9b/lD/4vm9Td3Avl7pKylPBLSvKEq6KJ/GlYvERTWzWXNl0eHg0VbaYyXDIAZOJyJBRtvFanKsW
 B0DdiDHr3OdWAE+4NvAy4IyOQwrR121WYgfPPFuK9GdxCVoEaYmQW4EZ6yQ/iOxknT3vLEDWLr9
 c3lxhkMst8jL5N7jkocg39agZ7V/UpiAzJm63WSjRMP6w9NaKBa6heFcipEBIexQKUoHnRmNPo6
 pwx+xxL1kSDkQH2dhZ2/AdyExWQ6RVYMFRQbvNRFr6HFVtFBCWGY0R90z9stTeFyVhpV7qUGfo+
 awF4JpAX7/uOY/cm+QYR7GNUPBocoWuuqQ7V9LZj4wEWVsJpFjovXeAuGNP9y5Y4hhMzXjmVBhL
 cYWb16j0RwftAnQ273fH2VXWfn1zvtnhxYuUKDVcFhACdIvtzoXAATuH+CiI6LtmATS7nlCCx76
 31aonf3pWxb+cMQIvNQYy544LKYXk6JbehUGj09vZHH46tBnm8r2e6TPVGoMNkWdXTuTT+q5DSP
 jH2Y8UFg3rdc8Fw/A26L/1eJXuUx4oG7Ad4MV9iODKU4r1Vb0Rel/o9Qh3mWGM25NJ1sSpmuNwK
 I729ds+lxDQgRi/xP+CdyxiaH7EGvg6G8GCOer0Bywpnq4KVUdf2sre32Rg3LnWDnyDm866TYOi
 LHAqvD7LEyxrwCg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM bridges are not visible to the userspace and it may not be
immediately clear if the chain is somehow constructed incorrectly. I
have had two separate instances of a bridge driver failing to do a
drm_bridge_attach() call, resulting in the bridge connector not being
part of the chain. In some situations this doesn't seem to cause issues,
but it will if DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is used.

Add a debugfs file to print the bridge chains. For me, on this TI AM62
based platform, I get the following output:

encoder[39]
	bridge[0] type: 0, ops: 0x0
	bridge[1] type: 0, ops: 0x0, OF: /bus@f0000/i2c@20000000/dsi@e:toshiba,tc358778
	bridge[2] type: 0, ops: 0x3, OF: /bus@f0000/i2c@20010000/hdmi@48:lontium,lt8912b
	bridge[3] type: 11, ops: 0x7, OF: /hdmi-connector:hdmi-connector

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_bridge.c  | 48 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_debugfs.c |  3 +++
 include/drm/drm_bridge.h      |  5 +++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c3d69af02e79..da3205aaed6b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -27,8 +27,10 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_debugfs.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_file.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 
@@ -1345,6 +1347,52 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+static int drm_bridge_chains_info(struct seq_file *m, void *data)
+{
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
+	struct drm_printer p = drm_seq_file_printer(m);
+	struct drm_mode_config *config = &dev->mode_config;
+	struct drm_encoder *encoder;
+	unsigned int bridge_idx = 0;
+
+	list_for_each_entry(encoder, &config->encoder_list, head) {
+		struct drm_bridge *bridge;
+
+		drm_printf(&p, "encoder[%u]\n", encoder->base.id);
+
+		bridge = drm_bridge_chain_get_first_bridge(encoder);
+
+		while (bridge) {
+			drm_printf(&p, "\tbridge[%u] type: %u, ops: %#x",
+				   bridge_idx, bridge->type, bridge->ops);
+
+			if (bridge->of_node)
+				drm_printf(&p, ", OF: %pOFfc", bridge->of_node);
+
+			drm_printf(&p, "\n");
+
+			bridge_idx++;
+			bridge = drm_bridge_get_next_bridge(bridge);
+		}
+	}
+
+	return 0;
+}
+
+/* any use in debugfs files to dump individual planes/crtc/etc? */
+static const struct drm_debugfs_info drm_bridge_debugfs_list[] = {
+	{"bridge_chains", drm_bridge_chains_info, 0},
+};
+
+void drm_bridge_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_add_files(minor->dev, drm_bridge_debugfs_list,
+			      ARRAY_SIZE(drm_bridge_debugfs_list));
+}
+#endif
+
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index c90dbcffa0dc..3e89559d68cd 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -31,6 +31,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_auth.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_client.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_device.h>
@@ -272,6 +273,8 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 
 	drm_debugfs_add_files(minor->dev, drm_debugfs_list, DRM_DEBUGFS_ENTRIES);
 
+	drm_bridge_debugfs_init(minor);
+
 	if (drm_drv_uses_atomic_modeset(dev)) {
 		drm_atomic_debugfs_init(minor);
 	}
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bf964cdfb330..60dbee6bd1e6 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -949,4 +949,9 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+struct drm_minor;
+void drm_bridge_debugfs_init(struct drm_minor *minor);
+#endif
+
 #endif

---
base-commit: c7a472297169156252a50d76965eb36b081186e2
change-id: 20230721-drm-bridge-chain-debugfs-0bbc1522f57a

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

