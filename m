Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDADD7C5FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbjJKV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjJKV7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:59:07 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBA1B8;
        Wed, 11 Oct 2023 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1697061541; bh=KbH2UqL5Mw2DaM0t8hbR9+M4YCGdx1V6vRdWjgihY6U=;
        h=From:To:Cc:Subject:Date:From;
        b=AJArDmKAuk2M5SJOFYHjrqFmvosIDKD3ckQD0LyGpYCgpWbpX9ydCFYSL0ZnxWeHM
         +dLEH+deWk+ZOLCLGE5n9J1EXl6wqCwZl1aik0v0ptnBjR9JTJx0PAQpWLL4rmMh1k
         ePUwqvqhBwmBz3iPx5ivEDBy0yHZhvGg1rBB1Ryc=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>, Jagan Teki <jagan@edgeble.ai>,
        Jonas Karlman <jonas@kwiboo.se>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for Pine64 QuartzPro64
Date:   Wed, 11 Oct 2023 23:58:43 +0200
Message-ID: <20231011215856.2082241-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

This series adds an initial support for Pine64 QuartzPro64 SBC.

The series was tested against Linux 6.6-rc4.

Please take a look.

For v2, I proactively went through changes made by Heiko when merging my
other patchset for Orange Pi 5 Plus, and made the same changes to this
patchset, which had some similar issues:

- order regulator-name inside pmic nodes as the first property
- re-oreder some other properties alphabetically (in rtc node and in
  some regulators under /)
- drop rockchip,system-power-controller (will re-add later without prefix once
  https://lore.kernel.org/lkml/20231010174138.1888396-1-megi@xff.cz/ gets merged)
- drop mem-supply from cpu nodes (this will also be re-added later
  once cpufreq support is upstreamed)
- sort nodes under pinctrl alphabetically
- added acked-by tag for DT bindings patch

Thank you,
	Ondřej Jirman

Ondrej Jirman (2):
  dt-bindings: arm: rockchip: Add Pine64 QuarzPro64
  arm64: dts: rk3588-quartzpro64: Add QuartzPro64 SBC device tree

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588-quartzpro64.dts  | 1137 +++++++++++++++++
 3 files changed, 1143 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts

-- 
2.42.0

