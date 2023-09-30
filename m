Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A447B404C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjI3Mv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjI3Mv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:51:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1043AF1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 05:51:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E858C433C8;
        Sat, 30 Sep 2023 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696078312;
        bh=o0BDP7/qlpQFQEz4SdtV7n0arI35k2WTUQrSjrLMH8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=AT1XpRJfxeXzvWQAjkpRWgnj+Of5ZAnVxc1AsCX/skmJb5W7yQIaShbKkrnIOT1o3
         vzW3tZf040hAbfNU+bs+MZeUmPPxdf29L7wFCRG0WPJ5lyDXFaeEoN5VtZsHYUO7EC
         UHlVZFzNvURcy0FLBYny8rGW60QJixaNQvEUZ0VIa4ANCWYD+nlPthyJtkHXuhjHAS
         8N0tJpgpE3HGEADgGRmkmjYDUq6KUl22wTUnaO2kdjknjwOzWIoUY2bq2r1L2ajoTF
         63A6zpTyyHdm9mk0zpwnQ+bL2GSAaxOWAGE477CNyC1qj1tZtTLyRws3ejQZkIIvY/
         exGHvsv17DMkw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Subject: [PATCH 0/5] Add Milk-V Duo board support
Date:   Sat, 30 Sep 2023 20:39:32 +0800
Message-Id: <20230930123937.1551-1-jszhang@kernel.org>
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

NOTE: this series is based on the SG2042 upstream series for the vendor
prefix and ARCH_SOPHGO option.

Link: https://milkv.io/duo [1]
Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
Link: https://lore.kernel.org/linux-riscv/cover.1695804418.git.unicornxw@gmail.com/ [3]

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
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 117 ++++++++++++++++++
 6 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi

-- 
2.40.1

