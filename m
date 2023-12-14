Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D50813993
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572989AbjLNSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjLNSNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:13:45 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7340A10A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50e04354de0so4916524e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577629; x=1703182429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVQf3dbyT14ng4SO14NJqgagpvGCqqxla+LEC+UJVYU=;
        b=VrUyXg1Ck0uRtmA0qq+4EHsgo06J0qHEDi8kRxD//82wtPzVbR1+ztIlaWs9qpByyE
         aBuNjeq3u6waNuCgZmUpclJw66mSH6iAV/QNEqUynxqahaIDXPAnTwNyyW76HmrhPid6
         LyBXTid3qAQQ0c2Uge1nc1/hsXUiycRrauKwSDgWrlheOMUjs9PsIrsZqWDt7v8Bv/Jc
         S4hjlmzOo3hHL5uHOpflVy/zuIt4tAdf3uzxNae8jeMWz4kjolD8d63lPW7jE5qIlvAK
         +lz9eIqPXmPwMwcI86EErV09yrSEat8yX23lb68xLKzDqqUpIiuAA2jA1fYnyNwVvN9y
         +xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577629; x=1703182429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVQf3dbyT14ng4SO14NJqgagpvGCqqxla+LEC+UJVYU=;
        b=dgEfWmmC6kbV6xXtnopFVgJmboq7dgJM+w3lYEoExkAFrPFDdYtZr9JboIBxILSoIr
         BSxHlYSppSQX40QtwDY0X+ISiTGjoqK5tBjQVCWlvODBhjv0Xej1FRfisNZNl0W42Lrk
         3mFmbx3Jsw/TUxjjg3ZJcrCRt3yxP5NZC/BQ/5JRdG2R3ODo+WzKpjZCk448p32MjaeK
         6q7lW1+KR0jN+PL/qa0YnSC/stypou1nlsKFHKRHiX8dTURvyqMAxuN+wEjDe42s/1GT
         HIWO0nypXLlpPKjuYKkxQfrC8DTjNpsQU08GbIvIdxQ3/Dhc51jzCSQIry0RKG7ibKH7
         4naQ==
X-Gm-Message-State: AOJu0Yyxh0JefmG93YzhZYfpx6pqozfZGAxbDFQ8Up1xtLiDmciiPI7t
        aLkDsYV+UcP/HDObMURs4LAbcQ==
X-Google-Smtp-Source: AGHT+IE6Y+zGN2MX4oNmeEjKqUQAvJwmAAdCFaira+2M3Z3fMM7AKCqXMPs7r9pionVuu9nbZZXonQ==
X-Received: by 2002:a05:6512:48d9:b0:50b:ecae:d8b with SMTP id er25-20020a05651248d900b0050becae0d8bmr4821204lfb.105.1702577628609;
        Thu, 14 Dec 2023 10:13:48 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm1928838lfu.48.2023.12.14.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:13:48 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 14 Dec 2023 19:13:38 +0100
Subject: [PATCH 1/6] interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-sc8180_fixes-v1-1-421904863006@linaro.org>
References: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
In-Reply-To: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Gustave Monce <gustave.monce@outlook.com>,
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

The CO0 BCM needs to be up at all times, otherwise some hardware (like
the UFS controller) loses its connection to the rest of the SoC,
resulting in a hang of the platform, accompanied by a spectacular
logspam.

Mark it as keepalive to prevent such cases.

Fixes: 9c8c6bac1ae8 ("interconnect: qcom: Add SC8180x providers")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sc8180x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 20331e119beb..03d626776ba1 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1372,6 +1372,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
+	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &slv_qns_cdsp_mem_noc }
 };

-- 
2.40.1

