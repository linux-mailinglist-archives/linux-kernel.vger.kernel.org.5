Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81A781CD5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHTIAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjHTIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 04:00:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6489710C7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 00:56:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so478593566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692518191; x=1693122991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THMyvm0RCCKTyF90SJ5PjCj2N+mTHvivLPOzTnzUtHE=;
        b=AEQ0uZMTDiIGTz38RCz2Yxu2LIhaUZ68DOvOl2b+zvEBNwShmUCnXpbMQlRaCHmuXR
         E6c/MV31P/XPmSHg6ZkUdfJpvC3undr2hF2pgu8DdlfefRBgNQwf0x+eer4MZY3rI9WQ
         HTdeb9ThvH2gLY6VfCTMj6dqvYUJpzEmp+uio1WtANyRaUr0y0T/D+e/SdYAmtec7jMR
         xxwHekRa/mABqUZfgMu5/rMLCMsfqvDrPrylZahqhljdv9Qolv4SgxddsB6yWTTCfUL5
         G+b6TXxXT0JHP7qV37MvtwspI2uJiPINKQjYOrw/0S8H8+tLYmRznzsURCYHafdBo8T/
         EzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692518191; x=1693122991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THMyvm0RCCKTyF90SJ5PjCj2N+mTHvivLPOzTnzUtHE=;
        b=YuLh/aNP56VE9hg17esme57WsexOpzhVW8hYxl6Wnkk0GLAZ3A1fSy7QrklkybpaFi
         QMObuMEUx8HHaPVbN5Abjv+LeCU1BbxoT9yFlfrs1AlJPbF3u75mtAFq+bMWyXWVZcDO
         nfp3bjmPMBe5NA9nwny8XHIZj90C/OrPARSMqppLm1pZ0bzpYYtTh7xMbF4vgmKDDCff
         4PtjjaZIfPlCqVDxpuxOy8IzHNwa6aFlUHrFi4gOx9RKKhCxA1t3mKGNbwaU6X9Zhr/w
         mFRK2GhgntSC0uhGWhx0LKt3CKd9bp4bDfNSRuHSriJGEZgK7mrQX+6ZG4x4JAam/dFR
         TmIg==
X-Gm-Message-State: AOJu0Yy4hzAc6d9FadpcFN9UFVUqwQ+jW97ZmFkEvDuQNIVsYP3/CANU
        HdjSGGyWevVB6aCSubwuyovj8A==
X-Google-Smtp-Source: AGHT+IFZW4S+dNy+vC8uZLRJvghLgr2H6/VYYBwnotfLZOZuk4PewJZcZxUZxkFQqni9pE/WpdEYUA==
X-Received: by 2002:a17:907:d26:b0:99b:fcd7:2d7a with SMTP id gn38-20020a1709070d2600b0099bfcd72d7amr4089970ejc.34.1692518190330;
        Sun, 20 Aug 2023 00:56:30 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id xa13-20020a170907b9cd00b0099bd5d28dc4sm4197644ejc.195.2023.08.20.00.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 00:56:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH RFT v2] arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side
Date:   Sun, 20 Aug 2023 09:56:26 +0200
Message-Id: <20230820075626.22600-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Embedded USB Debugger (EUD) second port should point to Type-C
USB connector.  Such connector was defined directly in root node of
sc7280.dtsi which is clearly wrong.  SC7280 is a chip, so physically it
does not have USB Type-C port.  The connector is usually accessible
through some USB switch or controller.

Doug Anderson said that he wasn't ever able to use EUD on Herobrine
boards, probably because of invalid or missing DTS description - DTS is
saying EUD is on usb_2 node, which is connected to a USB Hub, not to the
Type-C port.

Correct the EUD/USB connector topology by removing the top-level fake
USB connector and EUD port pointing to it, and disabling the incomplete
EUD device node.

This fixes also dtbs_check warnings:

  sc7280-herobrine-crd.dtb: connector: ports:port@0: 'reg' is a required property

Link: https://lore.kernel.org/all/CAD=FV=Xt26=rBf99mzkAuwwtb2f-jnKtnHaEhXnthz0a5zke4Q@mail.gmail.com/
Fixes: 9ee402ccfeb1 ("arm64: dts: qcom: sc7280: Fix EUD dt node syntax")
Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.

Changes in v2:
1. Disable the EUD node and do not add ports/connector in boards, as
   discussed with Doug.

v1: https://lore.kernel.org/all/CAD=FV=Xt26=rBf99mzkAuwwtb2f-jnKtnHaEhXnthz0a5zke4Q@mail.gmail.com/
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4abe5fb8e6c3..233cfcbd0b4a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -649,18 +649,6 @@ cpu7_opp_3014mhz: opp-3014400000 {
 		};
 	};
 
-	eud_typec: connector {
-		compatible = "usb-c-connector";
-
-		ports {
-			port@0 {
-				con_eud: endpoint {
-					remote-endpoint = <&eud_con>;
-				};
-			};
-		};
-	};
-
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -3623,6 +3611,8 @@ eud: eud@88e0000 {
 			      <0 0x88e2000 0 0x1000>;
 			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
 
+			status = "disabled";
+
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3633,13 +3623,6 @@ eud_ep: endpoint {
 						remote-endpoint = <&usb2_role_switch>;
 					};
 				};
-
-				port@1 {
-					reg = <1>;
-					eud_con: endpoint {
-						remote-endpoint = <&con_eud>;
-					};
-				};
 			};
 		};
 
-- 
2.34.1

