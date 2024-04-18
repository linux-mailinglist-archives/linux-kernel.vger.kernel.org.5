Return-Path: <linux-kernel+bounces-150108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CDF8A9A80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FADC1F2189E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE71149C6B;
	Thu, 18 Apr 2024 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bHVazGJb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BD1DFCF;
	Thu, 18 Apr 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445055; cv=none; b=uFkJso331hDNg/j1Q10EBra3pSHC/xabGI3SNELY0Kv+jnq418xrfS1375iH+fpw5oQyPB5tqmKmoyH2pbY3aQtGE6QSqPor5aWyPRQvxAxtTuqVBlLDUp4wTLY7eAS1bsl4U8GoXLdqM2SDARwe4X64geWfz5yXMkM5RtNcibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445055; c=relaxed/simple;
	bh=Rb3bBJy2VszRT+9R2AqUbAa53uLcfwNZ4YFhpNUDcKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ggicz2Yv7my4e+hrc2ozBJIgIgnz/RlAs9HMienbDM6vgWHfFZO9OyfcfYmUJnWRBxHheNE+C8/MZOLp+ZoR4a15qHP6fQfGf7k/miNemxNV+BGchwykFBAhc5ScoiW9FtCZm6PdlSGj6M27TQv1FIG17sgzCfD4upKPHbciZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bHVazGJb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713445053; x=1744981053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rb3bBJy2VszRT+9R2AqUbAa53uLcfwNZ4YFhpNUDcKs=;
  b=bHVazGJbtJ1Kc7c7jltPsYiSz+Czqo/26KhUCCCShVsktbyVexQneSaR
   f5aNk9ZKC3iO3sJReJhEj/BP77kWSj6zEhtyocZhTkYgZStNR5yKJ3JLS
   G/wFig2hpqj3/nOLtihBrO5hx7P0D9PMRb7VFjr7UhiABie0P9f/9tkzj
   zveK73BGyqQjZocu2Q0AhWhZ0FQzD3G2JIYDhCVz8iImAspROYYVz59Hz
   tSqDl02J5WJCCyqqbDY37xnphDSw/XfIijlt81as9M1oZ2oOuhX6fXb0H
   1Kwip40ELk+/YPc34lF60ompvmwvFJb5Kkhop4QAaVGwI9YftNtDHIK1v
   w==;
X-CSE-ConnectionGUID: Gt9eIEHaS7e6ziafVgNwUQ==
X-CSE-MsgGUID: LjOmlH8UQR6gdapeZhRjbA==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="21557019"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 05:57:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 05:56:47 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 05:56:38 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v4 00/12] Add support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface
Date: Thu, 18 Apr 2024 18:26:36 +0530
Message-ID: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series contain the below updates,
- Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
  net/ethernet/oa_tc6.c.
  Link to the spec:
  -----------------
  https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf

- Adds driver support for Microchip LAN8650/1 Rev.B1 10BASE-T1S MACPHY
  Ethernet driver in the net/ethernet/microchip/lan865x/lan865x.c.
  Link to the product:
  --------------------
  https://www.microchip.com/en-us/product/lan8650

Testing Details:
----------------
The driver performance was tested using iperf3 in the below two setups
separately.

Setup 1:
--------
Node 0 - Raspberry Pi 4 with LAN8650 MAC-PHY 
Node 1 - Raspberry Pi 4 with EVB-LAN8670-USB USB Stick

Setup 2:
--------
Node 0 - SAMA7G54-EK with LAN8650 MAC-PHY 
Node 1 - Raspberry Pi 4 with EVB-LAN8670-USB USB Stick

Achieved maximum of 9.4 Mbps.

Some systems like Raspberry Pi 4 need performance mode enabled to get the
proper clock speed for SPI. Refer below link for more details.

https://github.com/raspberrypi/linux/issues/3381#issuecomment-1144723750

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

v3:
- Completely redesigned all the patches.
- Control and data interface patches are divided into multiple small
  patches.
- Device driver APIs added in the oa-tc6-framework.rst file.
- Code readability improved in all the patches.
- Defined macros wherever is possible.
- Changed RESETC to STATUS0_RESETC for improving the readability.
- Removed OA specific DT bindings.
- Used default configurations defined in the OA spec.
- All variables are named properly as per OA spec for more redability.
- Bigger functions are split into multiple smaller functions.
- DT binding check is done.
- Phy mask is removed in phy scanning.
- Used NET_RX_DROP to compare the rx packet submission status.
- Indentation in the Kconfig file corrected.
- Removed CONFIG_OF and CONFIG_ACPI ifdefs.
- Removed MODULE_ALIAS().

v4:
- Fixed indentation in oa-tc6-framework.rst file.
- Replaced ENODEV error code with EPROTO in the
  oa_tc6_check_ctrl_write_reply and oa_tc6_check_ctrl_read_reply()
  functions.
- Renamed oa_tc6_read_sw_reset_status() function as
  oa_tc6_read_status0().
- Changed software reset polling delay as 1ms and polling timeout as 1s.
- Implemented clause 45 registers direct access.
- Replaced ENODEV error code with ENOMEM in the
  oa_tc6_mdiobus_register() function.
- Changed transmit skbs queue size as 2.
- Added skb_linearize() function to convert contiguous packet data.
- Checked kthread_should_stop() in the oa_tc6_spi_thread_handler()
  function before proceeding for the oa_tc6_try_spi_transfer().
- Removed netdev_err() print in the oa_tc6_allocate_rx_skb() function.
- Added spi-peripheral-props reference in the dt-bindings.
- Changed the fallback order in the dt-bindings.
- Replaced netif_start_queue() with netif_wake_queue().
- Empty data transfer performed in the oa_tc6_init() function to clear
  the reset complete interrupt.
- ZARFE bit in the CONFIG0 register is set to 1 to avoid lan865x halt
  based on the recommendation in the lan865x errata.

Parthiban Veerasooran (12):
  Documentation: networking: add OPEN Alliance 10BASE-T1x MAC-PHY serial
    interface
  net: ethernet: oa_tc6: implement register write operation
  net: ethernet: oa_tc6: implement register read operation
  net: ethernet: oa_tc6: implement software reset
  net: ethernet: oa_tc6: implement error interrupts unmasking
  net: ethernet: oa_tc6: implement internal PHY initialization
  net: ethernet: oa_tc6: enable open alliance tc6 data communication
  net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet
    frames
  net: ethernet: oa_tc6: implement receive path to receive rx ethernet
    frames
  net: ethernet: oa_tc6: implement mac-phy interrupt
  microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY
  dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY

 .../bindings/net/microchip,lan865x.yaml       |   80 +
 Documentation/networking/oa-tc6-framework.rst |  491 ++++++
 MAINTAINERS                                   |   15 +
 drivers/net/ethernet/Kconfig                  |   11 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/microchip/Kconfig        |    1 +
 drivers/net/ethernet/microchip/Makefile       |    1 +
 .../net/ethernet/microchip/lan865x/Kconfig    |   19 +
 .../net/ethernet/microchip/lan865x/Makefile   |    6 +
 .../net/ethernet/microchip/lan865x/lan865x.c  |  384 +++++
 drivers/net/ethernet/oa_tc6.c                 | 1321 +++++++++++++++++
 drivers/net/phy/microchip_t1s.c               |   30 +
 include/linux/oa_tc6.h                        |   23 +
 include/uapi/linux/mdio.h                     |    1 +
 14 files changed, 2384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
 create mode 100644 Documentation/networking/oa-tc6-framework.rst
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
 create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c
 create mode 100644 drivers/net/ethernet/oa_tc6.c
 create mode 100644 include/linux/oa_tc6.h

-- 
2.34.1


