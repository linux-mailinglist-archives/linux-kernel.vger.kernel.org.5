Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D4770EF5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjHEJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjHEJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:01:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332C49F4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 02:01:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b6e943ebso48336391fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691226098; x=1691830898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAS1x2FkCprR3urFZ8j6l2Bn1/hDBO8u/mCzFP5uQII=;
        b=XoQDqxjcBzgZdclFrc5xoSWHy9W0/gaSXWVvxG9ZstgiiJsySSDGUuVuXS96dpEBLK
         lZ5240qal6NeSxhvkWI1+jiJIw/XuChiQEEzszbItv6l4JRxiRSvCqvJnvVIc/SFdpLw
         o0Q88I7R3p6Gicw/oEnd/vGxXyXT82QCNns4mb2AKhbxUXSftKZKThOm+itYhnX4sf87
         td2K4pD5VBp1kqkjb236WAKfzLlOA0FVXLtHLo2fW3uS1CnkLTi9jQEBJxpy03tSAHgq
         PUoswyX4PI5qqUZr1bRi076X9cQ1/qf4afqCn/p4wIRwZn2J1g2apqwD80FYKnPkXAbZ
         Y8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691226098; x=1691830898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAS1x2FkCprR3urFZ8j6l2Bn1/hDBO8u/mCzFP5uQII=;
        b=g+4r4dSBNL4TGhaymla17jHkGqdGRPJYPF7Upa9icU/k+gkkPg6eHeOsy/JyFGN8iR
         Ln6XTUlMKQ+sm4eJZ/tUCYx6NKJzYU8wYkrE/zp68LGn2bHSFQGBebBr8y56fM2iruVs
         tTpXK217LeSJEH/zPkpNuH2HmLSyAWq9mmE1RxizRHTQsY3+pxpFsa1ZdTitlYcBiUXO
         G/ZoR8brjmX0N9b8r8Kj7f+8Po4AygmHfG5J6lLihoColIhW4jf34caXviHoa4aMgd6Z
         fsaDNvh7jl0JMOKwCPK5fzjLUZ62SCv0Frt1F+dO9CWfffK7r7aDy51aDIzGn/RZKbfo
         pdeQ==
X-Gm-Message-State: AOJu0Yx7+y5pYSewguWIHiNVeTNWYfA4TjV8E6LwepS9GttO/8PsFY27
        Gteut+BKloF9/kQT3v5ZsvlNYA==
X-Google-Smtp-Source: AGHT+IF6WfIftqokBBMIOuL/9u/hmZzChDUoy2+Yd/QQahUk58BJoyMzMI2QqkuAc50UO/sMItMtFQ==
X-Received: by 2002:a05:651c:483:b0:2b9:cb73:9a90 with SMTP id s3-20020a05651c048300b002b9cb739a90mr626593ljc.11.1691226098469;
        Sat, 05 Aug 2023 02:01:38 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id q24-20020a2e8758000000b002b6fe751b6esm814409ljj.124.2023.08.05.02.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 02:01:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 05 Aug 2023 11:01:33 +0200
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Add camera activity LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOwPzmQC/x2N0QrCMAwAf2Xk2UDXKjp/Rcbo0swFajcalcHYv
 xt8vIPjdlCuwgr3ZofKX1FZikF7aoDmWJ6MkozBOx/czV3wvaxCuLVBB4qvIXNCPnsKU+fSlTq
 wcIzKONZYaLa0fHI2uVaeZPufHv1x/AAcjxMfeQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691226096; l=1673;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1EZx/zCWBla3MFE6I61NTBOByaBBwYk3CAH6rZ+RkbY=;
 b=BENDfwanhYmEB+XHJC8kwdSBl0JkOZzJEv4A9qwDHTQWQ538CJ33ijM94JcXqi5oAs8/iinjk
 81FfGyD4P9TD9fpgmQFI+CZjgJoIM3I7578xOzwENNPHppk52s5erHv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disappointigly, the camera activity LED is implemented in software.
Hook it up as a gpio-led and (until we have camera *and* a "camera on"
LED trigger) configure it as a panic indicator.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index ffcca4f028e7..24e49b0e1131 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
@@ -78,6 +79,21 @@ switch-lid {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-camera-indicator {
+			label = "white:camera-indicator";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&tlmm 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			/* Reuse as a panic indicator until we get a "camera on" trigger */
+			panic-indicator;
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
 

---
base-commit: bdffb18b5dd8071cd25685b966f380a30b1fadaa
change-id: 20230805-topic-x13s_cam_led-e42c3f90d7c9

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

