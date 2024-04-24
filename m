Return-Path: <linux-kernel+bounces-156633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910108B060A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E681C22ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370B159580;
	Wed, 24 Apr 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHKnUZsp"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE87158DA8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950885; cv=none; b=LzWpM8i7qmX0geE3BrY4BIzjtf+wr7GTTutp04ckek94gP5c/n00TxXXv/7WRro5vKaaD4AI8ESG7ylS7RjhZTGORjc6CGxF4nBKzeHVwMkORtKTzgwRQB5LGc3x3b1ggATqvQ2N4SmaON+Uy3AFIcPTzPoEd8jFNthNplasXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950885; c=relaxed/simple;
	bh=v570ahBWF8ORIfZM6BH0hIA1GZMDcQxNJqsiqERo9kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOONX2HyFtBVVfXMr1vMSAp7Omsnrk2RkfsrLb1eG/Ek55oUuLHnjBrBmHpI1SZEnchLTgFbKoQDOT2Iqc/NU6D8yoAEsWNbPYubtu6qvwTg7G1C6rRE9fA4Svd6MtvcYfmYyQUL4nXR4JP0CUVaKz0DyaGo0F5NrQ/rXBbSixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHKnUZsp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d895138d0eso51913271fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713950881; x=1714555681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MS2KNkWq4ZyeLPsMtcVRix58GXeTzapt58TUhwImAs0=;
        b=lHKnUZspBuH13OPjUfqUMZGg81bfsKyaqv4jZQ8Ww9MkeTdxo2rdCgOhiTv7uTFT53
         YTAcEljslHBHER7om5xzlLcpf1H13eoQEghHzFVvOjp7WMYFCYzko9SBP0uyTHlQP+g0
         iNnZcv+MfKuXlG2mAR10l7OeXY60RU45bRxwjU7Eq/YjKlx788eu00Z+XMRUasUdkRQy
         Xyi/jCjS7FuTYmFqtpVH0WBfURE2ybhETfR6OQK1SypLevzErhnzA5Z2Ulp0vqvlwCVx
         N4DuWgsOWIgZTCUehqw1d7BXJjlxtPy/4iJiNGHowYUYYgii69lESqqdN83YOPQlPveU
         hLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713950881; x=1714555681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS2KNkWq4ZyeLPsMtcVRix58GXeTzapt58TUhwImAs0=;
        b=usHgIZdLz90wn80x+K2Rrm6IptDwHZ7BJrcTXRoY1DVyE6ZiNekNAWwpete909QBYD
         HG2hqqXMjca4yJ3RqCqrznzmqne0Owe0KdWxjczKIydOLCliXCFTMblQ1Zy0gHtTOoAf
         3/qLmd5GmeM7mxLjbIr14nFhT77gk+Cy/8QbHg3WzAelFBfpU49os9WTtZMHdpKKy1LM
         oHS7QHSYzAPSEhgKP5TiQSXARGrnmtTVFg6DSZF9XUM98RBmxcAotwI7Un7DOt+1eBU0
         fXe3o+TClSvRTSlr8cZZLjkjccJnVsl4QlRC+fFySw2FomwZAS7Z3k7nRzTygigE2Dd6
         Z46Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVFyQryLzQwn5bZs0b4wuoLLAp61L/j6riLFEPnwbHhYACWVuusnhwgn4PzTbzS3bWxGL44AmwUqDb6/5VdDm8mypUtpX3uPtPMIOk
X-Gm-Message-State: AOJu0Yz+ob6jX9bVjcPH7aaVSHXp6FpnKuCZ0FcNGKNSM9N3lQ5alIPb
	QllfhPpZwb+vCgfpzrob5g+AS0ZFRKTzjhF2Bc/paOUlEFLCsFa86AEvfUK/1lzpvT4SZ4yvMzg
	d
X-Google-Smtp-Source: AGHT+IF+E+/3DgPwa1Lg2IViJVPRe7oEh2Sr4rYrG3IKW/bfa70oHSZuv0/JhCOxsXVvsdHNrhm1Gw==
X-Received: by 2002:a2e:3308:0:b0:2db:a7c7:5d11 with SMTP id d8-20020a2e3308000000b002dba7c75d11mr926288ljc.47.1713950881340;
        Wed, 24 Apr 2024 02:28:01 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u2-20020a2e8442000000b002d8744903ebsm1916849ljh.68.2024.04.24.02.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:28:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 12:27:59 +0300
Subject: [PATCH v7 3/6] soc: qcom: pdr: extract PDR message marshalling
 data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-qcom-pd-mapper-v7-3-05f7fc646e0f@linaro.org>
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
In-Reply-To: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Xilin Wu <wuxilin123@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21841;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=v570ahBWF8ORIfZM6BH0hIA1GZMDcQxNJqsiqERo9kw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmKNCdpOUuqL2nBjaAAH48juxLybSZr6wQFp63C
 hgx8pGoTxKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZijQnQAKCRCLPIo+Aiko
 1SC6CAClPv9e2kapIZKvwE5ErS1Qxb7lUvVtnURhtxlvwsafysiM/pW2zro8C61bHj35hKLKi9l
 nztJeY4gXNWtN1zWfjHLe7sXH2YP+aA6cjjYl6xlrJ8OuMKl3Dm9eMl89GzctkTS1tpEhB1K8Sh
 V+aFSRx5xezz4/V2tekuE/L4U9nJI40xXBlR00VzBX7RdRgcWLedAW6Lvdq7XLuCQNV/ibb6Nx/
 cYY/f0a2Mt/EeM6Qoy6bfsqacVWqmx95YNc+/M2CX2CE4gRn6ODqqv/CuyJ05LA9EVlybjAIXJH
 B3Wm+v8Ubv6kBPF/jB/nfrdi/+bJyjbRmPknEF3CcWW+KNyO
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The in-kernel PD mapper is going to use same message structures as the
QCOM_PDR_HELPERS module. Extract message marshalling data to separate
module that can be used by both PDR helpers and by PD mapper.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/Kconfig        |   4 +
 drivers/soc/qcom/Makefile       |   1 +
 drivers/soc/qcom/pdr_internal.h | 306 ++------------------------------------
 drivers/soc/qcom/qcom_pdr_msg.c | 319 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+), 296 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 5af33b0e3470..95973c6b828f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -75,8 +75,12 @@ config QCOM_OCMEM
 config QCOM_PDR_HELPERS
 	tristate
 	select QCOM_QMI_HELPERS
+	select QCOM_PDR_MSG
 	depends on NET
 
+config QCOM_PDR_MSG
+	tristate
+
 config QCOM_PMIC_PDCHARGER_ULOG
 	tristate "Qualcomm PMIC PDCharger ULOG driver"
 	depends on RPMSG
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ca0bece0dfff..3110ac3288bc 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
 obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
+obj-$(CONFIG_QCOM_PDR_MSG)	+= qcom_pdr_msg.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
 obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
diff --git a/drivers/soc/qcom/pdr_internal.h b/drivers/soc/qcom/pdr_internal.h
index 03c282b7f17e..7e5bb5a95275 100644
--- a/drivers/soc/qcom/pdr_internal.h
+++ b/drivers/soc/qcom/pdr_internal.h
@@ -28,83 +28,12 @@ struct servreg_location_entry {
 	u32 instance;
 };
 
-static const struct qmi_elem_info servreg_location_entry_ei[] = {
-	{
-		.data_type      = QMI_STRING,
-		.elem_len       = SERVREG_NAME_LENGTH + 1,
-		.elem_size      = sizeof(char),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0,
-		.offset         = offsetof(struct servreg_location_entry,
-					   name),
-	},
-	{
-		.data_type      = QMI_UNSIGNED_4_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u32),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0,
-		.offset         = offsetof(struct servreg_location_entry,
-					   instance),
-	},
-	{
-		.data_type      = QMI_UNSIGNED_1_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0,
-		.offset         = offsetof(struct servreg_location_entry,
-					   service_data_valid),
-	},
-	{
-		.data_type      = QMI_UNSIGNED_4_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u32),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0,
-		.offset         = offsetof(struct servreg_location_entry,
-					   service_data),
-	},
-	{}
-};
-
 struct servreg_get_domain_list_req {
 	char service_name[SERVREG_NAME_LENGTH + 1];
 	u8 domain_offset_valid;
 	u32 domain_offset;
 };
 
-static const struct qmi_elem_info servreg_get_domain_list_req_ei[] = {
-	{
-		.data_type      = QMI_STRING,
-		.elem_len       = SERVREG_NAME_LENGTH + 1,
-		.elem_size      = sizeof(char),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x01,
-		.offset         = offsetof(struct servreg_get_domain_list_req,
-					   service_name),
-	},
-	{
-		.data_type      = QMI_OPT_FLAG,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x10,
-		.offset         = offsetof(struct servreg_get_domain_list_req,
-					   domain_offset_valid),
-	},
-	{
-		.data_type      = QMI_UNSIGNED_4_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u32),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x10,
-		.offset         = offsetof(struct servreg_get_domain_list_req,
-					   domain_offset),
-	},
-	{}
-};
-
 struct servreg_get_domain_list_resp {
 	struct qmi_response_type_v01 resp;
 	u8 total_domains_valid;
@@ -116,264 +45,49 @@ struct servreg_get_domain_list_resp {
 	struct servreg_location_entry domain_list[SERVREG_DOMAIN_LIST_LENGTH];
 };
 
-static const struct qmi_elem_info servreg_get_domain_list_resp_ei[] = {
-	{
-		.data_type      = QMI_STRUCT,
-		.elem_len       = 1,
-		.elem_size      = sizeof(struct qmi_response_type_v01),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct servreg_get_domain_list_resp,
-					   resp),
-		.ei_array      = qmi_response_type_v01_ei,
-	},
-	{
-		.data_type      = QMI_OPT_FLAG,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x10,
-		.offset         = offsetof(struct servreg_get_domain_list_resp,
-					   total_domains_valid),
-	},
-	{
-		.data_type      = QMI_UNSIGNED_2_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u16),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x10,
-		.offset         = offsetof(struct servreg_get_domain_list_resp,
-					   total_domains),
-	},
-	{
-		.data_type      = QMI_OPT_FLAG,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x11,
-		.offset         = offsetof(struct servreg_get_domain_list_resp,
-					   db_rev_count_valid),
-	},
-	{
-		.data_type      = QMI_UNSIGNED_2_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u16),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x11,
-		.offset         = offsetof(struct servreg_get_domain_list_resp,
-					   db_rev_count),
-	},
-	{
-		.data_type      = QMI_OPT_FLAG,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x12,
-		.offset         = offsetof(struct servreg_get_domain_list_resp,
-					   domain_list_valid),
-	},
-	{
-		.data_type      = QMI_DATA_LEN,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x12,
-		.offset         = offsetof(struct servreg_get_domain_list_resp,
-					   domain_list_len),
-	},
-	{
-		.data_type      = QMI_STRUCT,
-		.elem_len       = SERVREG_DOMAIN_LIST_LENGTH,
-		.elem_size      = sizeof(struct servreg_location_entry),
-		.array_type	= VAR_LEN_ARRAY,
-		.tlv_type       = 0x12,
-		.offset         = offsetof(struct servreg_get_domain_list_resp,
-					   domain_list),
-		.ei_array      = servreg_location_entry_ei,
-	},
-	{}
-};
-
 struct servreg_register_listener_req {
 	u8 enable;
 	char service_path[SERVREG_NAME_LENGTH + 1];
 };
 
-static const struct qmi_elem_info servreg_register_listener_req_ei[] = {
-	{
-		.data_type      = QMI_UNSIGNED_1_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x01,
-		.offset         = offsetof(struct servreg_register_listener_req,
-					   enable),
-	},
-	{
-		.data_type      = QMI_STRING,
-		.elem_len       = SERVREG_NAME_LENGTH + 1,
-		.elem_size      = sizeof(char),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct servreg_register_listener_req,
-					   service_path),
-	},
-	{}
-};
-
 struct servreg_register_listener_resp {
 	struct qmi_response_type_v01 resp;
 	u8 curr_state_valid;
 	enum servreg_service_state curr_state;
 };
 
-static const struct qmi_elem_info servreg_register_listener_resp_ei[] = {
-	{
-		.data_type      = QMI_STRUCT,
-		.elem_len       = 1,
-		.elem_size      = sizeof(struct qmi_response_type_v01),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct servreg_register_listener_resp,
-					   resp),
-		.ei_array      = qmi_response_type_v01_ei,
-	},
-	{
-		.data_type      = QMI_OPT_FLAG,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u8),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x10,
-		.offset         = offsetof(struct servreg_register_listener_resp,
-					   curr_state_valid),
-	},
-	{
-		.data_type      = QMI_SIGNED_4_BYTE_ENUM,
-		.elem_len       = 1,
-		.elem_size      = sizeof(enum servreg_service_state),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x10,
-		.offset         = offsetof(struct servreg_register_listener_resp,
-					   curr_state),
-	},
-	{}
-};
-
 struct servreg_restart_pd_req {
 	char service_path[SERVREG_NAME_LENGTH + 1];
 };
 
-static const struct qmi_elem_info servreg_restart_pd_req_ei[] = {
-	{
-		.data_type      = QMI_STRING,
-		.elem_len       = SERVREG_NAME_LENGTH + 1,
-		.elem_size      = sizeof(char),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x01,
-		.offset         = offsetof(struct servreg_restart_pd_req,
-					   service_path),
-	},
-	{}
-};
-
 struct servreg_restart_pd_resp {
 	struct qmi_response_type_v01 resp;
 };
 
-static const struct qmi_elem_info servreg_restart_pd_resp_ei[] = {
-	{
-		.data_type      = QMI_STRUCT,
-		.elem_len       = 1,
-		.elem_size      = sizeof(struct qmi_response_type_v01),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct servreg_restart_pd_resp,
-					   resp),
-		.ei_array      = qmi_response_type_v01_ei,
-	},
-	{}
-};
-
 struct servreg_state_updated_ind {
 	enum servreg_service_state curr_state;
 	char service_path[SERVREG_NAME_LENGTH + 1];
 	u16 transaction_id;
 };
 
-static const struct qmi_elem_info servreg_state_updated_ind_ei[] = {
-	{
-		.data_type      = QMI_SIGNED_4_BYTE_ENUM,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u32),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x01,
-		.offset         = offsetof(struct servreg_state_updated_ind,
-					   curr_state),
-	},
-	{
-		.data_type      = QMI_STRING,
-		.elem_len       = SERVREG_NAME_LENGTH + 1,
-		.elem_size      = sizeof(char),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct servreg_state_updated_ind,
-					   service_path),
-	},
-	{
-		.data_type      = QMI_UNSIGNED_2_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u16),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x03,
-		.offset         = offsetof(struct servreg_state_updated_ind,
-					   transaction_id),
-	},
-	{}
-};
-
 struct servreg_set_ack_req {
 	char service_path[SERVREG_NAME_LENGTH + 1];
 	u16 transaction_id;
 };
 
-static const struct qmi_elem_info servreg_set_ack_req_ei[] = {
-	{
-		.data_type      = QMI_STRING,
-		.elem_len       = SERVREG_NAME_LENGTH + 1,
-		.elem_size      = sizeof(char),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x01,
-		.offset         = offsetof(struct servreg_set_ack_req,
-					   service_path),
-	},
-	{
-		.data_type      = QMI_UNSIGNED_2_BYTE,
-		.elem_len       = 1,
-		.elem_size      = sizeof(u16),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct servreg_set_ack_req,
-					   transaction_id),
-	},
-	{}
-};
-
 struct servreg_set_ack_resp {
 	struct qmi_response_type_v01 resp;
 };
 
-static const struct qmi_elem_info servreg_set_ack_resp_ei[] = {
-	{
-		.data_type      = QMI_STRUCT,
-		.elem_len       = 1,
-		.elem_size      = sizeof(struct qmi_response_type_v01),
-		.array_type	= NO_ARRAY,
-		.tlv_type       = 0x02,
-		.offset         = offsetof(struct servreg_set_ack_resp,
-					   resp),
-		.ei_array       = qmi_response_type_v01_ei,
-	},
-	{}
-};
+extern const struct qmi_elem_info servreg_location_entry_ei[];
+extern const struct qmi_elem_info servreg_get_domain_list_req_ei[];
+extern const struct qmi_elem_info servreg_get_domain_list_resp_ei[];
+extern const struct qmi_elem_info servreg_register_listener_req_ei[];
+extern const struct qmi_elem_info servreg_register_listener_resp_ei[];
+extern const struct qmi_elem_info servreg_restart_pd_req_ei[];
+extern const struct qmi_elem_info servreg_restart_pd_resp_ei[];
+extern const struct qmi_elem_info servreg_state_updated_ind_ei[];
+extern const struct qmi_elem_info servreg_set_ack_req_ei[];
+extern const struct qmi_elem_info servreg_set_ack_resp_ei[];
 
 #endif
diff --git a/drivers/soc/qcom/qcom_pdr_msg.c b/drivers/soc/qcom/qcom_pdr_msg.c
new file mode 100644
index 000000000000..9b46f42aa146
--- /dev/null
+++ b/drivers/soc/qcom/qcom_pdr_msg.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/soc/qcom/qmi.h>
+
+#include "pdr_internal.h"
+
+const struct qmi_elem_info servreg_location_entry_ei[] = {
+	{
+		.data_type      = QMI_STRING,
+		.elem_len       = SERVREG_NAME_LENGTH + 1,
+		.elem_size      = sizeof(char),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0,
+		.offset         = offsetof(struct servreg_location_entry,
+					   name),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_4_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0,
+		.offset         = offsetof(struct servreg_location_entry,
+					   instance),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0,
+		.offset         = offsetof(struct servreg_location_entry,
+					   service_data_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_4_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0,
+		.offset         = offsetof(struct servreg_location_entry,
+					   service_data),
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_location_entry_ei);
+
+const struct qmi_elem_info servreg_get_domain_list_req_ei[] = {
+	{
+		.data_type      = QMI_STRING,
+		.elem_len       = SERVREG_NAME_LENGTH + 1,
+		.elem_size      = sizeof(char),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(struct servreg_get_domain_list_req,
+					   service_name),
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(struct servreg_get_domain_list_req,
+					   domain_offset_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_4_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(struct servreg_get_domain_list_req,
+					   domain_offset),
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_get_domain_list_req_ei);
+
+const struct qmi_elem_info servreg_get_domain_list_resp_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct servreg_get_domain_list_resp,
+					   resp),
+		.ei_array      = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(struct servreg_get_domain_list_resp,
+					   total_domains_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_2_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(struct servreg_get_domain_list_resp,
+					   total_domains),
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x11,
+		.offset         = offsetof(struct servreg_get_domain_list_resp,
+					   db_rev_count_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_2_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x11,
+		.offset         = offsetof(struct servreg_get_domain_list_resp,
+					   db_rev_count),
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x12,
+		.offset         = offsetof(struct servreg_get_domain_list_resp,
+					   domain_list_valid),
+	},
+	{
+		.data_type      = QMI_DATA_LEN,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x12,
+		.offset         = offsetof(struct servreg_get_domain_list_resp,
+					   domain_list_len),
+	},
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = SERVREG_DOMAIN_LIST_LENGTH,
+		.elem_size      = sizeof(struct servreg_location_entry),
+		.array_type	= VAR_LEN_ARRAY,
+		.tlv_type       = 0x12,
+		.offset         = offsetof(struct servreg_get_domain_list_resp,
+					   domain_list),
+		.ei_array      = servreg_location_entry_ei,
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_get_domain_list_resp_ei);
+
+const struct qmi_elem_info servreg_register_listener_req_ei[] = {
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(struct servreg_register_listener_req,
+					   enable),
+	},
+	{
+		.data_type      = QMI_STRING,
+		.elem_len       = SERVREG_NAME_LENGTH + 1,
+		.elem_size      = sizeof(char),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct servreg_register_listener_req,
+					   service_path),
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_register_listener_req_ei);
+
+const struct qmi_elem_info servreg_register_listener_resp_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct servreg_register_listener_resp,
+					   resp),
+		.ei_array      = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(struct servreg_register_listener_resp,
+					   curr_state_valid),
+	},
+	{
+		.data_type      = QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len       = 1,
+		.elem_size      = sizeof(enum servreg_service_state),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x10,
+		.offset         = offsetof(struct servreg_register_listener_resp,
+					   curr_state),
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_register_listener_resp_ei);
+
+const struct qmi_elem_info servreg_restart_pd_req_ei[] = {
+	{
+		.data_type      = QMI_STRING,
+		.elem_len       = SERVREG_NAME_LENGTH + 1,
+		.elem_size      = sizeof(char),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(struct servreg_restart_pd_req,
+					   service_path),
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_restart_pd_req_ei);
+
+const struct qmi_elem_info servreg_restart_pd_resp_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct servreg_restart_pd_resp,
+					   resp),
+		.ei_array      = qmi_response_type_v01_ei,
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_restart_pd_resp_ei);
+
+const struct qmi_elem_info servreg_state_updated_ind_ei[] = {
+	{
+		.data_type      = QMI_SIGNED_4_BYTE_ENUM,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(struct servreg_state_updated_ind,
+					   curr_state),
+	},
+	{
+		.data_type      = QMI_STRING,
+		.elem_len       = SERVREG_NAME_LENGTH + 1,
+		.elem_size      = sizeof(char),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct servreg_state_updated_ind,
+					   service_path),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_2_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x03,
+		.offset         = offsetof(struct servreg_state_updated_ind,
+					   transaction_id),
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_state_updated_ind_ei);
+
+const struct qmi_elem_info servreg_set_ack_req_ei[] = {
+	{
+		.data_type      = QMI_STRING,
+		.elem_len       = SERVREG_NAME_LENGTH + 1,
+		.elem_size      = sizeof(char),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x01,
+		.offset         = offsetof(struct servreg_set_ack_req,
+					   service_path),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_2_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u16),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct servreg_set_ack_req,
+					   transaction_id),
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_set_ack_req_ei);
+
+const struct qmi_elem_info servreg_set_ack_resp_ei[] = {
+	{
+		.data_type      = QMI_STRUCT,
+		.elem_len       = 1,
+		.elem_size      = sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type       = 0x02,
+		.offset         = offsetof(struct servreg_set_ack_resp,
+					   resp),
+		.ei_array       = qmi_response_type_v01_ei,
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(servreg_set_ack_resp_ei);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm Protection Domain messages data");

-- 
2.39.2


