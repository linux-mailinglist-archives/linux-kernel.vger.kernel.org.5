Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6F801165
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378263AbjLAQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjLAQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:25:18 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF852A6;
        Fri,  1 Dec 2023 08:25:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bdebb1786so496299e87.1;
        Fri, 01 Dec 2023 08:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701447923; x=1702052723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fe9LinVeEIS31sVu9a8Ip9icgC4gCnScZC9xWW4pX4=;
        b=kO8eVe2Om6W7oe8P2GtUiPRM6d//ZVGK8ZKlWqc3qpCabfCj5QhOliNY8AzBWpVh9S
         6erIbTR60xmsZvMEcGYDLxCZy3HBz8eCcApG5tt90EOvgFrfQ34n5Tdk7YD+vOKydo0s
         eBbQTDjJtORLSaz/5hwVjATqT8Oygfb6kOQkIPxmib/hGNc8Fg1zKT4iv3imRJj6ZXD1
         p10v262tO1cRmhiMjxhqOrLUq6qs0C8bxpR8Z6JXeLWh2X1LgK50BKVH2w0m8hiL7bbm
         Y3GJ1yDE5T4WGA0tQ82og9/B7oS3pZ8PYogts2+MNO2SkVw8ssnOuxIxptPGoivQr/Bo
         IAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447923; x=1702052723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Fe9LinVeEIS31sVu9a8Ip9icgC4gCnScZC9xWW4pX4=;
        b=pQayqNNZBc0Kdmf1KPXI+JyWVQrEyX4e2OBlH1EHIY/Q0GmZHbmE7pbcng0KYdaY9U
         z0o4iXBIm60nuntTa/5NXFeU5ZEbU/w/ddZVJJU9yAhzTlyiBNlK/TIbwGNh3Ob1cDia
         2Qp5ZWnDxUNkkBD6k9sKZe1yX6t5grnhyKYmJHO9OA/pbUkA2/+XNf6OYFgBr6RSSaY0
         wr+slLbf0XzNIwDDR2cMX80iiwTvCVCDtgrS7ZrD7Y4ewSeYtcaLPgx4OI9JKJLJaaxG
         S98tQsWdm0Z56SKBeUFWuXz+01gnj7cSaFYJukm0k+mznwiP957NK9iJugoGlk3N0eKD
         kXGA==
X-Gm-Message-State: AOJu0Yzp1WuUQUsQyZcGufMCHbEWalnuT20eX1MReqjREGdpK5xKsagN
        FoX4I6Dj3666PTGhJh8ggSE=
X-Google-Smtp-Source: AGHT+IED2w+hujxue7bm9bOGpjjCdvrKzr90/3i7E5Xd7uj7qqmqvOaSeS01ayw0GAygOWScKCMiaA==
X-Received: by 2002:a05:6512:280b:b0:50b:d764:64c0 with SMTP id cf11-20020a056512280b00b0050bd76464c0mr1188134lfb.117.1701447922712;
        Fri, 01 Dec 2023 08:25:22 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b0050bc303f3cbsm232121lfr.173.2023.12.01.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:25:22 -0800 (PST)
Date:   Fri, 1 Dec 2023 19:25:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        davem@davemloft.net, avifishman70@gmail.com, venture@google.com,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        tali.perry1@gmail.com, mcoquelin.stm32@gmail.com,
        edumazet@google.com, joabreu@synopsys.com, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, peppe.cavallaro@st.com,
        j.neuschaefer@gmx.net, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjaminfair@google.com
Subject: Re: [Linux-stm32] [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <dfbwvsvefbkj6lodj5nmj2up32vnai32u3qk667mpfjytvmp4z@uvny7nhaykzi>
References: <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
 <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
 <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch>
 <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
 <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com>
 <a551aefa-777d-4fd3-b1a5-086dc3e62646@lunn.ch>
 <CAP6Zq1jVO5y3ySeGNE5-=XWV6Djay5MhGxXCZb9y91q=EA71Vg@mail.gmail.com>
 <25d0c091-3dce-4d62-a112-c82106809c65@lunn.ch>
 <xvy2coamb6cl3wcbkl32f6w7kksoxfocyd63t7k7bz4pne2gyx@lktivhqovy7p>
 <20231130213441.032a661c@device.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130213441.032a661c@device.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, Nov 30, 2023 at 09:34:41PM +0100, Maxime Chevallier wrote:
> Hello,
> 
> On Thu, 30 Nov 2023 22:59:32 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > On Thu, Nov 30, 2023 at 06:26:13PM +0100, Andrew Lunn wrote:
> > > > I will check with the xpcs maintainer how can we add indirect access
> > > > to the xpcs module.  
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c#L449
> > > 
> > > It creates a regmap for the memory range. On top of that it creates an
> > > MDIO bus. You can then access the PCS in the normal way.  
> > 
> > Actually Synopsys DW XPCS can be synthesized with two types of the CSR
> > interfaces:
> > 1. MDIO: device looks as a normal MDIO device. This option is currently
> >    supported by the STMMAC MDIO driver.
> > 2. MCI/APB3: device MMD CSRs are directly (all CSRs are visible) or
> >    indirectly (paged-base access) accessible over the system memory bus.
> > 
> > In addition to the above XPCS device can be equipped with separate
> > clock sources (at least to feed the MCI or APB3 interface) and may
> > have dedicated IRQ line to signal various events like link
> > establishing, failures, etc. From that perspective XPCS in both cases
> > looks as a normal platform device for which would be better to have a
> > special DT-node defined with all those resources supplied. Then the
> > XPCS DT-node could be passed to the DW MAC DT-node via the already
> > standardized "pcs-handle" DT-property.
> 

> To my understanding, this should work, there's another PCS that works
> this way : 
> https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/net/pcs/pcs-rzn1-miic.c

It is similar to that, but since DW XPCS can reside on the normal MDIO
bus and in the system memory I took a liberty to implement the DW XPCS
MCI/APB3 interface support in the framework of the MDIO subsystem,
especially seeing Synopsys call them just "Management Interfaces", the
MMD CSRs can be indirectly accessible and since potentially there can
be more than one XPCS device on the same MCI/APB3 bus.

> 
> Are you still able to use the mdio-regmap glue that Andrew mentioned,
> to avoid the duplication between the mdio and mmio register accesses ?

Andrew cited the glue code using the Lynx PCS driver. In my case it's
DW XPCS driver. In anycase my patchset is designed in a way so not to
break (hopefully) the current DW XPCS driver users (STMMAC Eth for
sure, WangSun XGBE, SJA1105 DSA). So it will be still possible to create a
dedicated MDIO bus (using mdio-regmap API too) with the XPCS device
being detectable on it.

-Serge(y)

> 
> Maxime
