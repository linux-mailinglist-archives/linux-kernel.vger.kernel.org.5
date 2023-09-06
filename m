Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ACC79381E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjIFJZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbjIFJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:25:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9287F10C9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:25:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso4919085a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693992302; x=1694597102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnYwdqbWQjSGcMevmL2xfokfgyKteExecdSmCDZE+XU=;
        b=hTkz3JBDI5fAhQ2v35kPlvEPg31/qoX94NA0lgNFlYpB7ubSOtpeAdUPc4H5nphoA/
         9027Tnp3Id+MMiRtR7ySlwcpLUfZqRvzux0xkENPEW1nCWfC5dxxT4TD4MGFUOlTvFh4
         DGTuAV5y4T3YKGNm/oIg3k5eU1+lUwR2e5jMELM58ibLLE/xHqIJp5oeEaSEblwJv0na
         jRgultlQk8YbC6n2EjDCm2BXXgsM2ZIQ+Bo5ow4OHlD+ZPm8kVskgIsDeXngVX9JnJIe
         Py7k98qYWubWs8YI+VAnznRGX45qc0GKyrgALnjds0Hc4d/6UmCnJIgVNQWyYJLwmyUj
         Zv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992302; x=1694597102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnYwdqbWQjSGcMevmL2xfokfgyKteExecdSmCDZE+XU=;
        b=PFDFyDk7atrSN6uesxT9Joj/GPKknfbQp71s43h0OloU3U1eapsSYWalFky5IR4t6I
         jkJ1miCm3RDuKS+mdJ5w332rbl42Np46PhXBgQu+T899M8Y5IOqSiwXYQ7E+9jvtR+wN
         Wbx8BbTDp0sVP60lAIpN1vtrzxznI3qKwgtxPXAO60rwdvehvDKYsh40Kts6HlOPbK8d
         HmxyieYallYGAQtU550Xj2FFQuy2rLeLow+gSGnUM1hHYWW+sRKXVnfrQcYH4bc7Jdg0
         sx74oJTWgYcUczST6cpYOhLRlKNR7jVgbG7MZ4t6dERGK3G10vL9LiUiobozGSI+n0fs
         ApWw==
X-Gm-Message-State: AOJu0YwFNTpHD8TtManORcDq9duW/Wxu7C359Nspzr/lmx4Ok2tLx/9K
        VxRXODqFJZ0wFQIy1g/Wnd2hEA==
X-Google-Smtp-Source: AGHT+IEHJE3fGpzoBkTrJS7dRq9rbNAAXB5S+M8nvLb6myUfQXTwv3xVRVwXDoXA+ZA3DxjVdPm0wQ==
X-Received: by 2002:aa7:df05:0:b0:523:b133:5c7e with SMTP id c5-20020aa7df05000000b00523b1335c7emr2176561edy.1.1693992302078;
        Wed, 06 Sep 2023 02:25:02 -0700 (PDT)
Received: from [10.167.154.1] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b005232c051605sm8096155edt.19.2023.09.06.02.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:25:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 06 Sep 2023 11:24:57 +0200
Subject: [PATCH 3/5] arm64: dts: qcom: qrb2210-rb1: Enable remote
 processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-topic-rb1_features_sans_icc-v1-3-e92ce6fbde16@linaro.org>
References: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
In-Reply-To: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693992295; l=1269;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GxxdKaABG/4dfsjIOXX0iFhor2LXgsg6bFK7ECFX658=;
 b=zAiOOe27ov+y+/1gzwTD137dN13wjRsAUY980ds26cVqOaYdE4I6j5PXUkf9im2mXXeUXFm0o
 BYBKMrQIAimB3U/u3pBlE3IeGMfEituj1qE56BOsSYytIyTTcIoW4T3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the ADSP, MPSS and Wi-Fi. Tighten up the Wi-Fi regulators to
make them compliant with that the chip expects.

The Wi-Fi reports:
qmi chip_id 0x120 chip_family 0x4007 board_id 0xff soc_id 0x40670000

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 0f7c59187896..5f7619518deb 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -134,6 +134,16 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/qcm2290/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/qcm2290/modem.mbn";
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators {
 		compatible = "qcom,rpm-pm2250-regulators";
@@ -373,6 +383,14 @@ &usb_hsphy {
 	status = "okay";
 };
 
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm2250_l7>;
+	vdd-1.8-xo-supply = <&pm2250_l13>;
+	vdd-1.3-rfa-supply = <&pm2250_l10>;
+	vdd-3.3-ch0-supply = <&pm2250_l22>;
+	status = "okay";
+};
+
 &xo_board {
 	clock-frequency = <38400000>;
 };

-- 
2.42.0

