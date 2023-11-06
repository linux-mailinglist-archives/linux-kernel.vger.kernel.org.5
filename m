Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99D67E20F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKFMKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjKFMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:09:54 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C71718;
        Mon,  6 Nov 2023 04:08:55 -0800 (PST)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4SP99z0yVmzDqsV;
        Mon,  6 Nov 2023 12:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1699272535; bh=DZc5x9vkCzuuaEUVgKW05lDTzpnh7yi/JzzkDRqdcWQ=;
        h=From:Subject:Date:To:Cc:From;
        b=p1/xvraU4/1E28miZiPJynlEP0W5ed8pPMe8RX9g5nZdSiWW/qSiHI3f76sqmpkTB
         F40iMtUSJT0ndVXl+Zg4JV+F/ZsicmsDR8hX1c5O33cO0ZNL3OoDm3vGD/gftGyrK/
         BiU1H3X4fHA/Bwb/Hvm/EDJ57FZ3uQC1bPbaBaHQ=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4SP99x5dYMz9t37;
        Mon,  6 Nov 2023 12:08:53 +0000 (UTC)
X-Riseup-User-ID: 286C730A51436F1E5A2183D411F2896D0D44EA9549464B8F17AFD85E7B56467D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4SP99s6h4szJmtY;
        Mon,  6 Nov 2023 12:08:49 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Subject: [PATCH 0/8] Add PM8937 PMIC support
Date:   Mon, 06 Nov 2023 19:08:28 +0700
Message-Id: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzXSGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwMz3YJcC0tjc10DA4NUEyPjRHPTtCQloOKCotS0zAqwQdGxtbUAlRF
 NhVgAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Dang Huynh <danct12@riseup.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM8937 is a power management IC. It is used in various boards with
MSM8917, MSM8937, MSM8940 and APQ variants.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
Dang Huynh (8):
      mfd: qcom-spmi-pmic: Add support for PM8937
      dt-bindings: mfd: qcom-spmi-pmic: Document PM8937 PMIC
      regulator: qcom_spmi: Add PM8937 SPMI regulator
      dt-bindings: regulator: qcom,spmi-regulator: Document PM8937 PMIC
      regulator: qcom_smd: Add PM8937 regulators
      dt-bindings: regulator: qcom,smd-rpm-regulator: Document PM8937 IC
      arm64: dts: qcom: Add PM8937 PMIC
      soc: qcom: socinfo: Add PM8937 Power IC

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   1 +
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   4 +
 .../bindings/regulator/qcom,spmi-regulator.yaml    |  19 ++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               | 202 +++++++++++++++++++++
 drivers/mfd/qcom-spmi-pmic.c                       |   1 +
 drivers/regulator/qcom_smd-regulator.c             |  34 ++++
 drivers/regulator/qcom_spmi-regulator.c            |  34 ++++
 drivers/soc/qcom/socinfo.c                         |   2 +-
 include/soc/qcom/qcom-spmi-pmic.h                  |   1 +
 9 files changed, 297 insertions(+), 1 deletion(-)
---
base-commit: 12c9e8890929813dc852d9739f8d900ff51d9814
change-id: 20231106-pm8937-000e423a75fb

Best regards,
-- 
Dang Huynh <danct12@riseup.net>

