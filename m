Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA11776B010
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjHAJ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjHAJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:57:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD87CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:57:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31751d7d96eso4593883f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690883826; x=1691488626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1d1V+cLNsVcpTqtIF4+fUcW9E9CXlGy0gRkhFZnoVKg=;
        b=WF74t1WryOH/fLykzfMBemiBwU/l8L1G9u2aEqqg/ziDdBr7OxmRk8enIar2C394TN
         ujipU9V0Epftpe1ur7tbDTMjH+v/6K/zBrPjrcH4snHOTxi3xfBFbj9gD5A8+l2/Z7rH
         2TOA9EHtQffQBHTyqM6InopT76+nNjefrCJyuLlaWJGZinQZmzKc7xbrNYiAljPCvm9L
         ZuCajJIed9+ZswOx2M6WjWz+57S3Gk69qWXQNTZAjNux4KSgVQzl0lUns0YBH5K5MPl7
         uMH5Z6YWVT8VIrkBgO7fBIFJcL5riiqK3qhiVsa9+6oDLn4EE+E9izN3zZXyOLdSlM5J
         IiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690883826; x=1691488626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1d1V+cLNsVcpTqtIF4+fUcW9E9CXlGy0gRkhFZnoVKg=;
        b=HUsE0u/8dWd2f9ZYEL69HTVpFq+e1NBcjInSBXLxztPL6Hl+k6F2rjl6iDUFY6b+2E
         MOdjxRUkwGnc5kIM+jp+AuRoJyumGSETtKgagGGHV+Y1cWzlT8LdnO53gAbFu1CRMd+R
         ukHNxixZmqS8ESO+dyY44MRnQgAZN1S+OMGwbQZJE3PVpoeHOiLT7aTvvKvAUS8jgInJ
         p0wfxy5ksK3kxUvM+sJ9vA0Ldz5pDl7m/0CiaOef9f6AKJcEyHaTLhGnj0M3IHRItjT3
         Ajq3t5BLb79DlJi/6yH0IVCzung7L+eKqDxBqCI4zbbnVNe6l1F7leN/IsSZb4UZlEW5
         K+Tw==
X-Gm-Message-State: ABy/qLZWocCdcjCQ8e5x+OSJDKnrGuNBgVOCdE2b0m0o0rS7szx95q5o
        eED8BaLdWwZ65NVunxZWQo/o6w==
X-Google-Smtp-Source: APBJJlHgYYyvvbhT2RjOmVbcb22DHXlapgDLNFjGodT9QTDbjNFNmD/+R/o7vC1LiCsvXidFcFXKrQ==
X-Received: by 2002:adf:ef8b:0:b0:314:2ea7:af4a with SMTP id d11-20020adfef8b000000b003142ea7af4amr2022493wro.13.1690883825933;
        Tue, 01 Aug 2023 02:57:05 -0700 (PDT)
Received: from hackbox.lan ([86.123.96.80])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b00314417f5272sm15730957wrp.64.2023.08.01.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:57:05 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550
Date:   Tue,  1 Aug 2023 12:57:02 +0300
Message-Id: <20230801095702.2891127-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LDO 12 is NLDO 515 low voltage type, so fix accordingly.

Fixes: e6e3776d682d ("regulator: qcom-rpmh: Add support for PM8550 regulators")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 88ddd6c54d04..d990ba19c50e 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1067,7 +1067,7 @@ static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
 	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
 	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo515,    "vdd-l1-l4-l10"),
 	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo515,    "vdd-l11"),
-	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo,    "vdd-l12"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_nldo515,    "vdd-l12"),
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
 	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),
 	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo515,    "vdd-l15"),
-- 
2.34.1

