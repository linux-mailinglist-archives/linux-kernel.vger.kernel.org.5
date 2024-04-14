Return-Path: <linux-kernel+bounces-144009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C799E8A40B4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7291F213F3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9EB1CAA8;
	Sun, 14 Apr 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b="H4lLj8Hl"
Received: from sirabella.org (sirabella.org [207.246.81.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966A134D1;
	Sun, 14 Apr 2024 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.81.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713077647; cv=none; b=U0/zTBS+vxB83LXFrXoa4cj5Wt9dpEnC54uDu8JD8XYMc5e0/wEE2dijnUn7prOPQ+sx02YpT9i7LQyXEfoX6lDZLKHAsjs1Njb/Si0voRvJijzIq+BsgFmGa3T3SEOYjGYNAtE5GXvsVXdgmHGn/EWbenMWTXx9SMKVA8aPYcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713077647; c=relaxed/simple;
	bh=OwZXUAQIljzatfKc1kdDes2zT7NCe9QasY61Okvdqyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJj8Vxs98St4Z42TOeZPodaIA3aYATi+0LRDCGltPKGd/pvrVE8C+IcTzxh/Wk8z0X8mt4lILWjhaF9lBpqahkBCUA9FfXbYS2UAqBYdgpP/KtZXcmC7bbASPoCQqW3YsvgUkiwlzJI/QTpZNPu0jOnKAwIkvvSJP6eFWz2puug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org; spf=pass smtp.mailfrom=sirabella.org; dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b=H4lLj8Hl; arc=none smtp.client-ip=207.246.81.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sirabella.org
From: Marco Sirabella <marco@sirabella.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sirabella.org;
	s=mail; t=1713077643;
	bh=8yX+RfINII2LzHTSQoJ6+4gEiy7jn4rJ/Lmdru5TOLg=;
	h=From:To:Cc:Subject:Date;
	b=H4lLj8HlA8NDExuL9R1n42gLottdqmOcQFqh5dqCUJJVOPrKOcKzBIfZqGIV40w5u
	 lBfvoTtmv87+pL0xzskhD463GyG+QqthLRLfAm3D3cRGqXF3IBBXPWCURzaA42UuFT
	 PrGEpTWCebVQ3KdMUEnVkoGmUlb/K9819bEtMNt0=
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Marco Sirabella <marco@sirabella.org>
Subject: [PATCH] Documentation: spi: Update gpio+bitbang instruction
Date: Sun, 14 Apr 2024 02:53:05 -0400
Message-ID: <20240414065305.9796-1-marco@sirabella.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The way to do this was changed in
9b00bc7b901f (spi-gpio: Rewrite to use GPIO descriptors)
and there's no real docs outlining this,
update defunct #include "spi-gpio.c" instructions

Signed-off-by: Marco Sirabella <marco@sirabella.org>
---
 drivers/spi/spi-gpio.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 909cce109bba..8c5f88f01db2 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -44,22 +44,13 @@ struct spi_gpio {
  * per transferred bit can make performance a problem, this code
  * is set up so that you can use it in either of two ways:
  *
- *   - The slow generic way:  set up platform_data to hold the GPIO
+ *   - The generic way:  set up platform_data to hold the GPIO
  *     numbers used for MISO/MOSI/SCK, and issue procedure calls for
  *     each of them.  This driver can handle several such busses.
  *
- *   - The quicker inlined way:  only helps with platform GPIO code
- *     that inlines operations for constant GPIOs.  This can give
- *     you tight (fast!) inner loops, but each such bus needs a
- *     new driver.  You'll define a new C file, with Makefile and
- *     Kconfig support; the C code can be a total of six lines:
- *
- *		#define DRIVER_NAME	"myboard_spi2"
- *		#define	SPI_MISO_GPIO	119
- *		#define	SPI_MOSI_GPIO	120
- *		#define	SPI_SCK_GPIO	121
- *		#define	SPI_N_CHIPSEL	4
- *		#include "spi-gpio.c"
+ *   - The inlined way:  manually set up and register a gpiod_lookup_table with
+ *     the appropriately labelled gpio pins "sck", "mosi", "miso" & an array
+ *     named "cs" before calling devm_spi_register_controller (XXX).
  */
 
 #ifndef DRIVER_NAME
-- 
2.43.2


