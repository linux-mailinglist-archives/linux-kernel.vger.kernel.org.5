Return-Path: <linux-kernel+bounces-62034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DA6851AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E08D1C21E00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085D3F9F5;
	Mon, 12 Feb 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xp/8UMxS"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5853D579
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757380; cv=none; b=j+oV+FimRpYGzRJotSH68wNfm8wKqCq9EEDyFCpIdcApJ4qeh3oh/LazeDSbp88ak7J4OCMOmfNrLc4babCQoBtHn9l/iJQPCP9trRp2gkbWRGU24v4PxaoR7dfiwrU4ElZx2agyPIWQ53XU3GvZacNSJsU4a6u09MWgxzUn9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757380; c=relaxed/simple;
	bh=KYbfcSCObq9Y7TWbsBt1X4vUh7ieGGCaQrtS25nOIKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0jrdKEJfVo9evhMk0QjPsNzNkkfAbd91+v0E1SNmFo/aiQ2AhV9IFP3pzRcb7oDKJVxky8cQLPCB8XWdmbgqxS1MPW3Z0fwlnaAoubUA4S2mbZ6qCqPveTUuiUBan0/pqzCjXcvJWUzX6vxA8+v+C9jq8ZB1rDtPIqV4iwbihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xp/8UMxS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so5066856a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757377; x=1708362177; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzBgpfFit+87YhLNiV85KS1arSw6rjj+6NBv4OlIr7s=;
        b=Xp/8UMxSi0pdIGPESVP8v7BhHfAN6pwrmrkLWAmDPbjDYol1UA029ZZA/RcuXIzlAP
         whdaWPDMbE59vApZRX7cwGldGWFlLo8U1+uoV10X0xHjoKo14XaxxXFOUcJhj955wOpa
         qWhbtgA3gQIdzuNa8HJ8xWxJqu5Ss/hSqBjPyxZn/3zq7aIlI81mzVg2pu52M34GXGzA
         +KF0idprO6v9Bz+1jVg7lXDSELMPYnlbtVurknjejshW7T4jJTWOhm76pCucjbUJM+3X
         vOH2oEJ6egN4P7Pp4ozbWKsZOvQgsB+pkt3RPKxw0Gktx/bCEfqjIsrBl045t1lzyPS6
         rU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757377; x=1708362177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzBgpfFit+87YhLNiV85KS1arSw6rjj+6NBv4OlIr7s=;
        b=nye8eYWFbxRBZ/4E56XNT/c30YuuHjJ8kfEpOkpdGOmwJ7XaByLTqi3Xn8OPOSl0Ax
         m44gQDHZ0FKvIBKDCQ6KETWeKljNa53Aj8XYPMR1OKT6ru2r4Xdt3+3XAYkngERduPpZ
         RHjSauD2l5EdAr7Qq1Dit2PTAtV6/a4gvKuo5bu4Ir5SHptC66zmTJS/ZH/CErw1tkV4
         qzXcLQajjp00jT2R9xvAql2VyI78qjWmPFBGcODGhpUgWzLFb8IUFyUu/D+Wi9wAZbE4
         aCt0MdxPSqrRetQuIAtLuxZbsZAzeMD3gOZwzT7FBRDWTpNf49Cm2vJa50a9AGzb6z8F
         pCnA==
X-Forwarded-Encrypted: i=1; AJvYcCX7q4D5GkG8WfLeAIp/6u1n5ZX1pc+L3NGGvEY3eVyuuoubJEtQeAG47MUvSl/Rv1ZECg4nuQjSlw8cwd/laBUq+zbq6qdptzdvR/+K
X-Gm-Message-State: AOJu0Yx0jOgByjjWsfjLGAe1imZYu/ZCaZRnSY13ZXyUrNmhcAlsszXn
	DVmdX8ZSbqwHwFx94c2lhiVv6Gkx5+A0bNdRwJS7dIhJ7bmG1fRGEJEwkC0iGec=
X-Google-Smtp-Source: AGHT+IHa4jR6TElh6E4GUFNdVvbg2RFBB3k+KwmuZowq3Ev03MT/YjERFfeyWxB2Mhaf3WhtNGA7ww==
X-Received: by 2002:a17:906:5002:b0:a38:45fc:1f01 with SMTP id s2-20020a170906500200b00a3845fc1f01mr4799708ejj.45.1707757377152;
        Mon, 12 Feb 2024 09:02:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCe0+hF+inQus/Rc8nTATr1d5w+Tc3H+Q65e8rOpHKOW7rz55IlR/lDuhOXBi4bzlJuaVwgif6eLZWBIQA2z0Y6K6CeI9r940uDKCEsFHDZmIcgX0wNR15bBxav1VJvbAuOgxFXrWAytYkL6wajO6e1RE00+V1twS8jcMYG+Hg+sbrpjWuIdz11hXxjlGsc+wHHI92kx+SaCtPnCrvnUwHpTPWx8jtsmdBM3mzsGy38cRoZsJw+j7tytVHRwCLPzUfzmDzGfLmxPpFrAywoVESAJJrej0jYMxT0aQRR0PipvWHfHTOSMaCAHEvUTSZPtijeF1fhwVfLoTJrxHfzlu64rkNMbzC1Oj9x4jKZepU8cp8XvoZwe1MMf4iBGhe6McVnJoBSVc5ljMDobyfTqJgZOoJTwvcByckL9fGwzhnYo78fHug379ghw1ECmovX6W4PZrsxQIaVOvWLrwrxHLFgnPY39tWnANUTWhAEw==
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906261700b00a3c9951edf1sm379600ejc.115.2024.02.12.09.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:02:56 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 12 Feb 2024 19:02:44 +0200
Subject: [PATCH v2 3/3] remoteproc: qcom_q6v5_pas: Unload lite firmware on
 ADSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-x1e80100-remoteproc-v2-3-604614367f38@linaro.org>
References: <20240212-x1e80100-remoteproc-v2-0-604614367f38@linaro.org>
In-Reply-To: <20240212-x1e80100-remoteproc-v2-0-604614367f38@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=pK64jih4vFPFZcmgDeFClY35f13oGGe3b+xiPwzQtC0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlyk86letr6BgkGNok75q8FkQqp+5XwcEzKCPlo
 e5Fn/1UnDCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZcpPOgAKCRAbX0TJAJUV
 VhmLD/9D2yaRbOyfC+DrEoSDGVOiC9PAQg/srH+JDUAuuDxUgEHUC0/wQQEvB4ict4/mds0bv+w
 gwuiwSBssen0pdFkeqTWpFx36dpN1+J7h8ZUtMhCrQ8aJMxy1PK9Ph3T9RZm6Nlp0tVY6drg2oO
 rQsWfJgN3CoaLxmmCkmfw9oIVDBWPrcwGCnfi3eZTssXt0VFENEOTwnNCrhBq4XW2h+Szg5AuKf
 WQJUrronakABCgX5kXCXO8Ej9AvVcqPNizovIKnzd+IkY23WH6521veTxeZOY075TW1odA8a3zT
 GxZaDJDyQiQ5s7vlne2XAlgdnRWR5CrWHTPTtmyyTRqjcF+NNor8QeTSpt2qoW88O9eLu0b0hDq
 DhdgB+b17hMx7vWbblCPCwLwSyRzoI5GJGRAW32aadNtFnCMsMvs4MkH3IB9XIoUNPw9YXSSine
 1FzjCFuNWIXC6AMRtQJ6pycgKiCOij5IiGHlyFo+JGrTozr45a8IA16H5SGoAVE9xRQeizufpWi
 6wKgKV5xdikwzBxXnyL+ybhL1WP70LYrskuRc8DuM+BH0TMbz4EF3qvupe11ru7HX1EyeiR5Ck2
 naVt1Be5de9fuRSUimpOOyMvtfRhUbk7F71fz4Mx1enizlU7/p49JCjxah/hbwfIU4B3ycAZB1t
 WCJM92K3yw1d2PQ==
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
 drivers/remoteproc/qcom_q6v5_pas.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 117fdfdfbc26..581ae5e570e8 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -41,6 +41,7 @@ struct adsp_data {
 	const char *dtb_firmware_name;
 	int pas_id;
 	int dtb_pas_id;
+	int lite_pas_id;
 	unsigned int minidump_id;
 	bool auto_boot;
 	bool decrypt_shutdown;
@@ -77,6 +78,7 @@ struct qcom_adsp {
 	const char *dtb_firmware_name;
 	int pas_id;
 	int dtb_pas_id;
+	int lite_pas_id;
 	unsigned int minidump_id;
 	int crash_reason_smem;
 	bool decrypt_shutdown;
@@ -218,6 +220,9 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	/* Store firmware handle to be used in adsp_start() */
 	adsp->firmware = fw;
 
+	if (adsp->lite_pas_id)
+		ret = qcom_scm_pas_shutdown(adsp->lite_pas_id);
+
 	if (adsp->dtb_pas_id) {
 		ret = request_firmware(&adsp->dtb_firmware, adsp->dtb_firmware_name, adsp->dev);
 		if (ret) {
@@ -720,6 +725,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->rproc = rproc;
 	adsp->minidump_id = desc->minidump_id;
 	adsp->pas_id = desc->pas_id;
+	adsp->lite_pas_id = desc->lite_pas_id;
 	adsp->info_name = desc->sysmon_name;
 	adsp->decrypt_shutdown = desc->decrypt_shutdown;
 	adsp->region_assign_idx = desc->region_assign_idx;
@@ -1020,6 +1026,7 @@ static const struct adsp_data x1e80100_adsp_resource = {
 	.dtb_firmware_name = "adsp_dtb.mdt",
 	.pas_id = 1,
 	.dtb_pas_id = 0x24,
+	.lite_pas_id = 0x1f,
 	.minidump_id = 5,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){

-- 
2.34.1


