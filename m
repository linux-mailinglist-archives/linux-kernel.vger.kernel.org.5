Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E71786290
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbjHWVg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbjHWVgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:36:45 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164DA10C8;
        Wed, 23 Aug 2023 14:36:42 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id CFFBD120006;
        Thu, 24 Aug 2023 00:36:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CFFBD120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692826598;
        bh=PAT92EhPD5gqLj2vJPE7hpvJyS3wZwt4qhOpe1SENNw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=IROrd0gIp7QVi2PhLJuJDQWns3py/l7uK5pfi1tt23gEzRZb8BBd4Rq5QdKF+X3Wq
         KWQTdFuvcojosmc3TYETSvKeYooOcf7VdGslSnJmD2yDTrczOy3ZPBPxWnlcox7gkv
         Rzjd7wjjB1g5cBtW8cKm9KDJALc1iDhC8Ne1TniWNmyVd9mtDjDEUnmPwwASC1JGnP
         LvEWR+9mSj3TujxFV6MEjd1NunCro0gTI8Qexs33HoG37J2v7ZmZYMWh0O0bNbACgx
         WucDESx69gQIzhWMyVqCisCi9yk/4WXagqT0TVPEyVJGUEYS/vNBQubN0bAnQT/9FK
         lX1xbXZSWQLug==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 24 Aug 2023 00:36:37 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 24 Aug 2023 00:36:33 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>
CC:     <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v2 00/15] arm64: dts: meson: a1: introduce several peripheral IPs
Date:   Thu, 24 Aug 2023 00:36:15 +0300
Message-ID: <20230823213630.12936-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179413 [Aug 23 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/08/23 19:51:00
X-KSMG-LinksScanning: Clean, bases: 2023/08/23 21:14:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/23 18:49:00 #21688451
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces device tree declarations for various
peripheral IPs of the A1 SoC family, including clock controllers, EFUSE,
USB, SPI Flash Controller, SDIO, and UART_AO:
    - CLK: A1 SoC has four types on the board, namely PLL, Peripherals,
      CPU, and Audio, but only Amlogic A1 PLL and Peripherals clock
      controllers are currently supported.
    - EFUSE: consists of a 4k bit One Time Programmable (OTP) memory
      divided into 32 128-bit blocks, and data is accessed using the APB
      bus through software or the Key-ladder integrated with the EFUSE
      block.
    - USB: only one USB 2.0 high-speed port is available in the A1 SoC,
      supporting both HOST and DEVICE modes for OTG.
    - SPI Flash Controller: 4-bit QPI/SPI NOR Flash or NAND FLASH
      controller.
    - SDIO: for WiFi/IEEE802.11 connection.
    - UART_AO: for Bluetooth connection.
    - HWRNG: hardware random generator integrated into SoC.
    - AO SECURE: board info registers.

The above peripherals are integrated to new AD402 board device tree.

Changes v2 since v1 at [1]:
    - reorder meson-a1 dtsi includes to keep them sorted
    - remove extra empty lines
    - purge the unnecessary 'okay' status
    - reorder all device tree nodes (existing and new) sorted by 'reg'
      values
    - introduce new saradc definition
    - add hwrng dts node
    - provide ao secure dts node with board info registers
    - include all changes to new AD402 board device tree
    - add AD402 board to bindings

Links:
    [1] https://lore.kernel.org/all/20230607201641.20982-1-ddrokosov@sberdevices.ru/

Alexey Romanov (3):
  arm64: dts: meson: a1: enable efuse controller and setup its clk
  arm64: dts: meson: a1: add hw rng node
  arm64: dts: meson: a1: add ao secure node

Dmitry Rokosov (8):
  arm64: dts: meson: a1: reorder includes to keep them sorted
  arm64: dts: meson: a1: remove extra empty line before reset node
  arm64: dts: meson: a1: remove the unnecessary 'okay' status pwrc value
  arm64: dts: meson: a1: reorder gpio_intc node definition
  arm64: dts: meson: a1: introduce PLL and Peripherals clk controllers
  arm64: dts: meson: a1: support USB controller in OTG mode
  arm64: dts: introduce Amlogic AD402 reference board based on A113L SoC
  dt-bindings: arm: amlogic: add Amlogic AD402 bindings

George Stark (1):
  arm64: dts: meson: a1: add saradc definition

Jan Dakinevich (1):
  arm64: dts: meson: a1: add eMMC controller and its pins

Martin Kurbanov (1):
  arm64: dts: meson: a1: introduce SPI Flash Controller

Oleg Lyovin (1):
  arm64: dts: meson: a1: introduce UART_AO mux definitions

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 145 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 213 +++++++++++++++++-
 4 files changed, 348 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts

-- 
2.36.0

