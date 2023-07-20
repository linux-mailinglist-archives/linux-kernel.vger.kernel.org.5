Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E440C75AE79
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGTMdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGTMd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:33:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F5A2;
        Thu, 20 Jul 2023 05:33:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so2415619e87.1;
        Thu, 20 Jul 2023 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689856406; x=1690461206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00TBgGs9/x2395DFaQcI1ejZAz1FlgitzxZyGoIQYBo=;
        b=b9nmxZy6KVcznno15iMSw8WsAHn9FeWVx1/TB89iEhUO4keTXVQqlhbPQJt0Rg6VzM
         LZXw6KkF+Rdkfnud3nxa14JcoyWllCyHhKtoR8ZlJ0tQXbwKb8Vr+5vu5DUNq7qv0STb
         H5RQtCoPB6pYfgFoEZhsYv1L4PJ9S2AkPiQKzrG3PbOTwvml7EGbZ26D/8W22VFVtEDJ
         ubNnafFWdxu5b1HSnCgqFzROgQNYigRtLtyiuCGjYWitvJrq0xXj2Xg6/JkxuXV8u55J
         GbRwfP/ZoMnEw5v/NHbY1F4mMvoLJI5tfNgsy5Ox5FiftQLLkQOxZHE9po5wVNQbAw+7
         r7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689856406; x=1690461206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00TBgGs9/x2395DFaQcI1ejZAz1FlgitzxZyGoIQYBo=;
        b=F3f+17MV/HNzG2dMH3GyhUYql9chkEAT+l1nJbXq7r6J9HMsv1OVsNHqPVE405bnuF
         J0yATHiavlX8dw/0QMo/tF55J+hodjHufMQmzSmQcGnY0YCUdHEfYzFYWmpZ1Yw36L5E
         piyk9BX0sN6tEpkV82EEj9nyM9L59z/2mdR/JiDdWuO7extK0xdmFXm8DYGHfyVsIAoj
         0xoCZFVYXV54LybElVGrfdSBI9swL1cwBvVax+sn3fwCsVI7vshtZP3tEhtfycJa4CkJ
         wEMmzSSpaIC6D+kfkQnfRVzeUgq5+IVFhQYyE7Zzi9hiHUVQUrcaRjVCLM//KYQH0/U/
         0fRA==
X-Gm-Message-State: ABy/qLaw94IZG35xa5fMxvKPTbUFpBRmyHMsGnaI43RLxIdC2lOM8K4Q
        AkSD9Nxf5bZnZ+kCMyWhkXKBFzr35T0Aig==
X-Google-Smtp-Source: APBJJlGBWbeKkuAroHYB1XufGk1hhNt3Suw/M9bvbKZkt4URe3D7vm19QJDdXwePvkkwqk7AXWHJCQ==
X-Received: by 2002:a2e:8ec4:0:b0:2b6:d0c1:7cd0 with SMTP id e4-20020a2e8ec4000000b002b6d0c17cd0mr973716ljl.22.1689856406159;
        Thu, 20 Jul 2023 05:33:26 -0700 (PDT)
Received: from wro1-ldl-p01774.synapse.com ([94.42.83.62])
        by smtp.gmail.com with ESMTPSA id z5-20020a19f705000000b004ec84d24818sm182767lfe.282.2023.07.20.05.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:33:25 -0700 (PDT)
From:   Przemyslaw <przemekchwiala@gmail.com>
To:     hdegoede@redhat.com, krzysztof.kozlowski@linaro.org,
        m.szyprowski@samsung.com, sebastian.krzyszkowiak@puri.sm,
        kernel@puri.sm, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com,
        Przemyslaw Chwiala <przemekchwiala@gmail.com>
Subject: [PATCH] power: supply: max17042_battery: Do not use CONFIG_ prefix in regular C code
Date:   Thu, 20 Jul 2023 14:31:02 +0200
Message-Id: <20230720123102.154699-1-przemekchwiala@gmail.com>
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

From: Przemyslaw Chwiala <przemekchwiala@gmail.com>

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

