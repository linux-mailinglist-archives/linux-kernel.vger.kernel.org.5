Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7637EADE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjKNKUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKNKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:20:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCB0A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:19:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33139ecdca7so2440832f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699957196; x=1700561996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEIBIUZc6uePJfntJdIEYKl8kqhtvCCVMaiOaHpDyfM=;
        b=K+HGsPuiYL3ZrqRk7KkXHGbkyLrn6PeTwb33cDrYHxY5xNX5cpz53uQSSv23D8aN8N
         JwXyC8Fc4OvS+vhbmSrGPPsiUHia0y5rrk2kYhwCg9PhI2vRNdMvgjjUWjjhiLmGHojM
         MuW8XF93vuy1QC6Sc7igbbTFCkjnevsvtghCeWCLs/qSAJykX3GvE6uy8waLeejkGC29
         Egpoctb92Bgjc8QdUEAL7CR4ZZ863/EVhoBC9JLJ6W+qig7ANMoWwcuXnz7xOZtBAuYB
         6bsAtMz8zylgoelMrKkt53zc5o5xAXDfzKtwFVt8UukWhI6fTny9h1cpPJRHz3+uGPkl
         cBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699957196; x=1700561996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEIBIUZc6uePJfntJdIEYKl8kqhtvCCVMaiOaHpDyfM=;
        b=JHrVXWo9UV6P8tOfzagjIgkxQC78exvzzub7oWZ/Hl03BICcEdiMzGB+RDZJy7fdu4
         5npthRyH+9iO3w7PNmOxB7WAavLswQHWkSa9AkcSHeqWOQ4aLNwe8lmoR/8KaRYriet3
         O4tjmUfm3Dm7bRXagsLVsPcT8aqUprqdeDnoIlbax8wRZu17ZwGY2ZoYBryI4+wJH/4z
         X8G9mA8odG+qVtPQako4Xo8CUYbQ1/B+C3ip3AxYGQDxu2a78SOKJBPANKYmIMw6Zxb3
         jUyIu1Zh9Ve+LykuThwJR2TOCIdzoQsyiQk7w0amXQAV8VKv/gidb5cZ0YAOII8KvlUo
         I1XQ==
X-Gm-Message-State: AOJu0YxCI9WKIeWaITJvr9sR+dY0nuwGRBLN7GD5OtnhLmeVAjvU6M1g
        YkkiboXtTuNHE9eZMiRBD3tBow==
X-Google-Smtp-Source: AGHT+IFNvpoPpsHx2p5m3MMv9VHHwSghZIW3y1edhUbi+6SVcRkn4CBysD08DhvHC8uZ2rPXGDk8rw==
X-Received: by 2002:a5d:4e85:0:b0:32f:7967:aa4d with SMTP id e5-20020a5d4e85000000b0032f7967aa4dmr6050646wru.68.1699957196533;
        Tue, 14 Nov 2023 02:19:56 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d43c9000000b0032da022855fsm7419675wrr.111.2023.11.14.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:19:56 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 14 Nov 2023 11:19:51 +0100
Subject: [PATCH 2/2] pmdomain: amlogic: meson-ee-pwrc: add support for G12A
 ISP power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-2-f01e6fca67a0@linaro.org>
References: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-0-f01e6fca67a0@linaro.org>
In-Reply-To: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-0-f01e6fca67a0@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=aQxr32do09NNbq0amsdwX/uvKdT6sjjcfu6Gh0FrHoI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlU0nJG2mljBw/0T6F93TKPKViSSLGHPI+v240fNwU
 6mi3DumJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVNJyQAKCRB33NvayMhJ0XjED/
 9KRANEUmUjaRu1euBCtDmLf/JYF1uTV/2Zv2jc7KgMIDYp88B7esJ6pba+UtJ3jN3oj/xO2oRkRPWA
 gn3mgr1zCNWeFchLMDHwrE9AOwUQlesIWdh2PZSwSxZ9M+4IyyWY8shQkUVKf4U6/2hD4tujoQ8HaX
 C37kWyzbxzLZ2oWFl3DxsGAFk5doAr6Uh4q523pFst1oS0fs3WU6Ms5UgAf+6McUPwaPWSth3JRvG1
 V6ybYoD8aQmPjlvO+0TcsfemJ9U8OzU76SlgENyFxTHMSi/O0080wR2dGQAYfrRYyiRJDGa5IuNgLX
 Gf2/hs48OniwJBKhpc0FJQ2fQWOW2LKyoDw00w7CSoBujUqwHTR8GOupyHqqOodBrsXXmfyrucu0Au
 qINla3qD8EYH/br77LI4Zlt9F4KpKR7bI7DnznwBtRTsg9AUK0tIwSVgapO9vDCirhQML0m3sksavo
 wSmFDAqgSV1foZkzxtKndM/yM7G/g2bf3fpsY4QoGy40QnKfHCWZgNdvKp/yycTpTR+AtqhWgY8Qd2
 o1cskcw0iSfh+R5Mle6a071YtCqQ5mSUCMsFn9v/2nTKAnrh1+82YcrdHiGYHO2neof5AUxNK9aV1y
 bPYUBc1t9KJPXT35IEmzS9XP9L8AOOYy42+RD4smlOdstkhbboEWekFvpG8A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for the ISP power domain found in the Amlogic G12B SoC

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pmdomain/amlogic/meson-ee-pwrc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
index 0dd71cd814c5..cba216a2175e 100644
--- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
@@ -47,6 +47,8 @@
 
 #define G12A_HHI_NANOQ_MEM_PD_REG0	(0x43 << 2)
 #define G12A_HHI_NANOQ_MEM_PD_REG1	(0x44 << 2)
+#define G12A_HHI_ISP_MEM_PD_REG0	(0x45 << 2)
+#define G12A_HHI_ISP_MEM_PD_REG1	(0x46 << 2)
 
 struct meson_ee_pwrc;
 struct meson_ee_pwrc_domain;
@@ -115,6 +117,13 @@ static struct meson_ee_pwrc_top_domain g12a_pwrc_nna = {
 	.iso_mask = BIT(16) | BIT(17),
 };
 
+static struct meson_ee_pwrc_top_domain g12a_pwrc_isp = {
+	.sleep_reg = GX_AO_RTI_GEN_PWR_SLEEP0,
+	.sleep_mask = BIT(18) | BIT(19),
+	.iso_reg = GX_AO_RTI_GEN_PWR_ISO0,
+	.iso_mask = BIT(18) | BIT(19),
+};
+
 /* Memory PD Domains */
 
 #define VPU_MEMPD(__reg)					\
@@ -231,6 +240,11 @@ static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
 	{ G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(31, 0) },
 };
 
+static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_isp[] = {
+	{ G12A_HHI_ISP_MEM_PD_REG0, GENMASK(31, 0) },
+	{ G12A_HHI_ISP_MEM_PD_REG0, GENMASK(31, 0) },
+};
+
 #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)	\
 	{								\
 		.name = __name,						\
@@ -269,6 +283,8 @@ static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 	[PWRC_G12A_NNA_ID] = TOP_PD("NNA", &g12a_pwrc_nna, g12a_pwrc_mem_nna,
 				    pwrc_ee_is_powered_off),
+	[PWRC_G12A_ISP_ID] = TOP_PD("ISP", &g12a_pwrc_isp, g12a_pwrc_mem_isp,
+				    pwrc_ee_is_powered_off),
 };
 
 static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {

-- 
2.34.1

