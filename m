Return-Path: <linux-kernel+bounces-160021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F65A8B37DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CBAB235E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A3147C66;
	Fri, 26 Apr 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JiA16M8U"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16B146D47;
	Fri, 26 Apr 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136533; cv=none; b=oxBPGI/9BQQXWI+2cE/dFAYkzXYVf8j4bhXY9rfeWvBzuy2uWK+tIyzTa46wJjBq7pin3s2zd+x/xHq9BtIPLc114ROdmb+0Wr64Bnmb5zaH9Sjq4XbYrz6B2uZg3VXMfV6YyFpi2lBmZr+8CBu9/kez8arQpwnnIs1tEHnNaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136533; c=relaxed/simple;
	bh=QZ1jVNYFCjB2s44u+LZOvrIyLKhTU/k/vuakYy5vPmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVoIFQ1M8tURk4d9AatPLLwERGuFoAqylDAyCZy6UbCRWe6YyN/2LqfoHlJnDkAP05zsMLOJgL053GS/1EN6GAgoc9WVogfwSf55mLvGx42+RcK8/6jLXKIYhcQwlnK/ed9q24DN9qGwieSnqZqwIp5U/2ZfmzHbI0cr6Vj1zFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JiA16M8U; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q9HsU5029966;
	Fri, 26 Apr 2024 15:01:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=q2kYHv8uYrF72tA2YfB8ZxbNq7F2BQFGQbxWsGzIXLo=; b=Ji
	A16M8UpHE9m/J0dGGQuoWk9L+f8T59Bh52Pb4DddBUAVngRhF7V369TtugJ9QPSY
	hqzCbsEhBXsYuIqdBEeirQhe+/wwE+WchpsriSiorRoCcP0LMj4TyQVdO20iZrOu
	FDiJ1+H9O/MM+V4/AXeP37Zu59sKuYLWLXzeXlFAy7ABa3n6BJzEasGU3W9IHi7n
	LbbxAJ/Y/15QJPIAIqAW6ZZWV5IWHcJjsRJCPfkGTqrqJgRsayhS3mNVgJzLNlAu
	eLI5P0s+630bInuLm4RqrRIG3c6kBzXZrV7yRHsEIVeOoDMcWeQU7bwvsflW+B61
	fDDVYexZ7HgPn+SKHwBg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmrnjfk2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 15:01:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D0CC240044;
	Fri, 26 Apr 2024 15:01:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3D15222CB2;
	Fri, 26 Apr 2024 15:00:31 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 15:00:31 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/11] ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support
Date: Fri, 26 Apr 2024 14:57:07 +0200
Message-ID: <20240426125707.585269-12-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426125707.585269-1-christophe.roullier@foss.st.com>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

Need to enable MCP23S08 I/O expanders to manage Ethernet phy
reset in STM32MP135F-DK board
STMMAC driver defer is not silent, need to put this config in
built-in to avoid huge of Ethernet messages

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b2955dcb5a53..0abbe00372df 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -469,6 +469,7 @@ CONFIG_SPI_XILINX=y
 CONFIG_SPI_SPIDEV=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_AS3722=y
+CONFIG_PINCTRL_MCP23S08=y
 CONFIG_PINCTRL_MICROCHIP_SGPIO=y
 CONFIG_PINCTRL_OCELOT=y
 CONFIG_PINCTRL_PALMAS=y
-- 
2.25.1


