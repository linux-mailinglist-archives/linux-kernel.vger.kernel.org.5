Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999077DF5AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjKBPHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjKBPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:07:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6014182;
        Thu,  2 Nov 2023 08:07:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso619517f8f.1;
        Thu, 02 Nov 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698937664; x=1699542464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f94qUiebgt615Sr9cehEdI7ADckCMJr6fkub4RY4NUg=;
        b=FuR0c4/rjKGVh1j0SMywJBYuTDpOODK+2mH5bRNR0I3XlIvWnI482myh7Rhz5l7Lgf
         9PSnFm2b7FR/DA2XJcudJ/tm+G4Ih6Max+haRbwsaVoAuafyLzss8QHWsJUIuWUf3aG8
         y32GndC4EfqAMQjnyM70LFqX7L+6h1Kn3HJzy+SEgV9rf4DimRZhPkiZnf5MR1/DLdhL
         ycqu1bnqXt50rFo55dvuQbV7xziNGfHYQq07xo75p3kqgytEoigeuqXoOfh4+SBuQKSt
         111wIm6+zt5ZeL+NAcLnqoOBo7sdk6N7milGQZKTroFKqM2x9p+HppQda8uuH1qOB1ID
         QIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937664; x=1699542464;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f94qUiebgt615Sr9cehEdI7ADckCMJr6fkub4RY4NUg=;
        b=vcWL/FaGpd3f34br8xRR4Xx0TAXB+mgpBUdDd1za4WgcnlBP+Ngoe7h4izl1D9ckww
         WilvZLg8XouE5ln9gqGW3fA0UP9ZW90S1IxVOKOgqjyGCek1bJNlYm4Ym9kmnIotsvfF
         r5/Bk6bXUCJBw0Z79NVbuGi6E8jdSDso+M7bt8xLXjzm7s8fZqBRV0d/jeFH9S53/wYp
         Go+OU0POm0bazXTcZST2KaCiyiAMBInecXSVKwOiQ1A20fklJTO9jcU/ndzgAA+ymDnz
         85MToAuUtsvU2ceCcYmv6EOvbEmwQTf2ygceJTdH/IwmBxroeg1sVfIgmQjD3aUR1x+2
         47TQ==
X-Gm-Message-State: AOJu0YxMihh1T0i57bKegn1eKIprWcNv8965f4cot15G+koGQNIT1uiK
        YxARdYRI8hkJFQJcwnHOQTE=
X-Google-Smtp-Source: AGHT+IH5ZE9FSQlNE3PZ8RAa+Lcifz39U2xdAz+PBp97L7K0uZJ1QXZtktKzDfi290zWpExYpLYK6A==
X-Received: by 2002:a05:6000:1849:b0:32f:798f:2b3b with SMTP id c9-20020a056000184900b0032f798f2b3bmr13090330wri.16.1698937664078;
        Thu, 02 Nov 2023 08:07:44 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id r15-20020adfe68f000000b0032dbf32bd56sm2697400wrm.37.2023.11.02.08.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:07:42 -0700 (PDT)
Message-ID: <6543bb3e.df0a0220.385df.cdb1@mx.google.com>
X-Google-Original-Message-ID: <ZUO7PTtOdWOqkknM@Ansuel-xps.>
Date:   Thu, 2 Nov 2023 16:07:41 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 1/4] net: phy: aquantia: move to separate
 directory
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
 <5f60b2dc-4e97-49dc-8427-306400fb1b71@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f60b2dc-4e97-49dc-8427-306400fb1b71@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 04:03:33PM +0100, Andrew Lunn wrote:
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > index 421d2b62918f..4b2451dd6c45 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -68,6 +68,8 @@ config SFP
> >  
> >  comment "MII PHY device drivers"
> >  
> > +source "drivers/net/phy/aquantia/Kconfig"
> > +
> >  config AMD_PHY
> >  	tristate "AMD and Altima PHYs"
> >  	help
> > @@ -96,11 +98,6 @@ config ADIN1100_PHY
> >  	  Currently supports the:
> >  	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
> >  
> > -config AQUANTIA_PHY
> > -	tristate "Aquantia PHYs"
> > -	help
> > -	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
> > -
> 
> Does this move the PHY in the make menuconfig menu? We try to keep it
> sorted based on the tristate string.
>

Oh wasn't aware... Yes it does move it to the top of the list... I can
just move the source entry where AQUANTIA_PHY was... Or if we really
want, not create a dedicated Kconfig for it and keep everything in PHY.

-- 
	Ansuel
