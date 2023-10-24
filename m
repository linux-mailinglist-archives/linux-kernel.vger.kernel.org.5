Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF97D5128
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjJXNOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJXNN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:13:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640D210E;
        Tue, 24 Oct 2023 06:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698153214; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DLlVqmLPeG/3nPBWX3dS8znGiXydZyxE9lOOVefpmR5Gumb5do8MMbqnIYXctRU+aq
    YjuLCEGhQc0gZ6nxvpeoEhBwfxmjtLy/W7elq/ar6azHSbGiPrNSwiKCFq96DSLSZLL/
    deQnUqldW0HSFW6I/cywzSsqz1UX1UvAdIUO3Ct8a0jrvGA5YLOE7kGIrKiHCMyV1yYj
    Fn9ZxfYo2U47yun9Pkincp5NfHtTezM5hX4Z+W3gGDdMWM+T0R6nfiTA/wTPsgcyj6n2
    llucVTjDao6OQI4slwXr1Uuq9AaN/WZY9vZ3kjdZRxFXJgjdgFvWxqY4XHnlla+Kn5M5
    00FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698153214;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=W5wusIBKLee2orgc/xj8vY/2Cx7/lX+VsKgFuYpXUPU=;
    b=bsLOJs7L78GpxSismDxmiap08i/b75uNXE5L9GWE0OrkYuYmjOkvHcmjUzjAc/mNRX
    x0DS6D74WmZFxQAK+AYlAV9EC1JKyCfCZAvc18re+jXASnRupQzYaun0BKg22b/XJ1w4
    vx+YiPxWrT7fXbTtuz1BBVJxjhwQNaQWryn4nCRIwR3okG5jMPYOFgnm60aDcqU8igmI
    SnGzh6Tg1DTuYwlea0inOQS7Dxznx3AXtUqR5Q9IKeVICOxO/7/MUKzU8VqJNuAV6ann
    nnnIn4x3T5exhHiaSRnN5NjRnY4mCrp+2e3i1F4aM/T6nLLbAVFClP3Czu1b/tH1xCM9
    Tdyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698153214;
    s=strato-dkim-0002; d=ibv-augsburg.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=W5wusIBKLee2orgc/xj8vY/2Cx7/lX+VsKgFuYpXUPU=;
    b=dw+QTsEPwCQuQRFhKjXZg8z2u1XY538tMPeXPcLWzqmY9mVRcbIQhTnGr8TuW7AlMi
    tNvMCwodJ0lJNHsdQLI64x6Tg7d3y+o9zYl+I6cM2/gm4rSZdeQ4soKc5MUVBblI/pEF
    Zjf2MKfKgotq19BFtRYDbYuaZW2R2Mzqg47WfI1BJEZqgaqZ07P1ptlLVDCkQvM6eeoh
    Sov+UGRMXA0g3hQ0SVNf8CTRp2pw4Iy9pa+F1eFhkUNWianMDTsZozpYgbR93ESBvHGU
    BG4p38TpLy7GDecuIpdnxp/XVpL/SzELjFrflVnQ1KJxkAstzbPXB47RXR3Z4cSZMwq+
    Nmug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698153214;
    s=strato-dkim-0003; d=ibv-augsburg.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=W5wusIBKLee2orgc/xj8vY/2Cx7/lX+VsKgFuYpXUPU=;
    b=QJpQxi5ZkP/pG2FyuFrzMlNiHf7AqGNntOyiqgKAZcxoprwv0lZXAAN/3dVnvIPnM1
    LunHIpHS4Ed2KAHfhDAA==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+0odACkA=="
Received: from JADEVM-DRA
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id U33eaez9ODDXbSf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 24 Oct 2023 15:13:33 +0200 (CEST)
Date:   Tue, 24 Oct 2023 15:13:31 +0200
From:   Dominic Rath <dominic.rath@ibv-augsburg.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>, bahle@ibv-augsburg.de,
        rath@ibv-augsburg.de
Subject: Re: [PATCH v3 3/5] irqchip/gic-v3-its: Split allocation from
 initialisation of its_node
Message-ID: <20231024131331.GA4554@JADEVM-DRA>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
 <20231006125929.48591-4-lpieralisi@kernel.org>
 <20231024084831.GA3788@JADEVM-DRA>
 <86lebs493m.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86lebs493m.wl-maz@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:18:21AM +0100, Marc Zyngier wrote:
> Yeah, that's clearly a regression, and I've confirmed it on my
> Synquacer (which means the TI folks have accurately copied a dumb
> idea). Can you please give the patch below a go on your system and
> confirm asap whether it works for you?
> 

Thanks a lot, with that patch applied on top of 6.6-rc6 MSI-X interrupts
work again for the AM64x.

Best Regards,

Dominic

> > I have no idea whether TI's use of this quirk was "correct", but it did
> > work, and since 6.6-rc6 MSI-X has been broken for us.
> 
> Just as for bad SW, the worse HW ideas get replicated. Then I write
> bad SW for it.
> 
> Thanks,
> 
> 	M.
> 
> From b5571a69f09733ecfa0c944cc48baced6590d024 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Tue, 24 Oct 2023 11:07:34 +0100
> Subject: [PATCH] irqchip/gic-v3-its: Don't override quirk settings with
>  default values
> 
> When splitting the allocation of the ITS node from its configuration,
> some of the default settings were kept in the latter instead of
> being moved to the former.
> 
> This has the side effect of negating some of the quirk detection that
> have happened in between, amongst which the dreaded Synquacer hack
> (that also affect Dominic's TI platform).
> 
> Move the initialisation of these fields early, so that they can
> again be overriden by the Synquacer quirk.
> 
> Fixes: 9585a495ac93 ("irqchip/gic-v3-its: Split allocation from initialisation of its_node")
> Reported by: Dominic Rath <dominic.rath@ibv-augsburg.net>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Tested-by: Dominic Rath <dominic.rath@ibv-augsburg.net>

> Link: https://lore.kernel.org/r/20231024084831.GA3788@JADEVM-DRA
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 75a2dd550625..a8c89df1a997 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5112,8 +5112,6 @@ static int __init its_probe_one(struct its_node *its)
>  	}
>  	its->cmd_base = (void *)page_address(page);
>  	its->cmd_write = its->cmd_base;
> -	its->get_msi_base = its_irq_get_msi_base;
> -	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
>  
>  	err = its_alloc_tables(its);
>  	if (err)
> @@ -5362,6 +5360,8 @@ static struct its_node __init *its_node_init(struct resource *res,
>  	its->typer = gic_read_typer(its_base + GITS_TYPER);
>  	its->base = its_base;
>  	its->phys_base = res->start;
> +	its->get_msi_base = its_irq_get_msi_base;
> +	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
>  
>  	its->numa_node = numa_node;
>  	its->fwnode_handle = handle;
> -- 
> 2.39.2
> 
> 
> -- 
> Without deviation from the norm, progress is not possible.
