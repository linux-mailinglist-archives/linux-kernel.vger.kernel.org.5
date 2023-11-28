Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD93A7FB7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbjK1Kbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjK1Kb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:31:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FA3C14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:27:29 -0800 (PST)
Date:   Tue, 28 Nov 2023 11:27:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701167247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Com+dSCJOw0HxlqQXnru2ux2jzcwVajuCWhe2agRAKM=;
        b=Qz/nZK38xViHxCURslOIAFGVL4DxjuvyNG3tjFfxiIFqdZMk13EArChMFoUXd/nGq0TL0X
        1+1jmw/IYGkk4vZLpidXLUe7llSzSOoTmS0F5BRFBTG5Cx426y+ydkZ1XZz2lN81dfIJXa
        iSHf7uaftCbeD8CZV4AJQ063SosFwFRcyO3tb2njriWkNQcyu8cR17azq6Brd+c8DnyHYt
        /+klD0il/PTXON1abstAkCKvZyLvDsekTBDgz0Pl8HCcMaw16jzEV3FFxG8/VgqzItwlNg
        vQGHX99r56d4aUEUocehn+jUJDcLJcDjJJpjuiIlaDgRrQt0zTCZMEI9Om5N2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701167247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Com+dSCJOw0HxlqQXnru2ux2jzcwVajuCWhe2agRAKM=;
        b=egK6HftxIq/OD6FIebCHW6srKzLu+xB9bJpMlmAIyyle7tSA0tlL/Z2WY/EJaHTkP7OVC5
        W29g0WvSoA0ziKDA==
From:   Nam Cao <namcao@linutronix.de>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Message-ID: <20231128102722.fQizGKfo@linutronix.de>
References: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 02:18:36PM +0800, Jia Jie Ho wrote:
> Selects ARM_AMBA platform support for StarFive SoCs required by spi and
> crypto dma engine.
> 
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  arch/riscv/Kconfig.socs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 1cf69f958f10..381cd46e6373 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -29,6 +29,7 @@ config SOC_STARFIVE
>  	bool "StarFive SoCs"
>  	select PINCTRL
>  	select RESET_CONTROLLER
> +	select ARM_AMBA
>  	help
>  	  This enables support for StarFive SoC platform hardware.

I'm considering sending this to stable trees. Without this, it is not
possible to configure the kernel with SPI driver for the starfive board.

I just want to check with you first, in case I miss something obvious.
Any objection to backporting this patch?

Best regards,
Nam
