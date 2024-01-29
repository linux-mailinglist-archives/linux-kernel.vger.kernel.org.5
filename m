Return-Path: <linux-kernel+bounces-42814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDAA84071F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2831C22FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC465BBE;
	Mon, 29 Jan 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBZK8l5W"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5776657B9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535299; cv=none; b=ijukOAFktjrhboS09F+6bmolDb/gZiGlvUnZeswMF0QWBn5rT7MNYM2QV2wQIDiAEJg6m1aQz6yKtIfBnvMq+gHwZd1t5zr/MBOnif8MvMasqoJp5UNlkxznlXjJZWA/cOJ5ulEMb0W2HX/FtNtYoCrLV59xat//hN0Ea/oCPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535299; c=relaxed/simple;
	bh=7XEGX8tCobeF3TWbs26SkgzjQRQagB5DicUZQZndEAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bvmiw+iV2vj6aUakhZ05P8hvkFU5sanpSuDO3LtJBCTe1dgJuIQjF6RqOmzfhMpbx9UQZV2lGeJVb71TcZOp+/B8JV7uEmM32e4fRrbKOzfBKTryNUWswW742v+rUXrLTijWIz9jwNA8Vp9oMPCdU0dUlRwmd0Vkw8aZUabZwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBZK8l5W; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3122b70439so365734966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706535295; x=1707140095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXZFqpcx+yqKfOAXpJEod2Uxg4c+ixzxqWhb+cY1h8Y=;
        b=mBZK8l5WHdwNGGDRKq6wvzQnB/T9vVNeTYM4DsT8nBOsobyRA5/Tn82Tb3Lgj/9r1/
         qb7qDmv2l2aI0wzMLRxhWpgoc585O+zayMINaLh8un/PNg5FlRBxIRcsz8Oal5kMsIk/
         s+dcjptQqQUG1G3lSyA2ce5P/DkCb1ffXl9pyqb/o1uf9c+VjX3f/sUl5i6AxDgtXbQt
         gM6MoUl2pEbuBtyjdAOatFBbynpP/VOBI+/NUMS8PX16GuTT0POA5tx/kGXAdKrWVpen
         LOSWZCpGXw8s8RLVQEzGShwy9H5ePlArYDjuxMG77HHCCDQyASfQX66xojIjuXHMbb6M
         uZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706535295; x=1707140095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXZFqpcx+yqKfOAXpJEod2Uxg4c+ixzxqWhb+cY1h8Y=;
        b=F8yZnK2+FLDllMZgqn63BkUdmaMck8LGq7scIw2yhafKsXDfU3rG2teJYhGI3n7IjS
         lyQpTecHsNJKuiPS+mBgk94xuP0v05wlfGNYPZrW0baE+QMoExCg91Ieoku05e+HfzHx
         7O9yBP/jqbuXyZwZR3gT8+sr8Ym/UBfupIsM2NAUyNMSHdkO9UEJby02jFvDYXxmfxIw
         AyEQ71LPhOC37cu39u1+zk/kAcwtt3weUDHDH1LsEeafBrz2f+y8D5TJ/FNsVuogD7Nn
         kehcs+M+Qbd3iyOhi3iv0E3VxQ1lFivEhg08erY4FIWK1wtQak17d9JOMSucQHpfulkH
         wTvQ==
X-Gm-Message-State: AOJu0YwXuSKArkOcmQwmbrzIe8AmSiog/SP0PrUVsAbeRX0zjoAP5JJX
	tW97venw4vzgmt/Ufb/Tm9OA+yEKnaRov0cf5PbCBnAE6EAFL9Q6mxVTEzt0w40=
X-Google-Smtp-Source: AGHT+IHCFlT0NaicOgyWXFvdhxw1y4Dq6pYq28XJTkenjH+aNzp1/O+NJ3vGuzbpV29JtOx0Uln79g==
X-Received: by 2002:a17:906:248d:b0:a2d:a6a7:b3bc with SMTP id e13-20020a170906248d00b00a2da6a7b3bcmr4409221ejb.4.1706535295144;
        Mon, 29 Jan 2024 05:34:55 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vi1-20020a170907d40100b00a2f48a43c3esm3911483ejc.7.2024.01.29.05.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:34:54 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 15:34:39 +0200
Subject: [PATCH 3/3] remoteproc: qcom_q6v5_pas: Unload lite firmware on
 ADSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-remoteproc-v1-3-15d21ef58a4b@linaro.org>
References: <20240129-x1e80100-remoteproc-v1-0-15d21ef58a4b@linaro.org>
In-Reply-To: <20240129-x1e80100-remoteproc-v1-0-15d21ef58a4b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2175; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=DYmaa/61P4GaXID7Xccu2X68XxOqzoecSVlwWNbm4oQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt6l5CPj0vbamh6iXLeZP8wUB2GwT1lbw005/L
 ExfUy5EK/GJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbepeQAKCRAbX0TJAJUV
 Vk4dD/4pyJzUu6T1+dFDIrMr5yX8AxeC5PxCSxSS82hGVyIGL0+orImNWHgf8Mso62DjkvCxf04
 AKRN9an+loItW0pAklTRZmz6VynBGbQkvh0r9sbDggpkfFh77Oqnze5qnSBpibmew/wxA+ff0Z+
 QEk224GPexwy8asTTfibFzYRbikTjHvkf/vr0Jrb460tKv3PHw05Po0kFHh85vcI5bNpHK7UFxb
 VlQ1uwTocE7bTjd1nG85YJH9DcSl5gjN3XYZsyxB4o53PSgpshHb5QbkIVX0ufjdhgv+ipUQJZA
 CfL4uXyeBq/DDYbuWF41/a8yMRdj2CUbks1hSHeAOQeniVUv2l6g8bsZRkMO/omt2yJTxHx0H8H
 8jDx/rTgqBIdaIdpX9KhTJ1+tqlMZq2R4M0G6Bfa5Dytr42K/H4ZhcP/m6TTLhFcvNJt0O/kvOH
 uDlc9muh7K4XPHDN+UrPNIvozaCW8mAMKa1VM3QQndA7u/jtaOpYPZHk6e1SFAo7DzcWYACike3
 yw3DG0puF5gooNXTqtaAcziqQ6rsSXWPsvfqiGCGoRic4LWtMlJUL49C3+PfM6TgbdDxWrEFxZE
 gjtOedzLuSCP1kwMfUvRoQ2xaLTXF41gtCORvoxgh8MAUrgY3oK4Qv/4rQLCiYksHbFUbxILOzo
 G1afL4wVwYrGHhg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Sibi Sankar <quic_sibis@quicinc.com>

The UEFI loads a lite variant of the ADSP firmware to support charging
use cases. The kernel needs to unload and reload it with the firmware
that has full feature support for audio. This patch arbitarily shutsdown
the lite firmware before loading the full firmware.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 083d71f80e5c..4f6940368eb4 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -39,6 +39,7 @@ struct adsp_data {
 	const char *dtb_firmware_name;
 	int pas_id;
 	int dtb_pas_id;
+	int lite_pas_id;
 	unsigned int minidump_id;
 	bool auto_boot;
 	bool decrypt_shutdown;
@@ -72,6 +73,7 @@ struct qcom_adsp {
 	const char *dtb_firmware_name;
 	int pas_id;
 	int dtb_pas_id;
+	int lite_pas_id;
 	unsigned int minidump_id;
 	int crash_reason_smem;
 	bool decrypt_shutdown;
@@ -210,6 +212,10 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	/* Store firmware handle to be used in adsp_start() */
 	adsp->firmware = fw;
 
+	/* WIP: Shutdown the ADSP if it's running a lite version of the firmware*/
+	if (adsp->lite_pas_id)
+		ret = qcom_scm_pas_shutdown(adsp->lite_pas_id);
+
 	if (adsp->dtb_pas_id) {
 		ret = request_firmware(&adsp->dtb_firmware, adsp->dtb_firmware_name, adsp->dev);
 		if (ret) {
@@ -693,6 +699,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->rproc = rproc;
 	adsp->minidump_id = desc->minidump_id;
 	adsp->pas_id = desc->pas_id;
+	adsp->lite_pas_id = desc->lite_pas_id;
 	adsp->info_name = desc->sysmon_name;
 	adsp->decrypt_shutdown = desc->decrypt_shutdown;
 	adsp->region_assign_idx = desc->region_assign_idx;
@@ -990,6 +997,7 @@ static const struct adsp_data x1e80100_adsp_resource = {
 	.dtb_firmware_name = "adsp_dtb.mdt",
 	.pas_id = 1,
 	.dtb_pas_id = 0x24,
+	.lite_pas_id = 0x1f,
 	.minidump_id = 5,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){

-- 
2.34.1


