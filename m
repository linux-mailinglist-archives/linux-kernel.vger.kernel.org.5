Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18779C8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjILHuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjILHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:50:24 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B582E79;
        Tue, 12 Sep 2023 00:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694505012; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IcJI1yDLNLTpb+keWEMbKlBBhK061oaWAfnIf5f6IxX2wxANw9BB41ZLYivC6CDroz
    MP7idyUZzMtGEompC+imZMH2IPFWnRntgoHJL+j7I8S36BQyR0yY7484BkqjjTCnV1Y4
    cvAoFofXUikMUpmt38fSg/GAm40lguUiiL/CrjrF930BRcoZfjxyKuGfC45d0IxwN2lh
    gExUzxEbWMAWviGloDowXIgtk8ZiMjLPnEqvWJnrXwhaITvSX3zraFpDevWELnqZkTvY
    vZCEAALfqQ30ExMaPfott5T0zgG8GojgXLlxqF1dgR+UIS1w7vjwV9suBcjkaz8tYBYH
    jkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505012;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3BlPOpYYuTl9VcTVtvme0f5FGpEQD50BRzvSon1zHE0=;
    b=cjy2YeZ5vKnFDc1Z4/jdnD98TLvymu4XJ6HcT50HK3HehNG/ZQ7apYIlXs8P7+gRej
    u8RgQEjzYth8OShkANb0UvG05ehMk4grQzaYOpZeA014Nv7PMrWRZB9RiVqs8c+iSj0j
    pgzxs3ntiUXZS/EJ7wVJ2rGAVw71VyEEJbLihCAnf8lpcZ/4rcnuTVD6/hIxLmoQRaAc
    JgrmRnZieCiP3lClDPkRf+729CCjCNwN5CsI6ERhYYpilfhNG9/PrluhXg/soJM+aR5G
    CXHy/R2sqrN1L1oMbpHnsh2G8IhmGETikSxZAKa7i+mD+QHQk9CtOSrZ2ceQwFWhokRu
    O0pA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505012;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3BlPOpYYuTl9VcTVtvme0f5FGpEQD50BRzvSon1zHE0=;
    b=HzZWncz+lyNz2uxEJUgPvbzGt3ghPPYh/vxyCBNFpXRWtpMxARw+2hQDLoVnc7UpOX
    8gDbLbA+kJ1gc/AO+HQ0qQpJtdOy1rWz9mkEBThfpnor7AzesLw6O/r/+nluU4YTDoqr
    wejrdkkuRvszbD2dS+YqN15iGrdaQasU5UvjrsU8qOHHnjF4Brj8toFj67QLDq/gk3U7
    hfQRxPZYkc4DVvceTuYQYfwVx+8ZiehWFBE6ds32gmQHTjwx+2lsfO+oRdsWmZwtExGF
    xGNXS4p+kdFS/5lqzW/17LYj8qg08PGDiPxZaeeRgq+/4KfN/g4smgucze5Ng1eW+r0A
    BYcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694505012;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=3BlPOpYYuTl9VcTVtvme0f5FGpEQD50BRzvSon1zHE0=;
    b=RBBdpI7PTRW0dz/J8gJid8JM4XL0NJoO2rWUJ0cumj3GGpU/pSvv4KM7KmdxHh02Up
    JhaiMuGDdWnciqmPG0Cw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL7nT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8C7oCcKp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Sep 2023 09:50:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 12 Sep 2023 09:49:52 +0200
Subject: [PATCH 4/6] regulator: qcom_spmi: Add PM8019 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spmi-pm8909-v1-4-ba4b3bfaf87d@gerhold.net>
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

Add the necessary definitions for the PM8019 PMIC to the
qcom_spmi-regulator driver to allow reading the actual voltages applied
to the hardware at runtime. This is mainly intended for debugging since
the regulators are usually controlled through the RPM firmware (via
qcom_smd-regulator).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/regulator/qcom_spmi-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 3c7ab6416b61..13fe1c73a547 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2118,6 +2118,28 @@ static const struct spmi_regulator_data pm8005_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pm8019_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1", },
+	{ "s2", 0x1700, "vdd_s2", },
+	{ "s3", 0x1a00, "vdd_s3", },
+	{ "s4", 0x1d00, "vdd_s4", },
+	{ "l1", 0x4000, "vdd_l1", },
+	{ "l2", 0x4100, "vdd_l2_l3", },
+	{ "l3", 0x4200, "vdd_l2_l3", },
+	{ "l4", 0x4300, "vdd_l4_l5_l6", },
+	{ "l5", 0x4400, "vdd_l4_l5_l6", },
+	{ "l6", 0x4500, "vdd_l4_l5_l6", },
+	{ "l7", 0x4600, "vdd_l7_l8_l11", },
+	{ "l8", 0x4700, "vdd_l7_l8_l11", },
+	{ "l9", 0x4800, "vdd_l9", },
+	{ "l10", 0x4900, "vdd_l10", },
+	{ "l11", 0x4a00, "vdd_l7_l8_l11", },
+	{ "l12", 0x4b00, "vdd_l12", },
+	{ "l13", 0x4c00, "vdd_l13_l14", },
+	{ "l14", 0x4d00, "vdd_l13_l14", },
+	{ }
+};
+
 static const struct spmi_regulator_data pm8226_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
@@ -2378,6 +2400,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
 	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
 	{ .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
+	{ .compatible = "qcom,pm8019-regulators", .data = &pm8019_regulators },
 	{ .compatible = "qcom,pm8226-regulators", .data = &pm8226_regulators },
 	{ .compatible = "qcom,pm8841-regulators", .data = &pm8841_regulators },
 	{ .compatible = "qcom,pm8909-regulators", .data = &pm8909_regulators },

-- 
2.42.0

