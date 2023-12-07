Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91A808B67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443278AbjLGPF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjLGPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:05:22 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F76B19A;
        Thu,  7 Dec 2023 07:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=uxFGHxakStf7yH8nRFVFur6OexrjKQWIh4WIBrE+e5k=; b=gTaN9ieOG+xb95+U9xzUBuF6hX
        7+KoPz3qKcNPWhY3HULkwaYfvqom/gjFOf9nUCB4W97ZYs+JUpnoEnIltMYW+druhljkAxtYh5D9Z
        okJYobKeWW8INde9Tz+C/QwwMR7EP1QDgOTUGAqvkwh/bkFb/hU8o6jt9l3w1GE8E4m8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59044 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rBFwI-0006Zh-2x; Thu, 07 Dec 2023 10:05:22 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        leoyang.li@nxp.com, robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu,  7 Dec 2023 10:05:16 -0500
Message-Id: <20231207150519.1264808-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH v2 0/3] board: imx8mn-dimonoff-gateway-evk: add support for Dimonoff gateway EVK board
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series add support for the Dimonoff gateway EVK board.

Based on shawnguo/for-next branch.

Thank you.

Link: [v1] https://lore.kernel.org/all/20231206160303.33185-1-hugo@hugovil.com/

Changes for V2:
- Add Krzysztof Acked-by tag
- Wrap lines at 80 columns in dts
- Remove company name from compatible property

Hugo Villeneuve (3):
  dt-bindings: vendor-prefixes: add dimonoff
  dt-bindings: arm: fsl: add Dimonoff gateway EVK board
  arm64: dts: freescale: introduce dimonoff-gateway-evk board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mn-dimonoff-gateway-evk.dts | 160 ++++++++++++++++++
 4 files changed, 164 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-dimonoff-gateway-evk.dts


base-commit: 8c3c7094bf5b965a6dfc74864838fa4954dcf1c9
-- 
2.39.2

