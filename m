Return-Path: <linux-kernel+bounces-95600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2487500C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EBF1C2319D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA212D216;
	Thu,  7 Mar 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ECYeziOE"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856412C7F8;
	Thu,  7 Mar 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818458; cv=none; b=OXSccccUBPQUJkOFAs8zHV8cw3qBJjgxWkWmc2Fz0XNfWyTUHTNk3jJsgHSKy2p+7k/yAK1XOz91sgitt43nuBrYvj0iLRtpeVyqsElV4DmWt6D1u6jVKNH2oOzyGsO1BU9ILySjpZplFr2PgoDmt37EIKQE5nSMw0bjbkzreRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818458; c=relaxed/simple;
	bh=aUwIXIB6ikWepNt71w+3eWpZLF7KACsXFdv8w1LK8cA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I55to3gFl6bzCM6+ZFO2xh3ACiYic4/f5UZ288J8p5KF0GWDfwdNPPHrXIHNkxPzVoYYWrX+m9YWA8MdP57/THXuPl+TzQLpcZQExrWBIF8mUM0ZmodHc/9JcRfji+bBpax6H0Fxgfbrcn9fp1ckVnpe4XOdYh+37q43FGSG+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ECYeziOE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4279x8Ip028743;
	Thu, 7 Mar 2024 14:33:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=KVmmLD7PqCyPnZ/PZVStmvG794iivG5lxhLDKuQv7fY=; b=EC
	YeziOEokGPyOWKIxhtMqAfstauOVpnhqYlaWTTn6MVTnuBo2X90ymsLNUCDuq0HN
	CFiBXayp8/ZaClI764+zseFWuyRCsDRyPFPFQeAB7zk3kMDQ1NIQ4wkAYNIEiz/F
	GBjFSM/lGfKG+k4iT0gUOwWnEBbMA9zgjLFwXLwp3ekEyocd8KkWWnb8SzHhGbxI
	k9+piNaB/rgHQ+TL5wD5mvY8jCqmHW5xPPgUmSc/NZhosVcAyrvMmKOoe+/tKQ1h
	F5wZxTd70y1T67OisPNwYrGiGUCN77zdA6RBvOKHtIW0dVh72qfszgdoDhy9/V5M
	DnvaRNupZsYyrgEw9qmQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wn87tt1by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 14:33:55 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BFF1640047;
	Thu,  7 Mar 2024 14:33:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2DE7C27A500;
	Thu,  7 Mar 2024 14:33:27 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 14:33:26 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 02/10] counter: stm32-timer-cnt: rename counter
Date: Thu, 7 Mar 2024 14:32:58 +0100
Message-ID: <20240307133306.383045-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
References: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
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
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02

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


