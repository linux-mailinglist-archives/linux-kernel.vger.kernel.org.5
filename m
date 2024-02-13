Return-Path: <linux-kernel+bounces-64122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 515FD853A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14ECB28CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27521118E;
	Tue, 13 Feb 2024 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0Y27dxX"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75AF9CE;
	Tue, 13 Feb 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850447; cv=none; b=akRYKpgYNQ+t3qCmFw0M/oW/GlXGTjHmoN9Sg1BiYvGJyETVnVJyOUP58CueOxUyv934Viz3zDTF7v8d/8st9bZQ7a6cTK2WnH0RB1y87UhwRoP1iSwf81fNCEQ4j9lm8sqFgoikNbcqkP/RyQvCfhGqq6Uyj+IprqbRMEAZLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850447; c=relaxed/simple;
	bh=Pc0Uz7ZvGZAiMsnw79hmI3/pLFuibu1zlCY04CWwfqI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA1u1RFgOxa4/xIECtnWDwqxJEvtZzqhW/S2ey5SV6BMl/Ym5jwySev1bC8ChfdJ6P2DVx/8r+dvkhSbdaZEBo72et/ZMRkhqOtaqwhucGsPtIVGMhccuyhVDRixWup/x3qvN4ZN1Y00V2GjmBR6tlWQnIyPobgbaf6soCgI1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0Y27dxX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ce58eebe4so50213f8f.1;
        Tue, 13 Feb 2024 10:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707850444; x=1708455244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H+dGVs9NnswSaixQthi1rDV1QFJqXgmXn+44KoHCVtM=;
        b=D0Y27dxXWvXX3BikwVOwIcARuIN1TSTnwELh2mVwOeIX4rYheZrPCstI5xymPl/ZeO
         0GIQwn7B+DuN31W1wp5qKQmLF1Qe9ZcWKn7LAFtQBmoMLY9VYWhXx/1fGGMHi6Tn9Zxx
         k1liOT5IOJZ+7dhjAFgYZrUtDrzC5sm+TEDIWVYPaRWRMLc4CvqvcJEWt8PPQxf/p0tZ
         1CLiB0mbLZGaZp0khQnoVFKto6eXB2tmNEaIHlbapUd7/kZA73RCPxt5FN8SJMH7+Ld6
         0GwCCx7y74bqHh/x1yvaEvhCE3F8BWMhVrx1ccWvHCnYOKkShor5NtY1kNWuRB3Atj4A
         ZYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850444; x=1708455244;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+dGVs9NnswSaixQthi1rDV1QFJqXgmXn+44KoHCVtM=;
        b=DKkPmR2aJOCmlQfw67HS9eXzZNWuyPr214bCiVQDFn41LuSlBPgE3ciGIqJgjyxQvJ
         0cZWwqguwTTtC9y0VA8uFMzAVwzCH9nZ8Wl13Qpr4cDooIvb1Py+0Ia1yNtSA/zKWvOO
         2MeWuB6CitOSJKs1px4yVMh9QlYTFkk/KVUPwP0g+nXAIvZQqCf2bMErRRSuyd2DeXFi
         Sq5b8vpAB54Umq6FMmwNTDVAlq1B5tnd6QwTHPbG4hKpfr70q8uVkP1ZElrsbmhVS+2O
         k66IUeclRG8zhGkNTPXgB0CiEWHitNt1+Zn90NxjbSn0P1Imb8GTj+mwSJzJQnU7fnPd
         NC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+eWbKKr2kKwreVhLD9l/8LkxUNwG5wQDGxNUxmZD/1yM69eP1jOWNEMplncBQOoa8GmGVNsGgUwiCPSKihBs+dznCCNr5lzx4VFXIfFSt7xskfB2EGf9KvibDFGM0QLeAzNsi
X-Gm-Message-State: AOJu0Ywcq72a2iwj2p+ea1qxdRXlPjiWpXrSp2AqbbzZpypldrg60pgF
	4kJAJIKKwfkbk00H4a1a7PGkDdUA/UBatdn16GJH+RJZVQl4Ba4q
X-Google-Smtp-Source: AGHT+IGMMCWuXq1XZcrPQ1EiFcPPPej/HSXL6sjzEWIJaIXAfRFJTmfrTFNETJ/ER3qKIOvYbztQPw==
X-Received: by 2002:a05:6000:1247:b0:33b:69ee:981c with SMTP id j7-20020a056000124700b0033b69ee981cmr106399wrx.39.1707850443569;
        Tue, 13 Feb 2024 10:54:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaY1x2sBPwRiKIg3cQcsoW7970/cAS7G9IV23i6AC0XlH0ShC4BuzWXNRGV2SUbDJMZ7+zOM8DbK4wUQpOqYqu0rIfVIu67xbcQSPNxFghgBg2GvLqjhT2UU9j4Qzavli/9cAgG/b1CqykNVI+4SHHzvub+9/Dl2180Ugp5t7TzyIMewBBJGAMlkVm+fZGlilCmH+nhZwnMIqMMKgL7G7LZw/hLA50e/urfo3oAH2QyayXQNnQ3oOUimTwUQXdApMBu4kAOBL6MwvFlX/70blHykazh/6A9b6sJX9T8cvDmLBf1sS6g8X6x2QfP9uXVOEkOCZ3/n6MhbTn
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b0040fb44a9288sm12448929wmo.48.2024.02.13.10.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:54:03 -0800 (PST)
Message-ID: <65cbbacb.050a0220.b81d1.eb5b@mx.google.com>
X-Google-Original-Message-ID: <Zcu6xo67smLk3wy0@Ansuel-XPS.>
Date: Tue, 13 Feb 2024 19:53:58 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 0/2] net: phy: aquantia: fix system
 interface provision
References: <20240213182415.17223-1-ansuelsmth@gmail.com>
 <ee00b11a-4679-4ba4-be42-10f15d5e9f65@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee00b11a-4679-4ba4-be42-10f15d5e9f65@lunn.ch>

On Tue, Feb 13, 2024 at 07:46:45PM +0100, Andrew Lunn wrote:
> On Tue, Feb 13, 2024 at 07:24:10PM +0100, Christian Marangi wrote:
> > Posting this as RFC as I think this require some discussion on the topic.
> > 
> > There is currently a problem. OEM multiple time provision Aquantia FW
> > with random and wrong data that may apply for one board but doesn't for
> > another. And at the same time OEM use the same broken FW for multiple
> > board and apply fixup at runtime.
> > 
> > This is the common case for AQR112 where downstream (uboot, OEM sdk,
> > openwrt to have the port correctly working) hack patch are used to fixup
> > broken system interface provision from the FW.
> > 
> > The downstream patch do one simple thing, they setup the SERDES startup
> > rate (that the FW may wrongly not init) and overwrite the
> > global system config for each rate to default values for the rwquested PHY
> > interface.
> > 
> > Now setting the SERDES startup value is SAFE, and this can be implemented
> > right away.
> > 
> > Overwriting the SERDES modes for each rate tho might pose some question
> > on how this is correct or wrong.
> > 
> > Reality is that probably every user an Aquantia PHY in one way or another
> > makes use of the SDK and have this patch in use making any kind of
> > provision on the FW ignored, (since the default values are always applied
> > at runtime) making the introduction of this change safe and restoring
> > correct functionality of AQR112 in the case of a broken FW loaded.
> 
> This is part of the discussion i had with Aquantia about
> provisioning. Basically, you cannot trust any register to contain a
> known value, e.g the value the data sheet indicates the reset value
> should be, or that the 802.3 standard says it should be.
> 
> So in effect, the driver needs to write every single register it
> depends on.
>

Well if that's the case then this RFC patch is a must. With a
misconfigured System Interface configuration, the PHY can't comunicate
with the MAC.

> > This might be the safest change but again would not give us 100% idea that
> > the thing provision by the FW are correct.
> 
> I would say, we have to assume provision is 100% wrong. Write every
> single register with the needed value.
> 
> Is the provisioning information available? Can it be read from the
> flash? Can it be dumped from firmware we have on disk? Dumping it for
> a number of devices could give a list of register values which are
> highly suspect, ones that OEMs typically mess with. We could start by
> always setting those registers.
>

We know where they are stored in the FW but it's not documented how the
provision values are stored in the FW. (the format, how they are
organized...) I can waste some time trying to reverse it and produce a
tool to parse them if needed.

Would love also some comments by Russell about this, there was a patch
adding support for WoL where another user was messing with these regs
and he was with the idea of being careful with overwriting the provision
values.

-- 
	Ansuel

