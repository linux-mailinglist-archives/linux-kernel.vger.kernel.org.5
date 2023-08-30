Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B878DFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbjH3Tbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbjH3J67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:58:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE092CDB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:58:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c4923195dso675930066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693389534; x=1693994334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMaT33TMEcSdAqEfjzHnfiZm0MHlTu0tg8DNCHLNy/4=;
        b=HBV0EOKdS+6uEzk0jhmP4YwUyavmqI+ctdqAq583d3cTi2Q+Th15NIUXDqyct9quqa
         9DxMt2cfdeGsCNqfRmjY8t/TRlgycmD2mJVi1Af9vWfusDSZamFkPidxgLd7bbsPziwn
         dWDVoVIiSXOYCW4HAwCh8jAd67gTLXl+NR2ybhHIxQH4XKW1zkFY5PVXhXA9zjlpE+db
         kkzlt3dFT8uW4Kem2lICOB/moVgQERsQPy/7C879ou1ZGJvjF+NEWlms8zZD9f8ihiz0
         u1KK8yDsm+aXe08FZq+WPFy01p0pfpPI8G3k/7ATYDJEfpu/z2T4fU5NDEyw/QulgT/e
         2rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389534; x=1693994334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMaT33TMEcSdAqEfjzHnfiZm0MHlTu0tg8DNCHLNy/4=;
        b=DCPZzlEmBD/jPKAAT4N7hj5XCrPTSeUpzq+ZAgVvlmqeDVlYSNGypL84vEdGwVA9fV
         xoAPtfVxmw5vl/Tvip6km0WcQB9r/TW6jwrwioAHnR3RpCOr7kTE8fvaQx+p/VrU6vV3
         6ec5dW+4dFgGOGcU3cDOptnVVwktgU3VTW3Mv3Q457fCbHzakMWAk/fsQwyi895ebrEf
         9vv9W/3PCynxRJV29bLPdOpX6+yLpzgZeI8qSAL/uCnxcapST9a2BW8QObpvgjsOnejr
         T6QepsoDFhKTHuSS21Py/TeZTs+g6ipWtP/g7nYBsOlLYXEUbCg65p6XWHiCDlpdsB3a
         eB3w==
X-Gm-Message-State: AOJu0Ywko5HgA730UVyD23KnAIthkYJm7dyWJjJaxE5GqGhTtkMU5uJT
        iIepd5nzmc3asVrtdxeypd5W7g==
X-Google-Smtp-Source: AGHT+IEsayzgtGNMlFizdpOnfPYW6WrLF+nLZTrAoohOtQ7FLTkln95jhDk+INqp8xVX4Gj4B65n1A==
X-Received: by 2002:a17:906:20dd:b0:9a1:c89a:9260 with SMTP id c29-20020a17090620dd00b009a1c89a9260mr1229467ejc.51.1693389534562;
        Wed, 30 Aug 2023 02:58:54 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (5073ED84.static.ziggozakelijk.nl. [80.115.237.132])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709064ecf00b009a2202bfce5sm6957130ejv.118.2023.08.30.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:58:54 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Wed, 30 Aug 2023 11:58:34 +0200
Subject: [PATCH 09/11] cpufreq: Add QCM6490 to cpufreq-dt-platdev blocklist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-fp5-initial-v1-9-5a954519bbad@fairphone.com>
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
In-Reply-To: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm QCM6490 platform uses the qcom-cpufreq-hw driver, so add it
to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index fb2875ce1fdd..02ec58a8603b 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -145,6 +145,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,msm8998", },
 	{ .compatible = "qcom,qcm2290", },
+	{ .compatible = "qcom,qcm6490", },
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,qdu1000", },
 	{ .compatible = "qcom,sa8155p" },

-- 
2.42.0

