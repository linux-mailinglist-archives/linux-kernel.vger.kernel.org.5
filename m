Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353EF757AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjGRLk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGRLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:40:49 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA87510F5;
        Tue, 18 Jul 2023 04:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689680440; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bxJEewCmKTsxShVrLusqoZ4GKwdrG53rtIgidVQJUNWPQFmK/bzn+NIi1lGf/gZXtj
    LBD9s/SKJot+tW1wURR9WPpUb3yDi6vN1uAnZiH4sTL0QE/gs27TZ3lkD4J1upOrmhDR
    SgvWaEi3AH6xEf9HkCmIgOshiO+g22LYfo3J8kNqQejBPgBTtCxTZ8iZ8T/bK6JGARcf
    NAaQRRSlvji1cwES95CiBJlbd40yOhTl9VYQPAqMAc+KU2h+dWkO6bkjFJKbB37y8fXu
    YOaa1QyUzW7OjhvYQ0QoyOKp8WktYj+OubQ1n69BhpqXW1YqiEmFr7ps9TMVotOeOmh4
    Rkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680440;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vteLTIoeDwJEb7tTBHVxn9SENfUDXfypYONPVknY2OI=;
    b=ACqCJGfZSsul7barksXv6Gt4lAMbV5raYbv6IdlixGtj/1VZZcRm3Q6dq7oh/qIKJp
    wjjRvQVUeubETDh63v7NZduRW9Rkf5d03CUlw1QbK9JSkpUWYtHKcbkXJ7zLKAdn0mwZ
    hWu/+MB4YTAEk4Y4RVc2sVsiKR3PQrm5eKT2OkmF3nLQhbTI2xCIp5bHXPvkjNrpBWeq
    bPaclM1qrbhwULP3X1QFr5UlCn4+EEZew9YZw3Q3n3WzJiW1T8WyMzV9k7cU81wAqB/r
    a9JWcrzSDZ9cEQpF0kAyQXjgUJS+voetSYNyccBDu3tXd9R90OSfytP4xF/EmsQOd0BJ
    AAEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680440;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vteLTIoeDwJEb7tTBHVxn9SENfUDXfypYONPVknY2OI=;
    b=GOtbLx0A/gDA7QjoijZd6RZ6Py0WPlH+b9ZUEXgqJN2KclTwsESB4RyUPywQiOmaX/
    YtrNXaigGv9RIIBOR58k+ILvK5f3vw9dP/6uXTT1yO/q3LoYPcGhV/R2/9JLdO/K+btW
    ybu65Lk/n44ah4bN5kB/Ywo/Mcl205udLgX+flrjPucNSEIGRbD7cNgdEOJ2QSOGME9X
    of3qbuX2Zi7OZQReKRRNSamTRIL/Dkq3PzZEmykcfYArzthqrL/wzhSH1YCLZznF2IiN
    38WYLmkij5QV1ayAv4mxxCQ5JbUC2U1ziNtvppzxOXfg7fz20Atr+sjIaWhmfvsPDDMD
    D1PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689680440;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vteLTIoeDwJEb7tTBHVxn9SENfUDXfypYONPVknY2OI=;
    b=E/QakzoEEBxCqf7ER/+p72LxejX7PynRA+/2eh3n+nQMD3Er/NJ3uS5r40JYFw41li
    fN7c3DdTxiOTo7YrSwDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u45/mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IBedbpR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Jul 2023 13:40:39 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 18 Jul 2023 13:40:18 +0200
Subject: [PATCH 6/6] arm64: dts: qcom: pm8916: Drop codec reg-names and
 mclk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-pm8916-mclk-v1-6-4b4a58b4240a@gerhold.net>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
In-Reply-To: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant reg-names and mclk from the PM8916 analog codec that
were removed from the DT schema. Having the mclk on the analog codec is
incorrect because only the digital codec consumes it directly.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 2 --
 arch/arm64/boot/dts/qcom/pm8916.dtsi     | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index f3d65a606194..52bf876b8cc9 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -328,8 +328,6 @@ &mpss {
 
 &pm8916_codec {
 	status = "okay";
-	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-	clock-names = "mclk";
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
 };
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 1ea8920ff369..78187c0c94ce 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -142,9 +142,6 @@ pm8916_vib: vibrator@c000 {
 		pm8916_codec: audio-codec@f000 {
 			compatible = "qcom,pm8916-wcd-analog-codec";
 			reg = <0xf000>;
-			reg-names = "pmic-codec-core";
-			clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-			clock-names = "mclk";
 			interrupt-parent = <&spmi_bus>;
 			interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
 				     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,

-- 
2.41.0

