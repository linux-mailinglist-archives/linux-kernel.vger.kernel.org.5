Return-Path: <linux-kernel+bounces-123441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37E8908B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5619B235A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40874137920;
	Thu, 28 Mar 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Q26cDUnx"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D957889;
	Thu, 28 Mar 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652128; cv=none; b=VBY6/8aJoK6yDhHHpjMpySfAx55UOlofrzC120TUvGpLm+l2NTyQ+foPpEGLxeEAhdNFAlK1Dka1a3aixd1AxoMma1R0Py/hvY+U69rxlNYvkBOFx7luseJAD0wslmeLDDNA2E1JHmrEBhnzf4H6lb+1SrMIari9qt5hsdaErKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652128; c=relaxed/simple;
	bh=nYiT+PnFbwTb/z8tOHzQIRLo88but/GStXQy1ynO7pk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qWEvZv7o2Dfw32ZMojxvZLrqk8YGefeQgD5D4oHAeMp4KRauZjwnanBta3LianpHEa81JGLDS0wKhltHVBDDaCx1NbPEXfgu1DBKaCQ5QVw7AmMSpIb10VzpHD0CS/Pn2Nm7UhPDoiUqfimDLSnu179pMGd4VTdgga/T0Hm5v9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Q26cDUnx; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SEaJUs030709;
	Thu, 28 Mar 2024 19:55:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=FVETmF+
	qlTGkl2AVbfmzdk4WvyjKz5a+vliTNTjgj1w=; b=Q26cDUnxJCn1s9TvEurVVVO
	m+9bWnkMiyFF8Xq7aRBmDXQNs0Ks8LqcPhcjNIlAEotK3m+hyj8cbgCRVppBheR9
	jdRfCjC/nXSEbmgzg7iPFRhXeBaYBip2FGyACrUwJ3k9D1hwPG1vJ4TosCJDkUqS
	j74TlnHB9un9pSiCi+W607tXm0Qwh2YZQ7R6oHNQXZgWBHv6cRjdFzUKvEc/h4iZ
	oX6cKYs+jUo+2BLnMU5xU2/J05B0o8cXyuSnfL2ElS0mUToYgu/JH1EMLxnTNcuH
	dvDXlOy0tl12dgPykORxnrVY8uWuelMspQLZbwzskdPP/B3/sig1zKkZjm3ZN8g=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1qa3knc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 19:55:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7309B40044;
	Thu, 28 Mar 2024 19:54:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7324022D16E;
	Thu, 28 Mar 2024 19:53:43 +0100 (CET)
Received: from localhost (10.252.8.203) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Mar
 2024 19:53:43 +0100
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
Subject: [PATCH v6 0/1] Add property in dwmac-stm32 documentation
Date: Thu, 28 Mar 2024 19:53:36 +0100
Message-ID: <20240328185337.332703-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02

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
V6: - Fix indentation

Christophe Roullier (1):
  dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk

 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.25.1


