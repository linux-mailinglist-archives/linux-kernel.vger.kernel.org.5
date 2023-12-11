Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D3380CB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbjLKNgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjLKNgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:36:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A97EC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:36:14 -0800 (PST)
Date:   Mon, 11 Dec 2023 14:36:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702301772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUVN2ssEkdii3K08E1/98BL+0ihkfVFzlz/Q0FL4OUg=;
        b=KZK07WrhyghsvuSIfVC1Bm2il+eSi7oZjLvolLZeZ5H/S6YL2HkuWA7PVnslatpO7QWb7W
        fu7yvTdI8jS4avc2Z0rJ1SxTNs2wO3lSGJB/BbHwdS+JiR16OClVW6nmMJYyY+SfTlSKPg
        YErUYCiQE8mRsWlUUhMyiQgMrpM72LhTToDQJOUasKo66z81Ccr96S3X9jj1gz/3uZ/ilw
        9iEbGfyTVmtV2FYM82DcmtUcsA7actso6CjVVJctdEpfwKVZ4fN+vUySY0s9fZJvxKzogV
        7uEUHLmjy82X9QKPZvpJTC0IMC9DVuvSd+nCPFTRft62jiONOQunwNnOgphWqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702301772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUVN2ssEkdii3K08E1/98BL+0ihkfVFzlz/Q0FL4OUg=;
        b=ea4nKht2x+grJeWHo9KkOymkLO/f67qRoaZdBmqBX4j84BGuOTpe9N2/yl964YAikRFnD5
        KxDI8TwD80q96cDQ==
From:   Nam Cao <namcao@linutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Message-ID: <20231211143611.5d0248bf@namcao>
In-Reply-To: <20231128-grandma-guru-4fc6e6950a75@wendy>
References: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
        <20231128102722.fQizGKfo@linutronix.de>
        <20231128-grandma-guru-4fc6e6950a75@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 10:59:44 +0000 Conor Dooley <conor.dooley@microchip.com> wrote:
> On Tue, Nov 28, 2023 at 11:27:22AM +0100, Nam Cao wrote:
> > On Thu, May 25, 2023 at 02:18:36PM +0800, Jia Jie Ho wrote:  
> > > Selects ARM_AMBA platform support for StarFive SoCs required by spi and
> > > crypto dma engine.
> > > 
> > > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > > ---
> > >  arch/riscv/Kconfig.socs | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > index 1cf69f958f10..381cd46e6373 100644
> > > --- a/arch/riscv/Kconfig.socs
> > > +++ b/arch/riscv/Kconfig.socs
> > > @@ -29,6 +29,7 @@ config SOC_STARFIVE
> > >  	bool "StarFive SoCs"
> > >  	select PINCTRL
> > >  	select RESET_CONTROLLER
> > > +	select ARM_AMBA
> > >  	help
> > >  	  This enables support for StarFive SoC platform hardware.  
> > 
> > I'm considering sending this to stable trees. Without this, it is not
> > possible to configure the kernel with SPI driver for the starfive board.
> > 
> > I just want to check with you first, in case I miss something obvious.
> > Any objection to backporting this patch?  
> 
> Personally I would be okay with that, otherwise the driver is dead code
> in those stable versions. Just be sure that the rename of some pl011
> variables (I think that's what it was) that was a pre-req for this being
> merged is in said versions of stable. An allmodconfig should flag
> whether that has happened pretty quickly.

Thanks for the info. I think I found what you are talking about:
a1a5f2c88725 ("dmaengine: pl330: rename _start to prevent build error")

It's been a while and no one else said anything, so I am going forward with
this.

Best regards,
Nam

