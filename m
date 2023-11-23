Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE07F60C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbjKWNuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbjKWNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:50:20 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE634BA;
        Thu, 23 Nov 2023 05:50:26 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cd2f1a198cso7138267b3.0;
        Thu, 23 Nov 2023 05:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747426; x=1701352226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6HDmUWHoV/d+5kwt+BMpRMCcQ4EU+NPmBrVnqKEpBkk=;
        b=fCsbMueaAqe4vmewoSW6onWlFPkdA2U7h8HtTHIvasxQCHpbOH41yE81KU0z+UTwfT
         Q6v6Ixzn3SnDphaewcWX/b5CVS7iRGkd4+PgbrYMFTBp4I1i2TLcIghXOQobf4igitVD
         VsjKcv3Ez9P3JuWLtAJiPNLOd5uuKBFFKjPNt3h0QEsCZqkDuhqdrAeexZT7iUKtVxuC
         bJxWmaiuddbgNd8Mmc/r8j/ujlPyDLwj56ItH5UOQmklq4wcaDDlUV4FiTN+p1cYLcVw
         ylw68GL8/87oG0ke43GUgNufcMHWrue4CFFbJ9Fe4pYALzNtw9DA42Cfb/6VI9CSsi7i
         g3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747426; x=1701352226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HDmUWHoV/d+5kwt+BMpRMCcQ4EU+NPmBrVnqKEpBkk=;
        b=Ly75E3m+s6TILhOAXuM8xDQflO2gP111O635uanFSq/gn92Ge3KSyrCqoH4JZ63p9e
         6C92VpD6WL/+R+PTQKIfiT6bPpvbQ+qhVjS4mgGW8wa709RMu6UE2W+xi/RWpj1qKD+r
         oM+viHAxovI7+5neqCCo1qRWZF8cECJYuwY+6PlHpCXM59/kT0AhkhhhRIdopVqIMBcC
         OfaPonhaa9VChjd+7vGntIpVLh1w+/OofOJFhyjaV/jDkw+EMqa9AhVseTxR+S9kgMLF
         RU2jzrELfjqLo+VKF+zGEafYghsk5F+DQWKCiSvUDk0QWT8LUxV5YpgOZNhIvqpsDumT
         iryQ==
X-Gm-Message-State: AOJu0Yyk9sfRcDKhWwFPBh6y0KJ9GklvwFD+X9mzGYsg2bu5RcikNWJQ
        rvOO8fWPu3Ab2tF0vREBXp1G/Z9D0RbqK4ijqTc=
X-Google-Smtp-Source: AGHT+IGZwjwRkgSJ7EnlxLUgRSgKWDT8jC/rPzRQg0Kq3WiN+CVcYva0UFJf/nOdcGZASDUiq8QSYhmkdlzne0lzNs4=
X-Received: by 2002:a25:3409:0:b0:da0:3535:41f4 with SMTP id
 b9-20020a253409000000b00da0353541f4mr5712007yba.7.1700747426043; Thu, 23 Nov
 2023 05:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20231121151733.2015384-1-tmaimon77@gmail.com> <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch> <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
 <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch>
In-Reply-To: <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 23 Nov 2023 15:50:14 +0200
Message-ID: <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, 22 Nov 2023 at 20:45, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Nov 22, 2023 at 07:50:57PM +0200, Tomer Maimon wrote:
> > Hi Andrew,
> >
> > Thanks for your comments
> >
> > On Tue, 21 Nov 2023 at 18:42, Andrew Lunn <andrew@lunn.ch> wrote:
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
> > > > +
> > > > +     val &= ~(PCS_AN_ENABLE);
> > > > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > > > +}
> > >
> > > Is this a licensed PCS implementation? Or home grown? If its been
> > > licensed from somebody, it maybe should live in driver/net/pcs, so
> > > others can reuse it when they license the same core.
>
> > we are using DWC PCS, I don't see support for DWC PCS and I am not
> > sure it is supposed to be supported at /drivers/net/pcs
>
> I've not followed the naming used by Synopsys. Is DWC PCS the same as
> XPCS? Does Synopsys have multiple PCS implementations?
>
> > I do see a patch set to support DWC PCS but I don't think it answers my needs
> > https://patchwork.ozlabs.org/project/netdev/patch/1559674736-2190-3-git-send-email-weifeng.voon@intel.com/
>
> I _think_ this patch eventually got turned into
> driver/net/pcs/pcs-xpcs.c
>
> What exactly does it not do for you?
Thanks for pointing me to Synopsys (DWC) PCS in pcs-xpcs.c I need to
check if the driver follows all our SGMII needs
>
>      Andrew

Best regards,

Tomer
