Return-Path: <linux-kernel+bounces-128663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218AC895DDE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41B71F27EAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F1015DBB5;
	Tue,  2 Apr 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="oGeh1gvH"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283B2B9D8;
	Tue,  2 Apr 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090272; cv=none; b=arkIbFqbMnrqrLIW83z0f1EJEgRLd/FTitS5pwI7G7e+c8qG/nYF5ez8W91pmAct4RxxEuqONoCoPCnqcGZSWUJpH7rxO2c6L5NLfmsHrF3bMOwq+sjIPsrGUzDoWKnN2/5kG224Uit064Bv2rrwQTcPW/7G9pQIzD/cCKDNph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090272; c=relaxed/simple;
	bh=6Xrhbw6PvP/C4cqci2/uu8hCKyWsCfti56SDDRAnJno=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XX6owa1mi/TtCuKMbBEbjfg5VXaiy0ovvpse+YNX1J2mfW7HAnn8bqUFCcjifBEpg4ap+5Nklt7kxL160AucqUM8+TUGDj22V0H6aEf7wI2umz+7Bgw94D1TQu7Ow1zFi9FDgCJX2cWhAUAr5NoId7ySFJi7o3I4AEgJEyVq9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=oGeh1gvH; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 52E18100008;
	Tue,  2 Apr 2024 23:37:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 52E18100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712090260;
	bh=t2tHqsxYS8zoZJEGqRjan30QoziQPMtBbv04+Qu4qSI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oGeh1gvHQR6G1jzxf2b8eRj0ll8bP18T3CyiLJIbGlDemqYoaDd51wNgBUWu0AD3W
	 hwrHqWsNvrVuPECd8m/dsDTmK0WWx4j/G4lwF6ELkpMRl8bwPe1M0/vMvXpB+4FIZ2
	 w36oMAERlIA0NXoPvKnV5VTJ7Nknz7sdTnTs2DRwBqNG3CCxb3LLV9qJr1i23Y9LC1
	 GzXgRacp03u4jiQT4KlVBBJMexBC2VRmn3ikm6ikxNx4oDCRVMFAyda4miksJs69Iq
	 kmfBPiE1WJjzN/vc5KUu3qQVejmZZWI+DggEv/iOvFSsdvKN4Pfu/KyplkhOMKU7Wy
	 6I+Kx/aHFNmEw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  2 Apr 2024 23:37:40 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Apr 2024 23:37:39 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <oxffffaa@gmail.com>,
	<kernel@sberdevices.ru>, Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v1 0/2] Meson: R/W support for pages used by boot ROM
Date: Tue, 2 Apr 2024 23:27:03 +0300
Message-ID: <20240402202705.2355326-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184542 [Apr 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/02 18:05:00 #24580759
X-KSMG-AntiVirus-Status: Clean, skipped

Amlogic's boot ROM code needs that some pages on NAND must be written
in special "short" ECC mode with scrambling enabled. Such pages:
1) Contain some metadata about hardware.
2) Located with some interval starting from 0 offset, until some
   specified offset. Interval and second offset are set in the
   device tree.

This patchset adds R/W support for such pages. To enable it we can setup
it in dts:

    nand-is-boot-medium;
    meson,boot-page-last = <1024>;
    meson,boot-page-step = <128>;

It means that each 128th page in range 0 to 1024 pages will be accessed
in special mode ("short" ECC + scrambling). In practice this feature is
needed when we want to update first block of NAND - driver will enable
required mode by itself using value from device tree.

Arseniy Krasnov (2):
  dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
  mtd: rawnand: meson: support R/W mode for boot ROM

 .../bindings/mtd/amlogic,meson-nand.yaml      | 16 ++++
 drivers/mtd/nand/raw/meson_nand.c             | 88 +++++++++++++------
 2 files changed, 75 insertions(+), 29 deletions(-)

-- 
2.35.0


