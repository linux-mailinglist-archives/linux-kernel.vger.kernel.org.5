Return-Path: <linux-kernel+bounces-129819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F108970B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA2E28781D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C11509BA;
	Wed,  3 Apr 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VujnJ8vf"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D871509B4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150418; cv=none; b=ostMbJsCDwzf1TsNxawHsyOP0O3cn68XFdp1U38Wa2r9x/ecjj3uZecrBa8//3YttWylRjjAYT9HRgs7w6iOJh1z1pqdRi1C7fbQPEiW6HoN+twHJNQh9WeRl/LYfCLgTWFA/dBAl+yCVy7vxyK+B4JxxF9Om7cM2uNWN5W1kYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150418; c=relaxed/simple;
	bh=j+6n+26l0q+cbh2OD40qdoIYeb8lwUxF6fcV5G1Psvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEeYMnmZCkAowhfAq56DfwMhhnDZCfHmTnwT9ikM0+PMuvGLCX53lbXzNaL4hs6CbgC3ZwgdIu5JEHuG/1gdIZ5Tul+Qa4h7ku6+jNs3EZK/jdqPJN7CWco8SR6wwDhoirmVBs1TDv4Xsf09nXsJqL0x3EzrEK3S0nOLAv0CP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VujnJ8vf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so5299752b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712150416; x=1712755216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiJ0rq1wYp29cnToRCHnS5bZk38GY9Yz1Z7mmaTzhfM=;
        b=VujnJ8vfOhzdcih+xDCcWwoX5v5pw1f+2ZWtznP+rhELVZ4lk21fGr6buOnA8/3JT6
         EJpSPzEP0GlFZ6M8d3JFIDf8ogrBhGnXl/W4B+fEbxnNGnAq70KXHWDtzvGNOHBoywcm
         tQYNdZUFE6L9uAN05qlNJ9oKhG7Gm85Bp0FQMkf4haIhOcCMyQXVYy/DXcox7UyWDtA3
         li+Bgau0BmmWcRp9oUCydszoW5oh5AQ30SvAcLIs1lyiW2F0+kEE2CLN4Vioo4usfvfJ
         +TqzpqAHxBV1D7LDGo83NQe6WxJGWkNVO6fMBCw/UjaEYJnnzzYx8fNhqBoAqan0JYZC
         TrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150416; x=1712755216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiJ0rq1wYp29cnToRCHnS5bZk38GY9Yz1Z7mmaTzhfM=;
        b=lIQUBkU+UVyD+uqyueqUw1zgskOLXX53AZy6bzb3zH9jdvT1UoFgU9dNi+UEACBcJp
         83qGlRBKPq6PeO4D9aPt8wSDRXeFGROTrUoA4zdlMgHqOxuJFmeXeRl1eZPxQC1GsR6O
         zciomydvchdS0HtpsCo/dNluA8OuqMACXPJkSOI4ENP5NESi7ajCcQe5E6cQ2fsKa5ei
         JCi0SLB5GAhChrrcG7HUaLZFIZG5lrdWik3we1D4OUqUZx4DHHgbdCUK8Efm6YWJdkbm
         n/7lxw6XFTGa8Pwj/OO2ZLcL1mXA4kvPCPIokonsY+8c0bBlkbRf6FSUQNQ/P80NfqNb
         uolw==
X-Forwarded-Encrypted: i=1; AJvYcCXggWMsXd9FBYfG78nu3pXoglT+RqTAuVJqRLKB8pUNL1XbCaRfgy6HTUIboyMoT6l28xia4f/PreEgkkaVKX0xEHvSTtn/39wku9Am
X-Gm-Message-State: AOJu0YzQl8Cmb/MJTyMJbcaVzUXdVO9G2orCw1PtyuJfW1B7I8lha1oR
	v7po5GSgCoxFAe5I9jJySUnk4eYJY9hccWyvvzQtmrehPGdzC7lPGAGtbsleQiwvUrEsC+H4tHQ
	=
X-Google-Smtp-Source: AGHT+IE7wDcHnJkQ3Esm+caCHVovy19JtL5ItMSOUPXTnLu5fXc7L9qV6s9kjB+LTIyAhZX8T8yxcg==
X-Received: by 2002:a05:6a00:2182:b0:6eb:1d6:6c8c with SMTP id h2-20020a056a00218200b006eb01d66c8cmr9760926pfi.30.1712150415952;
        Wed, 03 Apr 2024 06:20:15 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id r1-20020aa78441000000b006e69a142458sm11640518pfn.213.2024.04.03.06.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:20:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 03 Apr 2024 18:50:03 +0530
Subject: [PATCH v2 1/2] scsi: ufs: qcom: Add missing interconnect bandwidth
 values for Gear 5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-ufs-icc-fix-v2-1-958412a5eb45@linaro.org>
References: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org>
In-Reply-To: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=j+6n+26l0q+cbh2OD40qdoIYeb8lwUxF6fcV5G1Psvs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmDVeJCKwdJUlxk65U7o9cYZS24i3ff7Owd3w8U
 d0xOoojvJ+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZg1XiQAKCRBVnxHm/pHO
 9SpGCACbtNlDcvhflimXP3tOYiQh/JDHWSOo/zU3VL5Wj1OxuGg7HdyL18xxJuK1CGI8O+BoiXZ
 +kau14L3lkLRyAtCEpTMxxQJ7IuyX2RzPAQKn5FAep0EE8gYenRDgDZpZDUiS93mtC/OgDDDTQz
 vh1yFHp2s8CmAGwTw8N9Di1owAjzE6Soiv0YF0fygAikyVXnP6p5xnTYIV3At0aKwPrhamiTe5o
 wwyr2XV+CHPJSQOUO8hZlxPDrcePO8Rbxt0QtsnpYgx2Hg1KScY0EwYB5Am8OQrJHLeZ4EOW+9c
 iJfr4WLtrAjVTIBvzeL7kxxj9OixWFl+vLpAr5D/uhPpMlp5
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

These entries are necessary to scale the interconnect bandwidth while
operating in Gear 5.

Cc: Amit Pundir <amit.pundir@linaro.org>
Fixes: 03ce80a1bb86 ("scsi: ufs: qcom: Add support for scaling interconnects")
Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8d68bd21ae73..696540ca835e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -47,7 +47,7 @@ enum {
 	TSTBUS_MAX,
 };
 
-#define QCOM_UFS_MAX_GEAR 4
+#define QCOM_UFS_MAX_GEAR 5
 #define QCOM_UFS_MAX_LANE 2
 
 enum {
@@ -67,26 +67,32 @@ static const struct __ufs_qcom_bw_table {
 	[MODE_PWM][UFS_PWM_G2][UFS_LANE_1] = { 1844,		1000 },
 	[MODE_PWM][UFS_PWM_G3][UFS_LANE_1] = { 3688,		1000 },
 	[MODE_PWM][UFS_PWM_G4][UFS_LANE_1] = { 7376,		1000 },
+	[MODE_PWM][UFS_PWM_G5][UFS_LANE_1] = { 14752,		1000 },
 	[MODE_PWM][UFS_PWM_G1][UFS_LANE_2] = { 1844,		1000 },
 	[MODE_PWM][UFS_PWM_G2][UFS_LANE_2] = { 3688,		1000 },
 	[MODE_PWM][UFS_PWM_G3][UFS_LANE_2] = { 7376,		1000 },
 	[MODE_PWM][UFS_PWM_G4][UFS_LANE_2] = { 14752,		1000 },
+	[MODE_PWM][UFS_PWM_G5][UFS_LANE_2] = { 29504,		1000 },
 	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_1] = { 127796,		1000 },
 	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_1] = { 255591,		1000 },
 	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
 	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
+	[MODE_HS_RA][UFS_HS_G5][UFS_LANE_1] = { 5836800,	409600 },
 	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_2] = { 255591,		1000 },
 	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_2] = { 511181,		1000 },
 	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
 	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
+	[MODE_HS_RA][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
 	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_1] = { 149422,		1000 },
 	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_1] = { 298189,		1000 },
 	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
 	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
+	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_1] = { 5836800,	409600 },
 	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_2] = { 298189,		1000 },
 	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_2] = { 596378,		1000 },
 	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
 	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
+	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
 	[MODE_MAX][0][0]		    = { 7643136,	307200 },
 };
 

-- 
2.25.1


