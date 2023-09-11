Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7179C2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbjILC2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbjILC2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823611AA48;
        Mon, 11 Sep 2023 18:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAA7C43215;
        Mon, 11 Sep 2023 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694468761;
        bh=A93qPH1BvZpug+kRF/tIkw7aL3cJtamMq810m6gI13w=;
        h=From:To:Cc:Subject:Date:From;
        b=ZnLmBUYqXzg8bTl7kfUw7AkOW9M7cMNX9QlQPNt+JziqdnnQYyh8mJoRQjGE4lIUp
         Rx7w5aALRJTaKDc+C7Iwpefrbu0XsmvQBonjJbsO18Q7TphiCT76LJcsSjUf1LKOET
         7VGGKU8ya+KdfTwa8plNdvnMaQ4sP3Hz2oBHyeguwKTLupuGDNN8VVO6AHfIwjYdIS
         r3n6+5swJPnrUGgFBsyG91kYbi7P4ArM8RVxVMN1HLvZSlk6/a4vMpgwuopIbu8JTW
         M2enhTIKSEsydFLWW01xNMWazav3+d7TpqOjj/hTgfnEzMfE+fJJ+XW1OJVPyrv1qb
         SJrI6kXcw1FAw==
Received: (nullmailer pid 2200995 invoked by uid 1000);
        Mon, 11 Sep 2023 21:45:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        David Jander <david@protonic.nl>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx: Add imx8mm-prt8mm.dtb to build
Date:   Mon, 11 Sep 2023 16:45:37 -0500
Message-Id: <20230911214547.2200528-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx8mm-prt8mm.dts was not getting built. Add it to the build.

Fixes: 58497d7a13ed ("arm64: dts: imx: add Protonic PRT8MM board")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index c6872b7e9471..0935626c3dfb 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -65,6 +65,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-mx8menlo.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phg.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-prt8mm.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-tqma8mqml-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
-- 
2.40.1

