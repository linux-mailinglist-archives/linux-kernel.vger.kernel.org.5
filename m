Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA957FEF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbjK3Mii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345191AbjK3Mih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:38:37 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 648751B4;
        Thu, 30 Nov 2023 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B3xSh
        3pkeOtaKv+3Outtg7o/L43oM6faIEHTjYD8usE=; b=ABaOxcI8JCVIyPpw97Ur+
        dql3tbeUmn4KpDjHN3YAcR9EnXe3DJDJaQpkh5z6mOlQ2M5eUCuApMivhr3jN2rb
        Ems/Eocda18A9b6zRA2Srpc8z4AEURieVep3mnjYXgOcOnA65akgI7J5yWsZgi97
        C2l8qXB9wJPcuBLuu2DxII=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wD3f3OQfmhlpsNSEQ--.49329S2;
        Thu, 30 Nov 2023 20:22:44 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 01/14] drm/rockchip: move output interface related definition to rockchip_drm_drv.h
Date:   Thu, 30 Nov 2023 20:22:39 +0800
Message-Id: <20231130122239.12769-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130122001.12474-1-andyshrk@163.com>
References: <20231130122001.12474-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f3OQfmhlpsNSEQ--.49329S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFW3Zw17XF4DCr1xZr45trb_yoW3XryDpa
        1DAryjvrW7CF42qrnrAFs3Ar4fta1qyayxCr97W3WavF1Ikr1DG3sxWws5Xr9xXr1xAFW2
        krsrG34UAF42gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSKZJUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEhc4XmVOAqth9QAAs1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

The output interface related definition can shared between
vop and vop2, move them to rockchip_drm_drv.h can avoid duplicated
definition.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

---

(no changes since v1)

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  1 -
 drivers/gpu/drm/rockchip/cdn-dp-core.c          |  1 -
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c |  1 -
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c     |  1 -
 drivers/gpu/drm/rockchip/inno_hdmi.c            |  1 -
 drivers/gpu/drm/rockchip/rk3066_hdmi.c          |  1 -
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     | 17 +++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h     | 12 +-----------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h    | 16 +---------------
 drivers/gpu/drm/rockchip/rockchip_lvds.c        |  1 -
 drivers/gpu/drm/rockchip/rockchip_rgb.c         |  1 -
 11 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 84aa811ca1e9..bd08d57486fe 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -30,7 +30,6 @@
 #include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
-#include "rockchip_drm_vop.h"
 
 #define RK3288_GRF_SOC_CON6		0x25c
 #define RK3288_EDP_LCDC_SEL		BIT(5)
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 21254e4e107a..a855c45ae7f3 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -24,7 +24,6 @@
 
 #include "cdn-dp-core.h"
 #include "cdn-dp-reg.h"
-#include "rockchip_drm_vop.h"
 
 static inline struct cdn_dp_device *connector_to_dp(struct drm_connector *connector)
 {
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 6396f9324dab..4cc8ed8f4fbd 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -26,7 +26,6 @@
 #include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
-#include "rockchip_drm_vop.h"
 
 #define DSI_PHY_RSTZ			0xa0
 #define PHY_DISFORCEPLL			0
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 341550199111..fe33092abbe7 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -18,7 +18,6 @@
 #include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
-#include "rockchip_drm_vop.h"
 
 #define RK3228_GRF_SOC_CON2		0x0408
 #define RK3228_HDMI_SDAIN_MSK		BIT(14)
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 6e5b922a121e..f6d819803c0e 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -23,7 +23,6 @@
 #include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
-#include "rockchip_drm_vop.h"
 
 #include "inno_hdmi.h"
 
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index fa6e592e0276..78136d0c5a65 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -17,7 +17,6 @@
 #include "rk3066_hdmi.h"
 
 #include "rockchip_drm_drv.h"
-#include "rockchip_drm_vop.h"
 
 #define DEFAULT_PLLA_RATE 30000000
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index aeb03a57240f..3d8ab2defa1b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -20,6 +20,23 @@
 #define ROCKCHIP_MAX_CONNECTOR	2
 #define ROCKCHIP_MAX_CRTC	4
 
+/*
+ * display output interface supported by rockchip lcdc
+ */
+#define ROCKCHIP_OUT_MODE_P888		0
+#define ROCKCHIP_OUT_MODE_BT1120	0
+#define ROCKCHIP_OUT_MODE_P666		1
+#define ROCKCHIP_OUT_MODE_P565		2
+#define ROCKCHIP_OUT_MODE_BT656		5
+#define ROCKCHIP_OUT_MODE_S888		8
+#define ROCKCHIP_OUT_MODE_S888_DUMMY	12
+#define ROCKCHIP_OUT_MODE_YUV420	14
+/* for use special outface */
+#define ROCKCHIP_OUT_MODE_AAAA		15
+
+/* output flags */
+#define ROCKCHIP_OUTPUT_DSI_DUAL	BIT(0)
+
 struct drm_device;
 struct drm_connector;
 struct iommu_domain;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 4b2daefeb8c1..43d9c9191b7a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -277,17 +277,7 @@ struct vop_data {
 /* dst alpha ctrl define */
 #define DST_FACTOR_M0(x)		(((x) & 0x7) << 6)
 
-/*
- * display output interface supported by rockchip lcdc
- */
-#define ROCKCHIP_OUT_MODE_P888	0
-#define ROCKCHIP_OUT_MODE_P666	1
-#define ROCKCHIP_OUT_MODE_P565	2
-/* for use special outface */
-#define ROCKCHIP_OUT_MODE_AAAA	15
-
-/* output flags */
-#define ROCKCHIP_OUTPUT_DSI_DUAL	BIT(0)
+
 
 enum alpha_mode {
 	ALPHA_STRAIGHT,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 56fd31e05238..7175f46a2014 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -7,10 +7,9 @@
 #ifndef _ROCKCHIP_DRM_VOP2_H
 #define _ROCKCHIP_DRM_VOP2_H
 
-#include "rockchip_drm_vop.h"
-
 #include <linux/regmap.h>
 #include <drm/drm_modes.h>
+#include "rockchip_drm_vop.h"
 
 #define VOP_FEATURE_OUTPUT_10BIT        BIT(0)
 
@@ -166,19 +165,6 @@ struct vop2_data {
 #define WB_YRGB_FIFO_FULL_INTR		BIT(18)
 #define WB_COMPLETE_INTR		BIT(19)
 
-/*
- * display output interface supported by rockchip lcdc
- */
-#define ROCKCHIP_OUT_MODE_P888		0
-#define ROCKCHIP_OUT_MODE_BT1120	0
-#define ROCKCHIP_OUT_MODE_P666		1
-#define ROCKCHIP_OUT_MODE_P565		2
-#define ROCKCHIP_OUT_MODE_BT656		5
-#define ROCKCHIP_OUT_MODE_S888		8
-#define ROCKCHIP_OUT_MODE_S888_DUMMY	12
-#define ROCKCHIP_OUT_MODE_YUV420	14
-/* for use special outface */
-#define ROCKCHIP_OUT_MODE_AAAA		15
 
 enum vop_csc_format {
 	CSC_BT601L,
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index f0f47e9abf5a..59341654ec32 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -27,7 +27,6 @@
 #include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
-#include "rockchip_drm_vop.h"
 #include "rockchip_lvds.h"
 
 #define DISPLAY_OUTPUT_RGB		0
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index c677b71ae516..dbfbde24698e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -19,7 +19,6 @@
 #include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
-#include "rockchip_drm_vop.h"
 #include "rockchip_rgb.h"
 
 struct rockchip_rgb {
-- 
2.34.1

