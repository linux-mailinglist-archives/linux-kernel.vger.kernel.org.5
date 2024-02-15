Return-Path: <linux-kernel+bounces-67193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3218567DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2A31F2CED9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157331339B2;
	Thu, 15 Feb 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3vNe30Y"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17D133431;
	Thu, 15 Feb 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011078; cv=none; b=cQ2TblvLNC5osJtL5/eIx4VgDfYOgvp8zyWG4tSjSYVasSrkfWNjQRKuOkMOQsP7sbX6CdVrFEoso4BDFAFH3grzyFc+fhH6gdFf1iRu2o41LaWNENGdz36On90gXJIQHz4kF6suxoxlXE+8tujk1H38Ow/D2R70y/H5ztBG/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011078; c=relaxed/simple;
	bh=dLfIX3aUyBqo2RdTxsMyCriWrHkLIgqJmVYmc44D6GE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBCHSL5T79KGkfXG+uV4d9OeLNXiRel5RJ2RhxeRf2kERgFbD72f+igCFX/kshwCJYJ87WwNWBQ3ko2H2fyxjNnterq0qCkGRs9APRgzI3cshtHGgXQUNgPD8SzmrCR3h1JjLhkJ0di4q1LB0a1Jftr4U/609r5O2jYNlGKlsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3vNe30Y; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33aea66a31cso559762f8f.1;
        Thu, 15 Feb 2024 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708011075; x=1708615875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yKrpTQJQFLvHUzVWUoBR2+UEWTVnDVznNd1fLBttIMw=;
        b=M3vNe30Y4ESHC64TLuvxzm5KCQx4GhCsMFTUyVEo6mRWXa0YyIe8+elRQ6NhSkYMU0
         GfD4iXrJ7tU/jWAhcMZtpax19sw0sElSuX/l/lGBZSiJBmB6LN3RcYnlTD9OmtgRT1xP
         x+ujmxGTOScHPtOZ3R+72LTK+UPNfXYeJt3Vpfz9wUqbScD7cp/RwBbkamR/l1x/yvj0
         2TnbjTLaL4VYL/6paMLWz97iCeHkEU7sVX+o8sm9YxWdt3VBpmCo4E1Hs0ysXsJK+K6O
         AhT7OdslzR5i/77L+/YuJbM7LO0FnoZgCJmUMHXLvbtVO56pU93YIqxBcio/XRl/rU95
         jW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011075; x=1708615875;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKrpTQJQFLvHUzVWUoBR2+UEWTVnDVznNd1fLBttIMw=;
        b=gTUyiqVVQtzpHL/9Bz5Q8h0GQ6JAH9pKU7v0z0AWbQTTbAIZ5YqPQY15DeRcc7xUuh
         SvWM78Zm78hAD/qV7ikalxEeOj1vSxq4fVdyQNc617yHtQNWsHC5DCdIOxWlqPMhAYJF
         SUxtM/WULCf6FNFan4sNetcL9Qk0aWYNpBUa5OW0RXhJ4v3BMBUbWIEv8uHjBcSDgDMw
         pUt3DuLxC1b9hl4Q+ZDaqXyIC6CKsSGCwwuo1/yyfEOmz7W4o2Ol1153bpmGcRfp8cdH
         iCbX5RpyyAKPAILTa1X6uajUJj3kx0xP5WJ0HzNX79h+D8Pcen3rXaZ36IMaJ5FMysBD
         SC5w==
X-Forwarded-Encrypted: i=1; AJvYcCWwgHo7lREKDkV1yCQXYMYp6k5LgKxir08TwHUqkIBRrdY6tbVb0845be9IKJFvXxvJKGRIzjroCv2RNKJgdmovSM/9682fIwnblrukWnUF0VgWcdsZ1k2hPT1Z2Zk0qxMVxWJy
X-Gm-Message-State: AOJu0YyHXx8odKqKkyzOko3E9kMO+r0Ceo6Wi9cyYHQWIXZ+k04r3tYw
	Yd1GSXaxZ6kEm2mDuWe7BN68K0r203EQg1PEgsVtEJZ5RR79t5zB
X-Google-Smtp-Source: AGHT+IHtJa43taH8kjVEW1xAmQDivjclGzmFMF9S6JofmjqqzjF5JBe78KImWL/Bx0Ac2GGLazCztg==
X-Received: by 2002:adf:db4a:0:b0:33b:179d:d9aa with SMTP id f10-20020adfdb4a000000b0033b179dd9aamr1823427wrj.26.1708011074413;
        Thu, 15 Feb 2024 07:31:14 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id bx23-20020a5d5b17000000b0033cfbe7343asm2230699wrb.8.2024.02.15.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:31:14 -0800 (PST)
Message-ID: <65ce2e42.5d0a0220.ee3ec.8566@mx.google.com>
X-Google-Original-Message-ID: <Zc4uP714kvDr1tqh@Ansuel-XPS.>
Date: Thu, 15 Feb 2024 16:31:11 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR113 PHY ID
References: <20240213180228.15859-1-ansuelsmth@gmail.com>
 <1d30f923-8391-4e36-bf3f-2cdb733d464c@lunn.ch>
 <e9c0e96314a36ca4320ff215c03d5f7dc0e01235.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c0e96314a36ca4320ff215c03d5f7dc0e01235.camel@redhat.com>

On Thu, Feb 15, 2024 at 01:35:40PM +0100, Paolo Abeni wrote:
> Hi,
> 
> On Wed, 2024-02-14 at 19:05 +0100, Andrew Lunn wrote:
> > On Tue, Feb 13, 2024 at 07:02:26PM +0100, Christian Marangi wrote:
> > > Add Aquantia AQR113 PHY ID. Aquantia AQR113 is just a chip size variant of
> > > the already supported AQR133C where the only difference is the PHY ID
> > > and the hw chip size.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> This does not apply cleanly anymore after "net: phy: aquantia: add
> AQR111 and AQR111B0 PHY ID". Could you please rebase it?
>

Sure, sent v2 and thanks for checking this.

-- 
	Ansuel

