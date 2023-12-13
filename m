Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DC811014
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377787AbjLMLdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377485AbjLMLdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:33:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90604121
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50e0daa57b3so887975e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702467189; x=1703071989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htZ0z29JSHaeYwcbtg65xi6QGYr+mWu8yuJLXo0qg0Q=;
        b=IoLGYe6KP+b9LGA1FczNmeVY4HD+Dx7R3PSP5fAMjc4EjROy12r8QCCGNmCKTyjQ4W
         Z2z+hpQnjysSWA+aefCWLEOP4rC15S2VwU5K4ZMjwWHu0JJ+JItXHfd+9JnBSyYLwchc
         rFHfirWWB7Mo2M4DTdQqSR4BBlKmVmNN+I0CFLV9eWDI44pl3Z8872DB2Xk8ACveo0LN
         eRTN6K8A5HLW6Gnqylzg5DNcpUwQZ0YDF8kCCIoxT1IUREjv7j49hJqQK/3fymF0mvY1
         0m37VEXKGebJlEDy2vz71bZ3lbPFTQu1kSN7CR1dsB5F37HotBaiFnxwE08lrVdA2+sM
         bV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467189; x=1703071989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htZ0z29JSHaeYwcbtg65xi6QGYr+mWu8yuJLXo0qg0Q=;
        b=Op694CGtjg7qKy1GT+WyaUsZxmnWLAYnhDKRONt8L2gvO928xyOJD3bPoTU906Mf1Z
         ARkVwig09dxlZu/yNzxlwdBcVl4JP3Yg3EE9hCucG8qHvCAchbbk2eDfpDoio3xrOXgX
         XklUDvo6ab503CEm86fgNPwcSq1WX5RFgKS6tW+rpd1Q6TDLV4v3ocXjzTKhIqgtHUSb
         Sdoe6UvtL4REWeduYFLVmL8CrJceRJLOC+3fZSLjogKFgFX/rCkUC8BxuMC2vnAlWIxS
         9q7VyP8FG/qlwKtXydcjhgiJ6Q9munSuAXDGWMHGr1cs7mdLDMRk9CESwBMfW4CL3N1H
         DIoA==
X-Gm-Message-State: AOJu0YyN2KFP3OmYysrAJYs3rTK/TxwYoMjlf32bEUQw5/X63i4DmuUz
        4kADCPVyfhe3ZmdvjmYikb4aDw==
X-Google-Smtp-Source: AGHT+IEYU8QnX1qYGV0hcMy23DhWt+J8l2mgG2U1R7ZB+WwMmxmp0UT250v/mB4bMySh4QlUHetkoA==
X-Received: by 2002:a05:6512:368d:b0:50b:ec26:7c56 with SMTP id d13-20020a056512368d00b0050bec267c56mr2054856lfs.50.1702467188879;
        Wed, 13 Dec 2023 03:33:08 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id fc18-20020a056512139200b0050bda0f8835sm1594955lfb.119.2023.12.13.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:08 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM: domains: Move genpd and its governor to the pmdomain subsystem
Date:   Wed, 13 Dec 2023 12:33:05 +0100
Message-Id: <20231213113305.29098-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems reasonable to collect the core parts for the generic PM domain,
along with its corresponding provider drivers. Therefore let's move the
files from drivers/base/power/ to drivers/pmdomain/ and while at it, let's
also rename the files accordingly.

Moreover, let's also update MAINTAINERS to reflect the update.

Cc: Kevin Hilman <khilman@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                            | 10 +---------
 drivers/base/power/Makefile                            |  1 -
 drivers/pmdomain/Makefile                              |  1 +
 drivers/{base/power/domain.c => pmdomain/core.c}       |  0
 .../power/domain_governor.c => pmdomain/governor.c}    |  0
 5 files changed, 2 insertions(+), 10 deletions(-)
 rename drivers/{base/power/domain.c => pmdomain/core.c} (100%)
 rename drivers/{base/power/domain_governor.c => pmdomain/governor.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af79..ab4b0aed34f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8878,21 +8878,13 @@ F:	Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.yaml
 F:	drivers/i2c/muxes/i2c-demux-pinctrl.c
 
 GENERIC PM DOMAINS
-M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Kevin Hilman <khilman@kernel.org>
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/power/power?domain*
-F:	drivers/base/power/domain*.c
-F:	include/linux/pm_domain.h
-
-GENERIC PM DOMAIN PROVIDERS
-M:	Ulf Hansson <ulf.hansson@linaro.org>
-L:	linux-pm@vger.kernel.org
-S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:	drivers/pmdomain/
+F:	include/linux/pm_domain.h
 
 GENERIC RADIX TREE
 M:	Kent Overstreet <kent.overstreet@linux.dev>
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 8fdd0073eeeb..01f11629d241 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -2,7 +2,6 @@
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o wakeup_stats.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
-obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
 
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index f0326b27b30b..a68ece2f4c68 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -16,3 +16,4 @@ obj-y					+= sunxi/
 obj-y					+= tegra/
 obj-y					+= ti/
 obj-y					+= xilinx/
+obj-y					+= core.o governor.o
diff --git a/drivers/base/power/domain.c b/drivers/pmdomain/core.c
similarity index 100%
rename from drivers/base/power/domain.c
rename to drivers/pmdomain/core.c
diff --git a/drivers/base/power/domain_governor.c b/drivers/pmdomain/governor.c
similarity index 100%
rename from drivers/base/power/domain_governor.c
rename to drivers/pmdomain/governor.c
-- 
2.34.1

