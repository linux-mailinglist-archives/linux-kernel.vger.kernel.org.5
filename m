Return-Path: <linux-kernel+bounces-65968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3DE85548A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A671C21F35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CADD13DBAE;
	Wed, 14 Feb 2024 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OD4YbwT3"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554C13F000
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945248; cv=none; b=MgIspBM0KxlhTfcypu5WKkFpGzeSx5vvgJFGeUV1PgURTcXMouA/SBVAbUi9nvr9hidIOh19qyDrHfuTLtOVGLFWiOh5SDTc9IW2jE/wfljUnsfAzwNwZJK8SxeBv9KvQfRSHaGGKQJ197LY4hyjlq1mZaW56uHwLed9WzjLQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945248; c=relaxed/simple;
	bh=bKFYboLxMzFRb04X+ozb/WPJtei7l0yJHbarbvFO084=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQmt5k7ZwNGQOI8XDpo3Dmf7kAM3Ot+QE2lp0lX0CQRuyoaXDcxMl9xuMHrlCDpUog3Y5LZKJR7WDdavDHA+DvQ5EnDglO8Bl1YlbIU7Qzk+ms8NRSJ0UXnesb8fFzEOUDqXiMl+MbrLvkCOblq7IShVfG31xAOoqNIGFoOTOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OD4YbwT3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511ac32fe38so247174e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945244; x=1708550044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mv6X//QoczbVtCVw1UzbH/X0Q7wummzkDNbCZ0tojQU=;
        b=OD4YbwT3to9c78Rlam4zdFRPWSuCVlxhsc35sO6wIC6vY5i/pNsp3SJgZ0F2mWkacx
         LOYu1XWQg9rJBnE3WThtMA+E7rw6Zr5oQBJnfWNKO97DfFFwLiXORttvfQ3eI4z/4Vyf
         oGpamNH6nKYsWY5EhKo+fI7J9l0qyFfbsed1juvOnrpqU/YHyz1/mvaG+TXtHzXVqGf8
         5/GjFuoDfz0h/SNFdqKvmhpUgtZMNIUZSi8fQv0fYaW4/c1IL3YxiIPRnVDKKGGhYgJ4
         mnNjPF7VdR/pt4i/f1/UdQUBLyC0BZqMifH7euSAqCRBdf4Mnx0HYku/J35Qt02gs0q3
         vGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945244; x=1708550044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv6X//QoczbVtCVw1UzbH/X0Q7wummzkDNbCZ0tojQU=;
        b=VedFzLF4hD2+7P/WUQtUSbhQR2+nMKKiD2cn0vMNn7M4BWKxjdY4gzGIQuRfDQ+l6b
         TJwgmUPRQZ9ui+jpazsQkPPs+bMEgx7qflXlini9KKKKZg/9+2YMc9uYNkVT66bSR93u
         R0Xu+M6nVNY1F0yqmf/4rIQA5G1IM44BQvvAPro4p4xh1XrLHKgfk2IAtNypSAeHQEHb
         qZyrj0vb9+GrmHr3+hFblOycBoRu3dwmCx3hZ3o9JrlMVI6fVznJbe/XhRdFbWyod/vf
         MQbNl3d8mJSyoJTM42ejSUvJ6po80r4d8JpPVS34St/MPFd5Jw5pHSMj8viPqkqZfyOR
         hT1w==
X-Forwarded-Encrypted: i=1; AJvYcCUzVy0rrJYJsggM7nXEIn18yP1gtENu2mqgSuTXsKVJwRajlQfP5q1GPYnmgBUr0hyAzzPDx3SEg0kjtse8++LqJUjs6/vH8aw/K2w6
X-Gm-Message-State: AOJu0YzCJwoMqPtsyCPE9UmbodkFoMeJViOUgHqy9VGG+o90qQNmsXug
	cyWSaoF+A1SKfcZAPZQxWjCab9HubYM8XT5ZbqNsTnrnjTs4Kwm48EYGNQzyHsA=
X-Google-Smtp-Source: AGHT+IGGBbMVWOs4KgtibIblCyH6HVl2O62mkQ2Yx8cbIwEWDSfgrKNYQdUN1iDqKdhMESylRZrSVQ==
X-Received: by 2002:ac2:4e92:0:b0:511:9d0d:ff59 with SMTP id o18-20020ac24e92000000b005119d0dff59mr2684848lfr.62.1707945242955;
        Wed, 14 Feb 2024 13:14:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJt0FTmGJ6w76/IyPJ2rkUr6w9zNq4VlNiSbviCuaDczvsGogkMPN8w1G2/ivfjAgJUph2j9LQNLtkD8DJzelPdtxShtibVuQryMjnusvj8ytGwOuTzLLrtaqI6oMI9E24SXqAxUmLOzANfe2mE20p2uaWlgO/C/5uGljW1Zpmv+VR0FWCq3ZP7nQTNKcEGH2n10sX2KOe7iAjw1BxRlNxBC62L8iDi5qQYHp64GEDzgorkdYkxdBAU9gRGSStGUKpOry7uSWpMifpT8gEoq5zGjFqI+yv8J7CkKe/cy5wjFH/AEhvcJY2gBXB5TurnVQS1ZCYK3BC94WDDz5BDH9CzRghh9zuxzXMW0XCTNkeY0GMLTgc1PjW8AbikMMEIk5LVtwZm139WcvxQGClZi84ex7RQAXajeL++3sldGFqdjm/K4YkgEUU7oiexkuoiEXuyA1asJp+f1kE2cxChw+ka+mYAJPYMxApO0NzsLmNJxpDGcCyevXyBAstwXepppLWppC9z/0=
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3d22f53210sm1457661ejc.188.2024.02.14.13.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:14:02 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 14 Feb 2024 23:13:47 +0200
Subject: [PATCH RFC v3 2/4] spmi: pmic-arb: Make the APID init a version
 operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-spmi-multi-master-support-v3-2-0bae0ef04faf@linaro.org>
References: <20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org>
In-Reply-To: <20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10835; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=bKFYboLxMzFRb04X+ozb/WPJtei7l0yJHbarbvFO084=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlzS0TsUbt+BWFJlchTfXaM18f41dpucg2xQf7B
 vdbv4pW4ryJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZc0tEwAKCRAbX0TJAJUV
 VmSSD/99hucTi1nIhlstOOR1/4S0kT6k6bezP8nSgsgcnc+Ow+7Dz32rigq1K7q+1cL0JXjYbDX
 ERUWxiiWQYV+AVBSNuyd26mWEqTy5JYjqo9X4/OudJqhMkTscGMbmcnxylPn/7CbPoGhPUkrqoh
 Kh6yEPDN2DcXRd37sbCxS8VZ7qep7kjKAmDnQtWRcdDMiqF5Hh8uuWbSqPhRbF9XymzgpIgiXsq
 BTIbCfNHzqTd6xHTCBQmKVIMzhQ92DBxjdw9MY5LLNaIuSq7dCAoWHOR/O9JXabiLCocjzpGYKf
 fvQZt+KrL343AnXN4zmDlUzJxNsKlhMok+4fBkV5GVBgLFtuGgSYxOqYwad9KLSEjjOwrvnYijj
 3Fir2AodT03rIVwMsW53nsGX5PnspmK2zjw/QpEpBFnIU3RT77AJhTYrEdXls5OQVfB9yMNZUdW
 5vCkk/h8JAXwB6zWqBOt2lwWUsOTQBjR+t/jcxZqXM1NKa196v2XeFzLxhVf6DOJDJxTIjVNloh
 /KQ1QKphc2W1Fsv4DKhuktJ5MtT0hlCRUlbDSWkV5TCkJ32ykuVSdHPY+5PVHYb/0awGjrtQgs7
 vmZPxj2eQdEIW2NKF/axZgIEWTmI0SnnsprTfGl0KpFsQ61pXaLN4PFxt+BnHOEptiHvhPexqgh
 O6ETGVyMR7chqDQ==
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
index 9ed1180fe31f..23939c0d225f 100644
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
+ * Only v7 supports 2 bus buses. Each bus will get a different apid count,
+ * read from different registers.
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


