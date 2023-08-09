Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86F7768EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjHITjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjHITjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:39:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F110DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:39:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so15411901fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691609950; x=1692214750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/ZCzffNd4VjgfPfI3FvCPGEBawQZB9kqBgHWNy6ki8=;
        b=W6DC5u2ztKlZ6rKzWGCpk0KZHaZCvGOVzHvJ1QLxXNCV6FoYgB38PohUvaDpxZgGHw
         kSSjj31ZJMVDUDZVclLt8MunljCGYsTU0bAWBuX4HGRWOJQ3cPKSHuazQYwbfpMeY7Zo
         0yECewWD7YzNj2bgr+c8vxEb3JT6/rKVoWgGZEYDz7XXz86hUS4s4Fg7JBJyZRh2gOXb
         v/9zNjd7W9ooqZsgyq13tQVFnAcMKE5BKHC/2KTLtZNM41KRCTkZyJoEQmAvCkUQBeaJ
         awazdnn7pETP44FxuFdzdgnihm8p9I1yLR4M/AZVHW2PkYbK5DWD9fYGCApuFi/nZHKS
         p09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609950; x=1692214750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/ZCzffNd4VjgfPfI3FvCPGEBawQZB9kqBgHWNy6ki8=;
        b=PkjbeCR+thUQZ68HVb33/TEeIaVe7CFsu2IX1gjpg7eNe5SbAa10Q8RNNnr2aTqLfn
         rB0SoN0qLSBdW2Vm5a+pm7F/RRt78KlYo2JWwlx0W0RmrqMMsQhzjkUj5buFXRCmCwwY
         Y69LoQp4/6JJW9WztcP4JCl+1R+c5lb4v8L3YNrGD5H6L/ohvolRZKtAYqHYgzOQAG5l
         fUiwoJn2HP6Fmr7nj2ISJo5XJkATf8UHF9UJYoTxL23whH+A/stv0hCBW/R1CiHLwCJh
         O/epwfoLXUfJNXPuF8ijo6nA6AbgAuODG9cUkgz1+/2Tree1wKQxHM0iLDuatFS+w9nT
         KKUg==
X-Gm-Message-State: AOJu0YyVC71Odt8uvIHKUwHr+cK80GnaoSiShFrpBdd3A4IymyOPgQxR
        KfuqkqJGrJt8fXh3xlSGoeTL1qcd/OEuvPHkVok=
X-Google-Smtp-Source: AGHT+IEpcxHLCLy+tp5VWY2y1CLPV67l3/9e/fwvfXS7Opiz0Ua1sxmTXXkqpLnXMGnImLfGLjG9Hg==
X-Received: by 2002:a05:651c:c91:b0:2b9:e705:6303 with SMTP id bz17-20020a05651c0c9100b002b9e7056303mr215972ljb.4.1691609949650;
        Wed, 09 Aug 2023 12:39:09 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e9c86000000b002b9fe77d00dsm2885287lji.93.2023.08.09.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:39:09 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 09 Aug 2023 21:38:54 +0200
Subject: [PATCH 1/5] pinctrl: qcom: msm8998: Fix MPM mappings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-topic-mpm_mappings-v1-1-5e17dd76b3c8@linaro.org>
References: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
In-Reply-To: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691609947; l=2512;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hCfkcXPkFWRhbSb1h+V6CJXQhWHaCdAB8TPVfPD9pXM=;
 b=S8jiSSCI5NcJ3Fq5TU/y5Yf0Pu1Z4aSwXDxAv9ccPX9HiW/hlU9rRM/sHWbZ50t6iK10+z8r/
 4sRvLNwCrsIBOzGkAtxxfKzboXAWnNb0p8oMCEuAzwfO3d5PyEz8Ske
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 29f6e7e379fd ("pinctrl: qcom: msm8998: Add MPM pin mappings")
added a map of pins <-> wakeirqs. The values in each tuple were swapped
and the last one was missing. Fix that.

Fixes: 29f6e7e379fd ("pinctrl: qcom: msm8998: Add MPM pin mappings")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm8998.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8998.c b/drivers/pinctrl/qcom/pinctrl-msm8998.c
index b7cbf32b3125..08d6e555652a 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8998.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8998.c
@@ -1496,15 +1496,16 @@ static const struct msm_pingroup msm8998_groups[] = {
 };
 
 static const struct msm_gpio_wakeirq_map msm8998_mpm_map[] = {
-	{ 1, 3 }, { 5, 4 }, { 9, 5 }, { 11, 6 }, { 22, 8 }, { 24, 9 }, { 26, 10 },
-	{ 34, 11 }, { 36, 12 }, { 37, 13 }, { 38, 14 }, { 40, 15 }, { 42, 16 }, { 46, 17 },
-	{ 50, 18 }, { 53, 19 }, { 54, 20 }, { 56, 21 }, { 57, 22 }, { 58, 23 }, { 59, 24 },
-	{ 60, 25 }, { 61, 26 }, { 62, 27 }, { 63, 28 }, { 64, 29 }, { 66, 7 }, { 71, 30 },
-	{ 73, 31 }, { 77, 32 }, { 78, 33 }, { 79, 34 }, { 80, 35 }, { 82, 36 }, { 86, 37 },
-	{ 91, 38 }, { 92, 39 }, { 95, 40 }, { 97, 41 }, { 101, 42 }, { 104, 43 }, { 106, 44 },
-	{ 108, 45 }, { 110, 48 }, { 112, 46 }, { 113, 47 }, { 115, 51 }, { 116, 54 }, { 117, 55 },
-	{ 118, 56 }, { 119, 57 }, { 120, 58 }, { 121, 59 }, { 122, 60 }, { 123, 61 }, { 124, 62 },
-	{ 125, 63 }, { 126, 64 }, { 127, 50 }, { 129, 65 }, { 131, 66 }, { 132, 67 }, { 133, 68 },
+	{ 3, 1 }, { 4, 5 }, { 5, 9 }, { 6, 11 }, { 8, 22 }, { 9, 24 }, { 10, 26 },
+	{ 11, 34 }, { 12, 36 }, { 13, 37 }, { 14, 38 }, { 15, 40 }, { 16, 42 }, { 17, 46 },
+	{ 18, 50 }, { 19, 53 }, { 20, 54 }, { 21, 56 }, { 22, 57 }, { 23, 58 }, { 24, 59 },
+	{ 25, 60 }, { 26, 61 }, { 27, 62 }, { 28, 63 }, { 29, 64 }, { 7, 66 }, { 30, 71 },
+	{ 31, 73 }, { 32, 77 }, { 33, 78 }, { 34, 79 }, { 35, 80 }, { 36, 82 }, { 37, 86 },
+	{ 38, 91 }, { 39, 92 }, { 40, 95 }, { 41, 97 }, { 42, 101 }, { 43, 104 }, { 44, 106 },
+	{ 45, 108 }, { 48, 110 }, { 46, 112 }, { 47, 113 }, { 51, 115 }, { 54, 116 }, { 55, 117 },
+	{ 56, 118 }, { 57, 119 }, { 58, 120 }, { 59, 121 }, { 60, 122 }, { 61, 123 }, { 62, 124 },
+	{ 63, 125 }, { 64, 126 }, { 50, 127 }, { 65, 129 }, { 66, 131 }, { 67, 132 }, { 68, 133 },
+	{ 69, 145 },
 };
 
 static const struct msm_pinctrl_soc_data msm8998_pinctrl = {

-- 
2.41.0

