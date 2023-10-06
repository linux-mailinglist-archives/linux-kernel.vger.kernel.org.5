Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A217BB77F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjJFM1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJFM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:26:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787DC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:26:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5411BC433C9;
        Fri,  6 Oct 2023 12:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696595216;
        bh=5bXGHkGr5/pHhrZtZ+4lgLJE9Up06okKf8OassnSh44=;
        h=From:To:Cc:Subject:Date:From;
        b=OalVg+e1UaK1t79fT2L2WyGzQ3V37IVB/knbOYWzS0ETR1SpiEd+Sdm/ny9AXkh0O
         n/Lyv7CYoqbxCD0pE2OTTyrE9+njF03o+DO63q2epvIRRJA5D5OJ94YIYP8Se/0CAJ
         CBJr3lQAyl7/gyprO0nTrakrcI2NBhidpFUOxf+NpxEEbrTRkej9Im/xlIngew1yGL
         QzWhWFBYMqBvQxQZqQU8JWBtsRVE0CKDsbZO5wUXVPXfYbBaLOBqERIaK6Hkp8OuV5
         wd9cWXVcuNW0TTWyaazmqtJpvwiEO5yDpNLaNhOCyetdcjy+G1stfiE9yX6NRqhw4+
         aNT2PQlulMGwA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>
Subject: [PATCH v2 0/5] Add Milk-V Duo board support
Date:   Fri,  6 Oct 2023 20:14:44 +0800
Message-Id: <20231006121449.721-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
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

Milk-V Duo[1] board is an embedded development platform based on the
CV1800B[2] chip. Add minimal device tree files for the development board.
Currently, now it's supported to boot to a basic shell.

NOTE: this series is based on the SG2042 upstream series[3] for the vendor
prefix and ARCH_SOPHGO option.

Link: https://milkv.io/duo [1]
Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
Link: https://lore.kernel.org/linux-riscv/cover.1696433229.git.unicorn_wang@outlook.com/ [3]

since v1:
 - fix dtbs_check warning
 - add clint node
 - sort dts in Makefile

Jisheng Zhang (5):
  dt-bindings: interrupt-controller: Add SOPHGO CV1800B plic
  dt-bindings: timer: Add SOPHGO CV1800B clint
  dt-bindings: riscv: Add Milk-V Duo board compatibles
  riscv: dts: sophgo: add initial CV1800B SoC device tree
  riscv: dts: sophgo: add Milk-V Duo board device tree

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/sophgo.yaml     |   4 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 arch/riscv/boot/dts/sophgo/Makefile           |   2 +-
 .../boot/dts/sophgo/cv1800b-milkv-duo.dts     |  38 ++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 123 ++++++++++++++++++
 6 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi

-- 
2.40.1

