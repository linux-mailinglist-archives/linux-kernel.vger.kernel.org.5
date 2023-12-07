Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E578089C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442881AbjLGOCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjLGOCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:02:41 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCD5133;
        Thu,  7 Dec 2023 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KToobrjtx8bHUanPqkeSeV34L1vDgN1VtbwPowRALnQ=; b=YPat5xI6eBrv3+C+YkdTiRJB7M
        oV0REbgHItkm73igzwfcTnvly7Uml7dcjpEamNWAeRjMqXBTQw3d3R1mRAv6+o4uQ+Lt6430a8xpK
        KHKXt0HVslE/WcX7slKZPBjXLUh2E+cGPKoeVZ98lZvOvnZ0clx6LrhqkAX1LF9IH4BahjDSiRLNy
        Qo7Yd7qdtyGvN4PU2IzoZpIHT2gT+yPoThPSt9ZK7CtZUedUCbQQyU6duXRZjkSavIdEf9xMZEEed
        sHvGlelGiJhSW0txg4yAld9oZ8Aw5t0/2gbxYAeUQvkPUMHaiyolKBUPtw5TddSxwah2zQiY1/X/X
        3B0wRJzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38332)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rBExQ-0001AL-0q;
        Thu, 07 Dec 2023 14:02:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rBExP-0003mi-5N; Thu, 07 Dec 2023 14:02:27 +0000
Date:   Thu, 7 Dec 2023 14:02:27 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/16] net: mdio: Add Synopsys DW XPCS
 management interface support
Message-ID: <ZXHQcyZbXwesy0MV@shell.armlinux.org.uk>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-10-fancer.lancer@gmail.com>
 <20231205133205.3309ab91@device.home>
 <cv6oo27tqbfst3jrgtkg7bcxmeshadtzoomn2xgnzh2arz4nwy@wq5k7oygto6n>
 <15e6857a-b1d1-465a-945e-6f31edac62fb@lunn.ch>
 <jqwhgthwxfge6y4nv5mdnojqu76m4pi2mt2x6kwqiuqntcwj67@mewh42eey5ny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jqwhgthwxfge6y4nv5mdnojqu76m4pi2mt2x6kwqiuqntcwj67@mewh42eey5ny>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:35:47PM +0300, Serge Semin wrote:
> Hi Andrew
> 
> On Wed, Dec 06, 2023 at 06:01:30PM +0100, Andrew Lunn wrote:
> > The compiler does a better job at deciding what to inline than we
> > humans do. If you can show the compiler is doing it wrong, then we
> > might accept them.
> 
> In general I would have agreed with you especially if the methods were
> heavier than what they are:
> static inline ptrdiff_t dw_xpcs_mmio_addr_format(int dev, int reg)
> {               
>         return FIELD_PREP(0x1f0000, dev) | FIELD_PREP(0xffff, reg);
> }               
>         
> static inline u16 dw_xpcs_mmio_addr_page(ptrdiff_t csr)
> {       
>         return FIELD_GET(0x1fff00, csr);
> }       
> 
> static inline ptrdiff_t dw_xpcs_mmio_addr_offset(ptrdiff_t csr)
> {
>         return FIELD_GET(0xff, csr);
> }
> 
> > But in general, netdev does not like inline in .C
> > file.
> 
> I see. I'll do as you say if you don't change your mind after my
> reasoning below.

This isn't Andrew saying it - you seem to have missed the detail that
"netdev". If Andrew doesn't say it, then DaveM, Jakub or Paolo will.

Have you read the "Inline functions" section in
Documentation/process/4.Coding.rst ?

> > Also, nothing in MDIO is hot path, it spends a lot of time
> > waiting for a slow bus. So inline is likely to just bloat the code for
> > no gain.
> 
> I would have been absolutely with you in this matter, if we were talking
> about a normal MDIO bus. In this case the devices are accessed over
> the system IO-memory. So the bus isn't that slow.
> 
> Regarding the compiler knowing better when to inline the code. Here is
> what it does with the methods above. If the inline keyword is
> specified the compiler will inline all three methods. If the keyword isn't
> specified then dw_xpcs_mmio_addr_format() won't be inlined while the rest
> two functions will be. So the only part at consideration is the
> dw_xpcs_mmio_addr_format() method since the rest of the functions are
> inlined anyway.
> 
> The dw_xpcs_mmio_addr_format() function body is of the 5 asm
> instructions length (on MIPS). Since the function call in this case
> requires two jump instructions (to function and back), one instruction
> to save the previous return address on stack and two instructions for
> the function arguments, the trade-off of having non-inlined function
> are those five additional instructions on each call. There are four
> dw_xpcs_mmio_addr_format() calls. So here is what we get in both
> cases:
> inlined:     5 func ins * 4 calls = 20 ins
> non-inlined: (5 func + 1 jump) ins + (1 jump + 1 ra + 2 arg) ins * 4 calls  = 22 ins
> but seeing the return address needs to be saved anyway in the callers
> here is what we finally get:
> non-inlined: (5 func + 1 jump) ins + (1 jump + 2 arg) ins * 4 calls  = 18 ins
> 
> So unless I am mistaken in some of the aspects if we have the function
> non-inlined then we'll save 2 instructions in the object file, but
> each call would require additional _4_ instructions to execute (2
> jumps and 2 arg creations), which makes the function execution almost
> two times longer than it would have been should it was inlined.

Rather than just focusing on instruction count, you also need to
consider things like branch prediction, prefetching and I-cache
usage. Modern CPUs don't execute instruction-by-instruction anymore.

It is entirely possible that the compiler is making better choices
even if it results in more jumps in the code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
