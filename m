Return-Path: <linux-kernel+bounces-56100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0684C5F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AC91F255D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280331F955;
	Wed,  7 Feb 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IhAw7k4G"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17A1F95D;
	Wed,  7 Feb 2024 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293304; cv=none; b=mKfYTBBBUixbuh2oI6s7ICIFhvkii7O6lI30jKINKB6sQcwFUh/JNW1WV1kQ2T8odyJtZQU4/NWRu1+YNnyd0uwISIOqO1NjhlpEgq5D1+kNBmXyd5fjMBQK4b9QSD6HQQMWcaTsutEd6q7xLA6dDOzHUpz1pcwllTC+V5x1xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293304; c=relaxed/simple;
	bh=daxL9NbNrv0PKQ73ESMe3FJq0wGSeI2kdG2Mz5x2tlE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SND3NqPisztGKFy59/OAkhTFZmE9h7AIztF0qarVoErvaXV4TNxwYl8OUkuVILTfdkbBw0cKMikDLJgJ6aLeZo8UgH/Txw95B8Gop7kVxy0XjeSt+a8o9K16COJzi+7boj86XkNi/rhPSsM+R5CbOU7unRi6yXPSnj0czCCgML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IhAw7k4G; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707293297; x=1738829297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=daxL9NbNrv0PKQ73ESMe3FJq0wGSeI2kdG2Mz5x2tlE=;
  b=IhAw7k4GE5StfZJP7LoITZW5wmm3xyKBp6QB5Ta22Ap8URlTb1A8WEcb
   HDQCCxJKPii3lStyh00hkwc2wGEMwu+62Y27zbgBlMdXfZ6Y7kAQzSICT
   2Z2Wzz5eK51sRthEGHILEHkyV7sFSowYULy6tVl2Wu7MyHfTt8DxOAFUI
   RMkLzMJXUv5DjxY3SAeWmAW2KGlxKC8C6JayOGPILeOPRiGgUaLmCz1Dw
   fSnlq0gyJauSfSaIziZOYuAG9hoDEIIq+116IebGLndg39lSDhUmIl65y
   V7t2VEGKNvrKIcNfYPjXX2+Hj5Ij1yA2g/0U6t5x6jShfveDgxVimfkv3
   w==;
X-CSE-ConnectionGUID: vQt9zdwKTaaiPaLrbSvDLw==
X-CSE-MsgGUID: x7VZntY8TZGwL8MFJYQ+zQ==
X-IronPort-AV: E=Sophos;i="6.05,250,1701154800"; 
   d="scan'208";a="17266354"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 01:08:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 01:08:14 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 01:08:11 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v3 SPI for-next 0/3] DMA Support for SPI in PCI1xxxx
Date: Wed, 7 Feb 2024 13:36:19 +0530
Message-ID: <20240207080621.30742-1-thangaraj.s@microchip.com>
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

v3:
-Merged Tx and Rx DMA patches into one to avoid unidirectional dma.
-Changed naming from DMA read and write functions to from_io and to_io
to avoid confusion between DMA and SPI Controller operations.

v2:
-Added can_dma operation, so that the core can do all DMA mapping and
switch between, DMA and PIO operation by itself.
-Added error messages for syslock acquire failure and DMA init failures.

v1:
-Initial Submission

Thangaraj Samynathan (2):
  spi: mchp-pci1xxxx: Add support for DMA in SPI
  spi: mchp-pci1xxxx: DMA support for copying data to and from  SPI Buf

 drivers/spi/spi-pci1xxxx.c | 510 +++++++++++++++++++++++++++++++++++--
 1 file changed, 483 insertions(+), 27 deletions(-)

-- 
2.25.1


