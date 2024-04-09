Return-Path: <linux-kernel+bounces-137456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A582989E268
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CA21C23048
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FF5156C5C;
	Tue,  9 Apr 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vUH4myao"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF513B284;
	Tue,  9 Apr 2024 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686879; cv=none; b=HSoVOcmpZ1lIxh1qpLtaZETAGMoZ+hiMlRykmOnQkNYxr8/DygsFGZLdD18p90/Xpl3MZE9cYsBoUpivQrF+d6cyND/LvfFDBYd0Nhs7sna1thRBU6moei0CxyRZ/UD28lWpCQEujbiM6WyUg5sDPvuGIG+op63DZ/Al4MXZ2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686879; c=relaxed/simple;
	bh=x8d2ovxUFoo/Rw29RRXNM8AzhmaYzw07hQyEbx6y3uc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJYGjy+mlq3wpAphdUrhSVy/FzsC+qzGFwSmkLvbz6M/PeATf3KWhBVG+qaPr0J6wbkn+SCtg6ZSTPQ6kiz407U6H/tuPxdW8An48sXQ/YGIenHZKqfc5SE9hDJMrFJ/TQ3swfCCi9bcx00N5oIVG+braelzhxv80XCcWtBGLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vUH4myao; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8E7F410004E;
	Tue,  9 Apr 2024 21:21:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8E7F410004E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712686872;
	bh=QZwk+YSIX1yZDPOX63O30JuCgB29OkKBRzU0do3JaVA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=vUH4myaogS72/QwazfmzARXzLqqPehzhI11M7dwROCbkPP8Qc3hrZ4ZuV0f5M64p7
	 f42HidsP+PbFEuUbNz92q8MT9lSUAFz1XcpFXAhBCmL8Qu81j2Rlbznc2WHGvD9DJD
	 +fRM+545PjwgfS41xi38/KakA1bq0IuyRPR66z9SCuUShkO8KiPjeozCeXXQH+jkgn
	 2+PR7jIdSOp1Q0oXMfr/sQOeiyK4pNUc1aDokVXFbUb6MBGWvPZd0wIEAbuU5WlaiH
	 J4Ah+lDp4L4B0DYYseFtPLqfHQ8Q/Fn8lxd2ao8nwJz7sajvh1BmlK7Yd60ykBVnLW
	 E2KGCc1H5nojQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Apr 2024 21:21:12 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Apr 2024 21:21:12 +0300
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
Subject: [PATCH v3 0/2] Meson: R/W support for pages used by boot ROM
Date: Tue, 9 Apr 2024 21:10:23 +0300
Message-ID: <20240409181025.55504-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184641 [Apr 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/09 14:21:00 #24719986
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
 v2 -> v3:
  * Add quotes to 0001 in dependencies. This fixes 'make dt_binding_check'
    warning.

Arseniy Krasnov (2):
  dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
  mtd: rawnand: meson: support R/W mode for boot ROM

 .../bindings/mtd/amlogic,meson-nand.yaml      | 14 +++
 drivers/mtd/nand/raw/meson_nand.c             | 88 +++++++++++++------
 2 files changed, 73 insertions(+), 29 deletions(-)

-- 
2.35.0


