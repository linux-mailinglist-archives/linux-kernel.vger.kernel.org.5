Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E83880C8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjLKL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjLKL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:59:20 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF882D5;
        Mon, 11 Dec 2023 03:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oq8U2
        J4jeAwzSS+oI8lZIgh3XmVih5h3euc/enRVnmk=; b=PpkDKIS7YuODt4KYpDhlZ
        Qi1FHu/R6KUo8RK7WynZh6WDVpQBCAv/JQrANMbMN6339OUCvU4+qu/nDSrpvyvU
        CByv5jdRCJLHO3+TveubtqhuWjc7cdqotsDJrpjqL++WQSE329qawogzQ/LwORKJ
        zykpIf4ljhSKrIqvs9iMB0=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wDntzht+XZlU7P7Aw--.32885S2;
        Mon, 11 Dec 2023 19:58:41 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 09/16] dt-bindings: soc: rockchip: add rk3588 vop/vo syscon
Date:   Mon, 11 Dec 2023 19:58:36 +0800
Message-Id: <20231211115836.1785248-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211115547.1784587-1-andyshrk@163.com>
References: <20231211115547.1784587-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDntzht+XZlU7P7Aw--.32885S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF13Ar4UKr17uw1Utw47urg_yoWfCFgEka
        4xZa45uF48GryFgw1qyayIk3Z8A3Z2kFykCa1jyF4kCaykZrZrKF95Jw1aqr1rua1fuw1f
        C3Z5WrWUGFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8K0P3UUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnAlDXlghl75dlgAAsT
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

Add VOP and VO GRF syscon compatibles for RK3588

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 1309bf5ae0cd..9793ea6f0fe6 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -28,6 +28,8 @@ properties:
               - rockchip,rk3588-sys-grf
               - rockchip,rk3588-pcie3-phy-grf
               - rockchip,rk3588-pcie3-pipe-grf
+              - rockchip,rk3588-vo-grf
+              - rockchip,rk3588-vop-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
-- 
2.34.1

