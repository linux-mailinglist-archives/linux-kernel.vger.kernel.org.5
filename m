Return-Path: <linux-kernel+bounces-140525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653328A15C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BC91C21E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519EF14D43D;
	Thu, 11 Apr 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZpLryE+6"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AE145FFA;
	Thu, 11 Apr 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842736; cv=none; b=aHKMDBjgffmyg718qw7Xlc4EPwOjHDV6t7UDHuuanUrvmYYbAmWztzeOii3IZi0PyPicQQe+t18SZVifnPfgV54bZjyjaTB3gFNK3ejSYjImAI7VFtHSnc1iHpwZAk2X+kZPDtmKWCPBzDc+sMOha/YCtwQGsFYM/iKUTGD47EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842736; c=relaxed/simple;
	bh=cYsl/oiu4j/xkoJTZV4MhH9pfcAuMOByGFV5r9tA7Jc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f913p5WVIxpxm6RS3jU43dbHD0QTxT/eS3bECMC+bVAQMJV6hjBpiM02DqT1qT/ZunvAOtOVjAuJCft1JCbRcLwjeN/fkir/MzzhzXdz2wjNc+nHQ7z51Ze6JeT9C6lfyQcGV0nPASg1XjLJB7jcqgrIROLlbMx4hzfjj2T6+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ZpLryE+6; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3E53D120065;
	Thu, 11 Apr 2024 16:38:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3E53D120065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712842728;
	bh=g/cmZ5EcPxVqLW90J3yJ5sNPqD6vla76/ub4sdzsxzk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ZpLryE+6hwve/7olN4Us/EgR+ZLJNQnc/cighsMUObSdI3AGWbqakdv6NkN4p3ykN
	 R5FvZjjzq4rf3cY8BJjT1q/7COzDHdA60oiamOBfxuNzLVy2buQQRtvCbEx3EDY8TK
	 eSmcomtR2sh3Tv2hZKx8096lzGjv94jauuj09Kj3M1G61iy7cMT0Xtiz6XFNN0rNmx
	 m+xiC5TUp6a8Y7+FbZf1GIKFrYbDkokdvywxHRIBR8ltX4kPcMaWgURQ4bzEXrN0hY
	 RHP3eJrnD2k7eusfMwUWf3tNwbq0nA6aUUKIT8tnVaCGl9KUDLj5rKCm8NzB0diQxN
	 fIWEc9CX+WKjw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 16:38:48 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Apr 2024 16:38:46 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <vadim.fedorenko@linux.dev>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v7 00/23] Support more Amlogic SoC families in crypto driver
Date: Thu, 11 Apr 2024 16:38:09 +0300
Message-ID: <20240411133832.2896463-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
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
X-KSMG-AntiSpam-Lua-Profiles: 184672 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;gist.github.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/11 07:46:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/11 07:47:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/11 09:22:00 #24744908
X-KSMG-AntiVirus-Status: Clean, skipped

Hello!

This patchset expand the funcionality of the Amlogic
crypto driver by adding support for more SoC families:
AXG, G12A, G12B, SM1, A1, S4.

Also specify and enable crypto node in device tree
for reference Amlogic devices.

Tested on GXL, AXG, G12A/B, SM1, A1 and S4 devices via
custom tests [1] and tcrypt module.

---

Changes V1 -> V2 [2]:

- Rebased over linux-next.
- Adjusted device tree bindings description.
- A1 and S4 dts use their own compatible, which is a G12 fallback.

Changes V2 -> V3 [3]:

- Fix errors in dt-bindings and device tree.
- Add new field in platform data, which determines
whether clock controller should be used for crypto IP.
- Place back MODULE_DEVICE_TABLE.
- Correct commit messages.

Changes V3 -> V4 [4]:

- Update dt-bindings as per Krzysztof Kozlowski comments.
- Fix bisection: get rid of compiler errors in some patches.

Changes V4 -> V5 [5]:

- Tested on GXL board:
  1. Fix panic detected by Corentin Labbe [6].
  2. Disable hasher backend for GXL: in its current realization
     is doesn't work. And there are no examples or docs in the
     vendor SDK.
- Fix AES-CTR realization: legacy boards (gxl, g12, axg) requires
  inversion of the keyiv at keys setup stage.
- A1 now uses its own compatible string.
- S4 uses A1 compatible as fallback.
- Code fixes based on comments Neil Atrmstrong and Rob Herring.
- Style fixes (set correct indentations)

Changes V5 -> V6 [7]:

- Fix DMA sync warning reported by Corentin Labbe [8].
- Remove CLK input from driver. Remove clk definition
  and second interrput line from crypto node inside GXL dtsi.

Changes V6 -> V7 [9]:

- Fix dt-schema: power domain now required only for A1.
- Use crypto_skcipher_ctx_dma() helper for cipher instead of
  ____cacheline_aligned.
- Add import/export functions for hasher.
- Fix commit message for patch 17, acorrding to discussion [10].

Links:
  - [1] https://gist.github.com/mRrvz/3fb8943a7487ab7b943ec140706995e7
  - [2] https://lore.kernel.org/all/20240110201216.18016-1-avromanov@salutedevices.com/
  - [3] https://lore.kernel.org/all/20240123165831.970023-1-avromanov@salutedevices.com/
  - [4] https://lore.kernel.org/all/20240205155521.1795552-1-avromanov@salutedevices.com/
  - [5] https://lore.kernel.org/all/20240212135108.549755-1-avromanov@salutedevices.com/
  - [6] https://lore.kernel.org/all/ZcsYaPIUrBSg8iXu@Red/
  - [7] https://lore.kernel.org/all/20240301132936.621238-1-avromanov@salutedevices.com/
  - [8] https://lore.kernel.org/all/Zf1BAlYtiwPOG-Os@Red/
  - [9] https://lore.kernel.org/all/20240326153219.2915080-1-avromanov@salutedevices.com/
  - [10] https://lore.kernel.org/all/20240329-dotted-illusive-9f0593805a05@wendy/

Alexey Romanov (23):
  drivers: crypto: meson: don't hardcode IRQ count
  drviers: crypto: meson: add platform data
  drivers: crypto: meson: remove clock input
  drivers: crypto: meson: add MMIO helpers
  drivers: crypto: meson: move get_engine_number()
  drivers: crypto: meson: drop status field from meson_flow
  drivers: crypto: meson: move algs definition and cipher API to
    cipher.c
  drivers: crypto: meson: cleanup defines
  drivers: crypto: meson: process more than MAXDESCS descriptors
  drivers: crypto: meson: avoid kzalloc in engine thread
  drivers: crypto: meson: introduce hasher
  drivers: crypto: meson: add support for AES-CTR
  drivers: crypto: meson: use fallback for 192-bit keys
  drivers: crypto: meson: add support for G12-series
  drivers: crypto: meson: add support for AXG-series
  drivers: crypto: meson: add support for A1-series
  dt-bindings: crypto: meson: remove clk and second interrupt line for
    GXL
  arch: arm64: dts: meson: gxl: correct crypto node definition
  dt-bindings: crypto: meson: support new SoC's
  arch: arm64: dts: meson: a1: add crypto node
  arch: arm64: dts: meson: s4: add crypto node
  arch: arm64: dts: meson: g12: add crypto node
  arch: arm64: dts: meson: axg: add crypto node

 .../bindings/crypto/amlogic,gxl-crypto.yaml   |  33 +-
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   7 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   6 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |   6 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |   5 +-
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   6 +
 drivers/crypto/amlogic/Makefile               |   2 +-
 drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 629 ++++++++++++------
 drivers/crypto/amlogic/amlogic-gxl-core.c     | 292 ++++----
 drivers/crypto/amlogic/amlogic-gxl-hasher.c   | 482 ++++++++++++++
 drivers/crypto/amlogic/amlogic-gxl.h          | 116 +++-
 11 files changed, 1221 insertions(+), 363 deletions(-)
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c

-- 
2.34.1


