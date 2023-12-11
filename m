Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3AC80D4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbjLKR5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKR5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:57:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80FCD;
        Mon, 11 Dec 2023 09:57:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b5155e154so55892165e9.3;
        Mon, 11 Dec 2023 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317475; x=1702922275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wYKSJ2l3/7Ewha/gT1ScFG6FBTutwPomIDS5R6uY778=;
        b=Ym5MwTGeE8YE6Wa29SglxoszQ4v5RFUclnKE6xTGGnwHq+UE8ZWFpYbUr1docIiy1V
         fEK2v0Iu94XBPVfB6PlI+6H0omRdby8HJgy+GVrxNVVyck9a35ZzoEq/vOLcz9O/kLjb
         D+KKS5CuEdDVGb2J6SSHkgmh/ACoo7f0J1ONfDStEWW4/vCyLm7SnHRx7oIi4xK6sGwp
         qCad/uKrFTUsZek4MxV4VUTqFhCE7HhPawBNbV1qz2a3RgSAjowaF2H/XxZdzKDukIo3
         fhbTPA4brHiK+zah7y+6b2saHe5ellncJO0CphyS0G+B9pZ/9GMSsXKPw8EEUmimkTCn
         ALqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317475; x=1702922275;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYKSJ2l3/7Ewha/gT1ScFG6FBTutwPomIDS5R6uY778=;
        b=w4Io3RETbttqm6IMuDDplJPnDqA7qTPcv+Cvm6kTQnNpmcl6uGYB2jPxbhnzR7EwaW
         mQ98OGqAGFK+0i0wmcOOkpFK1HeQ3g4BkqoON/4mSaye1szd/m3wsoxbkS4o/iC1I404
         /NMQjege5T2d0buYQIfSjE+WZlvZNvfsEuL3RW8Se+oBKP+Fvk4NBBouKKrQiGC2PVCv
         OJ1wyn1BuAUwkYhK9dOj3cr1Ib6wL1u64PeCQITNSUBgpH/o/IFXr2wUmGmmOTAWdwL/
         8QEp+mxC1bo/btLYDgQHAbOUM6240p41tioZDBlsLLludy5aUZr5p5MC5k8wODRQIn1S
         TVWQ==
X-Gm-Message-State: AOJu0YypnylH1JR0/pkEJRnTsRFQbS/OYA4ioWVQz/cU0xSiyLwpL2yh
        nu2C/IkQkRLvDwxxOjXOUE2eDLITztE=
X-Google-Smtp-Source: AGHT+IEg3L3pPefnALqwZK+c/kYFSt7/PmeOBRRMNF0qjacTIuHa3pTrzWGFXCqoTZPCv8mt9vjefA==
X-Received: by 2002:a05:600c:5248:b0:40c:3e0a:692e with SMTP id fc8-20020a05600c524800b0040c3e0a692emr1989294wmb.232.1702317474580;
        Mon, 11 Dec 2023 09:57:54 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b0040b397787d3sm10147623wmb.24.2023.12.11.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:57:53 -0800 (PST)
Message-ID: <65774da1.050a0220.bd430.2025@mx.google.com>
X-Google-Original-Message-ID: <ZXdNnsqUxlecXIF8@Ansuel-xps.>
Date:   Mon, 11 Dec 2023 18:57:50 +0100
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
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
 <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
 <65772f36.050a0220.678b6.ef84@mx.google.com>
 <74b7fc4f-88d2-41c0-8d98-6530f0fc2d70@lunn.ch>
 <657744b5.050a0220.dfa0d.11a4@mx.google.com>
 <2698eda5-af84-494f-844b-2ea87aa510d2@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2698eda5-af84-494f-844b-2ea87aa510d2@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 06:49:02PM +0100, Andrew Lunn wrote:
> On Mon, Dec 11, 2023 at 06:19:46PM +0100, Christian Marangi wrote:
> > On Mon, Dec 11, 2023 at 04:54:12PM +0100, Andrew Lunn wrote:
> > > > Mhhh with a generic property and LED core or phylib handling it... How
> > > > it would work applying that setting on PHY side?
> > > 
> > > Add a .led_set_polarity callback to the PHY driver structure?
> > > 
> > > Take a look at other LED drivers. Does anything similar already exist?
> > > It is unlikely that PHYs are the only sort of LED to have a polarity.
> > >
> > 
> > Interesting topic... With a quick grep on Documentation for polarity of
> > high, I can't find any use of it...
> 
> As i said, active-high is the default. So there is no need to specify
> it. But if you look in Documentation/devicetree/binding/leds for
> 'active-low' you will find a few examples.
>

Yes I was searching more and I just notice active-low and led-active-low
usage for bcm6358.

> > Also main problem is that the thing is controlled globally and not per
> > LED. (can be handled internally to the driver with some priv and check
> > magic)
> 
> Ah, missed that. Marvell PHYs have polarity per LED.
> 
> It would be better to describe this correctly, so one property at a
> higher level. We can then in the future add an 'active-low' property
> per PHY.
> 
> > Is it worth to impemement the additional API to control this? And I
> > guess a egenric binding should be added to ethernet-phy? Or should it be
> > added to LEDs?
> 
> Since it is above individual LEDs, i would not add it to the generic
> LED binding. But it could go inside the leds object of
> ethernet-phy.yaml.
> 
>            leds {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
> 		active-low;
> 
>                 led@0 {
>                     reg = <0>;
>                     color = <LED_COLOR_ID_WHITE>;
>                     function = LED_FUNCTION_LAN;
>                     default-state = "keep";
>                 };
>

Ok! And I guess the additional API will (initially to be later expanded
for other usage?) take this value and call the set polarity based on
this correct? 

bool active_low = of_property_read_bool(leds_node, "active-low");

.led_set_polarity(struct phy_device *phydev, bool active_low);


Maybe a more flexible approach might be scan for both. (either in leds
node or in the led subnode)

.led_set_polarity(struct phy_device *phydev, int index, bool active_low);

Where index is -1 if it's global and the led index if it's in the led
node?

PHY driver will know what to ignore/use as I can't immagine to have a
PHY that have both global and per LED polarity. What do you think?

-- 
	Ansuel
