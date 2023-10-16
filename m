Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CF27CA94E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjJPN0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjJPN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:26:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15889B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:26:19 -0700 (PDT)
Date:   Mon, 16 Oct 2023 15:26:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697462777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnR2Spxg+qAwbstIwvkCiT/Z2Jf78hlNE5OSASBp5cA=;
        b=zI+0mF1Qswowds0i5C43J6iq1G+41ReV2qIY+3rexpII2s2Me+iWvv/nzsdrEfCq8TNAm4
        CJHLlEwhdzyXrSr/3NJ4K4lT1q3xJNnvj/vHeTQtqf6INVmxqL66RFmNoAEoZWNWOldOTy
        tzCvqVKBNNJ3wnsV0qiVFAGsRnKvEbRLK+SxTHtq6ib3GShLuynBvSKFfz09Sh6+KzTRIU
        1X4mGV/GgAUbEkP7IjXljgOLnIb7NmPe7sVbM/Y1vA6FF4Nzx13VgB6glDqy4hxWD8ws7G
        9OLRKjC+2xUcSx3LLX5RZGbu5cUT+Sf87qePGpD8cy7z8Vv2HgLpDci2tlME/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697462777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnR2Spxg+qAwbstIwvkCiT/Z2Jf78hlNE5OSASBp5cA=;
        b=3KHGM2bsnNxuHq6VrbMC80846B1xrqMxhBPYUiiIw+Sb3lFTdIpk9GBjo1CF0wTUcatKp9
        O/GupTTF7UNHd/AA==
From:   Nam Cao <namcao@linutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Message-ID: <20231016132613.m8o1+AMG@linutronix.de>
References: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
 <20230709-rundown-unsettled-403e8bf5cca5@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709-rundown-unsettled-403e8bf5cca5@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 11:10:47PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On Thu, 25 May 2023 14:18:36 +0800, Jia Jie Ho wrote:
> > Selects ARM_AMBA platform support for StarFive SoCs required by spi and
> > crypto dma engine.
> > 
> > 
> 
> Applied to riscv-soc-for-next, thanks!
> 
> [1/1] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
>       https://git.kernel.org/conor/c/1fcaaa1d489c
> 
> Thanks,
> Conor.

Sorry if it's a stupid question, but did this patch get lost somehow? It
hasn't made it to Linus's tree, and there is this message in your tree:
"Notice: this object is not reachable from any branch."

Best regards,
Nam
