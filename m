Return-Path: <linux-kernel+bounces-166556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F27448B9C5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A8B209EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CEE153509;
	Thu,  2 May 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hrArQcUn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E75FEE6;
	Thu,  2 May 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660499; cv=none; b=XNyvn4EYFzy0NboE67XwjMrGMG8Y1gcysYZh6ZG/F/S/Ik4G8fO9rXvuFGlSCAQCaPupVtK1hchixkrVFHO2Kr3Tm6MI0fqhb3j+2GTIfIxUBuUt9zW7qH/P9KYmc0g/YDH9gbBXw9HbOxYM36lbgGdSb/PBvGJCNVAf4inOq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660499; c=relaxed/simple;
	bh=v9aRfS2wsTb+7Z0gnOhNLJHtPwt86gf3YphRSYDX72k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLBYeaFAxC5V6iwOAUYULI3PFy4fENtIJfGauEofIHPwpVmTKa1o74rLs5Nw/LGM7io1G9LcfPt+JV6LAwzIX/SJSH6xNNJ6xVcDvE/svkB6BrxJDYaxoU2G/Pz//N5Fz0xZjN2grANXHXt14pmDI1VGWIJQHnKEvjbs+P3jeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hrArQcUn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714660497; x=1746196497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9aRfS2wsTb+7Z0gnOhNLJHtPwt86gf3YphRSYDX72k=;
  b=hrArQcUnYZRjQiMM4SsGOczSSysqUbit7X2n7aouoXxi91gPXA6qVQsh
   xfz05YgfbSqj+5N0Ntke1KLx/68fiy0F+Eaqf5IN3X6bhwaQbdEY9HS5Z
   KKNESu9sT3UidQS9xpJon8Kzgm1rj4mePenj2tiZ0WxGP055pazhZb4/w
   6m/bU9oX7XxoZuvviKeewD/LiICUeO90WgsIQGyVHGiRUF30JowOZb9p0
   QcGqavoPJJyijsMc6pqd19zOdiFhizLaPqoPmCNyDFqAXJPJxXYU+d0n+
   0d58HoHWs1+broo68P4fFNHHIPBGiAu20xRut8utXeVDTU+UrW2vjnvdm
   g==;
X-CSE-ConnectionGUID: 6Y5bhyOoSXq5FFQlA0lIog==
X-CSE-MsgGUID: yXfQee23ReykRQVaYGMsQg==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="23394531"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2024 07:34:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 07:34:46 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 2 May 2024 07:34:44 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH 1/3] spi: spi-microchip-core: Add support for GPIO based CS
Date: Thu, 2 May 2024 15:34:08 +0100
Message-ID: <20240502143410.12629-2-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
References: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The SPI controller within the PolarFire SoC is capable of handling
multiple CS, but only one CS line is wired in the MSS. Therefore,
use GPIO descriptors to configure additional CS lines.

Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 634364c7cfe6..71886c27bca3 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -258,6 +258,9 @@ static int mchp_corespi_setup(struct spi_device *spi)
 	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
+	if (spi->cs_gpiod)
+		return 0;
+
 	/*
 	 * Active high targets need to be specifically set to their inactive
 	 * states during probe by adding them to the "control group" & thus
@@ -516,6 +519,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	host->num_chipselect = num_cs;
 	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->use_gpio_descriptors = true;
 	host->setup = mchp_corespi_setup;
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->transfer_one = mchp_corespi_transfer_one;
-- 
2.25.1


