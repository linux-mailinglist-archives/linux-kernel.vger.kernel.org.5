Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9B7C7203
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbjJLQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347288AbjJLQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:05:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698EC9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:05:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b64b98656bso186515666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697126713; x=1697731513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h51OwobaWmMhVpSm7Wk+pDxKsEdIOYAESioL6so1I0s=;
        b=uRFtU8k0/QpXCs6kAdXCJ4rawrksGSb7x/+ZAOcJ0XyuoABdQv+kgWmrHMMaqdzbCN
         wElZt6YVGABkBF1alcBXWkZDfJWrT9BHiDcZCPpL2PpIt5lz2zZ8Qqss451l7eqKUCJR
         xaiIfNYI2bOWn2mhIOopUBYkOY4wq2QXRMoUQniQqeyVjD22Cd7pZi4ACrJB2gc+/5HQ
         8qZPQiN2pfXdQlcWgjbhRjKepiNOe+MdwHmcCcgtpGJru6alj6/9OZn0VZvPbM/Vlcre
         LGmjg1g7otPI72zt2KD6Sw/i6Qyh5Mp+dnJeq1alDhZpbn8AM+y17RQQ0VwpbwNzegBd
         omjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697126713; x=1697731513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h51OwobaWmMhVpSm7Wk+pDxKsEdIOYAESioL6so1I0s=;
        b=VtTb3yQf+6MOkpysY/ROqdSbgYIRZfl0eEzNPvdlKzen4oKZ7bYsU40CgjAeCd4Beu
         c47yebtGupjowNjyJI/mQe5DCrPvDREGIrdPoKO2FS+m5G+sqVgnVviiJOWC1rfbkKHW
         c9a2OVAJgpZ01/ypcvC9EGP/cMK7JorxFZM9zHNc6iD62/UJkvWpoPK5fckRRmAJHmRx
         sFRS71rGJ46I4GN0W5mtPLD3ObuGl3RiiXQc11W3WwXCjdR3j4QDX2PVEQcEtaG1V5qO
         9Bxgl/bLfJV82uEvGKF14V5Ut9ZG8x5DBGRT7L/ID0xP9ADtcbcK1g1WEMN8WlGHVQlv
         JC3w==
X-Gm-Message-State: AOJu0YwHM0qnE3nwigXhszmxci0pAL8hGimmEG0udr2CfmElpKvGg2F3
        990bGc86b5q197Mkpjp8mt8ZmA==
X-Google-Smtp-Source: AGHT+IGT12k6sPvkO6Vv3rzcDBB/BNyNYBf7jeFzK9zKN7/feuGRswJeTT5L4dbk2B/jghcibhbAqg==
X-Received: by 2002:a17:906:8447:b0:9ad:fb49:4eda with SMTP id e7-20020a170906844700b009adfb494edamr19729931ejy.3.1697126713592;
        Thu, 12 Oct 2023 09:05:13 -0700 (PDT)
Received: from hackbox.lan ([79.115.22.174])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b009b2d46425absm11305324ejr.85.2023.10.12.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:05:13 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avinash Philip <quic_avinashp@quicinc.com>,
        Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Subject: [PATCH v2] soc: qcom: llcc: Fix LLCC_TRP_ATTR2_CFGn offset
Date:   Thu, 12 Oct 2023 19:05:09 +0300
Message-Id: <20231012160509.184891-1-abel.vesa@linaro.org>
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

According to documentation, it has increments of 4, not 8.

Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
Reported-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Reviewed-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * fixed Unnathi's first name typo
 * added Konrad's and Satya's R-b tags

 drivers/soc/qcom/llcc-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 674abd0d6700..fb4085b7cb19 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -47,7 +47,7 @@
 #define LLCC_TRP_STATUSn(n)           (4 + n * SZ_4K)
 #define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
 #define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
-#define LLCC_TRP_ATTR2_CFGn(n)        (0x21100 + SZ_8 * n)
+#define LLCC_TRP_ATTR2_CFGn(n)        (0x21100 + SZ_4 * n)
 
 #define LLCC_TRP_SCID_DIS_CAP_ALLOC   0x21f00
 #define LLCC_TRP_PCB_ACT              0x21f04
-- 
2.34.1

