Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB06780FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378447AbjHRQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378390AbjHRQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:06:24 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951C03AB5;
        Fri, 18 Aug 2023 09:06:22 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 1AE346004C;
        Fri, 18 Aug 2023 19:06:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id A6lUUeCWp4Y0-jg6h8aLA;
        Fri, 18 Aug 2023 19:06:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692374779;
        bh=rnraiTdpoybkBjqWdLC31dG14hD9xpbVadxDMSoBAPU=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=Sf5T2rKemdu0lYVcL/iI4C6Q+QRnKajhtSwCrnB5Q+q2mo3fieLOFjTqFtIwVR/Tr
         8Maf+UlDyDmNA/85GHcgysuN/mZMovOEIp9QQNfjllubfWlWrdlurPHmF6davv2VSh
         U8EthaBJkwyTBrvaDEoduxXkWVIsQsR73p9W7wPY=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com, jonas@kwiboo.se,
        megi@xff.cz, Muhammed Efe Cetin <efectn@6tel.net>
Subject: [PATCH v2 0/3] Add Support for Orange Pi 5
Date:   Fri, 18 Aug 2023 19:05:48 +0300
Message-ID: <cover.1692372351.git.efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series add initial support for Orange Pi 5 and SFC node for RK3588S.

Changes in v2:
* Fix CHECK_DTBS warnings and add dtb to makefile.
* Remove assigned-clock-rates from sfc node and fix wrong interrupts property.
* Remove non-existent adc buttons and add button-recovery instead.
* Remove backlight_1, backlight, vcc12v_dcin, vcc5v0_usbdcin, vcc5v0_usb, combophy_avdd0v85, combophy_avdd1v8, sata0, u2phy0, u2phy0_otg nodes.
* Rename vcc3v3_pcie2x1l2 to vcc3v3_pcie20, vbus5v0_typec to vbus_typec.
* Remove regulator-always-on property from vcc_3v3_sd_s0 and vcc3v3_pcie20.

Muhammed Efe Cetin (3):
  dt-bindings: arm: rockchip: Add Orange Pi 5 board
  arm64: dts: rockchip: Add sfc node to rk3588s
  arm64: dts: rockchip: Add Orange Pi 5

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 687 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  12 +
 4 files changed, 705 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts

-- 
2.41.0

