Return-Path: <linux-kernel+bounces-88249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C6086DF2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770B9B23717
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4FB6BB2A;
	Fri,  1 Mar 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zZNq4TqU"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71723BD;
	Fri,  1 Mar 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288796; cv=none; b=FgnZogja+q0Or+mf6iXAjpvwahHEKF1ixxlGZER75OBsf1J+dO9nOpxDmZRBWEO/9SxmpUdWNsFkBiv3oq9ffhiEhURA3n1Vr90F6fQ7A0wdrJu7FAyR3cZ1aWd29umzO4FtglB0/840KmsiFZSvbfgFv+8GyqS1GtP3PYBYrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288796; c=relaxed/simple;
	bh=jokYsqyurEXFxDPkRxZFI7C9kQPmyFxJWzMmRh4UsNU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z6V7dVUPuhIlmhK2WDbuML8ydxfUUFg7B+LMFdRZAFBFAN637JHeRn2vWX5Rj1WYWRScNHKIhZaDh9JkHwErw+DnkB3McNXOcXkub5R6EQZjp2dHktIDPOGEkbBAXco+2UHL5156t34xaEokvJF4awnUxCe0TZZRn4qdGcuwbNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zZNq4TqU; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4219345a021497;
	Fri, 1 Mar 2024 11:26:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=vp6qVxJ
	487N75yXFKor9ARqDlZLKEE+aQ/uMZChldUI=; b=zZNq4TqUD3suEztwQFse5rO
	dyMvyXT4S5CPRCUwHnw3aAybLz3LdveJbu0AKfZWtLnXGWmga6A5CVXjExA7zFZ7
	IIa9bLZahnWkwoFABBsEwmAH3Nm88Z1+b4tq4OABLc+M+fjSjwEmF4xYX6s/gCqj
	hm9BP/vOs7/xAADaRPBdfOqa6IzguLHLgptQbqg6Vqr8PmgJg/hd3Ho/P1g4suMm
	lMJQvy1n3troKACRd2vGqEuFspPnICLiSskCJpzmYuz8PbXEt+vmSwjheFST9CXU
	LmRsOutuRpxsa6Xlbe0W0LQ9/z4do0NQW35d9R1gHnkN55MiPmeqMPQIWg61/rw=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4bqdtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 11:26:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 80BE640046;
	Fri,  1 Mar 2024 11:26:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A80AA244B60;
	Fri,  1 Mar 2024 11:25:31 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Mar
 2024 11:25:30 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <syednwaris@gmail.com>, <vigneshr@ti.com>, <jpanis@baylibre.com>,
        <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Date: Fri, 1 Mar 2024 11:25:05 +0100
Message-ID: <20240301102505.591918-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 definitions=2024-03-01_08,2024-03-01_01,2023-05-22_02

Now that there are two users for the "frequency" extension, introduce a
new COUNTER_COMP_FREQUENCY() macro.
This extension is intended to be a read-only signal attribute.

Suggested-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v5
- "frequency" extension is read-only, so there's no need to provide
  a write parameter.
- patch sent separately from "counter: Add stm32 timer events support" [1]
[1] https://lore.kernel.org/lkml/20240227173803.53906-2-fabrice.gasnier@foss.st.com/
---
 include/linux/counter.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index 702e9108bbb4..0ac36f815b7d 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -602,6 +602,13 @@ struct counter_array {
 #define COUNTER_COMP_FLOOR(_read, _write) \
 	COUNTER_COMP_COUNT_U64("floor", _read, _write)
 
+#define COUNTER_COMP_FREQUENCY(_read) \
+{ \
+	.type = COUNTER_COMP_U64, \
+	.name = "frequency", \
+	.signal_u64_read = (_read), \
+}
+
 #define COUNTER_COMP_POLARITY(_read, _write, _available) \
 { \
 	.type = COUNTER_COMP_SIGNAL_POLARITY, \
-- 
2.25.1


