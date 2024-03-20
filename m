Return-Path: <linux-kernel+bounces-108462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A67880ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DCF1F22CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496F15E9C;
	Wed, 20 Mar 2024 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MkiGkSFk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78047171A5;
	Wed, 20 Mar 2024 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913988; cv=none; b=SG8R/u2/emzbyRAQw6JbGSI4M8eatr6zwMVv0TrT0C1EdQjGp/DTqUOhv70kvWdjG5DP1fMjr/n1SpIZvMz/gbQxZLYCYdAqOaeEmv5k1gMhVnRD1AahinL7Tm1LOQwUK2GGaBG5st5LHd1CHqKR/aVh9j6Qai2elTZC58GIfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913988; c=relaxed/simple;
	bh=0LrxTVE0XKWIB1jGO9V/AOKAuidZcyOpzRVqKralvAA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GlL+XwpVGScBoPuqSFAStyJ4tWsZKJrb0eiXN2Ejfwcm1xqC6BK7PBxVWto5GSkn2R1ijy2Nqq5Rn5op8JXsvIJ+VgsWvZ2+lTIgWi9Qw+Up42Ezz8axMcskP9iMG5hHP6r4IQ7CHCFpzSYnAtfZr6SYnUE9lOWngw1NHaTfRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MkiGkSFk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710913986; x=1742449986;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=0LrxTVE0XKWIB1jGO9V/AOKAuidZcyOpzRVqKralvAA=;
  b=MkiGkSFk3AO0r0AwGrR7gPREwnoc59spR0/eP6S5vNvqqNB46cjeW7aQ
   kqm6Mkp3RfeAJRCsAOH1wWBHCSR6ghKcq3rE/uuTuy0wfa8orP9kwcZxI
   5uN4EufNLL6qXwdMe6PelVsYg8zYi5ik7zMEzPN2oXuGbjJhv1xLk6hY4
   RonOVU318EGi6J+ZBr5gD/bbdXDp3R+G941Ib323PGBgDSuIJa85L+WTx
   uRbI16imqNlPYxc0NHbmtHOgECT5OFFQoqoSKNjy60ONZyW+IOnzbGMVt
   Bw3Yt1VRUiEVFNNuuvBi2SYTYoFNI5Y73Yb7Y0r9+Mf/Qelq+ttlOgSU9
   w==;
X-CSE-ConnectionGUID: JdC9FX/zRcy0DPyWmaJLzA==
X-CSE-MsgGUID: 9PlCotqfSxuslw082RtqUA==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="17851042"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 22:53:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 22:52:49 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 22:52:42 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 0/3] dt-bindings: mtd: atmel-nand: convert txt to yaml
Date: Wed, 20 Mar 2024 11:22:06 +0530
Message-ID: <20240320-linux-next-nand-yaml-v1-0-2d2495363e88@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAId5+mUC/x3MwQ5FMBBA0V+RWZukrQbxK2JRDCZhSPueVMS/a
 yzP4t4bAnmmAE12g6eTA++SoPMMhsXJTMhjMhhlrCqMwpXlH1Eo/lCcjHi5bcW+Lis7kNWkC0j
 p4Wni+G3b7nlejAGuTWYAAAA=
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
X-Mailer: b4 0.13.0

Convert the text bindings to yaml.

Note:

This patch is done on top of the commit I sent recently.
https://lore.kernel.org/all/20240320025258.6854-1-balamanikandan.gunasundar@microchip.com/
Please let me know if I should resend the above commit in this series.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
Balamanikandan Gunasundar (3):
      dt-bindings: mtd: atmel-nand: convert txt to yaml
      dt-bindings: mtd: atmel-nand: add atmel pmecc
      dt-bindings: mtd: atmel-nand: add deprecated bindings

 .../bindings/mtd/atmel-nand-deprecated.yaml        | 156 ++++++++++++++
 .../devicetree/bindings/mtd/atmel-nand.txt         | 236 ---------------------
 .../devicetree/bindings/mtd/atmel-nand.yaml        | 166 +++++++++++++++
 .../devicetree/bindings/mtd/atmel-pmecc.yaml       |  58 +++++
 MAINTAINERS                                        |   2 +-
 5 files changed, 381 insertions(+), 237 deletions(-)
---
base-commit: 66e1bf9c75595f96cefe0c32a7a719ba71c11bef
change-id: 20240320-linux-next-nand-yaml-b8674ce41e13

Best regards,
-- 
Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>


