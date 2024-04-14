Return-Path: <linux-kernel+bounces-144250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508F8A4395
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B53B281D91
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D677134CC6;
	Sun, 14 Apr 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqP0/h7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0551350DB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109807; cv=none; b=oxmWwGeQwHLIs3cNVAGx/ywGG2FEG/d07r9jN+P6U/Z3JOg26AuI18xp7THLGtF2jtG87/ScDGAZuP0UI0ZWFkMTab5dQLxGWgrnBh+fhd0ni92KSl2B8NQ1JjLrwPXfPh9cI32wiFfOguphEXxp0CzJ9W6ElGtlmWozZZNgLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109807; c=relaxed/simple;
	bh=F/dkFtRddbz2rD/46WKCGJKyqSMQqrDqq6p70dPALoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mc4wHcP+aoziHFVPofeYUmzKGzvP5QMwgUsnwH13PBhAc7KPqirMlrs4I0ZpgYUadolnrukPKIwpxcuuytyeltOGOYkrP8ydqiarFOXZeYNNHi0Pf/fB0qciBEE9KDLjx23MeYGzsdR9HYAziOoV/mVukU4JTJ6s72NCAwVbbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqP0/h7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2BBC32781;
	Sun, 14 Apr 2024 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109807;
	bh=F/dkFtRddbz2rD/46WKCGJKyqSMQqrDqq6p70dPALoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqP0/h7eEJrEgYeb8NzQBvwLwECJ7r0h/HXjOtMfK1LzqGbjm4ofY4LCtkKOFFA66
	 5EnLYrlgyJd4hdhMB3ecGGJ06ij5Pdo+WbVIAZ2WHVSggRvGwEhmyrELoVO+eVfDtz
	 RUmuMaDk09pemnJOdeSbvR05o8ehVIcZKIXNquoU7pgLiYdARra5YF9umqzKjzZsPr
	 0/qfwZD6WlwiHsqyjPO0JWrcRHOCOL4Cm8bl/fRqXV+PesJP3kHWTuyDu2qKdGwYej
	 ZXQguBJkXdj4WSZq9EU6yWEown5ZBcO2gUEKPTgSZDvgxo/HgMJs6tdsP9OE4Cuzc6
	 1gKaOIKxx3U3w==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mtd: mchp23k256: drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:49:56 +0200
Message-Id: <20240414154957.127113-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240414154957.127113-1-krzk@kernel.org>
References: <20240414154957.127113-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID table already has respective entry and MODULE_DEVICE_TABLE and
creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/devices/mchp23k256.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/devices/mchp23k256.c b/drivers/mtd/devices/mchp23k256.c
index d533475fda15..cef5f9677d39 100644
--- a/drivers/mtd/devices/mchp23k256.c
+++ b/drivers/mtd/devices/mchp23k256.c
@@ -257,4 +257,3 @@ module_spi_driver(mchp23k256_driver);
 MODULE_DESCRIPTION("MTD SPI driver for MCHP23K256 RAM chips");
 MODULE_AUTHOR("Andrew Lunn <andre@lunn.ch>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:mchp23k256");
-- 
2.34.1


