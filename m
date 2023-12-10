Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D355080B9C3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 09:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjLJIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 03:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjLJIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 03:06:34 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C894A119;
        Sun, 10 Dec 2023 00:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hsURR
        Csi3ZJB+D8uP6Qosmz8YCyjjg+sAMkIV/4imaE=; b=M38EuGw/ZilvDg3b8ucPc
        oBztIJ1/G1TOHY3g5+CPUNy11yJOZDKjZGTTwXoK2RyQ+4JKvOrEjXvnTgpHPQ9l
        RyxwrIBWbgcSK7KweFqpr5rJg/8d6gIv3IbNf7HOJgwvFibhDnw1T5/78nTXMTQE
        Bu0Q3jVqujRizSDqWjp+Sg=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wDn18ZycXVlDbACFQ--.57900S2;
        Sun, 10 Dec 2023 16:06:14 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 4/5] dt-bindings: arm: rockchip: Add Cool Pi CM5 EVB
Date:   Sun, 10 Dec 2023 16:06:07 +0800
Message-Id: <20231210080607.1667517-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210080313.1667013-1-andyshrk@163.com>
References: <20231210080313.1667013-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn18ZycXVlDbACFQ--.57900S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrykXF17KF48trWfWr1kAFb_yoWfWFgEka
        yxZwn5CF4FqF9093Wjva18GFy5Jw17KFn7C3W5tF1DA3s8tws3Kaykt34SkFyxuF17urn3
        CF4rWrWDuFsxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAuc_UUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqAFCXmVOA3fvqAABss
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

Add Cool Pi CM5 EVB, a board powered by RK3588

Signed-off-by: Andy Yan <andyshrk@163.com>

---

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

