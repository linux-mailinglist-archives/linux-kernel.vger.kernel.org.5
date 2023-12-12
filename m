Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6687180F050
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376679AbjLLP0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjLLP0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:26:17 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B43AA;
        Tue, 12 Dec 2023 07:26:23 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso74882821fa.2;
        Tue, 12 Dec 2023 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702394781; x=1702999581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzfykjqVsJboNXe+GyM6OYXbP3W5WNnJ1aGISEQJa3Q=;
        b=YHX5pL6oJFUsSwBk8s91P4GP016767zDZ3xGtKlET9cPh6G2ogZ3OcXLZsFNF5OHfz
         cR0ySMmXZUsmIlbCAUAJWtBG7R0TsGpP+WkbPkz/q6NWxO/Fj1gPIZJCKMHVcEG0G5Ld
         Ae4De6TUtKxQRtYqYZ2sS8+SiOhp0OBRXfQlllJhDIIUz+fUOAcEN1/O25kWS7c6sc7l
         JPgxq6k5tmcInCnHg4AM32SmIzaRcBidVyWRfYP5/xSV9gG3wSSgk3jnU9sZCWR79NFO
         v5rZpeb5sjIefZYyS28z4FmBfr0zsFkxgYQOD69hV1VdrC+PC4BrfY2h2uTvWymc+nJp
         e1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394781; x=1702999581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzfykjqVsJboNXe+GyM6OYXbP3W5WNnJ1aGISEQJa3Q=;
        b=huKyYmnDjkz3BN16Tettb7ikFPm7FlHVbl5qfB2MGHv/zS6jwoEZDe0YnUDLGmupKn
         Rp8vn0r/g1LbVPg+JwVHkUM3pK05H8/FIqCBc1Ujoboiwea6tJFM0hmADYJ3p3MR/0OQ
         JjGXMtS+p1Ru1gjutMtsm33XvZFqHEYGAv7gbAugW9fi1cyW8ysABrHdypuOiOhpdvyS
         UC6MynOvPNKbXq9L+Io4ztVEKZKefzgFP5xfVNYXiRWB2d3Klo2wzS4+YA3YnCjMNtIc
         M5Z+y+mkZ+1e7OL7g9Vt6WyrcnJ6f6DsSd5Tgms1uymXsSI8zBB6wsKz400QwoBPvhqg
         4NVw==
X-Gm-Message-State: AOJu0YyTmt5LfL5OUlk374E+F0XvbmNFWXY/l0Khp6gGvp5TjLYfFvOT
        keKNTh01MmW+v0HL2E7N4cw=
X-Google-Smtp-Source: AGHT+IFitWMolf9+MGbv8J/HUGRQFIiJq5Iv39LqC9IhSSbGgybQNYWznOea4pt3phQe2oNaB8bqQQ==
X-Received: by 2002:a2e:9ec4:0:b0:2ca:752:24a3 with SMTP id h4-20020a2e9ec4000000b002ca075224a3mr2851858ljk.22.1702394780915;
        Tue, 12 Dec 2023 07:26:20 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z18-20020a2ebe12000000b002c9f59f1748sm1537789ljq.7.2023.12.12.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:26:20 -0800 (PST)
Date:   Tue, 12 Dec 2023 18:26:16 +0300
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
Message-ID: <kagwzutwnbpiyc7mmtq7ka3vhffw4fejuti5vepnla74rocruh@tryn6lxhwbjz>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8pxM3RvyHJTwqH@shell.armlinux.org.uk>
 <ZW85iBGAAf5RAsN1@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW85iBGAAf5RAsN1@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:54:00PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 05, 2023 at 01:46:44PM +0000, Russell King (Oracle) wrote:
> > For your use case, it would be:
> > 
> > 	mdiodev = bus->mdio_map[addr];
> 
> By the way, this should be:
> 
> 	mdiodev = mdiobus_find_device(bus, addr);
> 	if (!mdiodev)
> 		return ERR_PTR(-ENODEV);
> 
> to avoid a layering violation.

I would have used in the first place if it was externally visible, but
it's defined as static. Do you suggest to make it global or ...

> At some point, we should implement
> mdiobus_get_mdiodev() which also deals with the refcount.

... create mdiobus_get_mdiodev() instead?

* Note in the commit message I mentioned that having a getter would be
* better than directly touching the mii_bus instance guts.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
