Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C142B7FCACC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376293AbjK1XZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjK1XZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:25:06 -0500
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2610C1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:25:10 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id 7B7C937943E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MPqJlFk0vA6r for <linux-kernel@vger.kernel.org>;
        Wed, 29 Nov 2023 00:26:45 +0100 (CET)
Received: from werkpc.lan (87-101-2-254.dsl.cambrium.nl [87.101.2.254])
        by mail.rnplus.nl (Postfix) with ESMTPSA id B3145379289;
        Wed, 29 Nov 2023 00:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1701214001; bh=G3JB671WawIpbUjjbrLf8COupnjT/0gEiSIXdRR+XLM=;
        h=From:To:Subject:Date;
        b=EgnkeBuDR0Tw+njhvtrf3miCyHthsJ+NqYbR0NY4u/ES2+I9u44o4HPuAnsWbKH6R
         TXXczAkAJPjKYWTTj0ZRXZtTpf3xuCqp4DRDuFkQmAAE8//ZbDj3OZH7WtiLxqpfQn
         SbhAerfJ9/PGdj0FGxfdM3c+jbd3uanlNieu7szY=
From:   Renze Nicolai <renze@rnplus.nl>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        renze@rnplus.nl
Subject: [PATCH v2 0/2] ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
Date:   Wed, 29 Nov 2023 00:23:15 +0100
Message-ID: <20231128232456.2932350-1-renze@rnplus.nl>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These patches add a device-tree (and a bindings update) for the
Aspeed BMC on the ASRock X570D4U, so that it can be added as a
supported OpenBMC platform.

Changes since v1:
  - Fixed indentation
  - Added "aspeed,ast2500" compatible
  - Switched to lower case hex values
  - Added function and color attributes to the LEDs
  - Renamed LEDs to led0 and led1
  - Removed hogging of output-bmc-ready GPIO (should be set from userland instead)
  - Get MAC addresses of the ethernet interfaces from the FRU EEPROM
  - Add descriptions to the busses exposed by the I2C switch (i2c-1@70)
  - Add blank lines between nodes in fan section
  - Drop bootargs from chosen section

Greetings,
Renze Nicolai

Renze Nicolai (2):
  dt-bindings: arm: aspeed: add Asrock X570D4U board
  ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 359 ++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts

-- 
2.43.0

