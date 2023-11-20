Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20977F0E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjKTJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjKTJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:06:50 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78441EB;
        Mon, 20 Nov 2023 01:06:45 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
        by gateway (Coremail) with SMTP id _____8Dxl+ihIVtlYiw7AA--.15404S3;
        Mon, 20 Nov 2023 17:06:41 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.120])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxS9ydIVtlrmRHAA--.24751S2;
        Mon, 20 Nov 2023 17:06:39 +0800 (CST)
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
Subject: [PATCH v5 0/5] dt-bindings: interrupt-controller: Fix some loongson,liointc warnings
Date:   Mon, 20 Nov 2023 17:06:22 +0800
Message-Id: <cover.1700449792.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxS9ydIVtlrmRHAA--.24751S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryfJFyxGrW5Zr1rAF13trc_yoW5Jry5pF
        sxC3ZrGr45Kr4xAws8Jay8ZF1rZ398JasxWFs7A348CayDJw1qqr1SkF48Ar47CryaqFya
        qrWkKFWUGFyjkFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYE_NUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Of course, these fixes also apply to MIPS Loongson-2K1000.

Thanks.

-----
V5:
- Add Reviewed-by tag;
patch(1/5):
  - Just drop 'loongson,parent_int_map' instead of marking it as
    deprecated.

Link to V4:
https://lore.kernel.org/all/cover.1699521866.git.zhoubinbin@loongson.cn/

V4:
- Add Acked-by tag;
patch(2/5):
  - Just add 'maxitem 2' instead of duplicating the list;
patch(3/5):
  - Rewite commit message for 'interrupt-names'.

Link to V3:
https://lore.kernel.org/all/cover.1698717154.git.zhoubinbin@loongson.cn/

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
    warning for interrupt-names
  irqchip/loongson-liointc: Fix 'loongson,parent_int_map' parse
  MIPS: Loongson64: DTS: Fix 'loongson,parent_int_map' references

 .../loongson,liointc.yaml                     | 26 +++++++++++--------
 .../boot/dts/loongson/loongson64-2k1000.dtsi  |  4 +--
 .../dts/loongson/loongson64c-package.dtsi     |  2 +-
 .../dts/loongson/loongson64g-package.dtsi     |  2 +-
 .../dts/loongson/loongson64v_4core_virtio.dts |  2 +-
 drivers/irqchip/irq-loongson-liointc.c        |  7 ++++-
 6 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.39.3

