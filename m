Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900B478AF20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjH1LnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjH1Lmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:42:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD7103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff882397ecso4668007e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693222952; x=1693827752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlJhEuNYBV5jj7maZ8OCRSRGiSihDfYe9wi2z5KSM2U=;
        b=ow3iiAW+ZTZtm92AcBkQk7p5et8JJP37pZMwORve0EXtK4t8SrfgXuAnZCHRzASNSq
         uWvCHi2+ZRs8PBUiathH9SPFonFJk6jTe1ReuYW2ZjnKtYZDnewCtEPE2i/d1/FoRA/n
         IqZoeq5sg9MMINz3uAwC6n1ktcqYt2qOKKx+Vt1LfUpD1BHcNJrWIiGVjLKEQjAI1HGo
         Sg0z02NMeb+QTDz9/0jtOY29ShPLiwplS7GXQirUKydHlR2CdYkTpoyfr+Lx02uIVgZp
         IyTnMerYcPgrMO2UgGM8AS8NXEybwHEbakFTBdSgUYOKAO3nh7KaCeCTOxfS6NXiNUCW
         12Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693222952; x=1693827752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlJhEuNYBV5jj7maZ8OCRSRGiSihDfYe9wi2z5KSM2U=;
        b=TfYBKN7tQo/+Kogq28h/o7jGUSri4yRwAwnE9/KFvcIdWc6/s3IQbF01Porm/Oa+QF
         hC1ZXN3RlDWyPhx+DOrPAt03YABcRQgZjZmOgaEwb6T4eIeOuqV7abR/H2V0Nbqgx7iJ
         LC88NLJr4pAWjoqtfT1YetMbEb+CxR8jyyQNClGXQvEk3soebmvBZcSMEaaK2T7ufywR
         yIx+EZNB7ukm1uf25Jcy/MeOyr2hA8fnmtmpJEfx8KSBPKeTHpwTlwroZ+VkiV3DROrg
         Kr0vZvZB6wUTBebTZnwDOJc/tOeoyI/4Ot33sA6zv70G/PCMaPm16e9KqVKZn/hCtip5
         6UNA==
X-Gm-Message-State: AOJu0YyAS1/6lEEx32uQy/+dVuMy+NDGsBAiRKD9wqM34W7e565HYELS
        0ALgtaudjUB3AEnSR+g8QeTYYQ==
X-Google-Smtp-Source: AGHT+IFCJzymF5UCLVAjAjDGmR4ygVJL9Sg5F/Ld5CJaFb4o1B80bsk+kDECF+LM6vldy/FCSQlY+Q==
X-Received: by 2002:a05:6512:3411:b0:4f8:586a:8af6 with SMTP id i17-20020a056512341100b004f8586a8af6mr19883083lfr.4.1693222952551;
        Mon, 28 Aug 2023 04:42:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id b2-20020ac247e2000000b005009920b6afsm1547799lfp.9.2023.08.28.04.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 04:42:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 28 Aug 2023 13:42:13 +0200
Subject: [PATCH v14 1/9] MAINTAINERS: Add entry for Qualcomm
 CPRv3/v4/Hardened driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v14-1-9fd23241493d@linaro.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693222948; l=984;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yngLWB8rmlXy5jjSjZ5Lm9GxiScjZReK/CD/vnxmRY4=;
 b=KdzZj8d+LpwunRLtMGgSF+OHlCpEot6WiekjhdSnUHsfIxb1gZJSAqI93Lqksed7oiVwl0hU6
 3kZHZi44jHbBJRBgraivx/9QhFzeRMfJjPZGcu6PXGDBf+cGoCbvP92
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add maintainers entry for the Qualcomm CPR3/CPR4/CPRh driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: rebase, update AGdR's email]
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37b9626ee654..0f46306abf37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17678,6 +17678,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
 F:	drivers/genpd/qcom/cpr.c
 
+QUALCOMM CORE POWER REDUCTION v3/v4/Hardened AVS DRIVER
+M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+F:	drivers/soc/qcom/cpr3.c
+
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
 L:	linux-pm@vger.kernel.org

-- 
2.42.0

