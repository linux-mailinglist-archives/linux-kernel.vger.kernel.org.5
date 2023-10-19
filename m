Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44A27CF5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjJSKui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjJSKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:50:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77081124;
        Thu, 19 Oct 2023 03:50:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso71216595e9.2;
        Thu, 19 Oct 2023 03:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697712621; x=1698317421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0naVyUeSmTC7NBi/QXx7z14rWsTMmPuek5i541kbChk=;
        b=PgF6XgDNP/o1D1DfUjFz9ONNlBUv5VN2XhOX/7P9MmOyDwYVYakd8ZW2dWuUsV0Il6
         68jW/qzjqIIQkG9u/k/L5iXOVCuuz2JgwOD3qETgwcl6UFUVe0uhDaOaBxNgLrKLoShy
         5/ZvJL4JxerqFXlqXEw/KxVIWAIbwNgtKvI9SkhnRMb65iutqY5LxqtbiL3K/rdt9JTV
         5vnG7YOzs1Py2BowahGUs/3JTabqvYdVNQeOk+ZqY8MzU9BoOl8S8lZ0t/TklpQYVv/g
         ln4TAk8JG/ETZSqQz9FYfPeEg+Cp83zQI8pEdo30nF6Eoa5ueCZTmu2TfP2ZP8e8T1zV
         6ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712621; x=1698317421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0naVyUeSmTC7NBi/QXx7z14rWsTMmPuek5i541kbChk=;
        b=PKr5jcztOHCifB5iV/fb2c1XACiz/wARgRjrzywx2Xd7+AFB0r10KtE6rnoBksi3uJ
         MlQLJbWa0xq2/qHAKxYV05rOwxU0qOo4teszuBaMgvdvvZASFL+ZJ+J4Vs3RXmRQ+Wiu
         iimwFHPiiUoWsH1N7k62DpdlUDJc4y+rugbKBax2Ak17mZXfepsvN2Sc2a78cu+89Ly7
         iiEGtXQeRXjVxxl7qulkeZFYWDjYMlj4c3oNR6+kVpg3yO49v0RNAUdMyq85P04GqZo0
         3iq7U5AgNbzfffrWNc6T9PnLNRIX4VNrcqiqy8eDJwHBGb7jV2BESwNyv7i/YmaVDO7C
         mIIw==
X-Gm-Message-State: AOJu0Yzas7Xq6Zr8rBanM2U/yg6N+riQKyyqCmDCOkCoopc2+WplXhmq
        sG/TDQXo7BCUlEvgJ3g3x9nKbyudDnE=
X-Google-Smtp-Source: AGHT+IH1D92oyQQikNYUtEM82hVGX1QwIVrW7tZZA0+9MqH36DSuOwfz16ZteI8WYuigyQLCFiUeNw==
X-Received: by 2002:a05:600c:511b:b0:402:ee9e:ed98 with SMTP id o27-20020a05600c511b00b00402ee9eed98mr1488997wms.34.1697712621541;
        Thu, 19 Oct 2023 03:50:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id bh9-20020a05600c3d0900b003feae747ff2sm4129511wmb.35.2023.10.19.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:50:21 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 2/4] cpufreq: qcom-nvmem: also accept operating-points-v2-krait-cpu
Date:   Thu, 19 Oct 2023 12:50:09 +0200
Message-Id: <20231019105011.7289-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019105011.7289-1-ansuelsmth@gmail.com>
References: <20231019105011.7289-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

the qcom-cpufreq-nvmem driver attempts to support both Qualcomm Kryo
(newer 64-bit ARMv8 cores) and Krait (older 32-bit ARMv7 cores). It
makes no sense to use 'operating-points-v2-kryo-cpu' compatibility node
for the Krait cores. Add support for 'operating-points-v2-krait-cpu'
compatibility string.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v7:
* Add this patch from reverted other series
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index c399b5014b49..57842d60d6ec 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -369,7 +369,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
+	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu") ||
+	      of_device_is_compatible(np, "operating-points-v2-krait-cpu");
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
-- 
2.40.1

