Return-Path: <linux-kernel+bounces-145302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0A78A5252
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A85B24275
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9F78C79;
	Mon, 15 Apr 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="x0oSHiJe"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC477A03;
	Mon, 15 Apr 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189116; cv=none; b=udJzqhQCCrgW695pAQHkzwWGWUNRkEC/h8bqpppFkrRce6/5A0R3MCyS6Lyr5Xj0iNa1c3EnsMwE7YalAk3QiQShKeB2MsXyb4iA2+g+zRELUvTFVhs8vS4OfiUYl5/5Sdhkp7Vft2v0f2nFQiKSDCbtIcjF+8z4VX5m3xwhSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189116; c=relaxed/simple;
	bh=KIYrUxY+b9z+lxbDqbvGLtVKWQfYAVPg7QIHFhflyJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TohTi8hwmRW/3cFmoXl/HttxbCwgXq4W/UtJU5jgzxUeRft4z+tuCnl5Cqs6Ozp/QxxWokLSIx6jo8vZdBSmreyD0sT/03g4aE9YMU9gqMShZgU+Mmem9xpr2/k/3ePHUD+H15IPw726ofwd9NRJ4qP/PRzuSCUtulnZMZ/J5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=x0oSHiJe; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FCaK9X024860;
	Mon, 15 Apr 2024 15:51:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=QsaD5br63QiPS08LMVeUwl+S5bVO25sOLw/LZKdTl/A=; b=x0
	oSHiJeqXIs3PRk1PrWgxXuE7GK5B2Oaxehn8+qOYrTP/Ky8/SzviaJsHFpZeo+zT
	rKkY3NDbQpSaYoM0em8tPc5OzraNHjH36wnLa/QGaQi0bIY0byai48cTP+j8cIg4
	ljE7MZANslFx9kZyBWlLqc1/z0gpWdSrtU/qeSsfXY2K42264g0EavBfz4h8vVc8
	mh8lNglZez/JOzfq/yLCT/ml3T/+rFv7s/ADb7WNVb3Qadh7WM1UTIkA/sTMsuaW
	zEUQhT/bVmXt5ZLzhzOHfq1+E7dTXUJcjDzwR1TsmDFVavzymHJd4mLK481nhZN+
	2YV/wB/alkniXGhV5Rdg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff647xnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:51:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 52A4140044;
	Mon, 15 Apr 2024 15:51:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2706421660B;
	Mon, 15 Apr 2024 15:50:50 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:50:49 +0200
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
Subject: [PATCH v2 07/11] arm64: Kconfig.platforms: Enable STM32_EXTI for ARCH_STM32
Date: Mon, 15 Apr 2024 15:49:22 +0200
Message-ID: <20240415134926.1254428-8-antonio.borneo@foss.st.com>
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

ARCH_STM32 needs to use STM32 EXTI interrupt controller for GPIO
and wakeup interrupts.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 24335565bad56..19bf58a9d5e1b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -302,6 +302,7 @@ config ARCH_STM32
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_STM32MP257
+	select STM32_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
 	select COMMON_CLK_SCMI
-- 
2.34.1


