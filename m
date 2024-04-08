Return-Path: <linux-kernel+bounces-135107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4D89BB42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575B5B22467
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C863C472;
	Mon,  8 Apr 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="kyCYvBRf"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFD3C6AC;
	Mon,  8 Apr 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567428; cv=none; b=fIOspk4wJ9vQtXOgmc4/W6DfyYHqUykIFudI0X82J4qTNHCD+K7brD/M0M5URfkxiPgJMYE4q7pN3zj6PxaAmBpCx2+UQTkcWXJ7QL4tngZI8c/jZU3ol8330R/LuBguCYIl1NElWIdnrBVpbkil6STEUCj/eoP1wd7UQMnMxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567428; c=relaxed/simple;
	bh=3BTt+1AUJwAlaBcpu5va8o0UT/OLJVcFtEROyWYd18M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AAwoZekEzcsIqHj1JPA+EBlcgrASoYwo42h+a+fmb1N+ogrcMOymmyNvzqqp/7TWH6DxfpEQJlJyxqswBUYcbIwEFIvsMjEOG/3AChd0chHRY5mBtOm/vL3bK/xKq9KTZaN2KgthWub+DtA62h/+zQN6wxEEz3Pb4Toqkf7+9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=kyCYvBRf; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9905C120018;
	Mon,  8 Apr 2024 12:10:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9905C120018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712567420;
	bh=Dl0lEJ2RQvUAsdbkNPBDUxXmtzfTz0ubHkllEirkE18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kyCYvBRfBw7/ucgp3jTdLpKIOChBySp1fZQy0q7SPk1NoxlmOpjpb1WsX3SBzHFnk
	 iqYKwcyedUO/GaUK3CRgW7rsalpOUWjl9IEmUNCi5DnuXPbBQNgaqOxxU6NevklWbT
	 c7lfNtoTj8vpNqWRtw9B8Q7d0wgR98I4CAuzoSgQM4Q8wwWIYmAwCwLIjFTrwpyy9/
	 aUKP78cZG7ttmBwozySRqUU6u0u9LD/qtv4+aM9A1GGWD8eqTg0aDnnXFs7j5fH92V
	 I/s/Lj7ipesPdtyYk96oonH916ogAgvDy/8+8g56yQdhQaYimfuJTBOmSfw5ptmEN2
	 Qn++t+aBs4nGA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 12:10:20 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Apr 2024 12:10:20 +0300
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
Subject: [PATCH v2 0/2] Meson: R/W support for pages used by boot ROM
Date: Mon, 8 Apr 2024 11:59:29 +0300
Message-ID: <20240408085931.456337-1-avkrasnov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184614 [Apr 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/08 06:07:00 #24706059
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
    amlogic,boot-page-last = <1024>;
    amlogic,boot-page-step = <128>;

It means that each 128th page in range 0 to 1024 pages will be accessed
in special mode ("short" ECC + scrambling). In practice this feature is
needed when we want to update first block of NAND - driver will enable
required mode by itself using value from device tree.

Changelog:
 v1 -> v2:
  * Rename 'meson,boot-page-XXX' -> 'amlogic,boot-page-XXX'.
  * Add words that 'amlogic,boot-page-step' is measured in pages.
  * Remove words that 'amlogic,boot-page-XXX' depends on 'nand-is-boot-medium'.
  * Make both 'amlogic,boot-page-XXX' depend on each other also, in
    addition to 'nand-is-boot-medium' dependency.

Arseniy Krasnov (2):
  dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
  mtd: rawnand: meson: support R/W mode for boot ROM

 .../bindings/mtd/amlogic,meson-nand.yaml      | 14 +++
 drivers/mtd/nand/raw/meson_nand.c             | 88 +++++++++++++------
 2 files changed, 73 insertions(+), 29 deletions(-)

-- 
2.35.0


