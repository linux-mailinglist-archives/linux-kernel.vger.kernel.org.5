Return-Path: <linux-kernel+bounces-71450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6585A569
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7D41F24813
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882837155;
	Mon, 19 Feb 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CwY0wRZs"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2B2E647;
	Mon, 19 Feb 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351594; cv=none; b=CqRYPICktIuRdMWuX5ngm/v27HSPIdiSmXmvme1UPudzbR4DBLmtFEbT9VS/iMGxe0NlRiQrBlPlHU0ba1VZqvgiuWvxsps7j9GlDKi7qJGxBDoV4U8PgV1CW6ug+ILRR/GEpIZBJ4lVDhRbcBgG2GdpnIa5ru3VqHhJGaiss+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351594; c=relaxed/simple;
	bh=5qxW4X1Ezb6TCJqh1wJ/+ccuB+eQ0ymYQKUPdQ8a+lU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lgN/uclQdIM3bpSj/KpDP+2PtRopl94t2WADIOpyIe34Fb5OwhNo6zbMNx2UgntBU0p6kSBA3RWix6rns04DWoVObVCUl4I+nlMUncT2BGKq3Zf7HZWD1neKdI39Aa3jvInRBjcEA904zkhUdMil5UsunYj3qpB4EgPJ3pDE/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CwY0wRZs; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J9TEVB008714;
	Mon, 19 Feb 2024 15:06:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=yFRkBHM
	ELWMAJ4eYruQiX4W19nuUNwDsJhqaDX8WO6k=; b=CwY0wRZsPMwx/gPCla0+Mai
	jI1r4KRfzqINlSZKMM3ZOlEbkz3YWE+Ui2Xf+rFvSH5sI+Sh8D0cZVEyN633iPdj
	WbKQvtxvW4jNBfnugRWC7xfg1fCgmmNzcu8M7LnHAKFZmuXTfez/Doksdvj7MQEe
	WNXo6yzsXobn6a1PCWJPZwc/UC41u50ZmrCDpAEG8DYZaPqTYa7Ww8bMfuaAx78z
	JtxMH/PTsK2cXqDFx5x3+vjpCr02v3Ct2O2HJhYo7WgrhoSlXty/OrTTRx8ENA6z
	5M/hxkgBjaAWW4gYqXNaWzWocUbSvpDxxIyqWPD/APHmipsPTNYny5URr3wXtUw=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wb784d40h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:06:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7BB4A4002D;
	Mon, 19 Feb 2024 15:06:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 59B8426A995;
	Mon, 19 Feb 2024 15:05:24 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 15:05:24 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2 0/3] mtd: rawnand: stm32_fmc2: add MP25 support
Date: Mon, 19 Feb 2024 15:05:02 +0100
Message-ID: <20240219140505.85794-1-christophe.kerello@foss.st.com>
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
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02

FMC2 IP supports up to 4 chip select. On MP1 SoC, only 2 of them are
available when on MP25 SoC, the 4 chip select are available.

For MP1 SoCs, MDMA is used and the max burst size is 128.
For MP25 SoC, DMA3 is used and the max burst size is 64.

Changes in v2:
 - dt-bindings commit message has been updated.
 - V1 patch 10, 11 and 12 have been squashed and reworked.

Christophe Kerello (3):
  dt-bindings: mtd: st,stm32: add MP25 support
  mtd: rawnand: stm32_fmc2: use dma_get_slave_caps to get DMA max burst
  mtd: rawnand: stm32_fmc2: add MP25 support

 .../bindings/mtd/st,stm32-fmc2-nand.yaml      | 25 +++++-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        | 83 +++++++++++++++----
 2 files changed, 93 insertions(+), 15 deletions(-)

-- 
2.25.1


