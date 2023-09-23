Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AD07AC236
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjIWNO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjIWNOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:14:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9906C11D;
        Sat, 23 Sep 2023 06:14:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-503397ee920so5768392e87.1;
        Sat, 23 Sep 2023 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695474879; x=1696079679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi1nMZ5Qx+Hd3+Zg0OLpMqTtfkM7eJhwwI+OqM4wPA8=;
        b=PDVAAicv89X0Sxn9lP1z2Z8m67+DE8PIcGoHFSrn+k0QzSOj3BwJ4gmYWO58U8VA57
         SXztz49ZesKOShzDHEsvThLzUmZ5J68cj4py3jYgx+Uk5G4PximjchhowP+3GDlT9ec2
         WX2fcU0U5axYY7FLiMDAE/kPbm/f6rUgf/iKJjCPGBtDQnWAbCQ/Ha5OTvVldK9u5iuN
         stL5+GV4NaaAjoZ3SU9ZVTMHBMwyN34eI+VzyhxxPGedrR+w9B1Bg89faAkzGCbyOG42
         X7+YG3uj/Y+9VRZKRFNHVzCjtGe3nhLFSIGhTj83k3fZhKwMOGzIGkbSCXx2cdsKPp3U
         wvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695474879; x=1696079679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi1nMZ5Qx+Hd3+Zg0OLpMqTtfkM7eJhwwI+OqM4wPA8=;
        b=bsy9EVqOuIihF1KQTtYO6Lgs8n6NZC9sn0AYKrEm4tR3Dxh4LcPnPtuwbT151SPFKA
         BDRItWwPSUn7fBGS4J3k9N24Odir6VHpNVzt2WHRcOaqZnv+VT6F09/3iMOn9flFu7cN
         7Eg+XYQSdLOGw9JFHWJHMExx1/9sQpEbF8tJU6danUEQ0AQ3LJyw/5gzgIAmOmGiAyT2
         UxZ/akBfeXag+6lQkmm8CDuiirskCpgNn4rePSnBXyrNptSK7C49s6EF+ldPSQjYFWud
         DGkklTa5vR8TR+MOOu1mkXMrfHEKSOtQvG4HimiV1cs7JLjOI88YrWrvc75uptewKquJ
         8ung==
X-Gm-Message-State: AOJu0YxecFzbJ84OI6kIbNG3CoQFsxkaHTRrlAJRY/9SwejyL9Cm8lfV
        5n6HkLg9x462fVKwuCgE4IUn5kt0yTAScg==
X-Google-Smtp-Source: AGHT+IHBKU41RrGfr51ITbEELFc5CKdYQ4Y4zrMrbdaGV8gRriIIepYoaaEubDywXIo447FPCVLDqg==
X-Received: by 2002:ac2:5932:0:b0:503:1875:5ae5 with SMTP id v18-20020ac25932000000b0050318755ae5mr1872523lfi.38.1695474878630;
        Sat, 23 Sep 2023 06:14:38 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m1-20020ac24281000000b004ff96c09b47sm1080847lfh.260.2023.09.23.06.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 06:14:38 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] pinctrl: qcom: msm8226: Add MPM pin mappings
Date:   Sat, 23 Sep 2023 16:14:31 +0300
Message-Id: <20230923131432.21721-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230923131432.21721-1-matti.lehtimaki@gmail.com>
References: <20230923131432.21721-1-matti.lehtimaki@gmail.com>
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
Changes in v2:
  - Add missing entry to mapping
---
 drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c b/drivers/pinctrl/qcom/pinctrl-msm8226.c
index 994619840a70..4030baa3715f 100644
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
+	{ 69, 33 }, { 71, 34 }, { 72, 35 }, { 106, 36 }, { 107, 37 }, { 108, 38 },
+	{ 109, 39 }, { 110, 40 }, { 111, 54 }, { 113, 55 }, { 115, 41 },
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

