Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99476C714
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjHBHhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjHBHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:36:50 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE333582;
        Wed,  2 Aug 2023 00:36:42 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 2A082206F3;
        Wed,  2 Aug 2023 09:36:39 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judith Mendez <jm@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-am62: Add MCU MCAN
Date:   Wed,  2 Aug 2023 09:36:33 +0200
Message-Id: <20230802073635.11290-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

On AM62x there are no hardware interrupts routed to A53 GIC
interrupt controller for MCU MCAN IPs, so MCU MCAN nodes were
omitted from MCU dtsi.

Timer polling was introduced in commits [1][2] so now add MCU MCAN nodes
to the MCU dtsi for Cortex A53.

[1] commit b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
[2] commit bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")

Once the MCU MCANs are added to the SOC dtsi, enable the Verdin CAN2.

v1..v2:
 - fixed can node name
 - added commit prefix before sha in commit message

Hiago De Franco (1):
  arm64: dts: ti: k3-am625-verdin: enable CAN_2

Judith Mendez (1):
  arm64: dts: ti: k3-am62: Add MCU MCAN nodes

 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       | 24 +++++++++++++++++++
 .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    |  5 ++++
 .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi |  5 ++++
 .../boot/dts/ti/k3-am62-verdin-yavia.dtsi     |  5 ++++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    | 19 +++++++++++++--
 5 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.25.1

