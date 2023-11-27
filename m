Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887F87FAD60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjK0WWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjK0WWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:22:08 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B96E4C15;
        Mon, 27 Nov 2023 14:19:21 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r7jwg-006mxq-1Q; Mon, 27 Nov 2023 23:19:14 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r7jwf-000kAN-2L;
        Mon, 27 Nov 2023 23:19:13 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v2 0/6] mfd: twl: system-power-controller
Date:   Mon, 27 Nov 2023 23:19:01 +0100
Message-Id: <20231127221907.177442-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system-power-controller property in the bindings and
the corresponding implementation and use it where
appropriate.
Not all cases are hit yet, there has probably to be a
separate series after going through with a brush.

Changes in v2:
- add A-By
- fix compiler warning

Andreas Kemnade (6):
  dt-bindings: mfd: ti,twl: Document system-power-controller
  twl-core: add power off implementation for twl603x
  ARM: dts: omap-embt2ws: system-power-controller for bt200
  ARM: dts: omap4-panda-common: Enable powering off the device
  mfd: twl4030-power: accept standard property for power controller
  ARM: dts: omap: gta04: standardize system-power-controller

 .../devicetree/bindings/mfd/ti,twl.yaml       |  2 ++
 arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi    |  2 +-
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts  |  1 +
 .../boot/dts/ti/omap/omap4-panda-common.dtsi  |  1 +
 drivers/mfd/twl-core.c                        | 34 +++++++++++++++++++
 drivers/mfd/twl4030-power.c                   |  3 ++
 include/linux/mfd/twl.h                       |  1 +
 7 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.39.2

