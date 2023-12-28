Return-Path: <linux-kernel+bounces-12620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C3581F7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5808F1F21533
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE479FF;
	Thu, 28 Dec 2023 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0QJOvgV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4C7475
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cca5e7b390so54738211fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703763732; x=1704368532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjZa9tE0ceD0rAWIgU+aMG5K2H2nDz2H19Wt+dz7aVw=;
        b=s0QJOvgVQV1b9mJFcmbwLgjpVQpoMiqaa8JfWyG7jVegXsS89TXVseGhXuzLhGuHVc
         J/SO6InQLRoKk0dlXzxygqks0l/RW6W/Qtjl5aMGHRmpvAVUX+6M93TustGHa4LvqnDO
         RLTMDmkJ5Kl41jawIWjlP7ZhZ3OC9zfFfwX9JAH2xej12D+/LBZ6oYdNKE/nctzs5AgN
         +2RwfNQnKcORsQt+HrdcRseezHHeXp9iqZ/43QsfanCiUL9TQ39mfQyGAjUoTvAZme5B
         1Fr0WTzt0CI/pz//Jf2TmpcWJUk4cWB2Gpz9STHxgVzcJweIFFXAgL7tp6+8cVBzuxU5
         Ye6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703763732; x=1704368532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjZa9tE0ceD0rAWIgU+aMG5K2H2nDz2H19Wt+dz7aVw=;
        b=nyVr6sAjAGIgdhVX9A8JpxmCpmlyTsTOxNl6c4kjSJ4LBrLZcPGV0Vg3X3gAtYOgQX
         qR1V0wq42HdQ+abzNS2A1PD2HbvDNPaJdhSCj0PP8GiNdCNL1GW4YkQs7HsySz4IXTw2
         mt34SnVnfQDhSV+WYXohATFzwIw0jC9SXnTron4VHhfEcA7QfsvMFKJ3S1AHM+QfdGO4
         Uxx3Q8YE15rSuDBcH5VxwNIjcnEFuxKbenOiQLVf1+wIlWQYDgBpI6YFZ9vusF9778oM
         UpuXc7elaCrtxX4WP89FUOXXr0ZEy2DwAzhdojsHnw2AtvB4wmRbRdx4EVlSk/7rMORo
         E0lw==
X-Gm-Message-State: AOJu0YwjFBITXwIBaoNaxpNROZEdmKSqJdRpU575SYoJqmR0wNg/cO2J
	uEUr+FkTaJBYOLAQpyRlg3uiO1wxCWTJaQ==
X-Google-Smtp-Source: AGHT+IEkg0SLbVn0GCOq/nH3aV+xIYolPgrqG8oo5borpKvHGKfCGBOh+OxPwwJXipPwx+k01DvLeA==
X-Received: by 2002:a2e:bba3:0:b0:2cc:d030:1557 with SMTP id y35-20020a2ebba3000000b002ccd0301557mr1596210lje.107.1703763731986;
        Thu, 28 Dec 2023 03:42:11 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a4-20020a05651c210400b002cc32fbe2e5sm2792867ljq.51.2023.12.28.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:42:11 -0800 (PST)
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
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/5] remoteproc: imx_dsp_rproc: Convert to dev_pm_domain_attach|detach_list()
Date: Thu, 28 Dec 2023 12:41:54 +0100
Message-Id: <20231228114157.104822-3-ulf.hansson@linaro.org>
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

Let's avoid the boilerplate code to manage the multiple PM domain case, by
converting into using dev_pm_domain_attach|detach_list().

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: <linux-remoteproc@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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


