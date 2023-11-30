Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D5E7FFBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjK3T7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjK3T7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:59:31 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B47198;
        Thu, 30 Nov 2023 11:59:37 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9b9191722so18234391fa.1;
        Thu, 30 Nov 2023 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701374375; x=1701979175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOrjiusb1CkTjaA85Fcf3elk7qFz3xbmkdXxylcNE28=;
        b=FsJXTuxYuuvLREcp0aIXgWKf0+Ouodce80CE99kdywIl/OB+7Mj6XoMov/9ZRzuXLn
         jIvJ+EWaZuQN4jdId3OKESYiS7n2E6rko1aYDI3rpX1/SRBdlpA45vYRUDptmjBxg0ud
         44D3NBEc/ETLlBMmgH218BBwbd/hMwuKB5tDS7zut+ja2QjsckHcyoqyswhb9S1mKrxp
         Oui7az2xcUZC+G6iqZHXquGDpQf6J8yKlQX2W3I/ciVggaI2uFWD4ErH9y20cmu9GKAe
         WPyH5vTpOB9vVDl/GZJ6oRYcqhKt6/Q2t4wCytut66FU9NpEdSYzFRqs0+11RJQJpKUh
         f0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374375; x=1701979175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOrjiusb1CkTjaA85Fcf3elk7qFz3xbmkdXxylcNE28=;
        b=v7opJqnPBuXQj3cvG7VVvSASGc4VgbOv0WqD31OMphJUXnbNKfgcalQWE6pl+EE+yr
         DterJz5Umd8thcECJ0/se3nhGH3icuCwEDuuSJ92ahJD4yTMnFdSr6pWeyScLuEJeqmS
         R6+v6iC8H3sNacXdtMDhjDobKg/GLV3zITA8lcqR1iFcsSvon0UfgDX6mxksV1Bm3hVk
         qEskZ7qKirkTEnVBuInrcECGvD5cUDlU/sglauZzBBitXOK3hL/W4KH7DOA0EyTXyf6k
         291Veu4tKFpdbOGw/bEMIvhf2su26N9XNFx0us7DmCQVLxr1PwN3tCmJfXWkSj5jl3YN
         L1Kg==
X-Gm-Message-State: AOJu0YwnU3ZsWu4kMHH5giv6gX71ff5uwM7+kYb0S/R1huvah+aB23G7
        5oz0FaZm9R54wJDaobRgj/Y=
X-Google-Smtp-Source: AGHT+IHUjij89dN7TIrQl0G91Pfh+h20hbyKUIOT6zGRwQNGTZnnP7/pfZPelhLBC+F8nHc0nEECjw==
X-Received: by 2002:a2e:9219:0:b0:2c9:d874:20c4 with SMTP id k25-20020a2e9219000000b002c9d87420c4mr62616ljg.78.1701374375270;
        Thu, 30 Nov 2023 11:59:35 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id i17-20020a2e8091000000b002b9e5fe86dasm227571ljg.81.2023.11.30.11.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:59:34 -0800 (PST)
Date:   Thu, 30 Nov 2023 22:59:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, alexandre.torgue@foss.st.com,
        tali.perry1@gmail.com, edumazet@google.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, joabreu@synopsys.com, joel@jms.id.au,
        devicetree@vger.kernel.org, j.neuschaefer@gmx.net,
        robh+dt@kernel.org, peppe.cavallaro@st.com,
        linux-arm-kernel@lists.infradead.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <xvy2coamb6cl3wcbkl32f6w7kksoxfocyd63t7k7bz4pne2gyx@lktivhqovy7p>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
 <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
 <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
 <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch>
 <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
 <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com>
 <a551aefa-777d-4fd3-b1a5-086dc3e62646@lunn.ch>
 <CAP6Zq1jVO5y3ySeGNE5-=XWV6Djay5MhGxXCZb9y91q=EA71Vg@mail.gmail.com>
 <25d0c091-3dce-4d62-a112-c82106809c65@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d0c091-3dce-4d62-a112-c82106809c65@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:26:13PM +0100, Andrew Lunn wrote:
> > I will check with the xpcs maintainer how can we add indirect access
> > to the xpcs module.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c#L449
> 
> It creates a regmap for the memory range. On top of that it creates an
> MDIO bus. You can then access the PCS in the normal way.

Actually Synopsys DW XPCS can be synthesized with two types of the CSR
interfaces:
1. MDIO: device looks as a normal MDIO device. This option is currently
   supported by the STMMAC MDIO driver.
2. MCI/APB3: device MMD CSRs are directly (all CSRs are visible) or
   indirectly (paged-base access) accessible over the system memory bus.

In addition to the above XPCS device can be equipped with separate
clock sources (at least to feed the MCI or APB3 interface) and may
have dedicated IRQ line to signal various events like link
establishing, failures, etc. From that perspective XPCS in both cases
looks as a normal platform device for which would be better to have a
special DT-node defined with all those resources supplied. Then the
XPCS DT-node could be passed to the DW MAC DT-node via the already
standardized "pcs-handle" DT-property.

I have such approach implemented in my local repo. If you consider
this as a proper solution, after a small modification I'll be able to
submit a patchset for review tomorrow.

-Serge(y)

> 
> 	Andrew
> 
