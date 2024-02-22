Return-Path: <linux-kernel+bounces-76638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31C585FA57
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690B5289F14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F41350EA;
	Thu, 22 Feb 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP9lR2Jv"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F71468EA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609949; cv=none; b=o02uP4IXw/Ga4E+I1DbOEbb6xMWZgdYcpbjVywz9qrxkP2TCYjYhn02uFFPT0wfBxd6JeY13z15QqKU8RfzbultV8MR0T/fgS/vfjEB8JnoIyZxEmDiFMwJxFHHpWGVTjlYoWcLr5pVz52kBSBFJ+Uk7LLJEPsPjIOHs+aWmaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609949; c=relaxed/simple;
	bh=xUhXxEB1TSjaY+70YZslQBzXRf4SXFhFlW0PDrTOM4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nwh8VOvouGb9fDXLvy8hojCKKLdRHGXOwgejyeAqjhdnzF3mbLsCGVe4HQ5iU3J8xLbREg5ukit3r7OhiWQ1UPTIuFWCgSeUUMKrWsyhJ2MGCDMo4js2aoyhezJC8OckU1hurZXSBs2+hUrxviedoPVmMDs7WIHcG7mAgYZBwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZP9lR2Jv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so998896566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708609945; x=1709214745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oA0fmKcMGpa77tBwzlw1ahRCKvmpIwJPYwf28NyUZ4=;
        b=ZP9lR2JvIZYdcxaSfDjRfTf+q0YpGKhFhCltJfMfuwIdIGuu7czO79IcCdKYRuzLVp
         Ct2caOEqkcVt80+jRE4fsXSjV7UISIm1AEpTGmb3WthCXLWijJQnOr3L4yclCKTIHkTe
         QddQ3Fqy1KPIT5na8ed/Xpho7/EwYL/23IMVxI0Bh7+56MdQfIYpVwGsB7zPbnY09CgR
         v04yEewx/RL6m3sAX0Q/eq5ae+q7eLoQH2UqQsK60tC/k47N71zY4DvNtTr15mLK8DCr
         Zs7mJQYkW2EMCkD3YqUz3SWyyksLdymG532CjDy1ECzNnRPIlDRfH15FyyXGFuZVG/Py
         2IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609945; x=1709214745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oA0fmKcMGpa77tBwzlw1ahRCKvmpIwJPYwf28NyUZ4=;
        b=KhMEtG1K3ixXNS7wN8K303ilC6UsoufOuqWbLEr4zJzQ0ZOtoBnHB1Mtl0MjQeE+f8
         /zRKzWd8+Ywor3GrSN0iZTFFJnCqTZP9d5YrpVcgDucstXR4eRSwgW966Wxc4O6j6BUZ
         foCjk5j5XGPa05ZO8+kCCqoL5YsknYkn+SuLqT398yvuhQvQMIRUS+Ic1P51qHz59XVO
         bFFQHcmTb1z6LOOckBDj7jdDaCzbbhvitbERG7ovQxINOUZmbrfljIaD/w6pyMqsBUtU
         Q01ETCMIuS+gghBP+CirCqLlSGM9+3fMgxTD5x9LbK4HxK+oRlaG1tMW44N/T3yCJyn5
         MOEw==
X-Forwarded-Encrypted: i=1; AJvYcCWhHP/0ucPhu6yYwI8dXnU91MTn7HORKo2/18os9bsZwbyL1Y7L/GrGIxWImS2mrp8i7+GmXZ+BRfLSNXDT2oEEl6TCYHy5I5e21whl
X-Gm-Message-State: AOJu0YyBIu4lH2Ei9yqsxQpCxdLjPPg63lO0Ne899Ytqgnirc5jCgQYM
	bXZIjAKJZhYDeb8h48Bn34ulqaYwqfATchmdqz4FlYkzIlEnbkt8NEsq1x0Vm/s=
X-Google-Smtp-Source: AGHT+IHNY8qxxD1cbONNLyuT97eCZnVnvMJpE/QkKV9d4LXP2QDpeyxr5SXIwTIIjLpIKge0UzRkUQ==
X-Received: by 2002:a17:906:b0d9:b0:a3d:2e0e:3f52 with SMTP id bk25-20020a170906b0d900b00a3d2e0e3f52mr15942826ejb.37.1708609944931;
        Thu, 22 Feb 2024 05:52:24 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b00a3ecdd0ba23sm3382839ejb.52.2024.02.22.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:52:24 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 22 Feb 2024 15:52:04 +0200
Subject: [PATCH v6 3/5] spmi: pmic-arb: Make the APID init a version
 operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-spmi-multi-master-support-v6-3-bc34ea9561da@linaro.org>
References: <20240222-spmi-multi-master-support-v6-0-bc34ea9561da@linaro.org>
In-Reply-To: <20240222-spmi-multi-master-support-v6-0-bc34ea9561da@linaro.org>
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
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl11GPjyYkQbpEe1tZZbHj+mFYHH3Oe4xzQjim7
 A22ixuiSdaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZddRjwAKCRAbX0TJAJUV
 ViQ1D/9DRRChsgDXo/wrGeWnhesGlRoSyED2HROdZOK3NVtWaEUU52G9qjhQz07ycb0kbAIb2OZ
 Dv48k18AZ5l/m38cAv2eW6h1IhhK3663tIyWoi5pnBPFkeTGIHQ6ac0piPS9Iu0byK4x/TLbA67
 SHuhaXrt8Hwbopj3j1b0W0RKsbK6cZTDksHRx/QsDIkJ/KvToml2vGJh/ljvqWBAwFJRKgfWa9U
 YQFuWYc4u6Wgqn4JOlhMGLWYTMfqIXDUvJwHhNbFHUX3qUydH2gdw025gIy2stkOFgZL/TZXl8I
 Yvl4Ln73XEWMdH7JbRGPtdmOB+Op94EN0oYCwN+4NXYa6sqcF6nENSxlqO8eo/9g/UknrJOjrCa
 jbjtylfvLY9ut8K52GGWtoPn4/aRllw9836/KRYqnqi+1BKBvxL6amDClL2yYyv9shkX5GgdVrX
 EPNfB+rNNoDcTxIGfVHzJnXYpUXbGCRFlMbB7XBugWACfctNX4EScLmvzf60Uj8ripcDWe1CsDb
 w0eRAsy+t3OGf/dinIVIe0jDoop7V3CcLvF8yRBUzKIrRP2A/YOVrWhJbx2zhYSv4qUR78zTbul
 XYOgiqjvc0oA4UuXhpyCHyUE8OHjA0T2r3tLGa1HgFsvl6bosXntsC41oToExx6mfbLNILJKLCv
 3RX0SYDErrb8inQ==
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


