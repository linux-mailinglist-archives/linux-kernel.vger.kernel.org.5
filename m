Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A387FA441
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjK0PTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjK0PTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:19:21 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DCCAA;
        Mon, 27 Nov 2023 07:19:27 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db4050e68f3so4007067276.0;
        Mon, 27 Nov 2023 07:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701098367; x=1701703167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIKMvlIRYtS1WvbUoM+vWJ1z9I2GYsx2bfxFTfmC+TQ=;
        b=B6PrzDkNSGflIGyKxT6lJSOQZtl1VH+4eiypVM5zl6cxjK23Wu2q3XJoL02SsBwr8T
         tG5rUCL+N435lbKfNLuwQzM9kkp22+OqmqSoS/RQLuESSO9QDwyHCsdyYja060omGwzY
         IV0DGMss6fZt2LCYzx+7kzq6Pnmw5UGgUgUoyWDl5YCO30EVZOEp69vFTHGKzLBAqFpd
         a2cWE9Az84mPzYdX0BZAGPpVFenUGhI4pyE6TFE5AHHb9RktbvLxCWPrslOos9qox1oq
         EY5v4iCAuV8blJQC2bx+/rYlLI3G9MKDhP48+TtHa/UyX/n2e54ArFdB2RQQDiTh2eJa
         c2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098367; x=1701703167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIKMvlIRYtS1WvbUoM+vWJ1z9I2GYsx2bfxFTfmC+TQ=;
        b=PKNIZUTCGlVrHyGL9wh0SpeZx9laWJA/LwnOcNNTbiOKAW+BRLnihbKVgcx+892VIx
         yvOSQE0FUZ6l3c56lWhOdnOQwL0xxHyfn1JLQlbWHq1hF7TBi9doiMXogMTruhxyD8GQ
         AklyggB8qKLHe7aGGXcgDr0apdTkO5ZfAkYZwlrtBwqzrKeGUdgJIkdmWsYn/PhdrFsC
         fEdliWz/GivdlqrQyKU4v+8Ctwv4F0qLPP9I+VflecCd0i3/q5SE3p6gefp1rMMfhHI1
         p77jODzFwYV/h+tYieRSqS6RnOfDBW9bG09X5Zsp2wgDNXKt0knZK4B4E3M9qWUJpRKC
         y2BQ==
X-Gm-Message-State: AOJu0YyjwNgrsfuhjhNul3djBBh96C/XCqQ6ohod5LEm26UZ6XyCkE1n
        BUJpvoRF+5jjxxjVBNfuOIF5cBmRmaVeA8TszEI=
X-Google-Smtp-Source: AGHT+IE/rFqsV0KKN1gYLmgiErQUf25fY8S0FvfOygtZwLf5Ah7JOJcfJbDXf3oSBTUYCLBu/J8CZ1DTNOo/phyIfOI=
X-Received: by 2002:a25:4b02:0:b0:db0:23d8:780 with SMTP id
 y2-20020a254b02000000b00db023d80780mr9466434yba.60.1701098366826; Mon, 27 Nov
 2023 07:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20231121151733.2015384-1-tmaimon77@gmail.com> <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch> <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
 <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch> <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
In-Reply-To: <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 27 Nov 2023 17:19:15 +0200
Message-ID: <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.torgue@foss.st.com, tali.perry1@gmail.com,
        edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, joabreu@synopsys.com, joel@jms.id.au,
        devicetree@vger.kernel.org, j.neuschaefer@gmx.net,
        robh+dt@kernel.org, peppe.cavallaro@st.com,
        linux-arm-kernel@lists.infradead.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I took a look at the xpcs driver and the stmmac driver and it doesn't
cover NPCM use.

in the NPCM case the stmmac ID=0x37 therefore the driver is linked to DWMAC1000
https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/hwif.c#L139

to enable the xpcs, the stmmac should support xgmac or gmac4 and in
the NPCM is support only gmac.
https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c#L555
https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c#L573

and the most important thing is that the XPCS is handled through an
indirect register access and not through MDIO. the MDIO is connected
to the external PHY and not to the XPCS.

In that case, I think the best way to handle the XPCS is through the
NPCM glue layer, what do you think?

Thanks,

Tomer

On Thu, 23 Nov 2023 at 15:50, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Andrew,
>
> On Wed, 22 Nov 2023 at 20:45, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Wed, Nov 22, 2023 at 07:50:57PM +0200, Tomer Maimon wrote:
> > > Hi Andrew,
> > >
> > > Thanks for your comments
> > >
> > > On Tue, 21 Nov 2023 at 18:42, Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > > +void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
> > > > > +                      struct plat_stmmacenet_data *plat_dat)
> > > > > +{
> > > > > +     u16 val;
> > > > > +
> > > > > +     iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
> > > > > +     val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > > > +     val |= PCS_RST;
> > > > > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > > > +
> > > > > +     while (val & PCS_RST)
> > > > > +             val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > > > +
> > > > > +     val &= ~(PCS_AN_ENABLE);
> > > > > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > > > +}
> > > >
> > > > Is this a licensed PCS implementation? Or home grown? If its been
> > > > licensed from somebody, it maybe should live in driver/net/pcs, so
> > > > others can reuse it when they license the same core.
> >
> > > we are using DWC PCS, I don't see support for DWC PCS and I am not
> > > sure it is supposed to be supported at /drivers/net/pcs
> >
> > I've not followed the naming used by Synopsys. Is DWC PCS the same as
> > XPCS? Does Synopsys have multiple PCS implementations?
> >
> > > I do see a patch set to support DWC PCS but I don't think it answers my needs
> > > https://patchwork.ozlabs.org/project/netdev/patch/1559674736-2190-3-git-send-email-weifeng.voon@intel.com/
> >
> > I _think_ this patch eventually got turned into
> > driver/net/pcs/pcs-xpcs.c
> >
> > What exactly does it not do for you?
> Thanks for pointing me to Synopsys (DWC) PCS in pcs-xpcs.c I need to
> check if the driver follows all our SGMII needs
> >
> >      Andrew
>
> Best regards,
>
> Tomer
