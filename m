Return-Path: <linux-kernel+bounces-68357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E8857937
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475F2284247
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB731C298;
	Fri, 16 Feb 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QNroi0dE"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136B1BC2C;
	Fri, 16 Feb 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076973; cv=none; b=gv3KPywD2uuBrmoWjNyKV7DQeNzWQCHXDIqPpngUnelfv52HB+g/kLjhZO7dhQQo+8zlo/xmfwodxH4/UeQH/lY669vemaaHONac42ABSEOa2DEgb5nAgcbvfn2uPbQi7nsvcftzThNzEPUkqEaTp/0Q+0FfiVsrrt7cMbWiSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076973; c=relaxed/simple;
	bh=9GqtczXm1RYdMViDNsks4YoWoxisqfq1uUJ6WTWXheI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuccXl2WEkZ4X/6znzdGs4X1aTs+ipIAoDb7jkd0r00ypg/qnhQ93nIutYuYmFk4d4RMAEpI2mBlKjwyJCym/MbVF13DdQz69WzGf1nDMqn6gp9l6xz6aCjcdc/KNuvAnTgjZnETZznxxLuYfQYj7niIVKt5d5MK4EpUNZanvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QNroi0dE; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4qEBw014621;
	Fri, 16 Feb 2024 10:49:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=faFMPHLHUFEef6pRo0+gjlsQKw/4z5M29dcTxIdWFoo=; b=QN
	roi0dE9l84Wf+oo70n6PUmc/eR2TSrBwoo+EUOWiCuKSBP88EaS99f5N6xSuYMAA
	MLW+aGadoFJt2qsXZrF27+YVR8aqDkug9F168oOnl3xotQ8d8YKXLudBgGdDN8iV
	Bv6LeHWyCPFFdNXbn40Rp132EAMSvQ3PBDAXdldg3vtK8dEDAm1xV4hYBHFZqeYh
	uW3WMevQbNQhi3jUW/s7l35ysBoiZxW+MfkchLN3VwMy26rr9SI8+WsXvcbDyOHo
	VgayKg0kdVMZ0iwcSIDevLLp+cFfBqXE7ikpZPxYtqswb26yRphqug4De7d2isH9
	LimMWR8hJ/9l7DGe2AhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa124gy45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:49:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 430A440046;
	Fri, 16 Feb 2024 10:49:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 99A5C237D74;
	Fri, 16 Feb 2024 10:48:17 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:48:17 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 01/12] irqchip/stm32-exti: Fix minor indentation issue
Date: Fri, 16 Feb 2024 10:47:46 +0100
Message-ID: <20240216094758.916722-2-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216094758.916722-1-antonio.borneo@foss.st.com>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02

Use only TAB for indentation, removing a leading space.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Fixes: 046a6ee2343b ("irqchip: Bulk conversion to generic_handle_domain_irq()")
---
 drivers/irqchip/irq-stm32-exti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 971240e2e31b..69982f21126a 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -322,7 +322,7 @@ static void stm32_irq_handler(struct irq_desc *desc)
 		while ((pending = stm32_exti_pending(gc))) {
 			for_each_set_bit(n, &pending, IRQS_PER_BANK)
 				generic_handle_domain_irq(domain, irq_base + n);
- 		}
+		}
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.34.1


