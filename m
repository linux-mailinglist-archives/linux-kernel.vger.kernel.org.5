Return-Path: <linux-kernel+bounces-78860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB498619D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC691F26F32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1917014CABC;
	Fri, 23 Feb 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SQqwHMrw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A312DD85;
	Fri, 23 Feb 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709317; cv=none; b=Qu3gTEp+/2XGvGuiwkcY1BeBsOhEZe808fxAhD/03IKNfr8aVlooXhhxDB15B9Yc4gybv8q2A+h2rZ8fZGVhfs/BLProRPl9O6w3xpNfzie1v4nmKhXdy+qCw9AxDgVo7iYtfqTUcObf1t2Xl8dhGVfh5zij05pBykQ3ndciGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709317; c=relaxed/simple;
	bh=mzGYFdm3v1XDGFucUtcC36Y7oX4EkJ+bnjLPq/ua1Ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXCI6Rk5LfKhj+M8jad3n64tGUrotYWd5q9sXvuj9MRpGjn4OCkdjQ1U1bI64Ce9JTLsvGf/qElJdTXa1v0516Li0DnAuXerjrCu+/YexiC0i22xH+3Gtc9SvEuFIUhWK47lJ6FkM/YBjNhhDsaCJoY+Cse1byQ9OIMTo3si6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SQqwHMrw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709315; x=1740245315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mzGYFdm3v1XDGFucUtcC36Y7oX4EkJ+bnjLPq/ua1Ck=;
  b=SQqwHMrw4YBObwIoQuKqC53wr+/aytNtHhXAuXE7Vrqfx4HQ3E0YL1Mh
   /DRcaYChiWv68KKQ+NNwBPy3vFNx4VEZkSe4Fu4x4IlZqpPTkR6m3B/YM
   l8sd3pKOur598mCJOeGAs5dRRw6kbboAZxWzuecEOJtb+1m795rWAYdPm
   lUMLHAN6c0Z2LFHNLFpw8oFsYuL8qCn+K+Suw4f591Hd5zuois0xnsa+s
   ImKuGj9SPxqzmF9TDxamywVS8mZEMbSuMe+1XmlPsMnEW4LUSOiqqgIfl
   NTg+KmYGFxD1U9MCACwezqCx5L7UFQr4jwxpsPMUp4HZVwHO8oerU9rYW
   A==;
X-CSE-ConnectionGUID: J2gaCqTjSWW69xa5fHD66A==
X-CSE-MsgGUID: 0uaOQgYvT4ulCAfYELEKEQ==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="18276287"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:28:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:28:30 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:28:25 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v4 26/39] dt-bindings: clock: at91: Allow PLLs to be exported and referenced in DT
Date: Fri, 23 Feb 2024 22:58:22 +0530
Message-ID: <20240223172822.672902-1-varshini.rajendran@microchip.com>
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

Allow PLLADIV2 and LVDSPLL to be referenced as a PMC_TYPE_CORE
clock from phandle in DT for sam9x7 SoC family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 include/dt-bindings/clock/at91.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 3e3972a814c1..6ede88c3992d 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -38,6 +38,10 @@
 #define PMC_CPU			(PMC_MAIN + 9)
 #define PMC_MCK1		(PMC_MAIN + 10)
 
+/* SAM9X7 */
+#define PMC_PLLADIV2		(PMC_MAIN + 11)
+#define PMC_LVDSPLL		(PMC_MAIN + 12)
+
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
 #define AT91_PMC_LOCKA		1		/* PLLA Lock */
-- 
2.25.1


