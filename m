Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51CD770DC7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 06:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHEEuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 00:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEEuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:50:01 -0400
Received: from mail.croughan.sh (mail.croughan.sh [135.181.193.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C524C04;
        Fri,  4 Aug 2023 21:49:56 -0700 (PDT)
From:   Matthew Croughan <matthew.croughan@nix.how>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nix.how; s=mail;
        t=1691210992; bh=T5x41Qy5WlnyzM+LU1ydag5IfKLN0yGgXPSOar7HGRs=;
        h=From:To:Cc:Subject:Date;
        b=QYO/x2FcGr8wf3wKEOoFaOwWcOF9CBwHdV+WKkszAdFuBCU5ackBQ3y/AgBjMk6sC
         QU5MRdLQfQoE9ZrdTfZtzbHhzfrGghuHd/NlN5GbRZfMHtTgJcJqUJFIu7G9qiS5On
         e0bV2xsn+hRA5db8haaegIlRkPyao5WvfBs2u6jg=
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Matthew Croughan <matthew.croughan@nix.how>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS
Date:   Sat,  5 Aug 2023 05:42:37 +0100
Message-ID: <20230805044558.279473-2-matthew.croughan@nix.how>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
V5:
- Switch ordering of patches
- Fix comment style
- Add Reviewed-by tag

Matthew Croughan (2):
  dt-bindings: arm: sunxi: add Mango Pi MQ-Quad binding
  arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-h616-mangopi-mq-quad.dts | 185 ++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts

-- 
2.41.0

