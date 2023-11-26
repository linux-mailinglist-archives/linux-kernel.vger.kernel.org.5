Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE927F90F2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 03:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjKZC2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 21:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKZC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 21:28:53 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A18FE;
        Sat, 25 Nov 2023 18:29:00 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso2139339b3a.0;
        Sat, 25 Nov 2023 18:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700965740; x=1701570540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hG3ipdLv3/wO1bTYNyUfdq//qPItjs43V53NHywBAQ8=;
        b=UyPRp5Rdp75ikpmdRdG1CawhfArNkj3B/ETWBSNXR3fEgTad9d1XPDcqs/ZrEiWbmN
         Sz9kKlqRV79u/GDi1bJaTP/KvGoIybbb4a4om4f5q4/5XfhebXcLa+vhWvFw7bxamZI8
         oh7Tj0lEwCN5MqKvYYZtBS1uRIlJPDysDmDrkTX2j4k4ET4ugvKwXcj2CWRp+pIWI3WC
         YV2KmQPXiWUmyqAD77oEMzQOG6KYa4xse+c6uUV2iKQBGG69sulPjXdFpossTxpF1Wvz
         SkVmcUiw7Wm3lYMv6EtjedpVoJhdUxS2D71jO77vYZlz39kMS141mbbBOq/oncnOtEcI
         3NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700965740; x=1701570540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hG3ipdLv3/wO1bTYNyUfdq//qPItjs43V53NHywBAQ8=;
        b=J2fbWIZEyixmkqM8vUi7wLZQmHNJulTuRAcTz7gF2KADzkvjxGjDIPshvzjPEFl3Vl
         8O9NVA/YYeLqBgXNTjFMuarNcJqO+KHrlIa3qA0EfA4ZciWfcrfopqsXjuKLKFoB05/E
         T0Pr+xxXSaQeMFQT8Y6SkcMq2fZriDc2zAn2StE6WzdjAgB6au7HwILoCtah1MC1wUvB
         WuxHL7nf7aRvjvnURQALWFRo92inTlJVdrI60rDBDescbKQtf/UQs2BgW1hGtSgicSk2
         4moaWzelF3yeUW5vAt2OcIpV9bHT+neZ/d9l1Au8t+8E7iBIeNJIeYogiO/q7lOR497o
         D/SA==
X-Gm-Message-State: AOJu0YxArkVcX8w+dLXoamEVvAETM96ugxfVXLG2hstcIAMgzCGRpCNc
        nUG1wUIiEwiwW0cHTLvCjIM=
X-Google-Smtp-Source: AGHT+IH2DY6zKNFVPQuWjOOZ1g52/xBEPT/okDXOij5i1dggz1QYAjb9c1rJKtoP32Yj3jzLO1IqIQ==
X-Received: by 2002:a05:6a00:14c8:b0:68f:c078:b0c9 with SMTP id w8-20020a056a0014c800b0068fc078b0c9mr10404207pfu.11.1700965739582;
        Sat, 25 Nov 2023 18:28:59 -0800 (PST)
Received: from localhost.localdomain ([192.166.114.90])
        by smtp.gmail.com with ESMTPSA id x18-20020aa793b2000000b00688435a9915sm4961821pff.189.2023.11.25.18.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 18:28:58 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: sm8250-xiaomi-elish: Fix typos
Date:   Sun, 26 Nov 2023 10:28:48 +0800
Message-ID: <20231126022849.14273-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two typos in this dtsi, so fix it.
  classis -> chassis.
  80700000 -> 80600000

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
No Changes in v3.

No Changes in v2.

 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 85e5cf3dc91e..3d4ea428e4cb 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -23,7 +23,7 @@
 /delete-node/ &xbl_aop_mem;
 
 / {
-	classis-type = "tablet";
+	chassis-type = "tablet";
 
 	/* required for bootloader to select correct board */
 	qcom,msm-id = <QCOM_ID_SM8250 0x20001>; /* SM8250 v2.1 */
@@ -114,7 +114,7 @@ vreg_s6c_0p88: smpc6-regulator {
 	};
 
 	reserved-memory {
-		xbl_aop_mem: xbl-aop@80700000 {
+		xbl_aop_mem: xbl-aop@80600000 {
 			reg = <0x0 0x80600000 0x0 0x260000>;
 			no-map;
 		};
-- 
2.41.0

