Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08347B623E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjJCHKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbjJCHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:10:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F46DD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:10:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40652e5718cso5701335e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317031; x=1696921831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLb8XoK4xSjjsLEStZVUx0dslR054K9qkL2umFuXmJI=;
        b=iAw2ZftUVWWv+93fWKZW8nrbN+MiECIIfXdA6iAmLbuQtiae6Uc8cYgvMOZFZLtPrD
         X/dGqFiNCKylqs1/p+DCxLZceNy+jOkjxr27ctBxfK7ywJt0zrwQNohBePZ9Djl3Bx8i
         N0+V3Rw60AN0rJjMHhoS89wvX8fGu2R/+FaD7fhvqOOF2NPktuzajp7t0tgAJ76zenn5
         pxCp80SWDa0JDpgh1b04tn85vg25tdUI6IemY1YBNxuHrBySPcmJ8fYBOUlQkGlkyJ5h
         +3hOjOftltvcz76RYlpiKs/NegypEYiNti8pvacWOIGZ0VGbALPpVqDHzew0Bpdn1D/E
         pe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696317031; x=1696921831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLb8XoK4xSjjsLEStZVUx0dslR054K9qkL2umFuXmJI=;
        b=c/3c07FIYy0/6Px1iARzSkM0RZv5z5/oenrne1NzraKGG3SRGFyXZrSeHTMkbmzPCn
         F1qz11EaxQMXizzASY9S8xtPk1Gvg3iLyOG34fFZu9cQ//sNeTaNuv1w/HTvCg6hes7u
         eLik8ZRabdvhwdUQCWR6x6U9NKwqojaHJZ8AbZmkFWquUQZTtChX0NtGOpJCsFCT6QNS
         9UT1Zup7AXvfpY4CjOjEbqgS498jTxDoJKi+j3yZU/m0V1jDC3OJq0ira7bBqvvXpcQO
         2br1jcBr3gxVfGAHkiyN8kQY+3oOehbqZjwTXegLIirhIMIpBW9NVCFPfUZDQ0kbyAfI
         mJ0A==
X-Gm-Message-State: AOJu0YweWLWObvaJkL/OXkvNjEignMWK+Hy7YWKCyTiHC7+IFt9VbXE/
        8VZo3kR2p2zw1y2+IaLusgVoHA==
X-Google-Smtp-Source: AGHT+IHurqPmTOvQyywenR4me6Rb+i5W+aB4YiRsbt4CxttjX51aKVEL8lhtgZye9Gb5Lx1RvbgloA==
X-Received: by 2002:a05:600c:1c1a:b0:406:53c0:3c71 with SMTP id j26-20020a05600c1c1a00b0040653c03c71mr11351278wms.37.1696317031207;
        Tue, 03 Oct 2023 00:10:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k2-20020a05600c1c8200b004065d72ab19sm8746652wms.0.2023.10.03.00.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:10:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 03 Oct 2023 09:10:22 +0200
Subject: [PATCH v4 4/5] arm64: dts: qcom: sm8550: add TRNG node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-topic-sm8550-rng-v4-4-255e4d0ba08e@linaro.org>
References: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
In-Reply-To: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EgwvrFMRksPbvZchOPqxaCjQZivk90KnsC77FZnwMJk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlG75gZ7bQ7XpHOKc3PJogc7Mtyyex96/6Kl3S8QgK
 2Sy2qTaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRu+YAAKCRB33NvayMhJ0R9GD/
 4p+8ciexogAPDkS7uTlwEf9YXZ2vrLOwUzBBEtos6jxzNxEckv2opMRaLR6vh4Ayr2b6PsUiZo4hcS
 8ONS5EYJFiFZN6sRiAoVRqTBELM6iEPgn3xA73aTPa2Cwg9jv2nQW72dDiCpzkqPDspf5SrZ9spIuJ
 VuVgOeUnV+TqFhMbVnwkp5W/I1BfOIn0gkSIcPw4Rl/1cFVfCnL1K54h6EiwOTeoowCckEzgpMVgvO
 j5J9NhtSrHWUFICxefvm93rSA46g/c+IeOsabCpY2Txdo4eTGZQ+++3/tgtGDVhIsHJEuwBN/byRkt
 +4DzzRoK475lOYA4NMx1F/Tg3Jvs4fOw/QkG+LTqGC/iUIZx5AXkb2DzOrkQx2s3w6CdZK8b0VIDBn
 4aHTHqs4yEJj2ahjzq6ZyN/J7q96RTld7MZDmMBj/J5qod1OhYJ0gDEk5xJiDlXtMaSbjB4b2Urk+b
 fbk6erm12zjOsZmx6sh0KxyARAJoipOoRXnLCntnevg+Mj/+bl6pSWhHMVgwlA4IgLgydlGZoib4+9
 SJLE4rh9K7Ods4Z/dL5smpUuGb7PzF0NQ6kK1rbe92ahVb5ps9NFCkhPqh/sTDYC+9iJ/+siqX+WL6
 CRn8fgVnZSackQLVmogdlfI88VocHjqueuvt7eGTuxnEAecWDOImoPReKvaw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Qualcomm True Random Number Generator node.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7b9ddde0b2c9..7bafb3d88d69 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1677,6 +1677,11 @@ mmss_noc: interconnect@1780000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		rng: rng@10c3000 {
+			compatible = "qcom,sm8550-trng", "qcom,trng";
+			reg = <0 0x010c3000 0 0x1000>;
+		};
+
 		pcie0: pci@1c00000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sm8550";

-- 
2.34.1

