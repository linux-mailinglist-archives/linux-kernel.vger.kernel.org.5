Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB38E8132D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573439AbjLNOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjLNOTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:19:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF45136;
        Thu, 14 Dec 2023 06:19:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso6342807e87.2;
        Thu, 14 Dec 2023 06:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563549; x=1703168349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ3bwMUk8X1J9J3ypOy0/pA2DHF8fbOaltjbT7mP9XQ=;
        b=k4AZMB4qqs2QvtVei5TV64L4E5JV6cNBfZFPHH3XotPoyBzdvtopDjqd1IDiX5C01v
         bp9MvuyAZda9AKHUj2dFPBLlpCCWjolTCKUxp6sjPQjzTIcLbnhYPmxxC4qElNRuRY0/
         Z34PfTl421la5OUPKn4eMt/dxGV+P0KIBSFo1FBBkxsi9jIXAiwGxx2XQtGqrUFzgUlk
         oj2PBHdCZcj7wkqRPBaN+nisL3Z2iGYdqfLCGHhFNOeclb4LbG0LIHvHoYrYs2JFk+0m
         3MGcsEckiian6QrxfrLnNN6jmaYDi3znouaq5lTC8FeALsQTGSBGJaqL5qciQQzwrQGg
         X1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563549; x=1703168349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ3bwMUk8X1J9J3ypOy0/pA2DHF8fbOaltjbT7mP9XQ=;
        b=a9Ih1576xLOsVm/hKMoIq6R625GFTvkde7MMPYa6V1ObFsMbfgWuw0PYEQc2zx6Lzy
         /ircoEqnPNYFmfCvnUAw0WtsNjQMvha/AQ9u3HLNXSG5q9sLUyma/UOxdxISO6MCpfim
         Jdsxr1Vg1a0yUEMI9/XeMG+O6jotfxFrRLw1wkSTIKfbAvqGlE7Nma+siSW8Xh7qnAOb
         FdCS8DTGcF7umItToTO5vUW9TZSe5dA4etn1YFvC1g1t+dcmHGwrcJklb/HRFqHRF2dK
         K3JaDBjKpMb67Fni6uYxV3NNhDpQiB/wWzY5lQTwruHtPvBxq1/cwTVToZyIP4+OxKKN
         dwXg==
X-Gm-Message-State: AOJu0YwMC83y6FcZ0XuUj9Nj5ZvshFgBceVRP/JQQZPjAK2c3G3ZNziN
        3suq6oSl8+1VAJFQOG83JMs=
X-Google-Smtp-Source: AGHT+IHqRqPM9xCrb8bY2qjbc5gXG+mnTP3vPzOVFwnQVHJHqCdJgI9kYABRRuwhHG1WUCcWt/wOqg==
X-Received: by 2002:a19:f70b:0:b0:50c:1f:7e00 with SMTP id z11-20020a19f70b000000b0050c001f7e00mr4932096lfe.21.1702563548694;
        Thu, 14 Dec 2023 06:19:08 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d6-20020ac24c86000000b0050bed336e0csm1881825lfl.162.2023.12.14.06.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:19:08 -0800 (PST)
Date:   Thu, 14 Dec 2023 17:19:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
Message-ID: <n44fxxqr6q3fs7z6uhooecn55tvyapdroizsowtmfgrn7vnhlw@dt25gi2dybc4>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8pxM3RvyHJTwqH@shell.armlinux.org.uk>
 <gbkgtb4yp3cwyw7xcuhmkdl3io2wlia2gska2xmjbwjvhigpz3@w52b6tdyugqo>
 <ZXnclVEz10K2XD2+@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnclVEz10K2XD2+@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:32:21PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 13, 2023 at 03:01:45AM +0300, Serge Semin wrote:
> > On Tue, Dec 05, 2023 at 01:46:44PM +0000, Russell King (Oracle) wrote:
> > > xpcs_create_mdiodev() as it originally stood creates the mdiodev from
> > > the bus/address, and then passes that to xpcs_create(). Once
> > > xpcs_create() has finished its work (irrespective of whether it was
> > > successful or not) we're done with the mdiodev in this function, so
> > > the reference is _always_ put.
> > 
> > You say that it's required to manage the refcounting twice: when we
> > get the reference from some external place and internally when the
> > reference is stored in the XPCS descriptor. What's the point in such
> > redundancy with the internal ref-counting if we know that the pointer
> > can be safely stored and utilized afterwards? Better maintainability?
> > Is it due to having the object retrieval and storing implemented in
> > different functions?
> 
> The point is that the error handling gets simpler:
> - One can see in xpcs_create_mdiodev() that the reference taken by
>   mdio_device_create() is always dropped if that function was
>   successful, irrespective of whether xpcs_create() was successful.
> 
> - xpcs_create() is responsible for managing the refcount on the mdiodev
>   that is passed to it - and if it's successful, it needs to increment
>   the refcount, or leave it in the same state as it was on entry if
>   failing.
> 
> This avoids complexities in error paths, which are notorious for things
> being forgotten - since with this, each of these functions is resposible
> for managing its refcount.
> 
> It's a different style of refcount management, one I think more people
> should adopt.
> 
> > While at it if you happen to know an answer could you please also
> > clarify the next question. None of the ordinary
> > platform/PCI/USB/hwmon/etc drivers I've been working with managed
> > refcounting on storing a passed to probe() device pointer in the
> > private driver data. Is it wrong not doing that?
> 
> If we wanted to do refcounting strictly, then every time a new
> pointer to a data structure is created, we should be taking a refcount
> on it, and each time that pointer is destroyed, we should be putting
> the refcount. That is what refcounting is all about.
> 
> However, there are circumstances where this can be done lazily, and
> for drivers we would prefer driver authors not to end up with
> refcount errors where they've forgotten to put something.
> 
> In the specific case of drivers, we have a well defined lifetime for
> a device bound to a driver. We guarantee that the struct device will
> not go away if a driver is bound to the device, until such time that
> the driver's .remove method has been called. Thus, we guarantee that
> the device driver will be notified of the struct device going away
> before it has been freed. This frees the driver author from having
> to worry about the refcount of the struct device.
> 
> As soon as we start doing stuff that is outside of that model, then
> objects that are refcounted need to be dealt with, and I much prefer
> the "strict" refcounting implementation such as the one I added to
> xpcs, because IMHO it's much easier to see that the flow is obviously
> correct - even if it does need a comment to describe why we always
> do a put.

Ok. I fully get your point now: lazy refcounting for the drivers
following standard model and the 'strict' one for others. It sounds
reasonable. I'll get that adopted in my future developments. Thank you
very much for the detailed explanation and for all your comments.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
