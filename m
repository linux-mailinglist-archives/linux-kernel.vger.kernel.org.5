Return-Path: <linux-kernel+bounces-95601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6D87500D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27C91C23351
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D712D750;
	Thu,  7 Mar 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SvNNScjN"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0012CDBA;
	Thu,  7 Mar 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818459; cv=none; b=Cm2Eg/MNYeDRkl8bdwC4mQb9q6ONzdaBRrFe3BkqgJxo5w2u6Vvhwlp3rJtys/3Os3T8OJYvodAaErYopYM+NUDfUM5u2yW5+oOFtU8yPtcQ3Ba5b8uMQsnzDzTAPXCAdhdfl48UXy6rDBMiCy2lZq8ycuc8RGW1Oj/bgOO5Oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818459; c=relaxed/simple;
	bh=cjKVsaI5PFnr7ib6s7ckHzrRY6Ce3mB9FzsAkpMZ7w4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khk89/kFcAWYjfcB887daz46HIp8UQHgRUrgL0Nsi5yu0igM4O2ED9tSz7tkkELK1oESMMUjjrKD/xgf8/58YVccHv1Y5RSom2AE6jLRhODLqhz/xUDdZsNvaeteNa5YsNx0qhSpjXAK7Wd4XvvvH7Y2PWOJkaQh/rBP6lI7j/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SvNNScjN; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4278eS6t014219;
	Thu, 7 Mar 2024 14:33:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=kzQQUvSZIpaXW+rkulQUdc2Tl/8nBTPY9MRFsPPGhAc=; b=Sv
	NNScjNJVZYPovoLb4Ph0LM6r3ywKcHFMwNmtWPx0XBWiYzhDwo4H6aPnYWMQ4D3N
	7/C5aShMm2t9c3r+JcqC1VXYJPubs+nyHf87SsgEbR32X8F23XD4SeER0Q1J54mU
	eCDSdVjDHDPkJMeV0GjaW4P6uSnx0nWK3Qfs9aJ3cea98U5g0EGHp+CAR9Bj94uT
	sTSzyv89BiWhx7DxsGaV1KSTsHnoMjqatE0+gNgFGOhxT86e1zP1ERVE4EGuJDHz
	7W5vqRMjVbel7k8RR2YtOHF/D5j5o48Fq6jGo/LKIWtTP/ArebqX4AKO3Q5XhzVk
	RKHimuX5Bn+Fq9Bh1ZoA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wktdmggw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 14:33:55 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1627040045;
	Thu,  7 Mar 2024 14:33:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 78BD6279E9C;
	Thu,  7 Mar 2024 14:33:26 +0100 (CET)
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
Subject: [PATCH v5 01/10] counter: stm32-timer-cnt: rename quadrature signal
Date: Thu, 7 Mar 2024 14:32:57 +0100
Message-ID: <20240307133306.383045-2-fabrice.gasnier@foss.st.com>
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

Drop the Quadrature convention in the signal name. On stm32-timer:
- Quadrature A signal corresponds to timer input ch1, hence "Channel 1"
- Quadrature B signal corresponds to timer input ch2, hence "Channel 2".
So name these signals after their channel. I suspect it referred to the
(unique) quadrature counter support earlier, but the physical input
really is CH1/CH2. This will be easier to support other counter modes.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Add William's Reviewed-by tag
Changes in v2:
- Drop the "Quadrature" convention from the signal name, as suggested by
  William
---
 drivers/counter/stm32-timer-cnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 6206d2dc3d47..36d812ddf162 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -279,11 +279,11 @@ static const struct counter_ops stm32_timer_cnt_ops = {
 static struct counter_signal stm32_signals[] = {
 	{
 		.id = 0,
-		.name = "Channel 1 Quadrature A"
+		.name = "Channel 1"
 	},
 	{
 		.id = 1,
-		.name = "Channel 1 Quadrature B"
+		.name = "Channel 2"
 	}
 };
 
-- 
2.25.1


