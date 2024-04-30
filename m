Return-Path: <linux-kernel+bounces-163635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77B8B6E03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EB21F23422
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CA1292F8;
	Tue, 30 Apr 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="weDoUmBs"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A312836D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468632; cv=none; b=bjjqjRtpjbf1f9yKiKvrbTD3drE9NkryWkzPKfKpWz+WNgP2QsvlMfTZT44tOTApNwklXUT/8eyOfABT23IwA8pRUgu0DUSP0fFZbTaIHoeTOfg9kn9yUpo9p6xCgFoAecJJOTIBaqhn/HzGKYVCj3wWaETxgYE4LFsoXfydRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468632; c=relaxed/simple;
	bh=wPFKKVDsrPqDd+T/V+mKITht1vWLOHyocwhrp50aPA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDjT7aSmNNQ63W7aYk+3Grs8aKYm+IbpbxweajpxZRGxu+euvOD1NC93GJBCN1yLGNRb1WkoWOBDgNLalihNZ7LgVeMmKyXBfyJUZbbILPRTGyiWXLTn6x2WPexJB7SZjczb7iv2yYR9S+EBIFcmsasbpeUm5Yz9UgUwW6oiqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=weDoUmBs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso27226105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714468629; x=1715073429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGFQI3/jkSXT/B0m8X2PcSHRlLdy4394SU1GEz5Fywc=;
        b=weDoUmBsBWdU/FHkZFpM5YoiW8NE2yZ9bIbrADkG79ib+rH3RJOcZz/OdTNoD6UMwo
         14E1Eef4xrbvDMsqictzDUu4clP/HpKg4FzcmafD1+0g9pTft6QlGVxd7skvRHFnQrkc
         58kEwWuJTLws1ZEfSSH7imeo2Suv5X9uTCA5q/q4iloHLKV0S+Opr2/ZVDNbiyDYIxqK
         l7dSWM7sluLPKhDfmqnVCu5lV1pu8cKgyGqwzj9yGql5vsFBkSnoZi7swN48jPqm2Y8z
         VopVwu/tzKpnIuM/H5mCq4XoVo2j+GXQtjnW40uMZjM9LVZoUqkt4DhHgDudIix1vT7a
         CCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468629; x=1715073429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGFQI3/jkSXT/B0m8X2PcSHRlLdy4394SU1GEz5Fywc=;
        b=dxvxwgMTUbUfV1FkPTzniAxQhbLTQV8/2Kbqg2zevdMV+FM0iv4w9G2kfYw6V2pQ8b
         botbsPewWmp62JPnknP/HjKhfLAjEZBQsy8GBUGvk1skLT7xvKE86uVX2vdAvdKP/3lE
         alZ5YG7K6xISKQUwdS/PNBRQwEJYRx+VUxAb8LANzwpJY4NPsHnBXcfWpjiUoag/r9qy
         u2XHJbeTesEA6EjbCvsIAzRx9G4l7sembipzMMbGjOv6V2VI/SI/o9CAhqX4jc0bUWz8
         9QBKYiNdDN7obOvGbRcRtsCcpRSvFyqC9Cr2AW26piUnFDUMCI+o6NSJQHeEecoDOJW3
         sDWw==
X-Gm-Message-State: AOJu0YydzpJZkT/snwYwADYRAEWVnjE4ymdO+liTWhwRNRkRXRcJ+E3b
	zc8gBYhsCmBL4brqZ1ZsM/KcjFwHJvbLGgziSiIDVmHuHyjyaZpfYPjqFeKS+/w=
X-Google-Smtp-Source: AGHT+IFlkac9vD+lwDTdAzfmiF+SPGtbUtAvb844gQwtiIu85XBlwOqie/1vX151fRr164e+2v8i9Q==
X-Received: by 2002:a05:600c:3c8a:b0:41b:6b65:4b7e with SMTP id bg10-20020a05600c3c8a00b0041b6b654b7emr11073768wmb.16.1714468629330;
        Tue, 30 Apr 2024 02:17:09 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0034d8b0b5329sm935513wrp.87.2024.04.30.02.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:17:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 2/3] slimbus: Convert to platform remove callback returning void
Date: Tue, 30 Apr 2024 10:16:56 +0100
Message-Id: <20240430091657.35428-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430091657.35428-1-srinivas.kandagatla@linaro.org>
References: <20240430091657.35428-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3655; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=NtRyxovsgrVmHg1Qgua7ounfumaZm+SHHi4WhEOBppw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLcFWekchStwa9kuUmpz6if9Ogt09P2t1/6Fh pN/EvtmjVqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjC3BQAKCRB6of1ZxzRV N3weB/9NbafmUyA/sjRoMgAjRYjmWCaFXo/l1cMlMwG42NVwpAHmhF1Lu8YfHX8bQszrsKtXhce 0T7NkwvwkePN6jHFLpAp86Z7kh7R5AHYsCuqrcgaZHevICrlD6JW/UOMAOwiIIAs8xD7rOor8LQ NGB38h7KhstMaLurhSImqom4++i2K9kpp9Wi+iUAWJqu0WM8MB7piaABz3+5WaHxRRzz2Xo02Te 2y/lmjlULZj/qyKZfYx3slwHvpRGuDm+fYFupJ8oFT3QztU/k/5+5ICbtUqcLicx+w+mx9zjKLs DhaW9TpugJuXnAWo2sN6LtKrIue8Ld7GPdaiGg1kqCou19Kn
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert the slimbus drivers from always returning zero in the
remove callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c     |  5 ++---
 drivers/slimbus/qcom-ngd-ctrl.c | 11 ++++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 400b7b385a44..7d632fad1300 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -626,7 +626,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_slim_remove(struct platform_device *pdev)
+static void qcom_slim_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
 
@@ -635,7 +635,6 @@ static int qcom_slim_remove(struct platform_device *pdev)
 	clk_disable_unprepare(ctrl->rclk);
 	clk_disable_unprepare(ctrl->hclk);
 	destroy_workqueue(ctrl->rxwq);
-	return 0;
 }
 
 /*
@@ -721,7 +720,7 @@ static const struct of_device_id qcom_slim_dt_match[] = {
 
 static struct platform_driver qcom_slim_driver = {
 	.probe = qcom_slim_probe,
-	.remove = qcom_slim_remove,
+	.remove_new = qcom_slim_remove,
 	.driver	= {
 		.name = "qcom_slim_ctrl",
 		.of_match_table = qcom_slim_dt_match,
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ce28ac35b2b6..e0b21f0f79c1 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1678,14 +1678,12 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
+static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
 	platform_driver_unregister(&qcom_slim_ngd_driver);
-
-	return 0;
 }
 
-static int qcom_slim_ngd_remove(struct platform_device *pdev)
+static void qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
@@ -1700,7 +1698,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;
-	return 0;
 }
 
 static int __maybe_unused qcom_slim_ngd_runtime_idle(struct device *dev)
@@ -1743,7 +1740,7 @@ static const struct dev_pm_ops qcom_slim_ngd_dev_pm_ops = {
 
 static struct platform_driver qcom_slim_ngd_ctrl_driver = {
 	.probe = qcom_slim_ngd_ctrl_probe,
-	.remove = qcom_slim_ngd_ctrl_remove,
+	.remove_new = qcom_slim_ngd_ctrl_remove,
 	.driver	= {
 		.name = "qcom,slim-ngd-ctrl",
 		.of_match_table = qcom_slim_ngd_dt_match,
@@ -1752,7 +1749,7 @@ static struct platform_driver qcom_slim_ngd_ctrl_driver = {
 
 static struct platform_driver qcom_slim_ngd_driver = {
 	.probe = qcom_slim_ngd_probe,
-	.remove = qcom_slim_ngd_remove,
+	.remove_new = qcom_slim_ngd_remove,
 	.driver	= {
 		.name = QCOM_SLIM_NGD_DRV_NAME,
 		.pm = &qcom_slim_ngd_dev_pm_ops,
-- 
2.25.1


