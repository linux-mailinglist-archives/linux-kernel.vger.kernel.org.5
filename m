Return-Path: <linux-kernel+bounces-18034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A474825789
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EF71C2151B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9EB3529D;
	Fri,  5 Jan 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDmBF7lF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E43529A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso1963304e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704470478; x=1705075278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xTV3KNGUOJDAGwGlyDoyXQPDYV81EgjVZP/tKxx0pk=;
        b=YDmBF7lFZiuX1dCRdWZpabfgxPbsOV6Stw36oosXPP+RmFjCmIpBv8udpLWBlxt+Zn
         Qv73R0O/CWt5IJagtninpik/ErVDKFFg9zRUzO6Ba8ZVbJG5fmrbKMdiDe9eaqzqAAl9
         9cPhlil85lEf8SOlHfz+XWk0lj7Q4wlsbL2ga13bAflBALtbmxcuqlnjJKnLgHm88tl3
         PcRdke8Xc4jZ/LP0qCGPku9ZabkL4qcsq1e8MJleEg6aRh+ydbOF/31i3rxSDqI+rJfO
         TA1fS436KkUCV3zU2P92PnyxygjzqSJYwULhWVFSLe307Az2DpfYUjQk5a9s2/BsAdg6
         SUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470478; x=1705075278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xTV3KNGUOJDAGwGlyDoyXQPDYV81EgjVZP/tKxx0pk=;
        b=QHFPA+uQMxfx2I6V/a12M7t57lvc3fFMc/EBTE3RpD6W/RUe2ghTjrP8rHVh40sjae
         nG9EUDPukPgIZbNxCY4P8WaTIwqIPNe8jm27zsmpfXJji2Yb+z55sIJbKGyP/XCmuTSq
         4clXtJxnmZgKNUowpgqdIGe0ZK0Q9f0TO0kn8ltNnl6xkTEVTLHOI2ZOHHSMhPxvKBQZ
         SD+h1u3+kVv+VOoQn8qkvR/8hGeQ9F6mDjaG6xF+T98ZvnZgmO5PeZ4d3wdGtUK0e7GZ
         G+ZDnacHi3slNwPX59wY8Tlfp6Te/3FMLhLWOHhnPDu4JZmGyz+ovZWcrQ0z9sQlFAvj
         Zn3Q==
X-Gm-Message-State: AOJu0YwcNSnaMqNrAQdfNj869QCN3KK7sDBp4Q5Xg8QPJpYmXUfmXX5u
	8p0xfJ5MaOpBTfpyNYcqq8efFw3OKn713Q==
X-Google-Smtp-Source: AGHT+IEhceusxqe38aK6YSRaF0oSmtJx101dr5UFrhN3EnDzMmqdMwFzHk96/G1pK1okalt2N+42DA==
X-Received: by 2002:a05:6512:532:b0:50e:6e9f:bc89 with SMTP id o18-20020a056512053200b0050e6e9fbc89mr1038688lfc.104.1704470477717;
        Fri, 05 Jan 2024 08:01:17 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512310500b0050e76978861sm262094lfb.277.2024.01.05.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:01:15 -0800 (PST)
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
	linux-media@vger.kernel.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 3/5] remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
Date: Fri,  5 Jan 2024 17:01:01 +0100
Message-Id: <20240105160103.183092-4-ulf.hansson@linaro.org>
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

Let's avoid the boilerplate code to manage the multiple PM domain case, by
converting into using dev_pm_domain_attach|detach_list().

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: <linux-remoteproc@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

Iuliana/Daniel I am ccing you to request help with test/review of this change.
Note that, you will need patch 1/5 in the series too, to be able to test this.

Kind regards
Ulf Hansson

---
 drivers/remoteproc/imx_rproc.c | 73 +++++-----------------------------
 1 file changed, 9 insertions(+), 64 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8bb293b9f327..3161f14442bc 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -92,7 +92,6 @@ struct imx_rproc_mem {
 
 static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
 static void imx_rproc_free_mbox(struct rproc *rproc);
-static int imx_rproc_detach_pd(struct rproc *rproc);
 
 struct imx_rproc {
 	struct device			*dev;
@@ -113,10 +112,8 @@ struct imx_rproc {
 	u32				rproc_pt;	/* partition id */
 	u32				rsrc_id;	/* resource id */
 	u32				entry;		/* cpu start address */
-	int                             num_pd;
 	u32				core_index;
-	struct device                   **pd_dev;
-	struct device_link              **pd_dev_link;
+	struct dev_pm_domain_list	*pd_list;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -853,7 +850,7 @@ static void imx_rproc_put_scu(struct rproc *rproc)
 		return;
 
 	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
-		imx_rproc_detach_pd(rproc);
+		dev_pm_domain_detach_list(priv->pd_list);
 		return;
 	}
 
@@ -880,72 +877,20 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 static int imx_rproc_attach_pd(struct imx_rproc *priv)
 {
 	struct device *dev = priv->dev;
-	int ret, i;
-
-	/*
-	 * If there is only one power-domain entry, the platform driver framework
-	 * will handle it, no need handle it in this driver.
-	 */
-	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
-						  "#power-domain-cells");
-	if (priv->num_pd <= 1)
-		return 0;
-
-	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
-	if (!priv->pd_dev)
-		return -ENOMEM;
-
-	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
-					       GFP_KERNEL);
-
-	if (!priv->pd_dev_link)
-		return -ENOMEM;
-
-	for (i = 0; i < priv->num_pd; i++) {
-		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
-		if (IS_ERR(priv->pd_dev[i])) {
-			ret = PTR_ERR(priv->pd_dev[i]);
-			goto detach_pd;
-		}
-
-		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
-						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
-		if (!priv->pd_dev_link[i]) {
-			dev_pm_domain_detach(priv->pd_dev[i], false);
-			ret = -EINVAL;
-			goto detach_pd;
-		}
-	}
-
-	return 0;
-
-detach_pd:
-	while (--i >= 0) {
-		device_link_del(priv->pd_dev_link[i]);
-		dev_pm_domain_detach(priv->pd_dev[i], false);
-	}
-
-	return ret;
-}
-
-static int imx_rproc_detach_pd(struct rproc *rproc)
-{
-	struct imx_rproc *priv = rproc->priv;
-	int i;
+	int ret;
+	struct dev_pm_domain_attach_data pd_data = {
+		.pd_flags = PD_FLAG_DEV_LINK_ON,
+	};
 
 	/*
 	 * If there is only one power-domain entry, the platform driver framework
 	 * will handle it, no need handle it in this driver.
 	 */
-	if (priv->num_pd <= 1)
+	if (dev->pm_domain)
 		return 0;
 
-	for (i = 0; i < priv->num_pd; i++) {
-		device_link_del(priv->pd_dev_link[i]);
-		dev_pm_domain_detach(priv->pd_dev[i], false);
-	}
-
-	return 0;
+	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
+	return ret < 0 ? ret : 0;
 }
 
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
-- 
2.34.1


