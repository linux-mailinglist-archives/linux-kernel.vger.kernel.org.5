Return-Path: <linux-kernel+bounces-69476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B5858A17
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CC81C21E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23A81487F0;
	Fri, 16 Feb 2024 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+b3kSXa"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18295146904;
	Fri, 16 Feb 2024 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125975; cv=none; b=A0p74+vJ+9k6ZrTv6TT50sv1w2ft6ww2d7/k5UDqBjvYTwc1kvkqLZh04lsjOslCzTlj/NvTHffc2VjcFlX5gaIlkT3rNHUS02qQK3hYKIXIdBKF/TqpaqNxAh/MvKfrVNblMMsQou96GaFk8zaF3ZYJnwsdCX5mpYeZVpKUXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125975; c=relaxed/simple;
	bh=UJvUp5C9UYEOXChbdhnNO8yiUcrVTmJefQNyfFlUSLk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9P0M0Wfdrd0W/9OPKWK2V0ksD5yQ9UqX2ih2Csc/xrCSXC7xcLMlbKNHQnRLoOGhE/e/ORfMNttsg1jnfBj0q7/z5jGsJxqXSeGLP4Vn5zMKtzt+XPFWR960SmgTQeVsLITAhcl1ZGmFcWfSrRKGOwQHZoj+pT6Hf1xzQd59jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+b3kSXa; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0aabed735so32156481fa.0;
        Fri, 16 Feb 2024 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708125972; x=1708730772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BsaSVjfRZTNez969kRMv0b944tY1bxLIdVTmdKUasJE=;
        b=k+b3kSXayTNVbcXCC6Pb9rwVjM1XO4uYX6+rlIP4PvgTez4B07l0WEPR1uIBXDbpd7
         ZhmZHbkucCkbBHr33KSfiYEv9222S/+UbbxJwGGxWMWJzYK1Ljnr5F+VzJm6Zw54Fs4e
         M40NajpnRILuR3+bm2yEC9xtrSMhVYMe9eq8Be+XU0789mPtEvcdSduAxMbCPV6UDtzi
         pECYL9XbviyOyLD7Utl8W78XrkNRZGItHBrvg093fbM+G3bSUdbCjGZRb87Xdq1Esi1f
         EIV3abQGaC6b4meAhYzMTCJhzF/wjAws2Xn4KnI6bGvOUsqWfs06nwnhtPe7VIkHr49i
         ayiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708125972; x=1708730772;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsaSVjfRZTNez969kRMv0b944tY1bxLIdVTmdKUasJE=;
        b=QY3cBbvJSB3LOyp4bnu6wp/aNlJiPABPYzNEi8rTrammYlbmncOWAcJdBVJOg8LKLk
         fsjqjET5UOum6prjPCW9ooaURPwPjOvKnA/u+P/g2I9e5HO0zE7iSPqIJkrqqZT7jaT+
         WBuVgdUpDc6+TpQ6PIEMlCFS7o9eeVdDQYtUJVoojkEUii/8JpahC4p4mevl2FC12+4+
         MXJOew5gJQKDDDo5lmwEH9/KXNfbQ0yD5O+x3kEypHkwyhfe+7YMZitbny70OsYI8FX/
         tjQfjk/VDi6FuqhRGhaZn9FU3iS+08cCobBJdI3cwNwKxrGclRQublDtxAdtR1ivskhH
         Em9g==
X-Forwarded-Encrypted: i=1; AJvYcCUMs8S7FxD0fPzC2bIbNt9HHIxJDCNxByEdpcQ+Hcm3OrJoOTbUosD3hyASwOPWOU+R52mIWFhYP25qtvcnZVWvm5I2TJvsQGyeF3qD1CrgEmmiMvUW9hAqsakCcHZaNARfHTl9
X-Gm-Message-State: AOJu0YwTXrWngQbnrNoTqsKpUWO3cY37Bbm4RLycPWv616FaanDYPzDY
	QYv/Z+IOaywrSSik29xmFWXHiUC/q9d8HOwXnbC0g/4EmGifV+3b
X-Google-Smtp-Source: AGHT+IF9WxeqXPNJ7EQOYfx8PiVcVP/WLZVQuYe4lLaWZ6aLzu99W0uiM6L1G3wSKHqQucBYPSLyow==
X-Received: by 2002:a2e:740c:0:b0:2d0:dfb2:421 with SMTP id p12-20020a2e740c000000b002d0dfb20421mr4588632ljc.7.1708125971776;
        Fri, 16 Feb 2024 15:26:11 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id t22-20020a7bc3d6000000b0040d5ae2906esm3516231wmj.30.2024.02.16.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:26:11 -0800 (PST)
Message-ID: <65cfef13.7b0a0220.822e5.f9f1@mx.google.com>
X-Google-Original-Message-ID: <Zc_vFvJl0heHcxe-@Ansuel-XPS.>
Date: Sat, 17 Feb 2024 00:26:14 +0100
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
 <65cbbacb.050a0220.b81d1.eb5b@mx.google.com>
 <a71e473e-bb92-4769-9f52-53de63f6a4ae@lunn.ch>
 <65cbd90d.050a0220.7cc10.ef02@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cbd90d.050a0220.7cc10.ef02@mx.google.com>

On Tue, Feb 13, 2024 at 10:03:05PM +0100, Christian Marangi wrote:
> On Tue, Feb 13, 2024 at 09:58:59PM +0100, Andrew Lunn wrote:
> > > > So in effect, the driver needs to write every single register it
> > > > depends on.
> > > >
> > > 
> > > Well if that's the case then this RFC patch is a must. With a
> > > misconfigured System Interface configuration, the PHY can't comunicate
> > > with the MAC.
> > > 
> > > > > This might be the safest change but again would not give us 100% idea that
> > > > > the thing provision by the FW are correct.
> > > > 
> > > > I would say, we have to assume provision is 100% wrong. Write every
> > > > single register with the needed value.
> > > > 
> > > > Is the provisioning information available? Can it be read from the
> > > > flash? Can it be dumped from firmware we have on disk? Dumping it for
> > > > a number of devices could give a list of register values which are
> > > > highly suspect, ones that OEMs typically mess with. We could start by
> > > > always setting those registers.
> > > >
> > > 
> > > We know where they are stored in the FW but it's not documented how the
> > > provision values are stored in the FW. (the format, how they are
> > > organized...) I can waste some time trying to reverse it and produce a
> > > tool to parse them if needed.
> > 
> > It might be worth it. How complex could it be? The obvious format is a
> > C45 mmd.reg pair and a value.
> >
> 
> Working on it. I already confirmed the FW have actually a provision part
> and is not empty.
> 
> The format looks to be u16 reg 16 value but I need to understand it
> better as not everything about provision is in mmd 1e so there must be
> some magic values to signal where the section has to be appled.
> 
> > > Would love also some comments by Russell about this, there was a patch
> > > adding support for WoL where another user was messing with these regs
> > > and he was with the idea of being careful with overwriting the provision
> > > values.
> > 
> > I expect the SERDES eye configuration is in there somewhere, and we
> > should not touch that. That was one of the arguments Aquantia made at
> > the time, that needs to be stored somewhere, and is board specific.
> > 
> > But knowing what standard 802.3 registers are commonly changed would
> > be useful, and could help track down silly problems like the
> > transmitter being disabled by default by provisioning.
> >
> 
> Yes having a tool to parse them would probably be useful and eventually
> even apply fixup in the firmware loading (if we really want)
>

As promised, I reversed the format and created a script. It's still WIP
in the sense that I have to still to find a better way to show the
values. Here the script [1].

Feel free to suggest improvements to it. Various discovery were done
while reversing this, especially the thing with the BUG.

[1] https://github.com/Ansuel/aqr_prov_table_parser

-- 
	Ansuel

