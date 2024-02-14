Return-Path: <linux-kernel+bounces-65969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFACC85548C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56879B25993
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6D013F001;
	Wed, 14 Feb 2024 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvQUq5t6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958213F010
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945249; cv=none; b=pdVAHezKwOuufHlvz1gtBkNA9XIMVibM99Vuzz3koWk0XxpxKN1i3zwDZ5YI1f4LDJiVjdXkCEDQ7IO7AiBxQlgcpogL7vAMjgGNYhG6ydJsrUrGx7O1caOQD6M5jiSescPDP3WFhqu6MblQTx+fe8Sr8HinLdmgqwIhzwJiZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945249; c=relaxed/simple;
	bh=4LROwuZKj3G5UarAy7ISLV8Z49ILwNriSc+DX7xCbJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8B6qp8kPQPYtsrst0EXNinjm+NNaBzbDz9qi/YJLOyzH9s2/VmzR8qVVjRsDFyavKsbt+3xs3+6SK6qMm//4+TiuW8l6Tw3THWXZjsQJcVpWCJrIA8UdflZYnD0dw0uzOF8D9CgsVCucvJPjaVUG6iE2tDYMkwxhrpiUBYPSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yvQUq5t6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a271a28aeb4so15895066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945245; x=1708550045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV6KAsArxgimUtDHuQlkVbBpy/xMC87U3LszE+Jd/CE=;
        b=yvQUq5t6Q3QOm+dQbzC4De0/wETrDPOAao0LWB4yi4P3CDikO26UpB8vmNuYgcw/LP
         r+B9MPPYr70oYI7AdIhFA+qWpbnP3lh+8TMLDi8yMQlIcbWVtrKBzlinqlV/kyjjktTC
         Vks27dIoAvNyULkwaqz3QiChnO6y+gP4QoAo4XDksmwt7xOGj6Z9X+DSXiHcfelkxgEL
         XkD3xeAlKRjdkDa0z460RRWX/mN8lnKVij+FIp7IWbtSD1vD20eVvNfdcA4vMblLfOQF
         AVpgta1DU+d1/X6f7IPpKcnPMTgAEYOjEa7eYT7djuFZDrcXQpR/pA5SkkmmcsQslJQn
         iMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945245; x=1708550045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV6KAsArxgimUtDHuQlkVbBpy/xMC87U3LszE+Jd/CE=;
        b=rhANCukkHbBUA/clW4tVd9EvdziXj6sD5O1ckvOZRe9WSQfMtNaWWLJnxFxPb8CD4T
         ExJPSGsr44iO6qZJam3FicBZAqMxNOj9b8uKqw32iTi5HrE6zVDDBIBflqEAv1sZX5Iw
         SYfT8apeHf4hZaWVmM90rsGO+tDpcnV8NbxHL70SLJPjSU12wqMlTzPOhSN5ZWMnJ0kD
         EsSCKIOc7AfVM2W9/d4wG84umum2lqa8OtBpcJCtxaEhULxoHYDHG4536i1hxDfNws2u
         PxJbI+E0zbE9Ai+xbKiMLKEs2cU7Lyww/6JNbbS39h1MUgwj0WfzPy02mUJlxP4YuHS1
         mt4g==
X-Forwarded-Encrypted: i=1; AJvYcCV0IE9pB0Va8fSGI/J37Z6WDcTtDdV4TJLqCZswSG/fZKGho8kKQstSlexN/8q6EC3YMxDD3zivry0vX6RecjeSVeUnN5CqxDBeEt9i
X-Gm-Message-State: AOJu0YyJJ2oJgcbvZySxuDyDTsBaIDCV+8zbVJmbjQcE2/U1ChIKxwix
	8vMdH6EiYhcp+MRuxyoCMVqH33Nm/WzYAfE7gR40gMBFkfHZcTxck3JuGBf47YA=
X-Google-Smtp-Source: AGHT+IHzsxx3AOPYwkGUeFhogGI80PY3yhCRmEhK1odK0qQ+qlL+iVC09i1szMitkiy+RIj0HXBuVg==
X-Received: by 2002:a17:906:d9cc:b0:a38:981c:840e with SMTP id qk12-20020a170906d9cc00b00a38981c840emr2035810ejb.19.1707945245462;
        Wed, 14 Feb 2024 13:14:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqAxJRuHuLa7FtY6zZi3LVBS++rEGvWsUTk1liNL8Qm6DCRdPWPgiKSKdJBjDAbnO5bP26msigbwn8n19RT+WqKpDb8okop14WYT+nWOXRGNd4+7soYghEKc1pJvRKbsat0hCoZjygmbrvRJNtGHBux2iX3sy8qv08e7Bk0BU5KQYpvsCQ4g7aTozVmnaNavH2bcmxy/IuNmUZaqFogfHKnc387X0eq3VRdTn/1JZ6XYVDVBnWRL/mJpwMMDBDKwjEo/9uQdxPKrgwPExphlGzi2G3jnekB24KpGjEYA1XC7WpUv9iKgLNbb2bPgzdeRnZrD2CIOyt4BzWC0vnsAumFrn6ORDPLBITU2UsTWJVjXgqLQr7TDvFID5151YodRaljfHH/kWS0u6E9UKf/dkzrG/cS+Wg0tAXVzjj0jNYuW7gp1+ku34rzRyGcFCcrEZSmobmtQbu9cgNXpXdO2OQnCs3jYCGfH1R6vv5NAs/6367Rv948RyuoBiKycQ/N0Pf0cQL+RU=
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3d22f53210sm1457661ejc.188.2024.02.14.13.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:14:05 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 14 Feb 2024 23:13:48 +0200
Subject: [PATCH RFC v3 3/4] spmi: pmic-arb: Make core resources acquiring a
 version operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-spmi-multi-master-support-v3-3-0bae0ef04faf@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6892; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=4LROwuZKj3G5UarAy7ISLV8Z49ILwNriSc+DX7xCbJQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlzS0UdlrMXcOsstRFNVkdktci53tJZ/KIRf09W
 rBYaL4DQXGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZc0tFAAKCRAbX0TJAJUV
 Vi1FEACETKPG5lNZ6t+PcyItRgAhtvlArhmfJXDkI30hcQXEIlDLCbTDq3ALZBtSPD9EDdV209u
 j+aZrzZrKnsBBcVZadPevuA+6tfKbs8IwL5sBt5wmQ1Qeea+9lKFEw2qA3Vl9zjTQU7XMcUeL+v
 VgvN1PUVjEV9sw331GT4VreIijLUICOkb9jNOtUNXqQ9DOhzVpLZkIhTmRI5jrZwpxeLLbgb2ed
 MkzoZuKuuV7V9/bgtXlPYtDdgH8EDdMHSH8+zSWqbqafeb0gF7jCXoMyBEO/c2aElbImxD6eBhJ
 ZHgej199mzqI+Rb0nzgwVdMhgFRkbti1LhQ3l0mdfaUJh89obSxiva2e+xeXzI7qzY6hUqMslFm
 YWHyvjUqOLsJamhY7ThnF9uAElbga/t0ON3VexpOHk3Ai8rNcC5HBZs6wVTSeKY8Xtn+wy1dAgS
 8Mgw4O5ahKlxNthuv1kOtuDLc8ZK3idnqPPo9nWCUf5F87OhEUFgslScnnm36puq8qXdGb37AUG
 PR6Dpn4i4n10i4j9XBnoV7wK49Zn910ux58VgK7mUc+XYqkYgP++sIKB341mI0qLx+e4H8z6HcE
 9had0323E0Suwfa6dvoptxcmVXpc+otagB2SCm1MVk1tkU+FywEyyM2azIe8Z+5C5y5mFl8joSJ
 QmD3QPVXwpSBZhg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Rather than setting up the core, obsrv and chnls in probe by using
version specific conditionals, add a dedicated "get_core_resources"
version specific op and move the acquiring in there.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/spmi/spmi-pmic-arb.c | 111 ++++++++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 23939c0d225f..489556467a4c 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -203,6 +203,7 @@ struct spmi_pmic_arb {
  */
 struct pmic_arb_ver_ops {
 	const char *ver_str;
+	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
 	int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
 	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
 	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
@@ -956,6 +957,19 @@ static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
 	return 0;
 }
 
+static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
+					  void __iomem *core)
+{
+	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
+
+	pmic_arb->wr_base = core;
+	pmic_arb->rd_base = core;
+
+	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
+
+	return 0;
+}
+
 static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
 {
 	u32 *mapping_table;
@@ -1063,6 +1077,41 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 	return apid;
 }
 
+static int pmic_arb_get_obsrvr_chnls_v2(struct platform_device *pdev)
+{
+	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "obsrvr");
+	pmic_arb->rd_base = devm_ioremap(dev, res->start,
+					 resource_size(res));
+	if (IS_ERR(pmic_arb->rd_base))
+		return PTR_ERR(pmic_arb->rd_base);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "chnls");
+	pmic_arb->wr_base = devm_ioremap(dev, res->start,
+					 resource_size(res));
+	if (IS_ERR(pmic_arb->wr_base))
+		return PTR_ERR(pmic_arb->wr_base);
+
+	return 0;
+}
+
+static int pmic_arb_get_core_resources_v2(struct platform_device *pdev,
+					  void __iomem *core)
+{
+	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
+
+	pmic_arb->core = core;
+
+	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
+
+	return pmic_arb_get_obsrvr_chnls_v2(pdev);
+}
+
 static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 {
 	u16 apid_valid;
@@ -1246,6 +1295,18 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return offset;
 }
 
+static int pmic_arb_get_core_resources_v7(struct platform_device *pdev,
+					  void __iomem *core)
+{
+	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
+
+	pmic_arb->core = core;
+
+	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
+
+	return pmic_arb_get_obsrvr_chnls_v2(pdev);
+}
+
 /*
  * Only v7 supports 2 bus buses. Each bus will get a different apid count,
  * read from different registers.
@@ -1469,6 +1530,7 @@ pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
 
 static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.ver_str		= "v1",
+	.get_core_resources	= pmic_arb_get_core_resources_v1,
 	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v1,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v1,
@@ -1484,6 +1546,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 	.ver_str		= "v2",
+	.get_core_resources	= pmic_arb_get_core_resources_v2,
 	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v2,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
@@ -1499,6 +1562,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 	.ver_str		= "v3",
+	.get_core_resources	= pmic_arb_get_core_resources_v2,
 	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v2,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
@@ -1514,6 +1578,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 	.ver_str		= "v5",
+	.get_core_resources	= pmic_arb_get_core_resources_v2,
 	.init_apid		= pmic_arb_init_apid_v5,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
@@ -1529,6 +1594,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v7 = {
 	.ver_str		= "v7",
+	.get_core_resources	= pmic_arb_get_core_resources_v7,
 	.init_apid		= pmic_arb_init_apid_v7,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
@@ -1584,44 +1650,23 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
 	hw_ver = readl_relaxed(core + PMIC_ARB_VERSION);
 
-	if (hw_ver < PMIC_ARB_VERSION_V2_MIN) {
+	if (hw_ver < PMIC_ARB_VERSION_V2_MIN)
 		pmic_arb->ver_ops = &pmic_arb_v1;
-		pmic_arb->wr_base = core;
-		pmic_arb->rd_base = core;
-	} else {
-		pmic_arb->core = core;
-
-		if (hw_ver < PMIC_ARB_VERSION_V3_MIN)
-			pmic_arb->ver_ops = &pmic_arb_v2;
-		else if (hw_ver < PMIC_ARB_VERSION_V5_MIN)
-			pmic_arb->ver_ops = &pmic_arb_v3;
-		else if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
-			pmic_arb->ver_ops = &pmic_arb_v5;
-		else
-			pmic_arb->ver_ops = &pmic_arb_v7;
-
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "obsrvr");
-		pmic_arb->rd_base = devm_ioremap(&ctrl->dev, res->start,
-						 resource_size(res));
-		if (IS_ERR(pmic_arb->rd_base))
-			return PTR_ERR(pmic_arb->rd_base);
-
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "chnls");
-		pmic_arb->wr_base = devm_ioremap(&ctrl->dev, res->start,
-						 resource_size(res));
-		if (IS_ERR(pmic_arb->wr_base))
-			return PTR_ERR(pmic_arb->wr_base);
-	}
+	else if (hw_ver < PMIC_ARB_VERSION_V3_MIN)
+		pmic_arb->ver_ops = &pmic_arb_v2;
+	else if (hw_ver < PMIC_ARB_VERSION_V5_MIN)
+		pmic_arb->ver_ops = &pmic_arb_v3;
+	else if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
+		pmic_arb->ver_ops = &pmic_arb_v5;
+	else
+		pmic_arb->ver_ops = &pmic_arb_v7;
 
 	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
 		 pmic_arb->ver_ops->ver_str, hw_ver);
 
-	if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
-		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
-	else
-		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
+	err = pmic_arb->ver_ops->get_core_resources(pdev, core);
+	if (err)
+		return err;
 
 	err = pmic_arb->ver_ops->init_apid(pmic_arb, 0);
 	if (err)

-- 
2.34.1


