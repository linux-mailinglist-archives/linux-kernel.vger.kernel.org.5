Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37F77532B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjHIGt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHIGtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:49:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821D1FCA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:49:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc76cdf0cbso3489145ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1691563764; x=1692168564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKzfX6v1CyZX2xitAs24S+KxRHnlm3GlIzocQibU/6A=;
        b=yGyy8Mz1HckaaA4QsaWJKbak6sihe+vLm7idvKMYiNgPDyYJD/Dikj+/Mf3iSa+kWj
         wEuMAfbL2bGAljm+niyuCrZl9zgsO+PMdV2Vy2AJr3JAfKgWkV5SaxH2d/6ryMqWa+PE
         69h8cm7xpWE/u3tgNAiCaRMjyiXd01u13acWOeQfRJPYPLVVPoZ16CRWJnGhOUu5n/uy
         AvEekx1XiQHMGHLfFYHjyMbJ2RMUIpSYM6qNNrT4Ijf166qmFy1S7Vc6Oj03j1E45BUW
         oLuBrL0HrcaKmMJl56VqCecXBoygMuqGOnoUMLOtjf3cz2HzNgJEN1RD5/YTjtI/vAKQ
         cusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563764; x=1692168564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKzfX6v1CyZX2xitAs24S+KxRHnlm3GlIzocQibU/6A=;
        b=HdoEuKGM/qeyfK5jH48HrgqWsSFqnEWjk3Hi22cTiymIZwLLM+YF+C38c/feqywXy4
         jyvX5SGvF6jAw/bXDzB/1FdzE1ddF6qIM7JSpECT8sBRspirchfhN2HaB3/7KgJgqVyM
         ZteTP4CNIBv6xQFYSWUiEECrhahd6V6uEw8XlrEqfg3grMpnnhdSCswoqArVTWx2f6KV
         PkBO3faSQZlC2mzpTPFcWzFm7WoSSXfDYPqzLNJRhzgGqj26pnRzQS28tJ1BLU6GrbFy
         ZEQBrukH8HiuSPNvZ4T7qCHqm7askuOfgiT1XlLVeejYoztINwrQMTJ+pT91FuAN5PFh
         L7pg==
X-Gm-Message-State: AOJu0Yy/ZO6jM2ErNEBQ4v5g/ZASN+txbvT0zuIp6m37jYdlcCNUTEQ2
        HI8Z1OjyfVGKNhuaRXdzvOucoA/VGSyG5NrodMZ6vQ==
X-Google-Smtp-Source: AGHT+IFVZ1bXROqbeWsWc5eNe+kiQ/I4WZ7bF3U6IfafvxkePQOzsTTVY0P7niGaotDK2f3nBKfkyw==
X-Received: by 2002:a05:6a20:8412:b0:12e:f6e6:882b with SMTP id c18-20020a056a20841200b0012ef6e6882bmr2314415pzd.1.1691563763998;
        Tue, 08 Aug 2023 23:49:23 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b006833bcc95b0sm9184161pfh.115.2023.08.08.23.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:49:23 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: qcom: sc7180: Add sku_id for lazor/limozeen
Date:   Wed,  9 Aug 2023 14:49:07 +0800
Message-Id: <20230809144516.v3.2.Ia4e268a027980f00c8fb0451a29938d76b765487@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SKU ID 10: Lazor LTE+Wifi, no-esim (Strapped 0 X 0)
SKU ID 15: Limozeen LTE+Wifi, TS, no esim (Strapped 1 X 0)
SKU ID 18: Limozeen LTE+Wifi, no TS, no esim (Strapped X 0 0)

Even though the "no esim" boards are strapped differently than
ones that have an esim, the esim isn't represented in the
device tree so the same device tree can be used for LTE w/ esim
and LTE w/out esim.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 .../boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts     | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts   | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
index 913b5fc3ba76..cef57c15b70b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
-	compatible = "google,lazor-sku6", "qcom,sc7180";
+	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
index 15d77dc5f956..2038a82bc0e7 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Lazor Limozeen (rev9+)";
-	compatible = "google,lazor-sku4", "qcom,sc7180";
+	compatible = "google,lazor-sku4", "google,lazor-sku15", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
index 38027f13b9d0..438ab9cd3389 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Lazor (rev9+) with LTE";
-	compatible = "google,lazor-sku0", "qcom,sc7180";
+	compatible = "google,lazor-sku0", "google,lazor-sku10", "qcom,sc7180";
 };
 
 &ap_sar_sensor_i2c {
-- 
2.34.1

