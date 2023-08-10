Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B344777630
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjHJKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:47:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E210DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:47:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-523225dd110so987769a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691664473; x=1692269273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cL5UPVfVDvTPeQFgxKATIKznitcWyNXilLQp5uC80cI=;
        b=G6pHUHnoTRweCuka8lUSPfAXJhMF537/JJNKPyOuyVHJBy5UR0uOeLt8TW7dwXa4JD
         BEBO2xt/mITqpaAYcQ65ixrn/FU1/rF5Uo2CChXWuk6wBuA0iR1sT0O4SYChe32G/E9x
         2nV5gCCrVFq/EamTv7i9wU21Fs+zGTJWa/uPofqynaQLcuik19lqLog8NruRcQLUmRvp
         ZhPLwqEOmjw0yPYz8dSNNq957zC/gjOaH2cIpxW8F0j0tkGBbbzdykd2D6tbKd9B4k3W
         BXrzxJRZ78QSdp1HmG0pQX8ee0aNP460OnyCEwER3ENS5EBe7eOPBxLEYZ/CRizp28b8
         F6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664473; x=1692269273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cL5UPVfVDvTPeQFgxKATIKznitcWyNXilLQp5uC80cI=;
        b=dw5ojETBhQy6AUN1YNtfL7t55YoxFZ0PwTDOP7ssnEzpDE78QMDGw+EalrRctsGRIi
         OHwwjt7YF+WGoFf4+cpLc3oe3eRNoeDjjp/Ldamd4lOU8SwBujlmz+Aa1GqFK/6kHi0L
         9qOFq6TKc6usD4QHrw2bXKxNrJtLeSZ/AAvbSm/v9QU/RXF31jnGWuXsxd95bvYKmotl
         p2e7eajVdAI7EmAmvqAfzNcXypnuzh0EzO5nYb1PRoIckY3+H+IQSLoPqjnxrgeVE2Qw
         MVKS9/TDIIelMEJsOgNpbmKg7KaF1nKX5N5LUCr0JEzEz/tpgolkpnL7/ImnLMKO4xaj
         QgtQ==
X-Gm-Message-State: AOJu0YyHElLTVc/UMo0VSm9mqkWxcBGB9kmEOr8Te5n1FtfRS3KDk57k
        ebWLPbWEc5FXMqY5pwTpQvnoTw==
X-Google-Smtp-Source: AGHT+IGXS1aQfmfAEnnnicUw9UC/MVRyaVegshXzkv6MrwG7ZgOG9nfvxHajlaARube88C1uKtE0IA==
X-Received: by 2002:a05:6402:28a:b0:523:406a:5f6 with SMTP id l10-20020a056402028a00b00523406a05f6mr1588660edv.12.1691664472836;
        Thu, 10 Aug 2023 03:47:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7cd94000000b0051dfa2e30b2sm653854edv.9.2023.08.10.03.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:47:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, llvm@lists.linux.dev
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ASoC: aw88261: Fix unitialized ret of aw88261_reg_update()
Date:   Thu, 10 Aug 2023 12:47:43 +0200
Message-Id: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a branch in if() clause where aw88261_reg_update() could return
uninitialized value.  Pounted out by W=1 clang build:

  sound/soc/codecs/aw88261.c:651:7: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                if (aw_dev->prof_cur != aw_dev->prof_index) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  sound/soc/codecs/aw88261.c:660:9: note: uninitialized use occurs here
        return ret;
               ^~~
  sound/soc/codecs/aw88261.c:651:3: note: remove the 'if' if its condition is always true
                if (aw_dev->prof_cur != aw_dev->prof_index) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/aw88261.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 82923b454dd4..fddba2f2de41 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -636,7 +636,7 @@ static int aw88261_dev_stop(struct aw_device *aw_dev)
 static int aw88261_reg_update(struct aw88261 *aw88261, bool force)
 {
 	struct aw_device *aw_dev = aw88261->aw_pa;
-	int ret;
+	int ret = 0;
 
 	if (force) {
 		ret = regmap_write(aw_dev->regmap,
-- 
2.34.1

