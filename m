Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631837D9BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346107AbjJ0Ons (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjJ0Oni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:43:38 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB33E3;
        Fri, 27 Oct 2023 07:43:36 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 4343240557;
        Fri, 27 Oct 2023 19:42:50 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698417770; bh=OHLRJC/diPfVFt8XwpnQvHWosIsHUiivbV6zXKO3qc0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=vjhEzfNBqX2jogZExWJu9smjWlNjalqWufxvt6mPBlLmiofTQKr+n1gW/qZ2fmxX9
         ibhUnclb0yuzOXkbupuJw4kfzorN8n/8R6udUv9vc1jZPVksm+k/9QNXR9RVv6Yyki
         TdoGbRHCtmdy9aqDBx7aufN+Es/Y3lIIWrBelFJhD25vXt9jvpUtzZ1wqhEXPonTFD
         +sYtXon6jSnNy1JZ6zbQ5wgQM1qn9Fo45MaHapNjKrJkLbX5kIxXNJQdxNQSeB4Jhs
         2lGOaXfrCAEk5+Nm5kzcoeb8+K89RCgd6Ww9p30nCtrLJbZYddWCJwUVDGBqz/PMjD
         GPMFDOJJZR1bg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 27 Oct 2023 19:42:23 +0500
Subject: [PATCH 3/3] arm64: dts: qcom: acer-aspire1: Add sound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-aspire1-sound-v1-3-5ff3cf8b5701@trvn.ru>
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
In-Reply-To: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4201; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=OHLRJC/diPfVFt8XwpnQvHWosIsHUiivbV6zXKO3qc0=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlO8xc30z+MrENqgfLgqVSE+q+ra7RoCnWdyiz1
 6GhE6uWXmGJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZTvMXAAKCRBDHOzuKBm/
 dd67D/4pT2ycHdMwd/6ryVt9JVDg9rTTP+IYgpuMiDCjwy/JQbSkqPqigfGqMOwdFhI9L4h6fqt
 gYa6wqXhCXxADwSfKrvXLSJsszBm5Btrm71ZnhWp+E5gDGYCoO4hjfH3L4Nv9FWJ4rkJe5WQL7Z
 3Ya+y6IW5jrKlAQhkr+zdTFhc3cgPKdbvB45jvxncQ5zEXPVQv5rDZ6m+orp42Pft9QWajLr5E5
 EOrN61xy36EwCz0zEj5irEOPUQXicR08uheUN/DlJIPppxOVnmfLku0/fO5SIjIQOEe0D20pSf0
 IA+VWyXrcE/+dAieOEBT+jN9f2IE25r5urMUMLv9jSjfcUvBufLRya6kRJ97bLOMu1sSW2OWnA4
 ZWu27d+nhxE+ux11DeQAvl+9Hs4iKT5cibvCieGVX0OLLjRWl1sFgVRAgc7lFMEyC89YYzTBmOt
 kaBR56+mNmr+MVA46wlhySWo5phGSniQA9iK6g/XqYREephKV64kJfDK2VysZrf4yfDyJXPS//3
 sB7h6sL81NHZkJR1MJ5vlGDWFaDbQ33V2N2rBn6VfcPaoMYCVYA2n/QGo/yWlsrey5E/G42nQ5P
 UMKEqwzUDkw+V/t66xTROfIN2I/UmtMPnRl1P1VNe9FVihLxSIyeZnIwM0SLCOC7RW4aCu2sA1U
 z0aJPfUusk+QCPw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This laptop has two i2s speakers; an i2s audio codec for the headset
jack; two DMIC microphones in the lid and the displayport audio channel.

This commit adds the audio node that describes all of the above with the
exception of the DMICs that require in-SoC digital codec to be brought
up, which will be done later.

Note that the displayport channel is connected here for completeness,
but the displayport can't be used yet since the HPD signal is created by
the embedded controller, which will be added later.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 153 +++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index 00b442696618..5afcb8212f49 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc7180.dtsi"
@@ -129,6 +130,113 @@ reg_lcm_3p3: panel-regulator {
 		pinctrl-names = "default";
 	};
 
+	sound: sound {
+		compatible = "qcom,sc7180-qdsp6-sndcard";
+		pinctrl-0 = <&pri_mi2s_active>, <&pri_mi2s_mclk_active>, <&ter_mi2s_active>;
+		pinctrl-names = "default";
+		model = "Acer-Aspire-1";
+
+		audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR";
+
+		multimedia1-dai-link {
+			link-name = "MultiMedia1";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+			};
+		};
+
+		multimedia2-dai-link {
+			link-name = "MultiMedia2";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+			};
+		};
+
+		multimedia3-dai-link {
+			link-name = "MultiMedia3";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+			};
+		};
+
+		multimedia4-dai-link {
+			link-name = "MultiMedia4";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA4>;
+			};
+		};
+
+		primary-rx-dai-link {
+			link-name = "Primary MI2S Playback";
+
+			cpu {
+				sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+
+			codec {
+				sound-dai = <&alc5682 0>;
+			};
+		};
+
+		primary-tx-dai-link {
+			link-name = "Primary MI2S Capture";
+
+			cpu {
+				sound-dai = <&q6afedai PRIMARY_MI2S_TX>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+
+			codec {
+				sound-dai = <&alc5682 0>;
+			};
+		};
+
+		tertiary-rx-dai-link {
+			link-name = "Tertiary MI2S Playback";
+
+			cpu {
+				sound-dai = <&q6afedai TERTIARY_MI2S_RX>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+
+			codec {
+				sound-dai = <&max98357a>;
+			};
+		};
+
+		displayport-rx-dai-link {
+			link-name = "DisplayPort Playback";
+
+			cpu {
+				sound-dai = <&q6afedai DISPLAY_PORT_RX>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp>;
+			};
+		};
+	};
+
 	reg_tp_3p3: touchpad-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "tp_3p3";
@@ -368,6 +476,45 @@ &pm6150_rtc {
 	status = "okay";
 };
 
+&q6afedai {
+	dai@16 {
+		reg = <PRIMARY_MI2S_RX>;
+		qcom,sd-lines = <1>;
+	};
+
+	dai@17 {
+		reg = <PRIMARY_MI2S_TX>;
+		qcom,sd-lines = <0>;
+	};
+
+	dai@20 {
+		reg = <TERTIARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
+
+	dai@104 {
+		reg = <DISPLAY_PORT_RX>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+
+	dai@3 {
+		reg = <3>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -376,6 +523,12 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	memory-region = <&adsp_mem>;
+	firmware-name = "qcom/sc7180/acer/aspire1/qcadsp7180.mbn";
+	status = "okay";
+};
+
 &remoteproc_mpss {
 	firmware-name = "qcom/sc7180/acer/aspire1/qcmpss7180_nm.mbn";
 	status = "okay";

-- 
2.41.0

