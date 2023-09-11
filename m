Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2978579A185
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjIKCwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjIKCwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:52:34 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9494FA;
        Sun, 10 Sep 2023 19:52:29 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 11 Sep 2023
 10:52:26 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH V3 RESEND 0/6] Power: T7: add  power domain driver
Date:   Mon, 11 Sep 2023 10:52:17 +0800
Message-ID: <20230911025223.3433776-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is that remove C3 some power domain ALWAYS_ON property.
Second patch is that add driver to support power parent node. 
Third patch is that turn on power if initial power domain with
"AWAY_ON" property state is off.

Other patchs adds power controller driver support for Amlogic T7 SoC.

Changes Since v2:
 -Modify subject.
 -Define PWRC_NO_PARENT UINT_MAX
 -Remove modification that transform is_off into 1 or 0 using !!

Changes Since v1:
 -Fix license from "GPL-2.0-only OR .*" to "GPL-2.0-only OR MIT".
 -Modify T7_NIC flag  "ALWAYS_ON"

xianwei.zhao (6):
  genpd: amlogic: modify some power domains property
  genpd: amlogic: add driver to support power parent node
  genpd: amlogic: init power domain state
  dt-bindings: power: add Amlogic T7 power domains
  genpd: amlogic: Add support for T7 power domains controller
  arm64: dts: amlogic: t7: add power domain controller node

 .../power/amlogic,meson-sec-pwrc.yaml         |   3 +-
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |   6 +
 drivers/genpd/amlogic/meson-secure-pwrc.c     | 127 ++++++++++++++++--
 include/dt-bindings/power/amlogic,t7-pwrc.h   |  63 +++++++++
 4 files changed, 185 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/power/amlogic,t7-pwrc.h


base-commit: 413f5c02929bb33042bbc4ee233166550a5fca70
-- 
2.37.1

