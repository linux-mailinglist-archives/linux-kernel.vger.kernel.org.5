Return-Path: <linux-kernel+bounces-139216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D989FFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286322895D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B489E15444B;
	Wed, 10 Apr 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmOmc32d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A715CB;
	Wed, 10 Apr 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774729; cv=none; b=qS4qh1V3W4hhAweCwzbZFs/zmCXQDS9t7I30k+A+3jrGX+3BxcJwTdYC029xftPmNjRRdbMxMdLDhR0XYgqC9nbQNopMOoel91mPzNJfK8oXMNDm5K9HRuOo4qP73Sie3jMmqNDrwmTl9WpLODh6uWHb/zAQKPrXF8POU1zrzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774729; c=relaxed/simple;
	bh=MG11DmFB8Z+iPMvLkOs1xgozpQKxZpBhECkM6V9URB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VxZsg5PBhsSINd9ay31y/FSklXXYWsMdwimCgLneb9I4iOilZr5EBa0oT2VXIFZbXi0k/LQxvtIVstY5XwnNqERo3XP9CFCY/x8bcMvPHJKcfIXSPv/g5rg0qOTF6pbC/C9HvRpO1Het32GNy1DYI9gRN8AOG4o01VKYo+zBpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmOmc32d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB09EC433F1;
	Wed, 10 Apr 2024 18:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712774728;
	bh=MG11DmFB8Z+iPMvLkOs1xgozpQKxZpBhECkM6V9URB0=;
	h=From:To:Cc:Subject:Date:From;
	b=HmOmc32dQYZ3/WUxRUlFcskPlj1sQ4gWcO86cg2Q7ZQg8Z8TbYi8BV8CMUBQxJd/F
	 8Zivyu66kjjwvW+BS20repDvteXCiUYVwr1ZxBky0A9lmQz37T+O8fy1yA0wn+IGVw
	 EbqBP549ZwnStIuh/IWFaguPMcJ0rWvmDi8KPopE6X+UNrYGnvRMHBbvnSXy7NYYrB
	 PjwltUhyjW+ydM5kbgL6v0CTUA9QEFLvAPSrDUlqRXprNrpkqkA0+bLOrigQE8wqn7
	 jq9tHSSILqn6iPt+J9wb1+tNQfu4CBgUgcmVw4GRXBBhw6JLgd5HFiuWlB/zbXvNIN
	 UoBkfd89lj6iw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] soc: qcom: mention intentionally broken module autoloading
Date: Wed, 10 Apr 2024 20:45:22 +0200
Message-Id: <20240410184522.271889-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm PMIC ChargerPD ULOG and RPM Master Statistics drivers are
solely for debugging purposes and should not be autoloaded as modules.
Add comments to annotate missing MODULE_DEVICE_TABLE.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. Rework, drop MODULE_DEVICE_TABLE, add comment.
---
 drivers/soc/qcom/pmic_pdcharger_ulog.c | 4 ++++
 drivers/soc/qcom/rpm_master_stats.c    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.c b/drivers/soc/qcom/pmic_pdcharger_ulog.c
index 238cd38589dc..39f412bbf2c1 100644
--- a/drivers/soc/qcom/pmic_pdcharger_ulog.c
+++ b/drivers/soc/qcom/pmic_pdcharger_ulog.c
@@ -150,6 +150,10 @@ static const struct rpmsg_device_id pmic_pdcharger_ulog_rpmsg_id_match[] = {
 	{ "PMIC_LOGS_ADSP_APPS" },
 	{}
 };
+/*
+ * No MODULE_DEVICE_TABLE intentionally: that's a debugging module, to be
+ * loaded manually only.
+ */
 
 static struct rpmsg_driver pmic_pdcharger_ulog_rpmsg_driver = {
 	.probe = pmic_pdcharger_ulog_rpmsg_probe,
diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
index 9ca13bcf67d3..086fe4ba6707 100644
--- a/drivers/soc/qcom/rpm_master_stats.c
+++ b/drivers/soc/qcom/rpm_master_stats.c
@@ -148,6 +148,10 @@ static const struct of_device_id rpm_master_table[] = {
 	{ .compatible = "qcom,rpm-master-stats" },
 	{ },
 };
+/*
+ * No MODULE_DEVICE_TABLE intentionally: that's a debugging module, to be
+ * loaded manually only.
+ */
 
 static struct platform_driver master_stats_driver = {
 	.probe = master_stats_probe,
-- 
2.34.1


