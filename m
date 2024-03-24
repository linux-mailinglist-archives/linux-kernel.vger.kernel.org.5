Return-Path: <linux-kernel+bounces-115363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85498893BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4692C1F2F397
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DF6161928;
	Mon, 25 Mar 2024 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDww2BRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0501D7918;
	Sun, 24 Mar 2024 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320604; cv=none; b=lQeAIgkSVKelaO/n79fzTkfbQyhDgAfE80nQ/DQ2BL/yZTEIGAv4FLqHlzXuzzeotU+YoxCwf2MLFhZYDgMtiS33/Rl2zwZUHRGKcw3NyrJL5dYG5/SKi+Oxzv3O7Or1azAl5kaiq2+7K/S2/+8aMx4lSJQXsWeFUsxJGO7fzMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320604; c=relaxed/simple;
	bh=8MlMsUXIAxi6EcUwJc1rCgwDpDQjngCF1q1kRo/oFOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADVl93y207ipuA2kSIGdQOClEb8N9kM9RpLMJwpT1CqbmIANyvba3uIZcTMVkcDbMHPwgBSqVZ+qdX9VkFRCYOJ70HX4p/FAOOPmP1pSIDWoikwKGSEKqPMU10kCxnEz7GR5eQxQRMEg02iHyWrK09knbRjNSEbkXlofPrMcf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDww2BRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D582C43394;
	Sun, 24 Mar 2024 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320604;
	bh=8MlMsUXIAxi6EcUwJc1rCgwDpDQjngCF1q1kRo/oFOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDww2BREgxb2ozVb/XZ4R/gf/170rUj0K9zm9fZUv7+ImXPBUtPFII5thrklfWBAV
	 fs1Fdj7c/v54hgCFji6WZFjJLYrtQM5LANNtSloHTW4AUZBcEU3UR0YAmTnMUVdHwP
	 FCGKaqGVsnAre+0yNYRUMZDn1sTnZ3CfY2aoAQ6OimvTcfmlGTpK+9QlaSYAh75nCD
	 c4RzohHehnJjH2IJBdXI7fwboR/H92u46UeLJ3codrvJVisnXiyv/qFRyCdxkyI3bQ
	 O9uM2d7FW+71jehf7DwcilGNjBM7Xo2KzurGXhoI+vJgSz7hb+jAuL9rfdVmltFOeq
	 wxBNpJBE2NPZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 165/713] soc: qcom: socinfo: rename PM2250 to PM4125
Date: Sun, 24 Mar 2024 18:38:11 -0400
Message-ID: <20240324224720.1345309-166-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 51e05bec5bfce..9865964cf6dbf 100644
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
 	[69] = "PM8550VS",
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


