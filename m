Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5501F7AFFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjI0JWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjI0JVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:21:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53D4B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:21:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so114341321fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695806512; x=1696411312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WW9O+qX10fuSUtolwUwOcuZrhGmJhLxghHZNu9pvopI=;
        b=nEB3BZ2EPiEyf3pmGg95/vSGKDBF4UbMPA8WZVbCvyf/8Cg/Vw/DSLcpv3+28EUlg4
         AKL7PRWRpmG47QUofQSJN2QDl7xWTxWltXQdKgiShf7PoHRLrS7S82QCMa9cwN4ol7DM
         UPZ6aQJgsMWkFzirvcbRfYYixe81vnRXvPkoUD+zFlvNQgMbC3kZRag8DxZvkwH2nIFd
         5C11r0485mI5rCACwehcKW9ETPYyfxgSraUEnHBOYtwF6KZOR9hQ1ygw6/7L9nAtyWnM
         A7J1pXtui/YHsu13Dcp7kGImJLL+sDXUsSg4SAZANx5EnTW56GNpYDw1VRRd3PxdP1Fj
         9sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806512; x=1696411312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW9O+qX10fuSUtolwUwOcuZrhGmJhLxghHZNu9pvopI=;
        b=nactiyUXkYPWF4QwcqlcF5XzFuGX+7QGwWprZ3R8S95rKLW2VXvGkZRTmIxOIUAoVm
         RVaXRbkhHFoVa1QMGAxwJZDBxs1nKnRgpaOoKsVI4kIVvO8dACZJtLJPEfeSZBlVizRr
         4U4uMMInXc4siYBg+AZY0vVf2mEblB494dCSex/pxFv76LDBXrjFciNxAxGLk15M+aPH
         /M5+QUI4xXfkZ+uW6afMwBe3WS1l5+eRp1bs4yljs14FcgcyCesfKFj+rBtL2XCsyhAp
         coMjjq+sp6WwP/Hh/W5bHUyaLfiOoxeMwO/nwvG0q5WL0RSsHaGfoUz/SHS58LJSLUbE
         WFXg==
X-Gm-Message-State: AOJu0YwkIsqAXrCd+kE21dCl6/kbzM9EygFwo0s0OSU2Py3nvwouGEG1
        Kg20x9cZmRwibJ7A3I93AXfr+A==
X-Google-Smtp-Source: AGHT+IHoyiXqDP+cgrx4RVf3BNKJAYmDS72/reSUGtR8r2euzrC/AGHJRayfoAjRKNP+PgjJoIF8BQ==
X-Received: by 2002:a2e:b0d6:0:b0:2bf:f365:c7b9 with SMTP id g22-20020a2eb0d6000000b002bff365c7b9mr1682123ljl.18.1695806512171;
        Wed, 27 Sep 2023 02:21:52 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id qq23-20020a17090720d700b00993664a9987sm8948574ejb.103.2023.09.27.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:21:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 27 Sep 2023 11:21:41 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: sm6375-pdx225: Enable MSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-topic-6375_stuff-v1-2-12243e36b45c@linaro.org>
References: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
In-Reply-To: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695806508; l=811;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=75nX4j0RzJI1wshwB+Vg1dphMpUe3Tavrj5ASyWGPHU=;
 b=ZDfATHGXicJ8fB2th8gLs8l0IN62uzMwqI6pInsVBmZfdAc7ICA4/mEv+VoFYumS+6IeFxqaA
 sFk4pBfy8xcA5t2N+zlHi5c2iW/AwP9oEzljWvwWTrTheiw6iiOhYiL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 5G modem on the Sony Xperia 10 IV.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index b2f1bb1d58e9..964fe86a18ef 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -187,6 +187,11 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
+&remoteproc_mss {
+	firmware-name = "qcom/sm6375/Sony/murray/modem.mbn";
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators-0 {
 		compatible = "qcom,rpm-pm6125-regulators";

-- 
2.42.0

