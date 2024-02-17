Return-Path: <linux-kernel+bounces-70117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176885939A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB841F21D52
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3CA80051;
	Sat, 17 Feb 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S52fd1MV"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F17E567;
	Sat, 17 Feb 2024 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212176; cv=none; b=e6QDhNq+j0lRzBSTrBZ8adFhtoTLVTvqGFRyboGQIqmJlFIoL6J4yLf1DYr4TF2pnBcvQ0cRnJbXNttauJgyDl/ZZ1yngaSn9x4KFfUPVQoTB6lS2lGdck+0ffRZ7prWy7U/+6YE5gfbezJBS+1hLRr6fY0/5ua0YCENoqyZdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212176; c=relaxed/simple;
	bh=a+QvVBjsGmqPcbi3qCCaAJe48zdumCLnTL6lnP3CrXo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6tOMRRKd4PBOVzcpY+m/5sMFrYA6EbhkL10gp7VFaYytWlg4t/+fGo0U8QzDk73ogSVsTU3jzbKDj+lVzOeACqHn5XP2zhvRTS2u+KjhEBB8uV7+P6b50yQgVx8hoOBz04WD+iMG/GLpwhlO8xUmWC7c3HDr3UYLOsQQIOE5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S52fd1MV; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbc649c275so1720958b6e.0;
        Sat, 17 Feb 2024 15:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708212174; x=1708816974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cbH9uymS/8c7/s6JqpxYO8BrELFkxi0FtyBb1T3F1as=;
        b=S52fd1MVOILXemrpWPEJMFq8Q36eBLd/0k3ncgIyxnnJE+gXl+FJNJYnTAuuVuhf7D
         QKR3P+3QtgXYpjTaQZpOlaRlkPp+w9yPzOWr088AtzQB3O0kMcppPjYCZ6lbKMpSzaAe
         OPbFEgzeiA9CPK5IjUiXdyi/8FvArIS+G2XQ5RLFoW+2JyyWqeOAEBFbpJN6n0C/q/XM
         pTWh+LCq0+SaAyo1DzcTJGIQgQECCTczl9Yh019KlC86DJoUtZ+LyAm+Taj9qabr7RX/
         AQA6qtXoymnSys897laaAHjLc+wQEiNt9f3CFFP5I94/lwHVqhSniAlgqFjk4kQzOGbH
         Bjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708212174; x=1708816974;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbH9uymS/8c7/s6JqpxYO8BrELFkxi0FtyBb1T3F1as=;
        b=hVOTA2pEdaXeEGWikLHPKTCmk0tf/q9VYEGVgXo9zriIK7iW/dIQjUlr9JJyLUWgjk
         Mkskoe4chjuuy1lmMVMeSPqAdUi5VKssBMdfdloxZ/6DAULYNJtxBSJZvtK/lYLRQR1b
         eVWf5iQVFHpYQED43mwWsa0q9yZXwdbeiAmjAMlGH3WkdG7sT7b89uApBxMTUQyoMzPK
         Je4SHoCf+2Zg6hFsnmVbZ+5llmYJOdjuVSGkPE8tfD1ICOS0mdKx3BxylP8hKAbaCXaf
         j20LJzexqobaAd89ipY7UStTIVxY4aL5khe5T8hXY2W3nZHk5NgMrDZw88hK1Ku91h3k
         BxHA==
X-Forwarded-Encrypted: i=1; AJvYcCVMhH6+MroJUWpcw1jBtBGnV1Tq17p2EOPLCsfsofTzHxq4DP5+Q/K/SffZFpDVDZ6PQQM84om4xDN4w4Y0dgCOfuWLiW9ZpS/4N/vOkix/6owiChGz3Iiwo5Lv49Ogogtv/T4taFYaLsMF26PLAoBcB/PJ1lpFfin98RgINGZ5ogFd8l79QlnpeS7OQZgTinKfU3fG4fWCgP/p/HRMrwN7x1Mi
X-Gm-Message-State: AOJu0YyHbH3dbSHMt9ooDamFz6+ebOl5fRKXzKb3Hr3OluH8tNHbT12H
	CPKqlHsZ4GrRGe7Kq+MsT+AHybn85vU8hJUem/EO2qBSzsNlm0kn
X-Google-Smtp-Source: AGHT+IGQKGBOkmuDc5gI2jIBVXWXAkHQ3X9wz3V5z8Dx1FdEbbwkWxIBFI2JRf0mUeEdUoy2E0VubQ==
X-Received: by 2002:a05:6808:2a4f:b0:3c0:3b90:ae1f with SMTP id fa15-20020a0568082a4f00b003c03b90ae1fmr7196758oib.49.1708212173842;
        Sat, 17 Feb 2024 15:22:53 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id qm12-20020a056214568c00b0068c88a31f1bsm1518837qvb.89.2024.02.17.15.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 15:22:53 -0800 (PST)
Message-ID: <65d13fcd.050a0220.88fe3.665f@mx.google.com>
X-Google-Original-Message-ID: <ZdE_xfQcwQ6hninK@Ansuel-XPS.>
Date: Sun, 18 Feb 2024 00:22:45 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com, Peter Geis <pgwipeout@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>, Xu Liang <lxu@maxlinear.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, rust-for-linux@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 0/3] net: phy: detach PHY driver OPs from
 phy_driver struct
References: <20240217194116.8565-1-ansuelsmth@gmail.com>
 <ZdEOpB1oVDE8+Qhq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdEOpB1oVDE8+Qhq@shell.armlinux.org.uk>

On Sat, Feb 17, 2024 at 07:53:08PM +0000, Russell King (Oracle) wrote:
> On Sat, Feb 17, 2024 at 08:41:11PM +0100, Christian Marangi wrote:
> > Posting as RFC due to the massive change to a fundamental struct.
> > 
> > While adding some PHY ID for Aquantia, I notice that there is a
> > big problem with duplicating OPs with each PHY.
> > 
> > The original idea to prevent this was to use mask on the PHY ID
> > and identify PHY Family. Problem is that OEM started to use all
> > kind of PHY ID and this is not doable, hence for PHY that have
> > the same OPs, we have to duplicate all of them.
> > 
> > This is present in Aquantia PHY, but is much more present in
> > other PHY, especially in the BCM7XXX where they use a big macro
> > for common PHYs.
> > 
> > To reduce patch delta, I added the additional variable without
> > adding tabs as this would have resulted in a massive patch.
> > Also to have patch bisectable, this change has to be in one go
> > hence I had to use this trick to reduce patch delta.
> > 
> > Other solution to this problem were to introduce additional
> > variables to phy_driver struct but that would have resulted
> > in having 2 different way to do the same thing and that is not O.K.
> > 
> > I took care to compile-test all the PHY, only exception is the unique
> > RUST driver, where I still have to learn that funny language and
> > I didn't had time to update it, so that is the only driver that
> > I think require some fixup.
> > 
> > I posted 2 example that would benefits from this change, but I can
> > find much more in other PHY driver.
> 
> Would it make more sense instead of this big churn, to instead
> introduce into struct phy_driver:
> 
> 	struct mdio_device_id	*ids;
> 
> which would then allow a phy_driver structure to be matched by
> several device IDs?

Yes that was an alternative idea, but is it good to then have 2 way to
declare PHY ID?

Also the name should be changed... Maybe an array of a struct PHY_ID,
name that ends with a sentinel?

> 
> We then would not need to touch any of the existing drivers initially,
> and a later cleanup could be to identify those where all the ops are
> the same for several phy_driver structures, and convert them over.

We have many PHY that already have macro to define the same OPs and
change only name PHY ID and mask.

-- 
	Ansuel

