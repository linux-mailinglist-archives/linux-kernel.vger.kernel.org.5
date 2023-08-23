Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76EA785377
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjHWJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjHWI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:59:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E831BF5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:56:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c353a395cso713419866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780963; x=1693385763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YqlRnGn91OunZJYlfRXxcxuSNxkSRF2lhtC/uoZUWdY=;
        b=NPGJWXuFHTLs3hVd8xiCycCq5eiBtcaCRR0IylUW3tigJMYQz4c3rM3KmPo9E0agZI
         +1l0XB8sVDKotqmLDoqPRDyvq5+gTBKe1NhaIlx0pvczPklsabqpPb99fjQegXZnyyYq
         QsuutC1YSO++KQudYR+xSm6xiaC1srkle9BwA3DVRTfxvt3q/+s3wWXM57ogq2RSYM78
         KS2+WHdUsjboOIVDr4D+hq+npZSrapKnQtl2U47+Bcy8/dj7L1R45IE9z5XcnXmTMiw9
         VVVTOZLjK4Idr+Jibf2thaOz+Bu5atyQqCo3YyfMovoxLs0BrxQF/xVQCCOhCNQ7Gr4N
         7X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780963; x=1693385763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqlRnGn91OunZJYlfRXxcxuSNxkSRF2lhtC/uoZUWdY=;
        b=ZE5lQz9PJ1vI3jhu8jZ3/GJhg2scx7qYHIOhmur4g2RK0rj2E/n0plulgwtEJCDY28
         nlcAQVUscE7mI6KKUC7RiRWrb6/gXZlsqH7n1fFwUtVslqfrQYOIZzjvWFsMxJLmgKCy
         aYfU5giuCzE3ctNB3q+zpyWw8aTCsm1AMBXpkeX9pftghX1n2VdwoJUm3RvtQuD/Eokv
         5z+UzHUyTmaAiqG3b3eL1MZGDXjErPuZNhredejzhF+bBwJIMbm8ioqsB95wDx9ClDux
         nFsmjGbfdC3HtnT6/pgNAEXYnlSMHOg5ag6KCx9jd5yoeVskwk74fpLh6RPC4mQZQQRN
         TENg==
X-Gm-Message-State: AOJu0YwWDILJ2YnPkKY0RB1rAOCFIzV5cxtlmvjjReY1T+6PfIMrCy1W
        46aY1ZMmHCr/8XF8WWWMnd8q7Q==
X-Google-Smtp-Source: AGHT+IH5ON0hBjZilGsUTjY604t0NGm/QEhcyl3p/yRnfW98/az7hiraLeTiA9xdATV4s5kQ8wPbPA==
X-Received: by 2002:a17:907:7635:b0:9a1:d915:d8dd with SMTP id jy21-20020a170907763500b009a1d915d8ddmr1032848ejc.10.1692780963486;
        Wed, 23 Aug 2023 01:56:03 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906a21900b00992f309cfe8sm9528251ejy.178.2023.08.23.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:56:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] power: reset: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 10:56:01 +0200
Message-Id: <20230823085601.116562-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/reset/pwr-mlxbf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
index 12dedf841a44..de35d24bb7ef 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 
 /*
  *  Copyright (c) 2022 NVIDIA CORPORATION & AFFILIATES.
-- 
2.34.1

