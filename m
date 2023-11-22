Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ACE7F4E42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbjKVRXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjKVRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:23:44 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A500F83;
        Wed, 22 Nov 2023 09:23:40 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso8553276.3;
        Wed, 22 Nov 2023 09:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700673820; x=1701278620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NynfojDHOku/gIHF0Vtvo3+Mk/LM+8uGwtlY48AR6MM=;
        b=dv+Hb9NFVteaY/vRglrdAUYLSLXPsyrJVgF9JnPXQvEfm2SlEIoV3Cjdb0jhSU7zbH
         EMe3pZGSj8PezsOOH/uTGeeBBu5LA3JNxQ1Y+bVhTnFqNtLE/5nmgl4RZ1iFHEI1LCoT
         5TbcbtE8KDWmSgrwbfW75JGKxHMddg142VC4L8nmIIwuuCIGZeUzzH+VjtDviNnOaVwb
         GOiWhExqu+Dkib8akRA40YXsGhxZICdhrM2MAa7TRgfT4LTrnVICd+kWZTuhqGLM6Syg
         Md3q6DM9WQepd1i9ZrcmfSNK+Ittxz8Q8vKToi4P/rH1wTSWjl8nm6UxYQdTrEau63zR
         5cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673820; x=1701278620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NynfojDHOku/gIHF0Vtvo3+Mk/LM+8uGwtlY48AR6MM=;
        b=p7UzkmWLM7ulzzCKqGFME5+zSN3n+0o9mJGfb5iSclhi6iYsPUcMwqU9BFJ9WK1GYM
         ZUWtuLm0vdP5evOD22BFy+dNDZ8NbeHLbWlBj6bNnB/DliQrpjtsFyURqf9NaBHhmP5W
         o4SqBb0sn3DeTQ2G6lyiFp5gBJxuN7NxXd/cpBzBCWDOSSCc+1sOQlCL528InELE9JDp
         D9XoDxbRReIRod/CAMzQbSJbm8UU+ph0y4y9qfngXaM09fFJ6fkoIiAA1QMuUz7G93Ua
         OnUSqtw/gC/UjbvCFRh29zxnYLlLDUzZGz7cwtBSL13VaCCcEHgUCV2eNRZwGXZMv35+
         T+8Q==
X-Gm-Message-State: AOJu0YwPUEQX+p7d8atOv6DSXMzAR2DikttHylEs0bz7SmSEBzeb1XVj
        8xf+kIwh4Mpp9s7LYTlAet/SEWWrnoY9s+cfUTw=
X-Google-Smtp-Source: AGHT+IHOpI5xPVk6Sar76TK2xFochhgo10/ziA9WnAM3iYe0K/JG8b7nGUI7tLK1eOpbXeUs9Wl63rjUYOi5f2szQMQ=
X-Received: by 2002:a5b:1cb:0:b0:d91:fdb:afd4 with SMTP id f11-20020a5b01cb000000b00d910fdbafd4mr2751108ybp.16.1700673819823;
 Wed, 22 Nov 2023 09:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20231121151733.2015384-1-tmaimon77@gmail.com> <20231121151733.2015384-3-tmaimon77@gmail.com>
 <ZVzQh9ykusyknGgP@shell.armlinux.org.uk>
In-Reply-To: <ZVzQh9ykusyknGgP@shell.armlinux.org.uk>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 22 Nov 2023 19:23:28 +0200
Message-ID: <CAP6Zq1gzAhp9BZNX1MOozUfQc82Vi_S==on5_nOfVfpvtgnN2g@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Thanks for your comments.

On Tue, 21 Nov 2023 at 17:45, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Nov 21, 2023 at 05:17:33PM +0200, Tomer Maimon wrote:
> > Add Nuvoton NPCM BMC SoCs support to STMMAC dwmac driver.
> >
> > And modify MAINTAINERS to add a new F: entry for this driver.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> A few comments on this...
>
> > +#define IND_AC_BA_REG                0x1FE
> > +#define SR_MII_CTRL          0x3E0000
> > +
> > +#define PCS_SR_MII_CTRL_REG  0x0
> > +#define PCS_SPEED_SELECT6    BIT(6)
> > +#define PCS_AN_ENABLE                BIT(12)
> > +#define PCS_SPEED_SELECT13   BIT(13)
> > +#define PCS_RST                      BIT(15)
>
> include/uapi/linux/mii.h:
>
> #define BMCR_SPEED1000          0x0040  /* MSB of Speed (1000)         */
> #define BMCR_ANENABLE           0x1000  /* Enable auto negotiation     */
> #define BMCR_SPEED100           0x2000  /* Select 100Mbps              */
> #define BMCR_RESET              0x8000  /* Reset to default state      */
>
> Look familiar? Maybe use the standard definitions for a standardised
> register?
>
> > +void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
> > +                      struct plat_stmmacenet_data *plat_dat)
> > +{
> > +     u16 val;
> > +
> > +     iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
> > +     val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > +     val |= PCS_RST;
> > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > +
> > +     while (val & PCS_RST)
> > +             val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
>
> What if the PCS never clears its reset bit? Maybe use
> read_poll_timeout() ?
>
> > +
> > +     val &= ~(PCS_AN_ENABLE);
> > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > +}
>
> Also, maybe it's time to require new stmmac platform support to start
> making use of the phylink PCS support rather than continuing to code its
> own?
>
> I notice, however, that you always disable inband signalling - please
> explain why. Also, what protocol does the PCS use when communicating
> with the PHY?
With disable inband signalling you mean disable auto negotiation? if
yes it is because the PCS sgmii is connected to the external phy AN
and is not working between the PCS and external phy.
accessing the PCS registers is indirect. The top 13 bits (bits 21-9)
of the offset have to be written to Indirect Access Base register
bits 12:0 before indirectly accessing the target register with the
offset of the bottom 9 bits (8:0) of the offset
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks,

Tomer
