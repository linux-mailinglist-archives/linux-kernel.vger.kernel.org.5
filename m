Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAFD7B54FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjJBO0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjJBO0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:26:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC5A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:26:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1146C433C8;
        Mon,  2 Oct 2023 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696256762;
        bh=WVaOWjmAPhEYGLQ/dhrK6Xdg4Cwe61FXo2unxl9a7Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWQCmj4XJsHD4MO2gtYL+UCF7l1D1C/lphxyn1TpcB3NCszlhd5R/YcmZvgVmG5Wv
         U9g1afdGi7oKG8H0AufqHL2ZZWvxCByhiHJFfZX1CLopO4NbKpn9WvfGMJyU2Vx5t8
         O8G6d3aNteux9swVR4YOEHDyFIgQSvJbsm3z4EQ+TwG7+cjcmqnGZ3mpxdbVmhO6AA
         ZKspYlu2LzTnZmjLR9h6kdVzIMLTGOzEbX3bJZyn76ImfIb2bEWMgNEl38P5sjqhpV
         2BIqP/EMmXPnHuztFDQHrFrsCZYbrgDEXO9WKY+sC13o0eYdqTeI61gebZR9e7MWzj
         CMDNG0H0E0Z9Q==
Date:   Mon, 2 Oct 2023 15:25:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add myself as the ARM GIC maintainer
Message-ID: <20231002142556.GA1435@willie-the-truck>
References: <20231002141302.3409485-1-maz@kernel.org>
 <20231002141302.3409485-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002141302.3409485-2-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:13:01PM +0100, Marc Zyngier wrote:
> The ARM GIC maintenance is currently covered by the blanket
> IRQCHIP DRIVERS entry, which I'm about to remove myself from.
> 
> It is unlikely that anyone is mad enough to pick this up,
> so I'll keep doing that for the foreseable future.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35977b269d5e..f37f4ee96b20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1585,6 +1585,14 @@ F:	arch/arm/include/asm/arch_timer.h
>  F:	arch/arm64/include/asm/arch_timer.h
>  F:	drivers/clocksource/arm_arch_timer.c
>  
> +ARM GENERIC INTERRUPT CONTROLLER DRIVERS
> +M:	Marc Zyngier <maz@kernel.org>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm/include/asm/arch_gicv3.h
> +F:	arch/arm64/include/asm/arch_gicv3.h
> +F:	drivers/irqchip/irq-gic*.[ch]

Do you want the GIC headers in include/linux/irqchip/ as well?

Will
