Return-Path: <linux-kernel+bounces-62131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3D851BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BFF1F22B29
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34033F9E9;
	Mon, 12 Feb 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QEG6TZ6H"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496313F9CC;
	Mon, 12 Feb 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760207; cv=none; b=q9e7PUVqZqGIKksYqZfO4Fa0byGlzyRAsj8GktlzRl9aVQZ+WffvJqnt5EprjHMsSWa8IDhIzQoQ07ja3DRRQSIor8Tp54Ge4JDAKmneYR+FWjM2GPHWk8Q14um5GbGK1UCR43/vlgw8NGMq9R7sR5DAoo5ZtyUpdpA/HcdmxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760207; c=relaxed/simple;
	bh=bvBzhLTbgJwtFJi9i8ZPE8IPcn6YXPYx10MSyPxIuRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YHbKcpalGNevhH+77qdNEGognkb3iNnC5z2jx/OSbu0rnnHbiNLdGEbkbhWauzTY8x8iiODV6yhgQAWXe48rMxDvl8fwcCLQHD/eeKgZ3f3htiQmAVNKyCvLT64DAuWQHeYvCivPu2XyTjl901cW2Ld3l/zLXgBkvVg4cVyX5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QEG6TZ6H; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CBflad027664;
	Mon, 12 Feb 2024 18:49:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=iG9lTCL
	5x6tc33cbUiqDXTjCZznE1C2VEmTB9j9Cvs0=; b=QEG6TZ6HWjBuHT1COxwVc/y
	B2AAMbrvZNHVl3zs8mqxcOSbPuydF4pEuJQoT2OwoDOp6QFtn7pmPugAjPyW8uBv
	L3t5N/5BKibv6CLVWPqjAdhpuCDn3YQ1KpBNLlmPx3B1K8nNNtOxDP+N7crSg2DI
	e+iKUvoZs3nZzv60K8TcyKH0eeXSkJ9WzXh1JOJbz1bzCmLlu/bDfFp9eW1/Uc8f
	8Rk9B/ptw1ZH6Rv73vHCQKhX8WbujlQpgxjcsTCIvtxYR8Ir4smWxSUWnJaH3I30
	r9PfTuiV4eAZi8ZmI/KmTqmR5uEX/qwKDrO5Qqzli6+cft7oaXs4x6Fi2gBDpIQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6mynd420-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:49:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3CAA840045;
	Mon, 12 Feb 2024 18:49:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AABF427B40C;
	Mon, 12 Feb 2024 18:48:39 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:48:39 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 00/12] Add MP25 FMC2 support
Date: Mon, 12 Feb 2024 18:48:10 +0100
Message-ID: <20240212174822.77734-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_15,2024-02-12_03,2023-05-22_02

Add MP25 SOC support in stm32_fmc2 drivers:
 - Update stm32-fmc2-ebi driver to support FMC2 revision 2 and MP25 SOC.
 - Update stm32_fmc2_nand driver to support FMC2 revision 2 and MP25 SOC.

Christophe Kerello (11):
  dt-bindings: memory-controller: st,stm32: add MP25 support
  memory: stm32-fmc2-ebi: add a platform data structure
  memory: stm32-fmc2-ebi: add MP25 support
  memory: stm32-fmc2-ebi: update the driver to support revision 2
  memory: stm32-fmc2-ebi: add RIF support
  memory: stm32-fmc2-ebi: add runtime PM support
  dt-bindings: mtd: st,stm32: add MP25 support
  mtd: rawnand: stm32_fmc2: use dma_get_slave_caps to get DMA max burst
  mtd: rawnand: stm32_fmc2: add a platform data structure
  mtd: rawnand: stm32_fmc2: add MP25 support
  mtd: rawnand: stm32_fmc2: update the driver to support revision 2

Patrick Delaunay (1):
  dt-bindings: memory-controller: st,stm32: add 'power-domains' property

 .../memory-controllers/st,stm32-fmc2-ebi.yaml |   7 +-
 .../bindings/mtd/st,stm32-fmc2-nand.yaml      |  58 ++-
 drivers/memory/stm32-fmc2-ebi.c               | 445 ++++++++++++++++--
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        | 108 ++++-
 4 files changed, 547 insertions(+), 71 deletions(-)

-- 
2.25.1


