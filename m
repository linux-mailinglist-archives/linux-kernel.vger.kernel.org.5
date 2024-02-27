Return-Path: <linux-kernel+bounces-83744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C4869DED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD401F240D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71224E1CE;
	Tue, 27 Feb 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FeXVongi"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B54EB4E;
	Tue, 27 Feb 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055559; cv=none; b=NebuMyaQhuUJIqUUXxqaZSVWp3dKifZeD9+ChibmkyA3wv1ZHI7TtmGG+41z7N7xFlI2W1C7wJxAE+n+7U/w6OTdZJefsDCk5xM2yRsEaeCKmStcolHa3+DDhAr0MooaaluTFEYtGitlKYuEf5irZJhZKG5MV1TpT11eU9wdkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055559; c=relaxed/simple;
	bh=aUwIXIB6ikWepNt71w+3eWpZLF7KACsXFdv8w1LK8cA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzqOv6WD2P58gIIXXiAE9hDBTEsgSZuScXFByvSoEPPA6SNLgTMK8Yo8fe/AZg6gMUbFxrrA+st7R06eBd7CF+l9OHc3gBSwhDauBgNfcnMw8zBf5No06Yz3TDEcyQv8DS41Q3sZdJJsc2G5d1gp/ytROll+jMeP7167pK619Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FeXVongi; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBi2YV006717;
	Tue, 27 Feb 2024 18:39:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=KVmmLD7PqCyPnZ/PZVStmvG794iivG5lxhLDKuQv7fY=; b=Fe
	XVongigRGirHWyC2nHFSxyp4XqqxWcS2NJz1A+6ValJD2YK7QmHjukow1hHSmJLa
	o8QcUmmBSzNVy26mD4tKpGitdYvHD0Tnkv4tp98w/RsbBwNPjny8vPAhNnVYSR69
	qnE015eWsg7ONRG2taH96kGJELQ6A1LwFAG6HUpLkgVhLFCr7h+Q5OGXcX2/T9Vg
	DAEFl/+1yQ/7rNzmfog3ZfiR3gKJrg7aArW82UFrecNVt01BaJVq6KfarClTgD1I
	w/crG59UtLAh0QzZEGzISy0AwuHEjmEwmCly3N9p1d19x/Qu/F+dZlmDdQGMsN8G
	PYxjX0xjMBB+741VIRzw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4b9dj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:39:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6BC204002D;
	Tue, 27 Feb 2024 18:38:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 140312AD12E;
	Tue, 27 Feb 2024 18:38:18 +0100 (CET)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:38:17 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/11] counter: stm32-timer-cnt: rename counter
Date: Tue, 27 Feb 2024 18:37:55 +0100
Message-ID: <20240227173803.53906-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02

The STM32 timer may count on various sources or channels. The counter
isn't specifically counting on channe1 1. So rename it to avoid a
confusion.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Add William's Reviewed-by tag
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 36d812ddf162..668e9d1061d3 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -302,7 +302,7 @@ static struct counter_synapse stm32_count_synapses[] = {
 
 static struct counter_count stm32_counts = {
 	.id = 0,
-	.name = "Channel 1 Count",
+	.name = "STM32 Timer Counter",
 	.functions_list = stm32_count_functions,
 	.num_functions = ARRAY_SIZE(stm32_count_functions),
 	.synapses = stm32_count_synapses,
-- 
2.25.1


