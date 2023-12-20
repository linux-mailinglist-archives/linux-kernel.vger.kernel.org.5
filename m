Return-Path: <linux-kernel+bounces-7095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E2581A19D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA51C240CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30773D995;
	Wed, 20 Dec 2023 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0fffFvbE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106F3E460;
	Wed, 20 Dec 2023 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BKEBau8025826;
	Wed, 20 Dec 2023 15:57:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=su2Pq6yXzJ+By01elmOLMUH+D+u4lMRIHEYBe4cjT9E=; b=0f
	ffFvbESOaHOL7itMtJxoKAtLCkR179P7KSvvH1t1hnF+By3KkbeDKUT1obhC2Tvv
	DcbU81pGJDdLlF/1HerK1ne+Z9/eBNRgb4pW99yxF+SPcoetClOcCwL8WbJuYESV
	tPQ+4fLAfH5ErRMWkOlbWNxa9RxNT6m+TWA3dSLDsPYs1poRQhmzcRNYHRqFMmm1
	B2f9RD2pagzIXmMXb8Ofv5q+gh4R7ycdomCQXjOxBoJw2ivYINz+ibCdPfLhgDw/
	/B0l8cxWrxK3otDWrdCUhu56q3Wvd7ceQx54lcikC3wR31dghhBo2adn+KYj2T9j
	eo8YOK3A1oMFHWSZjLuA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v3q80u4d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 15:57:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26FF8100057;
	Wed, 20 Dec 2023 15:57:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1DF8621B512;
	Wed, 20 Dec 2023 15:57:58 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 15:57:55 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/10] counter: stm32-timer-cnt: rename counter
Date: Wed, 20 Dec 2023 15:57:18 +0100
Message-ID: <20231220145726.640627-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_08,2023-12-20_01,2023-05-22_02

The STM32 timer may count on various sources or channels. The counter
isn't specifically counting on channe1 1. So rename it to avoid a
confusion.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
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


