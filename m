Return-Path: <linux-kernel+bounces-164878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7076D8B8461
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1100E1F23C81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A3612E4D;
	Wed,  1 May 2024 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY1lm9tD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117F10A03;
	Wed,  1 May 2024 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714530494; cv=none; b=XRcWnj/YX8QDgZFSo449Q4rJTkrmRfr/Itp35hl0PYHTp0cl9gxf6rrgOcGoEGwunNfHDD2z4OG6OOqr+bxvA2Qj2YITFPwjjJkpaxti6G9WNIbWbRORILGtgzeuOCQjJGNXMqUolRSyl2j4U9fSARk4MmzZzo5LZVExdpSpPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714530494; c=relaxed/simple;
	bh=G5naWNCxDJ0afeVPqJ5DnKzT7LM4bzo5IsRWVf8tIEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XcfhQH+LKq+HSbkCPFkDRV80iGUO84CT1CrvTeYVgiBn7A32zqmboNzhTNLYhRbbRqRi7WkV0zAucGOEv1L9lfNNRHGjzFFJ9Ng1J6YnFCJJ8/nxl4jTe2DpKptbnNB8D0HZgf6YaIili4GmpIwjhiutbiTh3RKjbQgQp7jJtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY1lm9tD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27003C2BBFC;
	Wed,  1 May 2024 02:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714530493;
	bh=G5naWNCxDJ0afeVPqJ5DnKzT7LM4bzo5IsRWVf8tIEs=;
	h=From:Date:Subject:To:Cc:From;
	b=FY1lm9tDOPRNTT/PPEWl3gcGsGWtf+BQ7vJx+z0kaWRFNUJ1IX0zdKjMrKWD4yBSF
	 AoD92TjmRwIfUAat4xKukuq0xDgtOnMKmjAcsyRpo0OxHZ4PfQ6NJExcnWcu6hi7dq
	 6djL2Yg1CB+pkPShxZSPkbew1NfCgiyUKJnLrMXFRKx5GdNr/w2nmVU3D5luD8xjaq
	 H3lViTCHqzWhwijBb04PAtKbLn9KSEzGQ+Ge536paH24reRQbMDECf1V05AVth8V9Q
	 V7LVWFKleGGrfCXnQBquALknIDIVZ8j/4EDk4G7vKwxvd57GlA/kzaNh9BE0pYZPtz
	 BAKlGxGtLzMFw==
From: Bjorn Andersson <andersson@kernel.org>
Date: Tue, 30 Apr 2024 19:33:12 -0700
Subject: [PATCH] firmware: qcom: uefisecapp: Allow on sc8180x Primus and
 Flex 5G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-uefisecapp-allowlist-sc8180x-v1-1-1a626ea9c5f1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOepMWYC/x3MTQqEMAxA4atI1gbSqiBeZXAR2sxMoGhpxh8Q7
 26Z5QePd4FJUTGYmguK7Gq6LhWubSB8efkIaqwGT76nviPc5K0mgXNGTmk9ktoPLYxupBNJmD3
 HKAM5qItcan3+96/5vh9mTF8rbgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=XbVCDXvcvfgiEaFAg0v+8KBCCPlHK+wbPdKTvD2fiFY=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmMantaAUWYIBw+YZIRuUtFVQfDG1xZPHoX2V6u
 AXWRWu7l3SJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZjGp7RUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUvlRAA1y9voqz/r7HsC52K4I4scitPRgVtyiV0RItnlCe
 GV2GE8mjdKtX7ns3iZiuz401xj/YUuN08Bt1T8usOGaAG3E4Jbvn1mKcMmcXdTqsNAiB8/npKm+
 tlkBa9AdyEwUIT8SNie1wkpGjkpYEZHqmcrHKfO7IDVfhtzipWHloWhipcpVMATcJ6eEMm9WfB9
 J0YwAVn+nFT0sl48XEzjCsnJq0Yath0k2ym3NTrVRIeueTMohF8ztoY62HQ/kuNBtbFSxSVbgmy
 nSIQrYI+bVJmnkJzX76Smzs0RFd1RRGSxEqkJyPYidIT0rSKpwewkxLkCDbqCpkSWnBAROAR0KR
 REVE+qqtNBF5V9RQ+wptoG06fo2utAG47LKfsc3F7eX3m0OHlV0O9WICg12AUYeAgleHdTyfjI/
 WIjyhj45B1rbFWWKpnzk8ZXcPiF4XmU5kICbJhouW0ykeQEpINuiHejbi8PMTMx8a6ccI+h1DMd
 e2YlMOFTUbDrjKXo4XHB0SWQcyck5satxr674r0uHP31aZFTbdSGC6KqEd9P0b9IYBkxHq8yZY6
 ZFwFnTc4w04KeyNY2E3qzsVk4EsPYfBgOt+oBkmzXJ1TLN1AmMRwWEkTGZVYhS89oyihwPGnD8/
 VMVFmWAYKfpA+/hsWqomNdw96rejZ8YuoyM2gBCiMegQ=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

Testing indicates that qseecom and uefisecapp are working on both the
SC8180X Primus and Lenovo Flex 5G, providing EFI variable access.

Add the two to the allow list.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 06e46267161b..68f4df7e6c3c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1646,7 +1646,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
  + any potential issues with this, only allow validated machines for now.
  */
 static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
+	{ .compatible = "lenovo,flex-5g" },
 	{ .compatible = "lenovo,thinkpad-x13s", },
+	{ .compatible = "qcom,sc8180x-primus" },
 	{ }
 };
 

---
base-commit: d04466706db5e241ee026f17b5f920e50dee26b5
change-id: 20240430-uefisecapp-allowlist-sc8180x-0eaa2adde501

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


