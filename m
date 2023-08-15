Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6877CDB2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbjHOOBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbjHOOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:00:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860BDD1;
        Tue, 15 Aug 2023 07:00:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe0c566788so8537724e87.0;
        Tue, 15 Aug 2023 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692108035; x=1692712835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HpL5vZ5TK3sBIkkNc1Nff9Nd8amkfnZofZ3YOp6jpc=;
        b=b9zaGkxrBEpPcKvR+VRIqgJK+Vm0P/VtpTqg1CuFCnl2LAjdF8bXqqvBgMnXuKGTzD
         p3zb6np7huhjju0qs+mm3d16tYc5pSCjtr1bZHqX8YwJhfxVtX1rmu10pYI5m1zEaQ54
         33HH8zVPBzif7R+23M6IxxbiMTXHbG4t/JUPErNMLTTUdsU2UQRh4rtV4oJiELo+b8x+
         xVJYMU2CPai81kZmWr75Hoay+aYN4RkrbY1F//QYvQFVwNxk4CRkNXToqsRRRsqpwZWP
         TdpOFRnLhpEmGYRgbMt1B+VN4crFH1zJdnWNoX9xmm8iUj0+yXTPhQjnmmEU+MSUOsGV
         bGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108035; x=1692712835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HpL5vZ5TK3sBIkkNc1Nff9Nd8amkfnZofZ3YOp6jpc=;
        b=QRJmukqwb0r0t9m4PnQAq7ADaJQCMZpkqnovTyoSHHxuBI57/jNT2gKTnY3iMMdNe2
         kLlnv9dlbdC1KMldLeAiFCEua+lrPDhU8x0lOGWdhdOvQVpxAi3DMom1buRibFvfdpzk
         fpSZ73+rw8czu0JMY9YoOrRuCWA0uYyHuRQomAeNNO24+avhbuSrIHicg1kILyBjkqND
         szzQgHxuNkBuGSELgnD85BsDqnSNAHanMSKHLW/KTUXpBYPmxhu1pI2y+kRDxiq9hpS6
         dlUNoYnYbkmZvUAOkqDnwMXPp7WeJY2wYrxhN61frM6J/TE2//6NoT2iXNwrT7azKeYC
         /qXQ==
X-Gm-Message-State: AOJu0Yxab+5piwF0vCYOuo5Gmsm70YX+cVKHhYY0H0mKMyFwuwiZR81g
        jFw0CLBoj4cUeexsppcRo1M=
X-Google-Smtp-Source: AGHT+IEk+ezPDL0N8dKyfHvugYBvOwY6+UjD1tlCJXfUzMr36l+/tByYEC5NUUTQRjZxPOlRPd/ABw==
X-Received: by 2002:a05:6512:746:b0:4fe:958:88ac with SMTP id c6-20020a056512074600b004fe095888acmr8223617lfs.6.1692108034313;
        Tue, 15 Aug 2023 07:00:34 -0700 (PDT)
Received: from fedora.. (dh207-96-14.xnet.hr. [88.207.96.14])
        by smtp.googlemail.com with ESMTPSA id a26-20020aa7d91a000000b00525740aa68dsm1049042edr.36.2023.08.15.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:00:33 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: firmware: qcom,scm: Document SDI disable
Date:   Tue, 15 Aug 2023 15:59:34 +0200
Message-ID: <20230815140030.1068590-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
means that WDT being asserted or just trying to reboot will hang the board
in the debug mode and only pulling the power and repowering will help.
Some IPQ4019 boards like Google WiFI have it enabled as well.

So, lets add a boolean property to indicate that SDI should be disabled.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 4233ea839bfc..bf753192498a 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -89,6 +89,14 @@ properties:
       protocol to handle sleeping SCM calls.
     maxItems: 1
 
+  qcom,sdi-disable:
+    description:
+      Indicates that the SDI (Secure Debug Image) has been enabled by TZ
+      by default and it needs to be disabled.
+      If not disabled WDT assertion or reboot will cause the board to hang
+      in the debug mode.
+    type: boolean
+
   qcom,dload-mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-- 
2.41.0

