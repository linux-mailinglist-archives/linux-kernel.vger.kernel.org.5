Return-Path: <linux-kernel+bounces-86776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8E86CA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3BF2873CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C3F12FB0B;
	Thu, 29 Feb 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ophE01xx"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844212CD87;
	Thu, 29 Feb 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214548; cv=none; b=EW6fyxm6tl77ZBix9bLbXxTy9iEsVnr9vckDT+3iP+FzJKg3HO5I5IQOurUg0m9JbWQgk5eSZbBiVZs9dStpjcXj7M2lDr53Wcdf+BCe5w5xn/uqDdToc/sIIO1MupmecYPD8Z/kiPaEqk9ALJw3qZMWKaV5M16y5hM2H/M7fMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214548; c=relaxed/simple;
	bh=aRTII+3NPMyzQVYAhCc1A8P1Zc2CrSGjf8yf70WQIO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvyEDzdw6mmNifxSvkoht1evc8wi9steoQ8V8zoQ/yHVoGc+98mobS90JBpR0BrAeMJyDQX4yVhiQZwjT18vaFbOeQKopxX8vqQyAPW922+zKHFJiJ9j6qVE2hEsUn3Y+FRkWElx+ETEhZrwHfBUEVzKV2mz0oyDsmj/GzzOIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ophE01xx; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TA6kFh018050;
	Thu, 29 Feb 2024 14:48:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=oivmPaX
	pFQMFUsyyqZJLQRYPIoHlWLULOftzA1Oyk3I=; b=ophE01xxHASQtSdV8Iv1/3k
	slVE+9cu0fGeVGFMgpP4WDJfZjk4lP7HQVQnmnPG1LVG4klpkpNS6wLVS9QWFzhK
	ZUSYKhWT/iIr6POd0HbG11W0jcXD1QfxjbKGEsfuWkta2Cqrh5YIQHamBJKxC68A
	Dph9AkXlxMDtCsfqdebTzyaKjVD1uxCCaMxxHHZbGoUKgIcrW3FW3da+D/tM7RbR
	vzi/Ns/rGliN/n1qERyN6VRY8ByMAzMDwvrwDPldV6uCQPirfiKmSWN4FWCCOPKM
	SBHobgXk1NEtADQiA7HMfVeCmfaraaFitImPiHuNPGSzF/2+iVLTWyHh4mDVIvg=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4e2jh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 14:48:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9B04C40048;
	Thu, 29 Feb 2024 14:48:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 87F5526F13F;
	Thu, 29 Feb 2024 14:47:44 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 14:47:44 +0100
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
Subject: [PATCH 0/2] Add properties in dwmac-stm32 documentation
Date: Thu, 29 Feb 2024 14:47:22 +0100
Message-ID: <20240229134724.1353903-1-christophe.roullier@foss.st.com>
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
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02

Introduce 2 new properties in dwamc-stm32 documentation

 - phy-supply: to manage PHY regulator.
 - st,ext-phyclk: is present since 2020 in driver so need to explain
   it.

Christophe Roullier (2):
  dt-bindings: net: add phy-supply property for stm32
  dt-bindings: net: add new property st,ext-phyclk in documentation for
    stm32

 .../devicetree/bindings/net/stm32-dwmac.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.25.1


