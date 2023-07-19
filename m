Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32B0759C39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGSRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGSRRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:17:21 -0400
Received: from mail.croughan.sh (mail.croughan.sh [IPv6:2a01:4f9:c011:cb0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC75B7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:17:19 -0700 (PDT)
From:   Matthew Croughan <matthew.croughan@nix.how>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nix.how; s=mail;
        t=1689787036; bh=f4xIuJQrQRXyZNafjmPTj5No4YjDqBwsgyQB3z7zS5Q=;
        h=From:To:Cc:Subject:Date;
        b=X/vAN1kPFMYKKFhzjKZhtkaCObuzeuFMQZdZ+6sUoEzoalXuPIuTPMVuQPHT8W7Uc
         s/Qk9bf5O9HkcI/s3IKTYSV9KocqELvHxwUJHM5tM5hVGmNl5tBgPoQFOhEBhVJNcX
         Z16nGWAUQGSF9Mz8Dwx3kIS1H4gZ0hAW+U6pX3wk=
To:     andre.przywara@arm.com, krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Croughan <matthew.croughan@nix.how>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: 
Date:   Wed, 19 Jul 2023 18:09:49 +0100
Message-ID: <20230719171608.3230198-1-matthew.croughan@nix.how>
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

Subject: [PATCH v4 0/2] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS

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

