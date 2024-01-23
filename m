Return-Path: <linux-kernel+bounces-34947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8B48389A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3ADB1C22A15
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD058AB5;
	Tue, 23 Jan 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlsUM/jC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FE57323
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999875; cv=none; b=NJLEewBq/GvvboWtPk8dhUJ/ena9IggXqqHOZFphFlBOjrRe52Q2UZ8MuJc1oey+wokK6eImLXTmQVP0XDGolD5yaNVK26w4t/q6Y3FXLddVZCotdCMzHPf3YJfqY7LTtoCZuU+n96Is1B/rWG3mxwPv9hmtN0j0UO1E9fnEgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999875; c=relaxed/simple;
	bh=XZNmKCtadz6Da1EJYKYhkd9L3yCpOcZpiG8dscR01jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMZ3+miph6imVvd3p9yk1WT55Wls1SwbTO3B7TrLUHa2LFHMiqwUhNXJB097vQOAv7muouQ79vhN7LhAw2reAHHAfFChrftUsIBNGDVBgqAhDURGtQGjipn9fSfJaipN9y2LRhaXWOX33JZPZqpSbpL0ZSmxcwlKEnUBG0O2u74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlsUM/jC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e800461baso48539915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705999871; x=1706604671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmUpAWI8T+ze0G7hpuFtNifMRc2sjFc92lz4GE1/R0M=;
        b=QlsUM/jChPKD50nWqSV9ZkKHlHMxXeY8VxdNHg4DWOssDXNbVlR3ArzYfv8yyWFPBc
         MjvmzwTYhyeh/wNZK9sAcXJa6ZJ1fsnjNW/O+Mk150QvB+9nh7eTZ6eaRlNsT94HqwAT
         oczv4JDXA2eMfCmcFsKPSHllLqUXndcF4hJ/qwWtD531g+4+i72EM1Q+6U4D6wOJgRzv
         IHBuwd5mxSbv1QYdwfIMPlaZXJcPEt/SHuTnq21YEThMnD7C+wgzhidZJPiUIQpGmf9Z
         4lFekblmaBnGpCt8MFVKPrIsq9tQKBzdKD+H0izFn6Dr9HNj9U5MRc3KNTM5Cz74l5LD
         KsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705999871; x=1706604671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmUpAWI8T+ze0G7hpuFtNifMRc2sjFc92lz4GE1/R0M=;
        b=XuP3WrfmY1ctJZlHF/UPNk+K3cFC6DeIW+vqiaFbi8Mkpuhrqyej82Bfh/NZmHpVa4
         y7WLNjR1PPW2KwI80kreU7GRDS60bZJSF4WUhN52Jvk27Xq4FsN3BoJME1crPec+Pqp1
         vp1va8944QpkMTdloPZhbAMqMa3YMHjdrFvZof8OklZOJBplbSR1CkRH7Rx8j8sJkuHB
         SIk4S3MK/eCUT1dXwYbaqKSepXMgMKjdEmb/ncY2xCTtf8kzEmbBkvnB7wnfZQSNC1Ez
         dIYj4v9UtOj9fxZygavQE5+cTBt1N1dBOa87BJGrLHkvghTGW0N2yzDb1g80EB6P9/bS
         gzrw==
X-Gm-Message-State: AOJu0YwMSBAXkbZzLC685w4YAbUoHZqsdnJIvtSHHi3JtsSKqeqvLK7d
	fXCzqK2tMZTcaNAUn0UYrnQfOMBAd5XU4UY46QxNW8W/6cYaUAA0Lk9I2PYSkm0=
X-Google-Smtp-Source: AGHT+IElIgvxZtWWU51XwImAiLbgvr9q8YNtZrMtz1qSs4V4/yBri0iky4HaaiuoVkxqzulXD/BMUw==
X-Received: by 2002:a05:600c:4f47:b0:40d:5aaa:a2d5 with SMTP id m7-20020a05600c4f4700b0040d5aaaa2d5mr154163wmq.201.1705999871669;
        Tue, 23 Jan 2024 00:51:11 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b0040e541ddcb1sm41847342wms.33.2024.01.23.00.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:51:11 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 23 Jan 2024 09:51:03 +0100
Subject: [PATCH v7 2/4] remoteproc: qcom: pas: make region assign more
 generic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-topic-sm8650-upstream-remoteproc-v7-2-61283f50162f@linaro.org>
References: <20240123-topic-sm8650-upstream-remoteproc-v7-0-61283f50162f@linaro.org>
In-Reply-To: <20240123-topic-sm8650-upstream-remoteproc-v7-0-61283f50162f@linaro.org>
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
 bh=XZNmKCtadz6Da1EJYKYhkd9L3yCpOcZpiG8dscR01jg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlr337kqvj3vmvlvwF75uVHYEm1H9JiBT+J9gAZZyN
 B2iOUHuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa99+wAKCRB33NvayMhJ0QxxEA
 CezeoXDS+NZXO7Jnofjpm9owx92hR3GNvB26t3YIUKINAEoBzeMlPoVHE+rBKdZqK3dWLeBS1AR183
 R0QHWSE6NT9rDOKyHrgTxLxWG4iuTTcgbnwe1PgJiae0joiv3GoC1XUCrnDe+XCUJJ8VWwai/9eknc
 SoRRgwR3AXmgUXMeAFzqKpGe47K6xGDhspOPGpr8edN3LQVdWDulxjt+Wg3J+d5Em/oENwamt3Io2t
 fXFwL/37oPAyxy/CzOrl3oCKt8WNihDjaSGWqjq5Oco7LRw6GPgjXj7STDjfHtQM67uxlHFm4J33Fc
 d00/xWS1fL6/Vl+sgGKfTlmSjlNMbRMiDBzpcLo1oeJCzqgGXCCPsdwfutSL1rcO6MMJSktly16Zme
 EZU2xNumvY1CPSsoYZCYgs3FI7Q3fbmcUk+0dqKyl/5YYlfE5yp0MXX0guV6do+YYODkRO7AdwUQsL
 dfxca94sBraJhfcj+jF/87bCIfj0EwkH3/48rsRBbUl0rl3LR3PhYfQEGNHq3935n8rYi0xBHeB6OV
 hU4oQ92ioMdgC3dvW3XbLZ4q1W7YO3XUmbhidSXaZSillqaRq+PC0Mbz6Xemq8mWDfbTtmcA2IH1mg
 VM/HI2gsaOSEnVfCMnsvpZCMJR2+AcU4LBD6wmgtGgXuolI79oJiSDeaT7IA==
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
index a9dd58608052..09e8ad9f08c4 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -33,6 +33,8 @@
 
 #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
 
+#define MAX_ASSIGN_COUNT 3
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


