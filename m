Return-Path: <linux-kernel+bounces-2618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A2815F85
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E9728285D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E54439F;
	Sun, 17 Dec 2023 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5LJdFJ/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99444398;
	Sun, 17 Dec 2023 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso27574055e9.1;
        Sun, 17 Dec 2023 05:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702821052; x=1703425852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICvtQdGfPaFWjFHYx5GmMKJ3nabe2JosWfeIvlfNizg=;
        b=X5LJdFJ/c5RIBpBIXUWzggBXKcJJxVu+pFH8VYt8ljcUold8kNnASB/zSQZKitgRR2
         27id93pEG9Gch2KMXJwB9HrzmS+pAFEFBRWq6d7lpGUjwZq7Es/6EkOWqi0ZFMYFt27g
         5wQX6QpoBTlnhI+sRmoyGopKb5zcGAhYhkLg+VMqWhvsjA72B8l8KBODYD9yRIprv0+E
         0rePJsr7FsDpTkiWxWn1KRaqmqn5wwux/vWXp58+cksztbUbhznA7qqLX2umcXu/Q4Qf
         eYS/50gBTc9bo+7kv2vIUEN782aOKmdzIvFNaBJ1Bic0p80XHAgUiiNIcSUPfORgSCON
         sUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702821052; x=1703425852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICvtQdGfPaFWjFHYx5GmMKJ3nabe2JosWfeIvlfNizg=;
        b=Gc9nJQkwgxLSSe4Ru6zis5hWt9uOAqsZNps9LvamYi5fOa9IKDZ5E4VKD+LeS9Uxzn
         Hol9FeSHdH5NaoAV8RgPymLxgni/Bf8JMWX1SQXexjeayYaH0JInzl4OLH+Cmjfd7VxX
         UcVGcx8SZk6Jx6LA9Zu5K1Y7W6r0q0TAW5r7igqu3EXbcwjp287J1IrXMMqxjg06teV4
         IA79V8Tpiua8+mChCxm4+Gv0raEY5xpMpXFL2lndJdcQaRpPJ8+AoZSxM2eoy5NpnWAr
         7/mCpi2OKysu7QMkcJH0fgi4mNEMQRflYbpDPs/SkQqVchrn74wPXJ0wL5isxUl4uNcX
         tWPw==
X-Gm-Message-State: AOJu0Yw0+gjB+ji17fojbLP2w+6Dc08dTK5tqGJTigfbBGBfoIvx/Xww
	3IkpIl+nL+fuJanMOl+clio=
X-Google-Smtp-Source: AGHT+IHic1xpcdt6VSPIjMTyJqvegeP17Kyhl5kC32DwWbYTrOCh5a6a1pc20yCFd/ntgBtc5y9uUA==
X-Received: by 2002:a05:600c:1384:b0:40c:521a:5d11 with SMTP id u4-20020a05600c138400b0040c521a5d11mr5104466wmf.39.1702821051594;
        Sun, 17 Dec 2023 05:50:51 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:ba4e:4805:1a67:13c2])
        by smtp.gmail.com with ESMTPSA id fa17-20020a05600c519100b0040c46719966sm28658569wmb.25.2023.12.17.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 05:50:51 -0800 (PST)
Date: Sun, 17 Dec 2023 14:50:49 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <ZX78ucHcNyEatXLD@eichest-laptop>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
 <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
 <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217111538.GA3591@debian>

Hi Dimitri,

On Sun, Dec 17, 2023 at 12:15:38PM +0100, Dimitri Fedrau wrote:
> Am Sun, Dec 17, 2023 at 10:22:54AM +0100 schrieb Andrew Lunn:
> > > > > +	/* Set IEEE power down */
> > > > > +	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x840);
> > > > 
> > > > 0x800 is MDIO_CTRL1_LPOWER. What is the other? It seems like a speed
> > > > selection bit?
> > > >
> > > The other is MDIO_PMA_CTRL1_SPEED1000. Will fix this in V2.
> > 
> > It seems odd to set a speed, and power it down. But i guess you have
> > blindly copied the reference code, so have no idea why?
> >
> I agree, absolutely no idea. I already asked the Marvell support for
> any document describing the init sequence, but they couldn't help me.
> So I have to stick to the reference code. At least I copied the comments
> that were part of the init sequence, trying to give some meaning to it.

I also tried to make the 88Q2221 work but didn't find the time yet to
write a clean version yet. My last minimal patch looks as attached
bellow.

I think the main thing to make the PHY work is to call this
sequence to set the master/slave detection threshold:

/* Set detection threshold slave master */
phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0a28);
phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0c28);

Without this sequence the PHY does not work. I was also wondering as
Andrew wrote why we write twice to the same register. My assumption is
that 0x8032 is some kind of selector for a subregister while 0x8031 will
set a 32 bit value. Unforunately, I also didn't get that information
from Marvell and it is just a wild guess. Please also note that calling
the sequence in the probe function (as I do it in the example below) is
definitely wrong, it was just a quick and dirty test I did because I
wanted to know if it is enough to call it only once.

Are you able to test everyting with the upstream kernel? I'm asking
because I have to backport a lot of stuff to a downstream kernel 5.15
from NXP to test the 88Q2221. 

Further, are you able to verify that autonegotion works? Somehow for me
this never really worked even when using the example sequence from
Marvell.

Best regards,
Stefan

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 94a8c99b58da..15e82e8ff8f4 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -208,17 +214,26 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 
 		ret = ret >> 12;
 	} else {
-		/* Read from vendor specific registers, they are not documented
-		 * but can be found in the Software Initialization Guide. Only
-		 * revisions >= A0 are supported.
-		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
-		if (ret < 0)
-			return ret;
+		if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2221) {
+			/* Read from vendor specific register, they can be
+			 * found in the sample source code of the Q222X API
+			 */
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfcd9);
+			if (ret < 0)
+				return ret;
+		} else {
+			/* Read from vendor specific registers, they are not documented
+			 * but can be found in the Software Initialization Guide. Only
+			 * revisions >= A0 are supported.
+			 */
+			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
+			if (ret < 0)
+				return ret;
 
-		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfc88);
-		if (ret < 0)
-			return ret;
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfc88);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return ret & 0x0F;
@@ -229,6 +244,16 @@ static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
 	return 15;
 }
 
+static int mv88q2221_probe(struct phy_device *phydev)
+{
+	/* Set detection threshold slave master */
+	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
+	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0a28);
+	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0c28);
+
+	return 0;
+}
+
 static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		.phy_id			= MARVELL_PHY_ID_88Q2110,
@@ -243,12 +268,27 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi		= mv88q2xxxx_get_sqi,
 		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
 	},
+	{
+		.phy_id			= MARVELL_PHY_ID_88Q2221,
+		.phy_id_mask		= MARVELL_PHY_ID_MASK,
+		.name			= "mv88q2221",
+		.get_features		= mv88q2xxx_get_features,
+		.config_aneg		= mv88q2xxx_config_aneg,
+		.config_init		= mv88q2xxx_config_init,
+		.read_status		= mv88q2xxx_read_status,
+		.soft_reset		= mv88q2xxx_soft_reset,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= mv88q2xxxx_get_sqi,
+		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
+		.probe			= mv88q2221_probe,
+	},
 };
 
 module_phy_driver(mv88q2xxx_driver);
 
 static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
 	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88Q2221, MARVELL_PHY_ID_MASK },
 	{ /*sentinel*/ }
 };
 MODULE_DEVICE_TABLE(mdio, mv88q2xxx_tbl);

