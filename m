Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14B67571AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGRCQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGRCQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:16:20 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6594B11C;
        Mon, 17 Jul 2023 19:16:18 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
        by gateway (Coremail) with SMTP id _____8Cxc_Dw9bVkfV4GAA--.16556S3;
        Tue, 18 Jul 2023 10:16:16 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.108])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ8zt9bVkAXgyAA--.33506S3;
        Tue, 18 Jul 2023 10:16:14 +0800 (CST)
Message-ID: <dac99aca-aff4-b288-6dd5-c660514f2988@loongson.cn>
Date:   Tue, 18 Jul 2023 10:16:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] docs: move loongarch under arch
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Alex Shi <alexs@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wu XiangCheng <bobwxc@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:LOONGARCH" <loongarch@lists.linux.dev>
References: <87edl6wr9p.fsf@meer.lwn.net>
 <20230717192456.453124-1-costa.shul@redhat.com>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20230717192456.453124-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ8zt9bVkAXgyAA--.33506S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3tw4rurW3Ww13XF48CFW5XFc_yoWDWFWUpF
        929r97Kan3Cw1UG348Ga47Wr1UJF1xGa12qF13t340gFsrXw4vyr48tr90gFy7Jw4FyFWI
        gF4fK345ZFyjywbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/18 03:24, Costa Shulyupin 写道:
> and fix all in-tree references.
>
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>
> Changes:
> v3: fixed typo in drivers/irqchip/Kconfig
> v2: added fix of MAINTAINERS and drivers/irqchip/Kconfig
>
> I'll continue with the rest architectures.
> Thank you.
> ---
>   Documentation/arch/index.rst                                  | 2 +-
>   Documentation/{ => arch}/loongarch/booting.rst                | 0
>   Documentation/{ => arch}/loongarch/features.rst               | 0
>   Documentation/{ => arch}/loongarch/index.rst                  | 0
>   Documentation/{ => arch}/loongarch/introduction.rst           | 0
>   Documentation/{ => arch}/loongarch/irq-chip-model.rst         | 0
>   Documentation/translations/zh_CN/arch/index.rst               | 2 +-
>   .../translations/zh_CN/{ => arch}/loongarch/booting.rst       | 4 ++--
>   .../translations/zh_CN/{ => arch}/loongarch/features.rst      | 4 ++--
>   .../translations/zh_CN/{ => arch}/loongarch/index.rst         | 4 ++--
>   .../translations/zh_CN/{ => arch}/loongarch/introduction.rst  | 4 ++--
>   .../zh_CN/{ => arch}/loongarch/irq-chip-model.rst             | 4 ++--
>   MAINTAINERS                                                   | 4 ++--
>   drivers/irqchip/Kconfig                                       | 2 +-
>   14 files changed, 15 insertions(+), 15 deletions(-)
>   rename Documentation/{ => arch}/loongarch/booting.rst (100%)
>   rename Documentation/{ => arch}/loongarch/features.rst (100%)
>   rename Documentation/{ => arch}/loongarch/index.rst (100%)
>   rename Documentation/{ => arch}/loongarch/introduction.rst (100%)
>   rename Documentation/{ => arch}/loongarch/irq-chip-model.rst (100%)
>   rename Documentation/translations/zh_CN/{ => arch}/loongarch/booting.rst (94%)
>   rename Documentation/translations/zh_CN/{ => arch}/loongarch/features.rst (61%)
>   rename Documentation/translations/zh_CN/{ => arch}/loongarch/index.rst (78%)
>   rename Documentation/translations/zh_CN/{ => arch}/loongarch/introduction.rst (99%)
>   rename Documentation/translations/zh_CN/{ => arch}/loongarch/irq-chip-model.rst (98%)
>
> diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
> index 8458b88e9b79..4b6b1beebad6 100644
> --- a/Documentation/arch/index.rst
> +++ b/Documentation/arch/index.rst
> @@ -13,7 +13,7 @@ implementation.
>      arm/index
>      arm64/index
>      ia64/index
> -   ../loongarch/index
> +   loongarch/index
>      m68k/index
>      ../mips/index
>      nios2/index
> diff --git a/Documentation/loongarch/booting.rst b/Documentation/arch/loongarch/booting.rst
> similarity index 100%
> rename from Documentation/loongarch/booting.rst
> rename to Documentation/arch/loongarch/booting.rst
> diff --git a/Documentation/loongarch/features.rst b/Documentation/arch/loongarch/features.rst
> similarity index 100%
> rename from Documentation/loongarch/features.rst
> rename to Documentation/arch/loongarch/features.rst
> diff --git a/Documentation/loongarch/index.rst b/Documentation/arch/loongarch/index.rst
> similarity index 100%
> rename from Documentation/loongarch/index.rst
> rename to Documentation/arch/loongarch/index.rst
> diff --git a/Documentation/loongarch/introduction.rst b/Documentation/arch/loongarch/introduction.rst
> similarity index 100%
> rename from Documentation/loongarch/introduction.rst
> rename to Documentation/arch/loongarch/introduction.rst
> diff --git a/Documentation/loongarch/irq-chip-model.rst b/Documentation/arch/loongarch/irq-chip-model.rst
> similarity index 100%
> rename from Documentation/loongarch/irq-chip-model.rst
> rename to Documentation/arch/loongarch/irq-chip-model.rst
> diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
> index 6fa0cb671009..d4c1c729dde2 100644
> --- a/Documentation/translations/zh_CN/arch/index.rst
> +++ b/Documentation/translations/zh_CN/arch/index.rst
> @@ -13,7 +13,7 @@
>      ../riscv/index
>      openrisc/index
>      parisc/index
> -   ../loongarch/index
> +   loongarch/index
>   
>   TODOList:
>   
> diff --git a/Documentation/translations/zh_CN/loongarch/booting.rst b/Documentation/translations/zh_CN/arch/loongarch/booting.rst
> similarity index 94%
> rename from Documentation/translations/zh_CN/loongarch/booting.rst
> rename to Documentation/translations/zh_CN/arch/loongarch/booting.rst
> index fb6440c438f0..d2f55872904e 100644
> --- a/Documentation/translations/zh_CN/loongarch/booting.rst
> +++ b/Documentation/translations/zh_CN/arch/loongarch/booting.rst
> @@ -1,8 +1,8 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/loongarch/booting.rst
> +:Original: Documentation/arch/loongarch/booting.rst
>   
>   :翻译:
>   
> diff --git a/Documentation/translations/zh_CN/loongarch/features.rst b/Documentation/translations/zh_CN/arch/loongarch/features.rst
> similarity index 61%
> rename from Documentation/translations/zh_CN/loongarch/features.rst
> rename to Documentation/translations/zh_CN/arch/loongarch/features.rst
> index 3886e635ec06..82bfac180bdc 100644
> --- a/Documentation/translations/zh_CN/loongarch/features.rst
> +++ b/Documentation/translations/zh_CN/arch/loongarch/features.rst
> @@ -1,8 +1,8 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/loongarch/features.rst
> +:Original: Documentation/arch/loongarch/features.rst
>   :Translator: Huacai Chen <chenhuacai@loongson.cn>
>   
>   .. kernel-feat:: $srctree/Documentation/features loongarch
> diff --git a/Documentation/translations/zh_CN/loongarch/index.rst b/Documentation/translations/zh_CN/arch/loongarch/index.rst
> similarity index 78%
> rename from Documentation/translations/zh_CN/loongarch/index.rst
> rename to Documentation/translations/zh_CN/arch/loongarch/index.rst
> index 0273a08342f7..4bd24f5ffed1 100644
> --- a/Documentation/translations/zh_CN/loongarch/index.rst
> +++ b/Documentation/translations/zh_CN/arch/loongarch/index.rst
> @@ -1,8 +1,8 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/loongarch/index.rst
> +:Original: Documentation/arch/loongarch/index.rst
>   :Translator: Huacai Chen <chenhuacai@loongson.cn>
>   
>   =================
> diff --git a/Documentation/translations/zh_CN/loongarch/introduction.rst b/Documentation/translations/zh_CN/arch/loongarch/introduction.rst
> similarity index 99%
> rename from Documentation/translations/zh_CN/loongarch/introduction.rst
> rename to Documentation/translations/zh_CN/arch/loongarch/introduction.rst
> index 470c38ae2caf..cba04befc950 100644
> --- a/Documentation/translations/zh_CN/loongarch/introduction.rst
> +++ b/Documentation/translations/zh_CN/arch/loongarch/introduction.rst
> @@ -1,8 +1,8 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/loongarch/introduction.rst
> +:Original: Documentation/arch/loongarch/introduction.rst
>   :Translator: Huacai Chen <chenhuacai@loongson.cn>
>   
>   =============
> diff --git a/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> similarity index 98%
> rename from Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
> rename to Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> index fb5d23b49ed5..f1e9ab18206c 100644
> --- a/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
> +++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> @@ -1,8 +1,8 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/loongarch/irq-chip-model.rst
> +:Original: Documentation/arch/loongarch/irq-chip-model.rst
>   :Translator: Huacai Chen <chenhuacai@loongson.cn>
>   
>   ==================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0ccb621a660..b68512f1b65f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12282,8 +12282,8 @@ R:	WANG Xuerui <kernel@xen0n.name>
>   L:	loongarch@lists.linux.dev
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
> -F:	Documentation/loongarch/
> -F:	Documentation/translations/zh_CN/loongarch/
> +F:	Documentation/arch/loongarch/
> +F:	Documentation/translations/zh_CN/arch/loongarch/
>   F:	arch/loongarch/
>   F:	drivers/*/*loongarch*
>   
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 4b9036c6d45b..f7149d0f3d45 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -567,7 +567,7 @@ config IRQ_LOONGARCH_CPU
>   	help
>   	  Support for the LoongArch CPU Interrupt Controller. For details of
>   	  irq chip hierarchy on LoongArch platforms please read the document
> -	  Documentation/loongarch/irq-chip-model.rst.
> +	  Documentation/arch/loongarch/irq-chip-model.rst.
>   
>   config LOONGSON_LIOINTC
>   	bool "Loongson Local I/O Interrupt Controller"

