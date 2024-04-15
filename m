Return-Path: <linux-kernel+bounces-145292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A077D8A5230
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55953282075
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E057317D;
	Mon, 15 Apr 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="otkQtpZT"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471EE64A90;
	Mon, 15 Apr 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189043; cv=none; b=Bz3dbwLFSGeieBR7MefuekulFNnxpxz3tn+tu/uuy3TaAy81uOt73s5RqT9gPfero0NAN8j7XPQoi1igX3NQStw11se1rNBXgbVypQd7CHcBssDIxpLXDnAmlZRth+9JkfPyDtx4t2jkltn2BFo0ckGa69tZldaBE0UqmTNJDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189043; c=relaxed/simple;
	bh=QZhMRb2CS9yT8tIxxTyT9rmdzh8VBYEjlJA+v56TCJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYYus5l7eB+CNz78fmyWUvYAhlCbX3myaCzGBePicGMesn/78Kb/cyU9BhgaJ5Yzp+NR6Eme3EzsqHUuRdK06VhotiGcaepefiEW1WSEmjqhTpO1tMa6Bxb1Y99aDA8d+oa39u34fVoWfFDxlHUJaP8t8J2BAyz+aRf6Bnu9FEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=otkQtpZT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FCHc16020533;
	Mon, 15 Apr 2024 15:50:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=HrinA/UUFT3hAAA33itcWjQl1PNnCt87DHDPr9ULNcY=; b=ot
	kQtpZThd8yGSd+LgIZIQbTqrFlaVBxt/jAvso4JnOYxizjowKNu9u7MDmISYhQoH
	Ef3MX17CDXNkxGkpVfHDP++vAebtx9+B7AQiBjPIym4DQ6zQ7NfZCKPMz4Bv5S9G
	6oMqfz5aTkyH/PWTcxiDxLjnprmFs8HBLzw8go3gJAHwgxs64dNfbcd/NqvPyV8S
	v5FxcJbdPmm76JzxRXpuSfJkXuWXlsDc/ckh9tuXFWs0gXu3mVlQY/QH20tTbDJ1
	PnwUta+mumpF+shyxD3lyikBDDhLSrl1bRqSOCc6nFiSSwmMZmKLb1WfHTVgzvqy
	kyeEgIuFw/7CrtiAbtGQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m0dt4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:50:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 03E2F40049;
	Mon, 15 Apr 2024 15:50:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F54121862C;
	Mon, 15 Apr 2024 15:49:44 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:49:44 +0200
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
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 01/11] irqchip/stm32-exti: Fix minor indentation issue
Date: Mon, 15 Apr 2024 15:49:16 +0200
Message-ID: <20240415134926.1254428-2-antonio.borneo@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02

Commit 046a6ee2343b ("irqchip: Bulk conversion to
generic_handle_domain_irq()") incorrectly adds a leading space
character in the line indentation.

Use only TAB for indentation, removing the leading space.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 26a5193d0ae41..3b35f138ed3d7 100644
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


