Return-Path: <linux-kernel+bounces-83748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B892C869E72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1FAB2869C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5CD4CB20;
	Tue, 27 Feb 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mzR1Ciu5"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50291487DC;
	Tue, 27 Feb 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055564; cv=none; b=U9CyiDBYu2LJLkYqr3Al8sew2q/TANoWSbsATVtu8a4W1KnT6DLr+nzy0b4GYsl6/c75H6k8BPMLL+QXp57MJZTK/YyvoIic3rBBjn5ERkGg/LEO6xySbjRIlx1sVyZftrsB4GJ893TXfADkNxQ2W3pK+moBrBg9Y35JnfJSCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055564; c=relaxed/simple;
	bh=8I2LJfjIfxxKwHLODKbe7ZdonemobuyLfJmot6PYhGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4fFfSxsM4hhB8FU+Y4CtziZ2hTqz2u5ifp6phZ9N84XuEVYLGud0WGoIhhryzgLGlj458ZfI4GhvXWuJM7TjgQGpD6Npg0hVPELLtC1vxODSKOzcaOOnShr45f620krZt95aQOaY7BKPChGIcBjgu22Jk4vAxo+tYEE/J9KvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mzR1Ciu5; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBi2OZ029666;
	Tue, 27 Feb 2024 18:38:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=vJldcTa3fZJ+W5cK/vrvMKnfUz/AWmcz3zq1p3k7gUo=; b=mz
	R1Ciu59N9MZiKesA/ud4/Se2eEr5pMXEDx0BlligdUEfBmzk/4iCTGDoizS7DH9p
	mCBIf/JE5Lgehp0dk9RZipzw1sz7OeEcNaQ0nASrWGq6CkKjketjfgcB1B9mNBIR
	H7e5e3DqXJrdd3nl2yvcHV8onYnvd0jj2b8AM74C/tTUWlHF3DumoBXW7NZ47+Ij
	lGvEkMnt8XYPzfnDLZGJDD69OkRAWaRjTAtgbnxcQrJM2Yarvdqz2/mDUwPP5WPr
	BodgS9CSum/YTOoozS4eKiAXfg26I5tj5JJNxC9oHxwMrSpumIb1JNbLc3Zg5j2q
	RPUkioxPVvDOR+JDca9Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4b9d71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:38:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6C0E040046;
	Tue, 27 Feb 2024 18:38:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 00D762AD12A;
	Tue, 27 Feb 2024 18:38:17 +0100 (CET)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:38:16 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 01/11] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Date: Tue, 27 Feb 2024 18:37:53 +0100
Message-ID: <20240227173803.53906-2-fabrice.gasnier@foss.st.com>
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
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02

Now that there are two users for the "frequency" extension, introduce a
new COUNTER_COMP_FREQUENCY() macro.

Suggested-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 include/linux/counter.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index 702e9108bbb4..03472d7407de 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -602,6 +602,9 @@ struct counter_array {
 #define COUNTER_COMP_FLOOR(_read, _write) \
 	COUNTER_COMP_COUNT_U64("floor", _read, _write)
 
+#define COUNTER_COMP_FREQUENCY(_read, _write) \
+	COUNTER_COMP_SIGNAL_U64("frequency", _read, _write)
+
 #define COUNTER_COMP_POLARITY(_read, _write, _available) \
 { \
 	.type = COUNTER_COMP_SIGNAL_POLARITY, \
-- 
2.25.1


