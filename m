Return-Path: <linux-kernel+bounces-65664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B774B85502D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BFA28F6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D95129A84;
	Wed, 14 Feb 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oXXFiV+5"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25D1272A2;
	Wed, 14 Feb 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931362; cv=none; b=BL/p3EyuDdPhTuySAPKqMJk5/7wtVN6tubs7CltFv8YXxnXg9PpVm2eBwt7V88G6E28+xQkrm/SiAxI96w7oazkbbUAt4kRMThOjmqug2cjJVisE3AoEiE7h6pRq17TCU3WmqBPMfaVyZDYfTd6eHSWeY8hVxwU5jNTipNtLCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931362; c=relaxed/simple;
	bh=8ga+HEE2O98HlzKy35lUTwq3IfvDawkIKEoVuNBe9Bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WieGVTvCrJ+Vnnt9hxz5RqSt62oeTOgOXJsS2g+rpx7ksRTNwoKYi7OVTV7UyM64ZCjPfJ8IwQnjYIJ0mCe/MQpfu+9ZZVVXswBml9u+LtQygt47OBr7Zaf8a8jyftwK1tsp8AIgjEXnNSnmlCtmWYkRTQvTUN6+Psps/ze62cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oXXFiV+5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41ED58rC027428;
	Wed, 14 Feb 2024 18:22:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=qBtgOyq14dsl5L0CUVufOoZV2xCltEiuqjmF3gmRqZM=; b=oX
	XFiV+5xGSmCtA5NmSoHOCaSPaLwTxGxZlFK/YhIO0zQyxjglHU50wBeMRMNORau/
	raLvy48cot9DbKrs6dr3FYyE2K2+k/FVq+x73c3BacEPMvD9EVvrzf5hXKXVgDMA
	Men5H+fpuVa0H6W1uIQaV7EAicfYrKBkx9K0No/FEcNiK16sWfYtKUgXIke4rRUt
	3+5eUpOzItxnBrhMkIoa+OQYQIuYQ0PgDdMny4zZtSsnWzDfZbzbtrhTIdQ4pMaN
	Xku5IPFOYl3+9tFX9Daf7HLPOhwHgMZXvuBgQ2YkG8vTNctbwdy8kielNeBuNJ9l
	j6JScewlezYm2Bk8uXdA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6mynnh06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:22:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5054940048;
	Wed, 14 Feb 2024 18:22:19 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED61A2CA548;
	Wed, 14 Feb 2024 18:21:32 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:32 +0100
Received: from localhost (10.201.20.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:32 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v3 2/7] remoteproc: Extract the firmware load from the start
Date: Wed, 14 Feb 2024 18:21:22 +0100
Message-ID: <20240214172127.1022199-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02

With the introduction of tee_remoteproc, the firmware has to be loaded
first before parsing the resource table. This constraint is linked to
the firmware authentication, that contains the resource table.
In OP-TEE, this authentication is correlated with the load of the
firmware (the loaded segments authenticated after being copied
to the destination memory). Removing rproc_load_segments will allow
it to be called earlier in the boot sequence.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 695cce218e8c..283ca071e35c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1269,13 +1269,6 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	struct device *dev = &rproc->dev;
 	int ret;
 
-	/* load the ELF segments to memory */
-	ret = rproc_load_segments(rproc, fw);
-	if (ret) {
-		dev_err(dev, "Failed to load program segments: %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * The starting device has been given the rproc->cached_table as the
 	 * resource table. The address of the vring along with the other
@@ -1430,6 +1423,13 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		goto clean_up_resources;
 	}
 
+	/* load the ELF segments to memory */
+	ret = rproc_load_segments(rproc, fw);
+	if (ret) {
+		dev_err(dev, "Failed to load program segments: %d\n", ret);
+		return ret;
+	}
+
 	ret = rproc_start(rproc, fw);
 	if (ret)
 		goto clean_up_resources;
@@ -1808,6 +1808,13 @@ static int rproc_boot_recovery(struct rproc *rproc)
 		return ret;
 	}
 
+	/* load the ELF segments to memory */
+	ret = rproc_load_segments(rproc, firmware_p);
+	if (ret) {
+		dev_err(dev, "Failed to load program segments: %d\n", ret);
+		return ret;
+	}
+
 	/* boot the remote processor up again */
 	ret = rproc_start(rproc, firmware_p);
 
-- 
2.25.1


