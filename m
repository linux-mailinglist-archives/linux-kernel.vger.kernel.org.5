Return-Path: <linux-kernel+bounces-123039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5389015B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C589A296578
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86212F38D;
	Thu, 28 Mar 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SRXmB4Ss"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1631644C67;
	Thu, 28 Mar 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635029; cv=none; b=XO9IVltDuuqOBa4pDJkkziCtIR9fMAsDlXhXW9elmZ+o0LXC5DIXTq1vH/dLxkpbBLnq7DxwA2hyTojwF+zHb3oAUE/lYUhOAX1JIomsSQIecWiazOYS9IMzI2p8IlhEbpdEtd8sAVw+CRhxXj3gAEDx0x2lbx+TqJOSGC5+OaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635029; c=relaxed/simple;
	bh=JWpSoP2HGc/Oc08Y57EtduMOidT+MC26N75BuT70CDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRgv0SB41DArjMHDRJAjllycc2dTo0O9YhSRBHl7YKxRyVpUO173WAZc/ow+wpZswXRDy92dJrB7cDgz7Ypi7lqbkbQuZZhNQK2AJgmwf4w2IFfNfzS5jmaPU3DN2YOt3A+Fzm74BhPJH19KPI+cPCIu3KxKKQo8Qj9qnn4EamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SRXmB4Ss; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S95dO0030640;
	Thu, 28 Mar 2024 15:09:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=QPXPIOV
	UfByGkuaSPB9AB9ng4t8wE4olpPYf5fbQTsY=; b=SRXmB4SsNms3FiiuAol2YpU
	3cCfMOFe9buoNVWGtoLMYi5iNiHWBkd4DLfI/V9Qncj52sf1ZrtXFCH8nfjVPYUG
	7cH6kEyEjnQvKkXB5mkHuqwscEfYRalq1m7M82yxybp6cQjTZz9af45h9K/qcUNo
	jH0JgQYeQ5zuS6NNEgbe5qIQaXjfq1J5uJETnmPR2iFebpexFaOYdnrsJLBhXG0B
	GG/j/PyUWMmbxwPG3BBlLXpKMzhF1M5h+TItzaq3MkcP/+lbW8ppKgH/N1zhJUfD
	ThBPRsB3FMaanVFVMdu9R+z6Tw1M6SCaoXg7UDiS6gyTcIFuUhK2G1BATNLKkkQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1qa3jann-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:09:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8E6E240044;
	Thu, 28 Mar 2024 15:09:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6FEC6221EA0;
	Thu, 28 Mar 2024 15:08:11 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Mar
 2024 15:08:09 +0100
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
Subject: [PATCH v5 0/1] Add property in dwmac-stm32 documentation
Date: Thu, 28 Mar 2024 15:08:02 +0100
Message-ID: <20240328140803.324141-1-christophe.roullier@foss.st.com>
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
 definitions=2024-03-28_14,2024-03-27_01,2023-05-22_02

Introduce property in dwmac-stm32 documentation

 - st,ext-phyclk: is present since 2020 in driver so need to explain
   it and avoid dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb: 
ethernet@5800a000: Unevaluated properties are not allowed 
('st,ext-phyclk' was unexpected)
   Furthermore this property will be use in upstream of MP13 dwmac glue. (next step)

V2: - Drop deprecated: property for st,eth-clk-sel and st,eth-ref-clk-sel
V3: - Rework commit message
V4: - Fix syntax issue in commit message
V5: - Remark from Andrew Lunn (remove documentation of PHY regulator, it will come in next step (with 
      implementation))

Christophe Roullier (1):
  dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk

 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.25.1


