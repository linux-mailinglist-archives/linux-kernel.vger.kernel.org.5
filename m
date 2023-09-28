Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693AB7B21EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjI1QEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjI1QEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:04:49 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFB2D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:04:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-774141bb415so722726285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695917085; x=1696521885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+ucouahBzodNfkwXkONEMjzJwRkueDSEs192aSCAA0=;
        b=Kz8YeMeTFBVXfhMrl3Z5V+EqC5d7zMLrCllNlZQY3J3tUz4HuR+RtAuDMJfPjnyQlu
         JwH7vwEthw8ODEEBziZzHYLjGlLCX8W1n/yjakxDgdpz9GoAZZKSDVrkwdHsQce0j8Ox
         iPISz25o8b+zI9EQSoGzneQfmxCQJ3SIHWO6h9CVA8mpuHyl74TJUo3MPL7rGxvGX7BE
         1MLTt/PkNZJvXBOlUJ2v29zVe7n+8fQ0ducTmBVZYvTSz5QfkSRWoEiRdhaX3ecvQlWm
         nbQPle6yCxeIyLjk2EZc00LPToYDztLFbJm+K+cpgC+HRXiDXP/LXj2FzsXt2Nir7B5z
         pvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695917085; x=1696521885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+ucouahBzodNfkwXkONEMjzJwRkueDSEs192aSCAA0=;
        b=l8Xxj+k30vMfh/RDMr7rAECKYrvqcdzP07W1f2+tXDpfka3p9K7nHEnPcSBDuK9xZC
         qAIykY+ricUCPbxYR/KkdeuaBndhS4Tgbon5ZWHSUDJQdkzn/alkGucKM9frKSr9QOso
         h0eT1yvq7vSpOB7U6AP/3w2yhQJ/4MzqW6G291WnLB+4hXkU8dgJzpEUkPI4ATeDZ96r
         ilE0N/4uyvQjGoP7K4IbUfdWo6xjeTeQNC/GKETJc+NzByK2Ee5q2uYhTtNqVsPjNhfm
         zslqihg/Zi35WRvdSCbFZ9yq5ueYm1AlNCt6A8kSU5/k4QIPQVG7fUlHGfGz18eAPfR9
         +M5Q==
X-Gm-Message-State: AOJu0YxWIEZV42u0ZVNzFPISHuZYFaEJWm+Yc8+EpOUBTqO8W86o5TE/
        tBfv4a/fAlW227KjZxphMs5dDw==
X-Google-Smtp-Source: AGHT+IEVCX3Vi5r38laj9t0c+Q54sVhbFMpaufWR20pLsTUTRIUbpfy+kw5RKJUjBlcqi3oaDBXsRg==
X-Received: by 2002:a05:620a:4251:b0:76c:a695:fe5b with SMTP id w17-20020a05620a425100b0076ca695fe5bmr1902767qko.62.1695917085636;
        Thu, 28 Sep 2023 09:04:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:5086:8bae:a4b0:bdad? ([2600:1700:2000:b002:5086:8bae:a4b0:bdad])
        by smtp.gmail.com with ESMTPSA id o17-20020ae9f511000000b007659935ce64sm81657qkg.71.2023.09.28.09.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 09:04:45 -0700 (PDT)
Message-ID: <4e4bf02b-2264-491e-9b71-ae3b5ad7fc39@sifive.com>
Date:   Thu, 28 Sep 2023 11:04:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/riscv: Increase the clock_event
 rating
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230928104520.24768-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230928104520.24768-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-28 5:45 AM, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Renesas RZ/Five SoC has OSTM blocks which can be used for clock_event and
> clocksource [0]. The clock_event rating for the OSTM is set 300 but
> whereas the rating for riscv-timer clock_event is set to 100 due to which
> the kernel is choosing OSTM for clock_event.
> 
> As riscv-timer is much more efficient than MMIO clock_event, increase the
> rating to 400 so that the kernel prefers riscv-timer over the MMIO based
> clock_event.

This is only true if you have the Sstc extension and can set stimecmp directly.
Otherwise you have the overhead of an SBI call, which is going to be much higher
than an MMIO write. So the rating should depend on Sstc, as in this patch:

https://lore.kernel.org/linux-riscv/20230710131902.1459180-3-apatel@ventanamicro.com/

Regards,
Samuel

> 
> [0] drivers/clocksource/renesas-ostm.c
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note, Ive set the rating similar to RISC-V clocksource, on ARM architecture
> the rating for clk_event is set to 450.
> ---
>  drivers/clocksource/timer-riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index da3071b387eb..e4fc5da119a2 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -54,7 +54,7 @@ static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>  	.name			= "riscv_timer_clockevent",
>  	.features		= CLOCK_EVT_FEAT_ONESHOT,
> -	.rating			= 100,
> +	.rating			= 400,
>  	.set_next_event		= riscv_clock_next_event,
>  };
>  

