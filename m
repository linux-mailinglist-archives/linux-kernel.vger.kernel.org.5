Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58994801D8C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjLBPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 10:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLBPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 10:46:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E521FB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 07:46:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7A5C433C8;
        Sat,  2 Dec 2023 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701531981;
        bh=1EqA9rvqYVRln0P1uLXrqlcy9RJ9TXHPL4bOBzuuWnI=;
        h=From:To:Cc:Subject:Date:From;
        b=lkH1vk7xmSD9/+2gTsQUPCBnMNa+96XkPFIFGUts5ED3+qCbcIyalDundPG5UbapV
         jRS7/DujAccErlR6gcF+GDlD5uxELE30r4byHdmWtWdGqC0UzmOnWKB9nMfEux5AAb
         7Pt62tcvmjvhdUiLRWzSW13QTQqkgCKgxBOSGe3o98OiOVmeVWo5Kahqpj2GPoibEM
         mnMQ/uCvgn4AtF64DRLyzvoSo79Ahm+NEbRMKTFeBz6QqLnQ1Y9qvVrl+MCp9s9OWY
         6RHCilnCQKbGrYAd0LuLHxhw8itRrC4mCh2eUmS0+ruggIEyZ/dAoSl4SZnnr+UBzm
         HXPz806s9oMRg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] riscv: dts: starfive: add Milkv Mars board device tree 
Date:   Sat,  2 Dec 2023 23:33:50 +0800
Message-Id: <20231202153353.635-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Milkv Mars is a development board based on the Starfive JH7110 SoC.
The board features:

- JH7110 SoC
- 1/2/4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 3x USB 3.0 host port
- 1x USB 2.0 host port
- 1x M.2 E-Key
- 1x eMMC slot
- 1x MicroSD slot
- 1x QSPI Flash
- 1x 1Gbps Ethernet port
- 1x HDMI port
- 1x 2-lane DSI and 1x 4-lane DSI
- 1x 2-lane CSI

patch1 adds 'cpus' label
patch2 adds "milkv,mars" board dt-binding
patch3 adds the devicetree file describing the currently supported
features:
Namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.

Since v1:
 - add two new patches which add "cpus" label and board dt-binding
 - adopt Krzysztof's suggestions, thanks

Hi Conor,

I see you have sent a patch which moves the timebase-frequency property
to soc dtsi, but this series doesn't rebase on that. I can update it
once your patch is merged.

Thanks

Jisheng Zhang (3):
  riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
  dt-bindings: riscv: starfive: add Milkv Mars board
  riscv: dts: starfive: add Milkv Mars board device tree

 .../devicetree/bindings/riscv/starfive.yaml   |   1 +
 arch/riscv/boot/dts/starfive/Makefile         |   1 +
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   2 +-
 .../boot/dts/starfive/jh7110-milkv-mars.dts   | 637 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   2 +-
 5 files changed, 641 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts

-- 
2.42.0

