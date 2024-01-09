Return-Path: <linux-kernel+bounces-20697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD38283A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA1F1C23CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824535F18;
	Tue,  9 Jan 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvrV83x3"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30933CF4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd33336b32so35847761fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 02:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704794691; x=1705399491; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=miknyKwLNWMTM/CUdCtv3GjPRYtDM3k634e3VG5YdIA=;
        b=CvrV83x34Y4EGSGtqAzXFU3lVkrU2llswQ8qKlAXJL5hI5CW8lbqDGyMGx6vOSiRL7
         Y/NoqNRfmY3EdNr1MMV4SMaW/UZ/O6D96xtqYJYwFFIYS/yTXthUWcIr3640Ianxfc1c
         tdkQmmEkJGRGLpIXTltOkbhbKMhOBCCPEZZOqbY4TnVv21RAsb1WtKgT7nYXSB1wl8/i
         xeQPTvgQ5gKLauPwzjJnvrgWeSAlVCAggKrpXq2NdEcnyeWQheYvt3PPaBWPPrCpxUtn
         ndRaX33Ogci7TY7dqcbvGL78dCSoR1h8S4fURIjVJsuJ7x0P8NIR5beugOJJxrjemswD
         oDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704794691; x=1705399491;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miknyKwLNWMTM/CUdCtv3GjPRYtDM3k634e3VG5YdIA=;
        b=RF1xSgbNTqcECQPn3xIWy+pkbzphjaKs59Ijd5rBB4fH4uTruUuio0Qsfow2VM2hiH
         U6SwCyR+0yKYR1qjaoD0GBySflXxeDW23XuB/iAP587hfBV1KJ6IDdmQQqWyW/rFLGqd
         WSuJNIVuWbJzeD4HabOZKBUAgGUqjcOjjTxgeZpolh6k97urNdwN1ZugKOE338ZmXFF3
         fsv+BlhNo9Hr6wVUJ/gcbDb/VOLBLp96VtzG1IPGrXKK48Oao1GtpYghQUEAVvQmD/VK
         RH6BSIngFB5mKxPsK0Jp4h+QefmGkfGT5nhU3AZll6mcrx7H9tbNq2tpGf8keWJPMvxK
         htCg==
X-Gm-Message-State: AOJu0YwRhoPYbbaQRPglF0z0o2xkkQdnUmZLIJFDT0t7zYbApOA8KFzC
	FWEJuqY+5v6tTl0EOGOwW4v9W2FdsZqoJA==
X-Google-Smtp-Source: AGHT+IF1PQdzWPHmXLfPvFu9bbrKMv2YpXR8bSAhucmKxaDT2gZanTZAhc8UHgp22OlOcsfbgMqWxw==
X-Received: by 2002:a2e:9b03:0:b0:2cd:4a84:2b2f with SMTP id u3-20020a2e9b03000000b002cd4a842b2fmr1887094lji.57.1704794690930;
        Tue, 09 Jan 2024 02:04:50 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b24-20020a05651c033800b002cd2cdda9besm314529ljp.50.2024.01.09.02.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 02:04:50 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 09 Jan 2024 11:04:49 +0100
Subject: [PATCH v3] regulator: qcom_smd: Keep one rpm handle for all vregs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-rpm_vreg_cleanup-v3-1-fa0201029f78@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEAanWUC/2WNwQqDMBAFf0Vy7pYkWiU99T9KkRg3GohJ2KgUx
 H9vKPTU4zyYNwfLSA4zu1cHI9xddjEUqC8VM7MOE4IbCzPJZcMFV0Bp6XfCqTceddgSKDsObY3
 KytvIijbojDCQDmYuYti8L2MitO797TxfhS3FBdaZUP/eayFlB2tMzvw3dgkCeGM6ZRqrRNs+v
 Aua4jXSxM7zAwOGyMzGAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

For no apparent reason (as there's just one RPM per SoC), all vregs
currently store a copy of a pointer to smd_rpm. Introduce a single,
global one to save up on space in each definition.

bloat-o-meter reports a slight uptick:

Total: Before=44008, After=44080, chg +0.16%

However the saved n * sizeof(ptr) for every dynamically allocated
regulator quickly makes up for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- Validate that the global pointer didn't change
- Update the bloat-o-meter report
- Link to v2: https://lore.kernel.org/r/20231227-topic-rpm_vreg_cleanup-v2-1-04c79c4f9166@linaro.org
Changes in v2:
- Remove unused function argument from rpm_regulator_init_vreg kerneldoc
- Do NOT add a mutex around the rpm assignment, talked to Dmitry offline
  and we concluded it makes no sense
- Link to v1: https://lore.kernel.org/r/20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5@linaro.org
---
 drivers/regulator/qcom_smd-regulator.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index d1be9568025e..3b7e06b9f5ce 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -11,11 +11,10 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
+struct qcom_smd_rpm *smd_vreg_rpm;
+
 struct qcom_rpm_reg {
 	struct device *dev;
-
-	struct qcom_smd_rpm *rpm;
-
 	u32 type;
 	u32 id;
 
@@ -70,7 +69,7 @@ static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
 	if (!reqlen)
 		return 0;
 
-	ret = qcom_rpm_smd_write(vreg->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
+	ret = qcom_rpm_smd_write(smd_vreg_rpm, QCOM_SMD_RPM_ACTIVE_STATE,
 				 vreg->type, vreg->id,
 				 req, sizeof(req[0]) * reqlen);
 	if (!ret) {
@@ -1384,14 +1383,13 @@ MODULE_DEVICE_TABLE(of, rpm_of_match);
  * @dev:		Pointer to the top level qcom_smd-regulator PMIC device
  * @node:		Pointer to the individual qcom_smd-regulator resource
  *			device node
- * @rpm:		Pointer to the rpm bus node
  * @pmic_rpm_data:	Pointer to a null-terminated array of qcom_smd-regulator
  *			resources defined for the top level PMIC device
  *
  * Return: 0 on success, errno on failure
  */
 static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev,
-				   struct device_node *node, struct qcom_smd_rpm *rpm,
+				   struct device_node *node,
 				   const struct rpm_regulator_data *pmic_rpm_data)
 {
 	struct regulator_config config = {};
@@ -1409,7 +1407,6 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
 	}
 
 	vreg->dev	= dev;
-	vreg->rpm	= rpm;
 	vreg->type	= rpm_data->type;
 	vreg->id	= rpm_data->id;
 
@@ -1449,6 +1446,11 @@ static int rpm_reg_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (smd_vreg_rpm && rpm != smd_vreg_rpm)
+		return dev_err_probe(dev, -EINVAL, "RPM mismatch\n");
+
+	smd_vreg_rpm = rpm;
+
 	vreg_data = of_device_get_match_data(dev);
 	if (!vreg_data)
 		return -ENODEV;
@@ -1460,8 +1462,7 @@ static int rpm_reg_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
-		ret = rpm_regulator_init_vreg(vreg, dev, node, rpm, vreg_data);
-
+		ret = rpm_regulator_init_vreg(vreg, dev, node, vreg_data);
 		if (ret < 0) {
 			of_node_put(node);
 			return ret;

---
base-commit: 0f067394dd3b2af3263339cf7183bdb6ee0ac1f8
change-id: 20240109-rpm_vreg_cleanup-9fdb63e9f25d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


