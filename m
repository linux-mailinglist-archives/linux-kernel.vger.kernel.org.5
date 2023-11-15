Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9234B7ED4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbjKOU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbjKOU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:59:20 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AAFBD;
        Wed, 15 Nov 2023 12:58:44 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso43405a34.2;
        Wed, 15 Nov 2023 12:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081923; x=1700686723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DNw5hefDLTG0j4qbA4dW0wqpyWD+OlJB5Qqx3rsaXk=;
        b=LtFWxHtCHE14MQVKqvU1+L/vfgEL+mUwv4SpXmumSlvC11781XSmtR6AEyq/oYA/YY
         tf1rTuu4LJqbjuAQ2dsUHR3UPxppfIumTzPNLhI4esRlRkJ+YAHGn5f6PuW2QNnVpp1b
         GR1SLKe3yTp5TQ4DAa7I3ZpTOSb3rF7CyWjfx2x/8hR2etDvtp3x282cl2tudvk8ksFa
         2JKrveoMhYBCbKWyNSyeUd/qB0AyAetr9ID1lyXBQ41QdL2XRychwfo2U0AM/4JsBSRL
         DJYJumL7Q8XkMIp+naiZGCCWgYjNzk1j1fCBhRX+ezo/Fp00LY8DYBCpqBDu6TSp6hLN
         S7Vw==
X-Gm-Message-State: AOJu0YwT291S7P6H2nCY1tCFkJNaRhaCSmOIhQ13ylvONS/RNkGW7EwB
        9crnPo3dmgU/zszMxGz+FA==
X-Google-Smtp-Source: AGHT+IGo6Yb7kPPy3PY7Ndx1XXPFo8iME5kmXwWIiLRanl+Wen5CAgy7ryBYlF7h8/a7/4RKzPQq9g==
X-Received: by 2002:a9d:7648:0:b0:6b9:4d79:e08a with SMTP id o8-20020a9d7648000000b006b94d79e08amr7245073otl.32.1700081923514;
        Wed, 15 Nov 2023 12:58:43 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a18-20020a056830101200b006cdf9935af2sm493131otp.53.2023.11.15.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 12:58:42 -0800 (PST)
Received: (nullmailer pid 3732498 invoked by uid 1000);
        Wed, 15 Nov 2023 20:58:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] thermal: loongson2: Replace of_device.h with explicit includes
Date:   Wed, 15 Nov 2023 14:58:28 -0600
Message-ID: <20231115205828.3732207-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h.

of_device.h isn't needed, but mod_devicetable.h and property.h were
implicitly included.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/thermal/loongson2_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 133098dc0854..644596f5e3bb 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -8,9 +8,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
 #include "thermal_hwmon.h"
-- 
2.42.0

