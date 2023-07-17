Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635CA7567A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjGQPU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjGQPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26CD19B1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so7241103e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607169; x=1692199169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkK0zo9Pzls7HuP6fjOXcbL6dtei0B7+SlDRygwdvi8=;
        b=iR1XfiKEzrx7+T4BDT5YuM955j5yDVy9OhdERnmdlfO6RjaGQtzMIdoGtE5Mjjezhd
         +3j1ecAmLtYvr1aFTK2pqDTZrzdc3ZM9kn/IFosFTienwFzol7xDCNmw8CMda7YoK8lU
         KGMtE+Yqr92xe0eiLB8nHadioD/dWtJiq+xDuk87+eks7sSS17pGU/ISpC26N8a7Za4i
         bJaqmNZF2QcXv0EqFRsYsNIO0ZLF2Vuvcx1HT3933tK6NqnFtG2cRvIso7kjuoB2zal5
         /6rCohkAuVVGnxTdP8pf0jNWBbe4YIv8BaHk5uA0MLxLEKtpHDOZrVfaymPL0+g/CZ0N
         lJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607169; x=1692199169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkK0zo9Pzls7HuP6fjOXcbL6dtei0B7+SlDRygwdvi8=;
        b=GM4hZXx6PFwvyhRC8x8MlKGuGZnRja5S/pcAkfUfCGHcYHpbgZb4708H1+NrkHOCJB
         hjARmepQQUI+5O1XpNKtKVXnKBIgBG63MJl3SrCnMMc2G7P7jygLOTJ6Xx5Wl5Nd9P/7
         8tnWlhKNBMVjH/P1zPvrZ+BGC7j29xcyi+5o+R/RthR0vdeggDsTsYQxXw6sLwii+cd7
         z9wGxyYhQEXkVYcRHcyLgRi8lUPw+lQaXiv/aqdvoYliYTla8sRIu1eMXMYA5P0SikcD
         I3afZaSapQoCWMqRHYH8tC6m/+lF3dJBpYZ0eagy0BWr2YXlr2JZWrPNpykSdte41K6f
         enGg==
X-Gm-Message-State: ABy/qLYYhLzvrkYvHeyIHQCv6Gho4zhD2842DdvoMMRPgJn1IJ+2KgZV
        swRkSf60hM6uK4/2eTbY9ChwlA==
X-Google-Smtp-Source: APBJJlEUuPJiBCoXWIVpOX6xMff+ZiEeee+KaZXIUJ20OrKIlUEG/fh8XyOh0tXXq7iUZpHtW3OiOw==
X-Received: by 2002:ac2:4546:0:b0:4fa:d522:a38e with SMTP id j6-20020ac24546000000b004fad522a38emr8262794lfm.35.1689607169690;
        Mon, 17 Jul 2023 08:19:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:20 +0200
Subject: [PATCH 13/15] arm64: dts: qcom: qcm2290: Add VDD_CX to GCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-13-27784d27a4f4@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=764;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CPIjnOdtakV5i/cKNTsCCaP/1W9vDnorxYs0r/7/pcg=;
 b=WOkbSks1r0/0/zz3X2U6Fi1XiOfql7qbx696TFz4HDvz9aDWN8L/4R9cCn0Xe2bSuOw2blzri
 Ypn4itLVWWqA3FXGDaS4p66CG3cykA3YI6V/hCCKLXU3IpaKvRNXPf1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC block is mainly powered by VDD_CX. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index d46e591e72b5..a3191e3548c1 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -622,6 +622,7 @@ gcc: clock-controller@1400000 {
 			reg = <0x0 0x01400000 0x0 0x1f0000>;
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
 			clock-names = "bi_tcxo", "sleep_clk";
+			power-domains = <&rpmpd QCM2290_VDDCX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.41.0

