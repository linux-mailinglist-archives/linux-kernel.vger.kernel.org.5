Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396467A600A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjISKsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjISKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:47:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B44E188
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:47:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c453379020so21264905ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695120459; x=1695725259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xQUn/IJIaVFS0x99xumnipF7RzW+wF0bxWwjg0oCIk=;
        b=HPZ3QuhOK8hf4Vk5Qx7kdD+K5prsC9/0Y2aVrjzjVsxNFbu9joD2Ou0lZqDqAnavy0
         YOQSbKM6L+WLCiA0/hlxq+inTIT7aBwsJnit2V+GLmppHUnVHIScGsa9RUTefOL21fwW
         Zl/BDv+eI6zSzpRl6xHhaghkdECFJWScLhtTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120459; x=1695725259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xQUn/IJIaVFS0x99xumnipF7RzW+wF0bxWwjg0oCIk=;
        b=EniMLJnNWCHvotwAWyjAmFJzR3/KCirRnelcfEshpO9LLpA0HeZBx1yWn1XzN3HnXf
         FUWjyebZLN+Khq15HpttingPbXWHmvidMwu2zS291PhNJHFxINB3yEI42K4NL1zuWV3Q
         NyfmDdUxflj7HzwtSIzVl+FG+eFgiF6ijbRmTat3w902IklhGkAimh4sSAS0h/HPqjLQ
         T+T7a+L/H/Nw8PcuDmfSQkuAAvrIIcYicP6z2aazX46dbe1YAOPOtpzveTkC8B0psOhK
         yvOtFuK+xxB4hwhgswuNvnMfQcWiZndFuPElVfmMBzdGSCvd1VJod71xh3hQSTIVc/r5
         tLqw==
X-Gm-Message-State: AOJu0Yx5UxC1LwemPixC/9gVd/WWMrJJPVF68LOB3uuykmMZMqM1OQSB
        zlLi+FY6RGvPqbWHJLvhRPpajQ==
X-Google-Smtp-Source: AGHT+IFe+997cxzsySXWWAQS25qUgXP0auEIHzVPbzDEWEBNw4i2aKJTdNMm2yHSkRleB/3+4BvJcg==
X-Received: by 2002:a17:903:1cd:b0:1bf:650b:14fb with SMTP id e13-20020a17090301cd00b001bf650b14fbmr11811076plh.42.1695120459673;
        Tue, 19 Sep 2023 03:47:39 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:40a:900d:e731:5a43])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001bc445e249asm6719578plg.124.2023.09.19.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 03:47:39 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 06/12] regulator: mt6358: Use mt6397-regulator.h binding header for buck mode macros
Date:   Tue, 19 Sep 2023 18:43:49 +0800
Message-ID: <20230919104357.3971512-7-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919104357.3971512-1-wenst@chromium.org>
References: <20230919104357.3971512-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The (undocumented) possible values for the buck operating modes on the
MT6358 are the same as those on the MT6397, both for the device tree
bindings and the actual hardware register values.

Reuse the macros for the MT6397 PMIC in the MT6358 regulator driver by
including the mt6397-regulator.h binding header and replacing the
existing macros. This aligns it with other PMIC.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- new patch

 drivers/regulator/mt6358-regulator.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 4a6ad0ccf03b..c312e79a0a39 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -13,8 +13,7 @@
 #include <linux/regulator/mt6358-regulator.h>
 #include <linux/regulator/of_regulator.h>
 
-#define MT6358_BUCK_MODE_AUTO	0
-#define MT6358_BUCK_MODE_FORCE_PWM	1
+#include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
 
 /*
  * MT6358 regulators' information
@@ -326,7 +325,7 @@ static const struct linear_range vldo28_ranges[] = {
 
 static unsigned int mt6358_map_mode(unsigned int mode)
 {
-	return mode == MT6358_BUCK_MODE_AUTO ?
+	return mode == MT6397_BUCK_MODE_AUTO ?
 		REGULATOR_MODE_NORMAL : REGULATOR_MODE_FAST;
 }
 
@@ -374,10 +373,10 @@ static int mt6358_regulator_set_mode(struct regulator_dev *rdev,
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		val = MT6358_BUCK_MODE_FORCE_PWM;
+		val = MT6397_BUCK_MODE_FORCE_PWM;
 		break;
 	case REGULATOR_MODE_NORMAL:
-		val = MT6358_BUCK_MODE_AUTO;
+		val = MT6397_BUCK_MODE_AUTO;
 		break;
 	default:
 		return -EINVAL;
@@ -408,9 +407,9 @@ static unsigned int mt6358_regulator_get_mode(struct regulator_dev *rdev)
 	}
 
 	switch ((regval & info->modeset_mask) >> (ffs(info->modeset_mask) - 1)) {
-	case MT6358_BUCK_MODE_AUTO:
+	case MT6397_BUCK_MODE_AUTO:
 		return REGULATOR_MODE_NORMAL;
-	case MT6358_BUCK_MODE_FORCE_PWM:
+	case MT6397_BUCK_MODE_FORCE_PWM:
 		return REGULATOR_MODE_FAST;
 	default:
 		return -EINVAL;
-- 
2.42.0.459.ge4e396fd5e-goog

