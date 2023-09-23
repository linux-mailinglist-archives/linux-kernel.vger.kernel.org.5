Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1777ABEB8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjIWIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIWIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:01:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB8D197
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:01:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417E1C433C7;
        Sat, 23 Sep 2023 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695456092;
        bh=aQTqfUoklRvlIZivFdZ0RDTbrwwguhjM51XFd8Rs0BI=;
        h=From:To:Cc:Subject:Date:From;
        b=YTaICS8z2lUR/w/MEmEVa21G/eA59iPqJFs5890r8aZNxgJa8VaajAINpAhgRc0iy
         vywvNJ7lU6OdptUbpoa97h4AcRWjuiJ70lE9IpnIsxs7cOQnbgYyfj7NdLDxcVH9En
         wJyLUqGuKNHF6FXIHCiR9Gu4b48WnboOF5S/NpiW4j2oq9W5aDwT1j+9CykLixBXah
         XA+voE8Ogp7fRF3n0MxmUyD+InanUBlYu6S+0tjzfS83rMYoUGUGEzsbe+/tYo65k/
         bNMdNgSUlOq+AUrdyPpkTwgWjowrIoPmSgOUyzoHiR0fKq7UYoni7uOnXDODukv6Hj
         Joi5cEVbH6alw==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, afd@ti.com, robh+dt@kernel.org
Cc:     vigneshr@ti.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srk@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] arm64: dts: ti: Add overlay for AM642-EVM NAND expansion card
Date:   Sat, 23 Sep 2023 11:00:44 +0300
Message-Id: <20230923080046.5373-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds device tree overlay for NAND expansion card for AM642-EVM.

cheers,
-roger

Changelog:
---------
v2:
- Drop patch "arm64: dts: ti: Enable support for overlays for relevant boards"
- Don't leave k3-am642-evm-nand.dtbo as an orphan. Make k3-am642-evm-nand.dtb
  with the overlay applied on the base board.
- Add patch "arm64: dts: ti: k3-am64: Add GPIO expander on I2C0"

Roger Quadros (2):
  arm64: dts: ti: am642-evm: Add overlay for NAND expansion card
  arm64: dts: ti: k3-am64: Add GPIO expander on I2C0

 arch/arm64/boot/dts/ti/Makefile               |   3 +-
 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 140 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   9 ++
 3 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

