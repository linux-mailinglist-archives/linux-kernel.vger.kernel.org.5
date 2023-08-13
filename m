Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EBD77A667
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjHMMze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHMMzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:55:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41941710
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 05:55:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso2043909a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691931335; x=1692536135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TCVvUlxQwvnZWY7TRswq2D2OW0n3M+Aa6xn7ejaiGKo=;
        b=TiMwQjBrtsaY1u3yP5yz7mVaZOq38v7JvM5CkG1y9mTRSGQAjrfF8XBnNpdPg1Kcvy
         vfnJWu2ZH9e/h0mKT5N+h9adlQKJ4mMwXZMP95VJ/fxlv+/r7u7CSjLHWk1msTbiBvcE
         Ysfx6F5CYh0v9t9RxzXVsuoKDBya+kYX+H3pEPlqdkKWePesAet6irX+xzdN2vw2i9No
         /QUBp8q5lWk6uHQ3Q2OmtRcSebmKRsF/buGXKtwUEc+GrtkIne7GpLoztj5HOhdc0oYB
         o4aFlMaX4X3zzuCAeQoeqW4cP2DoRmpo5lC+p6WWCvxffjXV3DWlv5bVLDbMfIh61OyA
         vmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691931335; x=1692536135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCVvUlxQwvnZWY7TRswq2D2OW0n3M+Aa6xn7ejaiGKo=;
        b=eSAUF2PguJie8KI6gzDDB9rvKtBVtoZmW1RVDtq6hP2C2zcwWZJkEL0Y1BOvfztA58
         ofFajByZcudsJbsMF+4b0NDBV/Pm+ZbxkAABFSQvbEsunX2nlIqetSnDxSsLENcHjb6A
         /hRXtGjD+xGoETjHgSvPRQ20jmOgx/+2+a5Z2VtTfBB2U8i43/jiQ0Ei8e5xoShnIzND
         RzAks2z9nQyc9MBz+Nuk9IlqFHUqbeyY0gTEltz+QHlOBdyvhTQG1jo7VstGaVy+CUiB
         +WJuoPJ0s8sysA76q+SvgdwgVXlLFtu5KVxK3UPKLaI/R1viWDdbG84DYuCybu8/V2d1
         MkmQ==
X-Gm-Message-State: AOJu0Yxj2a/MscjAfVal8ek8dQS4Ntv9z42D44DfFDkbdC7qXK9Dwjv4
        gOAmxNUHtxE6X80s5JBRYIw3PMYwohKXFcq3MYc=
X-Google-Smtp-Source: AGHT+IFwpATF3RxAsDXzH3GGlUPPVr/k9MqMhavMsfesMEOyKSQwar/d4RqPpBy6KyDjYeklJou/YQ==
X-Received: by 2002:a17:90a:294e:b0:268:2d6:74d6 with SMTP id x14-20020a17090a294e00b0026802d674d6mr4777448pjf.16.1691931335395;
        Sun, 13 Aug 2023 05:55:35 -0700 (PDT)
Received: from localhost.localdomain ([121.32.69.222])
        by smtp.gmail.com with ESMTPSA id gv12-20020a17090b11cc00b002681131c36csm8113954pjb.45.2023.08.13.05.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 05:55:34 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     perex@perex.cz, tiwai@suse.com, sboyd@kernel.org,
        mripard@kernel.org, linux-kernel@vger.kernel.org,
        Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH RESEND] ASoC: tlv320aic32x4: Fix the divide by zero
Date:   Sun, 13 Aug 2023 20:55:20 +0800
Message-Id: <20230813125520.11067-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The value of register(NDAC,MDAC,NADC,MADC,BCLKN) maybe zero lead to
divide by zero in clk_aic32x4_div_recalc_rate().And the rate should be
divide by 128 if the value was zero in this function according to the
datasheet.

Add the macro AIC32X4_DIV_MAX to present the 128 and return 0 if failing
to read the value of register.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 16 +++++++++++-----
 sound/soc/codecs/tlv320aic32x4.h     |  5 +++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index c116e82f712d..5c0a76a4a106 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -321,7 +321,7 @@ static int clk_aic32x4_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	u8 divisor;
 
 	divisor = DIV_ROUND_UP(parent_rate, rate);
-	if (divisor > 128)
+	if (divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
 
 	return regmap_update_bits(div->regmap, div->reg,
@@ -334,7 +334,7 @@ static int clk_aic32x4_div_determine_rate(struct clk_hw *hw,
 	unsigned long divisor;
 
 	divisor = DIV_ROUND_UP(req->best_parent_rate, req->rate);
-	if (divisor > 128)
+	if (divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
 
 	req->rate = DIV_ROUND_UP(req->best_parent_rate, divisor);
@@ -345,12 +345,18 @@ static unsigned long clk_aic32x4_div_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
 	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
-
 	unsigned int val;
+	int err;
+
+	err = regmap_read(div->regmap, div->reg, &val);
+	if (err)
+		return 0;
 
-	regmap_read(div->regmap, div->reg, &val);
+	val &= AIC32X4_DIV_MASK;
+	if (!val)
+		val = AIC32X4_DIV_MAX;
 
-	return DIV_ROUND_UP(parent_rate, val & AIC32X4_DIV_MASK);
+	return DIV_ROUND_UP(parent_rate, val);
 }
 
 static const struct clk_ops aic32x4_div_ops = {
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 4de5bd9e8cc5..d6101ce73f80 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -223,8 +223,9 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_REFPOWERUP_120MS	0x07
 
 /* Common mask and enable for all of the dividers */
-#define AIC32X4_DIVEN           BIT(7)
-#define AIC32X4_DIV_MASK        GENMASK(6, 0)
+#define AIC32X4_DIVEN			BIT(7)
+#define AIC32X4_DIV_MASK		GENMASK(6, 0)
+#define AIC32X4_DIV_MAX			128
 
 /* Clock Limits */
 #define AIC32X4_MAX_DOSR_FREQ		6200000
-- 
2.25.1

