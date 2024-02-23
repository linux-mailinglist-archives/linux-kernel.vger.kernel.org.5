Return-Path: <linux-kernel+bounces-78855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058B48619C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3674B1C253B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402D4140377;
	Fri, 23 Feb 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="scERPHKb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570612BF0E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709276; cv=none; b=RW4XNnGCQfQVMqy/J1OeWet0e2PACfBimt9fGkUKyeeKmCD/fCcnN0h65yaiGzErSKz+Sfne0qxyUM1Nxrgn9O2HXcj5tzhzRHp4QFzPVmG5FAZIiJ6ysj/g7aeXs4F+IVwQDhjYXGW10KasCkBg7Tgl+D+6o8rCqJoXnYbSbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709276; c=relaxed/simple;
	bh=SalObWM9FigCU2Fn7WR+PPhV8N178DvXnGJ19TAnF18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAuIgUewDwbuQRS/IgPBqYO2FztrB3/xJAgf3ExVnKtss97ZkymcA4U+KZo4yM/NJ2FmLdXgJNaw2S7xBRlQhqCvlly2DbMuySFZP8wLXcr1LXiqiVccmZT+N3SU8LpZW2+B9G9xcyia2h6QxfbkmaMoOq1ExfjAGkWQnhZLvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=scERPHKb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709276; x=1740245276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SalObWM9FigCU2Fn7WR+PPhV8N178DvXnGJ19TAnF18=;
  b=scERPHKbeWdFGLdbVo/82jz9/eq03yVpc54B+Rrk48NezoHaqjtCeYBd
   GVU0pMWXLs3FE/3gq66VeyXsqyFIrkn0pAaUePKBVWCt65WxSUsh5YrxZ
   6s+5KG6e7N8E48L/7V6ysZCC6VPCdBFMe3sJWSeqiLXk3bDwdvWC45JZd
   DN2Eafp8XyCe5i9T1512ICJh3u29ZDq5jneO2AqEjNauxegy57hHtzKeX
   NCOA5pIxC9dht7VvXBx6uiJJV1Gpf9vaI+k+ym/dMfUE4JyYqQ1sUVwBJ
   39EMr1L2jKlrQNXa2vOSoeCY4hUNr1ETF0gQ16o+JZHN5s+iAc11BM8IC
   Q==;
X-CSE-ConnectionGUID: VJwSy7CGT9OoHBfoc7EWkg==
X-CSE-MsgGUID: spaCYGWeRzWNJ6BVFSZzjA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="247481514"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:27:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:27:31 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:27:28 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 20/39] ARM: at91: add support in SoC driver for new sam9x7
Date: Fri, 23 Feb 2024 22:57:22 +0530
Message-ID: <20240223172722.672592-1-varshini.rajendran@microchip.com>
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

Add support for SAM9X7 SoC in the SoC driver.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Changes in v4:
- Sorted the entries alphabetically as per comment from Claudiu
- Updated EXID
Note: Did not remove the Reviewed-by tag since the changes were only
cosmetic and did not affect functionality
---
 drivers/soc/atmel/soc.c | 23 +++++++++++++++++++++++
 drivers/soc/atmel/soc.h |  9 +++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index cc9a3e107479..cae3452cbc60 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -101,6 +101,29 @@ static const struct at91_soc socs[] __initconst = {
 		 AT91_CIDR_VERSION_MASK, SAM9X60_D6K_EXID_MATCH,
 		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
 #endif
+#ifdef CONFIG_SOC_SAM9X7
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X72_EXID_MATCH,
+		 "sam9x72", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X70_EXID_MATCH,
+		 "sam9x70", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 1Gb DDR3L SiP ", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 512Mb DDR2 SiP", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 128Mb DDR2 SiP", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 2Gb DDR3L SiP", "sam9x7"),
+#endif
 #ifdef CONFIG_SOC_SAMA5
 	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAMA5D21CU_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 7a9f47ce85fb..fc4157c5f6e3 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -44,6 +44,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
+#define SAM9X7_CIDR_MATCH		0x09750020
 #define SAMA7G5_CIDR_MATCH		0x00162100
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
@@ -74,6 +75,14 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA7G54_D2G_EXID_MATCH		0x00000020
 #define SAMA7G54_D4G_EXID_MATCH		0x00000028
 
+#define SAM9X70_EXID_MATCH		0x00000005
+#define SAM9X72_EXID_MATCH		0x00000004
+#define SAM9X75_D1G_EXID_MATCH		0x00000018
+#define SAM9X75_D2G_EXID_MATCH		0x00000020
+#define SAM9X75_D1M_EXID_MATCH		0x00000003
+#define SAM9X75_D5M_EXID_MATCH		0x00000010
+#define SAM9X75_EXID_MATCH		0x00000000
+
 #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
 #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
-- 
2.25.1


