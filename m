Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A475AE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGTMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:25:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6446A2;
        Thu, 20 Jul 2023 05:25:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso1145220e87.0;
        Thu, 20 Jul 2023 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689855950; x=1690460750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikDfal5Trlv1e/jdelfFVdKYCn4a86M6Q8R9xOEO/oQ=;
        b=C+bWwclPKuMEzgF/DKUJlcsG6BT5mLTthUjuOgV6I9t4Q2aKDDBhwefFh/6LQDaH07
         b7Pws00PxJyNNYCSJG9KrbsVBUyrcWVpOGIRkAq5kJrN2D84IF/K0JsgOLAOIq8Hru8/
         /vYl8ld/yE3pa69nS6KJrgVvVKgR3Kl6ZhBU1qGaMaQQkbRC8mNNiAwWt4twSFFZrpED
         nvGJPAex+auZLUzCc8YQUCK4DBwggEWCi3qktom33/Thq5dcRJHLf71nozugPbJy2bji
         Evr/jwFpsaozAaL+Bu5H7Tydv11+hodqNsVaCXQsfuozgLSKqWsDEe5cs20HeAh2MB5k
         TJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689855950; x=1690460750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikDfal5Trlv1e/jdelfFVdKYCn4a86M6Q8R9xOEO/oQ=;
        b=Bt4DNQj1yI1yZVZ113YBIZTdwa6JFn/h1TTmEAZHqXTZ+tRHBr/GN0iJPVvTh0ZLex
         dSpcTU3PkYMCYZAXeubyGq4dTuUAB8CfGSDy0dGxT91s7fHN5BCa/vqGX8Wiw5x8xR1a
         eDAK92nvf9usVUX7basAjdmBqHMkRExBvXaymc5OHWL5rW8/e3gGuK6nABgAS9RpcQqp
         xvRz0acL9qmHjW7Fds/1Be5k3vupWJfsjRqWlWPUCKghebyo5euvKN5bnmZIULGnzcgK
         Ot2b8PjSXB9xfxN0gJ/1HQim6MknZne+44v5rbyERMPT3uC8siRVUJVbLFrR+JF7nxzh
         IlNw==
X-Gm-Message-State: ABy/qLbmcbSCOldz1xsx53/a199VL6WoaMSqAo6qc6C3fi8oqcZ9btZg
        njUj1aaEOqczibxtKGC9U1DOv/GXAHVDDQ==
X-Google-Smtp-Source: APBJJlHnT+J9A/TJEENoBWizONmw2zj/AsVl2czuC+62itZHkE8YLckb1r92A4CLHOieGs3WtXM5zg==
X-Received: by 2002:a05:6512:280f:b0:4fa:21d5:c0a3 with SMTP id cf15-20020a056512280f00b004fa21d5c0a3mr1820481lfb.36.1689855949883;
        Thu, 20 Jul 2023 05:25:49 -0700 (PDT)
Received: from wro1-ldl-p01774.synapse.com ([94.42.83.62])
        by smtp.gmail.com with ESMTPSA id r30-20020ac25a5e000000b004f8555f7aa1sm185583lfn.52.2023.07.20.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:25:49 -0700 (PDT)
From:   Przemyslaw <przemekchwiala@gmail.com>
To:     hdegoede@redhat.com, krzysztof.kozlowski@linaro.org,
        m.szyprowski@samsung.com, sebastian.krzyszkowiak@puri.sm,
        kernel@puri.sm, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, przemoch <przemekchwiala@gmail.com>
Subject: [PATCH] power: supply: max17042_battery: Do not use CONFIG_ prefix in regular C code
Date:   Thu, 20 Jul 2023 14:25:28 +0200
Message-Id: <20230720122528.154008-1-przemekchwiala@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: przemoch <przemekchwiala@gmail.com>

Using CONFIG_ prefix for macros is not a good practice.
Use CONFIG_ prefix in Kconfig only.

Signed-off-by: Przemyslaw Chwiala <przemekchwiala@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 17ac2ab78c4e..e7d37e422c3f 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -36,7 +36,7 @@
 #define STATUS_BR_BIT          (1 << 15)
 
 /* Interrupt mask bits */
-#define CONFIG_ALRT_BIT_ENBL	(1 << 2)
+#define CFG_ALRT_BIT_ENBL	(1 << 2)
 
 #define VFSOC0_LOCK		0x0000
 #define VFSOC0_UNLOCK		0x0080
@@ -1116,8 +1116,8 @@ static int max17042_probe(struct i2c_client *client)
 						chip);
 		if (!ret) {
 			regmap_update_bits(chip->regmap, MAX17042_CONFIG,
-					CONFIG_ALRT_BIT_ENBL,
-					CONFIG_ALRT_BIT_ENBL);
+					CFG_ALRT_BIT_ENBL,
+					CFG_ALRT_BIT_ENBL);
 			max17042_set_soc_threshold(chip, 1);
 		} else {
 			client->irq = 0;
-- 
2.25.1

