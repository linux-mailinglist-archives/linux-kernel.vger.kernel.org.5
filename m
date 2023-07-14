Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276875412C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjGNRsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbjGNRrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:55 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191C13AB7;
        Fri, 14 Jul 2023 10:47:36 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7835ae70e46so89106739f.3;
        Fri, 14 Jul 2023 10:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356821; x=1691948821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrS2k1UCIIMJ4emgSWk6h2fOgFxn4zWpWzOE6zZPTSk=;
        b=CRbWkOxLo01XLL20JM8fbTo3jHbfTXyfBZqEIC8CF1slXfSCT9zPGvM90E1hfBo1wS
         YyCrdGQM/f20rMAnQ3KEf9RNXh2mjDCuaXqOtp0okfiYwLHsUCYofPp/l9CPQOQetfey
         Cyq3KDizq7mNGBcAWG2Ll0F/Xtaj0fWSCmt/9kO16kQV4fhWaGotMl5FnrDGI4AWWxSp
         0zOwvutdyVWVPKAA1dmxW/Ech6Bsxr3ZIIVkyHfooXBX4TLTQwnlVcToFSzAGFeNUBfP
         PDLbYdSgUAejN+zjhw00wIA7QW8qgcLXR1TQ1a6Y7wp9Cp8k7bYgRQRxgJj+qzd4a3J9
         jTlA==
X-Gm-Message-State: ABy/qLZYdqGx69DbeQ9Len52pu4tjvwqrc6eJOP51hnK9iO7nnXR5azX
        BUMXKmB+Bk44xivCQkdP9g==
X-Google-Smtp-Source: APBJJlHNSXAZg4PXiZD/+bR1XmGZn6D0Df2QfoHAVDa/88JS4Gk1XWrziOYhPcc7CZj6LMKEwiAmJQ==
X-Received: by 2002:a92:cd47:0:b0:345:d284:5c49 with SMTP id v7-20020a92cd47000000b00345d2845c49mr4442240ilq.5.1689356820691;
        Fri, 14 Jul 2023 10:47:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p2-20020a92d282000000b00345b34fcf34sm2847967ilp.38.2023.07.14.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:47:00 -0700 (PDT)
Received: (nullmailer pid 4058361 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] interconnect: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:36 -0600
Message-Id: <20230714174638.4058268-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/interconnect/imx/imx8mp.c    | 1 -
 drivers/interconnect/qcom/icc-rpm.c  | 2 +-
 drivers/interconnect/qcom/icc-rpmh.c | 2 +-
 drivers/interconnect/qcom/msm8916.c  | 2 +-
 drivers/interconnect/qcom/msm8939.c  | 2 +-
 drivers/interconnect/qcom/msm8974.c  | 3 +--
 drivers/interconnect/qcom/msm8996.c  | 3 +--
 drivers/interconnect/qcom/osm-l3.c   | 2 +-
 drivers/interconnect/qcom/qcm2290.c  | 3 +--
 drivers/interconnect/qcom/qcs404.c   | 2 +-
 drivers/interconnect/qcom/qdu1000.c  | 3 ++-
 drivers/interconnect/qcom/sa8775p.c  | 3 ++-
 drivers/interconnect/qcom/sc7180.c   | 3 ++-
 drivers/interconnect/qcom/sc7280.c   | 3 ++-
 drivers/interconnect/qcom/sc8180x.c  | 3 ++-
 drivers/interconnect/qcom/sc8280xp.c | 3 ++-
 drivers/interconnect/qcom/sdm660.c   | 3 +--
 drivers/interconnect/qcom/sdm670.c   | 3 ++-
 drivers/interconnect/qcom/sdm845.c   | 3 ++-
 drivers/interconnect/qcom/sdx55.c    | 3 ++-
 drivers/interconnect/qcom/sdx65.c    | 3 ++-
 drivers/interconnect/qcom/sm6350.c   | 3 ++-
 drivers/interconnect/qcom/sm8150.c   | 3 ++-
 drivers/interconnect/qcom/sm8250.c   | 3 ++-
 drivers/interconnect/qcom/sm8350.c   | 3 ++-
 drivers/interconnect/qcom/sm8450.c   | 4 +++-
 drivers/interconnect/qcom/sm8550.c   | 4 +++-
 drivers/interconnect/qcom/smd-rpm.c  | 2 --
 28 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/interconnect/imx/imx8mp.c b/drivers/interconnect/imx/imx8mp.c
index 8bfaf173f1da..a66ae3638b18 100644
--- a/drivers/interconnect/imx/imx8mp.c
+++ b/drivers/interconnect/imx/imx8mp.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/interconnect/fsl,imx8mp.h>
 
diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 6acc7686ed38..c538661d96dc 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -8,7 +8,7 @@
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index fdb5e58e408b..8053ec8ab01b 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -7,7 +7,7 @@
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/slab.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 5c4ba2f37c8e..25259d7d8a3e 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -9,9 +9,9 @@
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/of_device.h>
 
 #include <dt-bindings/interconnect/qcom,msm8916.h>
 
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index caf0aefad668..fc84ad271aee 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -10,9 +10,9 @@
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/of_device.h>
 
 #include <dt-bindings/interconnect/qcom,msm8939.h>
 
diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 1828deaca443..5df05e7e4d21 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -33,8 +33,7 @@
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 20340fb62fe6..38101b63a80a 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -9,9 +9,8 @@
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index a1f4f918b911..056ac91225c4 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index a29cdb4fac03..a6a99f8e7573 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -11,9 +11,8 @@
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index fae155344332..2ec7ff57b578 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -9,8 +9,8 @@
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
 
 
 #include "smd-rpm.h"
diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index a4cf559de2b0..bf800dd7d4ba 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -7,8 +7,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index da21cc31a580..97014d0c5844 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -7,8 +7,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index ef4e13fb4983..d16298e77906 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -7,8 +7,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sc7180.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 971f538bc98a..6592839b4d94 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -7,8 +7,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index c76e3a6a98cd..0fb4898dabcf 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -7,7 +7,8 @@
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/interconnect/qcom,sc8180x.h>
 
diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index e56df893ec3e..b82c5493cbb5 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -7,8 +7,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sc8280xp.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 7ffaf70d62d3..1e3769975a05 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -9,9 +9,8 @@
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index bda955035518..29128a9b63ae 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -6,8 +6,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sdm670-rpmh.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 954e7bd13fc4..b6e76cb43b0d 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -7,7 +7,8 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/interconnect/qcom,sdm845.h>
 
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 130a828c3873..cf4cde512613 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -10,8 +10,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sdx55.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index b16d31d53e9b..f42392d505dd 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -6,8 +6,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sdx65.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index a3d46e59444e..15c647c0e987 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -6,8 +6,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sm6350.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index c5ab29322164..7fd19721e458 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -7,8 +7,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sm8150.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index e3bb008cb219..069fb463d008 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -7,8 +7,9 @@
 #include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sm8250.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 5398e7c8d826..0e02e1800e0c 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -7,7 +7,8 @@
 
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <dt-bindings/interconnect/qcom,sm8350.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 2d7a8e7b85ec..8981f423a48a 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -8,7 +8,9 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <dt-bindings/interconnect/qcom,sm8450.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index d823ba988ef6..cd2cbc1f9da2 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -10,7 +10,9 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
 
 #include "bcm-voter.h"
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index dc8ff8d133a9..63bf38e7cf8d 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -8,8 +8,6 @@
 
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
-- 
2.40.1

