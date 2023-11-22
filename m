Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0B87F4F18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbjKVSPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbjKVSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:15:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BAA4;
        Wed, 22 Nov 2023 10:15:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d9effe314so5025482f8f.3;
        Wed, 22 Nov 2023 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700676910; x=1701281710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NVSrNzLgRvQ4gfVAo/d/ONIYYWbL33zy5cmCQPLiW2M=;
        b=GBDRAYtSFhR+bsEVzlsLt7J4swhqOU/ikIMR/FRLbm3J+j8aqrlBdQyEn6yr/tb+eb
         PRxcHEv4/9eSt/xHSxPmBlBlmF7sFfdQtTm24q5DRf/zXM8b5OBnvc+lCu3LlNJ0WpiP
         dRa+1MUjobKPqm0FnTcIqjGUfFi6r5j96LAy7Ar0PcFeUK6Zqbr+8pTAyITSqoK/BJOb
         4hx+6wyXE+fhbyPi4lFogGPu/Y1lncj+OqmCaRnWRX4JusaNwJeM+ey0+cL7CI7PJRUF
         re/jsDR5x/AYFvAdVaChlmjnZTdQPqV9RMuFuWwDCOAv/uVAu91jS3TLIN8BRmjNDHqm
         YkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676910; x=1701281710;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVSrNzLgRvQ4gfVAo/d/ONIYYWbL33zy5cmCQPLiW2M=;
        b=AeCnw8BOHzll8Pg8O0mmyKL5JalGbOW4Z+0SMWdBtU4dS8SX9Zo5jxa1Q9mwb0Fcex
         Fo3wSE8CQK8ca7zfDrQAtOVBvABo5cY298DRwxnbXYoopCd0quVwIo7RBnjVjTQLrwJH
         32W1Gadx1OkybgCg9hjwW4+tLKUbV/2dJCp8Vmi4ZgnEDqSFL99xMjacujB9oJxYU7mK
         kdlCoJmCsyFmO1yzJhVHaBKDMzb4kUxW/aIlPvugpVIbXt+S2lQikFOuDjXogn8UvVcg
         j6wrFsbLiLQOdwZ/D3VHGwCJO78+epv+HF++keFO6ZVm3HfSOZ633CRc/4CwUBvmNvj9
         J09Q==
X-Gm-Message-State: AOJu0Ywq14Co4C2+b9AmHHAExc6oU0Bu/UUXvX4dHn3qaR693HfIsAbD
        6oB5e8fT7CG0f0R/5lMRs5E=
X-Google-Smtp-Source: AGHT+IE6ao4vkwq952ctFLHc3qQmln2Fu/+DhwMBUg5bDQNU//QHvdiFV9OG3a65EXYc10npzM6zbA==
X-Received: by 2002:adf:e550:0:b0:331:3b59:3edb with SMTP id z16-20020adfe550000000b003313b593edbmr2507151wrm.42.1700676910297;
        Wed, 22 Nov 2023 10:15:10 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d5147000000b003316debbde4sm24378wrt.48.2023.11.22.10.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:15:09 -0800 (PST)
Message-ID: <655e452d.5d0a0220.61c31.01ae@mx.google.com>
X-Google-Original-Message-ID: <ZV5FKswuT+PAXpWB@Ansuel-xps.>
Date:   Wed, 22 Nov 2023 19:15:06 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Simon Horman <horms@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 04/14] net: phy: add initial support for PHY
 package in DT
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-5-ansuelsmth@gmail.com>
 <20231122105243.GB28959@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122105243.GB28959@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:52:43AM +0000, Simon Horman wrote:
> On Mon, Nov 20, 2023 at 02:50:31PM +0100, Christian Marangi wrote:
> > Add initial support for PHY package in DT.
> > 
> > Make it easier to define PHY package and describe the global PHY
> > directly in DT by refereincing them by phandles instead of custom
> > functions in each PHY driver.
> > 
> > Each PHY in a package needs to be defined in a dedicated node in the
> > mdio node. This dedicated node needs to have the compatible set to
> > "ethernet-phy-package" and define "global-phys" and "#global-phy-cells"
> > respectively to a list of phandle to the global phy to define for the
> > PHY package and 0 for cells as the phandle won't take any args.
> > 
> > With this defined, the generic PHY probe will join each PHY in this
> > dedicated node to the package.
> > 
> > PHY driver MUST set the required global PHY count in
> > .phy_package_global_phy_num to correctly verify that DT define the
> > correct number of phandle to the required global PHY.
> > 
> > mdio_bus.c and of_mdio.c is updated to now support and parse also
> > PHY package subnote that have the compatible "phy-package".
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Hi Christian,
> 
> I was a little hasty in hitting send on my previous message.
> Please find some more minor feedback from my side below.
>

Thanks a lot for the initial review and sorry for the various warning
you had to write about it. I know this was a new concept and that I had
to discuss a lot about the DT structure so I was a bit relaxed in
releasing OF node. Will handle all of them in v2. Again thanks! 

> ...
> 
> > diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
> > index 64ebcb6d235c..bb910651118f 100644
> > --- a/drivers/net/mdio/of_mdio.c
> > +++ b/drivers/net/mdio/of_mdio.c
> > @@ -139,6 +139,44 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
> >  }
> >  EXPORT_SYMBOL(of_mdiobus_child_is_phy);
> >  
> > +static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
> > +				   bool *scanphys)
> > +{
> > +	struct device_node *child;
> > +	int addr, rc;
> > +
> > +	/* Loop over the child nodes and register a phy_device for each phy */
> > +	for_each_available_child_of_node(np, child) {
> > +		if (of_device_is_compatible(child, "ethernet-phy-package")) {
> > +			rc = __of_mdiobus_parse_phys(mdio, child, scanphys);
> > +			if (rc && rc != -ENODEV)
> > +				return rc;
> 
> for_each_available_child_of_node() makes calls to of_node_get() and
> of_node_put(), so when jumping out of a loop it is necessary to call
> of_node_put(), in this case of_node_put(child).
> 
> As flagged by Coccinelle.
> 
> Also flagged in of_mdiobus_find_phy() both before and after this patch.
> 
> > +
> > +			continue;
> > +		}
> > +
> > +		addr = of_mdio_parse_addr(&mdio->dev, child);
> > +		if (addr < 0) {
> > +			*scanphys = true;
> > +			continue;
> > +		}
> > +
> > +		if (of_mdiobus_child_is_phy(child))
> > +			rc = of_mdiobus_register_phy(mdio, child, addr);
> > +		else
> > +			rc = of_mdiobus_register_device(mdio, child, addr);
> > +
> > +		if (rc == -ENODEV)
> > +			dev_err(&mdio->dev,
> > +				"MDIO device at address %d is missing.\n",
> > +				addr);
> > +		else if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * __of_mdiobus_register - Register mii_bus and create PHYs from the device tree
> >   * @mdio: pointer to mii_bus structure
> > @@ -180,25 +218,9 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
> >  		return rc;
> >  
> >  	/* Loop over the child nodes and register a phy_device for each phy */
> > -	for_each_available_child_of_node(np, child) {
> > -		addr = of_mdio_parse_addr(&mdio->dev, child);
> > -		if (addr < 0) {
> > -			scanphys = true;
> > -			continue;
> > -		}
> > -
> > -		if (of_mdiobus_child_is_phy(child))
> > -			rc = of_mdiobus_register_phy(mdio, child, addr);
> > -		else
> > -			rc = of_mdiobus_register_device(mdio, child, addr);
> > -
> > -		if (rc == -ENODEV)
> > -			dev_err(&mdio->dev,
> > -				"MDIO device at address %d is missing.\n",
> > -				addr);
> > -		else if (rc)
> > -			goto unregister;
> > -	}
> > +	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys);
> > +	if (rc)
> > +		goto unregister;
> 
> Jumping to unregister will call of_node_put(child),
> however child appears to be uninitialised here.
> 
> Flagged by clang-16 W=1 build, and Smatch.
> 
> >  
> >  	if (!scanphys)
> >  		return 0;
> 
> ...

-- 
	Ansuel
