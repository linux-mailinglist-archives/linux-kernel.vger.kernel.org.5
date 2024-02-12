Return-Path: <linux-kernel+bounces-61569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 572718513BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD25B265CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355943A1A0;
	Mon, 12 Feb 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z97Mzfsb"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281A39FDD;
	Mon, 12 Feb 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741934; cv=none; b=lh9u3sbyYOhP/r6tVMM2sXsgDtxFdLqcT4F8iCMNoijaGTzE18MN0l94T5hTLtTLm6hlkXRyonjNU9upTJZS6FlYDdNlchzaXF1p3nkLwufJdSe+R8HSX1s2h9TOC3OOOm71Xgweh3oYmK7dcySBbo1kY0KDrCsck3sKWPJeMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741934; c=relaxed/simple;
	bh=R7lGqW1nRrkleiW4qjej3N1+KwbZp8lN1euPATaAfwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkzPKF+itUnQ+WqM3p6JyS40h6esgda17FKqM0+caxavFfcpTpGkJrNnjBHVwtb+d20Q1PAjfjk6cm7jKRCTRM1I68hiohkgONWjvsfacBnHZIAlMQ+MlIvGgY0GioIlHL6LU8Eg/gmQ3lh8ftNlfya4dye/ZGJ1/cy9L6XbdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z97Mzfsb; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0a0e40672so27578481fa.0;
        Mon, 12 Feb 2024 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707741930; x=1708346730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zrg9lawr/yZkm6/WrtjsywNEEEuh2zE0RbUtlneaNE=;
        b=Z97MzfsbWYqxiVawUbq52ea6cVIjsTWAqg1sgEVkC8ihw0Zetqq7FCRSotFW2FjAdc
         Pe5xsR/vYd1fLARdrz2jpL3Urx2rvBPL0l24TVU/5JEmAGh9BY6Ag2jymSLrOSoPLJCj
         5r3tk7aSkZjdyTwHnKz9fN4CTWbiWMRmKUAHNKRKqRtifsRSxj/SF8JOO5qCWp3N0wVA
         o1l+yPmP+VUYmUeT2rIXxYdAB2oie7XNkemtN8kbl3zclEqi+x/APYsDfZssnx6LM7aC
         XWOHbktopLDftOrd5W2yMsXOePuC3PoVLhV1A4WW2dnPr2lr9FMIFpDWgH7zrBc+hBQN
         0v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707741930; x=1708346730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Zrg9lawr/yZkm6/WrtjsywNEEEuh2zE0RbUtlneaNE=;
        b=w9/XrcI5M+XQBucJkMzmmzfxmifqN/CKCuJgGTx3j/W3Iuu2qLRCDbvzys74eyhd76
         UQpDz9AyQ7zOX8Yh9r0JCAiFvzwd/Isrk/U0piqHLfA6pABzWcpQA9cB/89yhsOEbMGB
         o484jhEck4WrbzTLCPUOnZoRaFRst5kfpKc0mBDx8LrzOVfdjWurd8vCjUAYvOsWjomy
         4PfEizNkBqKn25CsRLzChq3rcJm34B40TO13Sk66qPrlCx6sFrixx7DXFnY6cmJTn4nI
         eOMp9sHn5SbqYOs+9eCRndieOSNW6ZsQP9CcouM2wIkJzFPCJRjEvbTVho4neFKTzy4Y
         3wcA==
X-Gm-Message-State: AOJu0YxDEmGpFT49y+E+ACsMmhgKJZJXiApZ9SgE3wFfm0ZWlMZzzcD4
	cUT12fFwJH39I1kQNk879GnCGknN22JAjNA5bHHfbTQHZwrzcoe+Ac0oSUP0itD5tSVYDta4VdO
	f/N1FEV6l9B34O2HmwNVVjFn7L7M=
X-Google-Smtp-Source: AGHT+IEY3KujpPrwM/jn+Ez7992r5LMWGVQ7to0lh415/BYwip6pQ0nVZ1GyESCLTdzpJiqzB4CemULetGxh5/joSps=
X-Received: by 2002:a2e:86d7:0:b0:2d0:82f0:ba3b with SMTP id
 n23-20020a2e86d7000000b002d082f0ba3bmr2562140ljj.5.1707741930296; Mon, 12 Feb
 2024 04:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <170773502690.28134.16915655104997076968.git-patchwork-notify@kernel.org>
In-Reply-To: <170773502690.28134.16915655104997076968.git-patchwork-notify@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 12 Feb 2024 09:45:19 -0300
Message-ID: <CAJq09z44FnZknHAdmbxXf1F_H2QZW9SysqLLkErdzK70S1k1EQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/11] net: dsa: realtek: variants to drivers,
 interfaces to a common module
To: patchwork-bot+netdevbpf@kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"

> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Fri, 09 Feb 2024 02:03:36 -0300 you wrote:
> > The current driver consists of two interface modules (SMI and MDIO) and
> > two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO
> > modules serve as the platform and MDIO drivers, respectively, calling
> > functions from the variant modules. In this setup, one interface module
> > can be loaded independently of the other, but both variants must be
> > loaded (if not disabled at build time) for any type of interface. This
> > approach doesn't scale well, especially with the addition of more switch
> > variants (e.g., RTL8366B), leading to loaded but unused modules.
> > Additionally, this also seems upside down, as the specific driver code
> > normally depends on the more generic functions and not the other way
> > around.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v6,01/11] net: dsa: realtek: drop cleanup from realtek_ops
>     https://git.kernel.org/netdev/net-next/c/33f4336cbd32
>   - [net-next,v6,02/11] net: dsa: realtek: introduce REALTEK_DSA namespace
>     https://git.kernel.org/netdev/net-next/c/ded3813b44fe
>   - [net-next,v6,03/11] net: dsa: realtek: convert variants into real drivers
>     https://git.kernel.org/netdev/net-next/c/bce254b839ab
>   - [net-next,v6,04/11] net: dsa: realtek: keep variant reference in realtek_priv
>     https://git.kernel.org/netdev/net-next/c/4667a1db2f55
>   - [net-next,v6,05/11] net: dsa: realtek: common rtl83xx module
>     https://git.kernel.org/netdev/net-next/c/8be040ecd94c
>   - [net-next,v6,06/11] net: dsa: realtek: merge rtl83xx and
 interface modules into realtek_dsa
>     https://git.kernel.org/netdev/net-next/c/98b75c1c149c
>   - [net-next,v6,07/11] net: dsa: realtek: get internal MDIO node by name
>     https://git.kernel.org/netdev/net-next/c/8685c98d45c5
>   - [net-next,v6,08/11] net: dsa: realtek: clean user_mii_bus setup
>     https://git.kernel.org/netdev/net-next/c/68c66d8d8a19
>   - [net-next,v6,09/11] net: dsa: realtek: migrate user_mii_bus setup to realtek_dsa
>     https://git.kernel.org/netdev/net-next/c/b4bd77971f3c
>   - [net-next,v6,10/11] net: dsa: realtek: use the same mii bus driver for both interfaces
>     https://git.kernel.org/netdev/net-next/c/bba140a566ed
>   - [net-next,v6,11/11] net: dsa: realtek: embed dsa_switch into realtek_priv
>     https://git.kernel.org/netdev/net-next/c/9fc469b2943d
>
> You are awesome, thank you!

Thank you all involved, especially Vladmir who invested quite some time on this.

Regards,

Luiz

