Return-Path: <linux-kernel+bounces-78871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B618619F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6434328663D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704E13A862;
	Fri, 23 Feb 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EVNerFQz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD71E503
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709472; cv=none; b=C6KSN7j84Nbmf/cfvD69jrrYTxZpe9sFnrUPyRSLaQZYibZ5NTU0Ue1BuHWCs3HvBqBa3AVMvd2fjFuQDnMPtJGVNMjBXs/4Eg2X6FmD7U6+vtXORQScXly2xl0ydbKGs9uCtQ7dZzzN7cbylYAG3wkDbUy+79YvLTFx8hzZ2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709472; c=relaxed/simple;
	bh=MzE6ItZ/794POonRjSZ60qB1SlzVtmy0+kfDCLFkHkw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdXg1iRH8n56lT1SkxXhzSRk3LQ2El0Hd50ALuFwhppP2GHFou29W5D8/clWzXZXIsiLA26cgyiRk8e6QREpNrHf5QmnrzclXCoZyTNxOSiBv1r+dCyyjwB3f0lZ+meYponNA3mKTf0//magsnadEs5ALGliHBf6SE4HI2OOJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EVNerFQz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709470; x=1740245470;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=MzE6ItZ/794POonRjSZ60qB1SlzVtmy0+kfDCLFkHkw=;
  b=EVNerFQz31XXh4J8lsqemE6KZNDtz3zUsLw5NFajh4qLEN9tQpAOJmgc
   hC9b0LwbLMjnARI9+k78EugFUmflzTt/Pz0BQK8SmYw5I7LEb3a6O8J4O
   B45SZtF6NFknhpxHPmhWsd/4Z4z7usSaSP2tw1JaBuerrZSZubgjYXdte
   P2Bd/cLsqa4dxaPd9UygCfqEtJiZQX+bWu3owle4SEYSLS3jNbKt4R0bE
   rKpmj4T1EEpTM8y4q1sqskn6cmkwI1XKDfXM8qsJmlBIpPQr4749lale1
   lXrYs5v4P3kxHc9iUP+02GU4/8rPAHOfQp0OBxrlbCHmc3NX9no1BpkxO
   g==;
X-CSE-ConnectionGUID: HW6DC9r8Rxq9ZVuQvdhHkA==
X-CSE-MsgGUID: nwDNCmYJTEWmtglnSsY7yw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="18276496"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:31:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:30:50 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:30:45 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>, <arnd@arndb.de>,
	<geert+renesas@glider.be>, <mpe@ellerman.id.au>, <palmer@rivosinc.com>,
	<vbabka@suse.cz>, <rdunlap@infradead.org>,
	<varshini.rajendran@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 36/39] ARM: configs: at91: enable config flags for sam9x7 SoC family
Date: Fri, 23 Feb 2024 23:00:43 +0530
Message-ID: <20240223173043.673442-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable config flags for SAM9X7 SoC for the sam9x7 SoC family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 1d53aec4c836..880f0c0f4cc3 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -16,6 +16,7 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
 CONFIG_SOC_SAM9X60=y
+CONFIG_SOC_SAM9X7=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-- 
2.25.1


