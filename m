Return-Path: <linux-kernel+bounces-11761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9D381EB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABB41C20858
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7091FD7;
	Wed, 27 Dec 2023 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhRzvGtn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48D1FA3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26fa26e7aeso143696666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703640574; x=1704245374; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2D5wXd8y6YDz3Y7OZAiTyYTC//DCpbhbIggq/xSd+SI=;
        b=YhRzvGtn5AzXYqjNQgz8SnesemOt2K6TLUzkltbz6CBxSa6uKG3bXQKXYEqe3YAoe+
         3aSaQzBuxBEdJlLq6Ey8rw8jhMnxEnfX5NSdAwHvKtLMvd/SiCdmGDPShLC+iGdc/JTK
         WAgSenhIvt0mpJaf54+GJB+MGhtJ43f24bs+jgwwW76fcgZhx9LRtgqEayPp1+CVvujb
         QJXwLYOtXmB0BFwVnzZ6pkXfoS7kvbl12PYnj6g2BIY+bkfQcH1R36DulLaEo+At33S4
         M6LdcfFwFAIYeoYE2L6A9n9UKqStMSEXVDCwAkDYSbroynKtME34RkU5yQ6YXUk7K1a0
         hQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703640574; x=1704245374;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2D5wXd8y6YDz3Y7OZAiTyYTC//DCpbhbIggq/xSd+SI=;
        b=E5qyDyIa/Aw5MnAsmGhIfiJUqEEAi+J2y8LrWpixtpJe2QxJfe8ZzNp0webpl6bY1Z
         JjmdHnEzmofEq45FeaCGemFHkbrLbTWYylqjSrkSnx3W6WgVjT3rGHuDKnSzOhcUIgr6
         Tmb7kQUL0JKlgUPnR0Nd+AFRAYbU+qNLq6dssVT/wnCdGW5x3LiMvUR4U/3/2E3F0XXo
         5tg6oOHXMppDWwlmYrceGGNB7haYPBfFGuzuI9N987JXg0TH92gJODrp6EAEr3A/KR+z
         JZM7bZdFgI/5vgApLGhB1TZlc5qARxWmMztOOuRWWtkz2Rp8Nonjp/Lr8Su6fIcVhgm2
         g8Tg==
X-Gm-Message-State: AOJu0YxO2+hyQZhqy5qiP/s6DPkiqfsEJAOpRYadxcBkUYWTxAxYkm06
	3Okum0SbVw4yFF4GHOo+kIxWDBsq9wgrIw==
X-Google-Smtp-Source: AGHT+IGM2AJdYnrWnWNLIMybhMo7f+t9xBUMdtl2T1SgifBRaDwDzp3Uv020nhjb7Z4t5WNXbI5XMg==
X-Received: by 2002:a17:906:6150:b0:a19:a19b:c701 with SMTP id p16-20020a170906615000b00a19a19bc701mr3969934ejl.81.1703640574350;
        Tue, 26 Dec 2023 17:29:34 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id up10-20020a170907cc8a00b00a2366090bcfsm2563010ejc.212.2023.12.26.17.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 17:29:34 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 02:29:33 +0100
Subject: [PATCH] regulator: qcom_smd: Keep one rpm handle for all vregs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPx9i2UC/x2NWwqDQAwAryL5bkBTpI+rlCJrjBrYxiWrUhDv3
 qWfMzDMAVlcJcOzOsBl16yLFWguFfAcbBLUoTBQTdeG6IbrkpTR06fbXaaOowTbEo6hfrQ8tHQ
 XhhL3IQv2HoznktsWY5HJZdTv//Z6n+cP3Rsjen0AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703640573; l=2867;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9Tqu1p9SYBTpsvzpd2G7/sD+9sC24EsBi4LoZn2SeCY=;
 b=mBHz7z3eGXsXINB18n0CU/5eNlgbMYl5gbtssb6tOVlg9/++g8QgKLVlTHRkQLJNj4Fsfd0kh
 kJEQaybQb3tBNAy9Kldff7BpHpIhuwbXpRQiSaqJIhiO1BgImv1qe34
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
 drivers/regulator/qcom_smd-regulator.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index d1be9568025e..905c15df8c85 100644
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
@@ -1391,7 +1390,7 @@ MODULE_DEVICE_TABLE(of, rpm_of_match);
  * Return: 0 on success, errno on failure
  */
 static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev,
-				   struct device_node *node, struct qcom_smd_rpm *rpm,
+				   struct device_node *node,
 				   const struct rpm_regulator_data *pmic_rpm_data)
 {
 	struct regulator_config config = {};
@@ -1409,7 +1408,6 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
 	}
 
 	vreg->dev	= dev;
-	vreg->rpm	= rpm;
 	vreg->type	= rpm_data->type;
 	vreg->id	= rpm_data->id;
 
@@ -1440,11 +1438,10 @@ static int rpm_reg_probe(struct platform_device *pdev)
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
@@ -1460,8 +1457,7 @@ static int rpm_reg_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
-		ret = rpm_regulator_init_vreg(vreg, dev, node, rpm, vreg_data);
-
+		ret = rpm_regulator_init_vreg(vreg, dev, node, vreg_data);
 		if (ret < 0) {
 			of_node_put(node);
 			return ret;

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231227-topic-rpm_vreg_cleanup-fa095cd528ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


