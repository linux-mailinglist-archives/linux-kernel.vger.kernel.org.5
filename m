Return-Path: <linux-kernel+bounces-3850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227828173EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F99281DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868171D14B;
	Mon, 18 Dec 2023 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehDwO2IC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA33064A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e270639d9so2517600e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702910515; x=1703515315; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EC790w2wBtofMurLZCa3vCoI4IR1rVBptqvIo5PdSdA=;
        b=ehDwO2ICdTRht7kIi0uWYg934PVEmWfOw3SlYUDh8pOpTITEdX6ZAP8/0j7ZjvHa/j
         CRCeHIZvsH6r81ouscSd+bwr8i312HofPBZ55cVRFfc/r35DGemKp4mb10BHc7wNmbuC
         nT0GnY7Kv2J5YsSZ+KcXXfWSZA3ih3wqxWWQj+VoJjeQtrqElN5LrUUt8z8Fpj5RSkUQ
         /rjG187eEsLOtGQMrZ7MK9vOi7DiWSNI9dxnIc2YdkbRg8jz1FHDOEdLw7iqKZ89fHPi
         74Pae8hEKXMRCTHf7gAeMU7dtzJXcp5UwK+97KO9KxfUJbl+kr3RjJKLw7jAFVJIsjCO
         fHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910515; x=1703515315;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EC790w2wBtofMurLZCa3vCoI4IR1rVBptqvIo5PdSdA=;
        b=MwqMuritKD1iOMh0rz7F4fb24r7IhlGyoxq+byPw9dAO+JH6Bn4FJSGraLRUQBs8m8
         F6yyab0BsdKREV/d3ZIfxfHqIj2pFvEhcBT79F3MeprQw9TIjgzMc4pHQl3wmV143R3K
         QW5JWDVme5Qr6ye9ul3H0j+YkxEpBK1UvJemn3p7kS9HhlKCFYRJVK1orNF8UBctUThT
         PBlsRhF72RKbS313jrK0bYhVVcVgvCa2LpnlohGCA1Ay5Y7tmqQ3pBRloqDQsTmzKqJN
         s7Rp5bLBwr8qsEg8YsQLF4+1sheTZevE8uC4WcsuTUG6qyqMo/gKvcPHcqJmdcj3Zfm7
         VL6g==
X-Gm-Message-State: AOJu0YxyZMhXoXlSlGOqKiLaTZidKoCA77ettod09Qv6jAvnmh1Ngit5
	QmUn70OAYcm0j0Vn85VlgI9synr19saGMz0Kl4o=
X-Google-Smtp-Source: AGHT+IFjR4I4pOL61ywCzQqF3sg9naj5KMUspwmMQUBNDlEyn/0gZEg+ARarTPzvcRHkT/8K/I6Z0A==
X-Received: by 2002:a05:6512:e94:b0:50b:f9b5:b4de with SMTP id bi20-20020a0565120e9400b0050bf9b5b4demr9600773lfb.40.1702910514782;
        Mon, 18 Dec 2023 06:41:54 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id hg12-20020a1709072ccc00b00a2359f95ad8sm1145917ejc.37.2023.12.18.06.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:41:54 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 15:41:52 +0100
Subject: [PATCH RFC] power: supply: qcom_battmgr: Register the power
 supplies after PDR is up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-battmgr_fixture_attempt-v1-1-6145745f34fe@linaro.org>
X-B4-Tracking: v=1; b=H4sIAC9agGUC/x2NUQqDMBAFryL73UAToQ29SimSxI0uaAybVQri3
 bv0cwbevBMaMmGDV3cC40GNtqJgbx2kOZQJDY3K4O6ut856I1ulZGIQWSceMn1lZxwUca1iMPk
 HZj/mJ/agjRgamsihpFkrZV8WlZVRd//T9+e6frbbnkaEAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702910513; l=7109;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mgbHzQ/f6XWdmkp7t66704b+Nemu5GXGAe2cOFY3kSY=;
 b=5H6JfwMomIpo9Wi+N1T6ORl8MGtVbT8fuhohEuHl77wXXH5A08OIij6mUO0xDNJ8w5Y1p0b2r
 SfZASp6NigiCLTM94RHTaJSb6G4fIz2RZbs7U5ZicH6XSYtYUCmwTVo
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently, a not-yet-entirely-initialized battmgr (e.g. with pd-mapper
not having yet started or ADSP not being up etc.) results in a couple of
zombie power supply devices hanging around.

This is particularly noticeable when trying to suspend the device (even
s2idle): the PSY-internal thermal zone is inaccessible and returns
-ENODEV, which causes log spam.

Register the power supplies only after we received some notification
indicating battmgr is ready to take off.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/power/supply/qcom_battmgr.c | 109 ++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index ec163d1bcd18..a12e2a66d516 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -282,6 +282,7 @@ struct qcom_battmgr_wireless {
 
 struct qcom_battmgr {
 	struct device *dev;
+	struct auxiliary_device *adev;
 	struct pmic_glink_client *client;
 
 	enum qcom_battmgr_variant variant;
@@ -1293,11 +1294,69 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 		dev_err(battmgr->dev, "failed to request power notifications\n");
 }
 
+static char *qcom_battmgr_battery[] = { "battery" };
+
+static void qcom_battmgr_register_psy(struct qcom_battmgr *battmgr)
+{
+	struct power_supply_config psy_cfg_supply = {};
+	struct auxiliary_device *adev = battmgr->adev;
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &adev->dev;
+
+	psy_cfg.drv_data = battmgr;
+	psy_cfg.of_node = adev->dev.of_node;
+
+	psy_cfg_supply.drv_data = battmgr;
+	psy_cfg_supply.of_node = adev->dev.of_node;
+	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
+	psy_cfg_supply.num_supplicants = 1;
+
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
+		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
+		if (IS_ERR(battmgr->bat_psy))
+			dev_err(dev, "failed to register battery power supply (%ld)\n",
+				PTR_ERR(battmgr->bat_psy));
+
+		battmgr->ac_psy = devm_power_supply_register(dev, &sc8280xp_ac_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->ac_psy))
+			dev_err(dev, "failed to register AC power supply (%ld)\n",
+				PTR_ERR(battmgr->ac_psy));
+
+		battmgr->usb_psy = devm_power_supply_register(dev, &sc8280xp_usb_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->usb_psy))
+			dev_err(dev, "failed to register USB power supply (%ld)\n",
+				PTR_ERR(battmgr->usb_psy));
+
+		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->wls_psy))
+			dev_err(dev, "failed to register wireless charing power supply (%ld)\n",
+				PTR_ERR(battmgr->wls_psy));
+	} else {
+		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
+		if (IS_ERR(battmgr->bat_psy))
+			dev_err(dev, "failed to register battery power supply (%ld)\n",
+				PTR_ERR(battmgr->bat_psy));
+
+		battmgr->usb_psy = devm_power_supply_register(dev, &sm8350_usb_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->usb_psy))
+			dev_err(dev, "failed to register USB power supply (%ld)\n",
+				PTR_ERR(battmgr->usb_psy));
+
+		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->wls_psy))
+			dev_err(dev, "failed to register wireless charing power supply (%ld)\n",
+				PTR_ERR(battmgr->wls_psy));
+	}
+}
+
 static void qcom_battmgr_pdr_notify(void *priv, int state)
 {
 	struct qcom_battmgr *battmgr = priv;
 
 	if (state == SERVREG_SERVICE_STATE_UP) {
+		if (!battmgr->bat_psy)
+			qcom_battmgr_register_psy(battmgr);
+
 		battmgr->service_up = true;
 		schedule_work(&battmgr->enable_work);
 	} else {
@@ -1312,13 +1371,9 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{}
 };
 
-static char *qcom_battmgr_battery[] = { "battery" };
-
 static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
-	struct power_supply_config psy_cfg_supply = {};
-	struct power_supply_config psy_cfg = {};
 	const struct of_device_id *match;
 	struct qcom_battmgr *battmgr;
 	struct device *dev = &adev->dev;
@@ -1328,14 +1383,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 		return -ENOMEM;
 
 	battmgr->dev = dev;
-
-	psy_cfg.drv_data = battmgr;
-	psy_cfg.of_node = adev->dev.of_node;
-
-	psy_cfg_supply.drv_data = battmgr;
-	psy_cfg_supply.of_node = adev->dev.of_node;
-	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
-	psy_cfg_supply.num_supplicants = 1;
+	battmgr->adev = adev;
 
 	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
 	mutex_init(&battmgr->lock);
@@ -1347,43 +1395,6 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	else
 		battmgr->variant = QCOM_BATTMGR_SM8350;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
-		if (IS_ERR(battmgr->bat_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
-					     "failed to register battery power supply\n");
-
-		battmgr->ac_psy = devm_power_supply_register(dev, &sc8280xp_ac_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->ac_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->ac_psy),
-					     "failed to register AC power supply\n");
-
-		battmgr->usb_psy = devm_power_supply_register(dev, &sc8280xp_usb_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->usb_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
-					     "failed to register USB power supply\n");
-
-		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->wls_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
-					     "failed to register wireless charing power supply\n");
-	} else {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
-		if (IS_ERR(battmgr->bat_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
-					     "failed to register battery power supply\n");
-
-		battmgr->usb_psy = devm_power_supply_register(dev, &sm8350_usb_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->usb_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
-					     "failed to register USB power supply\n");
-
-		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->wls_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
-					     "failed to register wireless charing power supply\n");
-	}
-
 	battmgr->client = devm_pmic_glink_register_client(dev,
 							  PMIC_GLINK_OWNER_BATTMGR,
 							  qcom_battmgr_callback,

---
base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
change-id: 20231218-topic-battmgr_fixture_attempt-ec86ef8df7e3

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


