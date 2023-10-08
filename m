Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C927BCF14
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 17:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjJHP1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 11:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjJHP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 11:27:13 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D8B6;
        Sun,  8 Oct 2023 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696778828; bh=0jajswhxJ2xstyOKf9U5EODA+wWJ81yMdH1vbZSVs8g=;
        h=From:To:Cc:Subject:Date:From;
        b=xv2tyj44BnKRtlSXZ4Cnt+HgiVP8JQoubtuE9gILpf4GHYTz2jFwSfHWscjEIF6IA
         n+hjDCdDMGtonkQ+OIph5eZdqBGisMoWbYS5/EHscMLs7bOCTaZVDrzD7RtXqPXTRM
         KfdYWJvVv81M5TloOqjREqrdB4OtFuNyE4dIDOLI=
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
Subject: [PATCH 0/2] Add support for Pine64 QuartzPro64
Date:   Sun,  8 Oct 2023 17:26:55 +0200
Message-ID: <20231008152703.1196370-1-megi@xff.cz>
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

This series adds an initial support for Pine64 QuartzPro64 SBC.

The series was tested against Linux 6.6-rc4.

Please take a look.

Thank you,
	Ondřej Jirman

(Support for a few extra things, notably USB 3.0 is available at
 https://xff.cz/git/linux/log/?h=opi5-6.6)

Ondrej Jirman (2):
  dt-bindings: arm: rockchip: Add Pine64 QuarzPro64
  arm64: dts: rk3588-quartzpro64: Add QuartzPro64 SBC device tree

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588-quartzpro64.dts  | 1146 +++++++++++++++++
 3 files changed, 1152 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts

-- 
2.42.0

