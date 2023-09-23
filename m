Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D444A7AC237
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjIWNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjIWNOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:14:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672C119E;
        Sat, 23 Sep 2023 06:14:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5031426b626so5623390e87.3;
        Sat, 23 Sep 2023 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695474880; x=1696079680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyl55hSrpI/NQRmZG4XXfiof657r7srtbLcJb/TnH6E=;
        b=hbdztxRtPDg2txL4tU8i0StJt1iKDKl/kc80SlTNd83vZhFRYQhDEVNMuqUYsYMY4C
         gN23ublyGCoVfbdMkaMfRUR6CicLkIFj5nLvuoYRGDYt2GZo9wZ2/7orF9ikGjQjeIkx
         YjDjJtxRr5L1pdqk6VRHq4THOV4tIj4E1mLjrsPF2/5qrL1gsDX+JQvD+nbjt15Q0LYi
         Jgoxs7jg1kJqoqQMeeyHVVH3Gd8iLzyJzdk0Eva2xqkh84nYOhhoFMRn8bD6Cx/OMxbZ
         Js6ca8yEaZu77n6R+R3IvlsO7Z3khgxhI2BqZufRJ5J1btCuPTA0+ye9eCWYl8LbzAVp
         u8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695474880; x=1696079680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyl55hSrpI/NQRmZG4XXfiof657r7srtbLcJb/TnH6E=;
        b=HyFhbO9njBcFi+CGBwA2zahGApQuFYuRYIfMNq/95HpVAr8ph1zYWb6Kp/N1VIKHrc
         ZMkqq3HbUDC3dbqR0EGszpm4HWhcYZf5p8GVZBJ4LsUWufT8ZHrvFnHEg7KHZi7Zguuo
         qDrt73G9538AL3UH4GhPK7sghthgSuE/WgD/2oE+Ox5CpGPxKZ0PNy6xREoM90Ev2c6o
         txUW9LL6ahAND+89wNsiEWP25cR1Un3hnHMwTelT6/5cuEg9LAy5zBE1RplO7On34WCr
         cAdbG2Cd6hsrN+6stsyzRPMgnSQlbq76bKWxVgOyjqdG6taYp8ttV6b4Ys4f5q3+HX2W
         RFzg==
X-Gm-Message-State: AOJu0YxQVBOzO9RQLQfZ2iEKD+PDhQXPsBZfAd7Bk65lS6N2YAq4mfz/
        kTZeZr7AjChZ6BMTRJqoWE//qNaWGPEMZg==
X-Google-Smtp-Source: AGHT+IE8fCQ6pTHZZKuMgFbVuTjTce+bjedi3Ta8ahQThqNd5RNcuOTSR0Wx3PAau+eUGwrZdX+2og==
X-Received: by 2002:a05:6512:2246:b0:4fe:db6:cb41 with SMTP id i6-20020a056512224600b004fe0db6cb41mr2494966lfu.39.1695474880457;
        Sat, 23 Sep 2023 06:14:40 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m1-20020ac24281000000b004ff96c09b47sm1080847lfh.260.2023.09.23.06.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 06:14:40 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] pinctrl: qcom: msm8974: Add MPM pin mappings
Date:   Sat, 23 Sep 2023 16:14:32 +0300
Message-Id: <20230923131432.21721-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230923131432.21721-1-matti.lehtimaki@gmail.com>
References: <20230923131432.21721-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
through MPM-connected pins.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
  - Add Reviewed-by tag
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

