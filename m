Return-Path: <linux-kernel+bounces-52301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9DF849682
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DADA1C22091
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FEE12E63;
	Mon,  5 Feb 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf1UoE8A"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2065C12B7A;
	Mon,  5 Feb 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125556; cv=none; b=C894VAlQyPdJ6DEajbk88sewrz9PPT87kUGdOY45CYiZGTcKtRvFXURqgPx4PB/f/c/WtVj31XUJ67JhKylYmiQgbjMIdCxCA0iAYjEkYTyVien0kANG0pTmCFs1aUjCWgOrQ91XQy6zr6zR9xEjyNi3z/gZF5OmCFD3+ySFLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125556; c=relaxed/simple;
	bh=bpHmoC6/wZbkso58dTx+tA/PGOeOrS6uy27L+bFjjKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB6P7Anif1hb27GgIY3Xus5Kl5Ttd36T4Jedreff8T5ATuLhbbuZ9uF+nzhgll27COBa7s8R8RZwkfO8as2O1UXNB8zsKXIcVX+KurUR+gNcZxrhOWv51FKws77qfQJucD8Hq9aLzF4Fa4ju3cgOzNHzCRCib+MhYX6jK3KkjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf1UoE8A; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56025fcaebaso1691751a12.0;
        Mon, 05 Feb 2024 01:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707125553; x=1707730353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58wtEwb1JK1lopYlq43aJseGRPGR+y1RXI+NVyLV/Bw=;
        b=Xf1UoE8A+skqkaLXanA/XUw/yriyac5JLAGSL/Lc0il8Y1APeMkiVUs+3P9jPDeqrV
         Rit5yUL4wSXIewJRCNVSI6byDJIc8d6rIIhSUTsD0LDqnkGPPKAYzp4QhS/P4k5vBUJK
         jNT4xRzKR5biKQ8Tfp57HUSiGybbJME9kEwASfmCADUqnrqoBSu3AgysRljRqnGr8eyJ
         qLySui1abvRCop6hkCMpc2s3Dyhr/ZU7DMPLKJjjSbvnd5bQKvTna1b5sJuzdf8tWtsA
         TKHfPQG7pemhCGEcJ7HVyAlHKm4ybsIgkGZhW3grVb8FZjvgsJR6EQXbgdM7Z43tSGTp
         OSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125553; x=1707730353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58wtEwb1JK1lopYlq43aJseGRPGR+y1RXI+NVyLV/Bw=;
        b=nu1TP3Sir3YMxB8KoYlW+RJHmn3HwbWH7vjdA7DOanb8JhUiChxMFYfypGsvgqihWF
         C8EptoUkp4KoG8SMzvWTevxGexSF4QVwndkaPc3Hm2A5SCIavyj4umgWrHjFNW32qGY+
         6LpAAWF6FE8eqAN6kjwAW4N+lll6wDwQITw+cf4qfj7jh1qyiMOuTfHFzalTNW0+4EpX
         tc2A7Hs3KdZ/mCcxjrWG1G0opHQou6ptFmt0NkSWe24KYWlggLbdo8aKF7krax5JJ3Q4
         GxOeGzbBglZOJhR3IQTcaKRy0PruuRI/ife9RLgH/MAD0dkLDAcErV0OEN1THhV7C8eE
         uG+w==
X-Gm-Message-State: AOJu0YzV7sWmOUlq8ujp9K1QnyUkTlQ6skA4LN4Kp/TnG9bllQmjcBJn
	lEKj/6IYY9ubZlRFLAi3YhmsvGTFBhJUibbAnO+ic/OHdZvT7xIY
X-Google-Smtp-Source: AGHT+IFE9mxojvDd5IcKVFks55C46OgKWOQfgZGuWRJweh/BgPILptcwj4Xcvby/kKTntLwitJiwjg==
X-Received: by 2002:a05:6402:1853:b0:55f:fb3a:f5b0 with SMTP id v19-20020a056402185300b0055ffb3af5b0mr4025335edy.18.1707125552972;
        Mon, 05 Feb 2024 01:32:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVAGkHNKhGDvjuw0bIncrxoDltrhM1q6lZMhhbIXCxnle6lIKynHA0HhfXIxlxLCHS4/+FWj48/BbRh8XtFsND8V35osH9JSpOM1PipDUherk9CAw/7LdPg/KYu7gmOM3YMcUJFUD/dae6By8oLeLbt6MYF67e5pM/J2PJoLP/QrZaijXWBp24YRR8dfaP/gMeQgXS4dX54JHAafqZ26MQqnmxzKW7fo8vDoG/IpwH3gT2Rt4sFg0XZd8+gk/XvtXQq0SG5oTDHH9RG8dAO/3Y/8ytvmUv26Xl3qV9FuRQzQdk=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id p3-20020aa7c883000000b0056058f2603asm1234988eds.3.2024.02.05.01.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:32:32 -0800 (PST)
Date: Mon, 5 Feb 2024 10:32:30 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 00/13] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <20240205093230.GA2323158@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240129180959.582dbc88@kernel.org>
 <20240202183029.GA16692@debian>
 <ff0a1ea7-fdc3-4653-a52e-52869abb7dc8@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0a1ea7-fdc3-4653-a52e-52869abb7dc8@lunn.ch>

Am Sat, Feb 03, 2024 at 05:07:13PM +0100 schrieb Andrew Lunn:
> On Fri, Feb 02, 2024 at 07:30:29PM +0100, Dimitri Fedrau wrote:
> > [...]
> > 
> > Probably late, but there are parts of the code which are based on the
> > sample code provided by Marvell. The sample code is licensed under BSD
> > 2 Clause. Should I change the license in the driver to dual license ?
> 
> IANAL
> 
> You can take BSD code and release it with a GPL license. But it would
> be better to indicate it is derived from BSD code. Either make it dual
> license, or add a comment about the origin of the code.
>
Is there a reason why the "MODULE_AUTHOR" is not in the driver and it's
also missing in marvell-88x2222.c. I also don't see any copyright
information. I'm just curious, not seeking for any legal advice. :) I
just have to get this figured out to stay out of trouble.

Dimitri

