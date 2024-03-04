Return-Path: <linux-kernel+bounces-91006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE03870859
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D871C212A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553AD61671;
	Mon,  4 Mar 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Taia1kv2"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73916166E;
	Mon,  4 Mar 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573681; cv=none; b=erowN15VTsk5KRGII1rI3Fp7aoxts2Rgidk80xZqF0btPa32LaLTwIlHXeiSrJJMrJTcOXiDgDQu+4PIS5SuFMMAxFOsFYbuugNirzESjxg2z1R7fofk/GoVN0BRFO8taYZpfVAaoeq/E8Tyag0PpmTRnJk8FbykC8xpTCr2qW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573681; c=relaxed/simple;
	bh=xw6aC+A8gVg8jidmMdZ/OwGyhEFufS4cf1tmpKI+rMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HacHxY822bjcJfa/jFOI2+HXecTWpwOh3adfezXkcdBmvPoihC1iTbkw67MmM+F0kcPQEYipfR4GllRZloeEJQzln3m7GvDFQcTb2Ljj295XltPPZqG/6KWbqbByK0I0smo4Y1V+FLjLjNPl5eSkfY+FrwMx4J1gUs80HR7g4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Taia1kv2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28464c554so65189551fa.3;
        Mon, 04 Mar 2024 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709573678; x=1710178478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2FR1/AlUdSswXJG03DmWoIi/sBHU8HYBddm5uluiH4=;
        b=Taia1kv2u+2L11oJ50GARtae8dUonvKkre7duEosmVUsf7rq77OjArTvDEPv1g1j+n
         e+KtWYnye7v7yaThfZ23DAFt7865P2z9sUeQ/Yd8eVVh8mAnlaXiUzJMMaLPgOI9eJx4
         BGTdd19OPycBWW8SrBH4S+fVnz2Ji2RP5bSnQwkJ/DioUwHFFHC/N7NaTOFpyyOhzS5f
         JcOeXpPcuoKNqFIXx4KmUC0trGJwf6R97X2cziG76neu3n1bjfJ9yAhCO4OBKdpAf9ps
         USHVMaupW0t0ZGOEKpe2/9FiOfXYdVkw4mGYw9mW2V+pa/iOZVmzzcSkSywXGl6c2ZH1
         bJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573678; x=1710178478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2FR1/AlUdSswXJG03DmWoIi/sBHU8HYBddm5uluiH4=;
        b=Q29rr1y77ODJ4aib1IyvZ/0eq8kU7i/gFUfiRj2Y8Rq81ZXGdHxxNQgRUV+ICbGDtE
         ZmZ8ZcM3Ddp/VJ4GPFqR5mAS7teM7NTgMcDslvSXOBoUiVhTec2DvCU8bOeX7ghTqewm
         EvJ6489GihA9Wupyg3x9SRlJvP4bHhVy08ZsfYKryqbG8ruBuKFXn0nPJ7PaCjmoqlIZ
         UxYrxf9TonCwKoPEW0oj8NzJJF6dku3Dj92CEnSRP30c2L3klzkYEtn1SJCOWW9y4D3N
         DMhBo1cySqGzs3HxPz616CPFQErQ9Reg+fGpRUgJGfzgQk74c3dRBhL7FnYQyCEteFp5
         GQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUhpAg9hkfgM04baN3N59lVLxWZxXcB0cWBilJTh1Y+9JicCIZb5gEGXJ6HoplF0Prnnj0dpal6X21dNjR36BqwNFEIXEkiIesGY93m0NWIFkoNPeTdRrd15e3GXHAncqAov5575Fr3GMexzzPr
X-Gm-Message-State: AOJu0YxUrRRimmRLMXjQkra3XRV3IN5uVef0z9SEYuE6hGUIxGPlfqVH
	Qo15dxHy/VE5dSCjfbel0tu+172ZaxjqCwdBn7HCgP7KWkqZSXhbIGKG6bhv8lG0+6FWxJrMzSA
	UY4URufgQFZtwOeznhXBbDqVhoV0=
X-Google-Smtp-Source: AGHT+IGunG7KN2xT4wHChFr7YnPoTN76KLIjMpoQgX93fs+NLugh0voNXHnAKUKWEr2kahJppkbFtyR3YMhLXQWyg3k=
X-Received: by 2002:a05:651c:1031:b0:2d2:5129:4ffd with SMTP id
 w17-20020a05651c103100b002d251294ffdmr6633774ljm.53.1709573677499; Mon, 04
 Mar 2024 09:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018145540.34014-1-marcel@ziswiler.com> <20231018145540.34014-2-marcel@ziswiler.com>
 <ZWEG40nzRhm6oVEq@francesco-nb.int.toradex.com> <20240304165215.GA11208@francesco-nb>
In-Reply-To: <20240304165215.GA11208@francesco-nb>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Mar 2024 12:34:24 -0500
Message-ID: <CABBYNZLaWadMieheoUV=XVXfBmJGsU4L_+k+MuNiP_oCsvrVnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	Sherry Sun <sherry.sun@nxp.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
	Amitkumar Karwar <amitkumar.karwar@nxp.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Marcel Ziswiler <marcel@ziswiler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

On Mon, Mar 4, 2024 at 11:52=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> Hi Luiz,
>
> On Fri, Nov 24, 2023 at 09:26:11PM +0100, Francesco Dolcini wrote:
> > On Wed, Oct 18, 2023 at 04:55:39PM +0200, Marcel Ziswiler wrote:
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > >
> > > Unfortunately, btnxpuart_close() may trigger a BUG: scheduling while
> > > atomic. Fix this by properly purging the transmit queue and freeing t=
he
> > > receive skb.
> > >
> > > Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bl=
uetooth chipsets")
> > >
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > ---
> > > This is the kernel trace this commit fixes:
> > > [   29.270685] BUG: scheduling while atomic: kworker/u3:0/55/0x000000=
02
> >
> > I just hit this bug with 6.7-rc2, I think it would be worth to
> > apply this fix.
>
> Do you need any change for having this patch (1/2) applied? Do you want t=
his
> to be re-sent without the second patch (2/2) from this series that is
> maybe more controversial?

Yes please just resend it.

> Let me know how I can help,
>
> Thanks,
> Francesco
>


--=20
Luiz Augusto von Dentz

