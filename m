Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2800E79C8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjILHux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjILHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:50:29 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27D10DE;
        Tue, 12 Sep 2023 00:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694505013; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ib3VDx5cP75IwWqBbq8zVusKA5qfF+0AXQE9BakT5r4lCup2xey8tV04o+jnTsgmVO
    rwcPVLEqCrep3Vjx/AS4hdXsI7Itq6lFluKU7FmoAP4+bHaKH0LMyxM41/NdDEquCAUi
    jiKhEuJT3TE7QsOSPCI8P8OnKAcUcqCq66xvFiRXntVgRfmbv9tqHXcIeleeSr8TzO1a
    14SFfzuoSLcQQ5Ra41kLdTvSdZEOUBL1AolqvhJS6xPe4NrESGviLsQOJieLF7q/t+h4
    bK4EvA5iq+yHyC38bhVf94q2HEzMKmw6csTALYVdyXvJwU1ehPHMX+obPTUL23RXdmhv
    0MbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505013;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=g7bOyAxn6FtoUXlouwMS8dne0RmfAXqkR/iQ0MYt+F0=;
    b=RytiEHUyAEQa3tTASF+sYEFdGL6HwzWmBEBZ3wKcCnhb+dcnYhH1x0yobdMO/dngd8
    kEFE3qtb8UoasMert4VYiAMTQqD38+z/nGHFdRTixEORxVfvhd8YLsIP4hbPf5Xj75Vm
    niUy76zwv+rtUyVZLAC7pjE/FyOckFnzcd9jouBlt1z1CqLVRoQ9qKwUcPa19xQxo4mW
    Xxy4TPz+hllPRVYwg6NfFG+Vdk3rkfl7gIAVILiL5nzXnzAKGEoPyT0PCSotnbD36nEL
    p5GPJZfMNQd5rhfWnX2Irf+LKz/bOgWOHT1xBo8kXinGc8r0HmHN/Tyi5VAaDEqk7ym1
    dwfw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505013;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=g7bOyAxn6FtoUXlouwMS8dne0RmfAXqkR/iQ0MYt+F0=;
    b=snOQ+8EGQGDSleCVsj8Ni4sZpepCW9fpLRcbx/mawETer7rxpSPvz2bYiGstzTtuhd
    BJLvF7qS7uwDFIwH529FK2Dxow9SzeOTz29q0iUDXADPbtXasGRLXwvZOQx5tPm1ueTN
    gA8fuBm2v6LlKLmg3O+yno8BSCiMI+B9KNxobcMqEi3ZzsS2CBF9JeebkDwApCT0UNIW
    76aAiJTDPI+at1a8grhDNqpFtPYLFFw39w9gQgu2Sma4fjnJZSyzh8kTY50dI9YLcnDX
    vSLC0uT2jv7bkM+RWDaoUW3WIVz8p5GjMwqfmNLrLVgFLYRdzOtAtJMGWm0uhVN/P+Ay
    jb3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694505013;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=g7bOyAxn6FtoUXlouwMS8dne0RmfAXqkR/iQ0MYt+F0=;
    b=Z36x2yCRxb7hgE7effU7qsvOgOhWMsF3X91AwF4sMesZ/XbpuYYAN6/OJzMse0tJhr
    2Fa04MsQIbYoj+uw/xDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL7nT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8C7oCcKt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Sep 2023 09:50:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 12 Sep 2023 09:49:54 +0200
Subject: [PATCH 6/6] regulator: qcom_spmi: Add PMA8084 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spmi-pm8909-v1-6-ba4b3bfaf87d@gerhold.net>
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
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary definitions for the PMA8084 PMIC to the
qcom_spmi-regulator driver to allow reading the actual voltages applied
to the hardware at runtime. This is mainly intended for debugging since
the regulators are usually controlled through the RPM firmware (via
qcom_smd-regulator).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/regulator/qcom_spmi-regulator.c | 49 +++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 13fe1c73a547..fe32fd53f683 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2359,6 +2359,54 @@ static const struct spmi_regulator_data pm8994_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pma8084_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1", },
+	{ "s2", 0x1700, "vdd_s2", },
+	{ "s3", 0x1a00, "vdd_s3", },
+	{ "s4", 0x1d00, "vdd_s4", },
+	{ "s5", 0x2000, "vdd_s5", },
+	{ "s6", 0x2300, "vdd_s6", },
+	{ "s7", 0x2600, "vdd_s7", },
+	{ "s8", 0x2900, "vdd_s8", },
+	{ "s9", 0x2c00, "vdd_s9", },
+	{ "s10", 0x2f00, "vdd_s10", },
+	{ "s11", 0x3200, "vdd_s11", },
+	{ "s12", 0x3500, "vdd_s12", },
+	{ "l1", 0x4000, "vdd_l1_l11", },
+	{ "l2", 0x4100, "vdd_l2_l3_l4_l27", },
+	{ "l3", 0x4200, "vdd_l2_l3_l4_l27", },
+	{ "l4", 0x4300, "vdd_l2_l3_l4_l27", },
+	{ "l5", 0x4400, "vdd_l5_l7", },
+	{ "l6", 0x4500, "vdd_l6_l12_l14_l15_l26", },
+	{ "l7", 0x4600, "vdd_l5_l7", },
+	{ "l8", 0x4700, "vdd_l8", },
+	{ "l9", 0x4800, "vdd_l9_l10_l13_l20_l23_l24", },
+	{ "l10", 0x4900, "vdd_l9_l10_l13_l20_l23_l24", },
+	{ "l11", 0x4a00, "vdd_l1_l11", },
+	{ "l12", 0x4b00, "vdd_l6_l12_l14_l15_l26", },
+	{ "l13", 0x4c00, "vdd_l9_l10_l13_l20_l23_l24", },
+	{ "l14", 0x4d00, "vdd_l6_l12_l14_l15_l26", },
+	{ "l15", 0x4e00, "vdd_l6_l12_l14_l15_l26", },
+	{ "l16", 0x4f00, "vdd_l16_l25", },
+	{ "l17", 0x5000, "vdd_l17", },
+	{ "l18", 0x5100, "vdd_l18", },
+	{ "l19", 0x5200, "vdd_l19", },
+	{ "l20", 0x5300, "vdd_l9_l10_l13_l20_l23_l24", },
+	{ "l21", 0x5400, "vdd_l21", },
+	{ "l22", 0x5500, "vdd_l22", },
+	{ "l23", 0x5600, "vdd_l9_l10_l13_l20_l23_l24", },
+	{ "l24", 0x5700, "vdd_l9_l10_l13_l20_l23_l24", },
+	{ "l25", 0x5800, "vdd_l16_l25", },
+	{ "l26", 0x5900, "vdd_l6_l12_l14_l15_l26", },
+	{ "l27", 0x5a00, "vdd_l2_l3_l4_l27", },
+	{ "lvs1", 0x8000, "vdd_lvs1_2", },
+	{ "lvs2", 0x8100, "vdd_lvs1_2", },
+	{ "lvs3", 0x8200, "vdd_lvs3_4", },
+	{ "lvs4", 0x8300, "vdd_lvs3_4", },
+	{ "5vs1", 0x8400, "vdd_5vs1", },
+	{ }
+};
+
 static const struct spmi_regulator_data pmi8994_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
@@ -2408,6 +2456,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm8941-regulators", .data = &pm8941_regulators },
 	{ .compatible = "qcom,pm8950-regulators", .data = &pm8950_regulators },
 	{ .compatible = "qcom,pm8994-regulators", .data = &pm8994_regulators },
+	{ .compatible = "qcom,pma8084-regulators", .data = &pma8084_regulators },
 	{ .compatible = "qcom,pmi8994-regulators", .data = &pmi8994_regulators },
 	{ .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },
 	{ .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },

-- 
2.42.0

