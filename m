Return-Path: <linux-kernel+bounces-29039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D11830764
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19761F21559
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124420312;
	Wed, 17 Jan 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mXDOWHo6"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDC20305;
	Wed, 17 Jan 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499754; cv=none; b=IOGB+sr8zBBA96NAV0pYaPr5xUCdY4Qwb4COKgv/glKL07hpwb2rUOePoAIU0nY7rEsE8nFshxXrRhHtV+RfymEvm0dhahmyXNcm9UZIvxaYp2x0KsZmovovxnJe9lSWjPmJjw1wh1tXDlPc+/y7XSQ7fB8fFaHGON5EgPgmLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499754; c=relaxed/simple;
	bh=GsqhlpdhWhB+O3t+KRVPzN0GaF3NCrHNcXrzTf4mJjI=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-Proofpoint-Virus-Version; b=P30OclOx3Zp7oxqNk2t4SthjdBkFkehAxJmvZFCyNnH5RJuF+02nq5UmHXGEfNAK6W4wgBcmRt13S6P8BlxF+k4EZyPTpmc4x7EKNaqTXFoQ+LAVhVkyIeUBToUjqwidGNUSxHtIdk6R7lqhTprDJBz4ZyScidahZV8+5Ag7LpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mXDOWHo6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HC280B007800;
	Wed, 17 Jan 2024 14:55:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=M2X/FpQf8mi8ZCzUv8CpYHdo19t7D3Nj47u0BhM65mc=; b=mX
	DOWHo6ljERJEO47xY8A8b/FLGq1wdX7fJ1WoBQLc45DG2rqpAfiMH3oQYA4tIaDH
	mSgA4wta8uXdrMrorsVJV47OpZXS0X3aiG8AD6h/+jVycGCD1kXZBn+dJtTlsRK7
	fzAmgKq6KZQi3TMh7SyouKQu8o6zh4Q5a9HGwqP3AC05Z4FFDMr4OfUJRdmFSy18
	OLNP+ZBt6qgKmHOMskxapcAu0t4qECLt3Xy118Di2RU6z5nw0aupjxvu9Qk9bkJC
	sA3D9lxpnncIM6a5mtPnFDVDvHOEXZNMrkyobeyrps4g4JSzTlvj9Fo3DUAqkNsS
	kFhGkaYToSZKbf87DeyQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmde3v37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 14:55:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57E20100079;
	Wed, 17 Jan 2024 14:55:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4F71D209EE0;
	Wed, 17 Jan 2024 14:55:43 +0100 (CET)
Received: from localhost (10.252.22.63) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 17 Jan
 2024 14:55:42 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH 2/2] remoteproc: stm32: Fix incorrect type assignment returned by stm32_rproc_get_loaded_rsc_tablef
Date: Wed, 17 Jan 2024 14:53:12 +0100
Message-ID: <20240117135312.3381936-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117135312.3381936-1-arnaud.pouliquen@foss.st.com>
References: <20240117135312.3381936-1-arnaud.pouliquen@foss.st.com>
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
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

The sparse tool complains about the remove of the _iomem attribute.

stm32_rproc.c:660:17: warning: cast removes address space '__iomem' of expression

Add '__force' to explicitly specify that the cast is intentional.
This conversion is necessary to cast to addresses pointer,
which are then managed by the remoteproc core as a pointer to a
resource_table structure.

Fixes: 8a471396d21c ("remoteproc: stm32: Move resource table setup to rproc_ops")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2c28635219eb..10b442c6f632 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -657,7 +657,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 	 * entire area by overwriting it with the initial values stored in rproc->clean_table.
 	 */
 	*table_sz = RSC_TBL_SIZE;
-	return (struct resource_table *)ddata->rsc_va;
+	return (__force struct resource_table *)ddata->rsc_va;
 }
 
 static const struct rproc_ops st_rproc_ops = {
-- 
2.25.1


