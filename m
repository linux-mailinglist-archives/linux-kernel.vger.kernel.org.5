Return-Path: <linux-kernel+bounces-3424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437B816C16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC44E1C230C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42331A594;
	Mon, 18 Dec 2023 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAqVVmws"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCE1A289;
	Mon, 18 Dec 2023 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so14940105e9.0;
        Mon, 18 Dec 2023 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702898383; x=1703503183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5n5729EOzdXeaDBJQbuOs1rZ+Vdmdqpq3oeECYilXc=;
        b=WAqVVmwssoxeBizXyplI8QKENpKheRkAVVXyyXH2QWjiFFm2TDQWSJKmIvQRjHqHjJ
         A/Fwu8vHurnxwaBMHgDt/JyHXyXUvNoufhcf2RYkOE6w5mqNSPmmQPTdtRQuPTfJFmc4
         vwhlgbqQgJM/M4VXCUoGd7I6jb2RLUnl4o/a5tay3Hn9HiE3A6xYTxk/FsSJN14pAEb5
         RaAisJ44soPJIaJEioq1XrtMNy3fxhO8/Hlg8tNvh1OaBWEXjzqtppgY3oNiCtSG30//
         mGORHYQeX8EHzHLNRCQM5iugL7nmaV8M54RCQvK1g/ojTprpHt0XUUD7ued0Ef0ywL+Q
         gYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702898383; x=1703503183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5n5729EOzdXeaDBJQbuOs1rZ+Vdmdqpq3oeECYilXc=;
        b=iXN2RBnYnVyN0pCJ1m0B/F4t4uHJZunzu8xQwP5poS+ShFxC+cT+J6FmKJUDebt0Sk
         ZLKJvW3gcHsFUPIr78t42UBMc6SiP+dat5IakLvB5fUYbu1c/hoi88/MTgB/SdBmvsXS
         Ntf6AYnUjJwpVLFQZ9YmC+k3QIRk8+NzRgTh30ABEHqSkVXWFmZneklDvXuuS5Pr7dAg
         ql87PLfWK+FlKPwaXGB/6JeqehWHvknCct5Qf0V5G4h2bc8aRJDZdmfqFamSPu1m3IvZ
         igiNbWIb+vRoU35A/CpDzbT9dUe9etXwpRO7dJMYJw+9Y2xnfU7ycbNLeeCOueZoFhsX
         1flw==
X-Gm-Message-State: AOJu0Yzu0KKLDsyI1AKTrwuzwGaXGDxroiNXqYckICxHZ/D5/wF8C/cE
	QKRY8fRB0uGb5RnhXKrNzqA=
X-Google-Smtp-Source: AGHT+IEppZ71ikMbMgoJRJrf1Z3A2CQGa+4kbg2ESzX2nbAn3Wk7vlt2e2rQHcuk5fFyQxu/2GFhDw==
X-Received: by 2002:a05:600c:b50:b0:40b:5e26:237f with SMTP id k16-20020a05600c0b5000b0040b5e26237fmr7694647wmr.48.1702898382382;
        Mon, 18 Dec 2023 03:19:42 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:887d:230f:8633:4d97])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm41919960wmq.43.2023.12.18.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:19:38 -0800 (PST)
Date: Mon, 18 Dec 2023 12:19:32 +0100
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
Message-ID: <ZYAqxPZHICtZO15O@eichest-laptop>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
 <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
 <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218090932.GA4319@debian>

Hi Dimitri,

On Mon, Dec 18, 2023 at 10:09:32AM +0100, Dimitri Fedrau wrote:
> Am Sun, Dec 17, 2023 at 02:50:49PM +0100 schrieb Stefan Eichenberger:
> > I also tried to make the 88Q2221 work but didn't find the time yet to
> > write a clean version yet. My last minimal patch looks as attached
> > bellow.
> > 
> I probably will also get a 88Q2221 PHY, but it could take some time.
> When looking at the reference code the only difference for the 88Q2220
> and 88Q2221 seems to be an additional init sequence with 28 register writes.
> Remaining code seems to be identical. Am I right ? If yes we can use the
> same code base here. Besides that it seems that both PHYs share the same
> PHY id and are only distinguished by the "Secondary ID Register".

I think the init sequence is the same for both PHYs. At least they share
the same reference manual and the API User Guide.

> > I think the main thing to make the PHY work is to call this
> > sequence to set the master/slave detection threshold:
> > 
> > /* Set detection threshold slave master */
> > phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
> > phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0a28);
> > phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0c28);
> > 
> > Without this sequence the PHY does not work. I was also wondering as
> > Andrew wrote why we write twice to the same register. My assumption is
> > that 0x8032 is some kind of selector for a subregister while 0x8031 will
> > set a 32 bit value. Unforunately, I also didn't get that information
> > from Marvell and it is just a wild guess. Please also note that calling
> > the sequence in the probe function (as I do it in the example below) is
> > definitely wrong, it was just a quick and dirty test I did because I
> > wanted to know if it is enough to call it only once.
> > 
> You are maybe right about your guess. Without the init sequence at all I
> was able to get the PHY work with a fixed setting (100Mbit/Master).
> Maybe it was due to bootstrapping the pins of the PHY. But still I'm not
> getting the point. What are we going to do ? Do we want to strip down or
> generalize the init sequence ? There is probably a reason for such an
> annoying large undocumented series of register writes.

The documentation is really annoying, I agree. I would propose to try to
keep the driver as minimal as possible. If we see that something is not
working, we can still add it later on. Maybe this helps to get a better
understanding of what the registers do. Further, they always do a full
initialization when they switch e.g. from 100MBit/s to 1GBit/s. This
definitely seems to be unnecessary.

> > Are you able to test everyting with the upstream kernel? I'm asking
> > because I have to backport a lot of stuff to a downstream kernel 5.15
> > from NXP to test the 88Q2221. 
> > 
> I'm testing with the upstream kernel, no problems so far. Didn't have to
> backport anything or test on another kernel. First version of my driver
> was also on NXPs 5.15 kernel. Gladly you already upstreamed some T1
> specific code which helped me a lot to reduce code size.

That's good to hear. The 88Q2221 in my setup is connected to an S32G274A
from NXP and unfortunately that one doesn't have proper upstream support
yet.

> > Further, are you able to verify that autonegotion works? Somehow for me
> > this never really worked even when using the example sequence from
> > Marvell.
> > 
> 
> Autonegotiation works fine, didn't have any problems. I'm using the
> 88Q2220M rev B0. I test it with a Media Converter, the NETLion1000 C2T and
> with another 88Q2220M PHY. What do you use for testing ?

I have to try it again. I'm using the Goepel Media Converter (EasyCON)
and I'm pretty sure autoneg works on the Media Converter but somehow not
on the PHY side. It could be that this is because of one of this
undocumented registers.

Regards,
Stefan

