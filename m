Return-Path: <linux-kernel+bounces-149154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08BA8A8C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BDC284BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673C52F85;
	Wed, 17 Apr 2024 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIBTyTy8"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE444C8B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384190; cv=none; b=um8FuIlrBZTtcybV+FjUaP01FQSeoOw2Zv1FjvvqBjf+jzpeDkW5Av0M+olN8OJ1iYUTA8XWK9WiGVnILJ8yw8eh49SAieosVkFd3+SBOfqlbfl8dtw2+Sm1tOfWxWdq806GJWcxVdEDJVPzPGKX2woRnuczXROI5izulfnj1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384190; c=relaxed/simple;
	bh=9J7bTJW6Z2MeNhnVPByhcl4m6t24a8dv3hQEs4RW/1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNIyPKk9qe/QYEgH+VIcryJEsToTlKTzG0Zc2bLc+C9Djr09kjp0YXvJWQdLIvoeHfGz665poibAXjVknOxTdDTj6sv7O6DpkzqQkGtYyMaa7vPrnlYegoHquYHC9THShgmTSIP6jCg4TmhMOLJ41iF8Ph7Kw8yY12F97tNKlIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EIBTyTy8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a55323f2ef9so2777566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384187; x=1713988987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV6J30CfPASoymdIFYzV0/TP7ddiAe5RpBl3EgHS6Xs=;
        b=EIBTyTy8vlNq3dUgwpcSf6H+ieLISL1DtlR4v+jfF9o00XGT+LPhJxjEcA72N8zh3/
         VilD/csQLEkSXvaMr+hJycDAw+H2tx6XqeuP7sVOdvrok6dIf7LhKuJ7qAzsWEOooTzv
         8qoAtYtRjEF6yYp3/dEOYqJLzctCvQG5pEJ2/jZ0EnHE7tXqL7ckib5EhkiMJpseQjnl
         5/m8BmKnByfimogTc38lgmqWygqMhc4unOaRNXgVXTS/9AT3WTF82K9cwcodJ4lsNxvG
         VewT+aV0mGM8dyo5PJ2WEBsypRs2Le570tjE6DkE9tEHD3RJEyEYyQ0dvYh3KvK5gGto
         W+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384187; x=1713988987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV6J30CfPASoymdIFYzV0/TP7ddiAe5RpBl3EgHS6Xs=;
        b=luL6mKDMchPf7i9fSNmJOMIfzB0d0Y7m6v3nB0w/dbKjRFoPIko5ItosQAzTMry+hf
         0ZXWp/l1IlSh/hz/xOFx/0FeJVVi+KrKHL26zjbyuhmzIPOHtNqW720VZ+kK0m9DOlfE
         FQoFJeDvwcxrbgF5yo6Gr0Tp2gClDumpqgYwO8m+3A8TvCqeECq9mCdqcwnU0+em8W8G
         dvLR4DsbOUGhLIr1n4DxTSKB/DfgF29iBj1COIIV1TFBRRCtglPmozoR+MqHcfyq0TL1
         2igsZaNP7C/FqnWGSvkLEeonIi4+84GytRn1xWKkEx4Q18xGt8MMfy8GrAT60OZu41wu
         vV9w==
X-Forwarded-Encrypted: i=1; AJvYcCWdsAP4Njl9aRNpXNfTS77IqK8m2SWjpR6trE2pT6hLmiemlLVrvA7e0E+9OxNm80r3bqJHKoqx+r2zvBs+/3/igryhgN/Piqxvisx6
X-Gm-Message-State: AOJu0Yz7h3PrbBOI0bTpUkLJRb8diEZeTMiZZBZQ8VMqhkTRsMjPDEdD
	gpsKsqOUObjQkf0JDQ2mwjfn81yv6HX8fwzI8ClCAIE9nyE32p2ByENALS358FAtphbSrMzK030
	H
X-Google-Smtp-Source: AGHT+IEE4rTTfC2fS5MHSJv6KjEvvVOGWI1pShDXOcYNXGfN81YBcLHlG9LDzJPJpVmh0BPlqwuEww==
X-Received: by 2002:a17:907:10c3:b0:a55:5c04:89a4 with SMTP id rv3-20020a17090710c300b00a555c0489a4mr334635ejb.21.1713384187494;
        Wed, 17 Apr 2024 13:03:07 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170906fd8400b00a5252e69c7dsm5905590ejb.160.2024.04.17.13.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:03:07 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 17 Apr 2024 22:02:54 +0200
Subject: [PATCH v2 2/7] soc: qcom: smem: Add a feature code getter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-topic-smem_speedbin-v2-2-c84f820b7e5b@linaro.org>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
In-Reply-To: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384181; l=3440;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9J7bTJW6Z2MeNhnVPByhcl4m6t24a8dv3hQEs4RW/1Q=;
 b=4u/Mox1Q9N+V2KjoOOEjCZhuqpOUYbZD0oDyrWik5Dmyg03vy2l1Q8Y0YqOLyj0NsQdNoc2OR
 RXZWLV7bdp3CPY7/5IZlWwlKkSrH2MKosezQc/9nA71wDribMonE9+u
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Recent (SM8550+ ish) Qualcomm SoCs have a new mechanism for precisely
identifying the specific SKU and the precise speed bin (in the general
meaning of this word, anyway): a pair of values called Product Code
and Feature Code.

Based on this information, we can deduce the available frequencies for
things such as Adreno. In the case of Adreno specifically, Pcode is
useless for non-prototype SoCs.

Introduce a getter for the feature code and export it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/smem.c          | 33 +++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/smem.h    |  1 +
 include/linux/soc/qcom/socinfo.h | 26 ++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7191fa0c087f..29e708789eec 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -795,6 +795,39 @@ int qcom_smem_get_soc_id(u32 *id)
 }
 EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
 
+/**
+ * qcom_smem_get_feature_code() - return the feature code
+ * @code: On success, return the feature code here.
+ *
+ * Look up the feature code identifier from SMEM and return it.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int qcom_smem_get_feature_code(u32 *code)
+{
+	struct socinfo *info;
+	u32 raw_code;
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	/* This only makes sense for socinfo >= 16 */
+	if (__le32_to_cpu(info->fmt) < SOCINFO_VERSION(0, 16))
+		return -EOPNOTSUPP;
+
+	raw_code = __le32_to_cpu(info->feature_code);
+
+	/* Ensure the value makes sense */
+	if (raw_code >= SOCINFO_FC_INT_MAX)
+		raw_code = SOCINFO_FC_UNKNOWN;
+
+	*code = raw_code;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_get_feature_code);
+
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
 	struct smem_header *header;
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index a36a3b9d4929..0943bf419e11 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -13,5 +13,6 @@ int qcom_smem_get_free_space(unsigned host);
 phys_addr_t qcom_smem_virt_to_phys(void *p);
 
 int qcom_smem_get_soc_id(u32 *id);
+int qcom_smem_get_feature_code(u32 *code);
 
 #endif
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index 10e0a4c287f4..52439f48428f 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -3,6 +3,8 @@
 #ifndef __QCOM_SOCINFO_H__
 #define __QCOM_SOCINFO_H__
 
+#include <linux/types.h>
+
 /*
  * SMEM item id, used to acquire handles to respective
  * SMEM region.
@@ -82,4 +84,28 @@ struct socinfo {
 	__le32 boot_core;
 };
 
+/* Internal feature codes */
+enum qcom_socinfo_feature_code {
+	/* External feature codes */
+	SOCINFO_FC_UNKNOWN = 0x0,
+	SOCINFO_FC_AA,
+	SOCINFO_FC_AB,
+	SOCINFO_FC_AC,
+	SOCINFO_FC_AD,
+	SOCINFO_FC_AE,
+	SOCINFO_FC_AF,
+	SOCINFO_FC_AG,
+	SOCINFO_FC_AH,
+};
+
+/* Internal feature codes */
+/* Valid values: 0 <= n <= 0xf */
+#define SOCINFO_FC_Yn(n)		(0xf1 + n)
+#define SOCINFO_FC_INT_MAX		SOCINFO_FC_Yn(0x10)
+
+/* Product codes */
+#define SOCINFO_PC_UNKNOWN		0
+#define SOCINFO_PCn(n)			(n + 1)
+#define SOCINFO_PC_RESERVE		(BIT(31) - 1)
+
 #endif

-- 
2.44.0


