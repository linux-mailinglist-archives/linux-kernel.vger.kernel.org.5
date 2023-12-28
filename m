Return-Path: <linux-kernel+bounces-12619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97881F7D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1181F2151F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64279F9;
	Thu, 28 Dec 2023 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfwR0NlB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E57461
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccbf0169b5so29376581fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703763730; x=1704368530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HBesEgOBXKvZsxXjnZmaNVyGea3TH6zurKF4tZTceY=;
        b=rfwR0NlBJSZd5XBM/5kjWb/cH787JxviuhIG6I/G0Msh1UYxdg/KcL60eniQgVr1kl
         UIcwU73ObkB43KVSD0i2PX0KABVx9wtfCFcMLlPjNM1Xl7zENRepiPMX06o1+o8wsgDO
         o3SjETfPDCDqS561CI193gEqtL3fnKUNwgvryz1hD2P4yDV4qDzxS1IRvjCUe6MyCtTf
         qQH9OYISQrnA5bbZYLOvMsN/UH5v18MEwJy+uwvkqt3gXJSLhLPYKe6InkSlR3datokh
         bJ78R9XXx8gbw1+Xs7BpC2lp9oL9MICn5DTOyFW0uzMU0xBpaw0RrgvPug+D8sWSk6yg
         j/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703763730; x=1704368530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HBesEgOBXKvZsxXjnZmaNVyGea3TH6zurKF4tZTceY=;
        b=Q/gKblYz+ejuGq19/ld8wsUYVXOC3SGtwjGPGou42dFcwfc3j9o4e6s1EfFInHbsNa
         Ria6yX9tDxZmnwoXY71XkLrAINmnmqKjF7jhGC8632r+YZ2PU5lnDfVt0SxYj95xjcuh
         APYLpww4CpNfA3+Xo5p+8SXPIUlsNY/PZz+y4mwrdjVIrWD2BwMoKcJtqWnA1xafeM8L
         v19zPTaKYuzGLBY7wKaEdGF9T7cBp+I+r5zDI95KDFUEHyOPyvkmKhLlhuh6BinOksmL
         5Cj4x8CEueOAZNLHexCHnDgKKyxqhri9lewULj3I9B6Ky0NOC+FieVo5cuFmYqxMdmBj
         Wtdg==
X-Gm-Message-State: AOJu0YyrpOYeWyjXgX/Bo4yfymSXxlMn0lbisaaabvY3IZkkJloaJEvu
	2IBW7dccWNgpK3jNBFOhb+KebqtcWyVeEA==
X-Google-Smtp-Source: AGHT+IEwHgt8xJ6xxH2L04jF2DTHGxQNSRNZOWWqNHYggSEmfhdvXRy9wAWIoNmO0S8QJACWi0F9xg==
X-Received: by 2002:a2e:97d6:0:b0:2cc:a569:161f with SMTP id m22-20020a2e97d6000000b002cca569161fmr3116722ljj.86.1703763730662;
        Thu, 28 Dec 2023 03:42:10 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a4-20020a05651c210400b002cc32fbe2e5sm2792867ljq.51.2023.12.28.03.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:42:10 -0800 (PST)
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
Subject: [PATCH 1/5] PM: domains: Add helper functions to attach/detach multiple PM domains
Date: Thu, 28 Dec 2023 12:41:53 +0100
Message-Id: <20231228114157.104822-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228114157.104822-1-ulf.hansson@linaro.org>
References: <20231228114157.104822-1-ulf.hansson@linaro.org>
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
 drivers/base/power/common.c | 133 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  38 +++++++++++
 2 files changed, 171 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 44ec20918a4d..1ef51889fc6f 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -167,6 +167,114 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
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
+	u32 link_flags = data && data->pd_flags & PD_FLAG_NO_DEV_LINK ? 0 :
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
+	if (link_flags && data->pd_flags & PD_FLAG_DEV_LINK_ON)
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
@@ -187,6 +295,31 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
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


