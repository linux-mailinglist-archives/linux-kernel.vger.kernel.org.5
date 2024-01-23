Return-Path: <linux-kernel+bounces-35726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9884983959C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B0428BF90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7380033;
	Tue, 23 Jan 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gplF/fd+"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913747FBB4;
	Tue, 23 Jan 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029128; cv=none; b=ZxIxsD2NeiUXU6setlfzD1UnIyT1V7U2+0EB2W+7iZaCKgvs+VQDIEGxcTBvLdMCCGCeSbScrWgI1i95Amip4xFbLyRgvQrsw2p428S6RDyrDCdL57FYYH+CDg24mVq9wZn/mgd5nTaWLWWPRlwGx1Cy/gew9Cz5dOjWT34qlws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029128; c=relaxed/simple;
	bh=n9chiGVZ7ikmTakMXFC2zYvUDAvG9Y4v6GvQ/j4rxME=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFhYCiZwQuF1X9oPh9B33njNBrSQfvT4BwM34vjW/xXr1HQledxcGOkCZ55xV4D1d2sQ2MG31yi/SaNAE471+ifaE/8BlekRJf/5vwDyg3QddA19MCiOTZerMXcusEZSmrWz7hpje+DoNdcoQBz2p4ixstXd+MTCOmnYhlhVrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gplF/fd+; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E52DB12000C;
	Tue, 23 Jan 2024 19:58:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E52DB12000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706029120;
	bh=X6dDhX7s4UWSn6jo6T+Mv0rP4UhHPB3J5T7leAbh0jE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gplF/fd+jZDMpCENjMNbi19L6oCuvWZ6IfkfAuIm/AfZeE4+1CoWdfpS58Er7XaIi
	 ADyaU7LXC/8fYknIAsitNsTT6CYrwCPCMYAiwjOIfrYu8IoLzshHC2edFCB3OlnHSA
	 Ry+iIxOWjDAoZR+0Rp7SlbbTRNEQlc2KGIHHZZ0ZW///DUmUzOMcyN40eCCYUlg0ob
	 HmSiSLXNezQI4LinwVrO/upIcMI6sCVpCqIpAWdJipNTJH5CioPwEU36431tg3j1no
	 xm74ks2Xp3p0tsxiRbik+ZsB8I8yqK95xjr+sivhYwt6WLx1gGktG4GWoB60Z6crBA
	 IXSGMS6BLuj7Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Jan 2024 19:58:40 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 19:58:40 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 00/20] Support more Amlogic SoC families in crypto driver
Date: Tue, 23 Jan 2024 19:58:11 +0300
Message-ID: <20240123165831.970023-1-avromanov@salutedevices.com>
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
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182874 [Jan 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/01/23 15:06:00
X-KSMG-LinksScanning: Clean, bases: 2024/01/23 10:08:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/23 13:53:00 #23383939
X-KSMG-AntiVirus-Status: Clean, skipped

Hello!

This patchset expand the funcionality of the Amlogic
crypto driver by adding support for more SoC families:
AXG, G12A, G12B, SM1, A1, S4.

Also specify and enable crypto node in device tree
for reference Amlogic devices.

Tested on AXG, G12A/B, SM1, A1 and S4 devices via
custom tests and trcypt module.

---

Changes V1 -> V2:

- Rebased over linux-next.
- Adjusted device tree bindings description.
- A1 and S4 dts use their own compatible, which is a G12 fallback.

V1: https://lore.kernel.org/all/20240110201216.18016-1-avromanov@salutedevices.com/

Alexey Romanov (20):
  drivers: crypto: meson: don't hardcode IRQ count
  drivers: crypto: meson: make CLK controller optional
  drviers: crypto: meson: add platform data
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
  dt-bindings: crypto: meson: add new compatibles
  arch: arm64: dts: meson: a1: add crypto node
  arch: arm64: dts: meson: s4: add crypto node
  arch: arm64: dts: meson: g12: add crypto node
  arch: arm64: dts: meson: axg: add crypto node

 .../bindings/crypto/amlogic,gxl-crypto.yaml   |  31 +-
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   7 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   6 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |   6 +
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   6 +
 drivers/crypto/amlogic/Makefile               |   2 +-
 drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 602 ++++++++++++------
 drivers/crypto/amlogic/amlogic-gxl-core.c     | 281 ++++----
 drivers/crypto/amlogic/amlogic-gxl-hasher.c   | 452 +++++++++++++
 drivers/crypto/amlogic/amlogic-gxl.h          | 115 +++-
 10 files changed, 1165 insertions(+), 343 deletions(-)
 create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c

-- 
2.34.1


