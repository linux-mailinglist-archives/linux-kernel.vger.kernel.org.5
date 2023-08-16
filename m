Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B09277E899
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbjHPSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345469AbjHPSXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:23:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2F31FC8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:23:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf0b24d925so1433055ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692210180; x=1692814980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUX8EWH6XxBZ1I7CUpBjWN2BsINd0XvA+M8q/m5Tcq4=;
        b=nxQDmsxYGQgt1pmspKwGen/8ySUvxdoei03W+P9hu1VNfDVnmpS+3LZ6QZEZk4JtL/
         Gps2M1PdGBga1TDofqF+Jf7DEbMhX1pqc5/V3q75u2eDyIfmmLTLSk9xWPlWPSahtC+Y
         UfdOO/QKwRG7PiHU8qJ859Pv3XhlxHzF79YxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692210180; x=1692814980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUX8EWH6XxBZ1I7CUpBjWN2BsINd0XvA+M8q/m5Tcq4=;
        b=ktYZGU4xdriD5oMv1CWsXWoV3T1SH5s9OHtKDxJEHvizaIwEBU3x0mWmm16PUCAGtk
         xPXamPzT/7q5fRWlSbJHVJPmc8HOUUN8guShH0/J8qbM/ytKqiTI8JPOsXNI6vSj/4mx
         Lm5Xlgch5Jyv5NSt5iLUta1WoiDXLcRAjgktRE+TO4/x/1i7QXa/WwCEIHGbnvevrkmM
         f65fZtopD6pPx8QC1yQy1EpaLYaD4/94N7VO2s+2RZdAvOEV9p0tH8/Kc1izJVDEPcLl
         q8xDaEj+37Jgqaf3agRZFTiYiajSxlGd1ygnv4lk4A/tAOnA+tHqyO0ywKlGUeEeu8i7
         RkXg==
X-Gm-Message-State: AOJu0Ywk8HeRsnikGBhU+MBt/mmJ8FAkbTUZknMItIeNHYeD0NROQ9Kz
        1p8FutQlV/xR8D6wpzHKpbZgQA==
X-Google-Smtp-Source: AGHT+IHDlries/+2hFLGANqXdR6jK+AX2VcRvKX9MNLKxY6glARprxeWkg9KRmNfMSh50GH3a4BlQA==
X-Received: by 2002:a17:902:9b88:b0:1bb:ee1b:3cdf with SMTP id y8-20020a1709029b8800b001bbee1b3cdfmr2389094plp.67.1692210179792;
        Wed, 16 Aug 2023 11:22:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:d195:f984:f71b:ed07])
        by smtp.gmail.com with ESMTPSA id x18-20020a1709027c1200b001b9ff5aa2e7sm13440155pll.239.2023.08.16.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 11:22:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sc7180: Reorganize trogdor rt5682 audio codec dts
Date:   Wed, 16 Aug 2023 11:21:54 -0700
Message-ID: <20230816112143.2.I29a5a330b6994afca81871f74bbacaf55b155937@changeid>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
References: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was asserted that the "/delete-property/ VBAT-supply;" that we
needed to do in the rt5682s dts fragment was ugly. Let's change up all
the trogdor device trees to make it explicit which version of "rt5682"
we have and avoid the need for the "delete-property".

As a side effect, this nicely gets rid of the need for a delete-node
in coachz, which doesn't use "rt5682" at all.

A few notes:
- This doesn't get rid of every "/delete-node/" in trogdor, just the
  one that was used for rt5682s.
- Though we no longer have any "/delete-node/", we do still override
  the "model" in the "sound" node in one case (in pompom) since that
  uses the "2mic" sound setup.

This is validated to produce the same result (other than a few
properties being reordered) when taking the dtbs generated by the
kernel build and then doing:

  for dtb in *trogdor*.dtb; do
    dtc -I dtb -O dts $dtb -o out/$dtb.dts;
  done

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'm pretty on the fence about this change. I wrote it up at
Krzysztof's request. While I don't hate it, I'm not convinced that
this is truly more understandable and it does cause a bit of extra
duplication. Happy to let others/Bjorn decide.

 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  1 -
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  2 +
 .../sc7180-trogdor-lazor-limozeen-nots-r5.dts |  1 +
 .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  1 +
 .../qcom/sc7180-trogdor-lazor-limozeen-r4.dts |  2 +
 .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts |  1 +
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts |  1 +
 .../dts/qcom/sc7180-trogdor-lazor-r3-kb.dts   |  1 +
 .../dts/qcom/sc7180-trogdor-lazor-r3-lte.dts  |  1 +
 .../boot/dts/qcom/sc7180-trogdor-lazor-r3.dts |  1 +
 .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  1 +
 .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  1 +
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  1 +
 .../sc7180-trogdor-pazquel-lte-parade.dts     |  1 +
 .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  1 +
 .../qcom/sc7180-trogdor-pazquel-parade.dts    |  1 +
 .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  1 +
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  1 +
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |  1 +
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  1 +
 .../dts/qcom/sc7180-trogdor-rt5682i-sku.dtsi  | 38 +++++++++++++++++++
 .../dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi  | 33 +++++++++++++---
 ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts | 12 +++++-
 .../sc7180-trogdor-wormdingler-rev1-boe.dts   |  1 +
 ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  6 ++-
 .../sc7180-trogdor-wormdingler-rev1-inx.dts   |  1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 27 -------------
 27 files changed, 104 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682i-sku.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index a532cc4aac47..53f2b093bd40 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -10,7 +10,6 @@
 
 /* Deleted nodes from sc7180-trogdor.dtsi */
 
-/delete-node/ &alc5682;
 /delete-node/ &pp3300_codec;
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index b27dcd2ec856..ab51c3a930e1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -7,6 +7,8 @@
 
 /* This file must be included after sc7180-trogdor.dtsi */
 
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
+
 / {
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts
index 7f01573b5543..e7da0d6e8ef5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts
@@ -11,6 +11,7 @@
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Lazor Limozeen without Touchscreen (rev5 - rev8)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
index 913b5fc3ba76..400f9e18977f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
@@ -11,6 +11,7 @@
 #include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts
index d42dcd421146..8a24812b9a00 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts
@@ -11,6 +11,8 @@
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
+
 
 / {
 	model = "Google Lazor Limozeen (rev4 - rev8)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
index 15d77dc5f956..09a4ff13f072 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
@@ -11,6 +11,7 @@
 #include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Lazor Limozeen (rev9+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index 80c7108bc51b..b60060a38426 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -10,6 +10,7 @@
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Lazor (rev1 - 2)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
index 6ff81c1f7c44..3459b81c5628 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
@@ -10,6 +10,7 @@
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 #include "sc7180-lite.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
index e58e36e35950..ff8f47da109d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
@@ -11,6 +11,7 @@
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Lazor (rev3 - 8) with LTE";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
index 76c83f88cb41..dd8f6d95655e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
@@ -10,6 +10,7 @@
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 #include "sc7180-lite.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
index 960f7b7ce094..1c4f0773a242 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
@@ -10,6 +10,7 @@
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 #include "sc7180-lite.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
index 38027f13b9d0..ec73943abc4c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
@@ -11,6 +11,7 @@
 #include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Lazor (rev9+) with LTE";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
index 56dd222650d3..6cedc0ba9653 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
@@ -10,6 +10,7 @@
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 #include "sc7180-lite.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
index 767cb7450c0d..1c3d9f1381ca 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
@@ -11,6 +11,7 @@
 #include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-pazquel.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Pazquel (Parade,LTE)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
index 9145b74e9009..bf170471b00c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
@@ -11,6 +11,7 @@
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-pazquel.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Pazquel (TI,LTE)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
index 9a0e6632a786..60ae129b83c9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
@@ -10,6 +10,7 @@
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-pazquel.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Pazquel (Parade)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
index 47c5970d8c22..31678a98ce2c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
@@ -10,6 +10,7 @@
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-pazquel.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Pazquel (TI)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index fd944842dd6c..8a1e267b3d8e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -8,6 +8,7 @@
 #include "sc7180-trogdor.dtsi"
 /* Must come after sc7180-trogdor.dtsi to modify cros_ec */
 #include <arm/cros-ec-keyboard.dtsi>
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 62ab6427dd65..23c1c81900e8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 /* This board only has 1 USB Type-C port. */
 /delete-node/ &usb_c1;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 671b3691f1bb..c9667751a990 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -10,6 +10,7 @@
 #include "sc7180-trogdor.dtsi"
 /* Must come after sc7180-trogdor.dtsi to modify cros_ec */
 #include <arm/cros-ec-keyboard.dtsi>
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 #include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682i-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682i-sku.dtsi
new file mode 100644
index 000000000000..26f2f5de489c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682i-sku.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Trogdor dts fragment for SKUs with rt5682i
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+&hp_i2c {
+	alc5682: codec@1a {
+		compatible = "realtek,rt5682i";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_irq>;
+
+		#sound-dai-cells = <1>;
+
+		interrupt-parent = <&tlmm>;
+		/*
+		 * This will get ignored because the interrupt type
+		 * is set in rt5682.c.
+		 */
+		interrupts = <28 IRQ_TYPE_EDGE_BOTH>;
+
+		AVDD-supply = <&pp1800_alc5682>;
+		DBVDD-supply = <&pp1800_alc5682>;
+		LDO1-IN-supply = <&pp1800_alc5682>;
+		MICVDD-supply = <&pp3300_codec>;
+		VBAT-supply = <&pp3300_audio>;
+
+		realtek,dmic1-data-pin = <1>;
+		realtek,dmic1-clk-pin = <1>;
+		realtek,jd-src = <1>;
+	};
+};
+
+&sound {
+	model = "sc7180-rt5682-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi
index 66b8773309d4..ea036a73f875 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi
@@ -1,15 +1,36 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Google Trogdor dts fragment for SKUs with
+ * Google Trogdor dts fragment for SKUs with rt5682s
  *
  * Copyright 2023 Google LLC.
  */
 
-&alc5682 {
-	compatible = "realtek,rt5682s";
-	/delete-property/ VBAT-supply;
-	realtek,dmic1-clk-pin = <2>;
-	realtek,dmic-clk-rate-hz = <2048000>;
+&hp_i2c {
+	alc5682: codec@1a {
+		compatible = "realtek,rt5682s";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_irq>;
+
+		#sound-dai-cells = <1>;
+
+		interrupt-parent = <&tlmm>;
+		/*
+		 * This will get ignored because the interrupt type
+		 * is set in rt5682.c.
+		 */
+		interrupts = <28 IRQ_TYPE_EDGE_BOTH>;
+
+		AVDD-supply = <&pp1800_alc5682>;
+		DBVDD-supply = <&pp1800_alc5682>;
+		LDO1-IN-supply = <&pp1800_alc5682>;
+		MICVDD-supply = <&pp3300_codec>;
+
+		realtek,dmic1-data-pin = <1>;
+		realtek,dmic1-clk-pin = <2>;
+		realtek,dmic-clk-rate-hz = <2048000>;
+		realtek,jd-src = <1>;
+	};
 };
 
 &sound {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
index 842f07f16ed1..116f79c25a5d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
@@ -10,10 +10,20 @@
 
 /dts-v1/;
 
-#include "sc7180-trogdor-wormdingler-rev1-boe.dts"
+#include "sc7180-trogdor-wormdingler.dtsi"
 #include "sc7180-trogdor-rt5682s-sku.dtsi"
 
 / {
 	model = "Google Wormdingler rev1+ (BOE, rt5682s)";
 	compatible = "google,wormdingler-sku1025", "qcom,sc7180";
 };
+
+&mdss_dsi0_phy {
+	qcom,phy-rescode-offset-top = /bits/ 8 <31 31 31 31 (-32)>;
+	qcom,phy-rescode-offset-bot = /bits/ 8 <31 31 31 31 (-32)>;
+	qcom,phy-drive-ldo-level = <450>;
+};
+
+&panel {
+	compatible = "boe,tv110c9m-ll3";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
index 6eeead70d3eb..72627760e2a4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 
 #include "sc7180-trogdor-wormdingler.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Wormdingler rev1+ BOE panel board";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
index 084870323606..0bf355e08f78 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
@@ -10,10 +10,14 @@
 
 /dts-v1/;
 
-#include "sc7180-trogdor-wormdingler-rev1-inx.dts"
+#include "sc7180-trogdor-wormdingler.dtsi"
 #include "sc7180-trogdor-rt5682s-sku.dtsi"
 
 / {
 	model = "Google Wormdingler rev1+ (INX, rt5682s)";
 	compatible = "google,wormdingler-sku1", "qcom,sc7180";
 };
+
+&panel {
+	compatible = "innolux,hj110iz-01a";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
index dd34a2297ea0..4b165b826ab3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 
 #include "sc7180-trogdor-wormdingler.dtsi"
+#include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
 	model = "Google Wormdingler rev1+ INX panel board";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 5a33e16a8b67..46aaeba28604 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -372,7 +372,6 @@ keyboard_backlight: led-0 {
 
 	sound: sound {
 		compatible = "google,sc7180-trogdor";
-		model = "sc7180-rt5682-max98357a-1mic";
 
 		audio-routing =
 			"Headphone Jack", "HPOL",
@@ -747,32 +746,6 @@ trackpad: trackpad@15 {
 hp_i2c: &i2c9 {
 	status = "okay";
 	clock-frequency = <400000>;
-
-	alc5682: codec@1a {
-		compatible = "realtek,rt5682i";
-		reg = <0x1a>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hp_irq>;
-
-		#sound-dai-cells = <1>;
-
-		interrupt-parent = <&tlmm>;
-		/*
-		 * This will get ignored because the interrupt type
-		 * is set in rt5682.c.
-		 */
-		interrupts = <28 IRQ_TYPE_EDGE_BOTH>;
-
-		AVDD-supply = <&pp1800_alc5682>;
-		DBVDD-supply = <&pp1800_alc5682>;
-		LDO1-IN-supply = <&pp1800_alc5682>;
-		MICVDD-supply = <&pp3300_codec>;
-		VBAT-supply = <&pp3300_audio>;
-
-		realtek,dmic1-data-pin = <1>;
-		realtek,dmic1-clk-pin = <1>;
-		realtek,jd-src = <1>;
-	};
 };
 
 &lpasscc {
-- 
2.41.0.694.ge786442a9b-goog

