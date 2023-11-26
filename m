Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DA27F959C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKZVs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:48:25 -0500
Received: from smtprelay08.ispgateway.de (smtprelay08.ispgateway.de [134.119.228.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF32ED
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:48:30 -0800 (PST)
Received: from [92.206.191.233] (helo=note-book.lan)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1r7MzJ-0003uK-1g;
        Sun, 26 Nov 2023 22:48:25 +0100
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sun, 26 Nov 2023 22:46:20 +0100
Subject: [PATCH v2] arm64: dts: qcom: msm8939-longcheer-l9100: Add
 proximity-near-level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231126-bqm5_prox-v2-1-b7defc3979ac@apitzsch.eu>
X-B4-Tracking: v=1; b=H4sIAKu8Y2UC/23MQQ6CMBCF4auQWVtDB4vAynsYYqBMZRbS2mKDE
 u5uZe3yf3n5VgjkmQI02QqeIge2Uwo8ZKDHbrqT4CE1YI6FzGUp+udD3Zy3izjVqjKmzLFSCtL
 feTK87Na1TT1ymK1/73SUv/WfEqWQAjs96HOBPdXDpXM8f4Iej/SCdtu2L6IJnrukAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.4
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider an object near to the sensor when their distance is about 4 cm
or below.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v2:
- add R-b
- Link to v1: https://lore.kernel.org/r/20231016-bqm5_prox-v1-1-2acdc732be9d@apitzsch.eu
---
 arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
index ff532fdc1826..e3404c4455cf 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
@@ -180,6 +180,7 @@ magnetometer@d {
 	light-sensor@23 {
 		compatible = "liteon,ltr559";
 		reg = <0x23>;
+		proximity-near-level = <75>;
 
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l5>;

---
base-commit: 8c9660f6515396aba78d1168d2e17951d653ebf2
change-id: 20231016-bqm5_prox-4958ff602855

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

