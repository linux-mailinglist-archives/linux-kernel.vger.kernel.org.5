Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D977CDBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbjHOOBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbjHOOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:00:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC0D1;
        Tue, 15 Aug 2023 07:00:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe11652b64so8462772e87.0;
        Tue, 15 Aug 2023 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692108040; x=1692712840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qzbPPmHH2Cs84MMNUNLEy/8AFYHbEVzbBv7dcVzhPE=;
        b=O2HcgsWmVGf3noRrJ9w/dYS9V9qM1/QoW+WU7MUAeJ7W22RhWFLbwBf6WSf+ZVoyDC
         2snnbesW1aam6kkwc7Vwv27Icb/KrQgKR0jz6BZjtpslNAFrXiYU1uXSs+QZJfzmifB4
         aFC87yM1znezWHUI/2M4x4wq9o8iQqtUtJJmVTZYfWm9PdveS+LyCuItuWI9o5cYf3yH
         I7PO28oxEI5wATU0Dga6nSYmCxQV0XFTdlorwfuyI78x/NUc15ma8SpFOhntPTS6VcHw
         30IGLK/enBALtX6qT8Yez3sELl3fd1BnRiaP4F9V9DVsFFs9ePZOevnnr61ANlBe1aWZ
         zlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108040; x=1692712840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qzbPPmHH2Cs84MMNUNLEy/8AFYHbEVzbBv7dcVzhPE=;
        b=X84nZPHyuzmr+9d9r5xXmvXAo7Quz8QQmS+Q3F3RCX0hZZG3J9ckv5mfVp+Dv3QcCr
         d5Nyl8jnO2fHAfO3r2uL8SD3EUL8WWTofBFl3w7euVa+WXjZlsIX8L1ylO27NgqkZ3jM
         XqCO2gE2142hSRm8Aqpj1l4c4pQO6DbWTLE+eL+bqgoQMTjDyhhSme8SelTB6TOJgmk5
         Yfx0PLe9A0krSe/ebn2qNdS+y3h9lM0hnwTUustaEko4RM/dw+I1UQZ5QHaawfG0kuZ9
         jVT3zMIJ+bcQTdvPbi4tL5Z6h66IJL/HN+xu5WqBSr5uRYoUXpN2OnXSwMJeh50SaxwT
         +lPw==
X-Gm-Message-State: AOJu0YyiZugDN3ERqUk4kAIdQUYNI+hCnp9zKcmLBojUptAxO590iFox
        IJBOivZ5mnmdaRRYmWNtses=
X-Google-Smtp-Source: AGHT+IH09mRKKgi7n4qLOrwYSpjBkp5Qo0J6B2qC/jr9UQv6lMBVjwpMiLlv5m02pKEJwLW/kFjjcg==
X-Received: by 2002:a05:6512:3589:b0:4fe:3724:fdae with SMTP id m9-20020a056512358900b004fe3724fdaemr7883880lfr.66.1692108039828;
        Tue, 15 Aug 2023 07:00:39 -0700 (PDT)
Received: from fedora.. (dh207-96-14.xnet.hr. [88.207.96.14])
        by smtp.googlemail.com with ESMTPSA id a26-20020aa7d91a000000b00525740aa68dsm1049042edr.36.2023.08.15.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:00:39 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 5/5] arm64: dts: qcom: ipq5018: indicate that SDI should be disabled
Date:   Tue, 15 Aug 2023 15:59:38 +0200
Message-ID: <20230815140030.1068590-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815140030.1068590-1-robimarko@gmail.com>
References: <20230815140030.1068590-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that SCM has support for disabling SDI if indicated by DT, lets set
it for IPQ5018 as it has SDI enabled by default and it must be disabled.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..3285c86824cf 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -57,6 +57,7 @@ L2_0: l2-cache {
 	firmware {
 		scm {
 			compatible = "qcom,scm-ipq5018", "qcom,scm";
+			qcom,sdi-disable;
 		};
 	};
 
-- 
2.41.0

