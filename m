Return-Path: <linux-kernel+bounces-112983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7371D888043
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4AC281292
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2A12CDAF;
	Sun, 24 Mar 2024 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqjaj2Vt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267EC46537;
	Sun, 24 Mar 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319796; cv=none; b=kbZOQvfTN5yUmbcZZjW5tfXj8fGOwUfR7b4qwjt7CTfqG/JLTJHnPI1p1lpgTncV6Ay41ddHFakz0dDlap21PqNAG8Gm4+4cNJwqv6P/4eFUdu47pw2sflb7z8W7oA4p+LtbKoAuiR3pQ+P7pKRpN15Lg0OAsmFphB06O8IxKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319796; c=relaxed/simple;
	bh=mYG6uuvygBhyuJATiduM+s95bhxW+Profp/+8aCZrZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj7mbXPNdKAG6Ar5luNCBl+sZpFR4+kyVRS2aYCUNcnniE75h6i/khgeYr3wmSzW+mDOiZVIIASgjfOLCzyXPVp+xTTvCCuoKTl+Cy4EAPuKL1LFyaCvirNa4060xesWfc1YsYVPiuqDnODZw+go0e1uOSYV5brC2Jg9dcEpTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqjaj2Vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA021C433C7;
	Sun, 24 Mar 2024 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319795;
	bh=mYG6uuvygBhyuJATiduM+s95bhxW+Profp/+8aCZrZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gqjaj2VtPVzqfU3bfM6pB6PqjfNk9BfH661EW0eDqbN4HaxEWie/NMbI1k4Ho+Ncs
	 yNmDaUx2DnYasqbY8oF9kurT50mb+brmPe5pCp8RD/XSHZt4GnDH3KOs+by2oegjyz
	 8G7xsW9XSD+xvggPvBYamvCf09+AwBXHuLFs5PJn/wwoHXkA3sBS0/KSEcD4S+U20D
	 Yz88LrkInBSMYZFaKHGqKwbqt/1A16DAwoNMx/0MiO8NgXpNftV+zdg6r3Umqo5lkV
	 bTI43KXafq5jbOBeZNbg6ik9AO4RzPZLaz6NX4lGjV/R6by9mGpb2KMP3n7HCgWYPJ
	 T5EKy9CZKQ1aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 096/715] soc: qcom: socinfo: rename PM2250 to PM4125
Date: Sun, 24 Mar 2024 18:24:35 -0400
Message-ID: <20240324223455.1342824-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 6349a0debeb57..a980020ab854f 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -124,7 +124,7 @@ static const char *const pmic_models[] = {
 	[50] = "PM8350B",
 	[51] = "PMR735A",
 	[52] = "PMR735B",
-	[55] = "PM2250",
+	[55] = "PM4125",
 	[58] = "PM8450",
 	[65] = "PM8010",
 	[69] = "PM8550VS",
diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
index 17a0a8c3d6560..a62d500a6fdaf 100644
--- a/include/soc/qcom/qcom-spmi-pmic.h
+++ b/include/soc/qcom/qcom-spmi-pmic.h
@@ -49,7 +49,7 @@
 #define PMK8350_SUBTYPE		0x2f
 #define PMR735B_SUBTYPE		0x34
 #define PM6350_SUBTYPE		0x36
-#define PM2250_SUBTYPE		0x37
+#define PM4125_SUBTYPE		0x37
 
 #define PMI8998_FAB_ID_SMIC	0x11
 #define PMI8998_FAB_ID_GF	0x30
-- 
2.43.0


