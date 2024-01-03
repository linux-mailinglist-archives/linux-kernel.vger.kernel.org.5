Return-Path: <linux-kernel+bounces-15967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9351B82366D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F911C238B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954C91D553;
	Wed,  3 Jan 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZApOUn/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C11D527
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28ac851523so85324966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704313124; x=1704917924; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A2ZJGOikkMPN7pWE+w4oJN8NP+AUZ90HIGt1xo13QEI=;
        b=uZApOUn/mxLlMGJPmm13Egfnu3YTFdKAaTNE1MiHXsPtABwULRkw060NScRKNlCRGg
         TwyZekzmk+yyQEm3C/VK7/5NLM7Do7DQcYPg5/o0D1I2lqGLjHzeZyhxAlzFuPmFT73c
         N2rR8KSfvthAYGNOV3mAKRjrVfjiaLR1V6I1PNzfAx5ZDvlcP+EX2sWU4ziVYLW6D96r
         y2sNojkabKsz899K7+EDz65kK4q1J2FLavuLP8xVb+iO/omjvAXS9zNOKgNd7aWzhkKw
         JIYoDwQ9v/HxsWnrcDIgqIfVkSWLyGBxVkyinHdMLQwpDLnp5sdY/tLUq+xZXsNbAEOx
         ab4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313124; x=1704917924;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2ZJGOikkMPN7pWE+w4oJN8NP+AUZ90HIGt1xo13QEI=;
        b=Nrig10j6ZuBrf3m9T+IID7YcN/Ilp6JEIRgqQwpibfKrsWXyKCsTDXxot1T1KqK0C+
         BBaxU76kG3jrefHpynnFh8qjPRaHvOdErBpj4otcA9H6rOHvEHv2LHOYwxiFCDqPYFFr
         EK7FW7bJDC1775AKtZDOqkT1r4Cej1dLIyxRIb/M3Lwjno3vqaAVtBOpw1goFft1uu6C
         FEhhHn/+0lZZjyf1HPqmYno6XfAdJ5PIAThGQAGi7/2NR9UZbwgoFG3MCVloHv6D3Flg
         rGbHNbW8zMwuoEloQlIrHn/nn33HYd0ghrZad3trRaHrQVPR5ATfPKFqIg58clB0Qiij
         TkKw==
X-Gm-Message-State: AOJu0YxuZt7ROPwI+A6rXk6Ev9Q1fsnO1JHb4d61rjiukwj0DO/CdI9W
	xnw8jPgBZboPke3VUvjl1Hw3BsLNiGpjYA==
X-Google-Smtp-Source: AGHT+IEopSTbCf4B5V8fqwdakyTaEaltKwMaH7A9dLKVUUxSh9Idzu+RVi94wLwRocTrAJnl8BnPww==
X-Received: by 2002:a17:907:7e8a:b0:a28:afb8:9eea with SMTP id qb10-20020a1709077e8a00b00a28afb89eeamr553258ejc.86.1704313124095;
        Wed, 03 Jan 2024 12:18:44 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id wl1-20020a170907310100b00a236378a43fsm12962108ejb.62.2024.01.03.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:18:43 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 21:18:37 +0100
Subject: [PATCH v2] regulator: qcom_smd: Keep one rpm handle for all vregs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-rpm_vreg_cleanup-v2-1-04c79c4f9166@linaro.org>
X-B4-Tracking: v=1; b=H4sIABzBlWUC/4WNQQqDMBAAvyI5N0VTbbWn/qOIrHHVhTQJGw0t4
 t+b+oEeZ2CYTQRkwiDu2SYYIwVyNoE6ZULPYCeUNCQWKleXQqmbXJwnLdm/usg4ddog2NXLEfK
 m0kOlatQixT0ElD2D1XPK7WpMkp5xpPdxe7aJZwqL488xj8XP/v3EQhayKZsB8vpagq4ehiywO
 zueRLvv+xfm8N3c0gAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704313122; l=3511;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=oEtESB40r3b9IYd6/4bBqk9VXGazYB7UyTINdPp6n1U=;
 b=f7TiSIjD0bq8Xe77nwYvDy0TQG9DRzTS6fI3U1ukcZ2PtidSH0NyXUwOD0jeWtZGScn725yOg
 ztw/q+mYeCjBPXOb6WAX1KiLDgOrG7SFxOpTP/p9uYtBLeT+2Iovi7t
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

For no apparent reason (as there's just one RPM per SoC), all vregs
currently store a copy of a pointer to smd_rpm. Introduce a single,
global one to save up on space in each definition.

bloat-o-meter reports:

Total: Before=43944, After=43924, chg -0.05%

plus sizeof(ptr) on every dynamically allocated regulator :)

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Remove unused function argument from rpm_regulator_init_vreg kerneldoc
- Do NOT add a mutex around the rpm assignment, talked to Dmitry offline
  and we concluded it makes no sense
- Link to v1: https://lore.kernel.org/r/20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5@linaro.org
---
 drivers/regulator/qcom_smd-regulator.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index d1be9568025e..5461c03e2aac 100644
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
 
@@ -1440,11 +1437,10 @@ static int rpm_reg_probe(struct platform_device *pdev)
 	const struct rpm_regulator_data *vreg_data;
 	struct device_node *node;
 	struct qcom_rpm_reg *vreg;
-	struct qcom_smd_rpm *rpm;
 	int ret;
 
-	rpm = dev_get_drvdata(pdev->dev.parent);
-	if (!rpm) {
+	smd_vreg_rpm = dev_get_drvdata(pdev->dev.parent);
+	if (!smd_vreg_rpm) {
 		dev_err(&pdev->dev, "Unable to retrieve handle to rpm\n");
 		return -ENODEV;
 	}
@@ -1460,8 +1456,7 @@ static int rpm_reg_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
-		ret = rpm_regulator_init_vreg(vreg, dev, node, rpm, vreg_data);
-
+		ret = rpm_regulator_init_vreg(vreg, dev, node, vreg_data);
 		if (ret < 0) {
 			of_node_put(node);
 			return ret;

---
base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
change-id: 20231227-topic-rpm_vreg_cleanup-fa095cd528ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


