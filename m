Return-Path: <linux-kernel+bounces-48577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE78845E59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A163AB2BB12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62B21649BB;
	Thu,  1 Feb 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddc1zRwV"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE601649A1;
	Thu,  1 Feb 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808018; cv=none; b=R9rzeVvflmfI+9chjOJKU2/S/cvSeRjfbRIwA4YCe7FUxpDPR33j+8C2f/YEX+fknia0AMWM6aVlPoX/ykUNW3q1wQPMBrb/6JnvfkI9/NdhDpB1QL7ezHzAQe4mz0egPRkuF5hrWIMQClkZApj1eNa5QXo7Fygv16OysJ4vzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808018; c=relaxed/simple;
	bh=LH/WmLmxZ5NddiycIskFKogm1M0vOHxW+Kgj+afN768=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVsDEYrxSoHcqXIO+u+WZR8UOJnaYsWGTboO34UCjdDR+IJfExvtIuJyHaQP75TE3+b0OUJil2F1oT/jKiaaY92Re3ga3jnw+VHExcAd9+8QzkF3cjhq54j9jXY5c0hqVDB+QUuACcOfN5Pzt1jYC/Hi/1SF0ZMMZ8yECoRAStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddc1zRwV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b17fd046fso476322f8f.1;
        Thu, 01 Feb 2024 09:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706808014; x=1707412814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0AZcHUGcaVEghSUh9pVwwvnRjfi5Kbw3FRUGFJNp33k=;
        b=Ddc1zRwVkPrFKw7piHv22PMo9/bCXLZtMQiJnsERU5NFE6M/DOiMugbbAjc5VenWUQ
         fSBS8uWmZDKfx+cNSfOAeVOsqFJaoCF4x7m0G8vLc1K9N6DPI1qOd6qx2yIXtYZ9mASW
         wwn6AnkIu2nWohjPs+yam9a3MKjcOakT/i9vyqaGuEUbXr5us9t3wIDGk6GfIHwdlp7Q
         vexxqohOFlL6Oj2NBAVSxJzg6WmFrsQT+HMGZyX0W0g3NvWxzUVbgiweaO9pCspShNAy
         /ppXxvg96S7ZgLsRVFK3P2ip4aHoC6CwSWPNuJY6PG4Aea4Gp5NeBhm+JfJnB43l0qFD
         T2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808014; x=1707412814;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AZcHUGcaVEghSUh9pVwwvnRjfi5Kbw3FRUGFJNp33k=;
        b=aNPnGGXvOiJB9Ft50Bz+OizQhGmjxojHhJOYranZD9VctdFQuLIRmXfOHJMY64E7sW
         /aq96OQid6qpUqbSMsdwL4hLU78KTEMrY5muXrJHAR0msMQlD2xmgBaUoxw7V6o6V4qu
         xYRInWscgBfqw8NLv7ExSqz/PeYJLlzUWI2yY2yReZEAWnuDhgJy8WWI0M/k/vejGWYC
         SiOzipPXnikdP9fpp1WsTGGNQ3v8sOiuzkcDd/6XUTPANro+Lg3Z2kabGbiqPnTHkmA8
         kpqPq2C210Cn1MX1otQMJTRzCN4Ve8rwWfxamxPmplvzOO6azwxxuQbUYzMT1pz/2iOn
         8Yng==
X-Gm-Message-State: AOJu0YxebYH/Td5bWt4Qoz9YEpjUZWlbP+prUbqvNPpC8fGs27xm/exW
	nuS+YIbx20cHgW+1/4iRAZUHIiHndQMbCEX+bizK36lpTO8qwStn
X-Google-Smtp-Source: AGHT+IFN1KFpDh1vr3wtQw4Rq4JRxS6JjigiP3HSep4uIBf6R15MxBW8NBhFRaWoh+4CexLAnmTucA==
X-Received: by 2002:a5d:58ee:0:b0:33b:1d07:e5d with SMTP id f14-20020a5d58ee000000b0033b1d070e5dmr67618wrd.13.1706808014309;
        Thu, 01 Feb 2024 09:20:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXiMptxujpw0Uavr69kijioTH/QpH4oeYK5ZXjekdKcnmWbK224KFYbhKIOukjBf2usPaSBCPAXm7B34kxcBsO3gJdqgHF1RBs+mcvhrZNItaP7n9zf4KzdtiNjZ+CN4IQ/Q0O3jfPxHn8pF7748J6n4uHzLpHg9mAMN73EyNUwEAFiHB2mS5FYfW/BhxywyCEhB648dcAZmyvgeW2gzLB2iiXHkHm9HgppgHuYn7S+ZSTargk9uSr/AsZQzqyR164bla+fXOsH1QVI9aMdEeymDDCsEl+qztlYabRJLUoQRJB+fGyQfw2/f1RjuGMpUAwfgU2+3dKK9LYEF8VURqTGQSkF6czZei5W5N/zDX7ibwg2y7QvP0qCIYu5/SneZqnqUVdzpfSGSy5YF9Bc4zkojdAIUYxRrMp1YbwBtnCmsmu9SrQi2etiZaNT6LSHm78CiMTc5RX2gl9A8HKeQvYvCtTR7AHKbz/aGo9wjMdp9GBP4I+sQcZPo1wm7sXTAzwh+Sp2E3NiTzXdJ6jrVO7c2iGbPHtZu5CXB1CWvv9tJk/nxSrGZpDwNOIlbv9/xJVwA7yEfMOkAPdHcYVeRY1aV+jQ7aaABg==
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id bu16-20020a056000079000b0033b0797cc14sm4263915wrb.51.2024.02.01.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:20:14 -0800 (PST)
Message-ID: <65bbd2ce.050a0220.5ff09.69d5@mx.google.com>
X-Google-Original-Message-ID: <ZbvSyo_-1iTc4pD1@Ansuel-xps.>
Date: Thu, 1 Feb 2024 18:20:10 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Antoine Tenart <atenart@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 2/9] net: phy: add support for scanning PHY
 in PHY packages nodes
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-3-ansuelsmth@gmail.com>
 <170680473689.4979.1991415008659281513@kwain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170680473689.4979.1991415008659281513@kwain>

On Thu, Feb 01, 2024 at 05:25:36PM +0100, Antoine Tenart wrote:
> Quoting Christian Marangi (2024-02-01 16:17:28)
> > 
> > +static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
> > +                                  int base_addr, bool *scanphys)
> > +{
> > +       struct device_node *child;
> > +       int addr, rc = 0;
> > +
> > +       /* Loop over the child nodes and register a phy_device for each phy */
> > +       for_each_available_child_of_node(np, child) {
> > +               if (of_node_name_eq(child, "ethernet-phy-package")) {
> > +                       rc = of_property_read_u32(child, "reg", &addr);
> > +                       if (rc)
> > +                               goto exit;
> 
> This means a PHY package node w/o a reg property will prevent all other
> PHYs in the same parent node to be found?
>

Since this is something new, would it be a problem to make it mandatory
to define a reg? (And return error if we find something? Or print a
warn?)

> > +
> > +                       rc = __of_mdiobus_parse_phys(mdio, child, addr, scanphys);
> 
> You might want to save passing scanphys down, PHYs w/o a reg property in
> a PHY package won't be "auto scanned" later.
> 

I might be confused by this, but isn't this already done? (passing
scanphys in each recursive call so we can set it to true if needed?)

Also I think the scanphys should be skipped for the PHY package
(assuming we make reg mandatory, it would be an error condition and
should not be handled?)

> > diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> > index afbad1ad8683..7737d0101d7b 100644
> > --- a/drivers/net/phy/mdio_bus.c
> > +++ b/drivers/net/phy/mdio_bus.c
> > @@ -459,20 +459,33 @@ EXPORT_SYMBOL(of_mdio_find_bus);
> >   * found, set the of_node pointer for the mdio device. This allows
> >   * auto-probed phy devices to be supplied with information passed in
> >   * via DT.
> > + * If a PHY package is found, PHY is searched also there.
> >   */
> > -static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
> > -                                   struct mdio_device *mdiodev)
> > +static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
> > +                              struct device_node *np, int base_addr)
> >  {
> > -       struct device *dev = &mdiodev->dev;
> >         struct device_node *child;
> >  
> > -       if (dev->of_node || !bus->dev.of_node)
> > -               return;
> > +       for_each_available_child_of_node(np, child) {
> > +               int addr, ret;
> >  
> > -       for_each_available_child_of_node(bus->dev.of_node, child) {
> > -               int addr;
> > +               if (of_node_name_eq(child, "ethernet-phy-package")) {
> > +                       ret = of_property_read_u32(child, "reg", &addr);
> > +                       if (ret)
> > +                               return ret;
> 
> of_node_put

-- 
	Ansuel

