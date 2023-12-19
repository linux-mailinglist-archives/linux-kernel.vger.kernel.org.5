Return-Path: <linux-kernel+bounces-4973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D2D81849D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF95F1F23EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722F13AFA;
	Tue, 19 Dec 2023 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8/6N720"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C091426E;
	Tue, 19 Dec 2023 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3364c9ff8e1so2332926f8f.0;
        Tue, 19 Dec 2023 01:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702978556; x=1703583356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tF4Z5Fm8wpvM9kENnxFg1GOt/6EcGOZ/wJLhLT6ong=;
        b=A8/6N720USRCMuQzrUBk+LLcu2NW7I8D+EawQamNA3suLw6o4DKh4LTAansLvqMBZU
         0gMF2d3H7B2s9FHVzR8qKijIqk/A8GbAbrS3ONLOfpDGPxdyz+khZBDtftxEcfG5LQas
         QqqFoYPUG5C+xfoPO0VWqBHqTsAV7hVDJKtHoy28et+5x2ra5xDB3EFSRfx/XoGTn8d2
         rmj6nZHFT5TfLhZz351hrQNJJKdiBULvDTNqyirTZUFKHsZPmwiWBuCQlEUaR9TP7iyd
         WMAzl/mDYjU5B9frKIhd7OQmw2i1Ay4dDxFjn3MDkFcJt4yynexmj3wR8XVkYSDOVnrd
         7Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978556; x=1703583356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tF4Z5Fm8wpvM9kENnxFg1GOt/6EcGOZ/wJLhLT6ong=;
        b=QVX15ZfEA9A9436XFq/cj/pbuoLig0x4Xh/FrdprzfTwybGwcPzVkG66Iz5MLIk/a4
         /Yu/ksHrkTkTHqH0n0mUBXwCUgAi0te2ODMSSB8wOoNlH3+hGK2n9TYGjfE1JZAG75N+
         V+9CKlulMmsKqKxxRBXFxfQOAS60GlT8VZvsJ3oVWRLpds7L/kDOhq+MNurWWGAfj+J4
         wbPR/CLUOZUpxSwu+P1TABSzGI5SK/Gk/Eq36N4EcPaoZYEJwK4Bb/NFpKEV6KCNIZzV
         J4lwuc4rchxiggS49tyNN7RifMtIhcVMCOe/gH3mgFdxwKxQmK+u356x8Rj8FU0BJNkr
         1ucg==
X-Gm-Message-State: AOJu0YzVK77C6Hzt9ZUdSibXkn9D3bP8C29mq9Yl/mIoLgsOlpIETIoC
	wqyv97HgVdDGBv/0kO0SNWk=
X-Google-Smtp-Source: AGHT+IGpyp8BSukk+UDTj5z5JREfSz+alb3sH2oD1oIeAeVYhnVaLCG4dGSSt7Mw7T4w4HS/AypSpw==
X-Received: by 2002:a05:600c:4f92:b0:40b:5e56:7b39 with SMTP id n18-20020a05600c4f9200b0040b5e567b39mr383986wmq.130.1702978556331;
        Tue, 19 Dec 2023 01:35:56 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id bh20-20020a05600c3d1400b0040d15dcb77asm1992713wmb.23.2023.12.19.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:35:56 -0800 (PST)
Date: Tue, 19 Dec 2023 10:35:54 +0100
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
Message-ID: <20231219093554.GA6393@debian>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
 <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
 <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
 <ZYAqxPZHICtZO15O@eichest-laptop>
 <20231219081117.GA3479@debian>
 <ZYFfzei3SJSts5E/@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYFfzei3SJSts5E/@eichest-laptop>

Am Tue, Dec 19, 2023 at 10:19:41AM +0100 schrieb Stefan Eichenberger:
> On Tue, Dec 19, 2023 at 09:11:17AM +0100, Dimitri Fedrau wrote:
> 
> > I could add the init sequence for the 88Q2221 PHY. Then you could test
> > it on your side. Would this be helpful to you ? Did you already have the
> > chance to test the patch ?
> 
> Unfortunately I haven't had time to test it yet. I will try to do it on
> Thursday, otherwise sadly it will be next year.
>
Ok.

> > You are right, but I would propose to stick to the reference init
> > sequence and make sure the PHYs works with our code and then work on
> > optimizing the code. We still can remove and/or document parts of it.
> 
> I am not sure that it will be accepted by the maintainers if you use a
> lot of registers that are not documented. For this reason, keeping it to
> a minimum might increase the chances of it being accepted.
>
Ok. Will try to reduce them.

> > Are you trying with the patch I provided or your own code ? If you use
> > my patch you should wait until V3, because I found some problems with
> > it. Switching from 1000Mbit/s to 100Mbit/s in autonegotiation mode doesn't
> > work. I could fix it but the fix touches some code already upstreamed. So
> > I tried to push parts of it yesterday. I forgot to cc you, just used the
> > get_maintainer script. I will add you to the cc list. Until then you can
> > look it up here: 20231218221814.69304-2-dima.fedrau@gmail.com
> 
> I used my own code so far but I will try again with your patches. Maybe
> send this and the other patches as a whole series so that it gets clear
> why you need the changes as Andrew wrote.
> 
Ok. Will send an V3 including all patches.

> Regards,
> Stefan

Regards,
Dimitri

