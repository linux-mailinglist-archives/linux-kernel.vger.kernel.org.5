Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4027768E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjHITjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjHITjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:39:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425CC6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:39:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso3095851fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691609948; x=1692214748;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jmLyZ5qsVOGSKE5nYY/XIbEhaHmVwTjqouIJNSf7rI=;
        b=UyRYRvp6A8hBzlKaRKrNzhCNdCZICVHzg/qXEz+UT5Fi9KcAaJaBykzgqAwgwcpT/P
         6pCy3/948rqF+40usGpNU4LuKy9fa05lpOOCthDZRSdEu0XAbOMz01grDiKbZvBV/sJu
         1wLbypSPrO9W+H4naSAKfu8GqDU4vv1hoiFT9hnR2B/sPGlWf61YV1eAK5ms6XqWJmmW
         WGP/CB+E/UIwgc+UW1dE77A+ymI3eWApiKM97cOhd5OyX9ZCuHWakqXAV/fCyWzh+C84
         uaibbym3GVI6YOS3dU20MSlPrhCLPYzaviXcrRqIxgFilfRMG07hIOjENz2ZTVDuTYu/
         iVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609948; x=1692214748;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jmLyZ5qsVOGSKE5nYY/XIbEhaHmVwTjqouIJNSf7rI=;
        b=WXRC8Mu/hbMF6axXrSzdYTUB4JZHMAGDqy8DGKEXwWQGQoRmJjY4+LLjfbhQHg/WFZ
         8lCwfr3iu+yK9T1Zpjs0pU+Yrtm5njT1fycUilZ4h45mEPEBvfo2/USpz08pYSkcB5gw
         PVZoM4PypZmslCdQZDdYMRlQbQtW/OvYKUSyNcsOFcpqunKqYny6gujJBzaDYc9W/KUN
         UshdsSQ0kc4AxkyMAg+68HzVcOoQux7XLPQB42JaLIIq+4hBK+wSERePQVlLwGdvQ7hl
         m5CxrLIDUPOomcAE7PwILMk54U41bWzuLvwNp9UeVJxQwqEFxOl5qS5X6inVoY4UBipy
         qXuw==
X-Gm-Message-State: AOJu0YzR/tNjKNpUBKoXN42QdL6QfrJ8Bm0FYRXlZps7Bxgh2/KHaT7p
        vXpzayQB5gD68drpcI+QCAoJQA==
X-Google-Smtp-Source: AGHT+IH8iIbSc2i/fHslt6od09mNscVpJv3FRCvqGxwdmpCToHIG3FH/nKHDBSWPCdLjUzENf6xIqA==
X-Received: by 2002:a2e:8893:0:b0:2b9:5fd2:763a with SMTP id k19-20020a2e8893000000b002b95fd2763amr136182lji.35.1691609948107;
        Wed, 09 Aug 2023 12:39:08 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e9c86000000b002b9fe77d00dsm2885287lji.93.2023.08.09.12.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:39:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/5] MPM pin mappings
Date:   Wed, 09 Aug 2023 21:38:53 +0200
Message-Id: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE3r02QC/x2N0QrCMAwAf2Xk2UDXTZn+igzJaroF1qy0KsLYv
 xt8vIPjdqhchCvcmh0Kf6TKpgbtqYGwkM6M8jQG73znBnfF15YlYMrpkShn0bli18boh/PF9z2
 BhRNVxqmQhsVSfa+ryVw4yvd/uo/H8QNFnvSAeQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691609947; l=983;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=T5Gz0zorupBsGdJnfNzc+lNBLG7ID2DnaWLzds/HTeQ=;
 b=SEmr8AV3WmgkCRDQK0St3O5sEFeD4cSLLAir0u5TmjK1sYy2scF0mb4EfeHwYVhfvIa8y7LDL
 pybnSM3qDlQAlH9l9IYiWeHHTT2DDp9bC75jPmIg5KuMmML73FvBKfp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the MPM wakeirq mappings for some SoCs and fixes my
"big oops" within the 8998 driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      pinctrl: qcom: msm8998: Fix MPM mappings
      pinctrl: qcom: msm8996: Add MPM pin mappings
      pinctrl: qcom: sm6115: Add MPM pin mappings
      pinctrl: qcom: sm6125: Add MPM pin mappings
      pinctrl: qcom: sdm660: Add MPM pin mappings

 drivers/pinctrl/qcom/pinctrl-msm8996.c | 15 +++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm8998.c | 19 ++++++++++---------
 drivers/pinctrl/qcom/pinctrl-sdm660.c  | 14 ++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm6115.c  | 12 ++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm6125.c  | 14 ++++++++++++++
 5 files changed, 65 insertions(+), 9 deletions(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230809-topic-mpm_mappings-31ff2856244a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

