Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4A7DB8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjJ3LDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjJ3LDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:03:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52212D60
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:50:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so59410031fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659422; x=1699264222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9stpqAnk3dnnYMPNPoplRmh3fae6uUBC7Ti/UuDSw9Q=;
        b=aRNJkoKJQvmlv/hsT6S38CsZkNZO1jy1037zxF5JTlVH+ECXF08EqKRgnUPoTh2yH2
         dybrG9TB2yDrg8ekPMVvE7tzepjvB00ZYfmWZQCjn8DA2VkbZlpa7dUTJBhPjh6VNMW1
         D1vLCZDqDbcdOmrWbuRX8xDlrd1an3mFlo6JG4qCQZ49YMHaAWYCukUCpsT3qDSQxKKK
         iSippeULGIxV/hQMGwX0pVEwQZWouW4myGPI2ItXkz6fpNwPYzwMtOaQxwBQphwixbx+
         VIMqPiJiMCZ5xpZgjla5bxEcXPzEJ5qRhXQ+VD3Y0+eDPod8p/L8w1wNNd5AQa8ZQ78G
         RA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659422; x=1699264222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9stpqAnk3dnnYMPNPoplRmh3fae6uUBC7Ti/UuDSw9Q=;
        b=IeOHISG3J62o6Jgt0zpTQvRTEYUy3t0hHu3fpfn0/ztAiOeCBGrVOVbwv1ydiPA7wg
         95b4MqkKEvDagsPPaxCTzDIiCoSM5s57Avulg9qcaGvNbnEEpZeFo8taAaQjBbeyqt8c
         RplNxIU1pQ746SyDO9OCHTatvGzlPMdZ3IJA5eY7sJ2nCUt84r+b6HnhDpI09V4kewr3
         5+Y7iD1j6qDAzDoTA8BelsCl5xitLKQdsCSu99qEQYG8gxzVL04IxXH0SdZAQcff6rWn
         Kk8pZE3ogwLkPxzmf2PDUfHY8mGwzQyNq0NeCeUBoBOPbi5RF9qg50dNbJ8Fbu6nKGVH
         YBDQ==
X-Gm-Message-State: AOJu0YzdAVQzAnAGWJMV/vWe3mOBIJgFJryHhX433VGGJd7xIVPI5GVH
        g9hfXsc/Ce/2vSloPvRAy+hGgg==
X-Google-Smtp-Source: AGHT+IF8BRHzSBLAZL+eKA2bBwMHrEA2VYNBDrypefOEeDr9TVmVwhQV99YTlyzNjUZuQUkLcAU3JQ==
X-Received: by 2002:a2e:b042:0:b0:2bc:bf29:18d3 with SMTP id d2-20020a2eb042000000b002bcbf2918d3mr7393280ljl.31.1698659421879;
        Mon, 30 Oct 2023 02:50:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id hj19-20020a05600c529300b0040841e79715sm8625242wmb.27.2023.10.30.02.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:50:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 10:50:16 +0100
Subject: [PATCH v2 4/4] fixup! pinctrl: qcom: handle intr_target_reg
 wakeup_present/enable bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-tlmm-v2-4-9d4d4386452d@linaro.org>
References: <20231030-topic-sm8650-upstream-tlmm-v2-0-9d4d4386452d@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-tlmm-v2-0-9d4d4386452d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NZ3RXY5Xpm5QETB8k/ZBCrFID44rfsi5TIXbGtVooac=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP3xXFx7AsacbYFF//r69uEQGhm0QXGQMbBz9l3JQ
 6u7vnGaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT98VwAKCRB33NvayMhJ0Q6XD/
 9WIiQEcewz2fpQghH4iNdrn9Mf/tLX27m+6DkL1doieAfm16UuJc3xc4jr27ROYTYVJGjsAi92b/ij
 5UG0BefVkb0r4vL0MQ7NQoHz2g0rlegJeKRuTKym3eEXcHc55MXL5hxeFheLZTB6zv/R6Rbz4jL//a
 gTk7SyJxDvBMf7rJm0HXRQVRKttDHFqWNV1VyJf75svDfzn3aMe81mfQE3aY5chlkUclkroPplhEJ8
 ZtviZZeDPdDmFofmzK5hKoCBySMInUQo5KZVd4xP4Jsv3WY3xcXgU13kZB0Bx3Ugr7BbP2Og8eYoqY
 ngCGL/e3sGcwygRVrWM75yHe6p4X9+OLIUU+yZ6cDCTdibYeMtNrXkpNsmsAnXzgl5XfLn3IaMwUcd
 LW99x3sK7LMnuZ+luUumMcLF59Uoqtm/SI3FyhYQBVVziVwjZa46pT3/OpfBs1s6fWNP5I8HskSy4A
 ondkCQ/Z0ECVbrwp6V4KEEK/NZJxjn3E91jL1XlFCR1pc3tWmYInWHBpj1iNn6C0tZVxXqPoPrjZab
 G4uRtCLDfW2H6sbWkE8I8Y5MKLvoBJQpLfdDvQxrJN+naNjuGOuwtLhcrqSbvHFWIbJy/yQh8u8Ux3
 PHK2SIk7v3Sf0sK4De5H8BxnDrWhoflZlE1CS7Y6cMorkCxR3PW04GxgNxaA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/pinctrl/qcom/pinctrl-msm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 2489a9ac8455..207b41018580 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1197,6 +1197,7 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
+	unsigned long flags;
 	int ret;
 
 	if (!try_module_get(gc->owner))
@@ -1233,11 +1234,15 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
 	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
 		u32 intr_cfg;
 
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
+
 		intr_cfg = msm_readl_intr_cfg(pctrl, g);
 		if (intr_cfg & BIT(g->intr_wakeup_present_bit)) {
 			intr_cfg |= BIT(g->intr_wakeup_enable_bit);
 			msm_writel_intr_cfg(intr_cfg, pctrl, g);
 		}
+
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 	}
 
 	return 0;
@@ -1251,16 +1256,21 @@ static void msm_gpio_irq_relres(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
+	unsigned long flags;
 
 	/* Disable the wakeup_enable bit if it has been set in msm_gpio_irq_reqres() */
 	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
 		u32 intr_cfg;
 
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
+
 		intr_cfg = msm_readl_intr_cfg(pctrl, g);
 		if (intr_cfg & BIT(g->intr_wakeup_present_bit)) {
 			intr_cfg &= ~BIT(g->intr_wakeup_enable_bit);
 			msm_writel_intr_cfg(intr_cfg, pctrl, g);
 		}
+
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 	}
 
 	gpiochip_unlock_as_irq(gc, d->hwirq);

-- 
2.34.1

