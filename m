Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326EA80C8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjLKMBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjLKMAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:00:40 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D199E1BE2;
        Mon, 11 Dec 2023 04:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jaCFF
        RYW1gcoVC7lj3FNE34bxdlQ4CgwuijOqt2bS5E=; b=JXaYKzrzUTfJna4l5VyGL
        PMT2Etkp0xt+K1o7Wo0pjce0naQaXkAQ2qfsM58g1Q81vqD6vypcDXZW06SLKNHa
        Fe1kZTo6gGeuDGTyc3K2ngrzSMeAprELK2i3VAIjIoc/3L/HY+yO6nt9stDfHrIv
        mLGc/UVrtpkDBCHRxSdeac=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3v2qk+XZlaEolAA--.4231S2;
        Mon, 11 Dec 2023 19:59:35 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 13/16] drm/rockchip: vop2: rename VOP_FEATURE_OUTPUT_10BIT to VOP2_VP_FEATURE_OUTPUT_10BIT
Date:   Mon, 11 Dec 2023 19:59:31 +0800
Message-Id: <20231211115931.1785495-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211115547.1784587-1-andyshrk@163.com>
References: <20231211115547.1784587-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v2qk+XZlaEolAA--.4231S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF48CF4UCw4DAry7WFy3Jwb_yoW5uFW8pa
        9xAryjvrW8Cr4aqw4DXFZxZFs0y3ZrCayIka17K3W7JFy3Kr1DWFsF9a48Ar9xJry7uFWa
        krsrX34UJF42qr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jw4SOUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqAhDXmVOA44qLgAAsf
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

VOP2 has multiple independent video ports with different
feature, so rename VOP_FEATURE_OUTPUT_10BIT to
VOP2_VP_FEATURE_OUTPUT_10BIT for more clearly meaning.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 2 +-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index edca7723335f..2b996f1a25ad 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1995,7 +1995,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 		return;
 
 	if (vcstate->output_mode == ROCKCHIP_OUT_MODE_AAAA &&
-	    !(vp_data->feature & VOP_FEATURE_OUTPUT_10BIT))
+	    !(vp_data->feature & VOP2_VP_FEATURE_OUTPUT_10BIT))
 		out_mode = ROCKCHIP_OUT_MODE_P888;
 	else
 		out_mode = vcstate->output_mode;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 2763e54350a9..615a16196aff 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -11,7 +11,7 @@
 #include <drm/drm_modes.h>
 #include "rockchip_drm_vop.h"
 
-#define VOP_FEATURE_OUTPUT_10BIT        BIT(0)
+#define VOP2_VP_FEATURE_OUTPUT_10BIT        BIT(0)
 
 #define VOP2_FEATURE_HAS_SYS_GRF	BIT(0)
 #define VOP2_FEATURE_HAS_VO0_GRF	BIT(1)
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 275d265891db..48170694ac6b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -136,7 +136,7 @@ static const uint64_t format_modifiers_afbc[] = {
 static const struct vop2_video_port_data rk3568_vop_video_ports[] = {
 	{
 		.id = 0,
-		.feature = VOP_FEATURE_OUTPUT_10BIT,
+		.feature = VOP2_VP_FEATURE_OUTPUT_10BIT,
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 9 * 9 * 9,
 		.max_output = { 4096, 2304 },
@@ -263,7 +263,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 	{
 		.id = 0,
-		.feature = VOP_FEATURE_OUTPUT_10BIT,
+		.feature = VOP2_VP_FEATURE_OUTPUT_10BIT,
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 9 * 9 * 9, /* 9x9x9 */
 		.max_output = { 4096, 2304 },
@@ -272,7 +272,7 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 		.offset = 0xc00,
 	}, {
 		.id = 1,
-		.feature = VOP_FEATURE_OUTPUT_10BIT,
+		.feature = VOP2_VP_FEATURE_OUTPUT_10BIT,
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 729, /* 9x9x9 */
 		.max_output = { 4096, 2304 },
@@ -280,7 +280,7 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 		.offset = 0xd00,
 	}, {
 		.id = 2,
-		.feature = VOP_FEATURE_OUTPUT_10BIT,
+		.feature = VOP2_VP_FEATURE_OUTPUT_10BIT,
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 17 * 17 * 17, /* 17x17x17 */
 		.max_output = { 4096, 2304 },
-- 
2.34.1

