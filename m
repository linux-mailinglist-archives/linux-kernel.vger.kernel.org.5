Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194867FD31B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjK2JrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjK2JrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:47:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89341990;
        Wed, 29 Nov 2023 01:47:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-332cb136335so4503999f8f.0;
        Wed, 29 Nov 2023 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701251241; x=1701856041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tmdrAkRlA6xplH27jHLiMRC8wSQ2FJ2TlbcW+1L16+w=;
        b=iUAEW4W+7JXlTtIRoJoNaa7MYDn2tcTvU7hEJRHTSo0jfX18hprMT1wSwZ6I324hgD
         bpaXg2Nwr4rxir8mXFxyuEIR//SmfV68J+THGc4Q+Jb4RvrtzNpOVRJ7N4Ff26Fq9YSr
         hNErokaEqo2UDR92SK6VAUqo5NactGnMRSQ/m1+/m8ru+vpsTQ1acNcUYvQKsRZAK1pL
         kaLCfth3WSOPYvLgoNAWN9q1m++cCkdZjS364Xjqf3mz/8DALiR1/HZN7QxI8dB5CIgv
         kamO2s/1cuyssflV708I2M4VJA4+DuHb7HawNvWoZT5RsqCPk5IoRu0fmLSggTffXOnI
         NdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251241; x=1701856041;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmdrAkRlA6xplH27jHLiMRC8wSQ2FJ2TlbcW+1L16+w=;
        b=Cn+AfzRILjJX4eiS+leiIg1Cqzlgldt/J3qF8SndRfVRWa0+3BVRpjQU6t4GJqehnm
         v5uY7EvZ9mm23wUHXDSLjjoPH7c9Puh6+Iu/djK+mTSz+EXFxagaZUYZclIyn42he79W
         e3PZpuvhkVGADOpZ8XxnhTcnSKxL1UZHLYalO5fSZiBSxcBvownswi1S+NWEMUBKuLkC
         bHT/H8lM7REQWilNzfwKuHjnEL6jI+FiKBth9bjPPFl3Y+EXLsfxaon6s1pxf8ZAdlgv
         WbxcflLVjPhouiLrvPImFP+bLXvScs03cNJjP+x1z4+Ar0APu4bLPRr4cZO1m4+1RF5y
         akgw==
X-Gm-Message-State: AOJu0Yyf6ABppgswVoOq/jn/40MniLKGbpn06dF81omXQqG9E2Gc+HJi
        O2U488PCrSN38jo9K+DOZKU=
X-Google-Smtp-Source: AGHT+IFJIqqbIUVybyut0c5TBzi+/U/vvyAeknC6of2fayv2tmhNnbjyqNCL5wYYuMVDFqEuA8CmOg==
X-Received: by 2002:a5d:4cc1:0:b0:332:f8d2:640f with SMTP id c1-20020a5d4cc1000000b00332f8d2640fmr7644053wrt.39.1701251241124;
        Wed, 29 Nov 2023 01:47:21 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b003316b38c625sm17429283wro.99.2023.11.29.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:47:20 -0800 (PST)
Message-ID: <656708a8.df0a0220.28d76.9307@mx.google.com>
X-Google-Original-Message-ID: <ZWcIpjkrL6vJMZCy@Ansuel-xps.>
Date:   Wed, 29 Nov 2023 10:47:18 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 08/14] net: phy: at803x: drop specific PHY id
 check from cable test functions
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-9-ansuelsmth@gmail.com>
 <ZWcGn7KVSpsN/1Ee@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcGn7KVSpsN/1Ee@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:38:39AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 29, 2023 at 03:12:13AM +0100, Christian Marangi wrote:
> > @@ -1310,10 +1302,6 @@ static int at803x_cable_test_start(struct phy_device *phydev)
> >  	 */
> >  	phy_write(phydev, MII_BMCR, BMCR_ANENABLE);
> >  	phy_write(phydev, MII_ADVERTISE, ADVERTISE_CSMA);
> > -	if (phydev->phy_id != ATH9331_PHY_ID &&
> > -	    phydev->phy_id != ATH8032_PHY_ID &&
> > -	    phydev->phy_id != QCA9561_PHY_ID)
> > -		phy_write(phydev, MII_CTRL1000, 0);
> ...
> > +static int at8031_cable_test_start(struct phy_device *phydev)
> > +{
> > +	at803x_cable_test_start(phydev);
> > +	phy_write(phydev, MII_CTRL1000, 0);
> 
> I don't think this is a safe change - same reasons as given on a
> previous patch. You can't randomly reorder register writes like this.
>

Actually for this the order is keeped. Generic function is called and
for at8031 MII_CTRL1000 is called on top of that.

-- 
	Ansuel
