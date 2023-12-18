Return-Path: <linux-kernel+bounces-3334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CC816B24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A85E1F22F64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08808182C7;
	Mon, 18 Dec 2023 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L45Kmsk6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29114273
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c31f18274so34800305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702895296; x=1703500096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMHQ7FxowXR5FFIdGfBk5jzb/m9p5t8DcpQDDoewRFI=;
        b=L45Kmsk6go84ASzMYFtO/B1ZGpOYaRres4/vkled7tk+2hLJ2bhUpe6lgfzSK78QXo
         Hion2y6FHravOj9bhjdlEVwcBNemn+rVj73MfYrow+bWotHY4B/lFjyJmMx7XK5hiWub
         b3ODzQ8kz1kelcJHzgMX9WFE5gUb6C4XjHXePslCwm5Mp9uUOgB9Mel+vrrLCeKu1W39
         SyAdIxbDxxVBB0SZ0Pta4DojovSmgqo6bQ2l+gVG6eSDixzPh4AZFsFmNeve/H068u+1
         pdI4gtyOn5f9o+yU5VxVaFZAATo7qSwYR6mhyKn61VaX0DpEWPwZzHZGee0L7vZMVsw8
         C70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895296; x=1703500096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMHQ7FxowXR5FFIdGfBk5jzb/m9p5t8DcpQDDoewRFI=;
        b=KRyep09lcZPG6npN93DuyoXxzQH5SH02ZhFh/ipIAgPsMQeQEcxQjyA00jBEAA9yXG
         I6Nhk2U18PiQSuDfE/yKvghhHtF1xD805UWaU63XT+ITo6rqQcSkA1DNdx9cCVxoKRV4
         2dEIe2ZUGSApco7iL8UA7/2slo5cuPXpTxJlNTzsYAZB5tKezqnmL6StjgGn3wzPBmQK
         jdw9tjUYF76JYvz7CENUk1czU20a4cpayuyfVwLDd2eaGbMaOlTuOR/8obcBDc0WLlQ4
         Udl/0GocGyz5n9v4dvjtRdHeoPvy2wq1bZf9ylrxcecIqzaZuin4ghCNYVsYLlh3cAAd
         0BXQ==
X-Gm-Message-State: AOJu0YwXM3llNtk04jROPHWf7+aSx688hNbAk/gZ3il72UMNTNHNPPIY
	6BNU0Mw5Go17zhQ7RgijCbo0jA==
X-Google-Smtp-Source: AGHT+IFNqdVjTsVfqg55j2HNpFNzKNlJ2ojJ/0gzSRJsrU1bgBZJvUCsm0dU6AGb0FSUTSXUYerbtQ==
X-Received: by 2002:a05:600c:30d2:b0:40c:4378:f111 with SMTP id h18-20020a05600c30d200b0040c4378f111mr6666736wmn.80.1702895296475;
        Mon, 18 Dec 2023 02:28:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm41857967wmb.4.2023.12.18.02.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:28:16 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Dec 2023 11:28:11 +0100
Subject: [PATCH v6 3/3] remoteproc: qcom: pas: Add SM8650 remoteproc
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-sm8650-upstream-remoteproc-v6-3-3d16b37f154b@linaro.org>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dRIOpHbtn+6YYLWqsr39smtxV2/mprbkVvuZ9tMTQvg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgB67IsYHxNVpjconBvtj59V1HQ9zeRFPORhCOYk2
 phvMO3yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYAeuwAKCRB33NvayMhJ0f9nD/
 93SMhaFuOPVVU1Er3kqOX598KiaKIl32niAIr2osSGkIxuxenuZvX24Tcn9PztF48p8U6ufxy/O2+0
 +wcC+WtpkpEsjOSgrRBFLQejJwU2ubRcX1IWRaTYsMpb3wY0STsjgAZGkxoZL9ddQlGD1Jyf1011Sx
 68R2ht4e3csATJtSqje0XwoItD1dJlLMzzHOvbh3qEZAcJpDpvV8mfE+1E4d7f1x9un9tl5Bq8MNRE
 jfMmAh788ZSbYVGu5InJnXVoSM4KRWNamYQtD7Qj93HNTqnxGHNcT1ejCiJSvYp9RxfWloazROERD5
 yp3vTin8wWCqtpirSAMbqJGdr7yNz7iFUjMAkdYz4QCZLBtXkznQ8mLYT522yQWHlmYLEH67dcujwr
 SRfeGb7qWBZXWalL7jHbxNT8MjE0uHRso9+9Vfd6FVss9alvX+1esxTnGB1VZaC1XIgZuDmigNaW6Z
 85jCws4ah3yUmuBvRLMZy/zoStmMo/JHF1+Fv3r6vNeC/OAJ0pT6GWfq/6TC9eykVZVI7hXc2FdI0h
 RQaM3dFYk+J+glMhDoVvLRSDZZ4iGDwLL4iz6BsJ1ZlP94E4ET9262Quof01Em1tVT0JaYuURNAk/5
 c1eKxDQ9DsWeF2NgIQtJwQyxipomq8tvG0UGlAF/CMlJU0f6nByYWwHytSNA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add DSP Peripheral Authentication Service support for the SM8650 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index e90783fd1129..f7967a25ecdb 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1213,6 +1213,53 @@ static const struct adsp_data sc7280_wpss_resource = {
 	.ssctl_id = 0x19,
 };
 
+static const struct adsp_data sm8650_cdsp_resource = {
+	.crash_reason_smem = 601,
+	.firmware_name = "cdsp.mdt",
+	.dtb_firmware_name = "cdsp_dtb.mdt",
+	.pas_id = 18,
+	.dtb_pas_id = 0x25,
+	.minidump_id = 7,
+	.auto_boot = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mxc",
+		"nsp",
+		NULL
+	},
+	.load_state = "cdsp",
+	.ssr_name = "cdsp",
+	.sysmon_name = "cdsp",
+	.ssctl_id = 0x17,
+	.region_assign_idx = 2,
+	.region_assign_count = 1,
+	.region_assign_shared = true,
+	.region_assign_vmid = QCOM_SCM_VMID_CDSP,
+};
+
+static const struct adsp_data sm8650_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.dtb_firmware_name = "modem_dtb.mdt",
+	.pas_id = 4,
+	.dtb_pas_id = 0x26,
+	.minidump_id = 3,
+	.auto_boot = false,
+	.decrypt_shutdown = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mss",
+		NULL
+	},
+	.load_state = "modem",
+	.ssr_name = "mpss",
+	.sysmon_name = "modem",
+	.ssctl_id = 0x12,
+	.region_assign_idx = 2,
+	.region_assign_count = 2,
+	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
+};
+
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
@@ -1268,6 +1315,9 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8550-adsp-pas", .data = &sm8550_adsp_resource},
 	{ .compatible = "qcom,sm8550-cdsp-pas", .data = &sm8550_cdsp_resource},
 	{ .compatible = "qcom,sm8550-mpss-pas", .data = &sm8550_mpss_resource},
+	{ .compatible = "qcom,sm8650-adsp-pas", .data = &sm8550_adsp_resource},
+	{ .compatible = "qcom,sm8650-cdsp-pas", .data = &sm8650_cdsp_resource},
+	{ .compatible = "qcom,sm8650-mpss-pas", .data = &sm8650_mpss_resource},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adsp_of_match);

-- 
2.34.1


