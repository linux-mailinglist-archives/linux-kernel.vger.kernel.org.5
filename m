Return-Path: <linux-kernel+bounces-22320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873A829C28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AA3284996
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0401A4B5BA;
	Wed, 10 Jan 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IOmkYYse"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89A4E1CA;
	Wed, 10 Jan 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AE97RM037953;
	Wed, 10 Jan 2024 08:09:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704895747;
	bh=1TUaU5gWQ03/IkCqPSd9Gu2bzpk8j38xpiaWeQRjiDA=;
	h=From:To:CC:Subject:Date;
	b=IOmkYYsedjsyHlwT8wXOyS8G8N+5xz/f4MVZRTVYWnFb6QrCIKoKXyYzDrkSHsuTF
	 80nB1JKPMiotMDN+V2WCXp5BFkxdfRvWcxp2Q3hO5L7Ago6d1YpsT2oMLHd/jrXO1x
	 MJtCaw2BGBzTvb8Y1jmUJy2CWxsI/gDAZy9UgN8U=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AE9628026312
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 08:09:06 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 08:09:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 08:09:06 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AE960M041047;
	Wed, 10 Jan 2024 08:09:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Apelete Seketeli
	<aseketeli@baylibre.com>,
        Ayush Singh <ayushdevel1325@gmail.com>,
        Chao Zeng
	<chao.zeng@siemens.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        Garrett Giordano <ggiordano@phytec.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Jerome
 Neanne <jneanne@baylibre.com>,
        Julien Panis <jpanis@baylibre.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>,
        Le Jin <le.jin@siemens.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Peng Fan
	<peng.fan@nxp.com>, Pierre Gondois <pierre.gondois@arm.com>,
        Robert Nelson
	<robertcnelson@gmail.com>,
        Rob Herring <robh@kernel.org>, Roger Quadros
	<rogerq@kernel.org>,
        Ronald Wahl <ronald.wahl@raritan.com>,
        Sarah Walker
	<sarah.walker@imgtec.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>, Wadim Egorov <w.egorov@phytec.de>
Subject: [PATCH 00/16] arm64: dts: ti: Additional licensing and clarification
Date: Wed, 10 Jan 2024 08:08:47 -0600
Message-ID: <20240110140903.4090946-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

As part of my 2023 LPC talk[1] about the difficulty in ensuring
device tree is same across multiple s/w ecosystems, I mentioned about
Licensing, and Rob had indicated that other SoC vendors have MIT
license option that allows co-existance with Apache.

So, bunch of internal paper work later (during which GPL-2.0-only
had to be retained due to certain user community), here is the
update to sync TI K3 device trees with addition of MIT license in
addition to existing GPL-2.0 license.

After querying BeagleBoard Foundation folks, they'd also like to
follow suit, so those platforms have been added to the list as well.

While at this, clarify existing licenses to be compatible with latest
SPDX specifications for iot2050 and phycore.

verdin platforms look already sane, so no action required there.

The CC list is based on (Since I am representing @ti.com for this
series):
git log --no-merges --pretty="%ae" $files|grep -v "@ti.com"|sort -u

Requesting Acked by from the CC list at the earliest so that we can
merge this for rc1 window for next.

Series based on: next-20240109

Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Apelete Seketeli <aseketeli@baylibre.com>
Cc: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Chao Zeng <chao.zeng@siemens.com>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Esteban Blanc <eblanc@baylibre.com>
Cc: Garrett Giordano <ggiordano@phytec.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jason Kridner <jkridner@beagleboard.org>
Cc: Jerome Neanne <jneanne@baylibre.com>
Cc: Julien Panis <jpanis@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Le Jin <le.jin@siemens.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Sarah Walker <sarah.walker@imgtec.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wadim Egorov <w.egorov@phytec.de>

Nishanth Menon (16):
  arm64: dts: ti: Use https for urls
  arm64: dts: ti: k3-am62a7: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-am625: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-am62p: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-am65: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-j7200: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-j721e: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-j721s2: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-j784s4: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-pinctrl: Add MIT license along with GPL-2.0
  arm64: dts: ti: k3-serdes: Add MIT license along with GPL-2.0
  arm64: dts: ti: beagle*: Add MIT license along with GPL-2.0
  arm64: dts: ti: iot2050*: Clarify GPL-2.0 as GPL-2.0-only
  arm64: dts: ti: phycore*: Clarify GPL-2.0 as GPL-2.0-only
  arm64: dts: ti: Makefile: Clarify GPL-2.0 as GPL-2.0-only

 arch/arm64/boot/dts/ti/Makefile                           | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi           | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi               | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62.dtsi                       | 4 ++--
 .../boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso      | 4 ++--
 .../boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts            | 6 +++---
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 2 +-
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                    | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi            | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso       | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso       | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso        | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi           | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi               | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am64.dtsi                       | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  | 2 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                    | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65.dtsi                       | 4 ++--
 arch/arm64/boot/dts/ti/k3-am652.dtsi                      | 4 ++--
 .../arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts        | 2 +-
 .../dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts            | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi   | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am654.dtsi                      | 4 ++--
 .../boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi    | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts     | 2 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts          | 4 ++--
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts     | 4 ++--
 .../arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi           | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts        | 8 ++++----
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts     | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso   | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso         | 4 ++--
 .../arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi           | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                    | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts    | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso        | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi          | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi              | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi             | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi          | 4 ++--
 arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi             | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-pinctrl.h                       | 4 ++--
 arch/arm64/boot/dts/ti/k3-serdes.h                        | 4 ++--
 99 files changed, 204 insertions(+), 177 deletions(-)

[1] https://www.youtube.com/watch?v=kr-Yd56so9M
    https://lpc.events/event/17/contributions/1547/
-- 
2.43.0

PS: TI internal record: 00010588

