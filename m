Return-Path: <linux-kernel+bounces-63553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC9885312D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC36B262E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4CB4F21C;
	Tue, 13 Feb 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibj7/x5I"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683554F215;
	Tue, 13 Feb 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829353; cv=none; b=EF5AXtT2t+9T3SI6W/tlHxgN6e5ZXuI4LZzn2f1++P1x7uRjR9Mo44reQmkeywJVh6eFqbHBomYHAF4vfzimlRtPGgkyKPCSEtSFXffZHaaedi4b8By/3a7kfzv+v51nn+FXY66RY7IRxT4UuO/uuluPjVFb2xEyuMFGNYlZxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829353; c=relaxed/simple;
	bh=UTw2supuPVhe9bueSXvFvpL3aABsT1CoMyNpKM+P9T0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYPJrsBzWEPEFvgiGO0XqWfROQ/Z0WQwlfQqeJZqujhdfYYIHvAD8PQH3hYneJVS+16icrRhlqNn8ZePz6wTtXIrzBscRCp5ytNFl06lkxHBJQIIXU7O3AtvLFUtdkXbQOkCdXjLRmH3CLwgfktG/IL1eVsgYxHRh6oOxtrMoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibj7/x5I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-411bf7e4fc0so3815775e9.2;
        Tue, 13 Feb 2024 05:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707829349; x=1708434149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JK+PEM04a1oK4wYqrnDi7xxQoZhywLPsjnAUNjZABzA=;
        b=ibj7/x5IUgQcketX4w/1ru9s8pUb+N0cBcKicd1Ww8hBwYoJa8ATYaq+0jziF/TVMg
         OiT3QYodHExBN5EwCvIV2/yELg8tFgdr5ER7qcDpqV0pJxlplsbxdn/2kUF+iKMOvbKs
         aL4SmUSQZu6yi3T/BqPZbczCK9vHV8EP5SQ30yse0OCqoRmz6Zq7zv5++xeuOXNCcOOi
         m08GDaml7PzKEEaueHt3zzzAZMeelrArjQbB7K2HfUAGMwYXtL+SoJi+lWwAyArwEscb
         1KsTpXRKDM0Z+hWZ7qwR6DE6STcQAnAcm3qfU8PrD94kKGcrMVrjaQr3ZUYQsHtpl3MN
         zaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829349; x=1708434149;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JK+PEM04a1oK4wYqrnDi7xxQoZhywLPsjnAUNjZABzA=;
        b=lYzCXiaC55DYU5vQWph+CdtkM/erSU5H9kUF+OnzsPT/m748ZuoQ9UtvR2Ry9W1+bE
         L7YICyfrGMzbr41pKPPlj3UlDI5aYxzz1E0MI47kuuUC+tVuxN4L0FvSfFqVoBkfava1
         V3RSZ7wIGhay2g5qwIPLC+JxOsswY8ySZnvUqJKsrCDJCuwt92KVZBkPvVJGZhmdqlz7
         GvNhGWM9QYG37oFQcWsFbD4C6b0NipaODO/qRJclWqx6Sl/8Sup57nSFMjG63jRuc6ta
         wTdNHAuHiQVFj0nBIFntg+WJPV7mw6dNWNLo/ZgdzycJZ7ShOeo+hNmIJjVaNr3SWy8D
         NHFg==
X-Forwarded-Encrypted: i=1; AJvYcCWrNa9FK+A5/bKBpumiZnixYMiH0K+q6v4N5kqCALvsryB3NSIiufzm6TZoiIpeneCLJ8jSPBNZNpVoNA1HmTpj2mgeUw9Q6UUMx9RiycG+Y7B7o+hpdqqx1ZrjqiOOKkFp1CPB4G5dj+bMZRxFM4Jo9iRvoiJC8AHciSLQbfvK1t2acw==
X-Gm-Message-State: AOJu0YyUiPJVUD3X9zXpzQXv9ks+wBorKUJ87SOgcdc5a/Qm9ZrOSOKy
	auAAODK4C7YDaiTI5bDxaHwUWzeF+7v5CfUW+xyWdapYmw2TiPtM
X-Google-Smtp-Source: AGHT+IFwkv+k+kmgERe3GC53ZkCSqvOcSdHmTkYHqVj95AI8wudqqhFaXTDou5Y6ZV4Ka4cLomG82Q==
X-Received: by 2002:a5d:53ca:0:b0:33a:f689:1c01 with SMTP id a10-20020a5d53ca000000b0033af6891c01mr5311235wrw.70.1707829349176;
        Tue, 13 Feb 2024 05:02:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAJmYzhRzmQPA7BEfkcxfmFQJ1OuGw4sEHl2XzmVq8cP7NAGlVcurLgHrHP0rSpaStEgU7yRZHOlmQeZ2698RxOFob1a6xCll5Kz1i7WhDvWQ4/KeSvU5klkgtkMOuyskcUJD0uO8MWD34hgojRY0EKSpuJOkNB0CmIwrv8xE+SYJ+4kvLiLvEGK9eZHp8kOvHAcz2ged3peOBHxXkwoysAOk2d1gK4Yx03EjvCtWe8Vmcj2VLWnwKFdapFgao1xc1gUIAZUQrUKpbsGYrmSy4hoZahNdmAcAlW5oHJY3TZ9Yr4dTrxJ3FW8vYIo/JJ06p4T+B3CSCASCj8Ri04JUokuGE9HjXjcDjW4tLFks8qa3PtigHsTr84+ZKQ1auRweAdWlLtpAhp2GMC/WveA==
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b0033b888a0a63sm3381950wrw.0.2024.02.13.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:02:28 -0800 (PST)
Message-ID: <65cb6864.5d0a0220.9cdaa.2449@mx.google.com>
X-Google-Original-Message-ID: <ZctoYDAluFzpHILE@Ansuel-XPS.>
Date: Tue, 13 Feb 2024 14:02:24 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Robert Marko <robimarko@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andersson@kernel.org,
	konrad.dybcio@linaro.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca807x: move interface mode check to
 .config_init_once
References: <20240212115043.1725918-1-robimarko@gmail.com>
 <c97d10fa-39c5-4e5e-93ce-1610635cb4d4@lunn.ch>
 <CAOX2RU6OwiymM_O_62VETgkBNUQP1TuOKJmm0D1ZUXBA7ZPJNA@mail.gmail.com>
 <7c5dd47c-26b9-4a12-af93-6139ae85e864@lunn.ch>
 <CAOX2RU79o_5KRJZUJKA_++rrFXn66oLU0jOVHZnA1wHf2kA7RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU79o_5KRJZUJKA_++rrFXn66oLU0jOVHZnA1wHf2kA7RA@mail.gmail.com>

On Tue, Feb 13, 2024 at 11:16:47AM +0100, Robert Marko wrote:
> On Mon, 12 Feb 2024 at 20:48, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Feb 12, 2024 at 07:09:04PM +0100, Robert Marko wrote:
> > > On Mon, 12 Feb 2024 at 15:51, Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > On Mon, Feb 12, 2024 at 12:49:34PM +0100, Robert Marko wrote:
> > > > > Currently, we are checking whether the PHY package mode matches the
> > > > > individual PHY interface modes at PHY package probe time, but at that time
> > > > > we only know the PHY package mode and not the individual PHY interface
> > > > > modes as of_get_phy_mode() that populates it will only get called once the
> > > > > netdev to which PHY-s are attached to is being probed and thus this check
> > > > > will always fail and return -EINVAL.
> > > > >
> > > > > So, lets move this check to .config_init_once as at that point individual
> > > > > PHY interface modes should be populated.
> > > >
> > > > Just for my own understanding, not directly about this patch...
> > > >
> > > > priv->package_mode is about PSGMII vs QSGMII for one of the SERDES
> > > > interfaces? We expect the individual PHYs sharing that interface to
> > > > also indicate PSGMII or QSGMII?
> > >
> > > Yes, that is the idea, all of the individual PHY-s in the package
> > > should be indicating
> > > the same PHY interface mode.
> > >
> > > >
> > > > But what about the other SERDES, which can be connected to an SFP
> > > > cage. You would normally set that to SGMII, or 1000BaseX. When an SFP
> > > > module is inserted, the correct interface mode is then determined from
> > > > the contests of the EEPROM and the PCS needs to be reconfigured. So
> > > > i'm just wondering how this check works in this situation?
> > >
> > > I just went to retest SFP support and it works as intended, as soon as the SFP
> > > is inserted, PHY will get reconfigured to "combo" mode so that fifth PHY can
> > > support both fiber (100Base-FX or 1000Base-X) or regular copper connections.
> > >
> > > So, the check will not interfere with SFP support.
> >
> > So for the port with the SFP you also have phy-mode of PSGMII or
> > QSGMII? That then gets changed when the SFP is hot plugged?
> 
> Yes, that is correct and when SFP is plugged in it will be reconfigured
> by the driver into combo mode as that port can actually be used for fiber and
> copper at the same time by changing the priority.
>

Hi Andrew, just to make sure this doesn't get confused.

There is a HW limitation here and it's described in Documentation:

- In QSGMII mode the SFP Cage can't be connected or mounted physically
  as in this mode only 5 copper port can be connected, it would go
  against the HW design of the chip. In this configuration the first 4
  port are qsgmii and the 5th port is sgmii. (we enforce qsgmii on all
  ports out of simplicity to make sure we have a sane configuration in
  DT)

- In PSGMII mode the 5th port is always a combo port that can either be
  a copper port or a fiber port (with SFP cage). To set the 5th port to
  fiber mode, the mode has to be switched but the other 4 port are
  always copper.
  Also it's ok to set the initial PSGMII mode to 5 copper port as it
  will be changed as soon as a SFP cage is connected. (can't happen to
  have a device with both a copper port and a SFP cage connected to the
  5th port, it's one or the other. Again it would go against the HW
  design.

Hope it's clear now why the check was introduced and the HW limitation
of it as with the previous message one might think the 5th port is
totally separated and can go to his own mode (PSGMII or QSGMII)

-- 
	Ansuel

