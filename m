Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A597622FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGYUGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGYUGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:06:13 -0400
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E4B128;
        Tue, 25 Jul 2023 13:06:11 -0700 (PDT)
Received: from [77.64.243.219] (helo=note-book.lan)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qOOIK-0002Gr-2X; Tue, 25 Jul 2023 22:06:08 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v2 0/2] arm64: dts: qcom: msm8939-longcheer-l9100: Add
 initial dts
Date:   Tue, 25 Jul 2023 22:05:09 +0200
Message-Id: <20230725-bq_m5-v2-0-9779c249aeb1@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPUqwGQC/13MSw7CIBSF4a00dyyGhwZ05D5MY4Be5A7sA2qjN
 uxd7NDhf3LyrZAxEWY4NyskXCjT0NeQuwZ8tP0dGXW1QXKpuJYH5qbb48icP9mASptgOqjfMWG
 g1+Zc29qR8jyk98Yu4rf+C4tgnAltudHcauXwYkeaP9nHPT6hLaV8AXEz+nacAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dts adds support for BQ Aquaris M5 (Longcheer L9100) released in
2015.

Add a device tree with initial support for:

- GPIO keys
- Hall sensor
- SDHCI
- WCNSS (BT/WIFI)
- Accelerometer/Magnetometer
- Vibrator
- Touchscreen
- Front flash

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v2:
- add R-b to first patch
- sort node extends/overrides by name, but keep &tlmm last, as done in
  msm8939-samsung-a7.dts
- use id-gpios, to avoid conflict with
  https://lore.kernel.org/linux-arm-msm/20230724103914.1779027-7-alexander.stein@ew.tq-group.com/
- don't enable mdss for now; postpone it till display support is added
- Link to v1: https://lore.kernel.org/r/20230724-bq_m5-v1-0-17a0870a73be@apitzsch.eu

---
André Apitzsch (2):
      dt-bindings: arm: qcom: Add BQ Aquaris M5
      arm64: dts: qcom: msm8939-longcheer-l9100: Add initial device tree

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/msm8939-longcheer-l9100.dts      | 336 +++++++++++++++++++++
 3 files changed, 338 insertions(+)
---
base-commit: 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36
change-id: 20230724-bq_m5-bc9afe378f8d

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

