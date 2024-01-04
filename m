Return-Path: <linux-kernel+bounces-16806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FA824426
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D491C22038
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2382377A;
	Thu,  4 Jan 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DW2RTHF4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9523756
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so585140e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704379948; x=1704984748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Pny2BSPukPAhGXigrPkfA0Ifies1v/dCldSs0QzD7E=;
        b=DW2RTHF4UJm/tP1yfT4IIANQfeVwR0X9sU5omWSBCRQvF+/CLWq7+bqJvdUbqyLT6c
         yMDQzakzYtGFwMF0S32bmW+eUxykqikwZaKuaV7enLTBcb8CWhGqvwgrMq277jfBh4gP
         nJt6jM3CIyWf1n2QCa00duGq7D/OG3cMlyvADJ0MFE59clOJf6fO1iSo4M/1uNzJg3UG
         VAvcMsWCRpqQnt1q0c9pGRHtXRintrIy0lcxmiy5dmzCv8B7ACBGeSTOzW9ihTlkX6NJ
         xOQk/OgHbTsjvq847s4Sd5SrhssyRaLFhVV9jPUF4gSbV4fx1dBx31vyuQ/R8d+y7GUK
         r0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704379948; x=1704984748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pny2BSPukPAhGXigrPkfA0Ifies1v/dCldSs0QzD7E=;
        b=NmB300xuv5U2+6HhC+ea1BcmfT7Bt3Bk0i6hEa1+K50Fa25ziU+qJ8Bv4sOHRX2kNB
         5MKzlK0bIw96UtDynyKikRVAHhjnOQRINn0IMjhgEh1l5c1eETfL2G5ROp/kc1UuV60f
         B+nJub/MglNnbEAGhAYenASa7S+Eha6j4iJKhSDMPryNkYhsquOa5QOUhU271itoOHIR
         jx7bxuR1jSeGBMPO1Y/jdKDm5X5rFXUPazr1d6r0mlcXNJdm9bg3OzYWp3MGCPgN5gJ3
         yoAXhUb3luUgSp3doyOL4WPgILaIrjkodckXqfsh9Y/0mhScLTGWs8ca7RPBaJk18/tw
         Olaw==
X-Gm-Message-State: AOJu0Yym0ylMadkzTmf7KLIZsOetzHy2d4NmykN/Lj6RkEbfeGz0+Zx+
	pZikTQK28EsyGuqrbRmlaKn+LteLcrwWqTSGXyeXTrTO+BI=
X-Google-Smtp-Source: AGHT+IE4LZWjBT5Z/puJV/oZPwrany2VzsqiWwCpLplthDr8O07eEdSVga0vwXHDRi/sQPI1vh9NaA==
X-Received: by 2002:a05:6512:31c8:b0:50e:3d3b:93fa with SMTP id j8-20020a05651231c800b0050e3d3b93famr326971lfe.12.1704379948432;
        Thu, 04 Jan 2024 06:52:28 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id k24-20020a056402049800b00555e52fed52sm7970592edv.91.2024.01.04.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:52:28 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 04 Jan 2024 16:52:11 +0200
Subject: [PATCH 1/2] phy: qualcomm: eusb2-repeater: Fix the regfields for
 multiple instances
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-phy-qcom-eusb2-repeater-fixes-v1-1-047b7b6b8333@linaro.org>
References: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
In-Reply-To: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=GBupTnz16tRW20CMsCR0zbSfZA0/1o+u+nwhSpb/+hg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBllsYnkiZEJ2ippfJ4YOmJHOtwfvnPW4tdNoU63
 9GcXv2t91mJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZZbGJwAKCRAbX0TJAJUV
 VuqaD/9GVe1aAodgsSe7hiRo3X1qEr2g4Aeq/yTsLR3B39oPuRDl3pt654Y3Pg8R7VoZY26NLNE
 BcxraqReoegqo8rhI00yrd0REuYL+cu3T6341Q4pQKmVLZxhH9+V0ZUvE3eImTwOYKho2ruB7AE
 uye/FilmWm9RbsA3EAiJWuQk9AvmoBiieS05lt2obl1N52TsqQDD6yQeOQRGGgGdD010R9I1iDV
 ZrBLLBA6JJJJuRQoFNW9a9PSriB+qNHpTxkKqhBCYjcFT66fq8XWFzbB8U7o3IIAJ6IExZ5mRrH
 nu1eg9mpQa6IVjynBnlLqY6Kd8K8HQ8bE46Yr4f5iifehM/ymdyJosX/LLbSFSsw0c92GBRch4Y
 YQTg8GeSt6bNCRBwL5NfroooDri7DzNo9IvJMFBNvlDsvb1UcGC/3wTQtRiaPSy2c/RnK2+Kgnl
 IN8TxKZ9YPZku0ZlK32PmRlDBLhPOXEy2b5qdbFphU5o18pSYPwPnk1/YYTHeCXwE4E0hpUpuh8
 sWtjlO0MexqQGvuoYTPCSgZRcCC4TiSwBXBoq5gGQMlIBMsRi1rCJ75S4xFd8WfJlUyhvLOXV4R
 hkBfhlhWWol93KmOKT9jceVxk+M1ampz28t/gkZNS8ArnOP2j63+Q67xnLpwODXI4gEGKxotZg/
 shOi5CRLWVWDUWg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The global regmap fields offsets currently get incremented with the base
address of the repeater. This issue doesn't get noticed unless the probe
defers or there are multiple repeaters on that platform. So instead of
incrementing the global ones, copy them for each instance of the
repeater.

Fixes: 4ba2e52718c0 ("phy: qualcomm: phy-qcom-eusb2-repeater: Use regmap_fields")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index a623f092b11f..5f5862a68b73 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -101,6 +101,7 @@ struct eusb2_repeater {
 	struct regmap_field *regs[F_NUM_FIELDS];
 	struct phy *phy;
 	struct regulator_bulk_data *vregs;
+	struct reg_field *regfields;
 	const struct eusb2_repeater_cfg *cfg;
 	enum phy_mode mode;
 };
@@ -140,8 +141,8 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
 
 static int eusb2_repeater_init(struct phy *phy)
 {
-	struct reg_field *regfields = eusb2_repeater_tune_reg_fields;
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
+	struct reg_field *regfields = rptr->regfields;
 	struct device_node *np = rptr->dev->of_node;
 	u32 init_tbl[F_NUM_TUNE_FIELDS] = { 0 };
 	u8 override;
@@ -262,15 +263,21 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -ENODEV;
 
+	rptr->regfields = devm_kmemdup(dev, eusb2_repeater_tune_reg_fields,
+				       sizeof(eusb2_repeater_tune_reg_fields),
+				       GFP_KERNEL);
+	if (!rptr->regfields)
+		return -ENOMEM;
+
 	ret = of_property_read_u32(np, "reg", &res);
 	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < F_NUM_FIELDS; i++)
-		eusb2_repeater_tune_reg_fields[i].reg += res;
+		rptr->regfields[i].reg += res;
 
 	ret = devm_regmap_field_bulk_alloc(dev, regmap, rptr->regs,
-					   eusb2_repeater_tune_reg_fields,
+					   rptr->regfields,
 					   F_NUM_FIELDS);
 	if (ret)
 		return ret;

-- 
2.34.1


