Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E237ADC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjIYPrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjIYPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB9B1B6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405524e6768so44432755e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656840; x=1696261640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FNhGMWyAqnTDmM0T1BgOt5wrTJ6u2MeyoOMIg65gD0=;
        b=lqizoEq/FP8ekp2IT6uQ7TZWuakSu6fVuj3Z5IUAoZlMH1SmU6CLRgfSOS4PQ8Ip/u
         ez70MLj70fgl3Rc9aRqmFd+CBmkzqMP2aDYA78Wr0QywX/+cNA+vKtiurihKPEgH64Mm
         bgLk+q2MWwTu6cUbQidCi3S1bSfWvMvboSaGIy5fJpWQGadlRWEhvhYLMUuff6qELhSe
         0qC2O/Bl6WnRBJfqJBYoiEhd9JGAIIkH/dHXiYocez+KkQtTYyk5tISDpFYCGmxDX64F
         Po3B94ny2n1rWDAbp/rGNw5vtcehBD81zQfpnlS8l5WUeXobTJ6rqxGR1WW99eQBE47l
         c/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656840; x=1696261640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FNhGMWyAqnTDmM0T1BgOt5wrTJ6u2MeyoOMIg65gD0=;
        b=Yr0G0h6W4BHVna5wbdenyDtWaLX3iSmaWk4UV41EBjBxJ6XFbIqbyJVuZzpBz2/fyc
         FoSRS/v81cZvTpGjIIxgMWNvX3gKEuT2cdurXresCVheecItyFn9RzmxXAEAkwYz0ZkL
         h2pws39Gy6H0AT1Xf0bwHEm5wXe2/6/4OCohtg+kXaU5Dsmvleik2z1NPbiqxhtuhQ5b
         fCzVG9OF57UjZq56JPI9bLLkgbTQBcgNfZhoTPqeJgUqMEFxEsvRtsDKW/4Akbvxepw+
         SpSlpakRJDkChQW+z1ntZ/4nC5VJITFQ89aispFeJgxsw7Xy6ED0BNbxUE+jyG+kwmO7
         OnCw==
X-Gm-Message-State: AOJu0YwfSepd06hF1lwX4vQDLdCd+3caWKwg+RneNRxARYd2km8wWBD6
        5oWlRndteNz4mdfggKhyyaoQ6g==
X-Google-Smtp-Source: AGHT+IHPewfmUTn3VJZZkJ1LALUg4OCR6Ppp1kOmtKKZJ1+1wkDuA12DIwYUZw2q4FtqMfpboyjMMg==
X-Received: by 2002:a05:600c:b42:b0:3f6:58ad:ed85 with SMTP id k2-20020a05600c0b4200b003f658aded85mr5876872wmr.10.1695656840766;
        Mon, 25 Sep 2023 08:47:20 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:20 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 09/17] media: qcom: camss: Remove special case for VFE get/put
Date:   Mon, 25 Sep 2023 16:46:59 +0100
Message-ID: <20230925154707.837542-10-bryan.odonoghue@linaro.org>
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

From sdm845 onwards we need to ensure the VFE is powered on prior to
switching on the CSID.

Currently the code tests for sdm845, sm8250 and then does get/set. This is
not extensible and it turns out is not necessary either since vfe_get and
vfe_set reference count.

Remove the over-conservative SoC version check.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # rb3 # db410c
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 99f651e2021cb..95873f988f7e2 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -159,15 +159,17 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 	struct camss *camss = csid->camss;
 	struct device *dev = camss->dev;
 	struct vfe_device *vfe = &camss->vfe[csid->id];
-	u32 version = camss->res->version;
 	int ret = 0;
 
 	if (on) {
-		if (version == CAMSS_8250 || version == CAMSS_845) {
-			ret = vfe_get(vfe);
-			if (ret < 0)
-				return ret;
-		}
+		/*
+		 * From SDM845 onwards, the VFE needs to be powered on before
+		 * switching on the CSID. Do so unconditionally, as there is no
+		 * drawback in following the same powering order on older SoCs.
+		 */
+		ret = vfe_get(vfe);
+		if (ret < 0)
+			return ret;
 
 		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0)
@@ -217,8 +219,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 		regulator_bulk_disable(csid->num_supplies,
 				       csid->supplies);
 		pm_runtime_put_sync(dev);
-		if (version == CAMSS_8250 || version == CAMSS_845)
-			vfe_put(vfe);
+		vfe_put(vfe);
 	}
 
 	return ret;
-- 
2.42.0

