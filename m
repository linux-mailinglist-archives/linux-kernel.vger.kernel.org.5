Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC980C737
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjLKKuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjLKKuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:50:19 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D001B137;
        Mon, 11 Dec 2023 02:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/xwBX
        qSLSCI3iN3pBYQypMi6PTCbu6TA//aRm1MKyQ4=; b=ZD/35LIygaAej53WfA1cv
        4BvJ5x1xdveGz2MzZhSIA7GFbfFeGrMGONha8YUqmPYIrKhezFobMid9FjxKSiKa
        ciKmecJ4RhG2qz45rLBjrKGIScMpxA/CYsP1R+zLnjUagL0F/UBWreE2P/r8WCVZ
        SL0Gm6PuSz7NxJSTBC4rKY=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wC332gs6XZlaZl1BA--.11857S2;
        Mon, 11 Dec 2023 18:49:20 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>
Subject: [PATCH v3 0/5] Add 2 rk3588 based boards from Cool Pi
Date:   Mon, 11 Dec 2023 18:49:15 +0800
Message-Id: <20231211104915.1779476-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC332gs6XZlaZl1BA--.11857S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1rCr45Ww4UurW7Cr4UJwb_yoW8GF4rpw
        s3CrZ8GFn7GFy7XrZIqwn7Crs3Awn5tay0vrsxXFy2kr9xKFyDAF1SgwnxZ3srG3WxZayU
        GF1kKF47Gr1DXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_uc_UUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEBJDXmVOA4yg9wAAss
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series add support for rk3588s based SBC Cool Pi 4B
and rk3588 based board Cool Pi CM5 EVB

Changes in v3:
- drop ununnecessary property status = "okay" for rtc
- drop ununnecessary property status = "okay" for backlight
- reorder some nodes alphabetical
- drop ununnecessary blank line

Changes in v2:
- change board compatible from "CoolPi 4 Model B" to "coolpi,pi-4b"
- drop ununnecessary property status = "okay" for gpio-led
- drop ununnecessary blank line
- change node name to rtc for hym8563
- change board compatible from "CoolPi CM5 EVB" to "coolpi,pi-cm5-evb"

Andy Yan (5):
  dt-bindings: vendor-prefixes: Add Cool Pi
  dt-bindings: arm: rockchip: Add Cool Pi 4B
  arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B
  dt-bindings: arm: rockchip: Add Cool Pi CM5 EVB
  arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5
    EVB

 .../devicetree/bindings/arm/rockchip.yaml     |  10 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    | 879 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 823 ++++++++++++++++
 5 files changed, 1716 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts

-- 
2.34.1

