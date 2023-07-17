Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A90756642
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGQOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:23:49 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08173A1;
        Mon, 17 Jul 2023 07:23:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8FD625BF;
        Mon, 17 Jul 2023 14:23:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8FD625BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689603827; bh=wC/sqgz5xsdanwszDeKUfk2KUzM+XO1KRTq8or0Db40=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=Bl8Il627ZcL2pgqxNJSJ5weZgg63d7bpOCCpoyEH7hyNtkgCmA4pNoRSp+FkuHcJI
         NXC+cmfhwRX3Dd/akOavmziEVFbzPSgQJmuGaPfyodxDYto7NoZYrO/gz+DbDdg18g
         KxDp7WGa+vpXRXqecKZB57bOd94yqviAdZv3mVLNtYhCsJK3KULFbi9jpzpg0O4ezw
         wydqrCwtw7R0N3NK/v0sKWg1XuRHL2drH4pJ1nx/qwXsxjBJYOl4JH6PCU33KEwxjJ
         ro8WtFs1ugalAW+bJq4zF6F6XalUvX4Btq9L6WWW8JkX+dc9cHLuVg9ZELyWqA7fXp
         SRFRpARM0PBCg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:LOONGARCH" <loongarch@lists.linux.dev>
Subject: Re: [PATCH v2] docs: move loongarch under arch
In-Reply-To: <20230717141345.431342-1-costa.shul@redhat.com>
References: <87mszuwt4r.fsf@meer.lwn.net>
 <20230717141345.431342-1-costa.shul@redhat.com>
Date:   Mon, 17 Jul 2023 08:23:46 -0600
Message-ID: <87edl6wr9p.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> and fix all in-tree references.
>
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>
> Changes:
> - added fix of MAINTAINERS and drivers/irqchip/Kconfig 

Um ....

> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 4b9036c6d45b..5e54032f07c6 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -567,7 +567,7 @@ config IRQ_LOONGARCH_CPU
>  	help
>  	  Support for the LoongArch CPU Interrupt Controller. For details of
>  	  irq chip hierarchy on LoongArch platforms please read the document
> -	  Documentation/loongarch/irq-chip-model.rst.
> +	  Documentation/arch/oongarch/irq-chip-model.rst.

Can you please try to be a bit more careful than that?

Thanks,

jon
