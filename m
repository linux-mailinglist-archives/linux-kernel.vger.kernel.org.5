Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C26808948
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441934AbjLGNfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442011AbjLGNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:35:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD59123;
        Thu,  7 Dec 2023 05:35:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50be3eed85aso886460e87.2;
        Thu, 07 Dec 2023 05:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956151; x=1702560951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DE2zFskkDTSnqEUr5OB7Tct7a2e7vqqhqiLJL3O/hkk=;
        b=KJQdZ+qJlJ6FVDgAxHaA38o34Hy/dL74T5lvCDNCgp/ceKAGIpzNvO5bgtYEzqXzak
         j5i1i/ADcZ2C3gF+ILRzbXSs73o68vrO0FwfS2nIa5AZSj/FERjqsAPmgHASmgZnTbcY
         kq0907N0YNHaTs3UQtb67857AP1kbuyCesANQ5tDi9jgRMrD3ZnFhw1/ZtseLNwVgJqb
         KeEr8WhewcPk1ukT5nk1xPnG/LRldc7rRR/d3+/QjCGTWnhSxNzYW0lZ5WkG1zjbIvvt
         3UlLnQl12Huw8dD4C5t/+IrZHVkJjRmC4u4mUZcRZFAiWTVHJ84C4IGXlrGZqrr2YHiH
         BQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956151; x=1702560951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DE2zFskkDTSnqEUr5OB7Tct7a2e7vqqhqiLJL3O/hkk=;
        b=uuqFSNvAkRIp4YzL4XBmzNxjmp7JIaB6MKn6bu2PQ0HtVT1/EFXqnHLUIS9VWcQs9q
         SJnmHda71TgtNREvmDCVgQYPmWKFYhFnAIH25nWxRgD5loJMf2vt8PpBG1z4J4/rAgUd
         qodcT0osBSldCnhxjvLoP7VeGRteyhHhJqdpEiTDyR7zuJUiJJnEmbGJyZhV8RelWDZu
         S+Cc9nY48C2EjkkKdMMHlBrotN2jqrdjN/iHav+RAGGphm3O8nWrcC/JK6sJY2mVh36o
         2Bl2RGWWZ8fY+/PAxkox8XD38P4LCmtrLjBMwKHSnjemrTXLsh6nHDtj7wl0Ucl1FrqC
         ggVg==
X-Gm-Message-State: AOJu0YwSXTfBKWmq48iagfbNYCvEWwIbpDCPSwjSueB7od31VNSCZJIr
        FTQZLGE8GVazGb1bZFkHLoI=
X-Google-Smtp-Source: AGHT+IFpxi32i/H2T4l/U2UQxsPFB0f94jLoEstgg/x9ZHx2sGmv9RsyaRRUJxbdN9o8b/cu5/ilBA==
X-Received: by 2002:a05:6512:3124:b0:50c:a39:ee37 with SMTP id p4-20020a056512312400b0050c0a39ee37mr1567241lfd.109.1701956150819;
        Thu, 07 Dec 2023 05:35:50 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id bp42-20020a05651215aa00b0050bf8852fb1sm174527lfb.45.2023.12.07.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:35:50 -0800 (PST)
Date:   Thu, 7 Dec 2023 16:35:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
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
Message-ID: <jqwhgthwxfge6y4nv5mdnojqu76m4pi2mt2x6kwqiuqntcwj67@mewh42eey5ny>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-10-fancer.lancer@gmail.com>
 <20231205133205.3309ab91@device.home>
 <cv6oo27tqbfst3jrgtkg7bcxmeshadtzoomn2xgnzh2arz4nwy@wq5k7oygto6n>
 <15e6857a-b1d1-465a-945e-6f31edac62fb@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e6857a-b1d1-465a-945e-6f31edac62fb@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On Wed, Dec 06, 2023 at 06:01:30PM +0100, Andrew Lunn wrote:
> > > You shouldn't use inline in C files, only in headers.
> > 
> > Could you please clarify why? I failed to find such requirement in the
> > coding style doc. Moreover there are multiple examples of using the
> > static-inline-ers in the C files in the kernel including the net/mdio
> > subsystem.
> 

> The compiler does a better job at deciding what to inline than we
> humans do. If you can show the compiler is doing it wrong, then we
> might accept them.

In general I would have agreed with you especially if the methods were
heavier than what they are:
static inline ptrdiff_t dw_xpcs_mmio_addr_format(int dev, int reg)
{               
        return FIELD_PREP(0x1f0000, dev) | FIELD_PREP(0xffff, reg);
}               
        
static inline u16 dw_xpcs_mmio_addr_page(ptrdiff_t csr)
{       
        return FIELD_GET(0x1fff00, csr);
}       

static inline ptrdiff_t dw_xpcs_mmio_addr_offset(ptrdiff_t csr)
{
        return FIELD_GET(0xff, csr);
}

> But in general, netdev does not like inline in .C
> file.

I see. I'll do as you say if you don't change your mind after my
reasoning below.

> Also, nothing in MDIO is hot path, it spends a lot of time
> waiting for a slow bus. So inline is likely to just bloat the code for
> no gain.

I would have been absolutely with you in this matter, if we were talking
about a normal MDIO bus. In this case the devices are accessed over
the system IO-memory. So the bus isn't that slow.

Regarding the compiler knowing better when to inline the code. Here is
what it does with the methods above. If the inline keyword is
specified the compiler will inline all three methods. If the keyword isn't
specified then dw_xpcs_mmio_addr_format() won't be inlined while the rest
two functions will be. So the only part at consideration is the
dw_xpcs_mmio_addr_format() method since the rest of the functions are
inlined anyway.

The dw_xpcs_mmio_addr_format() function body is of the 5 asm
instructions length (on MIPS). Since the function call in this case
requires two jump instructions (to function and back), one instruction
to save the previous return address on stack and two instructions for
the function arguments, the trade-off of having non-inlined function
are those five additional instructions on each call. There are four
dw_xpcs_mmio_addr_format() calls. So here is what we get in both
cases:
inlined:     5 func ins * 4 calls = 20 ins
non-inlined: (5 func + 1 jump) ins + (1 jump + 1 ra + 2 arg) ins * 4 calls  = 22 ins
but seeing the return address needs to be saved anyway in the callers
here is what we finally get:
non-inlined: (5 func + 1 jump) ins + (1 jump + 2 arg) ins * 4 calls  = 18 ins

So unless I am mistaken in some of the aspects if we have the function
non-inlined then we'll save 2 instructions in the object file, but
each call would require additional _4_ instructions to execute (2
jumps and 2 arg creations), which makes the function execution almost
two times longer than it would have been should it was inlined. IMO in
this case saving 2 instructions of the object file isn't worth than
getting rid from four instructions on each call seeing the DW XPCS
MCI/APB3 buses are the memory IO interfaces which don't require any
long-time waits to perform the ops. Thus I'd suggest to keep the
inline keywords specified here.

What is your conclusion?

-Serge(y)

> 
>    Andrew
