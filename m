Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCE7FEEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbjK3MYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345413AbjK3MYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:24:40 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 083061AD;
        Thu, 30 Nov 2023 04:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sit8y
        AQ8spW7AEygxvycNPffHdr8vkm1m0j7wyi3JYE=; b=TKewiM/VHXRysrhhCf1dX
        vuHE+DqEnEjl0SXrr+NWMqbXo9+Uoe04m54QQvb39CgXAS1LGh0gLSjVjMxDiVHz
        fQLmvcx72Pg4jom8l2javh3z9HrBntMJ2HCltOkRWHkFst5W0GxdPH1/K3qenrF2
        SoemEmoPTlSsAQoKxdGojQ=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wD3HxndfmhlydF7Cw--.52237S2;
        Thu, 30 Nov 2023 20:24:00 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 07/14] drm/rockchip: vop2: rename grf to sys_grf
Date:   Thu, 30 Nov 2023 20:23:56 +0800
Message-Id: <20231130122356.13141-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130122001.12474-1-andyshrk@163.com>
References: <20231130122001.12474-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3HxndfmhlydF7Cw--.52237S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFW7tFy3Ww43Zw15tw1xGrg_yoW8Zr1fpa
        sxAFW29r47GrZFgF1vkFs8uFWakws7CayIk3WxC3WS9347tr98KFs8Wa45JrW3JrnruF4a
        q3yqyry3CFy7Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSOJnUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqAU4XmVOAquT1wAAsN
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

The vop2 need to reference more grf(system grf, vop grf, vo0/1 grf,etc)
in the upcoming rk3588.

So we rename the current system grf to sys_grf.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 40b5c5ca4864..e21e7284db4d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -190,7 +190,7 @@ struct vop2 {
 	void __iomem *regs;
 	struct regmap *map;
 
-	struct regmap *grf;
+	struct regmap *sys_grf;
 
 	/* physical map length of vop2 register */
 	u32 len;
@@ -1514,9 +1514,9 @@ static void rk3568_set_intf_mux(struct vop2_video_port *vp, int id,
 		dip &= ~RK3568_DSP_IF_POL__RGB_LVDS_PIN_POL;
 		dip |= FIELD_PREP(RK3568_DSP_IF_POL__RGB_LVDS_PIN_POL, polflags);
 		if (polflags & POLFLAG_DCLK_INV)
-			regmap_write(vop2->grf, RK3568_GRF_VO_CON1, BIT(3 + 16) | BIT(3));
+			regmap_write(vop2->sys_grf, RK3568_GRF_VO_CON1, BIT(3 + 16) | BIT(3));
 		else
-			regmap_write(vop2->grf, RK3568_GRF_VO_CON1, BIT(3 + 16));
+			regmap_write(vop2->sys_grf, RK3568_GRF_VO_CON1, BIT(3 + 16));
 		break;
 	case ROCKCHIP_VOP2_EP_HDMI0:
 		die &= ~RK3568_SYS_DSP_INFACE_EN_HDMI_MUX;
@@ -2774,7 +2774,7 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 			return PTR_ERR(vop2->lut_regs);
 	}
 
-	vop2->grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
+	vop2->sys_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
 
 	vop2->hclk = devm_clk_get(vop2->dev, "hclk");
 	if (IS_ERR(vop2->hclk)) {
-- 
2.34.1

