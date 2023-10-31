Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4578B7DC479
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjJaCgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjJaCgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:36:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 572A69F;
        Mon, 30 Oct 2023 19:36:47 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.17])
        by gateway (Coremail) with SMTP id _____8AxV_E8aEBlLd41AA--.40546S3;
        Tue, 31 Oct 2023 10:36:44 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.17])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy85aEBla0Q3AA--.53709S2;
        Tue, 31 Oct 2023 10:36:42 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 0/5] dt-bindings: interrupt-controller: Fix some loongson,liointc warnings
Date:   Tue, 31 Oct 2023 10:36:35 +0800
Message-Id: <cover.1698717154.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axzy85aEBla0Q3AA--.53709S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryfJFyxGrW5CrW5CrWfWFX_yoW8ZF15pF
        sxA3WDKr4UtFWxArs8Ja48Arn5ZFW5JasxWFs7A3WfCayDX34jqr1SkF48Ar47Cry3X34a
        vrykKrWUGFyUCFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

Some liointc-related DTBS_CHECK warnings were found when trying to
introduce the Loongson-2K DTS{I} for LoongArch.
This patch series attempts to fix those warnings, as well as fixing
non-standard property naming.

Of course, these fixes also apply to MIPS Loongson-2K1000/Loongson-3A
dts{i}.

Thanks.

-----
V3:
patch(1/5):
  - new patch, 'loongson,parent_int_map' renamed to 'loongson,parent-int-map';
patch(2/5)(3/5):
  - Separate the change points into separate patches;
patch(4/5):
 - new patch, make sure both parent map forms can be parsed;
patch(5/5):
 - new patch, fix 'loongson,parent_int_map' references in mips loongson
   dts{i}.

Link to V2:
https://lore.kernel.org/all/20230821061315.3416836-1-zhoubinbin@loongson.cn/

V2:
1. Update commit message;
2. "interruprt-names" should be "required", the driver gets the parent
interrupts through it;
3. Add more descriptions to explain the rationale for multiple nodes;
4. Rewrite if-else statements.

Link to V1:
https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongson.cn/

Binbin Zhou (5):
  dt-bindings: interrupt-controller: loongson,liointc: Standardize the
    naming of 'loongson,parent-int-map'
  dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check
    warning for reg-names
  dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check
    for interrupt-names
  irqchip/loongson-liointc: Fix 'loongson,parent_int_map' parse
  MIPS: Loongson64: DTS: Fix 'loongson,parent_int_map' references

 .../loongson,liointc.yaml                     | 44 +++++++++++++------
 .../boot/dts/loongson/loongson64-2k1000.dtsi  |  4 +-
 .../dts/loongson/loongson64c-package.dtsi     |  2 +-
 .../dts/loongson/loongson64g-package.dtsi     |  2 +-
 .../dts/loongson/loongson64v_4core_virtio.dts |  2 +-
 drivers/irqchip/irq-loongson-liointc.c        |  7 ++-
 6 files changed, 41 insertions(+), 20 deletions(-)

-- 
2.39.3

