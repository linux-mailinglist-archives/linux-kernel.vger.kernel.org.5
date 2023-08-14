Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1376377BCBC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjHNPN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjHNPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5CDE6E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso43992185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025971; x=1692630771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocJS1nXGrg9KUDSz6ydfTmzG4q/9Tzxynl3mXG6FazY=;
        b=VhoDoCLhtMXQbjvsXylJsc8VzXIflgqWEyOBYhB3z14NdZsOEdtFdl0gju0b/pMwtK
         JIlGy5gVKsOnHp0ZYGYyBL6XKejmeobJ3SZynFOMuAXIo6H79mO2NBARyhYKwKmTVj7H
         LD1UZDmUxfSWFb2K07PytjgKIAMhz1CaDfK/J75nh2zYwD6CmJm4rNowyU6vmlknuS7r
         e3/zGHrceyuhKY9UP3DukNu81xGbluhDbIegNJxgldlnRnY4ub9HRzn6aXwRFH2i5GBM
         E53ApoAHP1p7dJWUXkFdlgqGZuphT8qd8PKbf+xABvOhH0plotYAmNa+p5Iqx4RsaAvc
         I0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025971; x=1692630771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocJS1nXGrg9KUDSz6ydfTmzG4q/9Tzxynl3mXG6FazY=;
        b=bpIotNmJpMb7Kql1OeaNd/3r3OiXzL5YAlWhRD5BmnKBuEVtp7INt+owg5SeDnewdm
         wWuScT97QR2UmxfjGNM4cAt79VZ3cUuC3k47QHOEKrXODtzv3HeomfHWeIvL4Wqtc82S
         4NILRUteP4XxFUyVJQZkffq8ghhbAnGcpOOykJRGtKZzSVNxpFRS1ke9bsD54xNWDq1u
         JL8owo3AqIrDQ0BiAk6qC+IyE51S51RyEvvTwmnN+yiEZg+BxkWSBzgZ05tH50WhcBrq
         cf+WKY+B5cNAGBdHHr9rkKSe+9mv4f/2HqDp0DwHAcgQNKX4Tmw1IiQNPdy0w21XHXqv
         gGUA==
X-Gm-Message-State: AOJu0Ywe5WHhmG/ENqTDuos3//moYYfLLPx00qF3qHSN6e+NGONp+dpI
        lcTQAgndw9OnDxi2LuHicSpOww==
X-Google-Smtp-Source: AGHT+IHp0adq2Own21y+ewG89R+AmYf6CoxJPbeODa60h8OfL8WzJ18WT6WiFvnee4adaPrJUO3zbw==
X-Received: by 2002:a7b:cc8d:0:b0:3f4:d18f:b2fb with SMTP id p13-20020a7bcc8d000000b003f4d18fb2fbmr7922350wma.8.1692025971785;
        Mon, 14 Aug 2023 08:12:51 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:51 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 04/13] media: qcom: camss: Pass icc bandwidth table as a platform parameter
Date:   Mon, 14 Aug 2023 16:12:34 +0100
Message-ID: <20230814151243.3801456-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
References: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the bandwidth table as a platform parameter not if/else derived
pointer to the static table.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 29 +++++++----------------
 drivers/media/platform/qcom/camss/camss.h |  3 ++-
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 68eb45b2c0aaa..1a195eb4298a5 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1484,21 +1484,15 @@ static int camss_configure_pd(struct camss *camss)
 static int camss_icc_get(struct camss *camss)
 {
 	const struct resources_icc *icc_res;
-	int nbr_icc_paths = 0;
 	int i;
 
-	if (camss->version == CAMSS_8250) {
-		icc_res = &icc_res_sm8250[0];
-		nbr_icc_paths =	ICC_SM8250_COUNT;
-	}
+	icc_res = camss->res->icc_res;
 
-	for (i = 0; i < nbr_icc_paths; i++) {
+	for (i = 0; i < camss->res->icc_path_num; i++) {
 		camss->icc_path[i] = devm_of_icc_get(camss->dev,
 						     icc_res[i].name);
 		if (IS_ERR(camss->icc_path[i]))
 			return PTR_ERR(camss->icc_path[i]);
-
-		camss->icc_bw_tbl[i] = icc_res[i].icc_bw_tbl;
 	}
 
 	return 0;
@@ -1736,6 +1730,8 @@ static const struct camss_resources sm8250_resources = {
 	.csiphy_res = csiphy_res_8250,
 	.csid_res = csid_res_8250,
 	.vfe_res = vfe_res_8250,
+	.icc_res = icc_res_sm8250,
+	.icc_path_num = ARRAY_SIZE(icc_res_sm8250),
 };
 
 static const struct of_device_id camss_dt_match[] = {
@@ -1752,14 +1748,10 @@ MODULE_DEVICE_TABLE(of, camss_dt_match);
 static int __maybe_unused camss_runtime_suspend(struct device *dev)
 {
 	struct camss *camss = dev_get_drvdata(dev);
-	int nbr_icc_paths = 0;
 	int i;
 	int ret;
 
-	if (camss->version == CAMSS_8250)
-		nbr_icc_paths =	ICC_SM8250_COUNT;
-
-	for (i = 0; i < nbr_icc_paths; i++) {
+	for (i = 0; i < camss->res->icc_path_num; i++) {
 		ret = icc_set_bw(camss->icc_path[i], 0, 0);
 		if (ret)
 			return ret;
@@ -1771,17 +1763,14 @@ static int __maybe_unused camss_runtime_suspend(struct device *dev)
 static int __maybe_unused camss_runtime_resume(struct device *dev)
 {
 	struct camss *camss = dev_get_drvdata(dev);
-	int nbr_icc_paths = 0;
+	const struct resources_icc *icc_res = camss->res->icc_res;
 	int i;
 	int ret;
 
-	if (camss->version == CAMSS_8250)
-		nbr_icc_paths =	ICC_SM8250_COUNT;
-
-	for (i = 0; i < nbr_icc_paths; i++) {
+	for (i = 0; i < camss->res->icc_path_num; i++) {
 		ret = icc_set_bw(camss->icc_path[i],
-				 camss->icc_bw_tbl[i].avg,
-				 camss->icc_bw_tbl[i].peak);
+				 icc_res[i].icc_bw_tbl.avg,
+				 icc_res[i].icc_bw_tbl.peak);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index f632ee49ad83e..988c313b63551 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -84,6 +84,8 @@ struct camss_resources {
 	const struct resources *csid_res;
 	const struct resources *ispif_res;
 	const struct resources *vfe_res;
+	const struct resources_icc *icc_res;
+	const int icc_path_num;
 };
 
 struct camss {
@@ -105,7 +107,6 @@ struct camss {
 	struct device **genpd;
 	struct device_link **genpd_link;
 	struct icc_path *icc_path[ICC_SM8250_COUNT];
-	struct icc_bw_tbl icc_bw_tbl[ICC_SM8250_COUNT];
 	const struct camss_resources *res;
 };
 
-- 
2.41.0

