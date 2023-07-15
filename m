Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C367547DB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjGOJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGOJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:20:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3498F3C0D;
        Sat, 15 Jul 2023 02:20:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so24466965e9.3;
        Sat, 15 Jul 2023 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412806; x=1692004806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcIHaSKrR4JjJODseymsMqDO3fa+MLFhDB6UjbjUTpo=;
        b=AkcQaKMBERDjTs1UIrpydrPTPsZ61nJCxnccPi60KmmMOcsVgLNr9hUAMdXiNbzaD4
         q1D1OxfcioUs9Y0IHhuHnOTZHlCSRLvY/AXq/5iLRbSDh129e2kTZIkQwa74UFhdfF00
         ZqYbH3ua5FkBDYNC9r+yRk6d0lEMaKu5aoCkkR3rJZtjoApL46xbMcocRomRpZhtQxIz
         A1ebtVVfQwgwNyGbir4Kr0yGMlt+XF4LJpbTBJcSOexSni0cnImqXhBU4Sfz9ZlAzVze
         7IHwrHH4MJEP3f0IaqFeHs6qa0Ca6sBF8zEBhXLLOdyWMzxyvvDrolToQEhqW+7FORG5
         J5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412806; x=1692004806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcIHaSKrR4JjJODseymsMqDO3fa+MLFhDB6UjbjUTpo=;
        b=K4hmlOphbWgWV0rLwqUPoCjQx7y+tYGJtdPkfI1lESJx+l4I3k+Ao5yfO00dSLwfWW
         zAcj46XCrCyFrHVpdpQpf3mdSGfmb+Qa+eznAKBEx5C4Za7fxSDrsPvoYOFmVJ45MK9M
         ntYOWJDRu9ivvFcWEXX2FBiqzy58V456cyknYowyhZXKGeYZaHA2atoV9K4u4zZgstmk
         +5t7qz77+6vJ6SFWDp/MbkYLDE96oxlYS30ih2pFJYd3/X4PyF3TX0Qm+VZM7jo+AQdb
         ReIp67i3ONbm7SdKdZ9Q1pKxO/2r6c6oHt75SLtT/HZqlkxG2F1nZ0jZTpWoKMK8xpxw
         ReHw==
X-Gm-Message-State: ABy/qLZfJW8CYhjN3cr928FGQSQRItON1bdG378N+Q69KICxjy3D7202
        /EKpe2xbWczstkWrlSPkTu3SqwUqIv0=
X-Google-Smtp-Source: APBJJlGv8dHKCO/r29rQsgsQOIVVso/vVhMdbGJ51bXTdUlhMiljiUkWfMHrLjloHsgJomwyh1skMw==
X-Received: by 2002:a05:600c:2489:b0:3fb:b3aa:1c8f with SMTP id 9-20020a05600c248900b003fbb3aa1c8fmr5896747wms.28.1689412806652;
        Sat, 15 Jul 2023 02:20:06 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.202.152])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm3238133wml.18.2023.07.15.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:20:06 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v3 6/7] arm64: dts: qcom: Add SM7125 device tree
Date:   Sat, 15 Jul 2023 11:16:12 +0200
Message-ID: <20230715091932.161507-7-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715091932.161507-1-davidwronek@gmail.com>
References: <20230715091932.161507-1-davidwronek@gmail.com>
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

The Snapdragon 720G (sm7125) is software-wise very similar to the
Snapdragon 7c with minor differences in clock speeds and as added here,
it uses the Kryo 465 instead of Kryo 468.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm7125.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/qcom/sm7125.dtsi
new file mode 100644
index 000000000000..12dd72859a43
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#include "sc7180.dtsi"
+
+/* SM7125 uses Kryo 465 instead of Kryo 468 */
+&CPU0 { compatible = "qcom,kryo465"; };
+&CPU1 { compatible = "qcom,kryo465"; };
+&CPU2 { compatible = "qcom,kryo465"; };
+&CPU3 { compatible = "qcom,kryo465"; };
+&CPU4 { compatible = "qcom,kryo465"; };
+&CPU5 { compatible = "qcom,kryo465"; };
+&CPU6 { compatible = "qcom,kryo465"; };
+&CPU7 { compatible = "qcom,kryo465"; };
-- 
2.41.0

