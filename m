Return-Path: <linux-kernel+bounces-2384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E747815C11
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5E01F221B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D673358BD;
	Sat, 16 Dec 2023 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChoXgljS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29B3588C;
	Sat, 16 Dec 2023 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c55872d80so16376175e9.1;
        Sat, 16 Dec 2023 14:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702764713; x=1703369513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFxvDNzq/a/57fWqrc0hFxj0N99OnhOBGr8fli8AnDk=;
        b=ChoXgljStYMADXJw5qY2jmmqZAyCw/lDd+1sSt0lftTNjHEhmhWsOubh1FxOukcWJ6
         8gE/D+EbiGjkGMXIrxB50gcjjdEShAammsnnGZtEaXYzuPTrxPEwgy/7/amJeTRHXgPc
         49XKduMow1DiYzcMBKe/i3K16pHQM3oRkqapCEQboqu/FC9UNmjRZQpaKMzBp1GuQD60
         4T+pNdDLbBZbXN9ezTT30M7j3yI/7GtHxmXT2FZARExm39cRLzu3VI19fcEI3ce0IZIV
         ECuepvjh5BdmPz7+QbFJlaugulM4axJyvGjz/fEMZDvqzq+dE+sgzVQxIsSlsG3PSM+T
         2n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702764713; x=1703369513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFxvDNzq/a/57fWqrc0hFxj0N99OnhOBGr8fli8AnDk=;
        b=vRtIu2UWTNOhWFGS9yiW9XOykaHSXNXhZh3qtrfVfx8tbQ32ETNWh5f8ctya1gco4/
         5kISMgloLdEkyDOwtDdAUoQeVctf764ewXZx8T44qXLIhKc2se7IbszgU4aoTL+2Acw8
         fLTaijUJ/Z1/ZcIfbPt4tB+PMFv+UC+pCNqp/loyHlcHX72PQ2OMa0/e/fwR/HlTsj9r
         c178FESS7HpushK6LgepOHjH8tKTlX2EOiuXCvz18CVDOGYBLyffn+AhCwRHhbVBvSTO
         wTl23Z2NaHk+g1rtPVMDpMQp3tushA/1+g3uljZiUmSxou+F5F3sKs58dSzB33oBvpgb
         aNTQ==
X-Gm-Message-State: AOJu0YxvztWyQfJ01YOPXauBmyYgpnxErVoHT/uSaMetwdS3Wd8NE4Ow
	sW8Whhu8arXZeflAsjGtePQ=
X-Google-Smtp-Source: AGHT+IE+jkGzSKkDQZ6/DtJ39jl9N7HMf0sbJIX4/sOXzrcaDY0xsxy2zk0oK56xGrfpo4DSknmq9Q==
X-Received: by 2002:a05:600c:3b99:b0:40b:4072:54de with SMTP id n25-20020a05600c3b9900b0040b407254demr6835048wms.13.1702764713349;
        Sat, 16 Dec 2023 14:11:53 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id fk10-20020a05600c0cca00b0040b3d8907fesm36017851wmb.29.2023.12.16.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 14:11:53 -0800 (PST)
Date: Sat, 16 Dec 2023 23:11:51 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <20231216221151.GA143483@debian>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
 <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>

Am Sat, Dec 16, 2023 at 05:46:32PM +0100 schrieb Andrew Lunn:
> > +static int mv88q222x_config_aneg_gbit(struct phy_device *phydev)
> > +{
> > +	int ret;
> > +
> > +	/* send_s detection threshold, slave and master */
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xa28);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xc28);
> > +	if (ret < 0)
> > +		return ret;
> 
> Same register with two different values?
>
Just copied the init sequence from sample code provided by Marvell.
I don't know if its a mistake. There is no documentation on this.

> There are a lot of magic values here. Does the datasheet names these
> registers? Does it define the bits? Adding #defines would be good.
> 
Datasheet is not naming them. I once asked Marvell Support for
documentation on the init sequence and what purpose each register has.
Just got the answer to use the sample code as it is.

> > +static int mv88q222x_config_aneg_preinit(struct phy_device *phydev)
> > +{
> > +	int ret, val, i;
> > +
> > +	/* Enable txdac */
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8033, 0x6801);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Disable ANEG */
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Set IEEE power down */
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x840);
> 
> 0x800 is MDIO_CTRL1_LPOWER. What is the other? It seems like a speed
> selection bit?
>
The other is MDIO_PMA_CTRL1_SPEED1000. Will fix this in V2.

> 	  Andrew

