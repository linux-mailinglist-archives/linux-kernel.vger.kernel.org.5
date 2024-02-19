Return-Path: <linux-kernel+bounces-71224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A771485A22A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B4AB251E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A9E2C6AC;
	Mon, 19 Feb 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xi9exg7z"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA02C1AF;
	Mon, 19 Feb 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342786; cv=none; b=A9FhHJrVGKoHfFXqR22yAFm9clcv+2IYKAuO5/Va7nAqkBoKJximVhEYJO3pZSBfTTNv19QoxjcriYZglnXkpGli4vdg/Xlxy6Y57VTuCoYkmeOJlhsuq81yQjl2dsfSr5NfO5Iwu00VtlA0HPhM3JQgpu4JdKrlc/l0TAeOMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342786; c=relaxed/simple;
	bh=DmjgrXbc5RyWYMQbmKGxTVR82C4mgVXY1F8lsRBw/UM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuIVlxwZiC50N3+cjhO4TzF+bVCl4YHVlC5OWtQCez4uqyN3F1QSPY+6bxzGC8ODG/1L0I+UCLnwq7rRhu4qMDQC8UzVfIBGdEyLFQbqDgU5BBoYai9toov+ZoECfkv7Msc8CRcy2Yi4DLEnChCCjacGvGkBfxYyfvVm8Lp/c/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xi9exg7z; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J70b8s022274;
	Mon, 19 Feb 2024 12:39:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=A2iKM+c
	tRFPHqEUaV0TEOpjjyA+onvGcSY21gTvpe0o=; b=xi9exg7zgmS+kl9oPoXo1uz
	GLLo/6xv9gxvNLvKRi50SEs0uKiUw1xE/HOAdUYXOOyclI/v8Dy6VkXBEFsp15rd
	kPoqfqkVQPvDSxDgYjeYznRM+kYRZjYWMijh/MN+idvkCherP6a4T9IxX9mkmVdx
	UuNYTTkAg4NrY3Ni2yVExkySBL5kGFFYDDdXTSJse7V7NyzFw933oXmZ2ta2/N+O
	oEKDCh3gE/sCY99EGG+a9Fv8mohHYiTvNaJFr0cAHwmav6MTllBMpTbh1ysqGrZD
	MS07/tjJru9EIf5WnfRkAszFOdUQJp8DbeGsg2914wl6iPTEA+Jc/XzsMIqR9Zg=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wb8mnm4du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 12:39:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 71C5F4002D;
	Mon, 19 Feb 2024 12:39:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2BCFB25AEE7;
	Mon, 19 Feb 2024 12:38:29 +0100 (CET)
Received: from localhost (10.201.22.242) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 12:38:28 +0100
From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Enable the CRC and CRYP IP on STM32MP135F-DK board.
Date: Mon, 19 Feb 2024 12:37:42 +0100
Message-ID: <20240219113745.92538-1-thomas.bourgoin@foss.st.com>
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
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-16_01,2023-05-22_02

Enable the CRC and CRYP internal peripherals on STM32MP135F-DK board.

The first 2 patches adds the node crc1 in file stm32mp131.dtsi and
enables it for the board stm32mp135f-dk.
The last patch of the patchset enables the node cryp for the board
stm32mp135f-dk.

Lionel Debieve (2):
  ARM: dts: stm32: add CRC on stm32mp131
  ARM: dts: stm32: enable CRC on stm32mp135f-dk

Thomas Bourgoin (1):
  ARM: dts: stm32: enable crypto accelerator on stm32mp135f-dk

 arch/arm/boot/dts/st/stm32mp131.dtsi    | 7 +++++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 8 ++++++++
 2 files changed, 15 insertions(+)

--
2.25.1


