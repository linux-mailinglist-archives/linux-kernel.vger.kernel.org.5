Return-Path: <linux-kernel+bounces-18032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A6482577F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B91285303
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3634571;
	Fri,  5 Jan 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrNEsD2k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B6321B9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso1908004e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704470471; x=1705075271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNI1Oz48vQp4Hm9jFsOT4f7J+mpAOH6qfd1BBsjKsaA=;
        b=WrNEsD2k5FW4xLsue5ifzfhDU/Mz0SVJB070NPGwigme7y9tnzyTM2omqRxF9Q+o5c
         dgNYNMI/I19XKvH2J2gtisTqsk6LcL+xxuXkoiqKSBYnBOH2YLm/ti/7Y9oEpaXbbjqe
         C1L0sUJqbdsSTS02xgc+QPKHH8WYNC8FaihwAqLIxmZDY/1l3Zjl7DmDBQ97d3E5J7TF
         T5yPPzU8SRJaPXvQztXyNDHUHD/2T6thd9fb/uZQJT+Iu9fprEgoNjIQ0v7VXU7aH3E6
         gZm/pr03AtuxywmKa5nKFD4GLJJ82HsssgXq6CP+8QMIeBwmXCWx68hPMT7KaNpktf3a
         SXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470471; x=1705075271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNI1Oz48vQp4Hm9jFsOT4f7J+mpAOH6qfd1BBsjKsaA=;
        b=hvO/4Rv6cADDEJd613dd2tDnVhilE9qCnSqZGg4uXsetVdA5tROm4ZdwtMmMHO7xjO
         xasF3bQKp8F/zXIBGntV6C4/i/KCcB2ee8ZgjADu1aGrdG2HhN3PcESawMfLty9doUzF
         RGbAS/a9ro2LD66atNkaRxg2O4DhJN8U6DKY0vsRRXxkQeViMoDvEvmzedxCVX1jV+Ir
         suXNjgneoU7JZzpizP+5umKD32GyhzQq1S5Nkd9Ygl7VRkyMS+JrUt85OIYFZoSHauqT
         rFy8P3cf/vScAynysPaKA3c4h3jljlSgMZKKH7GuCW57GCsK17Xc87WqCW6repNjKSRE
         qdqg==
X-Gm-Message-State: AOJu0YyRd20zqVHmg9OVrEl9Llilk+bDESMixjyq8ECPOZTxsv9WG9+3
	99na8dbzn69HJdP37s/g2I6kr50RItLNAQ==
X-Google-Smtp-Source: AGHT+IFyphGz0Q6uyDmpcy3w7sNGqS+rbaFWXqKPDqcO5gErHcQWSgNAzPhrs714QaypH8/gnwBgJg==
X-Received: by 2002:a05:6512:75:b0:50e:7bbc:b678 with SMTP id i21-20020a056512007500b0050e7bbcb678mr619227lfo.17.1704470471425;
        Fri, 05 Jan 2024 08:01:11 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512310500b0050e76978861sm262094lfb.277.2024.01.05.08.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:01:10 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ben Horgan <Ben.Horgan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH v2 1/5] PM: domains: Add helper functions to attach/detach multiple PM domains
Date: Fri,  5 Jan 2024 17:00:59 +0100
Message-Id: <20240105160103.183092-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105160103.183092-1-ulf.hansson@linaro.org>
References: <20240105160103.183092-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching/detaching of a device to multiple PM domains has started to
become a common operation for many drivers, typically during ->probe() and
->remove(). In most cases, this has lead to lots of boilerplate code in the
drivers.

To fixup up the situation, let's introduce a pair of helper functions,
dev_pm_domain_attach|detach_list(), that driver can use instead of the
open-coding. Note that, it seems reasonable to limit the support for these
helpers to DT based platforms, at it's the only valid use case for now.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Fix NULL pointer bug pointed out by Nikunj.

---
 drivers/base/power/common.c | 134 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  38 ++++++++++
 2 files changed, 172 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 44ec20918a4d..327d168dd37a 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -167,6 +167,115 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
 
+/**
+ * dev_pm_domain_attach_list - Associate a device with its PM domains.
+ * @dev: The device used to lookup the PM domains for.
+ * @data: The data used for attaching to the PM domains.
+ * @list: An out-parameter with an allocated list of attached PM domains.
+ *
+ * This function helps to attach a device to its multiple PM domains. The
+ * caller, which is typically a driver's probe function, may provide a list of
+ * names for the PM domains that we should try to attach the device to, but it
+ * may also provide an empty list, in case the attach should be done for all of
+ * the available PM domains.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ *
+ * Returns the number of attached PM domains or a negative error code in case of
+ * a failure. Note that, to detach the list of PM domains, the driver shall call
+ * dev_pm_domain_detach_list(), typically during the remove phase.
+ */
+int dev_pm_domain_attach_list(struct device *dev,
+			      const struct dev_pm_domain_attach_data *data,
+			      struct dev_pm_domain_list **list)
+{
+	struct device_node *np = dev->of_node;
+	struct dev_pm_domain_list *pds;
+	struct device *pd_dev = NULL;
+	int ret, i, num_pds = 0;
+	bool by_id = true;
+	u32 pd_flags = data ? data->pd_flags : 0;
+	u32 link_flags = pd_flags & PD_FLAG_NO_DEV_LINK ? 0 :
+			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
+
+	if (dev->pm_domain)
+		return -EEXIST;
+
+	/* For now this is limited to OF based platforms. */
+	if (!np)
+		return 0;
+
+	if (data && data->pd_names) {
+		num_pds = data->num_pd_names;
+		by_id = false;
+	} else {
+		num_pds = of_count_phandle_with_args(np, "power-domains",
+						     "#power-domain-cells");
+	}
+
+	if (num_pds <= 0)
+		return 0;
+
+	pds = devm_kzalloc(dev, sizeof(*pds), GFP_KERNEL);
+	if (!pds)
+		return -ENOMEM;
+
+	pds->pd_devs = devm_kcalloc(dev, num_pds, sizeof(*pds->pd_devs),
+				    GFP_KERNEL);
+	if (!pds->pd_devs)
+		return -ENOMEM;
+
+	pds->pd_links = devm_kcalloc(dev, num_pds, sizeof(*pds->pd_links),
+				     GFP_KERNEL);
+	if (!pds->pd_links)
+		return -ENOMEM;
+
+	if (link_flags && pd_flags & PD_FLAG_DEV_LINK_ON)
+		link_flags |= DL_FLAG_RPM_ACTIVE;
+
+	for (i = 0; i < num_pds; i++) {
+		if (by_id)
+			pd_dev = dev_pm_domain_attach_by_id(dev, i);
+		else
+			pd_dev = dev_pm_domain_attach_by_name(dev,
+							data->pd_names[i]);
+		if (IS_ERR_OR_NULL(pd_dev)) {
+			ret = pd_dev ? PTR_ERR(pd_dev) : -ENODEV;
+			goto err_attach;
+		}
+
+		if (link_flags) {
+			struct device_link *link;
+
+			link = device_link_add(dev, pd_dev, link_flags);
+			if (!link) {
+				ret = -ENODEV;
+				goto err_link;
+			}
+
+			pds->pd_links[i] = link;
+		}
+
+		pds->pd_devs[i] = pd_dev;
+	}
+
+	pds->num_pds = num_pds;
+	*list = pds;
+	return num_pds;
+
+err_link:
+	dev_pm_domain_detach(pd_dev, true);
+err_attach:
+	while (--i >= 0) {
+		if (pds->pd_links[i])
+			device_link_del(pds->pd_links[i]);
+		dev_pm_domain_detach(pds->pd_devs[i], true);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
+
 /**
  * dev_pm_domain_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
@@ -187,6 +296,31 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
 
+/**
+ * dev_pm_domain_detach_list - Detach a list of PM domains.
+ * @list: The list of PM domains to detach.
+ *
+ * This function reverse the actions from dev_pm_domain_attach_list().
+ * Typically it should be invoked during the remove phase from drivers.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ */
+void dev_pm_domain_detach_list(struct dev_pm_domain_list *list)
+{
+	int i;
+
+	if (!list)
+		return;
+
+	for (i = 0; i < list->num_pds; i++) {
+		if (list->pd_links[i])
+			device_link_del(list->pd_links[i]);
+		dev_pm_domain_detach(list->pd_devs[i], true);
+	}
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_detach_list);
+
 /**
  * dev_pm_domain_start - Start the device through its PM domain.
  * @dev: Device to start.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 34663d0d5c55..6b71fb69c349 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -19,6 +19,33 @@
 #include <linux/cpumask.h>
 #include <linux/time64.h>
 
+/*
+ * Flags to control the behaviour when attaching a device to its PM domains.
+ *
+ * PD_FLAG_NO_DEV_LINK:		As the default behaviour creates a device-link
+ *				for every PM domain that gets attached, this
+ *				flag can be used to skip that.
+ *
+ * PD_FLAG_DEV_LINK_ON:		Add the DL_FLAG_RPM_ACTIVE to power-on the
+ *				supplier and its PM domain when creating the
+ *				device-links.
+ *
+ */
+#define PD_FLAG_NO_DEV_LINK		BIT(0)
+#define PD_FLAG_DEV_LINK_ON		BIT(1)
+
+struct dev_pm_domain_attach_data {
+	const char * const *pd_names;
+	const u32 num_pd_names;
+	const u32 pd_flags;
+};
+
+struct dev_pm_domain_list {
+	struct device **pd_devs;
+	struct device_link **pd_links;
+	u32 num_pds;
+};
+
 /*
  * Flags to control the behaviour of a genpd.
  *
@@ -432,7 +459,11 @@ struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
 					    const char *name);
+int dev_pm_domain_attach_list(struct device *dev,
+			      const struct dev_pm_domain_attach_data *data,
+			      struct dev_pm_domain_list **list);
 void dev_pm_domain_detach(struct device *dev, bool power_off);
+void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
 int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);
@@ -451,7 +482,14 @@ static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
 {
 	return NULL;
 }
+static inline int dev_pm_domain_attach_list(struct device *dev,
+				const struct dev_pm_domain_attach_data *data,
+				struct dev_pm_domain_list **list)
+{
+	return 0;
+}
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
+static inline void dev_pm_domain_detach_list(struct dev_pm_domain_list *list) {}
 static inline int dev_pm_domain_start(struct device *dev)
 {
 	return 0;
-- 
2.34.1


