Return-Path: <linux-kernel+bounces-70118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CFA85939E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158A22830B1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9114980059;
	Sat, 17 Feb 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+qTCYj2"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A627E59E;
	Sat, 17 Feb 2024 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212479; cv=none; b=lC16T0Ji+id8c0yST1E5/lzG55cagAY7UcLtdUaajU45XBqmhw9g21fTpsB2VCWWLKdT4NStuOrlQAtQCxvmuJPnDF1/IZwH3Id4P2fe3ePcx9bjpWOS+2/3airL3VBYNTF0wV/XMYf5AYN4grEUZ7685vGfAE1nXR6lpiotZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212479; c=relaxed/simple;
	bh=7UuNb3p0WlJLKXoD3Rm8wPRkK7OMhKHV4Rs9IWYizhk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHZJ2SKk2bcwEYSlILIb1PGyEkA1qv68RudJ9/mh7RVBoMQ7uUX+mM0J+PDsic5pEnjqLxlquaYCxw1aGA2MuGaAaMbeQKAPAhaqENuKs/O5f8EyOHbooSOf5roYjtiws+G67ewC3iPNnOc4O8R2OByc56DV7J7gR5vPGGTvkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+qTCYj2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d01faf711so1742659f8f.1;
        Sat, 17 Feb 2024 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708212476; x=1708817276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yMrVfGL8XXE/jIciEU8DHBE7OsIbpwslFPo8E5272EE=;
        b=U+qTCYj2byQ6isLC0E2qhUWxtcQbRTnJUc94OyxglkpwSIJvaM3diMHMrS+PQ7HF2G
         VfDBi0Z9FCKDW6jH5b0cGbFd4sN7tYCBxYv63v0/OrsnAQZhFO1hlVpLiHBWlKq0wP0H
         eDJadabVpyFQ57kAoBCLz7QnqWGonKLHQO+m4Rj300ZIvQqSkE0o7bPuPtadhnLOtwlE
         znzX7DJVViRgDHjSIIuq5XEXpqh/v1sb1hvDk6mfJ7BbfInlmM4Z+eZHuYDU4vzZhPB7
         TRY1bkQ5warxxDq7p6B/YxIB53jAi7BrkQDslurSNUNz8xCGwQMuR81phMIK2FnPPfGJ
         0ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708212476; x=1708817276;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMrVfGL8XXE/jIciEU8DHBE7OsIbpwslFPo8E5272EE=;
        b=qWYy0cUuBA33qf79UdUcFWMy5B8tSpnkrIVAE7VCFWusWCMwpacwji8tWiaMN/0E0y
         xtgAHcmwZjkSA2edLc73OPTz2p4qJzqL8XIUTdPT5NsWfi0Ub6Xm4nIR9VAp8VWeM2fV
         WETgXO2Oam/9CpXK2Tj1nqUc0xThd+BiujezF3yCU+SUmSNrJRkNQudTEG9I7gKO0k6B
         2rviItQTFScbnny58w01KbyAcnb+H1FJceLiRmDy+Vfo/IymIGJgtgTqfk5rzZqiKf0J
         /bld7/2B8+nQzuB8c9R0PsNbY7SvdTjy3dp3gXHz/vlEZXuUXVO+1OiYFNlXNAYFqwW/
         dZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCW/qPLyVk1wE+fhgCI72bQ0ulh8Xxz5tFVaf3aqD+j7nXuVm4r+rTXdvubHFL8uY0oUdJZvy0zPEiSRIkuVFHOhQvKGisrXFHNjSR1W6TGULvtNoQ2n8clUmoGuwnGlVB04sWjn7Bpc1stF2mkF9OtxXKzbCJgkpMMdTXjk358OD2SeTfya8saBezhu1zZb9PYtpHP62m1Ih498XArps51VXxda
X-Gm-Message-State: AOJu0YxBxetytNYNuxhzJovQvf2iRFD76ESzJobvLb4MNGsJ1h22WIHe
	GNYeYvbXCSTXgZrfvuDINuH0Olyw53XNM3kDNtSwN2Q73hEMAYB3fLTmvnnKOgfoVw==
X-Google-Smtp-Source: AGHT+IG06jEr4fsAxNzMuyQQWttNohqo0lQwW0nhEwlH4qFAtb/RroN/efm+DbY1uKKfB0jPXgmHPQ==
X-Received: by 2002:a5d:588f:0:b0:33d:2b3d:a02e with SMTP id n15-20020a5d588f000000b0033d2b3da02emr2093502wrf.46.1708212476161;
        Sat, 17 Feb 2024 15:27:56 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m2-20020a5d6a02000000b0033d071c0477sm5962470wru.59.2024.02.17.15.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 15:27:55 -0800 (PST)
Message-ID: <65d140fb.5d0a0220.81be3.7138@mx.google.com>
X-Google-Original-Message-ID: <ZdFA-ehmbYzM3DvW@Ansuel-XPS.>
Date: Sun, 18 Feb 2024 00:27:53 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
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
 <a804e21d-fe1d-41e8-90fd-64b260c9bcc7@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a804e21d-fe1d-41e8-90fd-64b260c9bcc7@lunn.ch>

On Sat, Feb 17, 2024 at 11:21:44PM +0100, Andrew Lunn wrote:
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
> 
> To me, this makes the code look ugly. I also expect many text editors
> which understand indentation will be unhappy, saying the indentation is
> wrong.
>

Yes, it was done to limit the patch delta, if I had to account for the
tab for each new section we would be in the order of 2000+ changes I
think.

> >  64 files changed, 737 insertions(+), 291 deletions(-)
> 
> These statistics are not good. If you had deleted more lines than you
> added, then maybe it might be an O.K. idea.
> 
> Sometimes KISS is best.
>

Well IMHO these stats are a bit flawed, the additional code is really
just extra check if ops is defined and the new .ops variable in each
phy_driver.

If you check patch 2 and 3 you can already see some code is removed.
Also while minimal the final .o produced results in bcm7xxx going from
53kb to 45kb and the aquantia driver from 48kb to 45kb.

I understand that this major rework might be too much, so I think the
only way to handle this is with introducing support for declaring
multiple PHY ID for one phy_driver struct.

-- 
	Ansuel

