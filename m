Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B22759C56
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGSR0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGSR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:26:37 -0400
Received: from mail.croughan.sh (mail.croughan.sh [135.181.193.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE98197
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:26:36 -0700 (PDT)
From:   Matthew Croughan <matthew.croughan@nix.how>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nix.how; s=mail;
        t=1689787593; bh=uqbFHFgug/FK3RwAxjyhcrZImmSE3Dfc7++rIqLINE4=;
        h=From:To:Cc:Subject:Date;
        b=AzHa6jU/Ylpe5gXt4nttjpQXGk5QW34gTBHh76JkcjWW9E8T7HCP/RNXAzzIAcK+k
         yyOQl2ryW7hAupQSRcNSRzpoLEbh7mYsxVdzk7HN6CPMr9UnLHLRysUA1CfkY9pURR
         iUxntSJyTfG3gLreemTV17oHO78UHtPRNNpXU5Bc=
To:     andre.przywara@arm.com, krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Croughan <matthew.croughan@nix.how>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS
Date:   Wed, 19 Jul 2023 18:25:38 +0100
Message-ID: <20230719172551.3248166-1-matthew.croughan@nix.how>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1: Submission
V2: Alphabetical ordering, added "widora,mangopi-mq-quad" compatible
V3: Added Signed-off-by, add to device-tree compatible/bindings documentation
V4:
- Add separate patch for bindings documentation
- Regularised comment style
- Add vcc supplies for gpio according to board schematic
- Removed unnecessary x-powers,self-working-mode;
- Added comment regarding ALDO1
- Removed unnecessary reg_dldo1 regulator, it seems to be connected to nothing
  in the schematic, no adverse effects observed

Matthew Croughan (2):
  arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS
  dt-bindings: arm: sunxi: add Mango Pi MQ-Quad binding

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-h616-mangopi-mq-quad.dts | 183 ++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts

-- 
2.41.0

