Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB707AA153
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjIUVBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjIUVAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:00:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F3BFAF96E;
        Thu, 21 Sep 2023 11:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CF091655;
        Thu, 21 Sep 2023 04:34:09 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33C4C3F5A1;
        Thu, 21 Sep 2023 04:33:31 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Move power-domain driver to the pmdomain dir
Date:   Thu, 21 Sep 2023 12:33:28 +0100
Message-ID: <20230921113328.3208651-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919121605.7304-1-ulf.hansson@linaro.org>
References: <20230919121605.7304-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the Arm SCMI power-domain driver
to the new pmdomain directory.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---

Hi Ulf,

If you are happy with this, please cck. I would like to take this along
with your scmi_perf_domain change as part of you series.

Regards,
Sudeep

 drivers/firmware/arm_scmi/Makefile                           | 1 -
 drivers/pmdomain/arm/Makefile                                | 1 +
 drivers/{firmware/arm_scmi => pmdomain/arm}/scmi_pm_domain.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/{firmware/arm_scmi => pmdomain/arm}/scmi_pm_domain.c (100%)

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index b31d78fa66cc..a7bc4796519c 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -16,7 +16,6 @@ scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 
-obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
 obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
 
 ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
diff --git a/drivers/pmdomain/arm/Makefile b/drivers/pmdomain/arm/Makefile
index 7128db96deac..cfcb1f6cdd90 100644
--- a/drivers/pmdomain/arm/Makefile
+++ b/drivers/pmdomain/arm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_ARM_SCMI_PERF_DOMAIN) += scmi_perf_domain.o
+obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
similarity index 100%
rename from drivers/firmware/arm_scmi/scmi_pm_domain.c
rename to drivers/pmdomain/arm/scmi_pm_domain.c
-- 
2.42.0

