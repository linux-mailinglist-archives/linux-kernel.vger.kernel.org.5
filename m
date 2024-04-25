Return-Path: <linux-kernel+bounces-158148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3AB8B1C30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1511C22F43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA96F077;
	Thu, 25 Apr 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lHSbkGyj"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588B67A1A;
	Thu, 25 Apr 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031391; cv=none; b=j1uQizkqyrKpPWar4x1ftoQG/AvrSOb49UPEcX06LAsodTdJlMOfr/P9XtVpNZwPw3P/1n54SQTBXmcCt6/JZzdzO3l4kzs4YbrIS+R1XeI9ZoNjTuYEO822+t2rRcsgFt7YNsMC/GhIrpiitU8sSv9B2ueNsUfShw9WudZ4Ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031391; c=relaxed/simple;
	bh=ZaH5Y+5K4+LetM1zlsUQzT+6eYAidDXHlw0BoqJXgxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UksYPtDUBZHCprORBk8KwwRbXLDC0xOQ5n4W6Kf4qJG4dxYjkcmBjDXVw4TOgBvp6jiOFGp6bJ+3rzqVjjNx9I/8vcNye9lRL4/se4e/0LWEtRCbih7ow8RA14UprtCZAFQNIrtZ9wjPnUO/3siGTFbSkg/06yfXw1/rHGseh9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lHSbkGyj; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P5kYQs018290;
	Thu, 25 Apr 2024 09:49:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=37REsQ2
	FIwtIHcuFXf9WH6rSdUEg9FqQ4fkZiZRMvHk=; b=lHSbkGyjPRhga+SPcpoHitc
	PP270bH2xydSDknnFzA7E2oOQ3ZenAWl9PHI0y3oJXFxsqXEnCbgnbZQPuNeli1k
	dZCyyBdtHgtcGD38csJEKE53N3GO6PbiMGcyuyPWSsXcErSuYyF9Dv7eBHu1lqeo
	BjG/keNpuifVGltVeJTKoRZl7BqMKnJIUKUh1tV6Bvfy6gevDWvEBQDPBbMs2m2/
	IZ0o3v225ZsWJKvCJt6lzaDCxL7kUThYgTbct60cjhPHgloDukGVWU+yuJbXJk15
	iUQ/XasKvdpKK1biABBJszXBftCtu2wmVd/snwCrOPJKPu8fYHjJZ8gAwtl6EDg=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cnmupb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:49:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8CFDB4002D;
	Thu, 25 Apr 2024 09:49:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4F4C212FD7;
	Thu, 25 Apr 2024 09:48:51 +0200 (CEST)
Received: from localhost (10.48.86.112) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 09:48:51 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/3] ARM: st: use a correct pwr compatible for stm32mp15
Date: Thu, 25 Apr 2024 09:48:31 +0200
Message-ID: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_06,2024-04-25_01,2023-05-22_02


This patchset removes the unexpected comma in the PWR compatible
"st,stm32mp1,pwr-reg" and uses a new compatible "st,stm32mp1-pwr-reg"
in STM3MP15 device trees.

The support of old compatible is keep to avoid ABI break.



Patrick Delaunay (3):
  dt-bindings: regulator: st,stm32mp1-pwr-reg: add correct compatible
  regulator: stm32-pwr: add support of correct compatible
  ARM: dts: st: update the pwr compatible for stm32mp15

 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml  | 6 ++++--
 arch/arm/boot/dts/st/stm32mp151.dtsi                        | 2 +-
 drivers/regulator/stm32-pwr.c                               | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.25.1


