Return-Path: <linux-kernel+bounces-166558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0BE8B9C65
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72B31F22377
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A83A15350A;
	Thu,  2 May 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sszJqImM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D852152E12;
	Thu,  2 May 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660516; cv=none; b=YXQAo9y1YISISLp2uB+4+xq83cro3Xw+Ow4MAuLnP2qnnVSfHugFnnwo0X8ZDnF3Th8tDiGievtzj5lC4lSYBTiPhRVtW3r28W3IC2IKWY6xSflg4RTIU1K5KNymnGD8+jdIwe6GVAE+DGUWVuuc7QVY/QjjGOQmJZ0s/fQI59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660516; c=relaxed/simple;
	bh=cGtSLhV9PQy5AG+syvA12d07Ab6jKTZoOL5VxbTBicU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhNShYwCm3iSuAeHKS6SvANaLuU3XHtwISkp7eoMiHpqMePycpfiZ4FuVvaUUbzJyEB9CpGMHt55WtLYKvyU+s2fX9nQ7XJLCqYi10Dw07gIga5NHi7d0XnsfaSnHbiPoDiuT/uqEF5ZEQRKc7qbQQeq66M05vkjw0EDHwNM/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sszJqImM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714660514; x=1746196514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cGtSLhV9PQy5AG+syvA12d07Ab6jKTZoOL5VxbTBicU=;
  b=sszJqImMAW+AQcOP6gaYucTjVta3sKGTayyqapjLbXFqmFiroheWV+k1
   pFUMI17sJXMWeaFwjScPTt3zCXfVEnqMM2J8pAiqJabIXfMbkRJl3KxON
   ienfwHhUHVoFsfacuy1Vzm5VryQD8ScbiDD2o3tovFw3zisdR3MtWIkAo
   K3GwZYXFo3ScDb9DLUjDQJwB4Yik8bm59RwfM+xas0Morm8PFmVDQr3z3
   01OBQAAZ5D4Sb1nCVyeTk2ro8rkZmOduIDUUnu9kxlPk8dyqtZBQ189FE
   TJi8b1KCgsma0ga/HWalyDWNaRIYNswiY96fmNThDiVcsZ0vfb8hu8Jy8
   w==;
X-CSE-ConnectionGUID: Qz8ca859QRGOvYnxkj1hIw==
X-CSE-MsgGUID: GIq4VhGQQ9+wxAv0D3gKJA==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="23373822"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2024 07:35:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 07:34:07 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 2 May 2024 07:34:05 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH 0/3] Add support for GPIO based CS
Date: Thu, 2 May 2024 15:34:07 +0100
Message-ID: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The Microchip PolarFire SoC SPI controller supports multiple 
chip selects. However, only one chip select is connected in the MSS. 
Therefore, use GPIO descriptors to configure additional chip select 
lines.

Prajna Rajendra Kumar (3):
  spi: spi-microchip-core: Add support for GPIO based CS
  spi: dt-bindings: Add num-cs property for mpfs-spi
  spi: spi-microchip-core: Fix the number of chip selects supported

 .../bindings/spi/microchip,mpfs-spi.yaml      | 19 ++++++++++++++++---
 drivers/spi/spi-microchip-core.c              |  6 +++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.25.1


