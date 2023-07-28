Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF6766AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjG1KkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbjG1Kj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC8830C2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940E8620DD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB14BC433CC;
        Fri, 28 Jul 2023 10:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690540671;
        bh=ONObWE6ZhfDnATcaTcPlY8CoLD+81fZVEWLGKUEkp94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qv6/cG2nGfQHwUQNpVT3rvmYUoTXiiuA0eAvXaYtS6Q44y8gLerW54dJZMLeFZZgN
         pndTqVw5Wvyqi9XxPyHcOKVEXrUD5HW3qRpMicZlP9XDZwfADMUjvuJJCrOg058YRs
         zjVGhxgJK2/nQC5tWwqmkiIu+wciQOpKTAa4hz9LhW8IJexxtU1UoUGGgYElKQYIaF
         LzVvLphH7r0IRDnPZAb6MeC+oTJ2k+woTV+7L1E0N3mKj7W+rexcKR5Ba8WcPvAI3Q
         WmhSuC9JdzpsA8IpK5xWOzZVtl59diAErplaoWn/XGGJ7+dDnx+Aj5wHqxDqpvYM4z
         kJUkxm1hwZG0A==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qPKqy-0002xP-NI;
        Fri, 28 Jul 2023 11:37:48 +0100
MIME-Version: 1.0
Date:   Fri, 28 Jul 2023 11:37:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     tglx@linutronix.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hari Prasath <Hari.PrasathGE@microchip.com>
Subject: Re: [PATCH v3 42/50] irqchip/atmel-aic5: Add support for sam9x7 aic
In-Reply-To: <20230728103002.267440-1-varshini.rajendran@microchip.com>
References: <20230728103002.267440-1-varshini.rajendran@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <87ee1e3c365686bc60e92ba3972dc1a5@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: varshini.rajendran@microchip.com, tglx@linutronix.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hari.PrasathGE@microchip.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-28 11:30, Varshini Rajendran wrote:
> From: Hari Prasath <Hari.PrasathGE@microchip.com>
> 
> Add support for the Advanced interrupt controller(AIC) chip in the 
> sam9x7.
> 
> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  drivers/irqchip/irq-atmel-aic5.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic5.c 
> b/drivers/irqchip/irq-atmel-aic5.c
> index 145535bd7560..bab11900f3ef 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -320,6 +320,7 @@ static const struct of_device_id aic5_irq_fixups[]
> __initconst = {
>  	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
>  	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
>  	{ .compatible = "microchip,sam9x60", .data = sam9x60_aic_irq_fixup },
> +	{ .compatible = "microchip,sam9x7", .data = sam9x60_aic_irq_fixup },
>  	{ /* sentinel */ },
>  };
> 
> @@ -406,3 +407,12 @@ static int __init sam9x60_aic5_of_init(struct
> device_node *node,
>  	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
>  }
>  IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", 
> sam9x60_aic5_of_init);
> +
> +#define NR_SAM9X7_IRQS		70

One can only wonder why this stuff doesn't come from the device tree,
given that there is no other meaningful difference between this
version of the IP and the previous ones...

         M.

> +
> +static int __init sam9x7_aic5_of_init(struct device_node *node,
> +				      struct device_node *parent)
> +{
> +	return aic5_of_init(node, parent, NR_SAM9X7_IRQS);
> +}
> +IRQCHIP_DECLARE(sam9x7_aic5, "microchip,sam9x7-aic", 
> sam9x7_aic5_of_init);

-- 
Jazz is not dead. It just smells funny...
