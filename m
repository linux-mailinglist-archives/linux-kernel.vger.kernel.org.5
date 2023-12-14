Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56B3813A10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjLNSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:36:42 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1578115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:36:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso11469856e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702579007; x=1703183807; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2agBAQIISiGm5BjQKQDZLX7+yyTNUH3OxJ2AW1m180=;
        b=YdVCRKG899iNweKUAeh3gBh7CoD2htMTRTawc6xAaDRYh1ZI6H4s9zvHdThihTpcSb
         CwgUF1/DAVgd8lgNazxq1fa6C8iNQI95X6cyZkSm5cKxuZALTNraqQtgma2nXPPqr1U6
         GYr1vYB9Xz03IvaQjlZdV8x/IYFVH/wtmLD3NRTFTBfRqkzsLputmcjbGkzf8POaCESx
         3nLk6x+g53/rFbtBY781C+tpNPCilkzyO3reXLfyL5aCyJS16xniQ78ITApjDuxWhAIS
         WYgGQxQQuVe4/uYgiUGB267wQ3uGKDeLBpdxA0AKbAxeqtBcyAWzGd0KU39ix+qok6ko
         CDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579007; x=1703183807;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2agBAQIISiGm5BjQKQDZLX7+yyTNUH3OxJ2AW1m180=;
        b=Jcf4HHkLd9h/Dd/vQUrxZldhO1VjSrhmS7NF0ca3CeLJNLSZeVPMjaip85c0yWUNNZ
         uGYyMyPqsj1WIL7FrGuJ989kwdBP+1fQDB01NQfNb5ExMBdEk7MUf5sR1XMOjTjQoCLU
         JlMYJW/Bhlpxle1HWeqBWPRIBgxME2pnZbjSun9t1OoETT6NP1N0AYqCTQkl4UfvcXH8
         g8YM29dK4rrag2Cm2rnUQhwKdhjvz4NiE6UC0VjF+qICjNpdLcitDT53qIkfa8oekdWI
         S5Tl++2oCb4Oyb9XLTjUW8LgkmTuONDTmQdkBg2CvavXQjXpL2uZutLhTrDDYRbG833D
         ow9w==
X-Gm-Message-State: AOJu0Yy3JshF62q+kDOHiwsKbySSeN21KjlYLwQQ296e3m8baePKYeT3
        ZAsR2ublyGfN99hzO8c4HD7s8A==
X-Google-Smtp-Source: AGHT+IGQMIUz/OELOVckBLP40+nDk50xRpbqd8QsbgXNin9cwtwb49ZEcf8JzeGg38O4QPZGSyTpiw==
X-Received: by 2002:a05:6512:4db:b0:50b:ed58:584c with SMTP id w27-20020a05651204db00b0050bed58584cmr4541681lfq.124.1702579007106;
        Thu, 14 Dec 2023 10:36:47 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k11-20020ac24f0b000000b0050ab2d4d7cbsm1943828lfr.19.2023.12.14.10.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:36:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 14 Dec 2023 19:36:41 +0100
Subject: [PATCH] interconnect: qcom: sm6115: Fix up includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-6115iccfix-v1-1-9ad999683a7d@linaro.org>
X-B4-Tracking: v=1; b=H4sIADhLe2UC/x2MQQqAMAzAviI9W7BzCvMr4kFr1V5UNhFh+HeLx
 wSSDEmiSoKuyBDl1qTHbkBlAbyN+yqoszG4ytXkyON1nMrYEjXKvOiD7eIbCqEKkxBYdkYx/S/
 74X0/kqmUOmIAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unnecessary includes and get rid of the abusive of_platform
in favor of the correct headers.

Reported-by: Rob Herring <robh+dt@kernel.org>
Reported-by: Georgi Djakov <djakov@kernel.org>
Fixes: 2eab57b131bd ("interconnect: qcom: Add SM6115 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm6115.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6115.c b/drivers/interconnect/qcom/sm6115.c
index c49a83c87739..88b67634aa2f 100644
--- a/drivers/interconnect/qcom/sm6115.c
+++ b/drivers/interconnect/qcom/sm6115.c
@@ -6,16 +6,12 @@
  */
 
 #include <dt-bindings/interconnect/qcom,sm6115.h>
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
-#include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/slab.h>
 
 #include "icc-rpm.h"
 

---
base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
change-id: 20231214-topic-6115iccfix-6f4519909be1

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

