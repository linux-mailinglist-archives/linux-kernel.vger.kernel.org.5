Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE81179A479
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjIKH3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjIKH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:29:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF8CE7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:28:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31f8a05aa24so1852220f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694417329; x=1695022129; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmXkMp6hw0QC2PD82S58qjMraTAHY6wvd7XAvr7oIME=;
        b=ScwxB9W0+9s2HPsreo03gPo1g+DtkqchySy+iaAt1TUs0DYTzzuZDX5+kV6RkmtGCq
         3NZXzDT23l8+yaL1WTgQVLthy+OZu4ZlRnHEMkuftRsvHUs+k5Bof9ls4lqcjckP/5tj
         M8BpNFZWBdkb5RO8Rx1t3Q8tlk0Un5vg+w3aBuwhJp3XJrSjH944eR/iqBjlscQca9rR
         K+yQluzs9DLjrhwmTNYAsNFaCRtWvXyMtwePwWhXRB0o4G3emDgpYiGO/QoTDBFv80+y
         wJofrybBpRAHS9eEkY+uTt/DXwccr4yFRPNy0go8NQ56XHnFKi+D56DGf6effEg1hVEg
         dFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694417329; x=1695022129;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmXkMp6hw0QC2PD82S58qjMraTAHY6wvd7XAvr7oIME=;
        b=l5Mt7QRRb/qOxRxFYrO3wvPUPe7du0eaCBDv/1es+/jzjV5ph7dxOZ1xmQJqC8Gcql
         DveFAh4WuNnPRRPJ1QLmPjr2jhRtu6cTxr8nayMwTRPiejqz3gTMNO07/Zn2RPiTRVq0
         0Ttv/eFxlQfSLyWI1oTbJaIlZDnrSjJu8W/5uOVfpTxz5i2b6gxIvtrT3eMyUAcBCWc5
         YLBcsLHsMTk3iJidJSpaVPiLYr6MPUIJ3BYJ8CttVW1r4dPh/CJGjho9YDkMAvjIFyay
         2ZQ7zeqrJfHvvDR8MDpyXibQtQ2nyfVPnI+4/yvJ9SJDB2s3G6DgL87LxHqNWk28VxbR
         0h4g==
X-Gm-Message-State: AOJu0YzulRF7aBdomz9+GcAzeDykOnfUkgQCxgXXmBrrfj7AT1xiIyhU
        nISlxkYalDbLWioWNYGtI77v+g==
X-Google-Smtp-Source: AGHT+IGWydEDfDezZCLFZgH18TY3egwhgA/nekWbF8CK6gOEc9NcN4f+7z/37bdHz8l+sMVy5Jx9dg==
X-Received: by 2002:adf:ea4b:0:b0:313:f61c:42ab with SMTP id j11-20020adfea4b000000b00313f61c42abmr7610606wrn.56.1694417329295;
        Mon, 11 Sep 2023 00:28:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c17-20020adfed91000000b0031779a6b451sm9250075wro.83.2023.09.11.00.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 00:28:48 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/2] arm64: dts: qcom: enable BT on SM8550-QRD
Date:   Mon, 11 Sep 2023 09:28:45 +0200
Message-Id: <20230911-topic-sm8550-upstream-bt-v4-0-a5a428c77418@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK3B/mQC/43N0QrCIBgF4FcJr/tD/d1mXfUe0YU6bcLSoWsUs
 XfP7SYiiC7PgfOdJ8k2eZvJYfMkyU4++xhKENsNMZ0KFwu+LZlwypHWnMIYB28gX2VVUbgNeUx
 WXUGP0DojkFZub5ggZa5VtqCTCqYrQLj1fSmHZJ2/r3+nc8mdz2NMj/V+Ykv7x9PEgIJouKxq4
 aRs+LH3QaW4i+lCFnXi/0q8SHupKRXYIlPiS8K3JFnzQ8IiITqUtW20qNmHNM/zCzECdpNqAQA
 A
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=V/4/cFdhF3GcYL6PArpmmPN8+yWVbJ7rwyA4ouLJKDA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk/sGvvff9SSvbi4K1qObxVakganz1EIpk1EITADmb
 iYHG2XeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZP7BrwAKCRB33NvayMhJ0QsQEA
 CUTtzrU9/caBMK6+Y7PldmUh0OgYa7lLaUU9Ak6yLYKRUoNAQYC0YNuXVhKZexF6boZuEYAZ0TGDSM
 +D5x4tdz+/YXTTE8Z9VOMkB+bhkoyAEJVv23j3qxlxA/RdChIWON5mZykcDX3Oj6PTHoZymtJSogco
 HYccQRfF0po9Uy4QMAGGdV3tVysa7uGMPXfwRkqCUzM66k8geXm0bgx+SS8XJdef9KE0uirmKGgc7D
 OrwPjqLuXLfMhnudX3DR9k7tsvvv4KCSyEb9Oef25jXXfUxGjm2cf0XpEAzUN5zpesmDR9qwWud0cE
 np/kvwEiVZum0O3UX2QVODxf9BJAP839/hFLM57wa2We75n4Vm4eQPubfORhefJCg8/S8ziY9+6pbV
 DD0AjPFOs3UsN4FsuA/DugtA/1kUJ5D0WhE3ZdiwmybnbR0MhqSA2Ii/wFUJlmTw4fxGeL9n+Vi56g
 j4c04BIc2SGYKscvI1OdaWoXInJAMLDLSt+ENpgsU1Fr5MfQ9r2ReCBEis5hHlQMKzMKeR+kt6KwWI
 IAU+R0wyAT3wygvwWCCpoNj58G4tZgx2je2H2Vv+n9ZJjDuSL0Dbw5euOO9+z8cw53Nb1Ch2OGjK2Y
 pszlUv9G5X2VsosMxAO2pxt84hSrs3Z49Y22KuMmKDS9xxL6hz5Xrii8T6lw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie enables WCN7850 on the Qualcomm SM8550 QRD
reference platform.

The WCN7850 is close to the WCN6855 but uses different
firmware names.

This patchset is the followup of https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org
with only the DT patches.

---
Changes in v4:
- Added review tags
- Rebased on v6.6-rc1
- Link to v3: https://lore.kernel.org/r/20230817-topic-sm8550-upstream-bt-v3-0-33f386e7b461@linaro.org

Changes in v3:
- Dropped applied BT patches, on DT patches remains
- Link to v2: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org

Changes in v2:
- Convert if/else and qca_is_*() macros by switch/case to simplify adding now BT SoCs
- Add bindings reviewed-by
- Link to v1: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org

---
Neil Armstrong (2):
      arm64: dts: qcom: sm8550: add UART14 nodes
      arm64: dts: qcom: sm8550-qrd: add bluetooth support

 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 43 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 30 +++++++++++++++++++++++
 2 files changed, 73 insertions(+)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230620-topic-sm8550-upstream-bt-dfc4305f9c14

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

