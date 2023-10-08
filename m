Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145F47BCE71
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344796AbjJHNGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbjJHNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:06:12 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFAC5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696770367; bh=iFJPDtUKoP37vIhXRBmqRJjQU1Msnq0cruFbwd9+vtk=;
        h=From:To:Cc:Subject:Date:From;
        b=RB6a8AY9b8cRboJA4kccUHp03BjJII6czvTikm1mJBlGvnyhnpUkfHzlMBKsfFs3W
         Z2btkDMsP0yTHBlT5UMPnsGZAn+olUZC1M6wSFXA2/Q5ZnLSgL7LDBDZI02Rxl5Esx
         GYomKpORSYIILZ8Bp10pdrbnEgpkeVb0h3OQWUDo=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>, Jagan Teki <jagan@edgeble.ai>,
        Jonas Karlman <jonas@kwiboo.se>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add support for Orange Pi 5 Plus
Date:   Sun,  8 Oct 2023 15:04:58 +0200
Message-ID: <20231008130515.1155664-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

This series adds an initial support for Orange Pi 5 Plus. The only
thing missing that can be readily added is USB 3.0 support, because
required patches were not yet merged. Support for USB 3.0 is available
at https://xff.cz/git/linux/log/?h=opi5-6.6

The series depends on SFC patch from:

  https://lore.kernel.org/lkml/70557b7843994a57c6d3422e00643cb75a698d0b.1692632346.git.efectn@6tel.net/

The series was tested against Linux 6.6-rc4.

Please take a look.

Thank you,
	Ondřej Jirman

Ondrej Jirman (4):
  arm64: dts: rockchip: rk3588s-pinctrl: Add I2S2 M0 pin definitions
  arm64: dts: rockchip: rk3588s-pinctrl: Add UART9 M0 pin definitions
  dt-bindings: arm: rockchip: Add Orange Pi 5 Plus
  arm64: dts: rk3588-orangepi-5-plus: Add board device tree

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3588-orangepi-5-plus.dts   | 857 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588s-pinctrl.dtsi    |  44 +
 4 files changed, 907 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts

-- 
2.42.0

