Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3157B7E66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjJDLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjJDLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:42:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA7A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 04:42:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7CBC433C7;
        Wed,  4 Oct 2023 11:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696419727;
        bh=fVYE1AzDVSfVfWCJMbsjMlhaPnlL9oDY13Ruj58Ow5E=;
        h=From:To:Cc:Subject:Date:From;
        b=B4VSALyKDMx0k4W/EDmXnP8dg+FDASWKmyxe1hbBNeN9LEIhAHaW2PoE8AugFbaH0
         udgvmBjGJduQsyZPA1P0LFX1/YJm/vNxqw3rwh4ml3LlvoCNi02fXyPq/OtnC7aUSh
         8Hi3Qg+5Ec9d/2LA/5YoficcqDLUoEifrFe3EBCNljtcbYnEN5vu+Ch1DFbzQklGbe
         DDJrsA2hZZim8Wd7imbFqqjvNvrXUHpgF38wZLmYzMCanBpSPTKDdRlRfRc8AMNDQR
         PnKms7Dfqf/p1Dm8KskA14niqxRwNXdId4tE3F7Wdmx68l2+DRYlVmvgKVPnVQtsIB
         wyucuSCsMHLgA==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     afd@ti.com, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, srk@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] arm64: dts: ti: am642-evm: Fix Makefile for k3-am642-evm.dtb
Date:   Wed,  4 Oct 2023 14:42:01 +0300
Message-Id: <20231004114201.6162-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We accidentally dropped k3-am642-evm.dtb target so add it back.

Fixes: 45a0c06571e1 ("arm64: dts: ti: am642-evm: Add overlay for NAND expansion card")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index b3516419f95d..29babdb77c86 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 
 # Boards with AM64x SoC
+dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 k3-am642-evm-nand-dtbs := k3-am642-evm.dtb k3-am642-evm-nand.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb

base-commit: 562fc2b011e213b5a127cda523110f0698770606
-- 
2.34.1

