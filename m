Return-Path: <linux-kernel+bounces-71441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571B85A54B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01781F248D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BCF37143;
	Mon, 19 Feb 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7vOItSRY"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A0374C4;
	Mon, 19 Feb 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351433; cv=none; b=W4YnV6RQQwxIZ8wVFBaR6HnZAV6aiSwr7JQEE60Co9cBPKZ+jMhTRcBPRNkm9bZIZ2LbWBziaTQgySMuMbAx1C6UsvhBx7oDExsibX2EyM/0j1w1+be/Exyx+BcaHoEx9c5TgyeLsiC21FPw5UpPXy41UZs9bBMie/Ptrzx/RFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351433; c=relaxed/simple;
	bh=W5O7VZ8KqDCfbvD26szdWB030oyr7Cq1XvqJ3vUKziE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cvia5FY087i1d+Tc1A/blRVClsQRNMWBP017vGTTK+LIY8IqNXdr17AXVcLE2hfRPt9hTMpKsYSy5HCW119WkHiF0WeacBmbEijBUXEloHU0VWc9ewR/AeIfh8B78KFNZpxCtvNpCFPmm6OttmS0vcu8De3YQiLYAfJHqJHNJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7vOItSRY; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JBbmfn010713;
	Mon, 19 Feb 2024 15:03:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=JbFKX/R
	0/Q/8vicTvjhSmz3MCxFrHdiMtjVvUU6pahA=; b=7vOItSRY0orWOLflOvBChU3
	gfTyHpTsT2gaFtBG5/+a9RZ9TjxjWg17JNZMUmm9WNOcXH5B6imYXcu4I7/s6+1x
	F8QOMyoqOo/Gpi509/RSJHf0Gb2YLXPRuviS0megmHytHTo8ZAFIz+xmu0we/NuV
	i9TiTh3khV8RJNWRpQiEqJK9wNHVnJJzOGZIBU4d9+jIg4HMfVrQS5+hPJ2Mo2A8
	LMyfSJVJaeU5FVRXaTKLSarUAjk1RxGwAJuj/yyuFjH4WrTEiLWoTdqQnxdKOl78
	jCjQInT4c9FWx+cE0pWa13nQy0qAV1a6Pe9x9GIXVc4edIkkFAjjXuZql0jfjAA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wamjh6mur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:03:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1A4A54002D;
	Mon, 19 Feb 2024 15:03:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 903CF26A985;
	Mon, 19 Feb 2024 15:03:09 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 15:03:09 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2 0/5] memory: stm32-fmc2-ebi: Add MP25 FMC2 support
Date: Mon, 19 Feb 2024 15:01:57 +0100
Message-ID: <20240219140202.85680-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02

On MP1 SoC, RNB signal (NAND controller signal) and NWAIT signal (PSRAM
controller signal) have been integrated together in the SoC. That means
that the NAND controller and the PSRAM controller (if the signal is
used) can not be used at the same time. On MP25 SoC, the 2 signals can
be used outside the SoC, so there is no more restrictions.
    
MP1 SoC also embeds revision 1.1 of the FMC2 IP when MP25 SoC embeds
revision 2.0 of the FMC2 IP.

Changes in v2:
 - V1 patch 1 and 2 have been squashed and commit message has been updated.
 - V1 patch 3, 4 and 5 have been squashed and reworked.
 - V1 patch 7 has been renamed and associated commit message has been updated.
 - V1 patchset is split, one for memory, and another one for NAND. 
 - Regmap_read API return value is checked everywhere it is called.
 - A platform data structure is handling the difference between MP1 and MP25.

Christophe Kerello (5):
  dt-bindings: memory-controller: st,stm32: add MP25 support
  memory: stm32-fmc2-ebi: check regmap_read return value
  memory: stm32-fmc2-ebi: add MP25 support
  memory: stm32-fmc2-ebi: add MP25 RIF support
  memory: stm32-fmc2-ebi: keep power domain on

 .../memory-controllers/st,stm32-fmc2-ebi.yaml |   7 +-
 drivers/memory/stm32-fmc2-ebi.c               | 739 ++++++++++++++++--
 2 files changed, 696 insertions(+), 50 deletions(-)

-- 
2.25.1


