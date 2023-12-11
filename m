Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A880C73E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjLKKv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjLKKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:51:09 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B20049A;
        Mon, 11 Dec 2023 02:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ogYeW
        q53mwvMY8/AuQ2ItH8tM58aVHFQdY1bO102rI8=; b=IaXGyWv9Z9egPL78L9ARm
        3BIh2qqjbQXm1NAet8V3MXhut+kacQiFdDNZCorTB7oTAPzYH5ZOySMhsZ/mtJKL
        XtNxzSzNg3Z89+93fLQRTFpX4efcbZi9UhTw15OOyh8QCXvJCsFv60VJBypi0ZU2
        js3UO0nPrfbZsJnRFSv7us=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnjx5w6XZlKq5+FQ--.11346S2;
        Mon, 11 Dec 2023 18:50:28 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/5] dt-bindings: arm: rockchip: Add Cool Pi CM5 EVB
Date:   Mon, 11 Dec 2023 18:50:23 +0800
Message-Id: <20231211105023.1779786-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211104915.1779476-1-andyshrk@163.com>
References: <20231211104915.1779476-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnjx5w6XZlKq5+FQ--.11346S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrykXrWkAF47XFWkGFWUCFg_yoWDGrXEka
        yxZw1ruF1FvF909w4qva1xGFy5tw17KFn7CF1rtF1DC3s8t393taykt34SyFyfuF13urn3
        CF4fWryDGFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAuc_UUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBVDXmVOA40STwAAsY
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cool Pi CM5 EVB, a board powered by RK3588

Signed-off-by: Andy Yan <andyshrk@163.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v2)

Changes in v2:
- change board compatible from "CoolPi CM5 EVB" to "coolpi,pi-cm5-evb"

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 11d03035f3db..4da83bbd642a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -95,6 +95,11 @@ properties:
           - const: chipspark,rayeager-px2
           - const: rockchip,rk3066a
 
+      - description: Cool Pi Compute Module 5(CM5) EVB
+        items:
+          - const: coolpi,pi-cm5-evb
+          - const: rockchip,rk3588
+
       - description: Cool Pi 4 Model B
         items:
           - const: coolpi,pi-4b
-- 
2.34.1

