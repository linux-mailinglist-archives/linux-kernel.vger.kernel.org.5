Return-Path: <linux-kernel+bounces-114119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0C88888D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738BC287D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3C23E40A;
	Sun, 24 Mar 2024 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTOxcwFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00151E7724;
	Sun, 24 Mar 2024 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321424; cv=none; b=CnAwkmtILW0kUe4ItjUlMv63iyLqK0cGkRFOUF9H+zKXRUne6O0G030VTdm6tLVdQveiXvFrI0uKWR3HBbHVJfV6yADW4bam3YrZhe4uVHvmNb7AOxuRzT9KKqN4/13ZjpV8afFX3ikJm3Mr6yJYONd+E4Vn3p/EMTqgW2gc3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321424; c=relaxed/simple;
	bh=UQ/n9Mkbco3R389fzuIFcQ9oMXzvD8ePrXG9uncztZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBJqmUHTdf/QQ/2AC902aIbZnOAw/4R7S+7gBYz5hdbzDFsPbDudDYCbKWefJK5l+px6+6Gdism7sF+ZTXCH/JYITUcQhVCncKxM7WhmeXOatiFTm9VkDzbSYl4zZ57qozR/UuyeoS3ivi2CigZ6l8cbQ4D7gdfU4Ny18jdSf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTOxcwFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E54C433C7;
	Sun, 24 Mar 2024 23:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321423;
	bh=UQ/n9Mkbco3R389fzuIFcQ9oMXzvD8ePrXG9uncztZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTOxcwFDp+NeYF05voAEqIw2UpujyrMxfnHDgPYzd30A0qknD/UdlV003QCGFgrm4
	 p+DZ9dEg2O1EuQ+tQ5rUCrAdFov+/sfSgGq2j4FjaIqv9yo0cw7D3beEKGPDr7oMTa
	 98Z3eZSQZ6ZNwwhGv6vU08IcmC2UMdmeQ3OnQHuQfsArcTVkNAEGapAIe66WfGEwz1
	 P1TxOI5xEReUbMUI4r3lfs9nzlfE5v7GsvasMUs8PpKkgbu1cy/gbr+x+PozYbbC1o
	 pFx72ovVlM2lL1wMSJLWRlFTx5jTWBDB8O9oD7E1/ViJJ6Jaucl5o9nFLJ23ZaKdxX
	 Eb3Bt89tlu+/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 147/638] soc: qcom: socinfo: rename PM2250 to PM4125
Date: Sun, 24 Mar 2024 18:53:04 -0400
Message-ID: <20240324230116.1348576-148-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 5155e48128826d0c5999dc9f47aa746df54da448 ]

It seems, the only actual mentions of PM2250 can be found are related to
the Qualcomm RB1 platform. However even RB1 schematics use PM4125 as a
PMIC name. Rename PM2250 to PM4125 to follow the documentation.

Fixes: 082f9bc60f33 ("soc: qcom: spmi-pmic: add more PMIC SUBTYPE IDs")
Fixes: 112d96fd2927 ("soc: qcom: socinfo: Add some PMICs")
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240128-pm2250-pm4125-rename-v2-1-d51987e9f83a@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/socinfo.c        | 2 +-
 include/soc/qcom/qcom-spmi-pmic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 497cfb720fcb0..880b41a57da01 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -114,7 +114,7 @@ static const char *const pmic_models[] = {
 	[50] = "PM8350B",
 	[51] = "PMR735A",
 	[52] = "PMR735B",
-	[55] = "PM2250",
+	[55] = "PM4125",
 	[58] = "PM8450",
 	[65] = "PM8010",
 };
diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
index c47cc71a999ec..fdd462b295927 100644
--- a/include/soc/qcom/qcom-spmi-pmic.h
+++ b/include/soc/qcom/qcom-spmi-pmic.h
@@ -48,7 +48,7 @@
 #define PMK8350_SUBTYPE		0x2f
 #define PMR735B_SUBTYPE		0x34
 #define PM6350_SUBTYPE		0x36
-#define PM2250_SUBTYPE		0x37
+#define PM4125_SUBTYPE		0x37
 
 #define PMI8998_FAB_ID_SMIC	0x11
 #define PMI8998_FAB_ID_GF	0x30
-- 
2.43.0


