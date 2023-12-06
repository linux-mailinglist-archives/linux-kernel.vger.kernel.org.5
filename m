Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234B8075A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379475AbjLFQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378367AbjLFQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:48:04 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5E3FA;
        Wed,  6 Dec 2023 08:48:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50be24167efso6062022e87.3;
        Wed, 06 Dec 2023 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881288; x=1702486088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGSzAZDHU/n9n4Kl/KgrYsUZ99ohOk5K4a9HJ2xbUCo=;
        b=EaxK1idd2SlFs/60Z5wj/1EyJxXOuMvGDZoBxHrA0BaMFswSL8CIfsVFlg9V4wge/7
         vQsM6bXfZJyUjB3A5NNIJqlx38ouRUIJ3DjyR+9eXvHDjlPS4yxzKfPW+4jcGhJR1UOs
         n1bJ0eznGhjL2zlcNwAzOYp5jzflA75x4G4hIhcXeWH6IUYpl/DWxiLtJp99ElGmYJCV
         p3R/9EMpMv2PbX35EXly56LF5e3D77MWwGhWIs5oX6Mr02SXoqxKxeQ9LS0Pex0wO/y+
         jLCEklPN/0lRFoKL9JjomKO4ilkjFj9w03YKIA6k70ZUcutPiUffon3PSz+tPIu8v/tI
         M5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881288; x=1702486088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGSzAZDHU/n9n4Kl/KgrYsUZ99ohOk5K4a9HJ2xbUCo=;
        b=HIKrYLyoneuqZu1mpXXZAcRZNYJL//mEfkaMXFgPPaeJRR++WrmXKrNL6r3XNCyNQA
         tN4rKJuAjGRVGfHtbDq74KFKHSOQlUXthwJ7C34r7ZockmoT/cexyh12gmFioqNzbPvU
         0FZ+0hPTPd9lw5LbnjwGS2Y9rXoOKAKo8B9vu1wj0XiiLJBeSIc93lqZyTahPLLlTdFp
         woB5GKgJLUcnbL8JLOAg6h7fozvzQmIRKpEuHR4dcTTlqDNQO5GxczSb/N4tOV+Ix1Lz
         TUxrGeWf4QXEFP/IqusqQ2o6KUIhuf2uCzhfHCUjo8C4Tlvun+zXUplE8t1EvQshdQ6Q
         XF3Q==
X-Gm-Message-State: AOJu0YzTevaXQLbS8romBEgj9/lV/aamPwaqf9jUPDj1Qv/K/jP5UoN9
        bHl0pb5cKpsWueooFLs4B2c=
X-Google-Smtp-Source: AGHT+IGGsCsfCn951B9opx/elkmniv97coLdGTP1IxFSUUNeCLwVpJYe73n4VNAi886eyirSlSS2Sg==
X-Received: by 2002:ac2:5928:0:b0:50b:fdc0:acbb with SMTP id v8-20020ac25928000000b0050bfdc0acbbmr390516lfi.138.1701881288167;
        Wed, 06 Dec 2023 08:48:08 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n16-20020ac242d0000000b0050bde64af5esm1442481lfl.174.2023.12.06.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:48:07 -0800 (PST)
Date:   Wed, 6 Dec 2023 19:48:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <cv6oo27tqbfst3jrgtkg7bcxmeshadtzoomn2xgnzh2arz4nwy@wq5k7oygto6n>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-10-fancer.lancer@gmail.com>
 <20231205133205.3309ab91@device.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205133205.3309ab91@device.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, Dec 05, 2023 at 01:32:05PM +0100, Maxime Chevallier wrote:
> Hi Serge,
> 
> On Tue,  5 Dec 2023 13:35:30 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > Synopsys DesignWare XPCS IP-core can be synthesized with the device CSRs
> > being accessible over MCI or APB3 interface instead of the MDIO bus (see
> > the CSR_INTERFACE HDL parameter). Thus all the PCS registers can be just
> > memory mapped and be a subject of standard MMIO operations of course
> > taking into account the way the Clause C45 CSRs mapping is defined. This
> > commit is about adding a device driver for the DW XPCS Management
> > Interface platform device and registering it in the framework of the
> > kernel MDIO subsystem.
> > 
> > DW XPCS platform device is supposed to be described by the respective
> > compatible string "snps,dw-xpcs-mi", CSRs memory space and optional
> > peripheral bus clock source. Note depending on the INDIRECT_ACCESS DW XPCS
> > IP-core synthesize parameter the memory-mapped reg-space can be
> > represented as either directly or indirectly mapped Clause 45 space. In
> > the former case the particular address is determined based on the MMD
> > device and the registers offset (5 + 16 bits all together) within the
> > device reg-space. In the later case there is only 256 lower address bits
> > are utilized for the registers mapping. The upper bits are supposed to be
> > written into the respective viewport CSR in order to reach the entire C45
> > space.
> 

> Too bad the mdio-regmap driver can't be re-used here, it would deal
> with reg width for you, for example. I guess the main reason would be
> the direct vs indirect accesses ?

Right, it's one of the reasons. I could have used the mdio-regmap
here, but that would have meant to implement an additional abstraction
layer: regspace<->regmap<->mdio-regmap<->mii_bus, instead of just
regspace<->mii_bus. This would have also required to patch the
mdio-remap module somehow in order to have the c45 ops supported. It
would have been much easier to do before the commit 99d5fe9c7f3d ("net:
mdio: Remove support for building C45 muxed addresses"). But since
then MDIO reg-address has no longer had muxed dev-address. Of course I
could have got it back to the mdio-regmap driver only, mix the C22/C45
address in the regmap 'addr' argument, then extract the MMD (for C45)
and reg addresses from the regmap IO ops argument and perform the
respective MMIO access. But as you can see it is much hardware and
would cause additional steps for the address translations, than
just directly implement the C22/C45 IO ops and register the MDIO bus
for them. I couldn't find much benefits to follow that road, sorry.

> 
> I do have a comment tough :
> 
> [...]
> 
> > +static inline ptrdiff_t dw_xpcs_mmio_addr_format(int dev, int reg)
> > +{
> > +	return FIELD_PREP(0x1f0000, dev) | FIELD_PREP(0xffff, reg);
> > +}
> > +
> > +static inline u16 dw_xpcs_mmio_addr_page(ptrdiff_t csr)
> > +{
> > +	return FIELD_GET(0x1fff00, csr);
> > +}
> > +
> > +static inline ptrdiff_t dw_xpcs_mmio_addr_offset(ptrdiff_t csr)
> > +{
> > +	return FIELD_GET(0xff, csr);
> > +}
> 

> You shouldn't use inline in C files, only in headers.

Could you please clarify why? I failed to find such requirement in the
coding style doc. Moreover there are multiple examples of using the
static-inline-ers in the C files in the kernel including the net/mdio
subsystem.

-Serge(y)

> 
> Maxime
