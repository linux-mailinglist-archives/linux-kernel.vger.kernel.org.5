Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE28038ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjLDPgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbjLDPfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:35:51 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13DEB6;
        Mon,  4 Dec 2023 07:35:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50be4f03b06so2283261e87.0;
        Mon, 04 Dec 2023 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704156; x=1702308956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JoGo3S5F18Eq5w0w9lKp48csF80CvWfgslipmXEQ2c=;
        b=Gu7t4MeCPDrZk4OKjyxBPv+UftGzNOrpS3DbZ1JOx7KxfcVcZ6P1CDBg4XpPx/3UXR
         SIZG2MobKhyp7Dlz1VQxwOvr+yVWrmALoa9KcRNiZ4GDYbGEiMaPZQeyrznDToHZFx8q
         6MZZTJNHImqxQkOlyjgVEt3WJvE3VLbvphfVNd/PfbRIpCsfbKks5wLEchmk8TP4He1/
         4cnv9D0XhVAWAl9OMx2YC6OJb20TSp23s5KcqL8aoJjKoRfZeiJPGrgP2UyxtvcEthU/
         qp8nMSrGTfCnH6rgdZEmZs5D66Inq0dCMHrvTMkMqWGym87xWekmsOjtXlY3r3uSPydt
         XzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704156; x=1702308956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JoGo3S5F18Eq5w0w9lKp48csF80CvWfgslipmXEQ2c=;
        b=MJAUcPhjNyHxi5fHG3ibj71llJ/1E4bBuui/UZU6a6kOjS1+BQHkpxONN+UoYGwiwM
         kfJhwBEJRwfgkDc7YUFOBswKcdgoONYs6UaaHEdNpoa5Ej3dInr2HRtxgW9bmib+H29e
         1aadFkrT+WLiNxYVCIJW0nCvP4c94L4uWabEyuS6nQKfdXE2zoXCZ7NYkeSz6NxyD5zK
         pMVxgdb0dLm8AANAST27quBSSKrphrDw8bhOZlDmSXfMs7Nep7PLL97a5d6PDUTs8e4F
         sgWhrfWDp7tofbTb/bkv0iPdx7rd7SrtFqD8gtYAl1FEO80q3iitvB/EVa/To24WjVg3
         hBjg==
X-Gm-Message-State: AOJu0YyIPkuYeGb4AAwjFi0PFHQRYnfJQTGKiTYxHvFG2opdLi/4nPxU
        O/Ev+npVgZDHAn8ns1KC2w==
X-Google-Smtp-Source: AGHT+IFeR1c6fEMTNf73omsuIShEqHPdSRkJR+GEECA6voE9/MXpZsqiF0j631q2/HOWTWd/oPU3kQ==
X-Received: by 2002:ac2:546d:0:b0:50b:c977:106a with SMTP id e13-20020ac2546d000000b0050bc977106amr1765730lfn.51.1701704155343;
        Mon, 04 Dec 2023 07:35:55 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:55ff:210b:5393:c9d7])
        by smtp.gmail.com with ESMTPSA id h20-20020a05640250d400b0054c77ac01f4sm693194edb.51.2023.12.04.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:35:55 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 1/3] ARM: dts: rockchip: Add power-controller for RK3128
Date:   Mon,  4 Dec 2023 16:35:45 +0100
Message-ID: <20231204153547.97877-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204153547.97877-1-knaerzche@gmail.com>
References: <20231204153547.97877-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power controller and qos nodes for RK3128 in order to use
them as powerdomains.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index c0c9f0eaffa3..0676d8b22a1e 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3128-power.h>
 
 / {
 	compatible = "rockchip,rk3128";
@@ -133,6 +134,93 @@ smp-sram@0 {
 	pmu: syscon@100a0000 {
 		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
 		reg = <0x100a0000 0x1000>;
+
+		power: power-controller {
+			compatible = "rockchip,rk3128-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-domain@RK3128_PD_VIO {
+				reg = <RK3128_PD_VIO>;
+				clocks = <&cru ACLK_CIF>,
+					 <&cru HCLK_CIF>,
+					 <&cru DCLK_EBC>,
+					 <&cru HCLK_EBC>,
+					 <&cru ACLK_IEP>,
+					 <&cru HCLK_IEP>,
+					 <&cru ACLK_LCDC0>,
+					 <&cru HCLK_LCDC0>,
+					 <&cru PCLK_MIPI>,
+					 <&cru ACLK_RGA>,
+					 <&cru HCLK_RGA>,
+					 <&cru ACLK_VIO0>,
+					 <&cru ACLK_VIO1>,
+					 <&cru HCLK_VIO>,
+					 <&cru HCLK_VIO_H2P>,
+					 <&cru DCLK_VOP>,
+					 <&cru SCLK_VOP>;
+				pm_qos = <&qos_ebc>,
+					 <&qos_iep>,
+					 <&qos_lcdc>,
+					 <&qos_rga>,
+					 <&qos_vip>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3128_PD_VIDEO {
+				reg = <RK3128_PD_VIDEO>;
+				clocks = <&cru ACLK_VDPU>,
+					 <&cru HCLK_VDPU>,
+					 <&cru ACLK_VEPU>,
+					 <&cru HCLK_VEPU>,
+					 <&cru SCLK_HEVC_CORE>;
+				pm_qos = <&qos_vpu>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3128_PD_GPU {
+				reg = <RK3128_PD_GPU>;
+				clocks = <&cru ACLK_GPU>;
+				pm_qos = <&qos_gpu>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
+	qos_gpu: qos@1012d000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012d000 0x20>;
+	};
+
+	qos_vpu: qos@1012e000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012e000 0x20>;
+	};
+
+	qos_rga: qos@1012f000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f000 0x20>;
+	};
+
+	qos_ebc: qos@1012f080 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f080 0x20>;
+	};
+
+	qos_iep: qos@1012f100 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f100 0x20>;
+	};
+
+	qos_lcdc: qos@1012f180 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f180 0x20>;
+	};
+
+	qos_vip: qos@1012f200 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f200 0x20>;
 	};
 
 	gic: interrupt-controller@10139000 {
-- 
2.43.0

