Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E438786B70
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbjHXJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbjHXJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:17:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18B1BFC;
        Thu, 24 Aug 2023 02:17:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5327e5e8so406027f8f.1;
        Thu, 24 Aug 2023 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692868667; x=1693473467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09q7RDvoiIxat2c5cDkQKRvlHf2HPpY9ZqqDIN8IDyw=;
        b=H88ukWVgASsdpcgCONgvZ9IAJozlWejIujj45rRH7ZYc4W22DSpGHDkbvMK5ffuEYU
         fcr/VEUT4UUE9LVPqqabVJcPwDI+GxDSHblzndFDF6bOD1vxGV2xvgNEeqWNMsTpzGJi
         IY/QmoeP3YBG2PyTUKeJBcBWQVmte7CWrpjlmfT7Rvqmr3NaESABwyTRl1vKBZ2w6OyD
         ogcyOjqcqY7myPZHiAKvQKGxTB+BWAZs3K/2bpApQOa0TC/wTdmHB+095NVIxTLtZMe+
         ZiRZAuOFRLlGML1wjdbqq4JwSRCRErTZRjhwGB5jfPxFQa1PQGbOsr1KMArBbTcqdXzq
         sIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868667; x=1693473467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09q7RDvoiIxat2c5cDkQKRvlHf2HPpY9ZqqDIN8IDyw=;
        b=Pj+AgubInbVtCFdKrzWPiKp0msDxcJ42QMDOIDSmza0tdenxtzEygWDR7Uu9RZ6VtD
         aVlkidC+BpieaHaUGog0qv06pldoUM7Yfa9tdmI0Vn8yXdSHVOhzFM/8bF6j1seI2pOP
         2q/seHCGoFrAUbXxJ5Y+a8eUckJqsRciM7qCAwHrJUloJfKaiV48wyFpqoQqzV/qHHgF
         AyuPoFG9aoq/eMnH0Rqr4BhdI2eLnVgBXicyi48Sq0f+ri4OyirzD3Pf/kLqTSGTXgpH
         DdQr+d+fWWK8G802PgSNyH4AcAP7jR+10KlWI2ifaWJSm7BeoQ5PLRWnK28KgI/e8nNR
         sQ0g==
X-Gm-Message-State: AOJu0YxpHXyBrllJ7vItuERzBTnRwaABl87N+8GkwuSL+PU0IY4VCyXR
        FZWUGjJZ01845eTZPF08CjA=
X-Google-Smtp-Source: AGHT+IFC+6dK3vZQm5xR0Z6qdBt5ocXAtvotuQ2V5GMpgoEnCEud39gpNjrHEYiW61xFTFrtfI+03w==
X-Received: by 2002:a5d:4e8a:0:b0:318:416:a56a with SMTP id e10-20020a5d4e8a000000b003180416a56amr11179510wru.13.1692868666930;
        Thu, 24 Aug 2023 02:17:46 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ip4d167053.dynamic.kabel-deutschland.de. [77.22.112.83])
        by smtp.googlemail.com with ESMTPSA id k8-20020a7bc408000000b003fe23b10fdfsm2022214wmi.36.2023.08.24.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:17:46 -0700 (PDT)
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
Subject: [PATCH v5 0/4] Add initial support for SM7125 and Xiaomi SM7125 platform
Date:   Thu, 24 Aug 2023 11:15:03 +0200
Message-ID: <20230824091737.75813-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
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

This series introduces support for the Qualcomm SM7125 SoC and the
Xiaomi SM7125 platform.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
Changes in v2:
- Allow qcom,board-id and qcom,msm-id properties
- Use QCOM_SCM_VMID_MSS_MSA definition
- Change initial regulator modes from LPM to HPM
- Move status to the bottom of nodes
- Fix up PM6150 interrupts
- Move clk patch to beginning of series
- Fix up copyright
- Take ownership of all commits with permission
- Link to v1: https://lore.kernel.org/all/20230704163848.169853-2-davidwronek@gmail.com/

Changes in v3:
- Disable pm6150 rtc by default
- Fix wrong pm8150l PMIC in joyeuse dts
- Link to v2: https://lore.kernel.org/all/20230706124339.134272-1-davidwronek@gmail.com/

Changes in v4:
- Fix key-vol-down node name
- Link to v3: https://lore.kernel.org/all/20230715091932.161507-1-davidwronek@gmail.com/

Changes in v5:
- Rename common dtsi to sm7125-xiaomi-common
- Link to v4: https://lore.kernel.org/all/20230723190725.1619193-1-davidwronek@gmail.com/

---
David Wronek (4):
  dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
  arm64: dts: qcom: pm6150: Add resin and rtc nodes
  arm64: dts: qcom: Add SM7125 device tree
  arm64: dts: qcom: Add support for the Xiaomi SM7125 platform

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |  16 +
 .../boot/dts/qcom/sm7125-xiaomi-common.dtsi   | 423 ++++++++++++++++++
 .../boot/dts/qcom/sm7125-xiaomi-joyeuse.dts   |  16 +
 arch/arm64/boot/dts/qcom/sm7125.dtsi          |  16 +
 6 files changed, 479 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

-- 
2.42.0

