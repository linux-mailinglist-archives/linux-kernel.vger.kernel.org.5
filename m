Return-Path: <linux-kernel+bounces-14031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B474821727
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07191C203B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CF9566B;
	Tue,  2 Jan 2024 05:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D90ZaNUb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8A10E1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e766937ddso7000883e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172650; x=1704777450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZIXO/ThTrvB76uyhSz3UtK15rWrBmplBSszBbpfRMs=;
        b=D90ZaNUbmhAHq/HjrwwK591ATA9FmB25H3ZmTC6dAXkKxS8xOck0nNvxI0mS9rfd/J
         7ILd/RxyPpmGzPIugvqc6gaKHc4cxsTJ43XbP2m115KC0ylU9QxOQiYKgVwR3HA1on3z
         NEEP+yOXU2YDCo5v5XsWFqZTusATgJaW+gvaF2rSmSuz+t5/mhlGiCVM7NWFbKacxf2Z
         whmh9zQoOS+tMOxq7dn8b10/v2u+J+pbQosxgpRJRzdNte8MVjRz2XJWsGA3CqboQuZd
         S3dALDUuEoDNboMx7R2uHZo3lCZqa6mVhEO5all5xZKU4miYSXL/ZgP3dm4NC8DTF5kv
         opHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172650; x=1704777450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZIXO/ThTrvB76uyhSz3UtK15rWrBmplBSszBbpfRMs=;
        b=LbAMUygIW4Ra4BcuVmUvCnMcVYJuF4UhghVjfXEOoj6MorGN/xehlY6V7doy5NOS4U
         NRaEAA5Q5JSDvTY+Wd3QebvilacueK9N0c54NyTvOoCGTdFKATn5Af40jfaoLiJ8M7PG
         DuBApaJQW87LsEVw/ypNf94Pd3yfqS8UyDy/eQvvWgp5tS51EaiBGYiYOuATaGUVE4cl
         UJDibjoBEzYciIeKwQpc7uVHb+Uw3yhKMX4HQZSGs0RhNXqi/w50kOt5aT5qh+WXOm0d
         yJtTLJXSialX4Y23oTGDBZbTl3hFYYM0ykLUc/CGELWgzA1xI5kO6LIB6rMTQgVcwcm4
         8OWw==
X-Gm-Message-State: AOJu0Yyjejc3WReUGDUJyWDCCePdse+DX5TXkGvdvEij2phf0vAz21FZ
	VV3B/YsdQcYtOQbGlClbD1lpo9jQsrYHkA==
X-Google-Smtp-Source: AGHT+IFFEFVpsEDS+y+rCbURQ4WFkh5IsquXFjsYIhuA+3N4KNlMBZcQ3Jo4UP8DTIKZW5EqF/yv+A==
X-Received: by 2002:a05:6512:3b9b:b0:50e:6cce:f83 with SMTP id g27-20020a0565123b9b00b0050e6cce0f83mr7619763lfv.41.1704172650431;
        Mon, 01 Jan 2024 21:17:30 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:24 +0200
Subject: [PATCH v7 04/22] soc: qcom: spm: remove driver-internal structures
 from the driver API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-4-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2084;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=a76V5wzOqJIYhtikxIwQ57SYROC70B96NpLt3fgYg9s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xj2RzTeDVozECsmG8KbA8MxS0mAvAVKiHEh
 4EqNsWdxzuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcYwAKCRCLPIo+Aiko
 1ZCDB/0T9Peoq2h7K4WOwq12rDVuzylEyRDBne4dCSpTjGMmN/a6uceuLmBbVQtVcVqTyDbmuMf
 rxCM1GXE593Ko4pdkKKeZfkkI+v8dkzx/PgzhBAFUpiiVCFXgDwpk4LnZ0TvKGLPfMxUAq3GOAk
 srzRG8XDnI8ziexjn5ShHcIDrzu/O9XGISscywTxUTv9M+RrQjs6sk2o//eOiFzFW0IHb6h7N2f
 7MvQGGBsMHasxFmzaYxVIGpHvXsrUkDln5+MMltdJGgU6Bfvs5/gvq7Bo1AKEoC313xg7i5Z6U+
 w441LpduamdgVhq/nZ4W8GvgYCVLUO+N2tMlNsZrDc/90o/P
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move internal SPM driver structures to the driver itself, removing them
from the public API. The CPUidle driver doesn't use them at all.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/spm.c | 20 ++++++++++++++++++++
 include/soc/qcom/spm.h | 23 +----------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 2f0b1bfe7658..b15435f7cb0d 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -36,6 +36,26 @@ enum spm_reg {
 	SPM_REG_NR,
 };
 
+#define MAX_PMIC_DATA		2
+#define MAX_SEQ_DATA		64
+
+struct spm_reg_data {
+	const u16 *reg_offset;
+	u32 spm_cfg;
+	u32 spm_dly;
+	u32 pmic_dly;
+	u32 pmic_data[MAX_PMIC_DATA];
+	u32 avs_ctl;
+	u32 avs_limit;
+	u8 seq[MAX_SEQ_DATA];
+	u8 start_index[PM_SLEEP_MODE_NR];
+};
+
+struct spm_driver_data {
+	void __iomem *reg_base;
+	const struct spm_reg_data *reg_data;
+};
+
 static const u16 spm_reg_offset_v4_1[SPM_REG_NR] = {
 	[SPM_REG_AVS_CTL]	= 0x904,
 	[SPM_REG_AVS_LIMIT]	= 0x908,
diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
index 4951f9d8b0bd..5b263c685812 100644
--- a/include/soc/qcom/spm.h
+++ b/include/soc/qcom/spm.h
@@ -7,11 +7,6 @@
 #ifndef __SPM_H__
 #define __SPM_H__
 
-#include <linux/cpuidle.h>
-
-#define MAX_PMIC_DATA		2
-#define MAX_SEQ_DATA		64
-
 enum pm_sleep_mode {
 	PM_SLEEP_MODE_STBY,
 	PM_SLEEP_MODE_RET,
@@ -20,23 +15,7 @@ enum pm_sleep_mode {
 	PM_SLEEP_MODE_NR,
 };
 
-struct spm_reg_data {
-	const u16 *reg_offset;
-	u32 spm_cfg;
-	u32 spm_dly;
-	u32 pmic_dly;
-	u32 pmic_data[MAX_PMIC_DATA];
-	u32 avs_ctl;
-	u32 avs_limit;
-	u8 seq[MAX_SEQ_DATA];
-	u8 start_index[PM_SLEEP_MODE_NR];
-};
-
-struct spm_driver_data {
-	void __iomem *reg_base;
-	const struct spm_reg_data *reg_data;
-};
-
+struct spm_driver_data;
 void spm_set_low_power_mode(struct spm_driver_data *drv,
 			    enum pm_sleep_mode mode);
 

-- 
2.39.2


