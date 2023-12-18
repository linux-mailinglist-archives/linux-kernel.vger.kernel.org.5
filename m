Return-Path: <linux-kernel+bounces-3335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C4816B23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A512A1C22883
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DC182CF;
	Mon, 18 Dec 2023 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPs0yRvi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489913FF6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so27246875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702895295; x=1703500095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brusERLuF9g6InfhOI5cvRdOOm8bY1Bt/He5xK1JCeI=;
        b=BPs0yRvikcoZulo+U1dBH9rMg43owCp6w3eCw9jgvpmp/Fra8Fjc2xBO1xOSMlkVkh
         d0gTA99FzUIwz8jJvxmk8t9FLu/hKz8vAWdC0t/iJoABdwL243qNllIwq6IYUVIzDkfk
         YpiwB7YonrFCF0pT8UcpiqfFnn2BOLu5dhnIn6/YL4bQ4p8dllqqqoI5iRbUTonlsXfc
         nxx3INctiNg7xU5IYzx+No4FKLpp5Y/jXv0ylpFKu+xTE4QZTG2ySiR96qmFI6Owiuqe
         XcbAcZ93r6sZ/6kI1WEd5C/nDZ2A4UZkYeDPAb4qosXQTeE6I6vuhiKNpmkXuoRBM5iA
         dVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895295; x=1703500095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brusERLuF9g6InfhOI5cvRdOOm8bY1Bt/He5xK1JCeI=;
        b=emGcWuSfjbvSTb8NqyBMQjLnpn6vqvcW95Dpb0LzbEfPgV9Xc2jmmq4ANIvuzpbArF
         uUCha5lMQTgAUnJObkMoyB9GIyyuWS4GLRDkv6J73E2f6oWIChBlg6rZwp866wKFAWUZ
         Rlm7ZtbEMVhVQmhYl0eAQcoAXdkFr+v2F0hM7e1I9PrWjjQqKVE2rzG8uEbT9CXsx6C5
         C6KP4DdikpUd1K6rIVlZ5qE0x6q04OTxAwkgSguxUxMCtaKINE7EibBWGIKE8Y79xzYC
         YA+IuaFcOeG60nrcCSLRQmXC5blQUtSnYYn5zdGGx8SuwwBzMmkOCVEKheZa3+6ijMtd
         w8KQ==
X-Gm-Message-State: AOJu0YxxJafa0h/xNjrR3sngi3TxzYI2V684MiH17LY/k5beW8gUkoVx
	E0cmuF228hcsrKf3m+w2ycnZnQ==
X-Google-Smtp-Source: AGHT+IGcvTDwhd5gtAZxk3beaIc4nJhhiUcrpnVVNHEww7z/HT6hqj48Es5MK6YHfxePjX/GZg6DbQ==
X-Received: by 2002:a05:600c:54e6:b0:40b:5e21:ec34 with SMTP id jb6-20020a05600c54e600b0040b5e21ec34mr7776468wmb.102.1702895295476;
        Mon, 18 Dec 2023 02:28:15 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm41857967wmb.4.2023.12.18.02.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:28:15 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Dec 2023 11:28:10 +0100
Subject: [PATCH v6 2/3] remoteproc: qcom: pas: make region assign more
 generic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-sm8650-upstream-remoteproc-v6-2-3d16b37f154b@linaro.org>
References: <20231218-topic-sm8650-upstream-remoteproc-v6-0-3d16b37f154b@linaro.org>
In-Reply-To: <20231218-topic-sm8650-upstream-remoteproc-v6-0-3d16b37f154b@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mukesh Ojha <quic_mojha@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6221;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mMV4sYhyuHxZXOCyI694/SnyEcdmuikG1JEY+XT6GWQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgB67SBNIAHpvz/xAlFvclYguS84GF72MbxQbtGK1
 lgiz9hWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYAeuwAKCRB33NvayMhJ0VTTD/
 4jYxPXOclmW7AecpuxKV9iJwB0FtH/m2MmetGmTWGoJmjXcf9Ye7UqHEPEKG6k49NAMKBEWpikcW2I
 vj0p6AnX8UG9ylJkA6PyXvmBOI6h5h2Q2mQUlpyKhn6Li32bsA8QdOPRFPQzfFdkUIN5sMCd+HSuCd
 af5d2F8Pm4WG8F6AvAOGuHc1ITt0zEZwWrloyoRXnUp/kB5hvd+csl7sxyGYZIFz821kaWQSk+VF28
 XgOS0Ke59+a8IBRZjlBhmu2SVGjnUI5ewEDalguHCWGqGyZlShGg6Ryr+jP9uKFRQObd7qQJp0cmcs
 78IYbRFppiELZYY+WT06IlrnpRQbB0rtmvcopa0i65Z2+5k1S9CrtqrUHdoi5vzEfCBfnjber2YMZk
 2bgEGGfdo/Iyv5zTwWlAj99q5WZFcPwB6sjBX1kMGqR5cM/tEq1ohvWirWnJ2ukJ2qOITRCRRTcNDO
 t4WtJknNbs80OF+FByCB/PFZhyGUg/ieIg5id1jGjxEsZc1zwJofiH3aeTQxhiijnTe8zhC/O1/xOR
 3shcLLND0dqLb0XvoVldcpXz3nDopZcgd9tJlA52ilKEhdyBJ1eQhQorIz8gsqv9/lgDUpcmhiyrZ2
 BzG9vxdU5ckgWbcMKCiO00L5kHPikp+d36lZepwaJQs+hgXfH6iGTL7Qp1lg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The current memory region assign only supports a single
memory region.

But new platforms introduces more regions to make the
memory requirements more flexible for various use cases.
Those new platforms also shares the memory region between the
DSP and HLOS.

To handle this, make the region assign more generic in order
to support more than a single memory region and also permit
setting the regions permissions as shared.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 100 ++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 34 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index a9dd58608052..e90783fd1129 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -33,6 +33,8 @@
 
 #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
 
+#define MAX_ASSIGN_COUNT 2
+
 struct adsp_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -51,6 +53,9 @@ struct adsp_data {
 	int ssctl_id;
 
 	int region_assign_idx;
+	int region_assign_count;
+	bool region_assign_shared;
+	int region_assign_vmid;
 };
 
 struct qcom_adsp {
@@ -87,15 +92,18 @@ struct qcom_adsp {
 	phys_addr_t dtb_mem_phys;
 	phys_addr_t mem_reloc;
 	phys_addr_t dtb_mem_reloc;
-	phys_addr_t region_assign_phys;
+	phys_addr_t region_assign_phys[MAX_ASSIGN_COUNT];
 	void *mem_region;
 	void *dtb_mem_region;
 	size_t mem_size;
 	size_t dtb_mem_size;
-	size_t region_assign_size;
+	size_t region_assign_size[MAX_ASSIGN_COUNT];
 
 	int region_assign_idx;
-	u64 region_assign_perms;
+	int region_assign_count;
+	bool region_assign_shared;
+	int region_assign_vmid;
+	u64 region_assign_owners[MAX_ASSIGN_COUNT];
 
 	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
@@ -590,37 +598,53 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 
 static int adsp_assign_memory_region(struct qcom_adsp *adsp)
 {
-	struct reserved_mem *rmem = NULL;
-	struct qcom_scm_vmperm perm;
+	struct qcom_scm_vmperm perm[MAX_ASSIGN_COUNT];
 	struct device_node *node;
+	unsigned int perm_size;
+	int offset;
 	int ret;
 
 	if (!adsp->region_assign_idx)
 		return 0;
 
-	node = of_parse_phandle(adsp->dev->of_node, "memory-region", adsp->region_assign_idx);
-	if (node)
-		rmem = of_reserved_mem_lookup(node);
-	of_node_put(node);
-	if (!rmem) {
-		dev_err(adsp->dev, "unable to resolve shareable memory-region\n");
-		return -EINVAL;
-	}
+	for (offset = 0; offset < adsp->region_assign_count; ++offset) {
+		struct reserved_mem *rmem = NULL;
+
+		node = of_parse_phandle(adsp->dev->of_node, "memory-region",
+					adsp->region_assign_idx + offset);
+		if (node)
+			rmem = of_reserved_mem_lookup(node);
+		of_node_put(node);
+		if (!rmem) {
+			dev_err(adsp->dev, "unable to resolve shareable memory-region index %d\n",
+				offset);
+			return -EINVAL;
+		}
 
-	perm.vmid = QCOM_SCM_VMID_MSS_MSA;
-	perm.perm = QCOM_SCM_PERM_RW;
+		if (adsp->region_assign_shared)  {
+			perm[0].vmid = QCOM_SCM_VMID_HLOS;
+			perm[0].perm = QCOM_SCM_PERM_RW;
+			perm[1].vmid = adsp->region_assign_vmid;
+			perm[1].perm = QCOM_SCM_PERM_RW;
+			perm_size = 2;
+		} else {
+			perm[0].vmid = adsp->region_assign_vmid;
+			perm[0].perm = QCOM_SCM_PERM_RW;
+			perm_size = 1;
+		}
 
-	adsp->region_assign_phys = rmem->base;
-	adsp->region_assign_size = rmem->size;
-	adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
+		adsp->region_assign_phys[offset] = rmem->base;
+		adsp->region_assign_size[offset] = rmem->size;
+		adsp->region_assign_owners[offset] = BIT(QCOM_SCM_VMID_HLOS);
 
-	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
-				  adsp->region_assign_size,
-				  &adsp->region_assign_perms,
-				  &perm, 1);
-	if (ret < 0) {
-		dev_err(adsp->dev, "assign memory failed\n");
-		return ret;
+		ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
+					  adsp->region_assign_size[offset],
+					  &adsp->region_assign_owners[offset],
+					  perm, perm_size);
+		if (ret < 0) {
+			dev_err(adsp->dev, "assign memory %d failed\n", offset);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -629,20 +653,23 @@ static int adsp_assign_memory_region(struct qcom_adsp *adsp)
 static void adsp_unassign_memory_region(struct qcom_adsp *adsp)
 {
 	struct qcom_scm_vmperm perm;
+	int offset;
 	int ret;
 
-	if (!adsp->region_assign_idx)
+	if (!adsp->region_assign_idx || adsp->region_assign_shared)
 		return;
 
-	perm.vmid = QCOM_SCM_VMID_HLOS;
-	perm.perm = QCOM_SCM_PERM_RW;
+	for (offset = 0; offset < adsp->region_assign_count; ++offset) {
+		perm.vmid = QCOM_SCM_VMID_HLOS;
+		perm.perm = QCOM_SCM_PERM_RW;
 
-	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
-				  adsp->region_assign_size,
-				  &adsp->region_assign_perms,
-				  &perm, 1);
-	if (ret < 0)
-		dev_err(adsp->dev, "unassign memory failed\n");
+		ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
+					  adsp->region_assign_size[offset],
+					  &adsp->region_assign_owners[offset],
+					  &perm, 1);
+		if (ret < 0)
+			dev_err(adsp->dev, "unassign memory %d failed\n", offset);
+	}
 }
 
 static int adsp_probe(struct platform_device *pdev)
@@ -696,6 +723,9 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->info_name = desc->sysmon_name;
 	adsp->decrypt_shutdown = desc->decrypt_shutdown;
 	adsp->region_assign_idx = desc->region_assign_idx;
+	adsp->region_assign_count = min_t(int, MAX_ASSIGN_COUNT, desc->region_assign_count);
+	adsp->region_assign_vmid = desc->region_assign_vmid;
+	adsp->region_assign_shared = desc->region_assign_shared;
 	if (dtb_fw_name) {
 		adsp->dtb_firmware_name = dtb_fw_name;
 		adsp->dtb_pas_id = desc->dtb_pas_id;
@@ -1163,6 +1193,8 @@ static const struct adsp_data sm8550_mpss_resource = {
 	.sysmon_name = "modem",
 	.ssctl_id = 0x12,
 	.region_assign_idx = 2,
+	.region_assign_count = 1,
+	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
 };
 
 static const struct adsp_data sc7280_wpss_resource = {

-- 
2.34.1


