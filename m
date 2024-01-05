Return-Path: <linux-kernel+bounces-18033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F2825783
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1136A1C209E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC734CD5;
	Fri,  5 Jan 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDJCNLOm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99534CD6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50ea226bda8so1843649e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704470475; x=1705075275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4adrkCiXynUojze/iFBMYeb+HEd5tnQA25jx/jo/fM=;
        b=pDJCNLOmnVHYDXvHROz/V9ko6aJEgCq6Mk/RM1GQoR55XbYiZkLMj7OWP4YvzxwPQl
         x+1HIf1GTrMPAF6IVk/ua5iuEG0gF2pmX3KaNDo6cBtxtb7dlj/XMPSpeNirAV9Dl/Gy
         mY1/V1Lp6HEZOzt8HKNg4equRumpkRP29YlmjBLbqgVPlopSuIGuGrM4rD9HkGrY2R6O
         xpV3ilduH1rAGWwqoh/wfZt5WEv6J9xgMlpaorFufT+uZfs2VihTbLeHv4SsnNXVphqt
         I7qroly+i/uonLq8ADXHOhCH/GeSwECmT9m8ES4G8jx2jlVYwhsSHaAyFZDoAAGjIlVg
         MRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470475; x=1705075275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4adrkCiXynUojze/iFBMYeb+HEd5tnQA25jx/jo/fM=;
        b=GS2vbCVKrogqBTht57DtNsxKwpE9XjMYwLD1iWh71rvEJsy0btN1I4+sa6yysamMiW
         z/3Hm32KoHg8di821BTinROpADgXdOXmdEPOyPUesamyUcnYTSPIcaBJNcWgI7mp7sru
         7w4iyQmdnzvqMu5jNyCV1BlFFm7Ss3oU110MaLNjfFrozeaRl1QJGXAUZ5APZ6Sy7yFu
         EooxPdiooFHnwuI+6bRduZY+tUBONinx9zO2LPdEp5AbTickG7OcKzf9xDoc4LIUbrKy
         GrZyZ7Uk0SI3rI0Ejp3QJ2ZDyuS4lp13oPW5vkwYzOUelBAAOTClNraoW1P6DZTzwMQK
         SX+A==
X-Gm-Message-State: AOJu0YxMNefs26H9h6bBjz8+lloR5ny4U0Zd2vNnJ0VnYHAwiuhb+24r
	P6uSbNZ0egrRHJn4Xcr03pPJqmQJFSl4ZA==
X-Google-Smtp-Source: AGHT+IGoYR9dNkx0TbEbTrZoz2zQHdVbLCqUuOHGn2IdJYr+CWUdepckfD72bhLcMFYSTGkVG//8iA==
X-Received: by 2002:a19:6447:0:b0:50e:3d5b:cfef with SMTP id b7-20020a196447000000b0050e3d5bcfefmr869108lfj.53.1704470474915;
        Fri, 05 Jan 2024 08:01:14 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512310500b0050e76978861sm262094lfb.277.2024.01.05.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:01:12 -0800 (PST)
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
Subject: [PATCH v2 2/5] remoteproc: imx_dsp_rproc: Convert to dev_pm_domain_attach|detach_list()
Date: Fri,  5 Jan 2024 17:01:00 +0100
Message-Id: <20240105160103.183092-3-ulf.hansson@linaro.org>
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
 drivers/remoteproc/imx_dsp_rproc.c | 82 ++++--------------------------
 1 file changed, 9 insertions(+), 73 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 8fcda9b74545..0409b7c47d5c 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -103,12 +103,10 @@ enum imx_dsp_rp_mbox_messages {
  * @tx_ch: mailbox tx channel handle
  * @rx_ch: mailbox rx channel handle
  * @rxdb_ch: mailbox rx doorbell channel handle
- * @pd_dev: power domain device
- * @pd_dev_link: power domain device link
+ * @pd_list: power domain list
  * @ipc_handle: System Control Unit ipc handle
  * @rproc_work: work for processing virtio interrupts
  * @pm_comp: completion primitive to sync for suspend response
- * @num_domains: power domain number
  * @flags: control flags
  */
 struct imx_dsp_rproc {
@@ -121,12 +119,10 @@ struct imx_dsp_rproc {
 	struct mbox_chan			*tx_ch;
 	struct mbox_chan			*rx_ch;
 	struct mbox_chan			*rxdb_ch;
-	struct device				**pd_dev;
-	struct device_link			**pd_dev_link;
+	struct dev_pm_domain_list		*pd_list;
 	struct imx_sc_ipc			*ipc_handle;
 	struct work_struct			rproc_work;
 	struct completion			pm_comp;
-	int					num_domains;
 	u32					flags;
 };
 
@@ -954,74 +950,14 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 static int imx_dsp_attach_pm_domains(struct imx_dsp_rproc *priv)
 {
 	struct device *dev = priv->rproc->dev.parent;
-	int ret, i;
-
-	priv->num_domains = of_count_phandle_with_args(dev->of_node,
-						       "power-domains",
-						       "#power-domain-cells");
-
-	/* If only one domain, then no need to link the device */
-	if (priv->num_domains <= 1)
-		return 0;
-
-	priv->pd_dev = devm_kmalloc_array(dev, priv->num_domains,
-					  sizeof(*priv->pd_dev),
-					  GFP_KERNEL);
-	if (!priv->pd_dev)
-		return -ENOMEM;
-
-	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_domains,
-					       sizeof(*priv->pd_dev_link),
-					       GFP_KERNEL);
-	if (!priv->pd_dev_link)
-		return -ENOMEM;
-
-	for (i = 0; i < priv->num_domains; i++) {
-		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
-		if (IS_ERR(priv->pd_dev[i])) {
-			ret = PTR_ERR(priv->pd_dev[i]);
-			goto detach_pm;
-		}
-
-		/*
-		 * device_link_add will check priv->pd_dev[i], if it is
-		 * NULL, then will break.
-		 */
-		priv->pd_dev_link[i] = device_link_add(dev,
-						       priv->pd_dev[i],
-						       DL_FLAG_STATELESS |
-						       DL_FLAG_PM_RUNTIME);
-		if (!priv->pd_dev_link[i]) {
-			dev_pm_domain_detach(priv->pd_dev[i], false);
-			ret = -EINVAL;
-			goto detach_pm;
-		}
-	}
-
-	return 0;
-
-detach_pm:
-	while (--i >= 0) {
-		device_link_del(priv->pd_dev_link[i]);
-		dev_pm_domain_detach(priv->pd_dev[i], false);
-	}
-
-	return ret;
-}
-
-static int imx_dsp_detach_pm_domains(struct imx_dsp_rproc *priv)
-{
-	int i;
+	int ret;
 
-	if (priv->num_domains <= 1)
+	/* A single PM domain is already attached. */
+	if (dev->pm_domain)
 		return 0;
 
-	for (i = 0; i < priv->num_domains; i++) {
-		device_link_del(priv->pd_dev_link[i]);
-		dev_pm_domain_detach(priv->pd_dev[i], false);
-	}
-
-	return 0;
+	ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
+	return ret < 0 ? ret : 0;
 }
 
 /**
@@ -1153,7 +1089,7 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 err_detach_domains:
-	imx_dsp_detach_pm_domains(priv);
+	dev_pm_domain_detach_list(priv->pd_list);
 err_put_rproc:
 	rproc_free(rproc);
 
@@ -1167,7 +1103,7 @@ static void imx_dsp_rproc_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	rproc_del(rproc);
-	imx_dsp_detach_pm_domains(priv);
+	dev_pm_domain_detach_list(priv->pd_list);
 	rproc_free(rproc);
 }
 
-- 
2.34.1


