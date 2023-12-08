Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6880A693
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574148AbjLHPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574128AbjLHPHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:07:06 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D31198C;
        Fri,  8 Dec 2023 07:07:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bdec453c8so2561342e87.3;
        Fri, 08 Dec 2023 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702048030; x=1702652830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WF5RVyq6ckUd8DU+aeAoDbJFrmMEuJFqK2TUAQspTEA=;
        b=l6CAQDH/uRwT8Yd85sQoev8PkVDXy/XSiT+Lf2vyt/JqBpJVMvP2n59Mt78UYT+RBy
         puZP20s4QkD4s/g/FPNfe5NwqJ2RN85w8SSJDfQDY1oWrmFuUSJUnzsjTpU3bD5eOgbl
         Uj73QYWYojl9Y0xEV3MSEaZB6oxdRppVR7PrTZlOszUspUsfenHEGVZoqFKpMyED13Jg
         Fbzw6hALPHr7Xcdc3wQtYE7K/IZfqBVFjCrh1FJmnSTQIHBnibLRCzR2CcN7dyLv/G20
         fReovEr5yoGs9DwDvX9WuExVA7Qt7RZlFwJe1NdL25XKSqL130RzVxahJ6riOYXkbRGl
         wGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048030; x=1702652830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF5RVyq6ckUd8DU+aeAoDbJFrmMEuJFqK2TUAQspTEA=;
        b=glUjlWVMiqQEI4HsdmMCHGpUuuvP/QhaqlrfIqAY0W0dzzYwnq+MPdZ/f702sWZ6hI
         3yenKTcD5Bt8odbSINSOZmclYCVvJbCIcDVrB+toM2BYap2MElmfFUT6azG84Yo6MjTZ
         NCvp+3HW/s/k9jSWqFvII4V4TDlrK1Osc66fZjqmi5BbmouHpRH6sGBBJDHnmLfq7+2U
         l9YCo+vfuY6AtVqz1FDJ32wB+7sJ2/5+RyaDRMBthx1EqhAdD01F3hbHixseZ7uQpAKm
         eBvO48HY00AaWBRyRYcDpqwiFGNgci3RUZPS6RnJXhhJYzupMkmdLBGIEKFaWCWXO2dv
         f6EA==
X-Gm-Message-State: AOJu0YwaeJbTpQTKFInNsiiVcxZLk64zojfpNzeuNNERhtfSDRhG8SM9
        RE1Z5/oslaoQybOMfRRHst4=
X-Google-Smtp-Source: AGHT+IFn0DWLpA9c912lqdnIDk2jEvmPjcyf++uanjHB3XBJDgftEUxNxH3LEfqMKNi2fs+m3cHW3A==
X-Received: by 2002:ac2:5d31:0:b0:50b:f547:82ba with SMTP id i17-20020ac25d31000000b0050bf54782bamr17911lfb.130.1702048029635;
        Fri, 08 Dec 2023 07:07:09 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f45000000b0050bf06c8098sm241291lfz.116.2023.12.08.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:07:09 -0800 (PST)
Date:   Fri, 8 Dec 2023 18:07:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <hgz3pt625kggix6kzincohw7kr2okcumrwfkmjgiauw2yvhrzt@ekeygo4b7k3b>
References: <20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com>
 <jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta>
 <hxds75erxqcfkufxnfbyo2up4b4jeicmi3f5xr6qlb3yf7fe76@4byeq62jhu4o>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hxds75erxqcfkufxnfbyo2up4b4jeicmi3f5xr6qlb3yf7fe76@4byeq62jhu4o>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 05:07:24PM -0600, Andrew Halaney wrote:
> On Fri, Dec 08, 2023 at 01:16:12AM +0300, Serge Semin wrote:
> > On Thu, Dec 07, 2023 at 03:12:40PM -0600, Andrew Halaney wrote:
> > > The stmmac_dt_phy() function, which parses the devicetree node of the
> > > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > > fixed-link means in relation to the MAC's MDIO bus. This results in
> > > a MDIO bus being created in situations it need not be.
> > > 
> > > Currently a MDIO bus is created if the description is either:
> > > 
> > >     1. Not fixed-link
> > >     2. fixed-link but contains a MDIO bus as well
> > > 
> > > The "1" case above isn't always accurate. If there's a phy-handle,
> > > it could be referencing a phy on another MDIO controller's bus[1]. In
> > > this case currently the MAC will make a MDIO bus and scan it all
> > > anyways unnecessarily.
> > > 
> > > There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> > > be created and scanned for a phy. This case can also be inferred from
> > > the platform description by not having a phy-handle && not being
> > > fixed-link. This hits case "1" in the current driver's logic.
> > > 
> > > Let's improve the logic to create a MDIO bus if either:
> > > 
> > 
> > >     - Devicetree contains a MDIO bus
> > >     - !fixed-link && !phy-handle (legacy handling)
> > 
> > If what you suggest here is a free from regressions semantics change
> > (really hope it is) I will be with both my hands for it. This will
> > solve the problem we have with one of our device which doesn't have
> > SMA interface (hardware designers decided to save ~4K gates of the
> > chip area) but has a PHY externally attached to the DW XGMAC<->XPCS
> > interface. PHY is accessible via a GPIO-based MDIO bus. BTW having no
> > SMA interface available on a DW *MAC device but creating the MDIO-bus
> > on top of the non-existent SMA CSRs anyway causes having _32_ dummy
> > PHYs created with zero IDs.
> 

> I hope it is regression free! I have tested both the [1] and [2] cases
> (I hacked up the devicetree for [1] to make it look like [2]) without
> any issue.
> 

I doubt you could have tested it on all the possible hardware the
STMMAC driver supports. The problem is that the DT-bindings thing is a
kind of contract which can't be changed that easily. It's like ABI but
for the hardware description so the kernel would bootup correctly on
the platforms with the old DT blobs. But if the change isn't that
critical, if the device-tree sources in the kernel fit to the updated
semantics, if the networking subsystem maintainers aren't against it
and I guess with the Rob, Krzysztof or Conor blessing (at least it
won't hurt to add them to the Cc-list together with the devicetree
mailing-list), then it will likely be accepted.

> Sorry, I don't have any docs for stmmac hardware so this might be
> answered in there (or just common net knowledge that I can't find
> online)... what's SMA stand for? I assume it's the MDIO interface.

Right. Synopsys names the MDIO-bus interface as Station Management
Agent MDIO module.

> 
> I agree though, if you have a phy-handle and no mdio node in your
> devicetree this patch series should bail out without registering a bus
> in stmmac_mdio_register().

On the other hand why would the MDIO-bus needed in such case? If the
phy-handle property is specified with no MDIO-bus DT-subnode, then it
will point out to a PHY residing an external bus. The only case I can
imagine though is that the DW XPCS device could be still auto-detected
on the internal SMA-MDIO-bus. But the only driver which currently has
XPCS auto-detection activated is the Intel glue layer (see
dwmac-intel.c and has_xpcs flag), but it doesn't use DT interface
since it handles a PCIe-based device.  So this case is out of
brackets.

> 
> > 
> > > 
> > > Below upstream devicetree snippets can be found that explain some of
> > > the cases above more concretely.
> 
> <snip>
> 
> > > -	if (mdio) {
> > > -		plat->mdio_bus_data =
> > > -			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
> > > -				     GFP_KERNEL);
> > 
> > > +	/* Legacy devicetrees allowed for no MDIO bus description and expect
> > > +	 * the bus to be scanned for devices. If there's no phy or fixed-link
> > > +	 * described assume this is the case since there must be something
> > > +	 * connected to the MAC.
> > > +	 */
> > > +	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
> > > +	if (legacy_mdio)
> > > +		dev_info(dev, "Deprecated MDIO bus assumption used\n");
> > > +
> > > +	if (plat->mdio_node || legacy_mdio) {
> > > +		plat->mdio_bus_data = devm_kzalloc(dev,
> > 
> > Special thanks for adding the comment above this code. It will really
> > save time of figuring out why MDIO-bus needs to be created anyway.
> > 
> > > +						   sizeof(struct stmmac_mdio_bus_data),
> > 
> > Should v4 is required I would suggest to change this to
> > sizeof(*plat->mdio_bus_data).
> > 
> > Anyway feel free to add:
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > -Serge(y)
> 

> Sure I will spin v4 to pick that up, thanks for catching it. I'll also
> improve the motivation in the commit message a hair more per Andrew
> Lunn's request over here on v2 (and will hold off a little bit just to
> make sure reviews come in before a respin):
> 
>     https://lore.kernel.org/netdev/e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch/

Ok. Thanks.

-Serge(y)

> 
> Thanks,
> Andrew
> 
