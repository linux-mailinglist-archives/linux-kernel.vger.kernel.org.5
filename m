Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFB17D6912
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbjJYKkd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjJYKkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:40:14 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD93610C9;
        Wed, 25 Oct 2023 03:40:07 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9330F83D4;
        Wed, 25 Oct 2023 18:39:59 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 25 Oct
 2023 18:39:59 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 25 Oct
 2023 18:39:59 +0800
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, Bjorn Andersson <andersson@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Keith Zhao <keith.zhao@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 3/6] drm/fourcc: Add drm/vs tiled modifiers
Date:   Wed, 25 Oct 2023 18:39:54 +0800
Message-ID: <20231025103957.3776-4-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025103957.3776-1-keith.zhao@starfivetech.com>
References: <20231025103957.3776-1-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each modifier, add the corresponding description

Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
---
 include/uapi/drm/drm_fourcc.h | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 8db7fd3f7..a580a848c 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -419,6 +419,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
 #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
+#define DRM_FORMAT_MOD_VENDOR_VERISILICON 0x0b
 
 /* add more to the end as needed */
 
@@ -1562,6 +1563,62 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_CLEAR(field) \
 	(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
 
+#define DRM_FORMAT_MOD_VERISILICON_TYPE_NORMAL					0x00
+#define DRM_FORMAT_MOD_VERISILICON_TYPE_MASK					((__u64)0x3 << 54)
+
+#define fourcc_mod_vs_code(type, val) \
+	fourcc_mod_code(VERISILICON, ((((__u64)type) << 54) | (val)))
+
+#define DRM_FORMAT_MOD_VERISILICON_NORM_MODE_MASK				0x1F
+
+/*
+ * An x-major 8x8 super tile consists of 64 8x8 sub-tiles in total.
+ * Each 8x8 sub-tile consists of four standard tiles .
+ * standard tiles (see Vivante 4x4 tiling layout)
+ */
+#define DRM_FORMAT_MOD_VERISILICON_SUPER_TILED_XMAJOR_8X8		0x02
+
+/*
+ * A y-major 8x8 super tile consists of 64 8x8 sub-tiles in total.
+ * Each 8x8 sub-tile consists of four standard tiles .
+ * standard tiles (see Vivante 4x4 tiling layout)
+ */
+#define DRM_FORMAT_MOD_VERISILICON_SUPER_TILED_YMAJOR_8X8		0x03
+
+/*
+ * An 8x8 tile consists of four standard tiles
+ * that are organized in Z-order.
+ * standard tiles (see Vivante 4x4 tiling layout)
+ */
+#define DRM_FORMAT_MOD_VERISILICON_TILE_8X8						0x04
+
+/*
+ * An 8x4 tile consists of two standard tiles
+ * that are organized in Z-order.
+ * standard tiles (see Vivante 4x4 tiling layout)
+ */
+#define DRM_FORMAT_MOD_VERISILICON_TILE_8X4						0x07
+
+/*
+ * An x-major 8x4 super tile consists of 128 8x4 sub-tiles in total.
+ * Each 8x4 sub-tile consists of two standard tiles.
+ * two standard tiles also same with DRM_FORMAT_MOD_VS_TILE_8X4
+ * standard tiles (see Vivante 4x4 tiling layout)
+ */
+#define DRM_FORMAT_MOD_VERISILICON_SUPER_TILED_XMAJOR_8X4		0x0B
+
+/*
+ * A y-major 4x8 super tile consists of 128 4x8 sub-tiles in total.
+ * Each 4x8 sub-tile consists of two standard tiles.
+ * two standard tiles also same with DRM_FORMAT_MOD_VS_TILE_8X4
+ * standard tiles (see Vivante 4x4 tiling layout)
+ */
+#define DRM_FORMAT_MOD_VERISILICON_SUPER_TILED_YMAJOR_4X8    0x0C
+
+#define fourcc_mod_vs_norm_code(tile) \
+	fourcc_mod_vs_code(DRM_FORMAT_MOD_VERISILICON_TYPE_NORMAL, \
+				(tile))
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

