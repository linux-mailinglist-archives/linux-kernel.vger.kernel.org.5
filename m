Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9660E765D73
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjG0UdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjG0Uc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:32:57 -0400
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412C94;
        Thu, 27 Jul 2023 13:32:53 -0700 (PDT)
Received: from [77.64.243.219] (helo=note-book.lan)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qP7fB-000859-S1; Thu, 27 Jul 2023 22:32:45 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v3 0/2] arm64: dts: qcom: msm8939-longcheer-l9100: Add
 initial dts
Date:   Thu, 27 Jul 2023 22:32:16 +0200
Message-Id: <20230727-bq_m5-v3-0-df5e227c79d0@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFDUwmQC/12Myw6CMBBFf4XM2po+IKWu/A9jTFsGmYWILTYq4
 d8tJCbq8tzccyaIGAgj7IoJAiaKdO0zqE0BvrP9GRk1mUFyqbiWJXO306VizhvbotJ1WzeQv0P
 Alh5r53DM3FEcr+G5ZpNY1v9CEowzoS2vNbdaOdzbgcZX9N0W77A0kvz2qo8ns2e0Nl6WxqITv
 948z2+RvlnG1AAAAA==
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v3:
- use "id-gpios" instead of "id-gpio" to avoid conflicts with
  https://lore.kernel.org/linux-arm-msm/20230724103914.1779027-7-alexander.stein@ew.tq-group.com/
  (v2 only contained the changelog entry, but not the actual change) 
- Link to v2: https://lore.kernel.org/r/20230725-bq_m5-v2-0-9779c249aeb1@apitzsch.eu

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
base-commit: 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab
change-id: 20230724-bq_m5-bc9afe378f8d

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

