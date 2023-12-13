Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89735811949
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjLMQ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjLMQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:26:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C8E3;
        Wed, 13 Dec 2023 08:26:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-336420a244dso477400f8f.0;
        Wed, 13 Dec 2023 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702484807; x=1703089607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86rjT9r43JxUHVqCjIMaYs/7Gsf2BMQ04Q05TfKC+5o=;
        b=eWH6oA5wx3EmMj5NFX8Nk+naIAzSf9xFR5k4eFZQDsvXpJAENOBWBenyltoGnX9XVM
         +Vt1eGvp9AjJFDUidC2QmVqK+eqW8djbIHwsduYv6Wqsgk3YjjcKaxDS9H3XsEGbQJqC
         c4OJFGzOxYKeEoaiY5IK8HGpiCGoQeBy3aOUWH0CqbY8QulSwMoNFa4ZaxhnnGWUNwra
         euTHFQ3YarrRQRAshlhs75aH2m5t/4RnY69l3S6LeAMD8PZ3QcjFuqIG6+pPaipeQ3eQ
         kIWiJ3X0Bm+rN0fY09hzDTnHsUmJmqMEUbDqhxTLAdszfcGi8IsJinNiJ7+oGPdbvlER
         IY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484807; x=1703089607;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86rjT9r43JxUHVqCjIMaYs/7Gsf2BMQ04Q05TfKC+5o=;
        b=V8BewCm1TIfKpjW6iRjstY9W6oFL/39MYiPuGiNi9AufbKAZROuyqppCYR+Yct2gZZ
         DDfkZ4w00FFvyrWtxosO0c/Hp7VIt6Usk87Fbvb56GDDLkFBlh8yZr0/I1xR+rdkFTV7
         wHycl4wHvKve77qEauQwsETQoxm8xos62jAkp0JzFBeVMcQBYCapn0MYTATJE270vFSh
         LupRgmcaym88cMh/3+w7t73XGTufvcEltcOeC/2lRJGTORtr4RynwP/SaTU3caMvhOvZ
         9ACQy3FS9lSyh8UN2a2guHhYTNs/UbTKjTeKJ1gQmtgC3hvwMgIGLjNL12SVDlo+HQfD
         Ufmg==
X-Gm-Message-State: AOJu0YwdMOU8gqWAT8ssxAK49uoobgJ5HPnt5xfQ7qIJeRHh/w9i4odg
        8EI17KnN9w6UykmbpY+PQjM=
X-Google-Smtp-Source: AGHT+IG3J3ozT4pM9XLZHmjeZXoiiA+xGV9gq0CLTjcYh08vAtBidQZZbRv0vSgmwbthR08Q89v97w==
X-Received: by 2002:a5d:63cf:0:b0:333:3a3b:8b9b with SMTP id c15-20020a5d63cf000000b003333a3b8b9bmr3811893wrw.108.1702484806570;
        Wed, 13 Dec 2023 08:26:46 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b003363823d8aesm2291005wrt.59.2023.12.13.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:26:46 -0800 (PST)
Message-ID: <6579db46.5d0a0220.d624a.80b4@mx.google.com>
X-Google-Original-Message-ID: <ZXnbQ3gpxfBxO2sK@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 17:26:43 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 3/3] net: phy: add support for PHY package
 MMD read/write
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
 <20231213105730.1731-3-ansuelsmth@gmail.com>
 <ZXnSB4YsuWZ0vdj2@shell.armlinux.org.uk>
 <6579d3df.050a0220.41f9b.a309@mx.google.com>
 <ZXnYKLOeStCuVXY7@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnYKLOeStCuVXY7@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:13:28PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 13, 2023 at 04:55:08PM +0100, Christian Marangi wrote:
> > On Wed, Dec 13, 2023 at 03:47:19PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Dec 13, 2023 at 11:57:30AM +0100, Christian Marangi wrote:
> > > > Some PHY in PHY package may require to read/write MMD regs to correctly
> > > > configure the PHY package.
> > > > 
> > > > Add support for these additional required function in both lock and no
> > > > lock variant.
> > > > 
> > > > It's assumed that the entire PHY package is either C22 or C45. We use
> > > > C22 or C45 way of writing/reading to mmd regs based on the passed phydev
> > > > whether it's C22 or C45.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > 
> > > I don't recall what has been said in previous postings of this, but
> > > introducing new helpers without an example user is normally frowned
> > > upon. The lack of cover message for this three patch series also
> > > doesn't help (the cover message could explain why there's no users
> > > being proposed with this addition of helpers.)
> > >
> > 
> > These are prereq for the qca803x PHY driver and the PHY package series.
> > 
> > I can move this single patch in those series, but it was suggested to
> > move these simple change to a separate patch to lower the patch number
> > since they were orthogonal to the PHY package series proposal.
> 
> ... so adding a cover message (your series in general seem to lack
> those) would be a good idea to explain that.
>

I tend to use cover letters only for big series, sorry for not being
very clear about this. Soo should I detach this from here or it O.K.?

-- 
	Ansuel
