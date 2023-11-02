Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4887DEE41
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjKBIiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKBIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:38:51 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF2128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:38:48 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da041ffef81so704686276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698914328; x=1699519128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MX2gk/Cxl4wXLQKYI24ffJCkT4RlP9TmZdj1aNtUnYE=;
        b=ISHWswscY3kaaRCWYXwp6z0kojEL+THykWZbm9miCYBIwYek+1tNq9KddJGzXI7gC5
         +6XNYctqOoDEz7tssTL7cnaBsPjCspJYhqjx1sahqlRsyICEoS4TwGICPOWObT1zvRS0
         2tYvkWteL3vxruidcYLN+vowS/lCO7KyoHBw3i33ZOAw5NWJ2X20p3sQsB4AtyZAo3Mk
         Lmd1RQ3ACeXXHXP4TtsYaf9cykgIhXk6GEk05bD0JAIgcHEFajrl0oHeA/+IXVmGCS47
         EGTpkVw+hwf2sfVj1lVA7A22uwYFADC4c7TbY29sXGoqLnUnF+woQ/CH1nHkj7zIyGTV
         EIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698914328; x=1699519128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MX2gk/Cxl4wXLQKYI24ffJCkT4RlP9TmZdj1aNtUnYE=;
        b=h4Yq0DhAtk/T/aQX/2hfhFuDzTVsC9vXJymb9ejit20NluYPDBIZU15DqHgshYonMT
         8bDBz35l4LlBxwDIG8LmF38vNArlsn0BZj6TvRYZyw20xSMIC3fM4xA79lVZOsI+5FGk
         2KGgWi2fe2bm0aV0UZloHzArQyZaWXH5Kjy1r2WbuTLYwyK2YovqagnFR6BDo898Sn9H
         lYla+LmTkjgZgNJ6lEebsgQj86sMsht5Sy6ZUfCWsFuX8DT139P23wB/fzkVbYbOvnvR
         ocf8hOChDRkLzsWaMm8gwZKHJeVZrbRvM/W0UAr5LdyCPLtUBb6x5EF5fXKGvn61VUCV
         puKg==
X-Gm-Message-State: AOJu0Yw4LzqKU9ehXS6cZE//xOUA1/Mq8pthc0g1i4NLmNktu2fklGAZ
        dvBgFA5tCEfj5DebTBNwZJAKxnW4JZHg0Q+veui8JXoWmds=
X-Google-Smtp-Source: AGHT+IFYJvDIrZEGLlekYy5y70QXRpdy1PHWPIXOwlqF+XaGVqQHg0xMqJX9WCqjGrTRphgeM4+PuY81okxrDdAmlqM=
X-Received: by 2002:a25:e753:0:b0:d89:aa7e:aed9 with SMTP id
 e80-20020a25e753000000b00d89aa7eaed9mr16130762ybh.23.1698914327935; Thu, 02
 Nov 2023 01:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231102002453.1299195-1-william@wkennington.com> <20231102005321.1303809-1-william@wkennington.com>
In-Reply-To: <20231102005321.1303809-1-william@wkennington.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 2 Nov 2023 10:38:36 +0200
Message-ID: <CAP6Zq1ig9hadeWATYVgzZkhmsU3qe6Se+hwU6rSjvnGr0OmvMA@mail.gmail.com>
Subject: Re: [PATCH RESEND] ARM: npcm: Add CPU hotplug callbacks for kexec support
To:     william@wkennington.com
Cc:     tali.perry1@gmail.com, avifishman70@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Brian Ma <chma0@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,


On Thu, 2 Nov 2023 at 02:53, <william@wkennington.com> wrote:
>
> From: Brian Ma <chma0@nuvoton.com>
>
> Add callbacks required for kexec to function. The NPCM7xx/NPCN8xx does
> not expose controls for powering down CPU cores, so just wait in idle
> loop.
This patch is related only to NPCM7xx please modify NPCM7xx/NPCN8xx to NPCM7xx.
>
> Signed-off-by: Brian Ma <chma0@nuvoton.com>
> Signed-off-by: William A. Kennington III <william@wkennington.com>
> ---
>  arch/arm/mach-npcm/platsmp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
> index 41891d3aa124..6cc7b5894f08 100644
> --- a/arch/arm/mach-npcm/platsmp.c
> +++ b/arch/arm/mach-npcm/platsmp.c
> @@ -69,10 +69,27 @@ static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
>
>         iounmap(scu_base);
>  }
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void npcm7xx_cpu_die(unsigned int cpu)
> +{
> +       while (1)
> +               cpu_do_idle();
> +}
> +
> +static int npcm7xx_cpu_kill(unsigned int l_cpu)
> +{
> +       return 1;
> +}
> +#endif
> +
>
>  static struct smp_operations npcm7xx_smp_ops __initdata = {
>         .smp_prepare_cpus = npcm7xx_smp_prepare_cpus,
>         .smp_boot_secondary = npcm7xx_smp_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
> +       .cpu_die                        = npcm7xx_cpu_die,
> +       .cpu_kill                       = npcm7xx_cpu_kill,
> +#endif
>  };
>
>  CPU_METHOD_OF_DECLARE(npcm7xx_smp, "nuvoton,npcm750-smp", &npcm7xx_smp_ops);
> --
> 2.42.0.820.g83a721a137-goog
>

Best regards,

Tomer
