Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868D6776693
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjHIRjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjHIRjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:39:36 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D610DE;
        Wed,  9 Aug 2023 10:39:35 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379HdP6o044737;
        Wed, 9 Aug 2023 12:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691602765;
        bh=bPJNJeQUgy0aF+J1sZlxi9L3YvHWdEofe+SYa/mf4fk=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=pdzmApGr09OPwlRMQLcIl9ulvvIu8/BxJ0MF0yZ7rLMKHF8YUM4i/7c9e0w7X+iN2
         VkZUtLFwSUqxsOKjnWgP8nz0QXWsKEjloB791GjECYHPdpOQ8P+jEpvyEOBczPHIx2
         r9Ul9nR0XiBrir7Bl0XUjolwyRIAWVwC5dtcOkxc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379HdPAB097175
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:39:25 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:39:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:39:24 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Hd6gd077353;
        Wed, 9 Aug 2023 12:39:20 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Keerthy J <j-keerthy@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j7200-thermal: Add cooling maps and cpu_alert trip at 75C
Date:   Wed, 9 Aug 2023 23:09:05 +0530
Message-ID: <20230809173905.1844132-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809173905.1844132-1-a-nandan@ti.com>
References: <20230809173905.1844132-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Add cooling maps and mpu_alert trip at 75C

Note: mpu_alert trip value should adjusted based on the system load and
performance needs.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
index e7e3a643a6f0..eeb596727d48 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
@@ -28,6 +28,20 @@ mpu_crit: mpu-crit {
 				hysteresis = <2000>; /* milliCelsius */
 				type = "critical";
 			};
+
+			mpu_alert0: mpu_alert {
+				temperature = <75000>; /* millicelsius */
+				hysteresis = <5000>; /* millicelsius */
+				type = "passive";
+			};
+		};
+
+		cpu_cooling_maps: cooling-maps {
+			map0 {
+				trip = <&mpu_alert0>;
+				cooling-device =
+				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
 		};
 	};
 
-- 
2.34.1

