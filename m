Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5538B7AB480
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjIVPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjIVPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:12:23 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B436A3;
        Fri, 22 Sep 2023 08:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695395534; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=daL6vx1jNXgT1bVNAJGmpIJqX/9LOTf/AeJIqtzTAVKw2Gn+SXKZL3Nydu8Fsrsgb+
    0TUB2ktyUy9rBvLEfZwGaEIzNUSzmq1MmvyVtKEmEHpmotEtY99j73nU0/mtZelIw5hF
    sw1ToRMG/mGw0FcpDF+66WmWeneplW+ilXJ3ezd77CvDIQiRtT19dTaUQ1RS0aEuLCu2
    yKrMBhJSXVyhCnCEPmwaP61BQlvnhlKnqfj8XzI/0nynIPWa5sJP0iYNlqZguTG2/BbC
    cUzV3BsvSn4x81zmxcz9l/3olafgPSppkkpU6vEm0nnjZxNKeVYDrR6EjaNDMmizqqGc
    QzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695395534;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n3ubanmp4NVB+vtzJSH5QAzXo0dNiKXJkLgh4A8QnPk=;
    b=nbqNPMnPKDg29Qgbw1NOmvQH9rDl2FscXKfdiaWK1f0eI5M4MCgpslb8WGm+dcytaj
    th1fBwi+8C7JFIWf1WcvU10eGZBZxHIBMy3YUj+xHTgKQ9MDKGaaC4lIH7mwyJmOpoda
    kBAfqgHPgdBQk+/Egp0uVMXmwDeWjb3IHCACLANCbu83JJScEdOizNFgzG+zibFAmZG5
    SZFil678nycOqwTgTkVBS5Y95kYOgfZ3Ohzv4d7YOcHDTSt3DRF+Sku6dWvpAYQzpD1y
    TQysJy28C+wgYcGe2DIL1CWECVNH4Kh591/KkT0zEPtCanJB7unl74tCc8C4GQAcp8+i
    KX8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695395534;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n3ubanmp4NVB+vtzJSH5QAzXo0dNiKXJkLgh4A8QnPk=;
    b=iHDQCOqr4Fzhh64LaOPEnMzFcTtpCzGYXc8QB1uURsLh7sqp9RxLPaKZ8lMN4/MINL
    03naxxZalQTfc9OJB8t9/0OcDv9dDRY6tlZ0eXkUnKlQOhdwPgg2SQ7kQ7y+D/jUtgL4
    pBFCcV+8VawbjhwEqLjRbO2JeguZVKF4mdPiOR8Oayu8Ewclm13hayccuIkcYx7AVj0i
    q2CQJW+gqTESLeBXUcDHgF4RFZo6WuM3yYoAIU1+Y7qoguLMyALYS4ZTqq9PNys21s7i
    S07/1gIbPRTp/rZ7WsWnmpkoaUbBUvNOpnPe33vp0ZZB14CCgt7U8Lqynb8l3a9nb7bi
    vZjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695395534;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n3ubanmp4NVB+vtzJSH5QAzXo0dNiKXJkLgh4A8QnPk=;
    b=yWuMLYzI+nQ1MilvmbaO0lUyrI/GDDoqDKEnpjyL6mS+PsaHhyq9VnA9AI7Tf1A4c1
    AJUjMUPRfR5HYFDWe1Dw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8MFCEUd6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Sep 2023 17:12:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Fri, 22 Sep 2023 17:11:56 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Use more
 generic node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-apq8016-sbc-camera-dtso-v1-1-ce9451895ca1@gerhold.net>
References: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
In-Reply-To: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "regulator" to the node names of the fixed regulators, and drop the
"_rear" part of the camera node name since it is not part of the class
of the device (which is simply "camera").

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
index c08b4be5cc7e..f9cbf8c1d689 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
@@ -9,7 +9,7 @@
 #include "apq8016-sbc.dts"
 
 / {
-	camera_vdddo_1v8: camera-vdddo-1v8 {
+	camera_vdddo_1v8: regulator-camera-vdddo {
 		compatible = "regulator-fixed";
 		regulator-name = "camera_vdddo";
 		regulator-min-microvolt = <1800000>;
@@ -17,7 +17,7 @@ camera_vdddo_1v8: camera-vdddo-1v8 {
 		regulator-always-on;
 	};
 
-	camera_vdda_2v8: camera-vdda-2v8 {
+	camera_vdda_2v8: regulator-camera-vdda {
 		compatible = "regulator-fixed";
 		regulator-name = "camera_vdda";
 		regulator-min-microvolt = <2800000>;
@@ -25,7 +25,7 @@ camera_vdda_2v8: camera-vdda-2v8 {
 		regulator-always-on;
 	};
 
-	camera_vddd_1v5: camera-vddd-1v5 {
+	camera_vddd_1v5: regulator-camera-vddd {
 		compatible = "regulator-fixed";
 		regulator-name = "camera_vddd";
 		regulator-min-microvolt = <1500000>;
@@ -53,7 +53,7 @@ &cci {
 };
 
 &cci_i2c0 {
-	camera_rear@3b {
+	camera@3b {
 		compatible = "ovti,ov5640";
 		reg = <0x3b>;
 

-- 
2.42.0

