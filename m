Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA127A6278
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjISMRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjISMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:16:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB00119
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:16:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so241933566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695125773; x=1695730573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ8Nt8LYUz2Xuy84Q3mL3OhNCwDhR0bArvJ9TQ6lw8Q=;
        b=FxbDw2DpvhXQ2FIFNmuhpVr3/o60h52ptQyvXJUKUmZyJvtGJ2hpVzhlXsWlCRsLl/
         QwpWbdS4V2yv8qDWaXxnS2+UdGiZbO/ZO1TlSlvaN8VRC5NOBSBN1TgxcM8ikfY5j5YG
         iGbRrnr02Ow0Z5kth8rQHY5gFMBQNM66b0AzL83TbHm2egNzrJt7C/DFWrfrB0t4dEs0
         2gQtzk4rkIYmoGK7ZmtL5KV/8v4vsQjBUZDLXcIticAKCbi0AJeQbXo1dwJ8F+fzhiou
         +A9hXQaKU0+rWKS515nKOi454TEJ32/O9bEcZdb8XYonzvC1EfpPR2W6f1fDq+xOKV1Y
         B5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125773; x=1695730573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ8Nt8LYUz2Xuy84Q3mL3OhNCwDhR0bArvJ9TQ6lw8Q=;
        b=XRqGTAFxsKqr7ucqmocD2InXLb0od6RkSIoa+qTFw8JnbGMkaEsUJ35BOJSCGm59UU
         N9g+D/HZ8xWdI3cfmIf05k5NMDKCZ5eKUnXReGI5DvdDvwoEYmu6XajlaxtkA5EVPyfQ
         DwjlpPswbaLDLNwvDjN2H3elZX95HOshrJIVA1UWzekHeJoxD+w8LFynxELjURu6v/Df
         T3MTu5ZLoIzlECHXWnR+qvCy+omkW/Ipy3adKvn/qtvns51dCMp1VfuFcLLLp1kiX4gr
         b2SwryVZT7dV3tSPNbd9xkslcWK9biiO4FLgyu391r66bBE/FFozeJY+8ZV2BR9nEJy9
         7T2w==
X-Gm-Message-State: AOJu0YwbCGVNKWHtDTCZeg+PFHT/3woxBYZ7yRf6RcOkSnIsdUP9nn9D
        ULpp5uA32NpO0ERMsUfzsehKHQ==
X-Google-Smtp-Source: AGHT+IF3/7yaArwwOo6EOIsX0xO/v8txgTATSqlBUG+snZCpfFKHtTAYiYqpo3h1f199YzNO5T2P8w==
X-Received: by 2002:a17:907:3e15:b0:9ad:e3fd:d46c with SMTP id hp21-20020a1709073e1500b009ade3fdd46cmr3085405ejc.10.1695125773449;
        Tue, 19 Sep 2023 05:16:13 -0700 (PDT)
Received: from uffe-tuxpro14.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id p25-20020a1709060e9900b00992b50fbbe9sm7781469ejf.90.2023.09.19.05.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:16:13 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/13] pmdomain: arm: Add the SCMI performance domain
Date:   Tue, 19 Sep 2023 14:16:05 +0200
Message-Id: <20230919121605.7304-1-ulf.hansson@linaro.org>
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

To enable support for performance scaling (DVFS) for generic devices with
the SCMI performance protocol, let's add an SCMI performance domain. This
is being modelled as a genpd provider, with support for performance scaling
through genpd's ->set_performance_state() callback.

Note that, this adds the initial support that allows consumer drivers for
attached devices, to vote for a new performance state via calling the
dev_pm_genpd_set_performance_state(). However, this should be avoided as
it's in most cases preferred to use the OPP library to vote for a new OPP
instead. The support using the OPP library isn't part of this change, but
needs to be implemented from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Sudeep, Cristian,

I decided to just send this a single patch, rather than a new version of the
complete series. If you prefer a new version of the series, please let me know.

Kind regards
Uffe

Changes in v4:
	- Rebased on v6.6-rc2 to be able to put the files in the new pmdomain
	subsystem (was genpd in v6.6-rc1).

Changes in v3:
	- Move files to drivers/genpd/arm/ and update MAINTAINERS.
	- Updated the commit msg header.
	- Prevent setting performance level 0.
	- Initialize the genpd as always-on.
	- Note, the corresponding Kconfigs should be placed in the genpd dir
	too, but that's better suited on top or through a later-version.

---
 MAINTAINERS                             |   1 +
 drivers/firmware/arm_scmi/Kconfig       |  12 ++
 drivers/pmdomain/Makefile               |   1 +
 drivers/pmdomain/arm/Makefile           |   3 +
 drivers/pmdomain/arm/scmi_perf_domain.c | 150 ++++++++++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 drivers/pmdomain/arm/Makefile
 create mode 100644 drivers/pmdomain/arm/scmi_perf_domain.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..aa8c58b16416 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20902,6 +20902,7 @@ F:	drivers/clk/clk-sc[mp]i.c
 F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
+F:	drivers/pmdomain/arm/
 F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
 F:	drivers/reset/reset-scmi.c
diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index ea0f5083ac47..706d1264d038 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -181,6 +181,18 @@ config ARM_SCMI_POWER_DOMAIN
 	  will be called scmi_pm_domain. Note this may needed early in boot
 	  before rootfs may be available.
 
+config ARM_SCMI_PERF_DOMAIN
+	tristate "SCMI performance domain driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the SCMI performance domains which can be
+	  enabled or disabled via the SCP firmware.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called scmi_perf_domain.
+
 config ARM_SCMI_POWER_CONTROL
 	tristate "SCMI system power control driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index 666753676e5c..f0326b27b30b 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -2,6 +2,7 @@
 obj-y					+= actions/
 obj-y					+= amlogic/
 obj-y					+= apple/
+obj-y					+= arm/
 obj-y					+= bcm/
 obj-y					+= imx/
 obj-y					+= mediatek/
diff --git a/drivers/pmdomain/arm/Makefile b/drivers/pmdomain/arm/Makefile
new file mode 100644
index 000000000000..7128db96deac
--- /dev/null
+++ b/drivers/pmdomain/arm/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_ARM_SCMI_PERF_DOMAIN) += scmi_perf_domain.o
diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
new file mode 100644
index 000000000000..aa100270500f
--- /dev/null
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI performance domain support.
+ *
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pm_domain.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+struct scmi_perf_domain {
+	struct generic_pm_domain genpd;
+	const struct scmi_perf_proto_ops *perf_ops;
+	const struct scmi_protocol_handle *ph;
+	const struct scmi_perf_domain_info *info;
+	u32 domain_id;
+};
+
+#define to_scmi_pd(pd) container_of(pd, struct scmi_perf_domain, genpd)
+
+static int
+scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
+{
+	struct scmi_perf_domain *pd = to_scmi_pd(genpd);
+	int ret;
+
+	if (!pd->info->set_perf)
+		return 0;
+
+	if (!state)
+		return -EINVAL;
+
+	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, true);
+	if (ret)
+		dev_warn(&genpd->dev, "Failed with %d when trying to set %d perf level",
+			 ret, state);
+
+	return ret;
+}
+
+static int scmi_perf_domain_probe(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	const struct scmi_handle *handle = sdev->handle;
+	const struct scmi_perf_proto_ops *perf_ops;
+	struct scmi_protocol_handle *ph;
+	struct scmi_perf_domain *scmi_pd;
+	struct genpd_onecell_data *scmi_pd_data;
+	struct generic_pm_domain **domains;
+	int num_domains, i, ret = 0;
+
+	if (!handle)
+		return -ENODEV;
+
+	/* The OF node must specify us as a power-domain provider. */
+	if (!of_find_property(dev->of_node, "#power-domain-cells", NULL))
+		return 0;
+
+	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
+	if (IS_ERR(perf_ops))
+		return PTR_ERR(perf_ops);
+
+	num_domains = perf_ops->num_domains_get(ph);
+	if (num_domains < 0) {
+		dev_warn(dev, "Failed with %d when getting num perf domains\n",
+			 num_domains);
+		return num_domains;
+	} else if (!num_domains) {
+		return 0;
+	}
+
+	scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
+	if (!scmi_pd)
+		return -ENOMEM;
+
+	scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
+	if (!scmi_pd_data)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num_domains; i++, scmi_pd++) {
+		scmi_pd->info = perf_ops->info_get(ph, i);
+
+		scmi_pd->domain_id = i;
+		scmi_pd->perf_ops = perf_ops;
+		scmi_pd->ph = ph;
+		scmi_pd->genpd.name = scmi_pd->info->name;
+		scmi_pd->genpd.flags = GENPD_FLAG_ALWAYS_ON |
+				       GENPD_FLAG_OPP_TABLE_FW;
+		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
+
+		ret = pm_genpd_init(&scmi_pd->genpd, NULL, false);
+		if (ret)
+			goto err;
+
+		domains[i] = &scmi_pd->genpd;
+	}
+
+	scmi_pd_data->domains = domains;
+	scmi_pd_data->num_domains = num_domains;
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, scmi_pd_data);
+	if (ret)
+		goto err;
+
+	dev_set_drvdata(dev, scmi_pd_data);
+	dev_info(dev, "Initialized %d performance domains", num_domains);
+	return 0;
+err:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(domains[i]);
+	return ret;
+}
+
+static void scmi_perf_domain_remove(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	struct genpd_onecell_data *scmi_pd_data = dev_get_drvdata(dev);
+	int i;
+
+	of_genpd_del_provider(dev->of_node);
+
+	for (i = 0; i < scmi_pd_data->num_domains; i++)
+		pm_genpd_remove(scmi_pd_data->domains[i]);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PERF, "perf" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_perf_domain_driver = {
+	.name		= "scmi-perf-domain",
+	.probe		= scmi_perf_domain_probe,
+	.remove		= scmi_perf_domain_remove,
+	.id_table	= scmi_id_table,
+};
+module_scmi_driver(scmi_perf_domain_driver);
+
+MODULE_AUTHOR("Ulf Hansson <ulf.hansson@linaro.org>");
+MODULE_DESCRIPTION("ARM SCMI perf domain driver");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

