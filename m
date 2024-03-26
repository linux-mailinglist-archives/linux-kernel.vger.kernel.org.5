Return-Path: <linux-kernel+bounces-119461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F1B88C93E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35961F66485
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AE913D2BE;
	Tue, 26 Mar 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPpp2GUA"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75F13D255
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470526; cv=none; b=HOv3GmtS2EyPt5T/M5yPN+WN+3hbqIALuLu1p7he9itpZUvrVMRYhJrEJ7R6yk1GsoJjJFuil1yuO8OSxWtBTq7ZS8tiTHzxDLDaiDNKHoJ6w0AAEY16esUKnq4v7K9Xza9TJoL0gLTKWSDZmebrc6Ab/aI4mZbOJjlMhOkTOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470526; c=relaxed/simple;
	bh=xUhXxEB1TSjaY+70YZslQBzXRf4SXFhFlW0PDrTOM4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMIq5IyMvhlKFxHpQ4bonE3SkZNVVF8vN8bWlGbTNUvJDC05WZ3kmeYelrBBTGxjihcNG3ZDdWFjGF5E3xrSSGHI9PfwaNWSLRQCHmCF7gux5vP4YbJV1I//Dpp4+8/LwvyIDG9tm4dsvIVVRkFmH7gydHmmZmwYcw4hEmslpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPpp2GUA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4dfb8bc3a6so50748666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711470522; x=1712075322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oA0fmKcMGpa77tBwzlw1ahRCKvmpIwJPYwf28NyUZ4=;
        b=cPpp2GUAjqZmB47+nU//QUmYkJCHZBd+o57FzueV+eDS0W1k4ML7an4n1Hv+AN19Pb
         PI8g7hrVgkSHQ74DmQz3MyCNTApH9srHwh+z+ATFR0i9k9F0LDuRGkUVqNvvi8v9Aj9l
         rqIe9seX7SzB7o150W+UwNPYt34HC76OEijqXxJzGYA70UBV94NvHhDJWWBnl2kCCaZC
         fr8sp+0ItTSnIpI+dIn2xKw7AInh8ZWwYN6UL+M7jfoOvgIDcsdFpnLHa7EyGBG/8bEQ
         PRQZc5njeV9aGmcpD0jqGPEvlqZr75dO8L4n0TVFY29+oBa+CaVI/sJtZ/mJQo85qa4f
         ew3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470522; x=1712075322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oA0fmKcMGpa77tBwzlw1ahRCKvmpIwJPYwf28NyUZ4=;
        b=bku5ZuFIZMUKtM0vY9YHjYhGpjK+pW1QWkSq0aVfgxvVJUqjvHPApCEZMr8qUSv9Qr
         +DYGHZnUGD0jIAOnqrTRB0+lYoYcIj54psaX/n+7Fjfeda4gsJY74IDbRfxHauxK7Z+m
         LDRN7yRcUwZCTpSa+86pHMNOkvQANK5udzjxRm4Z0tMC1nMDba/TL+PPY26YJ3VK7LXN
         LiGE8DbBK+COrFk8JWoaFAaB+hWaGW+35/Kg5D9iVUNkv0/KtQ2oL1x/oDSlYT2E7BwE
         r8tj8a9w7UgiSdIBzhqjbF+RDCq+5mgjboMXhkOkKD83Vhsgbt+RL6DzG+vEq4zMtOyP
         NJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSuOkrDGlNauDUhg0w21Mf/tCFuFHGeGln8d2KFKIlC4AR0q+xc84AGfFE0k+Bxch/r4PjtPL5fFpQi3ZRGKEgGBXuTMYTb2HC3m+D
X-Gm-Message-State: AOJu0YyeGnGfNTt+CXPqnMZnjbjksnni047IJZOlFAenl3zwUW4xTXlZ
	40w6nDgvNeOX9saGhHDTPHalJdfTHFC0o6b9554FrG2Abmb26iLJHIIeANyiNNI=
X-Google-Smtp-Source: AGHT+IF5ecueM8j94elEdjnYWCsA5s+9uZqfGl4itM8aRv7i3LEcTsq4sbTODZJrdSkA5o7sMcWbdQ==
X-Received: by 2002:a17:907:ea2:b0:a46:ea3c:72ab with SMTP id ho34-20020a1709070ea200b00a46ea3c72abmr9906039ejc.74.1711470522089;
        Tue, 26 Mar 2024 09:28:42 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906b09400b00a469e55767dsm4375051ejy.214.2024.03.26.09.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:28:41 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 26 Mar 2024 18:28:18 +0200
Subject: [PATCH RESEND v6 3/5] spmi: pmic-arb: Make the APID init a version
 operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-spmi-multi-master-support-v6-3-1c87d8306c5b@linaro.org>
References: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
In-Reply-To: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10831; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=xUhXxEB1TSjaY+70YZslQBzXRf4SXFhFlW0PDrTOM4E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmAvewIkleGVnx2QCiv5NylwLDUkZzoq7ZqjEi2
 h877wMbRuWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgL3sAAKCRAbX0TJAJUV
 VgzzD/9Vm851Otk3OVuA4xYiW3ikyA/aFB5kCZfArsuRDlzJ4aeqi7ij5tTtm9Ebr6Mm6fmMcaO
 lg5Ks0Lg4tQLER2EX/g6nEzkno/kSxu+W5DhZgHfbhGwBVexYJ3ljGcQt5ex1PJ7c+Z+eM3SCuP
 Qx4KhuUtgBV7FZDvJzak0MIn1SRX4Dyn/Gy65BkhvTY7ODxhRT6tlskRfHhl3by/h6f963PJh9S
 9+u9EsMYE78eqr+a8vA5xTlDrfQNJtqaKYJwNZaqjLewh0ztEAtwDcwNJ78zYG0cmiVhAE0NKHv
 GOQOVKeKYNbS3h548UHMF1ZtLmnMa5S7I8go97IPiFsrrJlfDhcAHSHDi6t7hGpLY8aw5aJbOnA
 VF6b/DN2l9U690Ty9gq1way+Qkhx2R/24PXhyQYwbRgGz5zGWaI4rQ328oheB3sJ2edkiAmQFJf
 XQJlfJWG5qvbI78Sfmsq513Mff/eSpQW8rkyFbHSL5TfH7xmoglT3jiXQlSHzuhNllCIYDJHivk
 udw5GbpzPk6xgFdiifdi7rnR3lIk4/Nz9LnZrPhz4hKpO3lwxVsKAxLFVfhU3DWvBImepElCZ8P
 IR5CyE3w3/KpHRjuPOUNt541pqpu7aAC28VYq/KUFtkCbuFgjm7Y4yydLclSp6Q4tYdgeiQu2e4
 rkTGEfpX4t0LBGw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Rather than using conditionals in probe function, add the APID init
as a version specific operation. Due to v7, which supports multiple
buses, pass on the bus index to be used for sorting out the apid base
and count.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/spmi/spmi-pmic-arb.c | 199 +++++++++++++++++++++++++++----------------
 1 file changed, 124 insertions(+), 75 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 9ed1180fe31f..38fed8a585fe 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -183,6 +183,7 @@ struct spmi_pmic_arb {
  * struct pmic_arb_ver_ops - version dependent functionality.
  *
  * @ver_str:		version string.
+ * @init_apid:		finds the apid base and count
  * @ppid_to_apid:	finds the apid for a given ppid.
  * @non_data_cmd:	on v1 issues an spmi non-data command.
  *			on v2 no HW support, returns -EOPNOTSUPP.
@@ -202,6 +203,7 @@ struct spmi_pmic_arb {
  */
 struct pmic_arb_ver_ops {
 	const char *ver_str;
+	int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
 	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
 	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
 	int (*offset)(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
@@ -942,6 +944,38 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
 	return 0;
 }
 
+static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
+{
+	/*
+	 * Initialize max_apid/min_apid to the opposite bounds, during
+	 * the irq domain translation, we are sure to update these
+	 */
+	pmic_arb->max_apid = 0;
+	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
+
+	return 0;
+}
+
+static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
+{
+	u32 *mapping_table;
+
+	if (index) {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
+			index);
+		return -EINVAL;
+	}
+
+	mapping_table = devm_kcalloc(&pmic_arb->spmic->dev, pmic_arb->max_periphs,
+				     sizeof(*mapping_table), GFP_KERNEL);
+	if (!mapping_table)
+		return -ENOMEM;
+
+	pmic_arb->mapping_table = mapping_table;
+
+	return pmic_arb_init_apid_min_max(pmic_arb);
+}
+
 static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 {
 	u32 *mapping_table = pmic_arb->mapping_table;
@@ -1144,6 +1178,40 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return 0x1000 * pmic_arb->ee + 0x8000 * apid;
 }
 
+static int pmic_arb_init_apid_v5(struct spmi_pmic_arb *pmic_arb, int index)
+{
+	int ret;
+
+	if (index) {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
+			index);
+		return -EINVAL;
+	}
+
+	pmic_arb->base_apid = 0;
+	pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+					   PMIC_ARB_FEATURES_PERIPH_MASK;
+
+	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
+			pmic_arb->base_apid + pmic_arb->apid_count);
+		return -EINVAL;
+	}
+
+	ret = pmic_arb_init_apid_min_max(pmic_arb);
+	if (ret)
+		return ret;
+
+	ret = pmic_arb_read_apid_map_v5(pmic_arb);
+	if (ret) {
+		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * v5 offset per ee and per apid for observer channels and per apid for
  * read/write channels.
@@ -1178,6 +1246,49 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return offset;
 }
 
+/*
+ * Only v7 supports 2 buses. Each bus will get a different apid count, read
+ * from different registers.
+ */
+static int pmic_arb_init_apid_v7(struct spmi_pmic_arb *pmic_arb, int index)
+{
+	int ret;
+
+	if (index == 0) {
+		pmic_arb->base_apid = 0;
+		pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+						   PMIC_ARB_FEATURES_PERIPH_MASK;
+	} else if (index == 1) {
+		pmic_arb->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+						  PMIC_ARB_FEATURES_PERIPH_MASK;
+		pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
+						   PMIC_ARB_FEATURES_PERIPH_MASK;
+	} else {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
+			index);
+		return -EINVAL;
+	}
+
+	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
+			pmic_arb->base_apid + pmic_arb->apid_count);
+		return -EINVAL;
+	}
+
+	ret = pmic_arb_init_apid_min_max(pmic_arb);
+	if (ret)
+		return ret;
+
+	ret = pmic_arb_read_apid_map_v5(pmic_arb);
+	if (ret) {
+		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * v7 offset per ee and per apid for observer channels and per apid for
  * read/write channels.
@@ -1358,6 +1469,7 @@ pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
 
 static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.ver_str		= "v1",
+	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v1,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v1,
 	.offset			= pmic_arb_offset_v1,
@@ -1372,6 +1484,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 	.ver_str		= "v2",
+	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v2,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v2,
@@ -1386,6 +1499,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 	.ver_str		= "v3",
+	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v2,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v2,
@@ -1400,6 +1514,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 	.ver_str		= "v5",
+	.init_apid		= pmic_arb_init_apid_v5,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v5,
@@ -1414,6 +1529,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v7 = {
 	.ver_str		= "v7",
+	.init_apid		= pmic_arb_init_apid_v7,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v7,
@@ -1439,7 +1555,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	struct spmi_controller *ctrl;
 	struct resource *res;
 	void __iomem *core;
-	u32 *mapping_table;
 	u32 channel, ee, hw_ver;
 	int err;
 
@@ -1467,12 +1582,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
 	pmic_arb->core_size = resource_size(res);
 
-	pmic_arb->ppid_to_apid = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PPID,
-					      sizeof(*pmic_arb->ppid_to_apid),
-					      GFP_KERNEL);
-	if (!pmic_arb->ppid_to_apid)
-		return -ENOMEM;
-
 	hw_ver = readl_relaxed(core + PMIC_ARB_VERSION);
 
 	if (hw_ver < PMIC_ARB_VERSION_V2_MIN) {
@@ -1506,58 +1615,17 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 			return PTR_ERR(pmic_arb->wr_base);
 	}
 
-	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
+	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
+		 pmic_arb->ver_ops->ver_str, hw_ver);
 
-	if (hw_ver >= PMIC_ARB_VERSION_V7_MIN) {
+	if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
+		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
+	else
 		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
-		/* Optional property for v7: */
-		of_property_read_u32(pdev->dev.of_node, "qcom,bus-id",
-					&pmic_arb->bus_instance);
-		if (pmic_arb->bus_instance > 1) {
-			dev_err(&pdev->dev, "invalid bus instance (%u) specified\n",
-				pmic_arb->bus_instance);
-			return -EINVAL;
-		}
-
-		if (pmic_arb->bus_instance == 0) {
-			pmic_arb->base_apid = 0;
-			pmic_arb->apid_count =
-				readl_relaxed(core + PMIC_ARB_FEATURES) &
-				PMIC_ARB_FEATURES_PERIPH_MASK;
-		} else {
-			pmic_arb->base_apid =
-				readl_relaxed(core + PMIC_ARB_FEATURES) &
-				PMIC_ARB_FEATURES_PERIPH_MASK;
-			pmic_arb->apid_count =
-				readl_relaxed(core + PMIC_ARB_FEATURES1) &
-				PMIC_ARB_FEATURES_PERIPH_MASK;
-		}
 
-		if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
-			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
-				pmic_arb->base_apid + pmic_arb->apid_count);
-			return -EINVAL;
-		}
-	} else if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
-		pmic_arb->base_apid = 0;
-		pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES) &
-					PMIC_ARB_FEATURES_PERIPH_MASK;
-
-		if (pmic_arb->apid_count > pmic_arb->max_periphs) {
-			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
-				pmic_arb->apid_count);
-			return -EINVAL;
-		}
-	}
-
-	pmic_arb->apid_data = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
-					   sizeof(*pmic_arb->apid_data),
-					   GFP_KERNEL);
-	if (!pmic_arb->apid_data)
-		return -ENOMEM;
-
-	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
-		 pmic_arb->ver_ops->ver_str, hw_ver);
+	err = pmic_arb->ver_ops->init_apid(pmic_arb, 0);
+	if (err)
+		return err;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
 	pmic_arb->intr = devm_ioremap_resource(&ctrl->dev, res);
@@ -1599,16 +1667,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	}
 
 	pmic_arb->ee = ee;
-	mapping_table = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
-					sizeof(*mapping_table), GFP_KERNEL);
-	if (!mapping_table)
-		return -ENOMEM;
-
-	pmic_arb->mapping_table = mapping_table;
-	/* Initialize max_apid/min_apid to the opposite bounds, during
-	 * the irq domain translation, we are sure to update these */
-	pmic_arb->max_apid = 0;
-	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
 
 	platform_set_drvdata(pdev, ctrl);
 	raw_spin_lock_init(&pmic_arb->lock);
@@ -1617,15 +1675,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	ctrl->read_cmd = pmic_arb_read_cmd;
 	ctrl->write_cmd = pmic_arb_write_cmd;
 
-	if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
-		err = pmic_arb_read_apid_map_v5(pmic_arb);
-		if (err) {
-			dev_err(&pdev->dev, "could not read APID->PPID mapping table, rc= %d\n",
-				err);
-			return err;
-		}
-	}
-
 	dev_dbg(&pdev->dev, "adding irq domain\n");
 	pmic_arb->domain = irq_domain_add_tree(pdev->dev.of_node,
 					 &pmic_arb_irq_domain_ops, pmic_arb);

-- 
2.34.1


