Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4080EC47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346647AbjLLMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjLLMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:42:35 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A777994;
        Tue, 12 Dec 2023 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZztcF
        4m8TPUVhvPQaLZh9GowClmn1CkB2GW7KAZDIzQ=; b=ACNoHcHmdMn4xjxZJYTnl
        RRtXmYGpwxWLLXJMIGyy6i0so2Hh93M1zDoT8JdtknoAUiakTzfbQ3WfjhNB8eIb
        uBqk0jKzkH4Vraa7HDRssNMMpwl1K61QyIH8bnW95ERSpK7If2l3jNo3QOGJwMgx
        rW0HNsmmWMSFz2lNRpthYQ=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wAHjrkbVXhlFotZBA--.29150S2;
        Tue, 12 Dec 2023 20:42:06 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Andy Yan <andyshrk@163.com>
Subject: [PATCH v4 0/5] Add 2 rk3588 based boards from Cool Pi
Date:   Tue, 12 Dec 2023 20:42:02 +0800
Message-Id: <20231212124202.1897238-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHjrkbVXhlFotZBA--.29150S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw17Ww45Jr1UJrW3urWUtwb_yoW8Cr1Upw
        n3CrZ8GFn7WFyxXFZIq3Z7Grs3Zwn5tay09rsxXFy2kr9IgF1UAFn3WwnxZ3sxG3W7Aayj
        gF1kKr47Kr1vqF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_uc_UUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqB9EXmVOA6bhbwAAst
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series add support for rk3588s based SBC Cool Pi 4B
and rk3588 based board Cool Pi CM5 EVB

Changes in v4:
- split pi-cm5 as a dtsi

Changes in v3:
- drop ununnecessary property status = "okay" for rtc
- reorder some nodes alphabetical
- remove disabled node
- Add compatible "coolpi,pi-cm5" for CM5
- drop ununnecessary property status = "okay" for backlight
- reorder some nodes alphabetical
- drop ununnecessary blank line

Changes in v2:
- change board compatible from "CoolPi 4 Model B" to "coolpi,pi-4b"
- change board compatible from "CoolPi 4 Model B" to "coolpi,pi-4b"
- drop ununnecessary property status = "okay" for gpio-led
- drop ununnecessary blank line
- change node name to rtc for hym8563
- change board compatible from "CoolPi CM5 EVB" to "coolpi,pi-cm5-evb"
- change board compatible from "CoolPi CM5 EVB" to "coolpi,pi-cm5-evb"

Andy Yan (5):
  dt-bindings: vendor-prefixes: Add Cool Pi
  dt-bindings: arm: rockchip: Add Cool Pi 4B
  arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B
  dt-bindings: arm: rockchip: Add Cool Pi CM5
  arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5
    EVB

 .../devicetree/bindings/arm/rockchip.yaml     |  12 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    | 214 +++++
 .../boot/dts/rockchip/rk3588-coolpi-cm5.dtsi  | 659 ++++++++++++++
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 823 ++++++++++++++++++
 6 files changed, 1712 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts

-- 
2.34.1

