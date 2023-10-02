Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1670F7B586D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbjJBQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjJBQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:32:19 -0400
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 09:32:16 PDT
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3F19B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:32:16 -0700 (PDT)
Message-ID: <0a959d0e-ac9d-ef67-bfec-f58e31db7e56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696263808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WuiXeew+EnJLhOC24vX2ovu6vzr95RjE0zFrm4PiD6k=;
        b=PoAJtmm7El2yBfCchnunakTLnWpew12e4Y4z2DXUq7JOYILFk7TLRCWchqbMArwE0nuWA1
        dUZ+AkKr2jInAzVxr4DyM2mWhetA23O6IBezrDYzYLWaWN/R+F2El7CEGYVW8FaGcRQ0pX
        egGDuCm6GDdf/18C4WCQryK4NSxapDk=
Date:   Tue, 3 Oct 2023 00:22:58 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] MAINTAINERS: Add myself as the ARM GIC maintainer
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231002141302.3409485-1-maz@kernel.org>
 <20231002141302.3409485-2-maz@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20231002141302.3409485-2-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/2 22:13, Marc Zyngier wrote:
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

Great. Previously patches targetting the Arm GIC drivers are usually not
sent to LAKML. With Will's suggestion addressed,

Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
