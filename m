Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33847547C5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGOJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGOJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:20:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B013AB3;
        Sat, 15 Jul 2023 02:20:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so27313735e9.2;
        Sat, 15 Jul 2023 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412800; x=1692004800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtItNqjBVn5PI+StR7IJKfR6iwBSQjGA7AnuIe8qRq0=;
        b=siCyPYvpFnYxVs/6cfKs4mW/x6v8Po/m38KkjHn8LW3O5h4I+RemL/52fqK0YxCnh4
         Si4q7ak74BLTV2KhRdHswNdQnMZvKAOnbuR+DcDraOnaeT2DG1hd/XcRI/P2TM72xz3m
         G0RRaWkhUH4AAoKLuRpAJP+3hN/4WuHxnovoFM0+rVKKK25tyTAc5+gWM6Yz0M9jSgXP
         WYg6LswZqxsYEeP8VQuZQECaVuhJBHZ5eUP1lNZiy81Ob4mIfwP5EPbvmHM441gstqrK
         tNvJNZtjf8tctaEYpVLIsyGLiNmAVwKXl4avS9k1cNZqQRoUW/VRx2FQ72RCFSuW3etw
         Ln9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412800; x=1692004800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtItNqjBVn5PI+StR7IJKfR6iwBSQjGA7AnuIe8qRq0=;
        b=jUMM7uFW5LlSWJXxAPjJ6e51qb3k/uN81zI794QVLTS+/4Vh9DOcswETRer0jTUG4r
         nrU+jnVNwWxGbWA8n6mgBaNMzvU8J4rJ2babAJ3pg2S3FM4sIHchyaOoJl8bzRkMbeNP
         7VOmRNfE3XiHCe750lyxb82Mzqg+CMhdGNu98WerVIOTUYIIJs6O/0P1b4pMboXFa4ot
         fXbmmOvuq51c/FzRnQlU3WE93kBfgLtwCSNVIKN1A7ZvLUSmQ/U67O3oxYS4cQip7JFl
         dpsVfM5Iq8ydfa0xMbIMeMBFrwYYR7rMm7Le141Yd+xLnft+IsiCp6vsVCCbkcSeSeMJ
         axGQ==
X-Gm-Message-State: ABy/qLYkwwL9b4uBS3tfhT47tp8w6ehznQahsgD3unuEO2tjdgzItGaf
        V+KUFir/Kv4+VacPJ3/OWxs=
X-Google-Smtp-Source: APBJJlHCKz1fZwLXEPTXAakK8h5aESw4UuZcOfxiyhysFIL84ZITXWzqpTjLJ2xFO8OG6XLbh4ahUg==
X-Received: by 2002:adf:dec9:0:b0:314:327:2ece with SMTP id i9-20020adfdec9000000b0031403272ecemr5789214wrn.61.1689412800433;
        Sat, 15 Jul 2023 02:20:00 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.202.152])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm3238133wml.18.2023.07.15.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:19:59 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v3 0/7] Add initial support for SM7125 and Xiaomi SM7125 platform
Date:   Sat, 15 Jul 2023 11:16:06 +0200
Message-ID: <20230715091932.161507-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

---
David Wronek (7):
  clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
  dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
  dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
  soc: qcom: socinfo: Add SoC ID for SM7125
  arm64: dts: qcom: pm6150: Add resin and rtc nodes
  arm64: dts: qcom: Add SM7125 device tree
  arm64: dts: qcom: Add support for the Xiaomi SM7125 platform

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |  16 +
 .../boot/dts/qcom/sm7125-xiaomi-joyeuse.dts   |  16 +
 .../boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi  | 423 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7125.dtsi          |  16 +
 drivers/clk/qcom/gcc-sc7180.c                 |   1 +
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 9 files changed, 482 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

-- 
2.41.0

