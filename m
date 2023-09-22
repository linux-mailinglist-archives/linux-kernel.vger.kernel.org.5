Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C2F7ABBE8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjIVWkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjIVWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:40:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE3E1A4;
        Fri, 22 Sep 2023 15:40:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c008d8fd07so48947311fa.1;
        Fri, 22 Sep 2023 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695422434; x=1696027234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/H0iMbs9oDvkcYDnhpon5p0YhVA9HnElyeHpI8GSo8=;
        b=JdtXepSlYH3qM59AHOH6dEfQ8lEG+idRt3N8iWbwSbg9i+0AlCbEJtYCiE9PrN4V+t
         Ed5gtIr/U0aAAQ3dzH4WXKEDDdYlNOcPSvMcM6+uUafZ3cczcXiy2JXowvVMd55rY+5P
         hTKLNeOv+SLW2fwrafWzN/ejKlolNBM8ZZvEt8bX5U1g7k0wliAOnaP4WTYDiF1aSC6z
         KQuqXpTjdhidFezVX9gaxRdSpFoWCm1lmRCgYLyad+HH3CB6M04MfVgJJxxen8guXruC
         AUGeXQ25yfOVWd7AbomHPazZhOEkvFVZ9T+rEPGkWi64LlgV6hCGU7MTRDBPfcs2101Q
         d9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695422434; x=1696027234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/H0iMbs9oDvkcYDnhpon5p0YhVA9HnElyeHpI8GSo8=;
        b=XjRWzJ5AAPuXuKILUDd/dAFA0OK24OL1XdLQ5sXXLmSC/xlkMV6bBnDJdQv+lX7RMC
         k6n13JIu/h9rp+HqY3cAZ2F1x/TOYgdqzXWMKLTBp9qIZ4z2r/FHcW7x37Pf5A42aQSF
         okb8aZfq2F2F0BhwCb7InpMbzOn2qs+bRpbC5sInGuYz3ZSa9qMXmu9vUQL1WtI9uAaj
         LnJ8dqfcH8iol0pK11GaV/CHdXxsgcfyRk9oXZ8oPecbdWi4ae4k6NoXYpqtsET+P13a
         7kHNvWkSxfZXWoZKZ9m0aRFGYbTGG9LxjNyBDEcHmCCFOT9fiFasJJ2iT4dTCBxvsNy8
         ES1w==
X-Gm-Message-State: AOJu0YwEvbMC7MOw8dp0f3IzHVHi1eVzDKjr1w/hOLz6sAY8yAotyNjB
        FyM7CNEK66OD9Sxm8nwxS9zwe1b8Or/srQ==
X-Google-Smtp-Source: AGHT+IFSotPp+F5vtMGoBdQYMWOLBcdRTmPQ4DVrOyoHTADi5LfsUpxUClcoiKgb0qQFEDd3oRDA9A==
X-Received: by 2002:a2e:9ace:0:b0:2b6:9da9:2884 with SMTP id p14-20020a2e9ace000000b002b69da92884mr459394ljj.40.1695422434015;
        Fri, 22 Sep 2023 15:40:34 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8502000000b002bfec05a693sm1090423lji.22.2023.09.22.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 15:40:33 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: qcom: msm8974: Add MPM pin mappings
Date:   Sat, 23 Sep 2023 01:40:27 +0300
Message-Id: <20230922224027.85291-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230922224027.85291-1-matti.lehtimaki@gmail.com>
References: <20230922224027.85291-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
through MPM-connected pins.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-msm8x74.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8x74.c b/drivers/pinctrl/qcom/pinctrl-msm8x74.c
index d5fe62992849..238c83f6ec4f 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8x74.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8x74.c
@@ -1045,6 +1045,16 @@ static const struct msm_pingroup msm8x74_groups[] = {
 
 #define NUM_GPIO_PINGROUPS 146
 
+static const struct msm_gpio_wakeirq_map msm8x74_mpm_map[] = {
+	{ 1, 4 }, { 5, 5 }, { 9, 6 }, { 18, 7 }, { 20, 8 }, { 24, 9 },
+	{ 27, 10 }, { 28, 11 }, { 34, 12 }, { 35, 13 }, { 37, 14 }, { 42, 15 },
+	{ 44, 16 }, { 46, 17 }, { 50, 18 }, { 54, 19 }, { 59, 20 }, { 61, 21 },
+	{ 62, 22 }, { 64, 23 }, { 65, 24 }, { 66, 25 }, { 67, 26 }, { 68, 27 },
+	{ 71, 28 }, { 72, 29 }, { 73, 30 }, { 74, 31 }, { 75, 32 }, { 77, 33 },
+	{ 79, 34 }, { 80, 35 }, { 82, 36 }, { 86, 37 }, { 92, 38 }, { 93, 39 },
+	{ 95, 40 }, { 102, 3 }, { 144, 41 },
+};
+
 static const struct msm_pinctrl_soc_data msm8x74_pinctrl = {
 	.pins = msm8x74_pins,
 	.npins = ARRAY_SIZE(msm8x74_pins),
@@ -1053,6 +1063,8 @@ static const struct msm_pinctrl_soc_data msm8x74_pinctrl = {
 	.groups = msm8x74_groups,
 	.ngroups = ARRAY_SIZE(msm8x74_groups),
 	.ngpios = NUM_GPIO_PINGROUPS,
+	.wakeirq_map = msm8x74_mpm_map,
+	.nwakeirq_map = ARRAY_SIZE(msm8x74_mpm_map),
 };
 
 static int msm8x74_pinctrl_probe(struct platform_device *pdev)
-- 
2.39.2

