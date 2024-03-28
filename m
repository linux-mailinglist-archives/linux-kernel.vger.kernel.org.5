Return-Path: <linux-kernel+bounces-122259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A78288F45E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864AC1F2493F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309B32375B;
	Thu, 28 Mar 2024 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="IEbJU/cD"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED418C22;
	Thu, 28 Mar 2024 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588201; cv=none; b=O2rRRQfiZy8pO8UUzkYIgTTntLtVP3YXEGsRPw6kaaFggx3H8wZEotREGdQfGVmrslY70KqKqb2IwGrbMpeRneplRtr2UZEQSX3/z0XVvbeoLO8hfPRcZREBPsfte9EYm7eNHk87GAJ89oGzLQ5XuqwnvfGE3MZd9kLc7+cbsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588201; c=relaxed/simple;
	bh=0wZS6e8223t8HdfHyFmZeurTXj6wd2M5GF+PWgyw1Wo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A8RDCT2hfWZTa0g45J2C9RbCW7oDG27WUM+37ME7/nMAFQKuSsxs41ZwyXB1ZAvZS9vWXdQ+hn1CDNL9asXTgLoddPudg6S2Z4nwnOeit39HkuOrO9LgiL3hx2tFWul0zNMkBw0KZND6tcT4I/RVz5heNox4Rj4DFP6SY2pmiTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=IEbJU/cD; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A0F2A100013;
	Thu, 28 Mar 2024 04:09:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A0F2A100013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711588191;
	bh=37MYTDLUrT8ifUqapj/v8ztNZZHrBVw96rI4MOrEYP0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IEbJU/cDongNfeDDtxTWgEwcSxg/PpC3ocspry+5WSWr7YXAD4N2MxsPMQRVfs28U
	 dnjWavBnGcH5NIl/hfJ997j0tGaAYUEkYs8HblBvrheS4ULPTpkPcoxnNBmJr04fLE
	 gdqihwocvPf4crgYZC74fn/qwgx3J5XZ+RNJ2d8ifbBxMg0PFwnpB1AA+z/1SvCjJb
	 oTDo++uaRaZ3R7PRV3ZUvZ6VxKDBHUJjXHwpXUhBJaCCb8LpQsBJiylRQMyKDyByys
	 wEMLzLi1RGv7eWzQqzX7nDQz4c2W38cyJ6/lDHueKlNIV2T8K8YvrpC1VbeYyiRQNk
	 tkITtssp3+2DA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 04:09:51 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 04:09:46 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v2 0/5] Add A1 Soc audio clock controller driver
Date: Thu, 28 Mar 2024 04:08:26 +0300
Message-ID: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184457 [Mar 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 13 0.3.13 9d58e50253d512f89cb08f71c87c671a2d0a1bca, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/27 23:57:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/28 01:00:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 00:06:00 #24481831
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds support for audio clock and reset controllers on A1 SoC family.

Links:

 [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/

Changes v1 -> v2:
 - Detached from v1's series (patch 2, 3, 4, 25).
 - Reuse some of defines from axg-audio;
 - Split the controller into two memory regions.

Jan Dakinevich (5):
  clk: meson: axg: move reset controller's code to separate module
  clk: meson: axg: share the audio helper macro
  dt-bindings: clock: meson: document A1 SoC audio clock controller
    driver
  clk: meson: a1: add the audio clock controller driver
  arm64: dts: meson: a1: add the audio clock controller

 .../bindings/clock/amlogic,a1-audio-clkc.yaml | 141 ++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  48 ++
 drivers/clk/meson/Kconfig                     |  18 +
 drivers/clk/meson/Makefile                    |   2 +
 drivers/clk/meson/a1-audio.c                  | 624 ++++++++++++++++++
 drivers/clk/meson/a1-audio.h                  |  45 ++
 drivers/clk/meson/axg-audio.c                 | 233 +------
 drivers/clk/meson/meson-audio-rstc.c          | 109 +++
 drivers/clk/meson/meson-audio-rstc.h          |  12 +
 drivers/clk/meson/meson-audio.h               | 143 ++++
 .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++
 .../reset/amlogic,meson-a1-audio-reset.h      |  29 +
 12 files changed, 1297 insertions(+), 229 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml
 create mode 100644 drivers/clk/meson/a1-audio.c
 create mode 100644 drivers/clk/meson/a1-audio.h
 create mode 100644 drivers/clk/meson/meson-audio-rstc.c
 create mode 100644 drivers/clk/meson/meson-audio-rstc.h
 create mode 100644 drivers/clk/meson/meson-audio.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h

-- 
2.34.1


