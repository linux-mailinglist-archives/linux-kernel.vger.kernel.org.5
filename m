Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDD7FF7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjK3RPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjK3RP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:15:28 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6810DB;
        Thu, 30 Nov 2023 09:15:33 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d3a7aa1ed5so4999907b3.2;
        Thu, 30 Nov 2023 09:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364533; x=1701969333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rUEJMCiwK1IimuLmpZAvnaV23jPetFgYdyhHNBMmmMM=;
        b=V6954mdKabRk4fXZdPAGt22zxQ/4lve+6VFSskXMIAwu1UkWFnBXpNVzj+YYBOhbrG
         icxum+dtwQ61DBI4J2kATOZ2ulEPczpFa/S4aarGd4Q0lfaMya9/jppiKGZrOfE0g1Wc
         wb59N61l2pCYKuYf9FP1XH/eAuZExIP+hPZbAdG0OVIKRBYiDOes523CYakCPKSSS9OO
         W5Qr8a1sFKr7kIRT0yQXBxQmabJfQXV+0fJaGYxTTHM1Te9Q7j/c58H4qNIKFgVatAtk
         d7OtpVKKZPtTjbZKsTjiofK8z41Cg7U6eJuHDeCKjOGYTJjQ5srM7MHeDrXgA80k9ss0
         FCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364533; x=1701969333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUEJMCiwK1IimuLmpZAvnaV23jPetFgYdyhHNBMmmMM=;
        b=o4xPw6Hdq26pe4VznQ2RKfx8NxDfaCUTt7YTFMiDAsngmbme5tU4gvB98PRVsuaL+A
         cWGi2xxBNMo39t4sDI7n04cxwf+lbltujkvrfYKPYbldbVC/SUSBss3C/WjC6kjMn1e6
         ogF6rzFk8BtTuDaYAUkz05hFUrw5V1cU0jBQo70bx6jBJwLqLe6CtzGWYjjgTs5e3aOA
         tHVeMmZ882hek27NuXxfICFTb2q88WVuyPta45rSkK+KfLXHcWOZs4tqSSaC6ZICSlFB
         bXy5Gu/chVs/9wHpgJQeWb03PeNeenbNGnv1pPzlZPxHMH/P6B89eiySsRD7pYoY7F4P
         BO1g==
X-Gm-Message-State: AOJu0YyVZ2oLuND/ROquDAx8LM61C58tTR9LMzCOjoFpQeeeX0TlCIPh
        REmW8c/Y8EJ705JePz+mjNuBgElyuiZLnnxmeSg=
X-Google-Smtp-Source: AGHT+IErvA2RyH4g/m74oMEXpowU9Ue1ZkuQKHoyzXHdNG4/HUE13vw8TPWvMWjjM1lDHYhxc1hrEUPuGNakOFAxacU=
X-Received: by 2002:a81:ad1c:0:b0:5cb:ee2d:5f5d with SMTP id
 l28-20020a81ad1c000000b005cbee2d5f5dmr18972117ywh.39.1701364533098; Thu, 30
 Nov 2023 09:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20231121151733.2015384-1-tmaimon77@gmail.com> <20231121151733.2015384-3-tmaimon77@gmail.com>
 <ZVzQh9ykusyknGgP@shell.armlinux.org.uk> <CAP6Zq1gzAhp9BZNX1MOozUfQc82Vi_S==on5_nOfVfpvtgnN2g@mail.gmail.com>
 <ZWS8m66LrrRQpbLO@shell.armlinux.org.uk>
In-Reply-To: <ZWS8m66LrrRQpbLO@shell.armlinux.org.uk>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 30 Nov 2023 19:15:21 +0200
Message-ID: <CAP6Zq1gLmOmtQ6081CubDsG4_CNvjBSMGdA2TTE4o+QJX8c=ZA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     davem@davemloft.net, edumazet@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alexandre.torgue@foss.st.com,
        peppe.cavallaro@st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, andrew@codeconstruct.com.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Mon, 27 Nov 2023 at 17:58, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Nov 22, 2023 at 07:23:28PM +0200, Tomer Maimon wrote:
> > Hi Russell,
> >
> > Thanks for your comments.
> >
> > On Tue, 21 Nov 2023 at 17:45, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Nov 21, 2023 at 05:17:33PM +0200, Tomer Maimon wrote:
> > > > Add Nuvoton NPCM BMC SoCs support to STMMAC dwmac driver.
> > > >
> > > > And modify MAINTAINERS to add a new F: entry for this driver.
> > > >
> > > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > >
> > > A few comments on this...
> > >
> > > > +#define IND_AC_BA_REG                0x1FE
> > > > +#define SR_MII_CTRL          0x3E0000
> > > > +
> > > > +#define PCS_SR_MII_CTRL_REG  0x0
> > > > +#define PCS_SPEED_SELECT6    BIT(6)
> > > > +#define PCS_AN_ENABLE                BIT(12)
> > > > +#define PCS_SPEED_SELECT13   BIT(13)
> > > > +#define PCS_RST                      BIT(15)
> > >
> > > include/uapi/linux/mii.h:
> > >
> > > #define BMCR_SPEED1000          0x0040  /* MSB of Speed (1000)         */
> > > #define BMCR_ANENABLE           0x1000  /* Enable auto negotiation     */
> > > #define BMCR_SPEED100           0x2000  /* Select 100Mbps              */
> > > #define BMCR_RESET              0x8000  /* Reset to default state      */
> > >
> > > Look familiar? Maybe use the standard definitions for a standardised
> > > register?
> > >
> > > > +void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
> > > > +                      struct plat_stmmacenet_data *plat_dat)
> > > > +{
> > > > +     u16 val;
> > > > +
> > > > +     iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
> > > > +     val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > > +     val |= PCS_RST;
> > > > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > > +
> > > > +     while (val & PCS_RST)
> > > > +             val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > >
> > > What if the PCS never clears its reset bit? Maybe use
> > > read_poll_timeout() ?
> > >
> > > > +
> > > > +     val &= ~(PCS_AN_ENABLE);
> > > > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > > +}
> > >
> > > Also, maybe it's time to require new stmmac platform support to start
> > > making use of the phylink PCS support rather than continuing to code its
> > > own?
> > >
> > > I notice, however, that you always disable inband signalling - please
> > > explain why. Also, what protocol does the PCS use when communicating
> > > with the PHY?
> > With disable inband signalling you mean disable auto negotiation?
>
> Over a SGMII, 1000base-X, USXGMII etc link, there is an inband
> signalling method. Whether it is "auto negotiation" depends on your
> point of view.
>
> With 1000base-X, it is "auto negotiation" because the two link partners
> advertise their abilities, and resolve the operational link parameters.
> In essence, there is a negotiation between both ends.
>
> In the case of e.g. Cisco SGMII, "auto negotiation" is a total misnomer.
> There is no "negotiation". The SGMII PHY side re-purposes the 1000base-X
> inband 16-bit control word to inform the MAC about the negotiated
> speed and duplex settings, and the MAC can only say "yes thank you for
> that" back to the PHY. There is no "and this is what I'm doing" to it.
> So there's no "negotiation" in SGMII.
>
> So, I prefer using "inband signalling" because that more accurately
> describes both of these situations, whereas "auto negotiation" does
> not.
>
> Note also that whenever I see "SGMII", that means Cisco's SGMII,
> which is 1000base-X modified by Cisco, and doesn't include the IEEE
> 802.3 1000base-X.
>
> > if
> > yes it is because the PCS sgmii is connected to the external phy AN
> > and is not working between the PCS and external phy.
>
> What if the external PHY wants to use Cisco SGMII inband signalling?
This is not working with the external PHY we using (BCM54210S) and
this is why we disable the inband signalling in the PCS.
> > accessing the PCS registers is indirect. The top 13 bits (bits 21-9)
> > of the offset have to be written to Indirect Access Base register
> > bits 12:0 before indirectly accessing the target register with the
> > offset of the bottom 9 bits (8:0) of the offset
>
> I'm not sure how this connects with my email. I asked what protocol
> is used between the PCS and PHY, and I _think_ you've said that it's
> Cisco SGMII.
>
> Please give details of which PHY is being used - I'd like to know
> more about why the inband signalling isn't being used.
We are using BRCM PHY, BCM54210S.
>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks,

Tomer
