Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733C17D3B32
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJWPr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjJWPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:47:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FFF10A;
        Mon, 23 Oct 2023 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076042; x=1729612042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=azRF8Tr1FjS1mhmfgNj7KBFmuZpo8uSGPa9Rwz8beHA=;
  b=AOcbmYXpP3I3AeurpyTMMH9NIWqUTqv1/JnVYwMlZHWZ0PIjOcB5VkJz
   VUI8X1QMg6+gErmM8bxi9SU+Z1rMV6p0yBKhoTFIeri2gxGJYhWFcHiKW
   J1W1Y7S4HKgjtX7soYkG23s9/CO7WEpwcFSXL/WP/mwNYhSepkfjfCxnp
   pE5jh3oRVRn0GTVGI5tmCOtjjjJgQ9X89O50kFiQFhXW6NOYJOJt79yfw
   euUqyezUwQ89rXsi4U44OIZcG8l4dDMkSaNa8s+LAhTkwkkPDblU29IHh
   arMPZpE7myqngTRsXeTaAWxMKBhDEXmKS6O1jagfpMOdLJVLwvg21QrWh
   g==;
X-CSE-ConnectionGUID: NJm2u3DySce+5c8BG0159g==
X-CSE-MsgGUID: KpmGRKNCTo+hPa8sxGPz0A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="10702766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:47:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:47:08 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:46:56 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <steen.hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface
Date:   Mon, 23 Oct 2023 21:16:40 +0530
Message-ID: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contain the below updates,
- Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
  net/ethernet/oa_tc6.c.
- Adds driver support for Microchip LAN8650/1 Rev.B0 10BASE-T1S MACPHY
  Ethernet driver in the net/ethernet/microchip/lan865x.c.

Changes:
v2:
- Removed RFC tag.
- OA TC6 framework configured in the Kconfig and Makefile to compile as a
  module.
- Kerneldoc headers added for all the API methods exposed to MAC driver.
- Odd parity calculation logic updated from the below link,
  https://elixir.bootlin.com/linux/latest/source/lib/bch.c#L348
- Control buffer memory allocation moved to the initial function.
- struct oa_tc6 implemented as an obaque structure.
- Removed kthread for handling mac-phy interrupt instead threaded irq is
  used.
- Removed interrupt implementation for soft reset handling instead of
  that polling has been implemented.
- Registers name in the defines changed according to the specification
  document.
- Registers defines are arranged in the order of offset and followed by
  register fields.
- oa_tc6_write_register() implemented for writing a single register and
  oa_tc6_write_registers() implemented for writing multiple registers.
- oa_tc6_read_register() implemented for reading a single register and
  oa_tc6_read_registers() implemented for reading multiple registers.
- Removed DRV_VERSION macro as git hash provided by ethtool.
- Moved MDIO bus registration and PHY initialization to the OA TC6 lib.
- Replaced lan865x_set/get_link_ksettings() functions with
  phy_ethtool_ksettings_set/get() functions.
- MAC-PHY's standard capability register values checked against the
  user configured values.
- Removed unnecessary parameters validity check in various places.
- Removed MAC address configuration in the lan865x_net_open() function as
  it is done in the lan865x_probe() function already.
- Moved standard registers and proprietary vendor registers to the
  respective files.
- Added proper subject prefixes for the DT bindings.
- Moved OA specific properties to a separate DT bindings and corrected the
  types & mistakes in the DT bindings.
- Inherited OA specific DT bindings to the LAN865x specific DT bindings.
- Removed sparse warnings in all the places.
- Used net_err_ratelimited() for printing the error messages.
- oa_tc6_process_rx_chunks() function and the content of oa_tc6_handler()
  function are split into small functions.
- Used proper macros provided by network layer for calculating the
  MAX_ETH_LEN.
- Return value of netif_rx() function handled properly.
- Removed unnecessary NULL initialization of skb in the
  oa_tc6_rx_eth_ready() function removed.
- Local variables declaration ordered in reverse xmas tree notation.

Parthiban Veerasooran (9):
  net: ethernet: implement OPEN Alliance control transaction interface
  net: ethernet: oa_tc6: implement mac-phy software reset
  net: ethernet: oa_tc6: implement OA TC6 configuration function
  dt-bindings: net: add OPEN Alliance 10BASE-T1x MAC-PHY Serial
    Interface
  net: ethernet: oa_tc6: implement internal PHY initialization
  dt-bindings: net: oa-tc6: add PHY register access capability
  net: ethernet: oa_tc6: implement data transaction interface
  microchip: lan865x: add driver support for Microchip's LAN865X MACPHY
  dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY

 .../bindings/net/microchip,lan865x.yaml       |  101 ++
 .../devicetree/bindings/net/oa-tc6.yaml       |   86 ++
 Documentation/networking/oa-tc6-framework.rst |  233 ++++
 MAINTAINERS                                   |   16 +
 drivers/net/ethernet/Kconfig                  |   12 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/microchip/Kconfig        |   11 +
 drivers/net/ethernet/microchip/Makefile       |    2 +
 drivers/net/ethernet/microchip/lan865x.c      |  415 ++++++
 drivers/net/ethernet/oa_tc6.c                 | 1117 +++++++++++++++++
 include/linux/oa_tc6.h                        |  109 ++
 11 files changed, 2103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
 create mode 100644 Documentation/devicetree/bindings/net/oa-tc6.yaml
 create mode 100644 Documentation/networking/oa-tc6-framework.rst
 create mode 100644 drivers/net/ethernet/microchip/lan865x.c
 create mode 100644 drivers/net/ethernet/oa_tc6.c
 create mode 100644 include/linux/oa_tc6.h

-- 
2.34.1

