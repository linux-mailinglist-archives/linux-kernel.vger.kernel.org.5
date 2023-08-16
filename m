Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9729177E6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbjHPQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344933AbjHPQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD519A7;
        Wed, 16 Aug 2023 09:46:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so947172166b.0;
        Wed, 16 Aug 2023 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692204407; x=1692809207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBNyxDK8Fyq1pXAd6MZ+yIoAL1WjznR7vyZJHcF2Lr0=;
        b=QOHY19PJ+01XY2ZiJsMfyq2e+VlW0VG9H3Fuejh6iobnBBH0dzrWQaFb9mJhsOYkDT
         iHhss3EZPFOunybYtp5MIixF9aqzcLaCcghlYYqf4F3wxVHXfzGZB/qXk/FtEZVt2PFV
         0pR5NF1bN0YHSLRAkI593Rn9i2tIZH0H6VCl45I+IOAi4s/0KiaGGaQQZCtmkWbEtvmz
         5NFIRFVl3VqnmwIX55t4NnF9cIIBSXDhqJo0MKJxqx5raGXAnbxIDNHbRw+YgxOC2PoS
         OBh+3e36tBiM+YUcFvOpw6WbsY2DXMM1W4C53s0gfhOiggPymqnbuOULtfP/CInPFBxY
         9aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204407; x=1692809207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBNyxDK8Fyq1pXAd6MZ+yIoAL1WjznR7vyZJHcF2Lr0=;
        b=PQHbBCz3vPM8QR5NcyfwFho53ZJPqfWMYglXcPaAuvdvfu45VQzLKgFVpjqvREEFdX
         7taG06SKhpfpS+xIKigWBKk3MgvthTtrUXcLVqltVery3zfE53a2WMO6isLUabNQ5tsx
         t8uzEDQza70Xps99W8ldNkO2C6gcQr498J/AuGSbRVgORLSDxvMCWix53gDEBloQSkyC
         kK3JW+OmaxT0wkVQuhcj50NERg6Y5KJELNYpOw5VTGkXbyeT5nsBMbc3JH01LhKwNsSx
         vpcJ05h/KxfXTO5EHu1Pb46c2pLDYVGu6KBA7t6pyul2soPyrCgbVDV6sqmEFIt/f7IB
         nh4g==
X-Gm-Message-State: AOJu0YzETYbDSRxHYbAl1NU/XPbrV+B5YENGe02gu5rHWM4FdGwKQjOV
        k2BLKbEJaXT+O6r82ieQgwML2iT32Itmvw==
X-Google-Smtp-Source: AGHT+IF1NKpyyc9qa0giS94QpZ5FYC9JU0Qu1HTtKanVq70NK0GpN78en+tF1whRK7dsWKqhrEy55Q==
X-Received: by 2002:a17:906:154d:b0:99b:d0dc:7e68 with SMTP id c13-20020a170906154d00b0099bd0dc7e68mr1904332ejd.72.1692204407109;
        Wed, 16 Aug 2023 09:46:47 -0700 (PDT)
Received: from fedora.. (dh207-98-254.xnet.hr. [88.207.98.254])
        by smtp.googlemail.com with ESMTPSA id b15-20020a170906490f00b0099c971ba285sm8697400ejq.5.2023.08.16.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:46:46 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mojha@quicinc.com
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/4] dt-bindings: firmware: qcom,scm: document IPQ5018 compatible
Date:   Wed, 16 Aug 2023 18:45:40 +0200
Message-ID: <20230816164641.3371878-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816164641.3371878-1-robimarko@gmail.com>
References: <20230816164641.3371878-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that IPQ5018 compatible was never documented in the bindings.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 590bbbd61de5..60c66cbcfd7b 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,scm-apq8064
           - qcom,scm-apq8084
           - qcom,scm-ipq4019
+          - qcom,scm-ipq5018
           - qcom,scm-ipq5332
           - qcom,scm-ipq6018
           - qcom,scm-ipq806x
-- 
2.41.0

