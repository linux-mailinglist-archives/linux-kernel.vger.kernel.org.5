Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD67ABBE5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjIVWkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjIVWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:40:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3851519A;
        Fri, 22 Sep 2023 15:40:34 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c02e232c48so49409711fa.1;
        Fri, 22 Sep 2023 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695422432; x=1696027232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnnYflUXki788FbyEpOYccXKNL0/Zg1ISD6i+gaFKJg=;
        b=I5KGoDCfhg2FLuq+5+qoq+3u03alPW0wUGN+Pwsz0ngEu9r1jRZ9T9WHZWyBw9GRVt
         ylXaMU/vIDGU0ATEnXG67cc4WvnydjBfK8XQh1JiIMgWtF3lXbtHsKbZd3jtq1B+RA6c
         VxAZuRjfdB3pZkCF68YLil09EDT+0fsSR/mmyo2C6bkUzl19fNDVPr8gRsWY9RElu4ov
         5veZu+ketPy1TNJrANI4QSIHfhDcnaXwLnCO5DmXPK1tTJ1iYTo/Hrux5yi7SlBoSe6o
         OCtQwX1ArLjP4N/KXmxp1KV7PbGEPXjkQQ8fE+X/u/a5u4I7S5onY43aEyr1SbgWFM+P
         ormg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695422432; x=1696027232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnnYflUXki788FbyEpOYccXKNL0/Zg1ISD6i+gaFKJg=;
        b=uAR8V083gMRjMSivi02g1T0V+HNBNjFNxcPPWG42xTtruMlG1hvJ01O0hceQ1vzxGI
         x83IdTrakTYLIanOc7GIh+GOCsSBoceARKcMRyhkU3Cq7jYacXtq5DtI/PmxS8WPSX4h
         KV+UFrrcant2u758fXre1DmNk6kOeqPKoFJQOp+5j9RFfCpP9aQxY7hKKQCNRhBEkZU8
         dnL0z78z1bAh7JahFtQsfp0/oP5cqPBeQKeLE8Pg5WRyiJa/MaFLfLHzm6WKFY4u5klr
         sW5V5AuCRE62qsc88XH9zXOEnItSxQtlpMRUogILENiOGJZ6Tgatdj6KQTNfp+sc8yPl
         9kLQ==
X-Gm-Message-State: AOJu0YytCIovwBS2v+nkQhx1EDOJ4q22hxBmFIZqpCaqbEhCGJvaLHy0
        PpoQKmAi0L1uJyIf1M7qMfw+U4J2L0YJsA==
X-Google-Smtp-Source: AGHT+IH1i47Tn5Z8ZtQxbuFYqsiDTKqaWjvOfIq+nP7TxtWUILLH579gVg4VztAXQwuOUFT2N1d37g==
X-Received: by 2002:a2e:b051:0:b0:2bc:f252:6cc4 with SMTP id d17-20020a2eb051000000b002bcf2526cc4mr401876ljl.10.1695422432122;
        Fri, 22 Sep 2023 15:40:32 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8502000000b002bfec05a693sm1090423lji.22.2023.09.22.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 15:40:31 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: qcom: msm8226: Add MPM pin mappings
Date:   Sat, 23 Sep 2023 01:40:26 +0300
Message-Id: <20230922224027.85291-2-matti.lehtimaki@gmail.com>
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
 drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c b/drivers/pinctrl/qcom/pinctrl-msm8226.c
index 994619840a70..1e46a9ab382f 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8226.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8226.c
@@ -612,6 +612,16 @@ static const struct msm_pingroup msm8226_groups[] = {
 
 #define NUM_GPIO_PINGROUPS 117
 
+static const struct msm_gpio_wakeirq_map msm8226_mpm_map[] = {
+	{ 1, 3 }, { 4, 4 }, { 5, 5 }, { 9, 6 }, { 13, 7 }, { 17, 8 },
+	{ 21, 9 }, { 27, 10 }, { 29, 11 }, { 31, 12 }, { 33, 13 }, { 35, 14 },
+	{ 37, 15 }, { 38, 16 }, { 39, 17 }, { 41, 18 }, { 46, 19 }, { 48, 20 },
+	{ 49, 21 }, { 50, 22 }, { 51, 23 }, { 52, 24 }, { 54, 25 }, { 62, 26 },
+	{ 63, 27 }, { 64, 28 }, { 65, 29 }, { 66, 30 }, { 67, 31 }, { 68, 32 },
+	{ 69, 33 }, { 71, 34 }, { 72, 35 }, { 106, 36 }, { 107, 37 },
+	{ 108, 38 }, { 109, 39 }, { 110, 40 }, { 111, 54 }, { 113, 55 },
+};
+
 static const struct msm_pinctrl_soc_data msm8226_pinctrl = {
 	.pins = msm8226_pins,
 	.npins = ARRAY_SIZE(msm8226_pins),
@@ -620,6 +630,8 @@ static const struct msm_pinctrl_soc_data msm8226_pinctrl = {
 	.groups = msm8226_groups,
 	.ngroups = ARRAY_SIZE(msm8226_groups),
 	.ngpios = NUM_GPIO_PINGROUPS,
+	.wakeirq_map = msm8226_mpm_map,
+	.nwakeirq_map = ARRAY_SIZE(msm8226_mpm_map),
 };
 
 static int msm8226_pinctrl_probe(struct platform_device *pdev)
-- 
2.39.2

