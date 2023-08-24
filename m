Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE45786B72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbjHXJSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbjHXJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:18:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA91FDF;
        Thu, 24 Aug 2023 02:17:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so99261311fa.1;
        Thu, 24 Aug 2023 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692868670; x=1693473470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR+D2sqMOmzG+r9C8IaAfmIZBBjuwD9uagZHPjWzkMY=;
        b=ASuz/dGu561wbPbeUpHA7JtTE8U5D+iF8hA9+Ajsk0kwvXOR1WkbxQmrU0f0pE5EiV
         M9geHWFylHLIUFwoQ7ECYP0ExMHH7gp3wPOC95Z61aUj9diowx2RWcFawF5rbMhd58sl
         Q45FV0/wO1AQXsOvrh6u7+MZxX89G+lEGzVqpsBdoOnZiaZjXegWggs/n+qjV9p0ZgDL
         3c/Xy5UzcHLbPsASi5NFLpIDp2LkliVLkssFIxqToac1kzIyubLhuLLrhEozkK6bGjEG
         zXoxsgFXRVOV/1GDiGbU9JwE9gi+IMQoVm8G76jpGnJo8djfI1kD/9srZdW9SLfXclo4
         jufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868670; x=1693473470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uR+D2sqMOmzG+r9C8IaAfmIZBBjuwD9uagZHPjWzkMY=;
        b=KvkoGv+iMSbVA4cyTpi754qtZbkn+9zvMsviQ5pi+kjsq/2YF6LoktcfXp5emcTWlG
         z5wFCSqgKOnItdaR1SRY82bPFb7MGtlCfI0hikb09FtRyuVcQacBSqoGpwNRqARmnwAS
         GJTJNmROYI8i1qWdlSnbzFJ7N5yww1WMmetP5bWs0PCnwGWVGASlWTJOyzcQ/JSqka+W
         zjS9bYc4+aUbNi78H4qBaixEB9gFC1rjrl0gwpruElixE3OUla/jlImdIWw/cNYohDvn
         xIwHA1JW3pBuqQEeOaJI8TNS69MwUyJB4EuM78QzmgUnQetWscxPfvKr695p2+P1DAJK
         z3lA==
X-Gm-Message-State: AOJu0Yxaaqmmv32SzajGk7XJp80FZX2UYjggRcgiQoJEYTRzhTRhKiFQ
        HpGPsITryB0DvLZqxI5ICeglJAVtG9aDXxql
X-Google-Smtp-Source: AGHT+IEYgEQiy/DrfOZzypBcYm2u+wifZxyZzo7+Jvdle2zlPnI3N+PMTGgfIWKzrSVAkcH3O+24Vg==
X-Received: by 2002:a2e:83cf:0:b0:2bb:b1da:27be with SMTP id s15-20020a2e83cf000000b002bbb1da27bemr9834591ljh.45.1692868669800;
        Thu, 24 Aug 2023 02:17:49 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ip4d167053.dynamic.kabel-deutschland.de. [77.22.112.83])
        by smtp.googlemail.com with ESMTPSA id k8-20020a7bc408000000b003fe23b10fdfsm2022214wmi.36.2023.08.24.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:17:49 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v5 3/4] arm64: dts: qcom: Add SM7125 device tree
Date:   Thu, 24 Aug 2023 11:15:06 +0200
Message-ID: <20230824091737.75813-4-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824091737.75813-1-davidwronek@gmail.com>
References: <20230824091737.75813-1-davidwronek@gmail.com>
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

The Snapdragon 720G (sm7125) is software-wise very similar to the
Snapdragon 7c with minor differences in clock speeds and as added here,
it uses the Kryo 465 instead of Kryo 468.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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
2.42.0

