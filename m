Return-Path: <linux-kernel+bounces-95678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B780875132
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6C3B26314
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784612EBC3;
	Thu,  7 Mar 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1cVUVPMR"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73412E1FA;
	Thu,  7 Mar 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820175; cv=none; b=Vr7G+bXpYQVVg8WjIcHjdPLYqOq3d4lgiMnqNt3nOZhbbk4bENmhqk2QagTqEvXlsq9qMo6Jd6kZ9w1A9MNHMvYlrxSR/N1dYNcGSM4dyXr2n3pfcbgSd7m+0EhjOkxRwjmo97fHrY1aVOqilcJ1gIfAaKCM+SK538hfljfqL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820175; c=relaxed/simple;
	bh=buSnnVcPm9q1IGlVOeLRFi6yISTc1DhJcXxXAaJLJPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=duKy+Bo5Lx2siOZo5Plsr5zATXAIllYbDlEt3KMnaWcJYqZOuZu7VSZD4Nnxb+1hXIHg6IaRgHOmEFSrVNwpY3NDYdmd4HspYEsOEi5YOny6sCHFqVIB3xKF0MktFN/q+GW/3MQzUyS7zCd2OGIDSIz/H/l3JmNvUiSqq5ZdBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1cVUVPMR; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4279qDL1004218;
	Thu, 7 Mar 2024 15:02:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=gxYbWB4
	fXb38xLpOEzgo56z8fvAXCuQ7VDTmsUnu2Mo=; b=1cVUVPMRBeF/QwnpIahXUla
	MF6PHZtiUba895i14rt1G4DoQT4SFrxPqt5ak9XBOW2yp3zpobqP4PiTkMARpoge
	GYJG7jUHdw0TkxcqOUaMi5a3XVlTukqvtyysXrS6eXVckTe4ii9AIwEgNtbJ+XHz
	P8a/Dqlc9mz6xOJsYesPGAhDcQBFTb9kQfwp+Qivsl/AvTHlFtTPgng3BCsqw0sD
	R8HGKyjPeUW8rmBomlyHu9c/pSa2Q7Jg+/v//kjQ/T6mpvNXU5/cj2mDRudSbCVx
	kunb+d0OljShFcG/N7C3h13TUztJiUz8+R4X6U3TH7gpsw4sptd6IiRuyKO9/Vg=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej5dxs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:02:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0509E40044;
	Thu,  7 Mar 2024 15:02:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6100327D0FC;
	Thu,  7 Mar 2024 15:01:10 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 15:01:09 +0100
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
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add properties in dwmac-stm32 documentation
Date: Thu, 7 Mar 2024 14:59:55 +0100
Message-ID: <20240307135957.303481-1-christophe.roullier@foss.st.com>
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
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02

Introduce 2 new properties in dwamc-stm32 documentation

 - phy-supply: to manage PHY regulator.
 - st,ext-phyclk: is present since 2020 in driver so need to explain
   it and avoid dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb: 
ethernet@5800a000: Unevaluated properties are not allowed 
('st,ext-phyclk' was unexpected) 

Christophe Roullier (2):
  dt-bindings: net: add phy-supply property for stm32
  dt-bindings: net: add new property st,ext-phyclk in documentation for
    stm32

 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.25.1


