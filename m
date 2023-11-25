Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF87F8BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjKYO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjKYO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:27:12 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8918BB0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:27:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c87acba73bso36986171fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700922437; x=1701527237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjrMx0Y9XqGbeFGv2v7KF3vpFk6Af7SmrHYjsceKUcc=;
        b=nMSIOCap7eRtNRKAftq68BVAYtwGVTsfBXmqPy9RDILKMmNIJY5fER2N9Crr61Cp8E
         oFvNPF6FaZjr97/MOuvNF8jTW0EGx4Diw2YbnbKOvoBkk1dI7HmuvXZuaDSIitO3SAHo
         0SXhUDvMm/mvlYI37hGF1gj6sYvNrtX/8oD2bFwPcHotHNThHoO2mHY8n3gS4pdKGf63
         2ejPYdv5+POuh+x/7jShwCyPDjG6wiC9ANdnT+Wx5bxZDXFaqTOKUvKNdoorK5CNHQfz
         ZeQURHlnqoYRUE8dODLxlvWtHVS4QBtdnv8Cs6r4f3gNr1LOEKr8yigwUCtntwq/14Az
         y6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700922437; x=1701527237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjrMx0Y9XqGbeFGv2v7KF3vpFk6Af7SmrHYjsceKUcc=;
        b=OnkGyqTmkPHUuUbll2qPjTIWVbcXGVTM+lJ2P1v3/o1yvb/O2eOK3lcnKVJBvIT0of
         GXVykBv6HEjVGpF8ahO/ipDjZGb07KB2J50ArNFLu8M/h34b5ykBcUDXetwwaQq3GWRG
         T3kpKUSio2os5g+/0IfcqrWeKIXvoElWgdeQiBFoXktRlsq37XtZS9iBQfodooUdLTtU
         EacrsKbDoxMKgXx80S1EUO0cqSkjObcqXjZuUYmjcobgY2u6O5l+ciBFetLMpzyiwzo2
         VDPB+dxZfwK8fQyMuQM7vHePsfIFn/S7H8cjKD5a9tWnWocpwBYRuNIIjbt95/08Ouja
         1zIQ==
X-Gm-Message-State: AOJu0YyBb8wiL/pExn8ezvuz0t3WwqelOOlTzLxF7AXNVUB7jb76bDow
        gMmRS3PxY+EwR1Fj39CgwEm9Hu84R+lqki5Vyls=
X-Google-Smtp-Source: AGHT+IEAtacX1rpj46KJsE7MAgE0rYdmvPIBb99+gIuObi2T5Uo92sjkL5+CgdTJt5Nze6GB+GMY9Q==
X-Received: by 2002:a2e:9d4e:0:b0:2b9:4b2e:5420 with SMTP id y14-20020a2e9d4e000000b002b94b2e5420mr4192424ljj.52.1700922436912;
        Sat, 25 Nov 2023 06:27:16 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id cb8-20020a170906a44800b009fd4583851esm3569253ejb.178.2023.11.25.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:27:16 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 15:27:04 +0100
Subject: [PATCH v6 2/2] irqchip: irq-qcom-mpm: Support passing a slice of
 SRAM as reg space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v6-2-682e4855b7e2@linaro.org>
References: <20230328-topic-msgram_mpm-v6-0-682e4855b7e2@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v6-0-682e4855b7e2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700922431; l=2753;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=C9jl/qWAOl6wjNdLIwtjlGydPzEtEemM1AEix/NRi+g=;
 b=QtoC2BFtU8WEQA3FaUGzzwenP8GqsgZoAjavep58j+7Xe7xYs8nBar2m2me6Rpy4DsIoa0wF3
 Rm4t4mZXOxaC1SKmjd726QWQTfffqWQ1f0bR+GNiVeYGNpXTX11V9zK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7124565234a5..7115e3056aa5 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -14,6 +14,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
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
2.43.0

