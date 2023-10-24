Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197A57D49DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjJXIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjJXIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:20:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270D120
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:20:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA44C433C8;
        Tue, 24 Oct 2023 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698135650;
        bh=ZGuyWnKr/kt2Unpu5aE4lFxwccQjdpGfUhSXgCB0iGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=foQZtX4RsqPA1ecHtPBitGHsP5F/J44rftp9gPIBTCVIR7TT8jRUlObURWD/rgm1X
         Au/Glm3NEO6FjtktwTAPK7/mAEMSeovOfjDghb4zDathzlb7uLQJBsRyy1rkwUqjVO
         j/V+NMU129W2X3YLHelvhoWmBKGkfwwveFui0ldAIy7Y4PBDa2kbTwQXiAjfvaQSF9
         exT50YevH8L1HrNL4NWVsUlhKH3A7wBA91EtGVvccTeH/aodA4ayYgCeIcifUAOV7o
         8mM3qFn0Suypghfn+F8L2C/j/Cv3dh8ewencwUtozKYH8Ng0XsdsqLdnM5L9kaOVPW
         18PDLl0QEf/WA==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: dts: sophgo: remove address-cells from intc node
Date:   Tue, 24 Oct 2023 09:20:35 +0100
Message-Id: <20231024-maternity-slang-fd3dcfb211c0@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=aQbYiTBBEQV72xMhaZU1xuHZtHqogNH4OaogNL5Blk4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnmdeYXOn9HB6V4Sdvv3hbt/vjRW5/gpatCGMI/W2saX 1Dwd/vfUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIlURzEy9Oq/3bJwvbaT0VLd Lpufb5b5hQcu+vTQOMR+otiq49ENpYwMl7St7TZfNt92yPJuwZ/9L3Py73qJh9qt5Dy6NZtv1/M 6bgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

A recent submission [1] from Rob has added additionalProperties: false
to the interrupt-controller child node of RISC-V cpus, highlighting that
the new cv1800b DT has been incorrectly using #address-cells.
It has no child nodes, so #address-cells is not needed. Remove it.

Link: https://patchwork.kernel.org/project/linux-riscv/patch/20230915201946.4184468-1-robh@kernel.org/ [1]
Fixes: c3dffa879cca ("riscv: dts: sophgo: add initial CV1800B SoC device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Chao Wei <chao.wei@sophgo.com>
CC: Chen Wang <unicorn_wang@outlook.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: devicetree@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..aec6401a467b 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -34,7 +34,6 @@ cpu0: cpu@0 {
 			cpu0_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
 				interrupt-controller;
-				#address-cells = <0>;
 				#interrupt-cells = <1>;
 			};
 		};
-- 
2.39.2

