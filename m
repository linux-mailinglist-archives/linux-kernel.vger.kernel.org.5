Return-Path: <linux-kernel+bounces-64238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7497F853C97
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE2328643A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3D6166F;
	Tue, 13 Feb 2024 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN3Txu1D"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F75DF3C;
	Tue, 13 Feb 2024 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858193; cv=none; b=lsItq5Y2DhdfajlrjD2W+g3Rt12fBBkFX8mlKEUEy1LU+slQrEUnXJFjRO7MJAfx4BES4eSNUU2zruQMb044wr8+rPUn16Xk8OuUWcjB5KXt+Eo6mCs5vxBEv7OalH0Uz3CwJgwKUw1jDwhdE/DZPrPVkxXBJVCnjI8joapYOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858193; c=relaxed/simple;
	bh=D5xFtmJb4RgbEH2NzGRmKv6Ow4RJxAM5+xjvAuR0vAg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv3FtgvL09WtT4f5s4lzgyG2whzfdDDKwzeP4qG/j1eBvAjhEKAdEZ9sL7Zf+PBMD/KLwkGReq7r7j5DV8lnJcrJVoVHLRLaUmpL3u9xgAcFafEZKHgOA3B5WTm+c2g+VQFvVnDmSV+bB854/htGgtMwVb3jTL3++O9BY/5+T94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN3Txu1D; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411cf319da4so5274745e9.2;
        Tue, 13 Feb 2024 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707858190; x=1708462990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T7JblcC+JB2R//36hKalltVDiKFAwpXQUzPo5XAomuI=;
        b=fN3Txu1DXngtP3UcxMmGntinx+DUUbM0v3YakW0akDhN+4Kgm7ceBqVG8NZbj0cYzs
         lIgvrTnzsFO+cVaLC1eq08WhPzvl2S01nCeedUCFG5zILBMLN2TPGT1VLF7azHvVKnja
         wFhf3CA4PcX7qNzC4fEErTv642bRzPWXd5/LxN2fDAuvE7UB3VYg+0VdQgxa+72mmyC+
         ySIhEVK0wL8FePdEyZfTUyDzrUDfI6vUxVKbb5/H06XgqZ2n09PHOtc0sNed7m0AH+9Q
         EkmfImI+B3i9iAmzN32ElSNdfRbGxywimA/C4yopGW6uYz+tGTMvI7rHMPXmNZtcUuUo
         77Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858190; x=1708462990;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7JblcC+JB2R//36hKalltVDiKFAwpXQUzPo5XAomuI=;
        b=ZoYUiudzb/FwhDsv0caQMK9PygHQjTZ6Rz1C8OmFF11+vR8uhTcfc3+rINkfYUhjq/
         uKfBRBWzqVN/PVlzntI5Z9x5aEkNJYGSd+POsYVtkVDoe8AcCb/d4RrBwlsH2AmQB4RP
         4cgPeEaMX6UD7a6fxijWjf4zIRIEv5qR4Xlu65SiHvLH7RKUPwIVlmwzUz9MO1UFaRqz
         izqAVTNBSlA65RF4wrBvYsA1QsJO8RdKFAtf/C49XOQe6cdUF8oMAE52/dU0wvGy76nL
         cJ7Nn0aa15cLkL/lwmWL5DRDvnI9N6d8FBkAfVv7IvNYP/3VLt9/CgUI7wK+tg2HrkBi
         cEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTw0M4lnOEnC8am4n8GLJ+Sdg6eY0rM/+ovZjcrcYyU652021l0RSXFuySImoDO0FBWYOceR9GPUlILzwqg0doeeNfVga0JWVQ/PEVFCe4/WCufTIrYYtoj2m6PiMO0sqjmvME
X-Gm-Message-State: AOJu0YxfOKWalJqnH1m9VmWuFTDhdJehlWPKpBSnNmkoFMHDJ2KZI5+s
	7mKDZHr4jwR6n0d51cSEpKS1giGeo7v1Pe1tIGucR1hvubjPxfiN
X-Google-Smtp-Source: AGHT+IH1XVcUK6ueE64QAIlOTg+53cNJbv+iJ/6bp2JHcj0RKJfXNLJouG5Xg48S8wdA39wTZyb5Fg==
X-Received: by 2002:a05:600c:a0f:b0:40f:d3d8:c8d5 with SMTP id z15-20020a05600c0a0f00b0040fd3d8c8d5mr593287wmp.9.1707858190208;
        Tue, 13 Feb 2024 13:03:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAROk4WfrZ5TMysnobPXA89x7N5PcGYTomnuvtH2fqPKqmZAPgpPJAPknPpRnNpKqR4l6qujQrCQ6guVPp8IiQoAhaE0wstMfOMTQVf3SHcCRn3He9mkBomlELEvbqWUrUc7gEDEyc17qs1H39aCf7cvYN7fnE5J/nIH6R6W3qlctfO0tyD3ou/xe/a5zns8n8xo5iOR7wStwqFR72S7a64Sfiy0A9SnwsvrIVDa9o47NjHVxuMt3XpPCDHuNDfHchFeV3DKWjhr6ui64IgXCOpF50Vd4yaXyDC9/M6ZEr2DGrjRpaJUjxBZ+UbvWIWvvbB9poHGDvP8Pv
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600c290500b0040ef95e1c78sm12665359wmd.3.2024.02.13.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:03:09 -0800 (PST)
Message-ID: <65cbd90d.050a0220.7cc10.ef02@mx.google.com>
X-Google-Original-Message-ID: <ZcvZCZOzG2BJOEwt@Ansuel-XPS.>
Date: Tue, 13 Feb 2024 22:03:05 +0100
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71e473e-bb92-4769-9f52-53de63f6a4ae@lunn.ch>

On Tue, Feb 13, 2024 at 09:58:59PM +0100, Andrew Lunn wrote:
> > > So in effect, the driver needs to write every single register it
> > > depends on.
> > >
> > 
> > Well if that's the case then this RFC patch is a must. With a
> > misconfigured System Interface configuration, the PHY can't comunicate
> > with the MAC.
> > 
> > > > This might be the safest change but again would not give us 100% idea that
> > > > the thing provision by the FW are correct.
> > > 
> > > I would say, we have to assume provision is 100% wrong. Write every
> > > single register with the needed value.
> > > 
> > > Is the provisioning information available? Can it be read from the
> > > flash? Can it be dumped from firmware we have on disk? Dumping it for
> > > a number of devices could give a list of register values which are
> > > highly suspect, ones that OEMs typically mess with. We could start by
> > > always setting those registers.
> > >
> > 
> > We know where they are stored in the FW but it's not documented how the
> > provision values are stored in the FW. (the format, how they are
> > organized...) I can waste some time trying to reverse it and produce a
> > tool to parse them if needed.
> 
> It might be worth it. How complex could it be? The obvious format is a
> C45 mmd.reg pair and a value.
>

Working on it. I already confirmed the FW have actually a provision part
and is not empty.

The format looks to be u16 reg 16 value but I need to understand it
better as not everything about provision is in mmd 1e so there must be
some magic values to signal where the section has to be appled.

> > Would love also some comments by Russell about this, there was a patch
> > adding support for WoL where another user was messing with these regs
> > and he was with the idea of being careful with overwriting the provision
> > values.
> 
> I expect the SERDES eye configuration is in there somewhere, and we
> should not touch that. That was one of the arguments Aquantia made at
> the time, that needs to be stored somewhere, and is board specific.
> 
> But knowing what standard 802.3 registers are commonly changed would
> be useful, and could help track down silly problems like the
> transmitter being disabled by default by provisioning.
>

Yes having a tool to parse them would probably be useful and eventually
even apply fixup in the firmware loading (if we really want)

-- 
	Ansuel

