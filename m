Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68331782D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbjHUPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjHUPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:48:19 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78529F7;
        Mon, 21 Aug 2023 08:48:17 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:12ae:0:640:5b3c:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 0C30560059;
        Mon, 21 Aug 2023 18:48:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7mKGOJgDamI0-ySCYmVO6;
        Mon, 21 Aug 2023 18:48:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692632894;
        bh=7QTAAhaoJM7pAQXybSkxpF1Sd6aRXq5aJx2tvdulhk0=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=sPcMdbn6pNOjJpaecFMvnfNKnXcCpAjWG5oTW0o41FhlAPGryjEwifhJQ8N5pPJVV
         r3ul/GKKUlzBl+ExpHegvUNolyGzGB2/2u3uFH7uErq0RAgHLP9KWR5SL989xToNJO
         MYyX3tRWPxm8U4d+o1cHVwxVcJnvOx+wPTSfF9nA=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com, jonas@kwiboo.se,
        megi@xff.cz, Muhammed Efe Cetin <efectn@6tel.net>
Subject: [PATCH v3 0/3] Add Support for Orange Pi 5
Date:   Mon, 21 Aug 2023 18:47:56 +0300
Message-ID: <cover.1692632346.git.efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series add initial support for Orange Pi 5 and SFC node for RK3588S.

Changes in v3:
* Remove cap-mmc-highspeed property from sdmmc.
* Make vcc_1v1_nldo_s3 an alias of dcdc-reg6 and add regulator-max-microvolt, regulator-min-microvolt properties.
* Make press-threshold-microvolt 1800 for recovery button.
* Remove assigned-clocks from sfc node.
* Drop some properties from sfc node in orangepi5 devicetree.
* Move snps reset properties to rgmii_phy1.

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
 .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 673 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  11 +
 4 files changed, 690 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts

-- 
2.41.0

