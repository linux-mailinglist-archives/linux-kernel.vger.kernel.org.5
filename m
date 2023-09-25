Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2047ADC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjIYPrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIYPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB85BC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3231d67aff2so3150672f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656831; x=1696261631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEExl+Qnlpbjs/kQF5vqHTfDAzymWTPDJmQL5fGoUhU=;
        b=OzH9sbAjwvrspYURlHGUKNZaWXaiCuT5Ii4eTET7chaJpi+kMMH0zdqZ9VS8fOA3pX
         4nVJ/Hd6DcXIAMeyhalf58ng3Uxxn5O+1KabMIyjP7lE7jvIamKLHTlN9FyBWg6a5CFM
         L1whhC1vY/khfYIdjH61pSQZmMdWHnCBA7spCi6W7pB58gOZql93NRoUxJ7JTVtpbqCh
         VBM2uggVN6oqb2LSVNm875G6axQO4k6zi5u0NV6n+CMBewUVzevulJw/c1THZmQr7rGg
         lL8W5EnugbdCjKLetBQUvPUMPJy/QbAYr3F04Zlv6RsW5XpDXWSz8nbjD3ASoBwcx7ME
         mgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656831; x=1696261631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEExl+Qnlpbjs/kQF5vqHTfDAzymWTPDJmQL5fGoUhU=;
        b=AbyaVtCMyQrMZdQOK4gawdnZCBghgYpYcirwR4iGfG2YdWHjiQLTo0wDtbh80UX3hF
         G25o8NKiyxa8qPmJXN/9uBYUWUHkF1oR3ODHIWpta7AZjWOWDkvHnOmzgb6R6ny+WzAm
         yWf98EwZx8FC2iZ5RdDm2tqlGEHgboUoRf0YRvmV0AzVL3xX1oX1DtSg+JZTs3IxQmiV
         9MkkvXB0JhyQAXlsXqLHtm/WPZAu9CNRLEmtMM1QJRTglfLv5jj+E2Smnm4cgP++/jhX
         KzqydcP77zRA3TG6EjfNFdbExkIygf+pxWReR8BvRPo8/J4mepfIeXU7jUOoCTkYFW8G
         sLIw==
X-Gm-Message-State: AOJu0YwrUkNQ7OfeVip5X7RLAlDP+R9g/AXtnBOUzZuODgBI8AOAh4K1
        APZaAeDzwaamPd6+ckwkMPcu0A==
X-Google-Smtp-Source: AGHT+IGQwR420EBz8gUib4vwFl7WdH5Kgm0Bu9eFHN1pPqVWcW6Sa7QkFWlMN7YlPd5yOLAq4/4JFA==
X-Received: by 2002:adf:fb51:0:b0:31f:e980:cd88 with SMTP id c17-20020adffb51000000b0031fe980cd88mr5610836wrs.61.1695656831560;
        Mon, 25 Sep 2023 08:47:11 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:11 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 01/17] media: qcom: camss: Amalgamate struct resource with struct resource_ispif
Date:   Mon, 25 Sep 2023 16:46:51 +0100
Message-ID: <20230925154707.837542-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason to differentiate the two resource structures
here. As part of a general tidyup of the declaration and passing of
resources within in the CAMSS driver it will be advantageous to have
one unified resource structure.

The two structures are very similar anyway thus leading more credence
still to the argument there should be only one.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/qcom/camss/camss-ispif.c |  4 ++--
 drivers/media/platform/qcom/camss/camss-ispif.h |  4 ++--
 drivers/media/platform/qcom/camss/camss.c       | 14 +++++++-------
 drivers/media/platform/qcom/camss/camss.h       |  8 +-------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 1c7e4b1b49401..61765b874b9a2 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -1095,7 +1095,7 @@ static int ispif_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
  * Return 0 on success or a negative error code otherwise
  */
 int msm_ispif_subdev_init(struct camss *camss,
-			  const struct resources_ispif *res)
+			  const struct resources *res)
 {
 	struct device *dev = camss->dev;
 	struct ispif_device *ispif = camss->ispif;
@@ -1152,7 +1152,7 @@ int msm_ispif_subdev_init(struct camss *camss,
 
 	/* Interrupt */
 
-	ret = platform_get_irq_byname(pdev, res->interrupt);
+	ret = platform_get_irq_byname(pdev, res->interrupt[0]);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.h b/drivers/media/platform/qcom/camss/camss-ispif.h
index fdf28e68cc7d8..c7c41f7afcaad 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.h
+++ b/drivers/media/platform/qcom/camss/camss-ispif.h
@@ -66,10 +66,10 @@ struct ispif_device {
 	struct camss *camss;
 };
 
-struct resources_ispif;
+struct resources;
 
 int msm_ispif_subdev_init(struct camss *camss,
-			  const struct resources_ispif *res);
+			  const struct resources *res);
 
 int msm_ispif_register_entities(struct ispif_device *ispif,
 				struct v4l2_device *v4l2_dev);
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index c6df862c79e39..fa0eb30d77c26 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -93,14 +93,14 @@ static const struct resources csid_res_8x16[] = {
 	},
 };
 
-static const struct resources_ispif ispif_res_8x16 = {
+static const struct resources ispif_res_8x16 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
 		   "csi1", "csi1_pix", "csi1_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = "ispif"
+	.interrupt = { "ispif" }
 
 };
 
@@ -234,7 +234,7 @@ static const struct resources csid_res_8x96[] = {
 	}
 };
 
-static const struct resources_ispif ispif_res_8x96 = {
+static const struct resources ispif_res_8x96 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
@@ -243,7 +243,7 @@ static const struct resources_ispif ispif_res_8x96 = {
 		   "csi3", "csi3_pix", "csi3_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0", "vfe1", "csi_vfe1" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = "ispif"
+	.interrupt = { "ispif" }
 };
 
 static const struct resources vfe_res_8x96[] = {
@@ -410,7 +410,7 @@ static const struct resources csid_res_660[] = {
 	}
 };
 
-static const struct resources_ispif ispif_res_660 = {
+static const struct resources ispif_res_660 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
@@ -419,7 +419,7 @@ static const struct resources_ispif ispif_res_660 = {
 		   "csi3", "csi3_pix", "csi3_rdi" },
 	.clock_for_reset = { "vfe0", "csi_vfe0", "vfe1", "csi_vfe1" },
 	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = "ispif"
+	.interrupt = { "ispif" }
 };
 
 static const struct resources vfe_res_660[] = {
@@ -1122,7 +1122,7 @@ static int camss_init_subdevices(struct camss *camss)
 {
 	const struct resources *csiphy_res;
 	const struct resources *csid_res;
-	const struct resources_ispif *ispif_res;
+	const struct resources *ispif_res;
 	const struct resources *vfe_res;
 	unsigned int i;
 	int ret;
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index f6c326cb853b8..e95211cdb1fd6 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -44,18 +44,12 @@
 struct resources {
 	char *regulators[CAMSS_RES_MAX];
 	char *clock[CAMSS_RES_MAX];
+	char *clock_for_reset[CAMSS_RES_MAX];
 	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
 	char *reg[CAMSS_RES_MAX];
 	char *interrupt[CAMSS_RES_MAX];
 };
 
-struct resources_ispif {
-	char *clock[CAMSS_RES_MAX];
-	char *clock_for_reset[CAMSS_RES_MAX];
-	char *reg[CAMSS_RES_MAX];
-	char *interrupt;
-};
-
 struct icc_bw_tbl {
 	u32 avg;
 	u32 peak;
-- 
2.42.0

