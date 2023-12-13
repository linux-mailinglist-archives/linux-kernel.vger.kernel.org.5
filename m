Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58A81186D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442393AbjLMPzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442349AbjLMPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:55:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB1B9;
        Wed, 13 Dec 2023 07:55:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c2308faedso72634285e9.1;
        Wed, 13 Dec 2023 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702482912; x=1703087712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1e68y3FE2MWFKMLTP5Kx3EY4iyEbW3G10jBWGdPzM7s=;
        b=CmLnoCATwRVs9GWg9e4KkhWWTEFdxIDwhdZI8Ar8CYv8BcTUUzEYbNw5i9Q5OAVoUq
         G9L7TFXKGY9OZ7rTbiaUy6FItRgIkQLlcAda0njviGWMkSZMrPShdEf2S4o9OakNsh0v
         /H08wHWVhKLQuJHlOTJCMqg4WYXtdXFtTwre8DAokAgRb/6D6PacGR5zVmvhPCTRLq12
         bz687sKt3AcUOfjQaoFmugU4wlb1X/xQPIzqNmoTot76iHbacznTsl28PFCcUSDbwt2y
         LSXHZYs8HyA74+n7I9ytCIv0u/aRXYDJjwIfXXDFXufxzGK+HlbDdaCG63zINwPVPHaG
         NpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482912; x=1703087712;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e68y3FE2MWFKMLTP5Kx3EY4iyEbW3G10jBWGdPzM7s=;
        b=J7CxrbhOPLEZJYNIL9jC68SCjYYYT/sR1/z8elqCzBdMjcZd/muA6HvIEwm9Pme9Gv
         +WVN8/KXlPwASUysWWSeLjJ/gNHJAr+XNnSVLg3WOPtydY5qCmjPiw/13DnfbBM1gwT8
         6ycRq1r4GPMRYJf3GOWaTP8Vmo4YU+WwwS0jg0uOHxUgXg3W/Axc/Va8FuqjomGDA6tn
         TDBLNPCCU6cvK+bnqmR6bUqKvUV3yVWoSg9nN13xNARppO8ldOoQ8bcwyquQJCLpCPAR
         KWiYOhSYOA6xV85zBXv582qdZ7lgM/VAby9O49OX3TnAaBCma9Oa/cayssasGEUniUht
         pjKg==
X-Gm-Message-State: AOJu0Yw2++QIfqkjFhSPHyFafVbfu54pMBE7gMw4G5EOnz5qM0YpC7vy
        PbLZ9Aqf0PVnbVscits6iX8=
X-Google-Smtp-Source: AGHT+IE4nQlwscrXHjGImT7QPI3Kd5SuwbK3f3e2SgnBwglpZhzxFrw2aKyBkUW7GqiFe3Q55OZlBQ==
X-Received: by 2002:a05:600c:246:b0:40c:c00:dfdb with SMTP id 6-20020a05600c024600b0040c0c00dfdbmr4352524wmj.11.1702482911494;
        Wed, 13 Dec 2023 07:55:11 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0040c490db950sm10760654wmq.47.2023.12.13.07.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:55:11 -0800 (PST)
Message-ID: <6579d3df.050a0220.41f9b.a309@mx.google.com>
X-Google-Original-Message-ID: <ZXnT3Kqs_JMr_KRe@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 16:55:08 +0100
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnSB4YsuWZ0vdj2@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:47:19PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 13, 2023 at 11:57:30AM +0100, Christian Marangi wrote:
> > Some PHY in PHY package may require to read/write MMD regs to correctly
> > configure the PHY package.
> > 
> > Add support for these additional required function in both lock and no
> > lock variant.
> > 
> > It's assumed that the entire PHY package is either C22 or C45. We use
> > C22 or C45 way of writing/reading to mmd regs based on the passed phydev
> > whether it's C22 or C45.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> I don't recall what has been said in previous postings of this, but
> introducing new helpers without an example user is normally frowned
> upon. The lack of cover message for this three patch series also
> doesn't help (the cover message could explain why there's no users
> being proposed with this addition of helpers.)
>

These are prereq for the qca803x PHY driver and the PHY package series.

I can move this single patch in those series, but it was suggested to
move these simple change to a separate patch to lower the patch number
since they were orthogonal to the PHY package series proposal.

-- 
	Ansuel
