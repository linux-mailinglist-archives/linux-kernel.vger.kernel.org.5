Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3DF75D81F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGVATS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGVATQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:19:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F222106;
        Fri, 21 Jul 2023 17:19:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99b78fda9a8so38276466b.1;
        Fri, 21 Jul 2023 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689985153; x=1690589953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTWd98NKQlQOLclRLEDjQKi8Er2TDZ8yqcwVYaUBRF4=;
        b=g8stHENCkeGch1fB3tUCKiHvRabXfdsjLeLptdr0BrbbyAdtZt4I9bXC/FavTzCJJS
         SRw1zCnJTCNWePs/lA379VCwb0XzmJ4fmB5n2k/qRQFrDUwvyNt+AZlkBs+A3k5sf//b
         VXYvt5/hUzfO7MkpDVmXYfLRTDe63Ho17/57XcvIgHkX7E/ijPrjjZuwZhJmLNPZfLXt
         hcUJIFr5pzXjKZQjbB4/xl/AASZFqEOnY+4zsG79UPpH6TDyEDZxhoIqG1ypIl1zHF6+
         pyUwBQ29NRaLt6LJjx9WdIeEgbuGPiqDUO0JMYVNcZgew/hOYwYvVhVdCBxEbxex7+pp
         cDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689985153; x=1690589953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTWd98NKQlQOLclRLEDjQKi8Er2TDZ8yqcwVYaUBRF4=;
        b=GE6IufzofPq57zLjeVQOBTfnl+Zg46mw8ozwBcQZlTqVtp+N/wMUiry0C1ifkjyelZ
         BCmgPEW/369lURDvqgqq+yxT16hDc+ED+fluyI5tOIlJIXR6S8SMpfFOw9pUK7D62XQW
         a1EGQeCdMqUPGM+1D+9kL7Tx0lDLQQShvBt3GN4tRxf3NSYgXkm4sI5DWvgbW1ENzOTK
         RwD9tfWXzuBk5PXrkZwm6KAU0ElKKsb5rhLwobAx+VEb11en6cmb53rqFQrHFplyLpDJ
         aRhn06QVYX81dNCnLM0wsfbXDUV3sHszYNXxRBclWWGXhA+TBzjvyL9hWeXQtfqBY2OP
         elsw==
X-Gm-Message-State: ABy/qLY20/bTvaTxHMwHOFVJ9Iy+rzj++ulFFq52A0wiBIsPGx5AcLcr
        XKeYwOGvrsc8Z8GgyonEp8A=
X-Google-Smtp-Source: APBJJlHi9BozvtizXPg1DpR0mzRtvmTtiRgsPjjjuMl3wYgM7YLVjIPj7YOOEA2UTXPHjMV80DNFrA==
X-Received: by 2002:a17:906:10dd:b0:99b:48b9:8e45 with SMTP id v29-20020a17090610dd00b0099b48b98e45mr2994966ejv.76.1689985153306;
        Fri, 21 Jul 2023 17:19:13 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id dk20-20020a170906f0d400b00992ab0262c9sm2817763ejb.147.2023.07.21.17.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:19:13 -0700 (PDT)
Date:   Sat, 22 Jul 2023 03:19:10 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Tristram.Ha@microchip.com
Cc:     o.rempel@pengutronix.de, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com,
        andrew@lunn.ch, linux@armlinux.org.uk, devicetree@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
        Arun.Ramadoss@microchip.com, edumazet@google.com,
        f.fainelli@gmail.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH net-next v2 6/6] net: dsa: microchip: ksz9477: make
 switch MAC address configurable
Message-ID: <20230722001910.fst7vmvi4ktob4lt@skbuf>
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
 <20230721135501.1464455-7-o.rempel@pengutronix.de>
 <BYAPR11MB3558A296C1D1830F15AC6BEFEC3FA@BYAPR11MB3558.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558A296C1D1830F15AC6BEFEC3FA@BYAPR11MB3558.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:09:57PM +0000, Tristram.Ha@microchip.com wrote:
> > The switch MAC address is used for sending pause frames and for Wake on Magic
> > Packet. So, make use of local-mac-address property in the switch node
> > root and configure it in the HW.
> >
> 
> > @@ -1211,6 +1211,14 @@ int ksz9477_setup(struct dsa_switch *ds)
> >         if (dev->wakeup_source)
> >                 ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
> > 
> > +       if (is_valid_ether_addr(dev->mac_addr)) {
> > +               int i;
> > +
> > +               for (i = 0; i < ETH_ALEN; i++)
> > +                       ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
> > +                                  dev->mac_addr[i]);
> > +       }
> > +
> 
> > +
> > +               mac = of_get_property(dev->dev->of_node, "local-mac-address",
> > +                                     NULL);
> > +               if (mac)
> > +                       memcpy(dev->mac_addr, mac, ETH_ALEN);
>  
> So the Magic Packet uses the same MAC address for all KSZ9477 switches
> if local-mac-address is not defined.  Is that practical in real operating
> environment?

"same address" which is 00:00:00:00:00:00 AFAIU.

Do you mean to ask "what do we do for systems without this device tree
property, don't we want to support Magic Packet for them too?". If so,
I agree, it is a valid concern (although we need to modify it anyway,
to add "wakeup-source", apparently).

Additionally, "local-mac-address" would be overloaded with a secondary
meaning compared to what ethernet-controller.yaml says:

      Specifies the MAC address that was assigned to the network device.

...which this is not.

Since the switch hardware doesn't have a register per user port that
could be kept in sync with the MAC address of the Linux interface, it
means that the address for WOL and for flow control will always require
a special way for the user to find out about it.

I'm thinking, would it be simpler to just program the hardware with the
MAC address of the DSA master? Every DSA master has one; we can track
changes to it; no special device tree properties are needed; it also
kinda makes sense as a MAC SA for flow control as well; DSA user ports
also inherit it if they don't have a local-mac-address of their own.
If there needs to be an override for that auto-selected MAC address, a
device tree property can be added later, in the "microchip," namespace.

But "how does the user find out what MAC address to use for WOL" still
remains a concern, when it's stuffed in the device tree. Is there going
to be a BIOS customized for the KSZ9477 which always fixes up the
local-mac-address of the switch node with what's set there?

> The DSA driver used to have an API to set the MAC address to the switch,
> but it was removed because nobody used it.
> 

Which API is that? "git log -GREG_SW_MAC_ADDR_0 drivers/net/dsa/" came
up with nothing.
