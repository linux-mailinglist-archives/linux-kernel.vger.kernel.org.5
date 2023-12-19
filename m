Return-Path: <linux-kernel+bounces-4865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C39A818314
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813141C2359B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B065111BC;
	Tue, 19 Dec 2023 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkeyQFqt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AE12B70;
	Tue, 19 Dec 2023 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c236624edso46651055e9.1;
        Tue, 19 Dec 2023 00:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702973480; x=1703578280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8Gs6wfq42ExQfA4rP3ujdzmR9AiQsHO39Ghul5ya0c=;
        b=bkeyQFqtvy+MI+NdAYUHG7loFBlPh4qCVtujT2u7ZRpR1UoGmfVjaT9v5ia0ryzw5A
         gaC0y1Vp/+9dG8pElA/WdxBoTOwtd7VBElfwwKxl19dAqRQqavUrSyFpEJu/7edpO+mO
         sgWvVK7tUitwSZK8ff7kmmu12W0Oxx5exzWxDqheMfH2D9a5Kqe6vAzDSrrS+JH7mXvN
         A7FsMpuSNE4VKJCTC2RR8hnwUZ6FO98JrnwHIPu6JRZR3jMx2bySzXdlnXp7M6mJkJop
         EOWda5C5fnzSNnIouHHChQ0LtHvz+PvchF/9Kh9/r5XRZWUWL0QBDEvdvzj+45r8fhvU
         vJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702973480; x=1703578280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8Gs6wfq42ExQfA4rP3ujdzmR9AiQsHO39Ghul5ya0c=;
        b=E0vXwuA793/TDYnln9a1O4cR6KgF4FA6MhgWPjclzORRojOg/N+1Ww4VaaqolpG+pK
         QHgu/NTTClEsMoGxgtzhwZKn3JKbEAaCAXNLEKfec2m8lyov7usuqHuvJBQYg58sr6jW
         J2u6UUE/AwgrOLrKdiUMQNcLWB+f7FAOP5IOefi7MaoOt+aeRauIXRdgHt6FxRBP6NuH
         sxAgmruiBnmoj5+YfyGW0QllnTZ13AS2s6ZkW9FHJm7f9aWb0rScd4Z79/Ma+pi574os
         KDkFG3bIaFY2xlDajcOP0NPn603A/rxLGMXm0Z4XCPldZa/HGPXrwYE66ccWpjIK6ukE
         Ag1w==
X-Gm-Message-State: AOJu0YyBaeC7fy7LwG5THCv/BYyAH9xOR5JkgnqvwbLtvb0Ct2V0brQi
	hH0ag8ZKKMTa/H+3ebtOuXI=
X-Google-Smtp-Source: AGHT+IER+R2AqiYndhh2M+N0E04la5rCzrcGwPV93SPMmxlCRVByZPeMEkIzCtQr+JF+td5kKWujug==
X-Received: by 2002:a05:600c:2946:b0:40c:296e:7bfe with SMTP id n6-20020a05600c294600b0040c296e7bfemr9298924wmd.140.1702973479776;
        Tue, 19 Dec 2023 00:11:19 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040b45282f88sm1630600wmq.36.2023.12.19.00.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:11:19 -0800 (PST)
Date: Tue, 19 Dec 2023 09:11:17 +0100
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
Message-ID: <20231219081117.GA3479@debian>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
 <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
 <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
 <ZYAqxPZHICtZO15O@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYAqxPZHICtZO15O@eichest-laptop>

Am Mon, Dec 18, 2023 at 12:19:32PM +0100 schrieb Stefan Eichenberger:
> Hi Dimitri,
> 
> On Mon, Dec 18, 2023 at 10:09:32AM +0100, Dimitri Fedrau wrote:
> > Am Sun, Dec 17, 2023 at 02:50:49PM +0100 schrieb Stefan Eichenberger:
> > > I also tried to make the 88Q2221 work but didn't find the time yet to
> > > write a clean version yet. My last minimal patch looks as attached
> > > bellow.
> > > 
> > I probably will also get a 88Q2221 PHY, but it could take some time.
> > When looking at the reference code the only difference for the 88Q2220
> > and 88Q2221 seems to be an additional init sequence with 28 register writes.
> > Remaining code seems to be identical. Am I right ? If yes we can use the
> > same code base here. Besides that it seems that both PHYs share the same
> > PHY id and are only distinguished by the "Secondary ID Register".
> 
> I think the init sequence is the same for both PHYs. At least they share
> the same reference manual and the API User Guide.
>
I could add the init sequence for the 88Q2221 PHY. Then you could test
it on your side. Would this be helpful to you ? Did you already have the
chance to test the patch ?

> > > I think the main thing to make the PHY work is to call this
> > > sequence to set the master/slave detection threshold:
> > > 
> > > /* Set detection threshold slave master */
> > > phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
> > > phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0a28);
> > > phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0x0c28);
> > > 
> > > Without this sequence the PHY does not work. I was also wondering as
> > > Andrew wrote why we write twice to the same register. My assumption is
> > > that 0x8032 is some kind of selector for a subregister while 0x8031 will
> > > set a 32 bit value. Unforunately, I also didn't get that information
> > > from Marvell and it is just a wild guess. Please also note that calling
> > > the sequence in the probe function (as I do it in the example below) is
> > > definitely wrong, it was just a quick and dirty test I did because I
> > > wanted to know if it is enough to call it only once.
> > > 
> > You are maybe right about your guess. Without the init sequence at all I
> > was able to get the PHY work with a fixed setting (100Mbit/Master).
> > Maybe it was due to bootstrapping the pins of the PHY. But still I'm not
> > getting the point. What are we going to do ? Do we want to strip down or
> > generalize the init sequence ? There is probably a reason for such an
> > annoying large undocumented series of register writes.
> 
> The documentation is really annoying, I agree. I would propose to try to
> keep the driver as minimal as possible. If we see that something is not
> working, we can still add it later on. Maybe this helps to get a better
> understanding of what the registers do. Further, they always do a full
> initialization when they switch e.g. from 100MBit/s to 1GBit/s. This
> definitely seems to be unnecessary.
> 
You are right, but I would propose to stick to the reference init
sequence and make sure the PHYs works with our code and then work on
optimizing the code. We still can remove and/or document parts of it.

> > > Further, are you able to verify that autonegotion works? Somehow for me
> > > this never really worked even when using the example sequence from
> > > Marvell.
> > > 
> > 
> > Autonegotiation works fine, didn't have any problems. I'm using the
> > 88Q2220M rev B0. I test it with a Media Converter, the NETLion1000 C2T and
> > with another 88Q2220M PHY. What do you use for testing ?
> 
> I have to try it again. I'm using the Goepel Media Converter (EasyCON)
> and I'm pretty sure autoneg works on the Media Converter but somehow not
> on the PHY side. It could be that this is because of one of this
> undocumented registers.
> 
Are you trying with the patch I provided or your own code ? If you use
my patch you should wait until V3, because I found some problems with
it. Switching from 1000Mbit/s to 100Mbit/s in autonegotiation mode doesn't
work. I could fix it but the fix touches some code already upstreamed. So
I tried to push parts of it yesterday. I forgot to cc you, just used the
get_maintainer script. I will add you to the cc list. Until then you can
look it up here: 20231218221814.69304-2-dima.fedrau@gmail.com

> Regards,
> Stefan

Regards,
Dimitri

