Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6115D757BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGRMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjGRMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:19:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF104E55
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:19:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so9392815e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689682756; x=1692274756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZHiNhlcnBcV/12CBhpoH4NhL4fdNzTRpHhX759efoE=;
        b=BkiQdJeW9f9DpFlueQzCM4Ay7onHhbx9JgqfOAtIlj6qfnKF/lOgQwvwtgAoWPkaJi
         Gj/7k/l5d7AD2S1DsoFaQJLMBBrtwHKkZfQwFE9dJY/DpkeuEIDrM/64dzXg0qXUh4rL
         l+Pvabu6upKPpJK9yUwQlTlqdYOgf5zM8ts37HjAKMn6BH7x2bZYrUB/aPSPxIcS3V3O
         Z8+cgfZpj/jdZYMHqwwbMunIX1SgadFdK8vzRApyRU/vr2aQ929GOhxL3tA5p99K178c
         SW/re6vJOs0bXvhLY1RgdnLO4Kn2pAf4PTHPVSjiti84kV9p/9VNqT4v7Bug7DhlqUxw
         2mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689682756; x=1692274756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZHiNhlcnBcV/12CBhpoH4NhL4fdNzTRpHhX759efoE=;
        b=X31l2MExJWf0oRB8O/NBfzMFEftmf6ktab+BOkfbOpKiqyIiOFuuuWIEYJiltmMca/
         xbDM44GgJVcbYqW3+EGwoLVaGdNv9LXPSytA6WCJY47bfrwO3PUHtc7ruIVKSZtLPMa0
         XVhp5gt1lOHW9uDkcCsynnL6r9UGb/RQkqBpVE7cnRQ2g1z9M4U648E9yI5SdXiqArkL
         FiJoIRQovY6jWJtr7VnMVrA2kNe4j5/tS3CkuvhZbVxHWjXJ8GcXtj2rvr678chxOpV3
         YuMcmpCeytwww8qUKPn4VMRz5VVN2NkAWHYuJI+LLLmgzxt/sZrrGc3R6RholWYoSdtt
         jFCg==
X-Gm-Message-State: ABy/qLaHC/CBuI6COfXxuvwRWNirNym+/YkuQ9q3kD3VRtawXq1pqNut
        ydyPlKwjVdp9PDITOIq0+Yui7w==
X-Google-Smtp-Source: APBJJlH6NnoSBJfilu2FTqtWGzALCPzNb/NSR8tEZkwUx5OLF0JfQhJZ9VBoH7NV4rKDhuUb8AY6pA==
X-Received: by 2002:a19:5f1a:0:b0:4fb:8df5:8919 with SMTP id t26-20020a195f1a000000b004fb8df58919mr8634710lfb.23.1689682756309;
        Tue, 18 Jul 2023 05:19:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id w5-20020ac25d45000000b004fbc95a4db3sm418257lfd.28.2023.07.18.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:19:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 18 Jul 2023 14:19:11 +0200
Subject: [PATCH v4 2/2] irqchip: irq-qcom-mpm: Support passing a slice of
 SRAM as reg space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v4-2-bae382dc0f92@linaro.org>
References: <20230328-topic-msgram_mpm-v4-0-bae382dc0f92@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v4-0-bae382dc0f92@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689682752; l=2751;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yQx/+qerpXC0l+cy+Ejk8gpdBKyKLvnTn9FYud1Txtk=;
 b=5CXvh5t6cxxmX683kjykjDScpVxz5kvmakrM1qH3EXTb53Kw1A5IqAAzygFxf1rNF0/r/LGhJ
 v7Ay7ThPnocDBXcvdEegD7ivKBpaQ+GfHIY9l7jTm+5hNWk0ePtVgbK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPM hardware is accessible to us from the ARM CPUs through a shared
memory region (RPM MSG RAM) that's also concurrently accessed by other
kinds of cores on the system (like modem, ADSP etc.). Modeling this
relation in a (somewhat) sane manner in the device tree basically
requires us to either present the MPM as a child of said memory region
(which makes little sense, as a mapped memory carveout is not a bus),
define nodes which bleed their register spaces into one another, or
passing their slice of the MSG RAM through some kind of a property.

Go with the third option and add a way to map a region passed through
the "qcom,rpm-msg-ram" property as our register space.

The current way of using 'reg' is preserved for ABI reasons.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/irqchip/irq-qcom-mpm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index d30614661eea..ee5f39a4a42a 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -14,6 +14,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	struct device *dev = &pdev->dev;
 	struct irq_domain *parent_domain;
 	struct generic_pm_domain *genpd;
+	struct device_node *msgram_np;
 	struct qcom_mpm_priv *priv;
 	unsigned int pin_cnt;
+	struct resource res;
 	int i, irq;
 	int ret;
 
@@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 
 	raw_spin_lock_init(&priv->lock);
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	/* If we have a handle to an RPM message ram partition, use it. */
+	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
+	if (msgram_np) {
+		ret = of_address_to_resource(msgram_np, 0, &res);
+		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
+		priv->base = devm_ioremap(dev, res.start, resource_size(&res));
+		of_node_put(msgram_np);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	} else {
+		/* Otherwise, fall back to simple MMIO. */
+		priv->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	}
 
 	for (i = 0; i < priv->reg_stride; i++) {
 		qcom_mpm_write(priv, MPM_REG_ENABLE, i, 0);

-- 
2.41.0

