Return-Path: <linux-kernel+bounces-3226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28107816974
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B9328307B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0121400A;
	Mon, 18 Dec 2023 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmB2aru/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8114282;
	Mon, 18 Dec 2023 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336641e9cf1so826250f8f.0;
        Mon, 18 Dec 2023 01:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890575; x=1703495375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYzSx48ha3Gs21e+0j454YX0hJycY5NAquehQaBLJSI=;
        b=PmB2aru/iFYG7MG3fUGyidipr69jIE3ipet+LTeFa+6KadopF1TVxgIXOTKl3skThC
         h80sEI50XH1CNOAKITXa2xIYvoA6nH+hRS3jktFwE7isDJuCeL7RWT8n5+EaBzqlln33
         3RZJa/WFMrEU1sDkFmXAKufjCH0lp6IX77jL0Pb14roAVgf/Vo6bQISJ6NeioYoRr8Z7
         OUOjzawnG34AMrs5BQ/yMMsQw+xAd9yho97YmmBPbOH+h37+m8Wnfl9lR4rErwTd7DGb
         sARGBZNHykOI5GggyyxrrVXMbvX0EZ/8qQP/+zAhfD/cWc5JghRoacOeFDTYGFRDhO9E
         E+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890575; x=1703495375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYzSx48ha3Gs21e+0j454YX0hJycY5NAquehQaBLJSI=;
        b=uB6MdLxB3SYkV2NhLxQdEoi6peaNtuuSliwcY45ud31IAN2yLjDLvhtwdqZURqW8j4
         ZaAcrI3y7OmQqZJ2S0fr4YJ8G7fNFfauWWOI/SM5/wP63Rtq/lWkoJwdTm9Pvp+bHJcp
         VtrAlynoMgZEedTdK3rjM4/08v0qzkNqRSlMEJ1yRzvJVMfHA+CxnD/CI2AZvvsGtCBH
         HDD/+ztpJmn8L0vipCYJs3bfwxVUjAHgDRS6FxCNGSGuvIHpmBFwsmuVGFLrBze9hLJJ
         P8VO2x/6Ljxril5ATr/3WaZzyYIcr5Ptebf+uhqGwbf2amo5YlmbuBW6RFTN1xYftm2/
         ZinQ==
X-Gm-Message-State: AOJu0Ywd7Sy1382MR3PuuNesINs8oBkf3evomaHIrxbei73FOzR9BhrR
	u4J6b7duM0Lc1mQlpT/LYUtRl7JL1OcVMg==
X-Google-Smtp-Source: AGHT+IFuNzXUaYXkyUgsSjxjNWeVlvTMWSMes4kNG5veXDJbG+uqOLG8mH/CoaAnJJ44reGUsLx9hA==
X-Received: by 2002:a5d:4807:0:b0:336:6135:8e0 with SMTP id l7-20020a5d4807000000b00336613508e0mr1460682wrq.14.1702890575067;
        Mon, 18 Dec 2023 01:09:35 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b003364ce25f22sm9804652wro.108.2023.12.18.01.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:09:34 -0800 (PST)
Date: Mon, 18 Dec 2023 10:09:32 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <20231218090932.GA4319@debian>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
 <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
 <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZX78ucHcNyEatXLD@eichest-laptop>

Am Sun, Dec 17, 2023 at 02:50:49PM +0100 schrieb Stefan Eichenberger:
> Hi Dimitri,
>
Hi Stefan,

> On Sun, Dec 17, 2023 at 12:15:38PM +0100, Dimitri Fedrau wrote:
> > Am Sun, Dec 17, 2023 at 10:22:54AM +0100 schrieb Andrew Lunn:
> > > > > > +	/* Set IEEE power down */
> > > > > > +	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x840);
> > > > > 
> > > > > 0x800 is MDIO_CTRL1_LPOWER. What is the other? It seems like a speed
> > > > > selection bit?
> > > > >
> > > > The other is MDIO_PMA_CTRL1_SPEED1000. Will fix this in V2.
> > > 
> > > It seems odd to set a speed, and power it down. But i guess you have
> > > blindly copied the reference code, so have no idea why?
> > >
> > I agree, absolutely no idea. I already asked the Marvell support for
> > any document describing the init sequence, but they couldn't help me.
> > So I have to stick to the reference code. At least I copied the comments
> > that were part of the init sequence, trying to give some meaning to it.
> 
> I also tried to make the 88Q2221 work but didn't find the time yet to
> write a clean version yet. My last minimal patch looks as attached
> bellow.
> 
I probably will also get a 88Q2221 PHY, but it could take some time.
When looking at the reference code the only difference for the 88Q2220
and 88Q2221 seems to be an additional init sequence with 28 register writes.
Remaining code seems to be identical. Am I right ? If yes we can use the
same code base here. Besides that it seems that both PHYs share the same
PHY id and are only distinguished by the "Secondary ID Register".

> I think the main thing to make the PHY work is to call this
> sequence to set the master/slave detection threshold:
> 
> /* Set detection threshold slave master */
> phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
> phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0a28);
> phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0c28);
> 
> Without this sequence the PHY does not work. I was also wondering as
> Andrew wrote why we write twice to the same register. My assumption is
> that 0x8032 is some kind of selector for a subregister while 0x8031 will
> set a 32 bit value. Unforunately, I also didn't get that information
> from Marvell and it is just a wild guess. Please also note that calling
> the sequence in the probe function (as I do it in the example below) is
> definitely wrong, it was just a quick and dirty test I did because I
> wanted to know if it is enough to call it only once.
> 
You are maybe right about your guess. Without the init sequence at all I
was able to get the PHY work with a fixed setting (100Mbit/Master).
Maybe it was due to bootstrapping the pins of the PHY. But still I'm not
getting the point. What are we going to do ? Do we want to strip down or
generalize the init sequence ? There is probably a reason for such an
annoying large undocumented series of register writes.

> Are you able to test everyting with the upstream kernel? I'm asking
> because I have to backport a lot of stuff to a downstream kernel 5.15
> from NXP to test the 88Q2221. 
> 
I'm testing with the upstream kernel, no problems so far. Didn't have to
backport anything or test on another kernel. First version of my driver
was also on NXPs 5.15 kernel. Gladly you already upstreamed some T1
specific code which helped me a lot to reduce code size.

> Further, are you able to verify that autonegotion works? Somehow for me
> this never really worked even when using the example sequence from
> Marvell.
> 

Autonegotiation works fine, didn't have any problems. I'm using the
88Q2220M rev B0. I test it with a Media Converter, the NETLion1000 C2T and
with another 88Q2220M PHY. What do you use for testing ?

> Best regards,
> Stefan
> 
Best regards,
Dimitri

> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 94a8c99b58da..15e82e8ff8f4 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -208,17 +214,26 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
>  
>  		ret = ret >> 12;
>  	} else {
> -		/* Read from vendor specific registers, they are not documented
> -		 * but can be found in the Software Initialization Guide. Only
> -		 * revisions >= A0 are supported.
> -		 */
> -		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
> -		if (ret < 0)
> -			return ret;
> +		if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2221) {
> +			/* Read from vendor specific register, they can be
> +			 * found in the sample source code of the Q222X API
> +			 */
> +			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfcd9);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			/* Read from vendor specific registers, they are not documented
> +			 * but can be found in the Software Initialization Guide. Only
> +			 * revisions >= A0 are supported.
> +			 */
> +			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
> +			if (ret < 0)
> +				return ret;
>  
> -		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfc88);
> -		if (ret < 0)
> -			return ret;
> +			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfc88);
> +			if (ret < 0)
> +				return ret;
> +		}
>  	}
>  
>  	return ret & 0x0F;
> @@ -229,6 +244,16 @@ static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
>  	return 15;
>  }
>  
> +static int mv88q2221_probe(struct phy_device *phydev)
> +{
> +	/* Set detection threshold slave master */
> +	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
> +	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0a28);
> +	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0c28);
> +
> +	return 0;
> +}
> +
>  static struct phy_driver mv88q2xxx_driver[] = {
>  	{
>  		.phy_id			= MARVELL_PHY_ID_88Q2110,
> @@ -243,12 +268,27 @@ static struct phy_driver mv88q2xxx_driver[] = {
>  		.get_sqi		= mv88q2xxxx_get_sqi,
>  		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
>  	},
> +	{
> +		.phy_id			= MARVELL_PHY_ID_88Q2221,
> +		.phy_id_mask		= MARVELL_PHY_ID_MASK,
> +		.name			= "mv88q2221",
> +		.get_features		= mv88q2xxx_get_features,
> +		.config_aneg		= mv88q2xxx_config_aneg,
> +		.config_init		= mv88q2xxx_config_init,
> +		.read_status		= mv88q2xxx_read_status,
> +		.soft_reset		= mv88q2xxx_soft_reset,
> +		.set_loopback		= genphy_c45_loopback,
> +		.get_sqi		= mv88q2xxxx_get_sqi,
> +		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
> +		.probe			= mv88q2221_probe,
> +	},
>  };
>  
>  module_phy_driver(mv88q2xxx_driver);
>  
>  static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
>  	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
> +	{ MARVELL_PHY_ID_88Q2221, MARVELL_PHY_ID_MASK },
>  	{ /*sentinel*/ }
>  };
>  MODULE_DEVICE_TABLE(mdio, mv88q2xxx_tbl);

