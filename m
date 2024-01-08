Return-Path: <linux-kernel+bounces-19400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10FD826C61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48DC1F222B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279114287;
	Mon,  8 Jan 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ8D/JVE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D714265;
	Mon,  8 Jan 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28bf46ea11so295229366b.1;
        Mon, 08 Jan 2024 03:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704712611; x=1705317411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SezONTGW0o9omRljlmdl8+OgfSQw/IsfLT4LzpWIjaE=;
        b=jJ8D/JVEMsFQWie1icZ0gl+bJbVdvrkKOZqdRxhSk9drmojUk93EQJt/F6qxnlrV3f
         ocrwq1KbBLvMOL/XfWM4sUWqUnj3nchEbR2CKGGydUOKe/8miCjAnJyeWbtnup/6BG4n
         RO+RQ8756w9LNpyBOF/EcMqYYX0pEOBaE7XWfNvhu+KFzG55marcLcwaUyMBvY023w8O
         j388tfJtEwsJXjwlccFoe3dmmGBMCsfH4nyiTVWKPWthso7HBct+KgdLkKDbSf/NNz5I
         2ZQq1pkQBMw74a/ai8IqXqTRlYBXb6WhWxUfi0F/dfJynyX+hYp2MbQHkEghJzvqnQLV
         h8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712611; x=1705317411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SezONTGW0o9omRljlmdl8+OgfSQw/IsfLT4LzpWIjaE=;
        b=snT8Mvjs0replLfsW0DjsMJRIGY0lNbYCFbYstiH/aOfxXL2I+miLLecJ0Xcu5O6EQ
         plNsoz4bHs80N6++OAGS592Mxs/KTHeq9KuLXpCRnFdRLSZNOinZHbcO+GqFVrj6RX+d
         CI5YywuNQrZtwXfmyYNHvd9rtx9iFABqt2nrNJeNZZaXJXMpMXZ9mrV/d701QgNmThff
         UsoAOFbxvZKzFy3AstGavxbrYcngOBqSnU4s+zRiqTT4HAib61rFVBJMCSaalif2NnkP
         SUVFss4GOlQ5zhbAxa0QPhC4VvyFjSMzoQMEito5XaFn0rYO5nSwVixxr6s3/Ec72GJK
         ESmQ==
X-Gm-Message-State: AOJu0YyzQNGjiSvhgeVPFYhhRxohsIBtkBaYmTiecMZSVK//KuRfdN79
	6nQJKsoC1Ac8bhsrsQVhQdI=
X-Google-Smtp-Source: AGHT+IFxLBkiCxEuJUmp6SzUMwj4CVUopJsybGUfY92utzFVyhX8D6uD+Xn9+NEtMcBiScdIHZrDHg==
X-Received: by 2002:a17:907:2cd1:b0:a28:c148:d53d with SMTP id hg17-20020a1709072cd100b00a28c148d53dmr3301131ejc.66.1704712611430;
        Mon, 08 Jan 2024 03:16:51 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id d26-20020a170906175a00b00a27c463fbdesm3832568eje.211.2024.01.08.03.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:16:50 -0800 (PST)
Date: Mon, 8 Jan 2024 12:16:48 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 5/5] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <20240108111648.GA28777@debian>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <20240108093702.13476-6-dima.fedrau@gmail.com>
 <20240108110844.GH132648@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108110844.GH132648@kernel.org>

Am Mon, Jan 08, 2024 at 11:08:44AM +0000 schrieb Simon Horman:
> On Mon, Jan 08, 2024 at 10:37:00AM +0100, Dimitri Fedrau wrote:
> > Add a driver for the Marvell 88Q2220. This driver allows to detect the
> > link, switch between 100BASE-T1 and 1000BASE-T1 and switch between
> > master and slave mode. Autonegoation is supported.
> 
> nit: Autonegotiation
> 
Will fix it in V5.
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/net/phy/marvell-88q2xxx.c | 206 +++++++++++++++++++++++++++++-
> >  include/linux/marvell_phy.h       |   1 +
> >  2 files changed, 201 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> 
> ...
> 
> > @@ -29,6 +36,42 @@
> >  
> >  #define MDIO_MMD_PCS_MV_RX_STAT			33328
> >  
> > +struct mmd_val {
> > +	int devad;
> > +	u32 regnum;
> > +	u16 val;
> > +};
> > +
> > +const struct mmd_val mv88q222x_revb0_init_seq0[] = {
> > +	{ MDIO_MMD_PCS, 0x8033, 0x6801 },
> > +	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
> > +	{ MDIO_MMD_PMAPMD, MDIO_CTRL1,
> > +	  MDIO_CTRL1_LPOWER | MDIO_PMA_CTRL1_SPEED1000 },
> > +	{ MDIO_MMD_PCS, 0xfe1b, 0x48 },
> > +	{ MDIO_MMD_PCS, 0xffe4, 0x6b6 },
> > +	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0 },
> > +	{ MDIO_MMD_PCS, MDIO_CTRL1, 0x0 },
> > +};
> > +
> > +const struct mmd_val mv88q222x_revb0_init_seq1[] = {
> > +	{ MDIO_MMD_PCS, 0xfe79, 0x0 },
> > +	{ MDIO_MMD_PCS, 0xfe07, 0x125a },
> > +	{ MDIO_MMD_PCS, 0xfe09, 0x1288 },
> > +	{ MDIO_MMD_PCS, 0xfe08, 0x2588 },
> > +	{ MDIO_MMD_PCS, 0xfe11, 0x1105 },
> > +	{ MDIO_MMD_PCS, 0xfe72, 0x042c },
> > +	{ MDIO_MMD_PCS, 0xfbba, 0xcb2 },
> > +	{ MDIO_MMD_PCS, 0xfbbb, 0xc4a },
> > +	{ MDIO_MMD_AN, 0x8032, 0x2020 },
> > +	{ MDIO_MMD_AN, 0x8031, 0xa28 },
> > +	{ MDIO_MMD_AN, 0x8031, 0xc28 },
> > +	{ MDIO_MMD_PCS, 0xffdb, 0xfc10 },
> > +	{ MDIO_MMD_PCS, 0xfe1b, 0x58 },
> > +	{ MDIO_MMD_PCS, 0xfe79, 0x4 },
> > +	{ MDIO_MMD_PCS, 0xfe5f, 0xe8 },
> > +	{ MDIO_MMD_PCS, 0xfe05, 0x755c },
> > +};
> 
> nit: mv88q222x_revb0_init_seq0 and mv88q222x_revb0_init_seq1 seem
>     to only be used in this file. Perhaps they should be static.
> 
> ...

You are right, will fix it in V5. Thanks.

Best regards,
Dimitri

