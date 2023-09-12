Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75D179C8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjILHuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjILHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:50:29 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA5010D2;
        Tue, 12 Sep 2023 00:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694505011; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jAaIyz3OLtuYENZ/aU3Iw7Qt+0tVRy8OmrnnlXzqAMZw7FmnIclv1pM8LGyQ/6BGpl
    r+mP5MRNw/4plcZUeVdNSsP5c/ROHAvpu4K2MuYN+bjrbeihf9ye/DHDhpDUc+HiY+nz
    9WGfJXyqB/Voo/3jcN7Pg1NmHMnxutmpZSLnZdBxcKQ60YvWIYCnJbMolTUBXycs6LuO
    SdUaLjR2rT3cTH1L46zu8S3dom2E/RzKuIDybPp5hgTibytCOPsXp4LW2X6g4mI8U3R9
    PZxkbn+KX3JleD0FF1mzXhuPMcgnjpK78rE1sRNH1yWaTAJO2qUDqlQHHyFY8EkHZ71O
    Znsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GoY+wkPEUDk1CP3sMN6mSJftrGp/Nkm/mVVOtBRAzok=;
    b=EVW44+oLEBew2olp3qKodknQjoUPNqSPKeNNq/Os0gSFKrw0bR1f1dX8eVpkbFEWaH
    GYD37SpqDqimqgZlFY1kusx6Vij/yf4gh+simskfob3l+KL70jE4x0sq9BKp6ofoYDjP
    pJHnUQvmnFHeVbNBeFajYumx+6f2mOWJQSBb0AVvylnbCjnVgaKAjbMm6gvV2Nn/M4CK
    BOJnsmuKhJHkTx495iFjy9e5HSU9oyn9vsec9YXneJtK2e6C2xepuALnsxaO/wLLrFYa
    KjFQLp19vz7vKjbBSSMCkHny4rYknEfaN2ZlVvU/5ja86G17nzGVnkeN6+gCtIC5eX00
    tTpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GoY+wkPEUDk1CP3sMN6mSJftrGp/Nkm/mVVOtBRAzok=;
    b=PlEjrdVfxnKlcIPe6FOk97cWDeMEH4rncdhamGgHTisVnvjBgeX5q02o5VcsE98OJM
    53OMI0skSeKLmXC+VtbI97U3Fe+HOkoiYOegSpzxSJia5Yc9W2haWfNWQqZ5OkReyz3G
    QcvR9GTvJ2DSXn8/s+K5QlgvkrnVy95OGpLwfyZSo7A/Wh+ThHLvbmK05d/4WEB4VFev
    t31QUDfPfChhoOYN+NblInENx6xuC2RGOAiCaDfwxYj7Y7Jt7cUOmGaoxhvkLPBiJpsO
    D6aBH79wblcYGcJ841nJeHmWZ7t6xv39K8ISAdmnyEgxI7bvbCIro+kSaE/zZ3P1krNy
    Y5yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GoY+wkPEUDk1CP3sMN6mSJftrGp/Nkm/mVVOtBRAzok=;
    b=157Ylj0/ZcC1xYcEfUZeFWOrRNvMKfgGpFu/zEBJTVYupfT5qEk9ihOnuYGsaMEj6f
    csmxE72A26Ns6Yc+F4CQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL7nT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8C7oBcKn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Sep 2023 09:50:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 12 Sep 2023 09:49:50 +0200
Subject: [PATCH 2/6] regulator: qcom_spmi: Add PM8909 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spmi-pm8909-v1-2-ba4b3bfaf87d@gerhold.net>
References: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
In-Reply-To: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Add the necessary definitions for the PM8909 PMIC to the
qcom_spmi-regulator driver to allow reading the actual voltages applied
to the hardware at runtime. This is mainly intended for debugging since
the regulators are usually controlled through the RPM firmware (via
qcom_smd-regulator).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index c95f6e9c7ab5..3c7ab6416b61 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2168,6 +2168,29 @@ static const struct spmi_regulator_data pm8841_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pm8909_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1", },
+	{ "s2", 0x1700, "vdd_s2", },
+	{ "l1", 0x4000, "vdd_l1", },
+	{ "l2", 0x4100, "vdd_l2_l5", },
+	{ "l3", 0x4200, "vdd_l3_l6_l10", },
+	{ "l4", 0x4300, "vdd_l4_l7", },
+	{ "l5", 0x4400, "vdd_l2_l5", },
+	{ "l6", 0x4500, "vdd_l3_l6_l10", },
+	{ "l7", 0x4600, "vdd_l4_l7", },
+	{ "l8", 0x4700, "vdd_l8_l11_l15_l18", },
+	{ "l9", 0x4800, "vdd_l9_l12_l14_l17", },
+	{ "l10", 0x4900, "vdd_l3_l6_l10", },
+	{ "l11", 0x4a00, "vdd_l8_l11_l15_l18", },
+	{ "l12", 0x4b00, "vdd_l9_l12_l14_l17", },
+	{ "l13", 0x4c00, "vdd_l13", },
+	{ "l14", 0x4d00, "vdd_l9_l12_l14_l17", },
+	{ "l15", 0x4e00, "vdd_l8_l11_l15_l18", },
+	{ "l17", 0x5000, "vdd_l9_l12_l14_l17", },
+	{ "l18", 0x5100, "vdd_l8_l11_l15_l18", },
+	{ }
+};
+
 static const struct spmi_regulator_data pm8916_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
@@ -2357,6 +2380,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
 	{ .compatible = "qcom,pm8226-regulators", .data = &pm8226_regulators },
 	{ .compatible = "qcom,pm8841-regulators", .data = &pm8841_regulators },
+	{ .compatible = "qcom,pm8909-regulators", .data = &pm8909_regulators },
 	{ .compatible = "qcom,pm8916-regulators", .data = &pm8916_regulators },
 	{ .compatible = "qcom,pm8941-regulators", .data = &pm8941_regulators },
 	{ .compatible = "qcom,pm8950-regulators", .data = &pm8950_regulators },

-- 
2.42.0

