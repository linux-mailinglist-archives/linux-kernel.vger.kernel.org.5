Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4D812010
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442615AbjLMUeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:34:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50160A3;
        Wed, 13 Dec 2023 12:34:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so78496095e9.2;
        Wed, 13 Dec 2023 12:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702499662; x=1703104462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cZt635Sksiv/B4iHuCAGDrtYdVX5NK3B45SifYW+RSU=;
        b=OWh8Js1xctM3ckMsJHHyFs0jlPyhA8QjlMva5OrfX85eBUX82KzXpO5rNnuIe+9mNu
         of696V1JOxPideUF6o8d65jMyn9CePllnMyewjBkqCGqMDV+dm79XBrFuKJqGkXVB8CW
         MXamE4c4XjPYuwME7+SUYmNw3xbfoUSsYTMTHnpvlTYvo4XQsDTynnoZgHI82lKRpjbo
         y3zzTQ7nOPVcY+AA49tOHFlv5MgOm3x/+BLaLXNnt8bZElxMH+0jROitH1OYYQBYxPSJ
         umLhAzq34MmR1nxWUk0GiDkjMqE1yDqOXmu6G2WwyjorhNBB8W01NAbukiYcJrocucNe
         TA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499662; x=1703104462;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZt635Sksiv/B4iHuCAGDrtYdVX5NK3B45SifYW+RSU=;
        b=rXs9uw3bwX0K5adMfRg+PBml8ujDrmwnmdezYXGDFQlmFBMP8gngPvzyYnqQPbMTiH
         ogGmALb9aI/6B3fyyz7xCkEirWcq2w0eshhjVjuECmFo3CBzCTFgtchMHCCQJyUwVgey
         y3qtSVLQZpovfleJ9I9oNFoQvF77a5/dFeWvbSUz7mEigRUDCA90yJMv+pNSsDg8Z7yW
         JJkaXG7xhVDJ3gCI+p+sMCJA/p5cndYIq2iJM/0prg3b4iQiL8sl0v1nu8mwQrIrgVXj
         ezfcFGivvFbP6Fhbl2HyDWpAXbMmcxXgI0g0kz1Vr+y24oig06HT0lZgiJc86K9jAIIj
         ZjFQ==
X-Gm-Message-State: AOJu0Yw7+PgoGJBQriM8B9mQ7ixZELq7jPSwMB61dvdRtcB8qXlUNg8X
        E0Qx4oE/V6KQ9LRrQ16jYDk=
X-Google-Smtp-Source: AGHT+IHaGfR3RX18f4847KxfzLmuAMM3GtfUiiNka5Gh/lb8lUiXGzuZv2vlnb/OD61S/h1+spe0MQ==
X-Received: by 2002:a05:600c:3ca5:b0:40c:4b42:a1fd with SMTP id bg37-20020a05600c3ca500b0040c4b42a1fdmr2426945wmb.34.1702499661392;
        Wed, 13 Dec 2023 12:34:21 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id jb4-20020a05600c54e400b0040c5cf930e6sm3184972wmb.19.2023.12.13.12.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:34:21 -0800 (PST)
Message-ID: <657a154d.050a0220.c9399.b619@mx.google.com>
X-Google-Original-Message-ID: <ZXoVSkfZ_1G_zKUg@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 21:34:18 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: phy: leds: use new define for link
 speed modes number
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
 <20231213181554.4741-3-ansuelsmth@gmail.com>
 <ZXoRntVeW/YL/H5n@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXoRntVeW/YL/H5n@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 08:18:38PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 13, 2023 at 07:15:54PM +0100, Christian Marangi wrote:
> > Use new define __LINK_SPEEDS_NUM for the speeds array instead of
> > declaring a big enough array of 50 elements to handle future link speed
> > modes.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/phy_led_triggers.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
> > index f550576eb9da..40cb0fa9ace0 100644
> > --- a/drivers/net/phy/phy_led_triggers.c
> > +++ b/drivers/net/phy/phy_led_triggers.c
> > @@ -84,7 +84,7 @@ static void phy_led_trigger_unregister(struct phy_led_trigger *plt)
> >  int phy_led_triggers_register(struct phy_device *phy)
> >  {
> >  	int i, err;
> > -	unsigned int speeds[50];
> > +	unsigned int speeds[__LINK_SPEEDS_NUM];
> >  
> >  	phy->phy_num_led_triggers = phy_supported_speeds(phy, speeds,
> >  							 ARRAY_SIZE(speeds));
> 
> Yes, I agree the original code is utterly horrid, and there should be a
> definition for its size. However, this is about the only place it would
> be used - if you look at the code in phy_supported_speeds() and in
> phy_speeds() which it calls, there is nothing in there which would know
> the speed.
> 
> The only two solution I can think would be either a new function:
> 
> size_t phy_num_supported_speeds(struct phy_device *phydev);

Maybe this is better to not fill the phy_speeds function with too much
conditions.

> 
> or have phy_speeds() return the number of entries if "speeds" was NULL.
> 
> Then kmalloc_array() the speed array - but that seems a bit on the
> side of things. The code as it stands is safe, because the passed
> ARRAY_SIZE() limits the maximum index into speeds[] that will be
> written, and it will result in the slower speeds not being added
> into the array.
>

The fact that the phy_speed compose an array in descending order seems
wrong to me and not following why it was done like that in the first
place.

Passing for example an array of 3 elements i would expect 10 100 100
speed to be put instead of 800 400 200. (just as an example)

Wonder if it would be sane to do this change. (invert the produced speed
array with ascending order)

A kmalloc_array might be overkill for the task but declaring a random
array of 50 elements is equally bad...

Think I will just implement kmalloc + function to return the count of
speed modes from the settings struct.

-- 
	Ansuel
