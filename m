Return-Path: <linux-kernel+bounces-151442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F18AAF05
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C106B283C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5688812D745;
	Fri, 19 Apr 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="JTk3EAzo"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18C8594B;
	Fri, 19 Apr 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531639; cv=none; b=SA4uyLysbmE9treM7o0dAnjpneEbe/uMmG7FlwmSO7yE+ZSAWHcl8EeSTxMV6iwOcLfVX41A+6X6PF0tK8Yt1cLXtD60PyDHS97wr4WjCYbzPEvtGfSEXe7pdnN6o3L8Btcfx4mRvZpKeAueygqxGU3IWkPeTiVIOSSNCJCu+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531639; c=relaxed/simple;
	bh=7pKojDMQuVrZIIvqhT/X6XWwh8Z/cok7nF7ciMlN8BE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJyAWYlBrE6Y7z/cYDET+BJnwT19k5OHdckBVCiOx3bQS5NoBRAv4gu5z0otn/FbNAI+hF03yls2ldeiXhIOMjN4n0CkBZeu5Ox0suPhvBw5T1pXTry3x6W97FrnptyheQ662bAe6kzW1pm3GTUJNgzmGuuMh/erYL6vnOIIgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=JTk3EAzo; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DF042100007;
	Fri, 19 Apr 2024 16:00:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DF042100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713531626;
	bh=wKFbGy5kXF6YmVtQApc9Loyay81pnuGNBjJQMyo1XHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=JTk3EAzoeVCi0LAVhcBtRyaZ5iOqwv+J8I0jB2MdXcy47F5vYDm71XyOhTbhTbBGA
	 5HUXxV8cEAb+JkcncVQZkOVLVWVD89NrNNP/etjFUTN+0ScoY1rkmzA2Rf/I3n+PZu
	 XZWLPYNLuSScVsEX3ugY7ZYa6inHZvODmGW1rikza8alooapkWEXHbA0RSn2kyWBda
	 J+UnNddlNmjQlvRKcdL4iEbyTsuDoqWw6BCVV8UE2MyeTwWyjQaqb7E4MxLsGLRnPi
	 IieTMCcXrapmWJyYAR3xbxQ0eQefy3aTOf2kXlT7nI2fBrLqqd0Imp9JnWho6rFxrq
	 ByOzpbBrrv1DQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 19 Apr 2024 16:00:26 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Apr 2024 16:00:26 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v3 0/6] Add A1 Soc audio clock controller driver
Date: Fri, 19 Apr 2024 15:58:06 +0300
Message-ID: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184806 [Apr 19 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;lore.kernel.org:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/19 12:19:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/19 12:19:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/18 23:49:00 #24865988
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds support for audio clock and reset controllers on A1 SoC family.

Changes v2 -> v3
 - reset:
   * added auxiliary device
 - yaml:
   * added declaration of optional clocks
   * fixed names in example and another cosmetics
 - clocks:
   * reworked naming
   * stop using of "core" clock name
   * fixed wrong parenting

Changes v1 -> v2:
 - Detached from v1's series (patch 2, 3, 4, 25).
 - Reuse some of defines from axg-audio;
 - Split the controller into two memory regions.

Links:
 [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
 [2] https://lore.kernel.org/lkml/20240328010831.884487-1-jan.dakinevich@salutedevices.com/

Jan Dakinevich (6):
  reset: reset-meson-audio: introduce separate driver
  clk: meson: axg: share the set of audio helper macro
  clk: meson: axg: introduce AUD_MUX_TABLE() helper macro
  dt-bindings: clock: meson: document A1 SoC audio clock controller
    driver
  clk: meson: a1: add the audio clock controller driver
  arm64: dts: meson: a1: add the audio clock controller

 .../bindings/clock/amlogic,a1-audio-clkc.yaml | 124 ++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  46 ++
 drivers/clk/meson/Kconfig                     |  16 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/a1-audio.c                  | 651 ++++++++++++++++++
 drivers/clk/meson/axg-audio.c                 | 244 +------
 drivers/clk/meson/meson-audio.h               | 149 ++++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-meson-audio.c             | 207 ++++++
 .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++
 .../reset/amlogic,meson-a1-audio-reset.h      |  29 +
 include/soc/amlogic/meson-audio-reset.h       |  10 +
 13 files changed, 1371 insertions(+), 236 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml
 create mode 100644 drivers/clk/meson/a1-audio.c
 create mode 100644 drivers/clk/meson/meson-audio.h
 create mode 100644 drivers/reset/reset-meson-audio.c
 create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
 create mode 100644 include/soc/amlogic/meson-audio-reset.h

-- 
2.34.1


