Return-Path: <linux-kernel+bounces-54270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ECD84AD0D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B69E1F241F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEA7319C;
	Tue,  6 Feb 2024 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jExk9LCI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4A2595;
	Tue,  6 Feb 2024 03:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191036; cv=none; b=I17hx2Msf6Pu564tTtydDYmTHcZGQrS1dLZxV9QF1AqhmGw4Kf/3nzEIfH8/FwO3ADhDQ5XDIt/EW5YrukGPfpFPX0BJcDrVQBCzue9JErezxvUmxd6/wl+VkJR4R4tK/VQTAQnrkWN3KYv4v6u8Mu1IW6HOUgfR7ZgSib1Gxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191036; c=relaxed/simple;
	bh=6VuaWSlmv52TfSRHByUinUpVvYEdIDQJBKINYMHBdAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O4uf4+X010mKo7nZj2ix3zt81AS2+DLiqfd2oXyIFWTu3TsYfzcY9smqEyCKC2IEN+suT95ue3v8NEbK8trfqoDWguFYxyFFflCznNCUFc1w61IRmwqOuox6wDFI6Lpmbt9HOmTMHbx+wwcc7DtAPIYf0vleJGdP3OtRKd30z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jExk9LCI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707191034; x=1738727034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6VuaWSlmv52TfSRHByUinUpVvYEdIDQJBKINYMHBdAg=;
  b=jExk9LCInHMZH2T7WEyhYrXajjP9Jwu2zwa9JvAb7ClF+tX6foaUmjRC
   KmG+c24dsvxB6OwuOYTwijn09rm8UnClC2yPXZCitU2JW+OgCtG9R4VsD
   Di/gkHTxMiugDtHi2s8Si391jQXblMIkS/Rh2Sbvt2Gk+sN1x/Hv3x08D
   tbMImVWCSf+A+LBiia3rB+m6nNxR68Cu5FfEV4766b/3b3r21cMU4IiOW
   IBUKTCwd1SR/KxWnoiu7VQVUks7CxIV0OugnH8ldWzQ3BJ5DBx8PS8lP3
   g9UROcGmZUUFgOM8Wi3WCrQc4lmdZplQHFFugCfBAtIZgnEsCjcorJntC
   A==;
X-CSE-ConnectionGUID: fiSYXhrfTQy9hSpjm7+bzA==
X-CSE-MsgGUID: BqoQ7Km3S4OdyAWTmvN6YQ==
X-IronPort-AV: E=Sophos;i="6.05,246,1701154800"; 
   d="scan'208";a="15826644"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 20:43:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:43:13 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 20:43:11 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v2 SPI for-next 0/3] DMA Support for SPI in PCI1xxxx
Date: Tue, 6 Feb 2024 09:11:15 +0530
Message-ID: <20240206034118.748801-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series of patch is to add DMA Support that improves SPI Performance
in PCI1xxxx. With DMA Support in 20MHz clock, the performance is
improved from 6Mbps to 17Mbps.

v2:
-Added can_dma operation, so that the core can do all DMA mapping and
switch between DMA and PIO operation by itself.
-Added error messages for syslock acquire failure and DMA mask set
failures.

v1:
-Initial Submission


Thangaraj Samynathan (3):
  spi: mchp-pci1xxxx: Add support for DMA in SPI
  spi: mchp-pci1xxxx: DMA Read support for copying data into SPI Buf
  spi: mchp-pci1xxxx: DMA Write Support for copying data from SPI Buf

 drivers/spi/spi-pci1xxxx.c | 510 +++++++++++++++++++++++++++++++++++--
 1 file changed, 483 insertions(+), 27 deletions(-)

-- 
2.25.1


