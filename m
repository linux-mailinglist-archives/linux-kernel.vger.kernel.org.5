Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B775C1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGUI3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGUI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:29:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FDA2D76
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:35 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a43cbb4343so1034448b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689928175; x=1690532975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjm1htpsgUdaRZcHsGo757GH1rkymaOgiUPQg9DWT7s=;
        b=RW7GYa24SF9OUtc1EwYBobJChC2NGH/9ryiaix+d6Lb7prlVSNmtW31odoBZ6MdhLH
         xGf7HcgZhS4CC2qc338kcpffmjLxhCqX7S0PN2nGX253i2MbmLXJM2aQLiaav5rxRzXS
         lkoLYnuPiwJNtT85A02CwFnryI1ZJ+Pyk2yuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928175; x=1690532975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjm1htpsgUdaRZcHsGo757GH1rkymaOgiUPQg9DWT7s=;
        b=Yl5O/oE1NQjWhxNizOjJtbGcVHUhpammyJK3Bqn3zLrdqiC43/HfKrTeV45t6EDkGC
         kIiZ+YR/EeiYSDtgzS6+EXWPBFZYUWh1ZswMNnlSoAxt9qCMZVDWOBNqe8m2h8Tvg6yi
         OLZ3y3Fruq3ndIexcCP4UtaqAtmE+kjfK0Zvd6gtSZL1EhWCLX9GcWjQ0u+Djply4MuH
         gOaZv+9QDIMKYviY0acGVSaP0Ed0puJ6qQqIv5YHysDayA9zrz6GdaeAXmUtFB0i3lif
         1oLBvIEREBbG4M/WKvPbyZ0SBT8KED26Xydy9Evx3bwM88reLoI8ldfjj+Zn8JA3Mftz
         hKuQ==
X-Gm-Message-State: ABy/qLbInhVs0micYdMGXb0MRM80NxPKJVVey0/p0MOIgWdagvUSFlI1
        niuFCJX7BZ1tBF5TjSURhFMuCw==
X-Google-Smtp-Source: APBJJlEaH+ytBtT6CWe3CshSGBWY3wUzqSd86sdwBGEZQQl0EkYUmpQfwwK3cbB5v7Sicgp2RjpOUQ==
X-Received: by 2002:a05:6808:280b:b0:3a4:350e:b213 with SMTP id et11-20020a056808280b00b003a4350eb213mr1139687oib.27.1689928175257;
        Fri, 21 Jul 2023 01:29:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6d86:d21:714:abab])
        by smtp.gmail.com with ESMTPSA id d26-20020a63991a000000b0055fe64fd3f4sm2594382pge.9.2023.07.21.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:29:34 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fei Shao <fshao@chromium.org>
Subject: [PATCH RESEND v2 3/7] regulator: mt6358: Fix incorrect VCN33 sync error message
Date:   Fri, 21 Jul 2023 16:28:55 +0800
Message-ID: <20230721082903.2038975-4-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721082903.2038975-1-wenst@chromium.org>
References: <20230721082903.2038975-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After syncing the enable status of VCN33_WIFI to VCN33_BT, the driver
will disable VCN33_WIFI. If it fails it will error out with a message.
However the error message incorrectly refers to VCN33_BT.

Fix the error message so that it correctly refers to VCN33_WIFI.

Suggested-by: Fei Shao <fshao@chromium.org>
Fixes: 65bae54e08c1 ("regulator: mt6358: Merge VCN33_* regulators")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index da6b40f947c4..b9cda2210c33 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -661,7 +661,7 @@ static int mt6358_sync_vcn33_setting(struct device *dev)
 	/* Disable VCN33_WIFI */
 	ret = regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, BIT(0), 0);
 	if (ret) {
-		dev_err(dev, "Failed to disable VCN33_BT\n");
+		dev_err(dev, "Failed to disable VCN33_WIFI\n");
 		return ret;
 	}
 
-- 
2.41.0.487.g6d72f3e995-goog

