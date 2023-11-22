Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52A87F4729
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjKVM4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjKVM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:56:33 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AA46112;
        Wed, 22 Nov 2023 04:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1/yeg
        zhg493SHTeZi5h3nk3lTbPGINQCkIZUbQHUeVA=; b=fKSsXRd8y86+tjM+RTSH9
        TGaEuGovJ8wiDGh0cMEug4IHZwwkgstMvTydI8x5kVzWUeU55thdrEkxXzIBh7z6
        OuHa8qOb47GZZfWLkvS9GHMWHSeIQ214NacjAFHPjUwNXqz+OPD1Dh0BsT05XXvO
        Ua4kIokobf5qFABxM0MEik=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wC3nxBE+l1lQijtDg--.51444S2;
        Wed, 22 Nov 2023 20:55:35 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        s.hauer@pengutronix.de, Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 09/12] dt-bindings: soc: vop2: Add more endpoint definition
Date:   Wed, 22 Nov 2023 20:55:31 +0800
Message-Id: <20231122125531.3454857-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122125316.3454268-1-andyshrk@163.com>
References: <20231122125316.3454268-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3nxBE+l1lQijtDg--.51444S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF48Aw1fJFW3tFyfKF17KFg_yoWfCFc_A3
        ZrXF4kWF4fuFWfJrZ5Ar48Wr15u3Z7CF1xXFn0yrZxAF1F9rWkA3Z7JF13J3Wruay5J3Wv
        qay0gasxu3Z8GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnUKItUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnAgwXlghlh7-EgABsn
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

There are 2 HDMI, 2 DP, 2 eDP on rk3588, so add
corresponding endpoint definition for it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- split form vop driver patch

 include/dt-bindings/soc/rockchip,vop2.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/soc/rockchip,vop2.h b/include/dt-bindings/soc/rockchip,vop2.h
index 6e66a802b96a..668f199df9f0 100644
--- a/include/dt-bindings/soc/rockchip,vop2.h
+++ b/include/dt-bindings/soc/rockchip,vop2.h
@@ -10,5 +10,9 @@
 #define ROCKCHIP_VOP2_EP_LVDS0	5
 #define ROCKCHIP_VOP2_EP_MIPI1	6
 #define ROCKCHIP_VOP2_EP_LVDS1	7
+#define ROCKCHIP_VOP2_EP_HDMI1	8
+#define ROCKCHIP_VOP2_EP_EDP1	9
+#define ROCKCHIP_VOP2_EP_DP0	10
+#define ROCKCHIP_VOP2_EP_DP1	11
 
 #endif /* __DT_BINDINGS_ROCKCHIP_VOP2_H */
-- 
2.34.1

