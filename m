Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB5802F13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjLDJq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjLDJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:46:25 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8CC106;
        Mon,  4 Dec 2023 01:46:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701683177; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pJudvDMWVylERXpP3nXifI54PwmHy6yRb7Ypnhpzgj7ZoVcDiGHBjsg/8R75Z5e1W6
    DMfi3mnwbZA6YWq0v7fZaRxmysOJBQVtG0mcO0IE1tzcyMXrDztGOOdxmqRyIWNw+qgF
    yMve/5gREh7iIgqlpV/ZQSQLQvXWGEfAFjxlYE/BTBl8sw5AecdjthMHTW+QZu/j1pVb
    oTCJVAhUH6rAWUrFKlwmNOZUSZ1VvrKdyVJ3NuLqWXdnX7uAdFdk0vpyUJpzTy1MXVt1
    O5P/k58x2wjTAkEvck3MSReq/6MmelJTZiK15FGh6QKvi1Qe2dmHiHm+wEupCFepOOd4
    6BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701683177;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=vPDDwu/LFJBTyJh71GaE5A1eXeoeKpnofr6UkCT3JFc=;
    b=bd2THfus25v89rcBx4MqjHLvnuJmGkBScugwnrIMCaFKKsevsnVAXqQBJSnUk9/T8P
    tF8xQtZLkxJ4XzHKwcbiJAPd0nmExJKxt3Glr53CTt5yT7xpAmV/de93QwA94ku92AsD
    CnyFogbpcvuSdBQZRPSyaMQAdJH+2JfzJBa3IttDUF93DvUEKUTRXqXlwhZ5A8yK0Df+
    qy6Ss9A7SZp9sIEWt2GXodmOfa6O6EYwJOFtt1OOgwvcvoqLYG0bKQ8wT24Ix3kNS3WU
    Td8K4AfTY3MElWi03nNmfMYwCDSANsdaKgvR5BhnOgieteffnl04weYE/pU3HbgOUu+U
    R6aQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701683177;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=vPDDwu/LFJBTyJh71GaE5A1eXeoeKpnofr6UkCT3JFc=;
    b=rPk0hNXwy2KILWychu1slf4uvwLJiipWZ2W0xPHJ8gFStNsZUkEcqJTJVFbxf2dDV3
    zDtjhGHKCPKWIvzbSidbDBq6LkPTzvtARTNy0ILUgv14avRr0VyV8HGgaeRRGtTQGyNO
    kGmGUCknTErt4eLIEpv27DLIg39t8GXUWFs9TZuiJCpdL8VhN0t2rcHnEue8k+QeLTXJ
    UjwV5U/WT1OPVitHhsrHJFI43AquUKs2lSlg2SS2Knp9HABnXCekPKc6GRnhqE5Z2JYx
    9nMOkVCZOiM0HaC0XsfyG7ISWEBY5Wexg6GFPb1E0aw/SMrHVXvFfKpGu7lbyK7hG7v3
    EXtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701683177;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=vPDDwu/LFJBTyJh71GaE5A1eXeoeKpnofr6UkCT3JFc=;
    b=WBm/rMl4qC5EUAACv3CtuLo+TKvmcHiI9F+fVlKzN2o6kMxDlpRZk20CgOo64UwzJj
    qNipme+P/lOSFYRJ/GAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.9.7 DYNA|AUTH)
    with ESMTPSA id R5487bzB49kG9je
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 4 Dec 2023 10:46:16 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 04 Dec 2023 10:46:11 +0100
Subject: [PATCH] arm64: dts: qcom: Add missing vio-supply for AW2013
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231204-qcom-aw2013-vio-v1-1-5d264bb5c0b2@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAOKfbWUC/x3MQQ5AMBBA0avIrE3STkvCVcSCGsyC0iZIGnfXW
 L7F/wkiB+EIbZEg8CVR/J6hywLcOuwLo0zZQIqMJmXxdH7D4SalDV7isdHT6BRVztYWcnUEnuX
 5j13/vh8qnxsnYQAAAA==
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing vio-supply to all usages of the AW2013 LED controller
to ensure that the regulator needed for pull-up of the interrupt and
I2C lines is really turned on. While this seems to have worked fine so
far some of these regulators are not guaranteed to be always-on. For
example, pm8916_l6 is typically turned off together with the display
if there aren't any other devices (e.g. sensors) keeping it always-on.

Cc:  <stable@vger.kernel.org> # 6.6
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
I omitted the Fixes: tag here as it would be 5 separate commits, and
it's really only useful to backport this to v6.6+ since this is where
the necessary driver addition landed (see commit baca986e1f2c3 ("leds:
aw2013: Enable pull-up supply for interrupt and I2C"). I'm not aware
that anyone actually ran into trouble with this missing regulator yet.
---
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts  | 1 +
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts | 1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts      | 1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts    | 1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 37fa55166918..5f24c40a6020 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -104,6 +104,7 @@ led-controller@45 {
 		#size-cells = <0>;
 
 		vcc-supply = <&pm8916_l17>;
+		vio-supply = <&pm8916_l6>;
 
 		led@0 {
 			reg = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index d4b88c787e59..510b3b3c4e3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -142,6 +142,7 @@ led-controller@45 {
 		#size-cells = <0>;
 
 		vcc-supply = <&pm8916_l16>;
+		vio-supply = <&pm8916_l5>;
 
 		led@0 {
 			reg = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
index ed95d09cedb1..6b9245cd8b0c 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
@@ -111,6 +111,7 @@ led-controller@45 {
 		reg = <0x45>;
 
 		vcc-supply = <&pm8953_l10>;
+		vio-supply = <&pm8953_l5>;
 
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
index 61ff629c9bf3..9ac4f507e321 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
@@ -104,6 +104,7 @@ led-controller@45 {
 		reg = <0x45>;
 
 		vcc-supply = <&pm8953_l10>;
+		vio-supply = <&pm8953_l5>;
 
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
index 1a1d3f92a511..b0588f30f8f1 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
@@ -113,6 +113,7 @@ led-controller@45 {
 		reg = <0x45>;
 
 		vcc-supply = <&pm8953_l10>;
+		vio-supply = <&pm8953_l5>;
 
 		#address-cells = <1>;
 		#size-cells = <0>;

---
base-commit: adcad44bd1c73a5264bff525e334e2f6fc01bb9b
change-id: 20231204-qcom-aw2013-vio-91dbc025c464

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

