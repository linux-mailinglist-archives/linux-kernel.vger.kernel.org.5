Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E583C75C1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGUI34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjGUI3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:29:41 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D054273C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:38 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-563439ea4a2so1076785eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689928178; x=1690532978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys0r8p0mIPfGi9bl8X8cEqDLnuWcCtUcJ0oWQjuIrRg=;
        b=J652JuDYAUtc/gckkv+10/iqRTK8vq4DdfVxBL10Azkhg6LCGGDB2uj/ANrRKkQrzL
         oy4UiFu28vAWj08W733djKdD6OJF2mBh8P1kPIR2sgnFzCeqE/PU4Y5AxdV4bJMUjEVP
         KAO+43rtUglLxW1awsbDFwicekL2Rfoh8c+10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928178; x=1690532978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys0r8p0mIPfGi9bl8X8cEqDLnuWcCtUcJ0oWQjuIrRg=;
        b=lABbo9mh2tl3xEidytpWLrBQ/dm1UODkuWDu8VFRt2qH456zhp1jlnCsmItQ+Km61l
         CtFxi0O9V7kRA5PFKvmyiD5CUM3ApFSP1izsldyELBUCzi02f1DYJ4RLekdDA9utmE2+
         qhLH1+pLss+WR8IFKHfHn4af9ByC4an0NLnBro634yKp1wfGdylh8Yp/qwP2oWe34U0N
         +uKNTnDZ/Joq67rMwapKwTLaCe80t/0zKqUMqrVmCUaFQo1XaDbqh17jM+LdZrcRJEuw
         OayY9S7poHXVCT4Mm+i9qPf22rsnAYE4m9IRei9jiBsxJh46uoAeh6KRymyL8MMYligf
         cibw==
X-Gm-Message-State: ABy/qLbyknlcblw2q36zJ5PiBGhkjhJpKAo5zCXv7JSE3ktbFnXYlueB
        3U8r/Bzb9WctENk5YOzX/+/0+Q==
X-Google-Smtp-Source: APBJJlH4zr16V8/zoAw9LSHLzoGP6ZJ04FLTsy+Rw6XaPcaQHV7bk9/6klOg9xRA3fzhtSjy6Vugzw==
X-Received: by 2002:a05:6358:27a8:b0:135:6d9:2399 with SMTP id l40-20020a05635827a800b0013506d92399mr1442813rwb.30.1689928177700;
        Fri, 21 Jul 2023 01:29:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6d86:d21:714:abab])
        by smtp.gmail.com with ESMTPSA id d26-20020a63991a000000b0055fe64fd3f4sm2594382pge.9.2023.07.21.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:29:37 -0700 (PDT)
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
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 4/7] regulator: mt6358: Fail probe on unknown chip ID
Date:   Fri, 21 Jul 2023 16:28:56 +0800
Message-ID: <20230721082903.2038975-5-wenst@chromium.org>
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

The MT6358 and MT6366 PMICs, and likely many others from MediaTek, have
a chip ID register, making the chip semi-discoverable.

The driver currently supports two PMICs and expects to be probed on one
or the other. It does not account for incorrect mfd driver entries or
device trees. While these should not happen, if they do, it could be
catastrophic for the device. The driver should be sure the hardware is
what it expects.

Make the driver fail to probe if the chip ID presented is not a known
one.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: f0e3c6261af1 ("regulator: mt6366: Add support for MT6366 regulator")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index b9cda2210c33..a1eae45f5fee 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -676,12 +676,18 @@ static int mt6358_regulator_probe(struct platform_device *pdev)
 	const struct mt6358_regulator_info *mt6358_info;
 	int i, max_regulator, ret;
 
-	if (mt6397->chip_id == MT6366_CHIP_ID) {
-		max_regulator = MT6366_MAX_REGULATOR;
-		mt6358_info = mt6366_regulators;
-	} else {
+	switch (mt6397->chip_id) {
+	case MT6358_CHIP_ID:
 		max_regulator = MT6358_MAX_REGULATOR;
 		mt6358_info = mt6358_regulators;
+		break;
+	case MT6366_CHIP_ID:
+		max_regulator = MT6366_MAX_REGULATOR;
+		mt6358_info = mt6366_regulators;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported chip ID: %d\n", mt6397->chip_id);
+		return -EINVAL;
 	}
 
 	ret = mt6358_sync_vcn33_setting(&pdev->dev);
-- 
2.41.0.487.g6d72f3e995-goog

