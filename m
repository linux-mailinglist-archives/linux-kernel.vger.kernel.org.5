Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2897380EE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376302AbjLLNwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbjLLNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:52:16 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022FDB3;
        Tue, 12 Dec 2023 05:52:21 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf69afa99so7297775e87.3;
        Tue, 12 Dec 2023 05:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702389140; x=1702993940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFnllcfa91c1zJc4Gntywu/a8dFRpUHFeO6CvIvFtu4=;
        b=B3SpP+4WEDCrXayc3qWvV8daTzwf2cw3SF/DlDxLD1l3+uAa+1ltZRHd1QxGPWo5CY
         7ic88L33QXDHm1+MG8lKocupTO4QytkT7ApImWXMyudMAXHzycQZ6+8y9mC7vMxdDtw+
         2d1oJfqT4SpKd8V8RaUKwKc7rVPHijhY3UcnSWpewVrC6oaiUo6R5j2OVMmmmgTjkYuM
         LY1BnsAyuJFc6aUiaaNh4it6hUgHXyITFRsFH41liG/ka0MIEbKBJITY50xlz0SiwGqD
         KUFmSj8KUktZzwZAj0SpUH1jIFdeJ5ZWxccV5xWgv2xSwezwKES9tJt/sqZDCIInidvH
         sOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389140; x=1702993940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFnllcfa91c1zJc4Gntywu/a8dFRpUHFeO6CvIvFtu4=;
        b=Em/VQl8OdPiJY42u2OYy/BKLALeF+26O4NmFTKX7bOe+aQe/fEH+E39iDk2qTJoi2s
         8DVywiHeEmWHI+RSTwWAj3uHAgojgmNFLdpsXWCfTVt419s+RSLD/Oh9UhfgelFTGTU7
         6BMWaf+JRbnhIbxWlIbqJ+IsnnbnMn21+FgmOQU8EwelLWFJ+ORJZrIwgLvPyOIRDWx/
         H6nXU7tEVtTffrT3YjLK8uAHkkf0eoxzvLUk/B7/KZjkkvNCvaB3tdDnSjQaJHKeZdva
         2yMSJmN4oAi7tcFwaqIFOEzJh4F2+DHJ08LLNZZiiReWC387ZUeXNriUvHEa/4wSLbOV
         DevQ==
X-Gm-Message-State: AOJu0YzJIYspMCF0wDH1H+lavHHpl/JkZLWp9sqqS+oV/acJl8Df3lBF
        HY/AJGb6winVyihAAEMXlu4G2o2Lw/c+cg==
X-Google-Smtp-Source: AGHT+IHQrUXSxuBn29LhUoJX1ePcDGg56snRNXblvB5VLnQAdFUNh09t5mpngpSLdnTnZAS3jpzzfw==
X-Received: by 2002:a05:6512:3b8d:b0:50c:c8b8:669a with SMTP id g13-20020a0565123b8d00b0050cc8b8669amr3958930lfv.92.1702389139829;
        Tue, 12 Dec 2023 05:52:19 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g4-20020a0565123b8400b0050bfb2a5661sm1363163lfv.103.2023.12.12.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:52:19 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:52:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <na6krkoco7pmsl62dfuj2xlrvpsnod74ptpfyy6gv7dzwmowga@mzsiknjian2i>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8ASzkC9IFFlxkV@shell.armlinux.org.uk>
 <rgp33mm4spbpm5tmgxurkhy4is3lz3z62rz64rni2pygteyrit@zwflw2ejdkn7>
 <e1806c15-757e-4af0-a8be-075aa77918c2@lunn.ch>
 <ZW840qQMbVRto442@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW840qQMbVRto442@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Russell

Sorry for the delay with response. I had to refresh my understanding
of the series since it was created sometime ago and I already managed
to forget some of its aspects (particularly regarding the MDIO-bus
PHY-mask semantics).

On Tue, Dec 05, 2023 at 02:50:58PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 05, 2023 at 02:52:24PM +0100, Andrew Lunn wrote:
> > On Tue, Dec 05, 2023 at 02:31:41PM +0300, Serge Semin wrote:
> > > On Tue, Dec 05, 2023 at 10:49:47AM +0000, Russell King (Oracle) wrote:
> > > > On Tue, Dec 05, 2023 at 01:35:27PM +0300, Serge Semin wrote:
> > > > > If the DW XPCS MDIO devices are either left unmasked for being auto-probed
> > > > > or explicitly registered in the MDIO subsystem by means of the
> > > > > mdiobus_register_board_info() method there is no point in creating the
> > > > > dummy MDIO device instance in order to get the DW XPCS handler since the
> > > > > MDIO core subsystem will create the device during the MDIO bus
> > > > > registration procedure.
> > > > 
> > > 
> > > > Please reword this overly long sentence.
> > > 
> > > Ok.
> > > 
> > > > 
> > > > If they're left unmasked, what prevents them being created as PHY
> > > > devices?
> > > 
> > > Not sure I fully get what you meant. If they are left unmasked the
> > > MDIO-device descriptor will be created by the MDIO subsystem anyway.
> > > What the point in creating another one?
> > 

> > Saying what Russell said, in a different way:
> > 
> > /*
> >  * Return true if the child node is for a phy. It must either:
> >  * o Compatible string of "ethernet-phy-idX.X"
> >  * o Compatible string of "ethernet-phy-ieee802.3-c45"
> >  * o Compatible string of "ethernet-phy-ieee802.3-c22"
> >  * o In the white list above (and issue a warning)
> >  * o No compatibility string
> >  *
> >  * A device which is not a phy is expected to have a compatible string
> >  * indicating what sort of device it is.
> >  */
> > bool of_mdiobus_child_is_phy(struct device_node *child)
> > 
> > So when walking the bus, if a node is found which fits these criteria,
> > its assumed to be a PHY. 
> > 
> > Anything on the MDIO bus which is not a PHY needs to use a compatible.
> 
> Right. I'd actually forgotten about the firmware-based walking, and
> was thinking more of the non-firmware bus scanning as the commit
> message was talking about being _unmasked_ and the only mask we have
> is bus->phy_mask.

Back then when I was working on the series and up until last week I
had thought that having a device unmasked in mii_bus->phy_mask was a
correct way to do for _any_ device including our DW XPCS (which BTW
looks like a normal C45 PHY and if synthesized with a PMA attached
could be passed to be handled by the PHY subsystem). Can't remember
why exactly I came to that thought, but likely it was due to finding
out examples of having mii_bus->phy_mask uninitialized in some of the
PCS use-cases, like in drivers/net/dsa/ocelot/felix_vsc9959.c (but in
case of DW XPCS the mask is always set indeed). Anyway obviously I was
wrong and PHY-device is supposed to be created only if a device is
actual PHY and handled by the PHY subsystem drivers. So the correct
ways to create PHY MDIO-devices are:

1. Call mdiobus_register() with PHY-addresses unmasked
2. Call of_mdiobus_register() for a DT-node with sub-nodes for which
of_mdiobus_child_is_phy() returns true.

and the correct ways to create non-PHY MDIO-devices are:

1. Call mdiobus_register() with non-PHY-addresses masked and have
those non-PHY device registered by mdiobus_register_board_info()
beforehand.
2. Call of_mdiobus_register() with DT sub-nodes having specific
compatible string (based on the of_mdiobus_child_is_phy() semantics).

Only in case of having a non-PHY device registered it's allowed to
use it in in non-PHY MDIO driver, like PCS, etc. Right?

Please correct me if I am wrong or miss something.

> 
> It seems to me that this is yet another case of a really confusing
> commit message making review harder than it needs to be.

From the perspective described above the patch log is indeed partly
wrong. Sorry about that. I shouldn't have mentioned the mask at all
but instead just listed two use-cases of creating the non-PHY
MDIO-devices. I'll fix that in v2.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
