Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8627175292A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjGMQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjGMQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:52:49 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218652701
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:52:48 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b5d57d7db9so763982a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689267167; x=1691859167;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/TQQu9i4zVTx/pAbl1XLa7p043pJkUqA0em0AaQVe1Q=;
        b=EOJTZVfBLXbJ+tgLJUJRaAhYQO95hGodf9yyM3ZyJmDrHCRlhC2xTABoIUd+3Cl1Yo
         XO6MFz+wN+mKMs6tq2jcRQ64XxumnSH7k9awmG8P4d7raV506yyFNuk+QzDmoxlG7chk
         Xm8c4ZN86UiZ92TA62A3E7CqOGXkzsg58hlso09jztugiWJsrZlajfgdFEImk3AudVEl
         cx4jXLpbjX+rbI6inQvzyxatK+J3NV0dtyEMl2rdalG0LM16oQKztrzu1e9wqiv4IAZx
         OywlZGqh1gyC+BOajdMLtm5QuJcdzMOffKpKItqBLM8fiPpYEPx/vCTS+0PA28sPaCRn
         hNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267167; x=1691859167;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TQQu9i4zVTx/pAbl1XLa7p043pJkUqA0em0AaQVe1Q=;
        b=DpQW36g+RNCcxjPuQ9hd/ZfM+VDmTY+VoE9qrwceyRbtw4jJFlLMegr4+d1QZZQR7f
         4Cfd3SPwdqv11cYXT1HOY5YSbobsjFAieqz7IQUywbI6HTpPPJmWVT7W10uSXMUdMRQl
         CvYyDL1nc4Le+s346ps2SwBAnHToqztyRsqgqY+x2aHW3bbvR4Dr04ZJKdyqH/4l/Ec+
         qh6ia7bvcu71l1WDlvZF4/1emgIiTeEVLsf39f6/a4QOtetpuxBSUXukbSuy+iWNkQxD
         CXMr+Lq6x3gwPenWoy3mO+923vbztdDOSVvFHBFm3fpSd7HwP+pc3JYznaV198gjQPV3
         uK1w==
X-Gm-Message-State: ABy/qLaKXO1OaB+Q/2QU+hyxkBkiZojqg7HR5uPxOVSCzEwpPrQma9IZ
        fWHiQHz/hx8yi6EByNTCDaEy+Q==
X-Google-Smtp-Source: APBJJlECN8Pkf5oJl1wriKAi9i7oMviETr74ANXnYL6u7bXmI8D7Lz2S54OFWvuw32qLmK8Qci/xoA==
X-Received: by 2002:a05:6870:c188:b0:19f:5c37:abb9 with SMTP id h8-20020a056870c18800b0019f5c37abb9mr2495348oad.12.1689267167408;
        Thu, 13 Jul 2023 09:52:47 -0700 (PDT)
Received: from x-wing.lan ([49.207.50.231])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090abf8300b002633fa95ac2sm12009150pjs.13.2023.07.13.09.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:52:46 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: display/msm: mdss-common: add memory-region property
Date:   Thu, 13 Jul 2023 22:22:37 +0530
Message-Id: <20230713165238.2814849-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Author: Amit Pundir <amit.pundir@linaro.org>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and document the reserved memory region property in the
mdss-common schema.

For now (sdm845-db845c), it points to a framebuffer memory
region reserved by the bootloader for splash screen.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
v5: Moving the dt-binding to mdss-common schema with
    updated commit message and property description.

v4: Adding this new dt-binding patch, in qcom,sdm845-mdss
    schema, in the v4 of the follow-up patch for
    sdm845-db845c.
    https://lore.kernel.org/lkml/20230712130215.666924-2-amit.pundir@linaro.org/

 .../devicetree/bindings/display/msm/mdss-common.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index ccd7d6417523..84ed2757ded5 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -77,6 +77,12 @@ properties:
     items:
       - description: MDSS_CORE reset
 
+  memory-region:
+    maxItems: 1
+    description:
+      Phandle to a node describing a reserved framebuffer memory region.
+      For example, the splash memory region set up by the bootloader.
+
 required:
   - reg
   - reg-names
-- 
2.25.1

