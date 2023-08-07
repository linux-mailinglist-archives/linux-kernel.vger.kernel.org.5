Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5FC773046
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjHGUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjHGUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:22:10 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB610D8;
        Mon,  7 Aug 2023 13:22:07 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 4A1B920658;
        Mon,  7 Aug 2023 22:22:05 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4]  arm64: dts: ti: Enable Audio on Verdin AM62
Date:   Mon,  7 Aug 2023 22:21:55 +0200
Message-Id: <20230807202159.13095-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add AM62x AUDIO_REFCLKx to AM62x SoC dtsi, and after doing it, enable audio
support for Toradex Verdin AM62.

DT bindings updates, related to the audio codec used here, are already merged
in next [2][3].

For correct functionality this fix [1] is also required.

[1] https://lore.kernel.org/all/20230728222639.110409-1-francesco@dolcini.it/
[2] https://lore.kernel.org/all/20230719124752.248898-1-francesco@dolcini.it/
[3] https://lore.kernel.org/all/20230719121918.247397-1-francesco@dolcini.it/

v3:
 - added Reviewed-by: Jai Luthra <j-luthra@ti.com>
 - removed changes on k3-am62a-main.dtsi that were introducing warnings 
v2:
 - s/clock/clock-controller/ on audio refclk nodes name.

Francesco Dolcini (3):
  arm64: dts: ti: verdin-am62: Set I2S_1 MCLK rate
  arm64: dts: ti: verdin-am62: dev: add sound card
  arm64: dts: ti: verdin-am62: dahlia: add sound card

Jai Luthra (1):
  arm64: dts: ti: k3-am62: Enable AUDIO_REFCLKx

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 18 +++++++
 .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    | 53 +++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi | 45 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |  5 ++
 4 files changed, 121 insertions(+)

-- 
2.25.1

