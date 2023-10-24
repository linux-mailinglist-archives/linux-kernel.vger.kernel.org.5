Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB837D5217
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjJXNqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjJXNqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:46:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A79E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so681005866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698155189; x=1698759989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/PDZ9kO7G74nmKb1u4SH9mYF0IVyBxsHL5CzZjHNxg=;
        b=a2nmV7AAYue7cDE2kf8E3r2cs2/ufpJLS+2aXFOe6f5FbB+hA1iH5ah3ffb4loLVxv
         KdXSMdwnvuzoudP0tGIWbvx17n8sB3EFVRrGK33REZhDnYoeyXW6xDfTcCLHCZJ95d+q
         tLhD6R3UzUt3qsT48ZIX5dDHigRwXq8bAPlMM7urudRb/jCZuMR/62whvu5aYlnX7VDn
         ALzhFqA/3sqAsPud2J4qC0p8So+5Dy6GIAzU50P0G+DfvylZPwMpIsSvFKasEn0G+ZpK
         s2AXdjg6BOuoddcm1SJSBjUDhvQWH3ie1Ptt41ovEQJNh6eBrFwf2TfzUr/TofTyv9VO
         1UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155189; x=1698759989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/PDZ9kO7G74nmKb1u4SH9mYF0IVyBxsHL5CzZjHNxg=;
        b=QgRmtqEXbpoEhHFHaGT+RqeHsncWOFH5Ru3U99dXJy2J3XMOPnmfQvq6eJKiM1rzG1
         etZYXEaBQ74J6WZ+bblyVE563gcUwS1dquA7BCwerFFbo6Xxd+Mpb+OPvy9T8o6yp+Mr
         LfiEcXspcLwjscp/i/015ox8Lwtw5vdVDcdmExVyyzbCwt1ijdkzrtA99bTilN6dPlaV
         6TnBKhhzSam5bakmuiFafo/b7z1CINDk2FRssVEwRwPqtCP9w8rfq1jTK1P8prCj2J2+
         LvoWmv1nYkKpnSP2oDxaiI1BGycEqjWZIDvue+/6b7OUQ0VLiduoKO6VQWUu7CypsyKk
         XCWQ==
X-Gm-Message-State: AOJu0YwCgZLHl19tx670wHOFj2TIwR+pNRDGcaxpvX48J/ujXS+1XFVe
        SbK4nCb/wpKMzBN7jBuifQS9bg==
X-Google-Smtp-Source: AGHT+IF+1tfBFlWZ5ekM05Nq5pyNWfVPceFIGTk4iLH6nqXJP1nu6iyfuNMw3LtQyviPzDKHUaf2XQ==
X-Received: by 2002:a17:907:3ea5:b0:9c3:8242:e665 with SMTP id hs37-20020a1709073ea500b009c38242e665mr10019942ejc.8.1698155189411;
        Tue, 24 Oct 2023 06:46:29 -0700 (PDT)
Received: from hackbox.lan ([86.122.213.220])
        by smtp.gmail.com with ESMTPSA id og43-20020a1709071deb00b0098951bb4dc3sm8320367ejc.184.2023.10.24.06.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:46:28 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: qcom-rpmh: Fix smps4 regulator for pm8550ve
Date:   Tue, 24 Oct 2023 16:46:26 +0300
Message-Id: <20231024134626.2364426-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of the smps4 regulator from pm8550ve is actually FTSMPS525
medium voltage. So fix it accordingly.

Fixes: e6e3776d682d ("regulator: qcom-rpmh: Add support for PM8550 regulators")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index d990ba19c50e..b2e359ac3169 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1095,7 +1095,7 @@ static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
 	RPMH_VREG("smps1", "smp%s1", &pmic5_ftsmps525_lv, "vdd-s1"),
 	RPMH_VREG("smps2", "smp%s2", &pmic5_ftsmps525_lv, "vdd-s2"),
 	RPMH_VREG("smps3", "smp%s3", &pmic5_ftsmps525_lv, "vdd-s3"),
-	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_lv, "vdd-s4"),
+	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_mv, "vdd-s4"),
 	RPMH_VREG("smps5", "smp%s5", &pmic5_ftsmps525_lv, "vdd-s5"),
 	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
 	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
-- 
2.34.1

