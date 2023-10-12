Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E87C6B12
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjJLK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347133AbjJLK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:27:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE4CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:27:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40651a726acso8110965e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697106427; x=1697711227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQFTPYux32bkJIxgqrdnxVBc3lqPGjAfWUK2pgjn7rI=;
        b=RrtLssvUJxeY9mT0JuHVfFepvq+2fJpnZ+eX6SxoiVe5+3svG2Ez+NaXl/KluFIbie
         FlFctnhv1oFoIghI2XqoVYvUMfKnfnr+3Ri8xDlVVZeGA3pCUTfbtqywj8gaTLq1Dq5f
         Ji5WUr3/dOETrHalZwPMujBphDB/Q3g2lth+xp1xQg+iE/D4Mn7292oivbRFH1B+8K8u
         oOcLzMXiyMX0XlVC5l2LTsH385Tt9FV0WUKzQwzWQLGE7mdAc7vkaqNcj+EecCcdUHKH
         rAS3K524eiPC9/TmLuqBEahu0Hy84mM++G/fcP+rUloqHbXVWvf9om2gUQx9j7oVX80D
         rzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697106427; x=1697711227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQFTPYux32bkJIxgqrdnxVBc3lqPGjAfWUK2pgjn7rI=;
        b=oZs/ZUB8SM8hqnLutcmmbz5IGdNDkJ4+eQLDmOJJLakpCEzl3OXnoeg3bhu63q9osL
         4JbEYX+rYr2r37GXBKIGJPf26toPDjnhQwttxc1CVpkVWujvGmxaS73yKskEh14hXygD
         a7tToMhqtJqDZFDM0rJFM3Kel5pz04QJjjnX0xsXh16HkkpgaCBV6fw6LPwGJQQsnMM2
         CIeqELraBu+hfR3uM6EMmFB+QDITWyyF+epTHzJQ2H3al6utW5j96wf/I2785JRTPJUH
         vB0Wg/Vug6g0xmUVyV6tW9fN9Hf8mhB/HuFtw//InFsrK5HAjPmz4o/Mjtl5JK0cl/t2
         ZWsA==
X-Gm-Message-State: AOJu0YzQOyJ77xqZtTrKLomEb6+qB/5qnhyAkYniqygIix7LtXBkqc5o
        KYpbAtS/dWDimYiWz28HTeMi8w==
X-Google-Smtp-Source: AGHT+IFqoY1cr+DhnY1o7SPlM2iF7e9VXj353COvBQwi/ECuub7MVp44/HtQGMV6tDkQ5D0EHknaeA==
X-Received: by 2002:a05:600c:3652:b0:405:3dd0:6ee9 with SMTP id y18-20020a05600c365200b004053dd06ee9mr21322101wmq.34.1697106427168;
        Thu, 12 Oct 2023 03:27:07 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm21506797wmk.1.2023.10.12.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:27:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal/core: Hardening the self-encapsulation
Date:   Thu, 12 Oct 2023 12:26:58 +0200
Message-Id: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal private header has leaked all around the drivers which
interacted with the core internals. The thermal zone structure which
was part of the exported header led also to a leakage of the fields
into the different drivers, making very difficult to improve the core
code without having to change the drivers.

Now we mostly fixed how the thermal drivers were interacting with the
thermal zones (actually fixed how they should not interact). The
thermal zone structure will be moved to the private thermal core
header. This header has been removed from the different drivers and
must belong to the core code only. In order to prevent this private
header to be included again in the drivers, make explicit only the
core code can include this header by defining a THERMAL_CORE_SUBSYS
macro. The private header will contain a check against this macro.

The Tegra SoCtherm driver needs to access thermal_core.h to have the
get_thermal_instance() function definition. It is the only one
remaining driver which need to access the thermal_core.h header, so
the check will emit a warning at compilation time.

Thierry Reding is reworking the driver to get rid of this function [1]
and thus when the changes will be merged, the compilation warning will
be converted to a compilation error, closing definitively the door to
the drivers willing to play with the thermal zone device internals.

No functional changes intended.

[1] https://lore.kernel.org/all/20230414125721.1043589-1-thierry.reding@gmail.com/

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_bang_bang.c       | 1 +
 drivers/thermal/gov_fair_share.c      | 1 +
 drivers/thermal/gov_power_allocator.c | 1 +
 drivers/thermal/gov_step_wise.c       | 1 +
 drivers/thermal/gov_user_space.c      | 1 +
 drivers/thermal/thermal_acpi.c        | 1 +
 drivers/thermal/thermal_core.c        | 1 +
 drivers/thermal/thermal_core.h        | 4 ++++
 drivers/thermal/thermal_helpers.c     | 1 +
 drivers/thermal/thermal_hwmon.c       | 1 +
 drivers/thermal/thermal_netlink.c     | 1 +
 drivers/thermal/thermal_of.c          | 1 +
 drivers/thermal/thermal_sysfs.c       | 1 +
 drivers/thermal/thermal_trip.c        | 1 +
 14 files changed, 17 insertions(+)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 1b121066521f..752c627075ba 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -11,6 +11,7 @@
 
 #include <linux/thermal.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 static int thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 03c2daeb6ee8..108cb5074594 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 #include "thermal_trace.h"
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /**
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 8642f1096b91..d1c6ad92e5b4 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -14,6 +14,7 @@
 #define CREATE_TRACE_POINTS
 #include "thermal_trace_ipa.h"
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 #define INVALID_TRIP -1
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 1050fb4d94c2..1c844004afe5 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -14,6 +14,7 @@
 #include <linux/minmax.h>
 #include "thermal_trace.h"
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /*
diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 8bc1c22aaf03..8883c9ca930f 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 static int user_space_bind(struct thermal_zone_device *tz)
diff --git a/drivers/thermal/thermal_acpi.c b/drivers/thermal/thermal_acpi.c
index 0e5698818f69..556c9f0cc40d 100644
--- a/drivers/thermal/thermal_acpi.c
+++ b/drivers/thermal/thermal_acpi.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/units.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /*
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 58533ea75cd9..9ee0ec3bdff6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -24,6 +24,7 @@
 #define CREATE_TRACE_POINTS
 #include "thermal_trace.h"
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index de884bea28b6..387b06c49415 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -14,6 +14,10 @@
 
 #include "thermal_netlink.h"
 
+#ifndef THERMAL_CORE_SUBSYS
+#warning This header can only be included by the thermal core code
+#endif
+
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 4d66372c9629..26804cfdd494 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 #include "thermal_trace.h"
 
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c3ae44659b81..ba2ae5be0c23 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -17,6 +17,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_hwmon.h"
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /* hwmon sys I/F */
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 08bc46c3ec7b..f3ac6432bf5f 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -11,6 +11,7 @@
 #include <net/genetlink.h>
 #include <uapi/linux/thermal.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 static const struct genl_multicast_group thermal_genl_mcgrps[] = {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1e0655b63259..db83596ea105 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /***   functions parsing device tree nodes   ***/
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 4e6a97db894e..ca616b3f5172 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/jiffies.h>
 
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 /* sys I/F for thermal zone */
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 024e2e365a26..2f4c6fa83bea 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -7,6 +7,7 @@
  *
  * Thermal trips handling
  */
+#define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
 int for_each_thermal_trip(struct thermal_zone_device *tz,
-- 
2.34.1

