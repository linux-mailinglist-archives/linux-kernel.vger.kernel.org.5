Return-Path: <linux-kernel+bounces-868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971ED814744
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B192EB22089
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2C25112;
	Fri, 15 Dec 2023 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GRXOU8th"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532224B52;
	Fri, 15 Dec 2023 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702641025; x=1734177025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FONo09cctWbjCQrHoqxg4nvLF1hyPf6cr+OVaLaPo3w=;
  b=GRXOU8thqW2r2+PCzfx00o5Ajp1VciNT4rzVdpCoSrPHS6zJCGI7lflc
   tLetrxqphhB7gPLpRlH8x6TyQ68l4xwsSeNHODwZKZI5Nzv1mqJnsCTSZ
   j7lYyBly3n3wrUAy6PANmfK+I2qF+MmF73rOovcNmTTW4bJum1aLZBbnM
   Ih2ZoKxSQAPWg5rzPqXm9nKyTw+9LBwVskWEyrTBFW4AB+tGbC9UzCe3z
   uSZnZrKZT2DMna32E5vahYC9fLd8mECTaruWYSNnHOHo4NiYqRoaTMRtF
   Ck0gkYH+h25RbVKzBLUGLI4RjO7V5zRBgyal7UpZ8Kvuhz5drMZSDkY1D
   A==;
X-CSE-ConnectionGUID: ti+VcWCIQUWdJNIEI/3IvQ==
X-CSE-MsgGUID: S4VLZutARaupzCMZFPu0Yg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="14317219"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2023 04:50:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 04:49:59 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 04:49:57 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Tharunkumar.Pasumarthi@microchip.com>,
	<Kumaravel.Thiagarajan@microchip.com>, <Arun.Ramadoss@microchip.com>,
	<Ronnie.Kunin@microchip.com>, <jegadheesan.gopalmanoharan@microchip.com>
Subject: [PATCH SPI for-next 0/3] DMA Support for SPI in PCI1xxxx
Date: Fri, 15 Dec 2023 17:17:45 +0530
Message-ID: <20231215114748.152319-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series of patches is to add DMA Support that improves SPI Performance
in PCI1xxxx. With DMA Support in 20MHz clock, the performance is improved
from 6Mbps to 17Mbps.

Thangaraj Samynathan (3):
  spi: mchp-pci1xxxx: Add support for DMA in SPI
  spi: mchp-pci1xxxx: DMA Read support for copying data into SPI Buf
  spi: mchp-pci1xxxx: DMA Write Support for copying data from SPI Buf

 drivers/spi/spi-pci1xxxx.c | 441 +++++++++++++++++++++++++++++++++++--
 1 file changed, 419 insertions(+), 22 deletions(-)

-- 
2.25.1


