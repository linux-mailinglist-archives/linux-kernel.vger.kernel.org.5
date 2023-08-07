Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC69772955
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjHGPd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjHGPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:33:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B060510EF;
        Mon,  7 Aug 2023 08:33:34 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FXFkh116683;
        Mon, 7 Aug 2023 10:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691422395;
        bh=PHdwIjd19EToE+SqKgKZGmkPpNgd8gvipOkXIPTlebI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HWriUiRXHAjzzeqeK6pbqwEXkEAaatPyEu5xZAesijRN1/yRFIuGCg/Slzjkxo/Cm
         wQfZfH8Fpw+p9tPRsVFqhoMeNx+7/Aj2ZL8ScyntLJ0jxLUdGwcZ9YqLGsWa7eP3lj
         M+c2EZ5e8qytAFxK1QaHtrzwj0Yg57f6JfCSppHk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FXFBF104748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:33:15 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:33:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:33:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377FXES8084515;
        Mon, 7 Aug 2023 10:33:15 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v4 4/6] arm64: dts: ti: am62x-sk: Add overlay for HDMI audio
Date:   Mon, 7 Aug 2023 21:03:05 +0530
Message-ID: <20230807153307.22174-5-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807153307.22174-1-a-bhatia1@ti.com>
References: <20230807153307.22174-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jai Luthra <j-luthra@ti.com>

Enable audio output over HDMI instead of the 3.5mm jack.

A FET switch (U65) on the EVM muxes serial audio lines coming from McASP
between the codec (tlv320aic3106) and the HDMI bridge (sii9022).

By default it uses the codec, but it can be toggled to use the HDMI
bridge by shorting a (J24) header on the board.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
[a-bhatia1: Cosmetic changes]
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  3 ++
 .../boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso   | 40 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 437a3d7e8e3a..e3eadf69d43b 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
@@ -68,6 +69,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Enable support for device-tree overlays
+DTC_FLAGS_k3-am625-sk += -@
+DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
new file mode 100644
index 000000000000..43a0ddc123e5
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Audio playback via HDMI for AM625-SK and AM62-LP SK.
+ *
+ * Links:
+ * AM625 SK: https://www.ti.com/tool/SK-AM62
+ * AM62-LP SK: https://www.ti.com/tool/SK-AM62-LP
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	hdmi_audio: sound-sii9022 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM62x-Sil9022-HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&hdmi_dailink_master>;
+		simple-audio-card,frame-master = <&hdmi_dailink_master>;
+
+		hdmi_dailink_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+			system-clock-direction-out;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&sii9022>;
+		};
+	};
+};
+
+&mcasp1 {
+	auxclk-fs-ratio = <2177>;
+};
+
+&codec_audio {
+	status = "disabled";
+};
-- 
2.40.1

